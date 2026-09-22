-- =====================================================================
--  HOMOLOGAÇÃO DE ATESTADOS — o banco
--
--  Rode no Supabase > SQL Editor, inteiro, de uma vez. Pode rodar mais
--  de uma vez: tudo aqui é "se não existir" ou "crie ou troque".
--
--  UM SISTEMA SEPARADO DO TREINAMENTO, DE PROPÓSITO
--  O RH que manda atestado não é, necessariamente, o RH que acompanha
--  curso. Por isso as contas, as tabelas e a permissão da equipe são
--  todas próprias (prefixo homol_), e nada daqui lê ou escreve nas
--  tabelas trein_*.
--
--  QUEM É QUEM
--    RH da empresa  -> conta da homologação (homol_conta), presa a UM
--                      CNPJ, criada pelo SistemaCMH a partir de um
--                      contrato assinado pelos dois lados. Vê e lança os
--                      atestados da empresa dele, e de nenhuma outra.
--    médico         -> usuário do SistemaCMH com a categoria "Diretor
--                      médico" (o Dr. Everaldo). Entra no site com o
--                      mesmo usuário e senha do programa, vê os processos
--                      de todas as empresas e dá o parecer. Tirar a
--                      categoria, ou desativar o usuário, corta na hora.
--    equipe         -> quem tem o módulo "Homologação" marcado no
--                      SistemaCMH (ou é administrador). Cria e desliga
--                      as contas do RH, pelo programa.
--
--  AS REGRAS MORAM AQUI, E NÃO NA TELA
--  A tela é um arquivo que qualquer um baixa e altera. Tudo que importa
--  — quem vê o quê, quem pode dar parecer, o que o parecer faz com o
--  processo — é conferido pelo banco, em RLS e gatilhos. Uma tela
--  adulterada consegue, no máximo, pedir; quem decide é aqui.
-- =====================================================================


-- =====================================================================
--  1. A EQUIPE DA CLÍNICA
--  Mesma ideia da trein_is_equipe (19-quem-administra-treinamento.sql),
--  com a marcação própria: 'homologacao' em Usuários, no SistemaCMH.
-- =====================================================================
create or replace function public.homol_is_equipe()
returns boolean
language sql stable security definer set search_path = public as $$
  select exists (
    select 1 from public.orc_usuarios u
     where u.id = auth.uid()
       and u.ativo
       and (u.admin or 'homologacao' = any(u.modulos))
  );
$$;
revoke execute on function public.homol_is_equipe() from public;
grant execute on function public.homol_is_equipe() to authenticated;


-- =====================================================================
--  2. AS CONTAS
-- =====================================================================
create table if not exists public.homol_conta (
  -- o mesmo id do usuário no Auth: uma linha aqui é uma conta lá
  id            uuid primary key references auth.users(id) on delete cascade,
  -- só RH mora aqui; o médico é usuário do SistemaCMH (ver homol_eh_medico)
  papel         text not null default 'rh' check (papel = 'rh'),
  nome          text not null,
  email         text not null unique,
  -- RH: só os dígitos, sempre. CNPJ com ponto num lugar e sem ponto no
  -- outro é o jeito mais fácil de o RH não enxergar a própria empresa.
  empresa_cnpj  text not null check (empresa_cnpj ~ '^\d{14}$'),
  empresa_nome  text not null,
  -- o contrato (assinado pelos dois) que deu origem ao acesso
  contrato_numero text,
  ativo         boolean not null default true,
  vale_ate      date,
  -- cópia cifrada da senha, com a senha da clínica (igual ao trein_rh:
  -- quem perde a senha pede à clínica, e a clínica consulta no programa)
  senha_cripto  text,
  senha_em      timestamptz,
  criado_por    text,
  criado_em     timestamptz not null default now(),
  ultimo_acesso timestamptz
);
create index if not exists idx_homol_conta_cnpj on public.homol_conta (empresa_cnpj);
alter table public.homol_conta enable row level security;

drop policy if exists homol_conta_self on public.homol_conta;
create policy homol_conta_self on public.homol_conta
  for select using (id = auth.uid());
drop policy if exists homol_conta_equipe on public.homol_conta;
create policy homol_conta_equipe on public.homol_conta
  for all using (public.homol_is_equipe()) with check (public.homol_is_equipe());

-- A conta de quem está logado — só se estiver ATIVA e dentro da validade.
-- Toda regra abaixo passa por aqui: desligar a conta no programa corta o
-- acesso na hora, sem esperar o login vencer.
create or replace function public.homol_eu()
returns public.homol_conta
language sql stable security definer set search_path = public as $$
  select c.* from public.homol_conta c
   where c.id = auth.uid()
     and c.ativo
     and (c.vale_ate is null or c.vale_ate >= current_date);
$$;
revoke execute on function public.homol_eu() from public;
grant execute on function public.homol_eu() to authenticated;

-- O MÉDICO É QUEM TEM A CATEGORIA "Diretor médico" no SistemaCMH, com o
-- usuário ativo. A comparação ignora acento e maiúscula: "Diretor Medico"
-- digitado à mão num banco antigo não pode trancar o Dr. Everaldo do lado
-- de fora.
create or replace function public.homol_eh_medico()
returns boolean
language sql stable security definer set search_path = public as $$
  select exists (
    select 1 from public.orc_usuarios u
     where u.id = auth.uid()
       and u.ativo
       and translate(lower(coalesce(u.cargo, '')), 'é', 'e') = 'diretor medico');
$$;
create or replace function public.homol_meu_cnpj()
returns text
language sql stable security definer set search_path = public as $$
  select empresa_cnpj from public.homol_eu();
$$;
-- O nome de quem está logado, seja RH ou médico — é o que vai para o
-- histórico e para "quem anexou".
create or replace function public.homol_meu_nome()
returns text
language sql stable security definer set search_path = public as $$
  select coalesce(
    (select c.nome from public.homol_eu() c),
    (select u.nome from public.orc_usuarios u
      where u.id = auth.uid() and public.homol_eh_medico()));
$$;
-- O que a tela precisa saber de quem entrou: papel, nome, empresa.
-- 'nenhum' = logou no Supabase, mas não tem acesso à homologação.
create or replace function public.homol_quem_sou()
returns table (papel text, nome text, empresa_cnpj text, empresa_nome text, registro text)
language sql stable security definer set search_path = public as $$
  select 'medico', u.nome, null::text, null::text,
         nullif(concat_ws(' ', u.profissao, u.registro), '')
    from public.orc_usuarios u
   where u.id = auth.uid() and public.homol_eh_medico()
  union all
  select 'rh', c.nome, c.empresa_cnpj, c.empresa_nome, null
    from public.homol_eu() c
   where c.id is not null
   limit 1;
$$;
revoke execute on function public.homol_meu_nome() from public;
revoke execute on function public.homol_quem_sou() from public;
grant execute on function public.homol_meu_nome() to authenticated;
grant execute on function public.homol_quem_sou() to authenticated;
revoke execute on function public.homol_eh_medico() from public;
revoke execute on function public.homol_meu_cnpj() from public;
grant execute on function public.homol_eh_medico() to authenticated;
grant execute on function public.homol_meu_cnpj() to authenticated;

-- Marcar que entrou (o programa mostra o último acesso de cada conta).
create or replace function public.homol_entrou()
returns void
language sql volatile security definer set search_path = public as $$
  update public.homol_conta set ultimo_acesso = now() where id = auth.uid();
$$;
revoke execute on function public.homol_entrou() from public;
grant execute on function public.homol_entrou() to authenticated;


-- =====================================================================
--  2b. AS FILIAIS DE CADA EMPRESA
--  Cadastradas pela clínica no SistemaCMH (módulo Homologação), junto do
--  login do RH. No "Novo atestado" do site, a filial vem daqui: uma só,
--  já preenchida; mais de uma, o RH escolhe na lista. É o que deixa os
--  relatórios "por filial" confiáveis: sem lista, cada um escreve a mesma
--  unidade de um jeito, e o gráfico vira quatro barras da mesma filial.
-- =====================================================================
create table if not exists public.homol_filial (
  id           bigint generated by default as identity primary key,
  empresa_cnpj text not null check (empresa_cnpj ~ '^\d{14}$'),
  nome         text not null check (length(btrim(nome)) between 1 and 120),
  ativo        boolean not null default true,
  criado_por   text,
  criado_em    timestamptz not null default now(),
  unique (empresa_cnpj, nome)
);
create index if not exists idx_homol_filial_cnpj on public.homol_filial (empresa_cnpj);
alter table public.homol_filial enable row level security;

-- ler: o RH, as da empresa dele; o médico e a equipe, todas
drop policy if exists homol_filial_ler on public.homol_filial;
create policy homol_filial_ler on public.homol_filial
  for select using (
    empresa_cnpj = public.homol_meu_cnpj()
    or public.homol_eh_medico()
    or public.homol_is_equipe());
-- escrever: só a equipe (pelo SistemaCMH). Filial não se apaga: desliga.
drop policy if exists homol_filial_equipe on public.homol_filial;
create policy homol_filial_equipe on public.homol_filial
  for insert with check (public.homol_is_equipe());
drop policy if exists homol_filial_equipe_upd on public.homol_filial;
create policy homol_filial_equipe_upd on public.homol_filial
  for update using (public.homol_is_equipe()) with check (public.homol_is_equipe());


-- =====================================================================
--  3. OS PROCESSOS
-- =====================================================================
create table if not exists public.homol_processo (
  -- o número do processo é o próprio id: nasce no banco, sem repetir e
  -- sem buraco adivinhável a partir da tela
  id              bigint generated by default as identity (start with 1000001) primary key,
  empresa_cnpj    text not null,
  empresa_nome    text not null,
  requisitante    text,
  chapa           text not null,
  nome            text not null,
  filial          text,
  inicio          date not null,
  hora_inicio     time not null default '08:00',
  dias            int  not null check (dias between 1 and 730),
  fim             date not null,
  tipo            jsonb,
  medico          jsonb,
  entidade        jsonb,
  cid             jsonb,
  responsavel     jsonb,
  observacoes     text,
  parecer         text not null default 'Pendente'
                  check (parecer in ('Pendente', 'Aprovado', 'Reprovado')),
  parecer_obs     text,
  parecer_por     text,
  parecer_em      timestamptz,
  situacao        text not null default 'aberto' check (situacao in ('aberto', 'finalizado')),
  atividade       text not null default 'Clínica avalia atestado',
  abertura        timestamptz not null default now(),
  criado_por      uuid default auth.uid(),
  criado_por_nome text,
  atualizado_em   timestamptz not null default now()
);
create index if not exists idx_homol_proc_cnpj   on public.homol_processo (empresa_cnpj);
create index if not exists idx_homol_proc_inicio on public.homol_processo (inicio);
create index if not exists idx_homol_proc_sit    on public.homol_processo (situacao);
alter table public.homol_processo enable row level security;

-- Pode ver: o médico e a equipe veem tudo; o RH, só o CNPJ dele.
create or replace function public.homol_pode_ver(p_cnpj text)
returns boolean
language sql stable security definer set search_path = public as $$
  select public.homol_eh_medico()
      or public.homol_is_equipe()
      or (p_cnpj is not null and p_cnpj = public.homol_meu_cnpj());
$$;
revoke execute on function public.homol_pode_ver(text) from public;
grant execute on function public.homol_pode_ver(text) to authenticated;

drop policy if exists homol_proc_ler on public.homol_processo;
create policy homol_proc_ler on public.homol_processo
  for select using (public.homol_pode_ver(empresa_cnpj));

-- Lançar: só o RH, e só para a empresa dele (o gatilho carimba o CNPJ
-- da conta, seja o que for que a tela mandar).
drop policy if exists homol_proc_lancar on public.homol_processo;
create policy homol_proc_lancar on public.homol_processo
  for insert with check (public.homol_meu_cnpj() is not null);

-- Alterar: o médico, sempre; o RH, só o da empresa dele e só enquanto
-- não foi finalizado.
drop policy if exists homol_proc_alterar on public.homol_processo;
create policy homol_proc_alterar on public.homol_processo
  for update using (
    public.homol_eh_medico()
    or (empresa_cnpj = public.homol_meu_cnpj() and situacao <> 'finalizado')
  ) with check (
    public.homol_eh_medico()
    or empresa_cnpj = public.homol_meu_cnpj()
  );
-- Apagar: ninguém. Processo errado é reprovado com o motivo, e fica o
-- registro — atestado que some é o primeiro assunto de uma auditoria.


-- ---------------------------------------------------------------------
--  O gatilho que faz as regras valerem
-- ---------------------------------------------------------------------
create or replace function public.homol_processo_regras()
returns trigger
language plpgsql security definer set search_path = public as $$
declare
  eu       public.homol_conta;
  medico   boolean := public.homol_eh_medico();
  meu_nome text    := public.homol_meu_nome();
begin
  select * into eu from public.homol_eu();
  if eu.id is null and not medico then
    raise exception 'SEM_ACESSO: esta conta não tem acesso à homologação';
  end if;

  -- a data fim sai das outras duas, sempre — nunca do que a tela manda
  new.fim := new.inicio + (new.dias - 1);
  new.atualizado_em := now();

  -- A FILIAL TEM DE SER UMA DAS CADASTRADAS, quando a empresa tem filiais
  -- cadastradas (quem lança é o RH; o CNPJ vem da conta dele). Empresa
  -- sem filial nenhuma cadastrada continua livre.
  if not medico and exists (select 1 from public.homol_filial f
                             where f.empresa_cnpj = eu.empresa_cnpj and f.ativo) then
    if not exists (select 1 from public.homol_filial f
                    where f.empresa_cnpj = eu.empresa_cnpj and f.ativo
                      and f.nome = coalesce(new.filial, '')) then
      raise exception 'FILIAL_INVALIDA: escolha uma das filiais cadastradas pela clínica';
    end if;
  end if;

  if tg_op = 'INSERT' then
    if eu.id is null then
      raise exception 'SO_RH_LANCA: quem lança atestado é o RH da empresa';
    end if;
    new.empresa_cnpj    := eu.empresa_cnpj;
    new.empresa_nome    := eu.empresa_nome;
    new.requisitante    := eu.nome;
    new.criado_por      := eu.id;
    new.criado_por_nome := eu.nome;
    new.abertura        := now();
    new.parecer         := 'Pendente';
    new.parecer_obs     := null;
    new.parecer_por     := null;
    new.parecer_em      := null;
    new.situacao        := 'aberto';
    new.atividade       := 'Clínica avalia atestado';
    return new;
  end if;

  -- UPDATE: o que ninguém muda
  new.id              := old.id;
  new.empresa_cnpj    := old.empresa_cnpj;
  new.empresa_nome    := old.empresa_nome;
  new.requisitante    := old.requisitante;
  new.abertura        := old.abertura;
  new.criado_por      := old.criado_por;
  new.criado_por_nome := old.criado_por_nome;

  if medico then
    -- O PARECER DECIDE O PROCESSO, sozinho:
    --   Aprovado  -> finalizado, "Homologado"
    --   Reprovado -> finalizado, "Não homologado"
    --   Pendente  -> volta à empresa, "Aguardando documento"
    if new.parecer in ('Pendente', 'Reprovado') and coalesce(btrim(new.parecer_obs), '') = '' then
      raise exception 'FALTA_MOTIVO: diga à empresa o que falta, ou por que foi reprovado';
    end if;
    if new.parecer = 'Aprovado' and (new.tipo is null or new.medico is null
                                     or new.entidade is null or new.responsavel is null) then
      raise exception 'FALTA_CAMPO: para aprovar, preencha tipo, médico, entidade e responsável';
    end if;
    new.situacao    := case when new.parecer = 'Pendente' then 'aberto' else 'finalizado' end;
    new.atividade   := case new.parecer when 'Aprovado'  then 'Homologado'
                                        when 'Reprovado' then 'Não homologado'
                                        else 'Aguardando documento' end;
    new.parecer_por := meu_nome;
    new.parecer_em  := now();
  else
    -- o RH corrige e reenvia; o parecer não é dele, nem por engano
    if old.situacao = 'finalizado' then
      raise exception 'FINALIZADO: processo finalizado não se altera';
    end if;
    new.parecer     := old.parecer;
    new.parecer_obs := old.parecer_obs;
    new.parecer_por := old.parecer_por;
    new.parecer_em  := old.parecer_em;
    new.situacao    := 'aberto';
    new.atividade   := 'Clínica avalia atestado';
  end if;
  return new;
end;
$$;
drop trigger if exists trg_homol_processo_regras on public.homol_processo;
create trigger trg_homol_processo_regras
  before insert or update on public.homol_processo
  for each row execute function public.homol_processo_regras();


-- =====================================================================
--  4. O HISTÓRICO (movimentações + comentários)
-- =====================================================================
create table if not exists public.homol_evento (
  id          bigint generated by default as identity primary key,
  processo_id bigint not null references public.homol_processo(id) on delete cascade,
  quando      timestamptz not null default now(),
  quem_id     uuid default auth.uid(),
  quem_nome   text,
  oque        text not null check (length(oque) between 1 and 4000),
  comentario  boolean not null default false
);
create index if not exists idx_homol_evento_proc on public.homol_evento (processo_id, quando);
alter table public.homol_evento enable row level security;

drop policy if exists homol_evento_ler on public.homol_evento;
create policy homol_evento_ler on public.homol_evento
  for select using (exists (
    select 1 from public.homol_processo p
     where p.id = processo_id and public.homol_pode_ver(p.empresa_cnpj)));

-- Pela tela, só entra COMENTÁRIO. As movimentações quem escreve são os
-- gatilhos: ninguém consegue forjar "Parecer: Aprovado" no histórico.
drop policy if exists homol_evento_comentar on public.homol_evento;
create policy homol_evento_comentar on public.homol_evento
  for insert with check (
    comentario
    and public.homol_meu_nome() is not null
    and exists (select 1 from public.homol_processo p
                 where p.id = processo_id and public.homol_pode_ver(p.empresa_cnpj)));

create or replace function public.homol_evento_carimbo()
returns trigger
language plpgsql security definer set search_path = public as $$
begin
  if new.comentario then
    new.quem_id   := auth.uid();
    new.quem_nome := public.homol_meu_nome();
    new.quando    := now();
    new.oque      := btrim(new.oque);
  end if;
  return new;
end;
$$;
drop trigger if exists trg_homol_evento_carimbo on public.homol_evento;
create trigger trg_homol_evento_carimbo
  before insert on public.homol_evento
  for each row execute function public.homol_evento_carimbo();

-- A linha do histórico de cada mudança no processo
create or replace function public.homol_processo_historico()
returns trigger
language plpgsql security definer set search_path = public as $$
declare
  quem text := coalesce(public.homol_meu_nome(), 'Sistema');
  txt  text;
begin
  if tg_op = 'INSERT' then
    txt := 'Processo aberto e enviado à clínica';
  elsif new.parecer_em is distinct from old.parecer_em then
    txt := 'Parecer: ' || new.parecer ||
           coalesce('. Motivo: ' || nullif(btrim(new.parecer_obs), ''), '');
  else
    txt := 'Processo corrigido e reenviado à clínica';
  end if;
  insert into public.homol_evento (processo_id, quem_id, quem_nome, oque, comentario)
  values (new.id, auth.uid(), quem, txt, false);
  return null;
end;
$$;
drop trigger if exists trg_homol_processo_historico on public.homol_processo;
create trigger trg_homol_processo_historico
  after insert or update on public.homol_processo
  for each row execute function public.homol_processo_historico();


-- =====================================================================
--  5. OS ANEXOS
--  O arquivo mora no Storage (balde privado "homologacao", pasta = número
--  do processo); aqui fica a ficha dele.
-- =====================================================================
create table if not exists public.homol_anexo (
  id          bigint generated by default as identity (start with 3800001) primary key,
  processo_id bigint not null references public.homol_processo(id) on delete cascade,
  nome        text not null,
  tipo        text not null check (tipo in ('application/pdf', 'image/jpeg', 'image/png')),
  tamanho     bigint not null check (tamanho between 1 and 10485760),
  caminho     text not null unique,
  versao      int  not null default 1000,
  quem_id     uuid default auth.uid(),
  quem_nome   text,
  quando      timestamptz not null default now(),
  atividade   text
);
create index if not exists idx_homol_anexo_proc on public.homol_anexo (processo_id);
alter table public.homol_anexo enable row level security;

-- Pode anexar: o médico, ou o RH da empresa enquanto não finalizou.
create or replace function public.homol_pode_anexar(p_processo bigint)
returns boolean
language sql stable security definer set search_path = public as $$
  select exists (
    select 1 from public.homol_processo p
     where p.id = p_processo
       and (public.homol_eh_medico()
            or (p.empresa_cnpj = public.homol_meu_cnpj() and p.situacao <> 'finalizado')));
$$;
create or replace function public.homol_pode_ver_processo(p_processo bigint)
returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.homol_processo p
                  where p.id = p_processo and public.homol_pode_ver(p.empresa_cnpj));
$$;
revoke execute on function public.homol_pode_anexar(bigint) from public;
revoke execute on function public.homol_pode_ver_processo(bigint) from public;
grant execute on function public.homol_pode_anexar(bigint) to authenticated;
grant execute on function public.homol_pode_ver_processo(bigint) to authenticated;

drop policy if exists homol_anexo_ler on public.homol_anexo;
create policy homol_anexo_ler on public.homol_anexo
  for select using (public.homol_pode_ver_processo(processo_id));
drop policy if exists homol_anexo_incluir on public.homol_anexo;
create policy homol_anexo_incluir on public.homol_anexo
  for insert with check (
    public.homol_pode_anexar(processo_id)
    and caminho like processo_id::text || '/%');
-- tirar: só quem anexou, e só enquanto pode anexar
drop policy if exists homol_anexo_tirar on public.homol_anexo;
create policy homol_anexo_tirar on public.homol_anexo
  for delete using (quem_id = auth.uid() and public.homol_pode_anexar(processo_id));

create or replace function public.homol_anexo_carimbo()
returns trigger
language plpgsql security definer set search_path = public as $$
begin
  new.quem_id   := auth.uid();
  new.quem_nome := public.homol_meu_nome();
  new.quando    := now();
  new.atividade := (select atividade from public.homol_processo where id = new.processo_id);
  return new;
end;
$$;
drop trigger if exists trg_homol_anexo_carimbo on public.homol_anexo;
create trigger trg_homol_anexo_carimbo
  before insert on public.homol_anexo
  for each row execute function public.homol_anexo_carimbo();

create or replace function public.homol_anexo_historico()
returns trigger
language plpgsql security definer set search_path = public as $$
begin
  if tg_op = 'INSERT' then
    insert into public.homol_evento (processo_id, quem_id, quem_nome, oque)
    values (new.processo_id, auth.uid(), new.quem_nome, 'Anexou o arquivo ' || new.nome);
    return null;
  end if;
  insert into public.homol_evento (processo_id, quem_id, quem_nome, oque)
  values (old.processo_id, auth.uid(), public.homol_meu_nome(), 'Tirou o arquivo ' || old.nome);
  return null;
end;
$$;
drop trigger if exists trg_homol_anexo_historico on public.homol_anexo;
create trigger trg_homol_anexo_historico
  after insert or delete on public.homol_anexo
  for each row execute function public.homol_anexo_historico();

-- O balde do Storage: PRIVADO. Quem abre um arquivo recebe um link que
-- vale poucos minutos, e só se puder ver o processo.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('homologacao', 'homologacao', false, 10485760,
        array['application/pdf', 'image/jpeg', 'image/png'])
on conflict (id) do update
  set public = false, file_size_limit = excluded.file_size_limit,
      allowed_mime_types = excluded.allowed_mime_types;

-- a pasta do arquivo é o número do processo: "1000123/1695400000-atestado.pdf"
create or replace function public.homol_processo_da_pasta(p_nome text)
returns bigint
language sql immutable as $$
  select case when split_part(p_nome, '/', 1) ~ '^\d{1,18}$'
              then split_part(p_nome, '/', 1)::bigint end;
$$;

drop policy if exists homol_storage_ler on storage.objects;
create policy homol_storage_ler on storage.objects
  for select to authenticated using (
    bucket_id = 'homologacao'
    and public.homol_pode_ver_processo(public.homol_processo_da_pasta(name)));
drop policy if exists homol_storage_enviar on storage.objects;
create policy homol_storage_enviar on storage.objects
  for insert to authenticated with check (
    bucket_id = 'homologacao'
    and public.homol_pode_anexar(public.homol_processo_da_pasta(name)));
drop policy if exists homol_storage_apagar on storage.objects;
create policy homol_storage_apagar on storage.objects
  for delete to authenticated using (
    bucket_id = 'homologacao'
    and public.homol_pode_anexar(public.homol_processo_da_pasta(name))
    and owner = auth.uid());


-- =====================================================================
--  6. ENTIDADES E PROFISSIONAIS DE SAÚDE
--  Um cadastro só, da clínica inteira: o hospital que um RH cadastrou
--  aparece para os outros, e o médico não cadastra o mesmo lugar três
--  vezes com três grafias.
-- =====================================================================
create table if not exists public.homol_entidade (
  codigo      bigint generated by default as identity primary key,
  nome        text not null,
  fantasia    text,
  cnpj        text unique check (cnpj is null or cnpj ~ '^\d{14}$'),
  cidade      text,
  uf          text,
  criado_por  text,
  criado_em   timestamptz not null default now()
);
create table if not exists public.homol_profissional (
  codigo      bigint generated by default as identity primary key,
  nome        text not null,
  orgao       text not null,
  uf          text not null check (uf ~ '^[A-Z]{2}$'),
  numero      text not null,
  registro    text not null,
  criado_por  text,
  criado_em   timestamptz not null default now(),
  unique (orgao, uf, numero)
);
alter table public.homol_entidade enable row level security;
alter table public.homol_profissional enable row level security;

drop policy if exists homol_ent_ler on public.homol_entidade;
create policy homol_ent_ler on public.homol_entidade
  for select using (public.homol_meu_nome() is not null or public.homol_is_equipe());
drop policy if exists homol_ent_incluir on public.homol_entidade;
create policy homol_ent_incluir on public.homol_entidade
  for insert with check (public.homol_meu_nome() is not null);
drop policy if exists homol_ent_equipe on public.homol_entidade;
create policy homol_ent_equipe on public.homol_entidade
  for all using (public.homol_is_equipe()) with check (public.homol_is_equipe());

drop policy if exists homol_prof_ler on public.homol_profissional;
create policy homol_prof_ler on public.homol_profissional
  for select using (public.homol_meu_nome() is not null or public.homol_is_equipe());
drop policy if exists homol_prof_incluir on public.homol_profissional;
create policy homol_prof_incluir on public.homol_profissional
  for insert with check (public.homol_meu_nome() is not null);
drop policy if exists homol_prof_equipe on public.homol_profissional;
create policy homol_prof_equipe on public.homol_profissional
  for all using (public.homol_is_equipe()) with check (public.homol_is_equipe());

create or replace function public.homol_cadastro_carimbo()
returns trigger
language plpgsql security definer set search_path = public as $$
begin
  new.criado_por := coalesce(public.homol_meu_nome(), new.criado_por);
  new.nome := upper(btrim(new.nome));
  return new;
end;
$$;
drop trigger if exists trg_homol_ent_carimbo on public.homol_entidade;
create trigger trg_homol_ent_carimbo before insert on public.homol_entidade
  for each row execute function public.homol_cadastro_carimbo();
drop trigger if exists trg_homol_prof_carimbo on public.homol_profissional;
create trigger trg_homol_prof_carimbo before insert on public.homol_profissional
  for each row execute function public.homol_cadastro_carimbo();


-- =====================================================================
--  7. Anônimo não enxerga nada
-- =====================================================================
revoke all on public.homol_conta, public.homol_processo, public.homol_evento,
              public.homol_anexo, public.homol_entidade, public.homol_profissional,
              public.homol_filial
  from anon;
grant select, insert, update on public.homol_filial to authenticated;
grant select, insert, update on public.homol_processo to authenticated;
grant select, insert on public.homol_evento to authenticated;
grant select, insert, delete on public.homol_anexo to authenticated;
grant select, insert, update, delete on public.homol_entidade, public.homol_profissional to authenticated;
grant select, insert, update, delete on public.homol_conta to authenticated;


-- =====================================================================
--  Confira — todas as linhas têm de bater com a coluna "esperado"
-- =====================================================================
select 'tabelas homol_' as o_que,
       (select count(*) from information_schema.tables
         where table_schema = 'public' and table_name like 'homol\_%')::text as achei,
       '7' as esperado
union all
select 'tabelas com RLS ligada',
       (select count(*) from pg_class c join pg_namespace n on n.oid = c.relnamespace
         where n.nspname = 'public' and c.relname like 'homol\_%' and c.relkind = 'r'
           and c.relrowsecurity)::text, '7'
union all
select 'gatilhos',
       (select count(*) from pg_trigger t join pg_class c on c.oid = t.tgrelid
         where c.relname like 'homol\_%' and not t.tgisinternal)::text, '7'
union all
select 'balde de anexos privado',
       (select (not public)::text from storage.buckets where id = 'homologacao'), 'true'
union all
select 'politicas do storage',
       (select count(*) from pg_policies
         where schemaname = 'storage' and policyname like 'homol\_storage\_%')::text, '3'
union all
select 'anon NAO le processos',
       (not has_table_privilege('anon', 'public.homol_processo', 'select'))::text, 'true';
