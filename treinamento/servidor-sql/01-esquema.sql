-- =====================================================================
--  Clínica Medicina Humana — Área de Treinamentos em NRs
--  Esquema do banco (Supabase / Postgres) + regras de segurança (RLS)
--
--  Rode no Supabase:  SQL Editor > New query > cole > Run
--  Projeto: ojhulerxocgaxbiutrnm  (o MESMO do site e do SistemaCMH)
--
--
--  COMO FUNCIONA, EM UMA PÁGINA
--  ----------------------------
--  1. No SistemaCMH você gera um CUPOM: quais cursos ele libera, para
--     quantas pessoas, até quando dá para resgatar e por quanto tempo cada
--     um fica com acesso.
--  2. O cliente recebe um código só (ex.: NR35-7K4M-2PQX) e repassa para
--     a equipe dele. Um código, dez mil pessoas em potencial — sem você
--     cadastrar ninguém.
--  3. No site, cada trabalhador resgata o cupom com o CPF e o nome dele, e
--     escolhe a própria senha. A partir daí a CONTA É INDIVIDUAL.
--  4. Cada resgate consome uma vaga do cupom. Quando acaba, o próximo vê
--     um recado para procurar o RH — e o RH procura o comercial.
--
--  Por que individual: certificado de NR é nominal, com nome e CPF de quem
--  fez. Conta compartilhada não sabe quem assistiu, e o papel sairia sem
--  dono — inútil numa fiscalização. O cupom resolve o volume sem abrir mão
--  disso.
--
--
--  DUAS DATAS DIFERENTES, DE PROPÓSITO
--  -----------------------------------
--  `expira_resgate` é até quando o CUPOM pode ser resgatado.
--  `acesso_ate` / `acesso_dias` é quanto tempo a PESSOA fica com o curso.
--  São coisas distintas: um cupom pode parar de ser distribuído em março e
--  quem resgatou em fevereiro seguir estudando até dezembro.
--
--
--  QUEM ESCREVE E QUEM LÊ
--  ----------------------
--  O SistemaCMH grava o cupom direto, pelo REST, com o login de quem está
--  usando o programa (tabela `orc_usuarios`). O resgate é feito por Edge
--  Function, porque só ela pode criar usuário no Auth e porque a conta da
--  vaga precisa ser feita com a linha travada — dois resgates no mesmo
--  segundo venderiam a mesma vaga duas vezes.
--
--
--  A TRAVA DO PRAZO FICA AQUI, E NÃO NO SITE
--  -----------------------------------------
--  Aula e material só saem enquanto a matrícula está no prazo. Quem decide
--  é o banco: o que o navegador esconde, qualquer um mostra de volta.
-- =====================================================================

create extension if not exists "uuid-ossp";

-- =====================================================================
--  Quem é da casa
-- =====================================================================

-- Equipe da clínica, vista dos DOIS lados. O SistemaCMH tem os usuários
-- dele em `orc_usuarios` (domínio orcamentos.…) e o site tem a equipe do
-- sistema de resultados em `admins` (domínio admin.…). São conjuntos
-- diferentes de gente, e os dois precisam poder administrar treinamento.
create or replace function public.trein_is_equipe()
returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.orc_usuarios u
                  where u.id = auth.uid() and u.ativo)
      or exists (select 1 from public.admins a where a.user_id = auth.uid());
$$;

-- =====================================================================
--  Catálogo
-- =====================================================================

create table if not exists public.trein_curso (
  id              uuid primary key default uuid_generate_v4(),
  codigo          text unique not null,       -- 'NR-35', 'NR-11', 'DD'
  titulo          text not null,
  subtitulo       text,
  carga_horaria   int,                        -- em horas
  -- de quanto em quanto tempo a NR manda reciclar: é o que define a
  -- validade impressa no certificado
  validade_meses  int,
  preco           numeric(10,2),
  descricao       text,
  capa_url        text,
  -- porcentagem de acerto para passar. Por curso, e não fixa no código,
  -- porque nem toda NR exige o mesmo.
  nota_minima     int not null default 70,
  ativo           boolean not null default true,
  ordem           int not null default 0
);

create table if not exists public.trein_aula (
  id             uuid primary key default uuid_generate_v4(),
  curso_id       uuid not null references public.trein_curso(id) on delete cascade,
  titulo         text not null,
  descricao      text,
  video_url      text,          -- onde o vídeo está hospedado
  duracao_seg    int,
  material_path  text,          -- apostila no Storage privado
  ordem          int not null default 0
);
create index if not exists idx_trein_aula_curso on public.trein_aula(curso_id, ordem);

-- =====================================================================
--  O CUPOM — é o que o SistemaCMH gera e o cliente recebe
-- =====================================================================
create table if not exists public.trein_cupom (
  id              uuid primary key default uuid_generate_v4(),
  codigo          text unique not null,
  -- de quem é. Texto livre porque a empresa não precisa ter cadastro
  -- nenhum aqui: o cupom é entregue ao comercial, não a um login.
  empresa         text,
  empresa_cnpj    text,
  contato         text,
  -- quantas pessoas podem resgatar. 0 = sem limite (cortesia, demo).
  quantidade      int not null default 0,
  -- até quando dá para RESGATAR o cupom
  expira_resgate  date not null,
  -- por quanto tempo quem resgatou fica com o curso. Preencha um dos dois:
  -- `acesso_dias` conta a partir do resgate (justo com quem entra tarde);
  -- `acesso_ate` é data fixa para todos.
  acesso_dias     int,
  acesso_ate      date,
  ativo           boolean not null default true,
  observacao      text,
  criado_por      text,          -- nome de quem gerou no SistemaCMH
  criado_em       timestamptz not null default now(),
  constraint trein_cupom_prazo check (acesso_dias is not null or acesso_ate is not null)
);
create index if not exists idx_trein_cupom_codigo on public.trein_cupom(codigo);

-- quais cursos aquele cupom libera
create table if not exists public.trein_cupom_curso (
  cupom_id  uuid not null references public.trein_cupom(id) on delete cascade,
  curso_id  uuid not null references public.trein_curso(id) on delete cascade,
  primary key (cupom_id, curso_id)
);

-- =====================================================================
--  O ALUNO — conta individual, criada no resgate
-- =====================================================================
create table if not exists public.trein_aluno (
  id          uuid primary key references auth.users(id) on delete cascade,
  cpf         text unique not null,
  nome        text not null,
  email       text,
  telefone    text,
  -- de que empresa ele veio. Copiado do cupom no resgate, para o relatório
  -- "quem da Construtora X já fez o NR-35" não depender de o cupom existir
  -- para sempre.
  empresa     text,
  criado_em   timestamptz not null default now()
);
create index if not exists idx_trein_aluno_empresa on public.trein_aluno(empresa);

-- um resgate é uma vaga consumida. Tabela própria (e não um contador no
-- cupom) porque contador some o histórico: aqui dá para saber QUEM pegou.
create table if not exists public.trein_resgate (
  cupom_id      uuid not null references public.trein_cupom(id) on delete cascade,
  aluno_id      uuid not null references public.trein_aluno(id) on delete cascade,
  resgatado_em  timestamptz not null default now(),
  primary key (cupom_id, aluno_id)
);
create index if not exists idx_trein_resgate_cupom on public.trein_resgate(cupom_id);

-- =====================================================================
--  A MATRÍCULA — quem tem qual curso, até quando
-- =====================================================================
create table if not exists public.trein_matricula (
  id          uuid primary key default uuid_generate_v4(),
  aluno_id    uuid not null references public.trein_aluno(id) on delete cascade,
  curso_id    uuid not null references public.trein_curso(id) on delete cascade,
  cupom_id    uuid references public.trein_cupom(id) on delete set null,
  liberado_em date not null default current_date,
  expira_em   date not null,
  -- cancelar em vez de apagar: se houve estorno, o registro do que
  -- aconteceu tem de continuar existindo.
  cancelada   boolean not null default false,
  criado_em   timestamptz not null default now(),
  unique (aluno_id, curso_id)
);
create index if not exists idx_trein_mat_aluno on public.trein_matricula(aluno_id);
create index if not exists idx_trein_mat_venc  on public.trein_matricula(expira_em);

-- =====================================================================
--  Progresso, prova e certificado
-- =====================================================================
create table if not exists public.trein_progresso (
  matricula_id    uuid not null references public.trein_matricula(id) on delete cascade,
  aula_id         uuid not null references public.trein_aula(id) on delete cascade,
  segundos_vistos int not null default 0,
  concluida       boolean not null default false,
  atualizado_em   timestamptz not null default now(),
  primary key (matricula_id, aula_id)
);

-- ATENÇÃO: esta tabela NÃO é lida pelo navegador, nem por quem está
-- matriculado — veja a RLS lá embaixo. A resposta certa não pode chegar ao
-- cliente nem escondida: basta abrir a aba de rede para vê-la. A prova é
-- servida e corrigida por Edge Function.
create table if not exists public.trein_questao (
  id            uuid primary key default uuid_generate_v4(),
  curso_id      uuid not null references public.trein_curso(id) on delete cascade,
  enunciado     text not null,
  alternativas  jsonb not null,      -- ["texto a", "texto b", ...]
  correta       int not null,        -- índice da certa dentro do array
  ordem         int not null default 0
);
create index if not exists idx_trein_questao_curso on public.trein_questao(curso_id);

-- guardamos TODAS as tentativas, e não só a última: numa fiscalização o
-- que vale é poder mostrar o histórico
create table if not exists public.trein_tentativa (
  id            uuid primary key default uuid_generate_v4(),
  matricula_id  uuid not null references public.trein_matricula(id) on delete cascade,
  feita_em      timestamptz not null default now(),
  acertos       int not null,
  total         int not null,
  nota          int not null,        -- porcentagem
  aprovado      boolean not null
);
create index if not exists idx_trein_tent_mat on public.trein_tentativa(matricula_id);

create table if not exists public.trein_certificado (
  id            uuid primary key default uuid_generate_v4(),
  matricula_id  uuid not null unique references public.trein_matricula(id) on delete cascade,
  -- para quem recebe o papel poder conferir a autenticidade sem login
  codigo        text unique not null,
  emitido_em    timestamptz not null default now(),
  valido_ate    date
);

-- =====================================================================
--  O RESGATE, feito com a linha do cupom travada
--
--  Toda a conferência acontece aqui dentro, numa transação só. Se dois
--  trabalhadores resgatarem a última vaga no mesmo segundo, o `for update`
--  faz um esperar o outro — e o segundo recebe "esgotado" em vez de os
--  dois entrarem. Contar as vagas na Edge Function não daria essa
--  garantia.
--
--  O usuário no Auth já foi criado pela Edge Function quando chega aqui;
--  se esta função levantar erro, é ela que desfaz o usuário.
-- =====================================================================
create or replace function public.trein_resgatar(
  p_codigo    text,
  p_aluno_id  uuid,
  p_cpf       text,
  p_nome      text,
  p_email     text default null,
  p_telefone  text default null
) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  v_cupom    public.trein_cupom%rowtype;
  v_usados   int;
  v_expira   date;
  v_cursos   int;
begin
  select * into v_cupom from public.trein_cupom
   where upper(codigo) = upper(trim(p_codigo))
   for update;                      -- trava: é o que impede vender duas vezes

  if not found then
    raise exception 'CUPOM_INVALIDO';
  end if;
  if not v_cupom.ativo then
    raise exception 'CUPOM_CANCELADO';
  end if;
  if v_cupom.expira_resgate < current_date then
    raise exception 'CUPOM_VENCIDO';
  end if;

  if v_cupom.quantidade > 0 then
    select count(*) into v_usados from public.trein_resgate r
     where r.cupom_id = v_cupom.id;
    if v_usados >= v_cupom.quantidade then
      raise exception 'CUPOM_ESGOTADO';
    end if;
  end if;

  -- até quando esta pessoa fica com o curso
  v_expira := case
                when v_cupom.acesso_dias is not null
                  then current_date + v_cupom.acesso_dias
                else v_cupom.acesso_ate
              end;

  insert into public.trein_aluno (id, cpf, nome, email, telefone, empresa)
  values (p_aluno_id, p_cpf, p_nome, p_email, p_telefone, v_cupom.empresa)
  on conflict (id) do nothing;

  insert into public.trein_resgate (cupom_id, aluno_id)
  values (v_cupom.id, p_aluno_id);   -- a PK impede resgatar o mesmo cupom 2x

  -- renovar/ampliar nunca cria segunda linha do mesmo curso: o progresso e
  -- as provas ficariam presos na matrícula antiga. E o prazo só anda para
  -- a frente — um cupom curto não pode encurtar quem já tinha mais tempo.
  insert into public.trein_matricula (aluno_id, curso_id, cupom_id, expira_em)
  select p_aluno_id, cc.curso_id, v_cupom.id, v_expira
    from public.trein_cupom_curso cc
   where cc.cupom_id = v_cupom.id
  on conflict (aluno_id, curso_id) do update
     set expira_em = greatest(public.trein_matricula.expira_em, excluded.expira_em),
         cancelada = false,
         cupom_id  = excluded.cupom_id;

  get diagnostics v_cursos = row_count;

  return jsonb_build_object(
    'cupom_id', v_cupom.id,
    'empresa',  v_cupom.empresa,
    'expira_em', v_expira,
    'cursos',   v_cursos
  );
end;
$$;
revoke execute on function public.trein_resgatar(text, uuid, text, text, text, text) from anon, authenticated;

-- Antes de resgatar, o site mostra o que o cupom dá. Esta função é a única
-- coisa do cupom que quem não tem login pode ver — e de propósito não
-- devolve quantas vagas restam, só se ainda há: o número exato é
-- informação comercial do cliente.
create or replace function public.trein_espiar_cupom(p_codigo text)
returns jsonb
language plpgsql stable security definer set search_path = public as $$
declare
  v_cupom  public.trein_cupom%rowtype;
  v_usados int;
begin
  select * into v_cupom from public.trein_cupom
   where upper(codigo) = upper(trim(p_codigo));
  if not found or not v_cupom.ativo or v_cupom.expira_resgate < current_date then
    return jsonb_build_object('valido', false);
  end if;
  select count(*) into v_usados from public.trein_resgate where cupom_id = v_cupom.id;
  if v_cupom.quantidade > 0 and v_usados >= v_cupom.quantidade then
    return jsonb_build_object('valido', false, 'motivo', 'esgotado');
  end if;
  return jsonb_build_object(
    'valido', true,
    'empresa', v_cupom.empresa,
    'cursos', (select coalesce(jsonb_agg(jsonb_build_object(
                 'codigo', c.codigo, 'titulo', c.titulo,
                 'carga_horaria', c.carga_horaria) order by c.ordem), '[]'::jsonb)
                 from public.trein_cupom_curso cc
                 join public.trein_curso c on c.id = cc.curso_id
                where cc.cupom_id = v_cupom.id)
  );
end;
$$;
grant execute on function public.trein_espiar_cupom(text) to anon, authenticated;

-- O aluno logado tem ESTE curso, e dentro do prazo?
create or replace function public.trein_pode_ver(p_curso uuid)
returns boolean
language sql stable security definer set search_path = public as $$
  select exists (
    select 1 from public.trein_matricula m
    where m.aluno_id = auth.uid()
      and m.curso_id = p_curso
      and not m.cancelada
      and m.expira_em >= current_date
  );
$$;

-- =====================================================================
--  Row Level Security
-- =====================================================================
alter table public.trein_curso       enable row level security;
alter table public.trein_aula        enable row level security;
alter table public.trein_cupom       enable row level security;
alter table public.trein_cupom_curso enable row level security;
alter table public.trein_aluno       enable row level security;
alter table public.trein_resgate     enable row level security;
alter table public.trein_matricula   enable row level security;
alter table public.trein_progresso   enable row level security;
alter table public.trein_questao     enable row level security;
alter table public.trein_tentativa   enable row level security;
alter table public.trein_certificado enable row level security;

-- catálogo: público de propósito. A página de vendas mostra os cursos para
-- quem ainda não é cliente — é justamente o que faz vender.
drop policy if exists trein_curso_publico on public.trein_curso;
create policy trein_curso_publico on public.trein_curso
  for select using (ativo or public.trein_is_equipe());
drop policy if exists trein_curso_equipe on public.trein_curso;
create policy trein_curso_equipe on public.trein_curso
  for all using (public.trein_is_equipe()) with check (public.trein_is_equipe());

-- aula: só de curso liberado E no prazo. É aqui que a data trava.
drop policy if exists trein_aula_lib on public.trein_aula;
create policy trein_aula_lib on public.trein_aula
  for select using (public.trein_pode_ver(curso_id) or public.trein_is_equipe());
drop policy if exists trein_aula_equipe on public.trein_aula;
create policy trein_aula_equipe on public.trein_aula
  for all using (public.trein_is_equipe()) with check (public.trein_is_equipe());

-- CUPOM: só a equipe enxerga. É por aqui que o SistemaCMH grava, direto
-- pelo REST. Quem tem o código não lê a tabela — usa trein_espiar_cupom,
-- que não conta quantas vagas sobraram.
drop policy if exists trein_cupom_equipe on public.trein_cupom;
create policy trein_cupom_equipe on public.trein_cupom
  for all using (public.trein_is_equipe()) with check (public.trein_is_equipe());
drop policy if exists trein_cupomc_equipe on public.trein_cupom_curso;
create policy trein_cupomc_equipe on public.trein_cupom_curso
  for all using (public.trein_is_equipe()) with check (public.trein_is_equipe());
drop policy if exists trein_resgate_equipe on public.trein_resgate;
create policy trein_resgate_equipe on public.trein_resgate
  for select using (aluno_id = auth.uid() or public.trein_is_equipe());

-- aluno: vê a própria ficha e pode corrigir os próprios dados
drop policy if exists trein_aluno_self on public.trein_aluno;
create policy trein_aluno_self on public.trein_aluno
  for select using (id = auth.uid() or public.trein_is_equipe());
drop policy if exists trein_aluno_upd on public.trein_aluno;
create policy trein_aluno_upd on public.trein_aluno
  for update using (id = auth.uid()) with check (id = auth.uid());
drop policy if exists trein_aluno_equipe on public.trein_aluno;
create policy trein_aluno_equipe on public.trein_aluno
  for all using (public.trein_is_equipe()) with check (public.trein_is_equipe());

-- matrícula: o aluno vê as próprias, inclusive vencidas — precisa saber
-- que venceu para procurar a renovação
drop policy if exists trein_mat_self on public.trein_matricula;
create policy trein_mat_self on public.trein_matricula
  for select using (aluno_id = auth.uid() or public.trein_is_equipe());
drop policy if exists trein_mat_equipe on public.trein_matricula;
create policy trein_mat_equipe on public.trein_matricula
  for all using (public.trein_is_equipe()) with check (public.trein_is_equipe());

-- progresso: o aluno lê o próprio, e só escreve enquanto está no prazo
drop policy if exists trein_prog_sel on public.trein_progresso;
create policy trein_prog_sel on public.trein_progresso
  for select using (
    exists (select 1 from public.trein_matricula m
            where m.id = matricula_id and m.aluno_id = auth.uid())
    or public.trein_is_equipe());
drop policy if exists trein_prog_ins on public.trein_progresso;
create policy trein_prog_ins on public.trein_progresso
  for insert with check (
    exists (select 1 from public.trein_matricula m
            where m.id = matricula_id and m.aluno_id = auth.uid()
              and not m.cancelada and m.expira_em >= current_date));
drop policy if exists trein_prog_upd on public.trein_progresso;
create policy trein_prog_upd on public.trein_progresso
  for update using (
    exists (select 1 from public.trein_matricula m
            where m.id = matricula_id and m.aluno_id = auth.uid()
              and not m.cancelada and m.expira_em >= current_date));

-- QUESTÕES: ninguém lê pelo navegador, nem quem está matriculado.
drop policy if exists trein_questao_equipe on public.trein_questao;
create policy trein_questao_equipe on public.trein_questao
  for all using (public.trein_is_equipe()) with check (public.trein_is_equipe());

-- tentativas: o aluno vê as próprias notas; quem GRAVA é a Edge Function
drop policy if exists trein_tent_self on public.trein_tentativa;
create policy trein_tent_self on public.trein_tentativa
  for select using (
    exists (select 1 from public.trein_matricula m
            where m.id = matricula_id and m.aluno_id = auth.uid())
    or public.trein_is_equipe());
drop policy if exists trein_tent_equipe on public.trein_tentativa;
create policy trein_tent_equipe on public.trein_tentativa
  for all using (public.trein_is_equipe()) with check (public.trein_is_equipe());

-- certificado: o aluno baixa o próprio. Quem EMITE é a Edge Function,
-- depois de conferir que passou — nunca o navegador.
drop policy if exists trein_cert_self on public.trein_certificado;
create policy trein_cert_self on public.trein_certificado
  for select using (
    exists (select 1 from public.trein_matricula m
            where m.id = matricula_id and m.aluno_id = auth.uid())
    or public.trein_is_equipe());
drop policy if exists trein_cert_equipe on public.trein_certificado;
create policy trein_cert_equipe on public.trein_certificado
  for all using (public.trein_is_equipe()) with check (public.trein_is_equipe());

-- =====================================================================
--  Conferência da autenticidade do certificado, SEM login
--
--  Quem recebe o certificado (auditor, contratante) precisa poder conferir
--  sem ter conta. Devolve só o que confirma o documento, e o CPF sai
--  mascarado — o suficiente para bater com o papel na mão, sem expor o
--  número inteiro de quem não pediu nada.
-- =====================================================================
create or replace function public.trein_conferir_certificado(p_codigo text)
returns table (nome text, cpf_masc text, empresa text, curso text,
               carga_horaria int, emitido_em timestamptz, valido_ate date)
language sql stable security definer set search_path = public as $$
  select a.nome,
         '***.' || substr(a.cpf, 4, 3) || '.' || substr(a.cpf, 7, 3) || '-**',
         a.empresa, c.titulo, c.carga_horaria, ce.emitido_em, ce.valido_ate
  from public.trein_certificado ce
  join public.trein_matricula m on m.id = ce.matricula_id
  join public.trein_aluno a     on a.id = m.aluno_id
  join public.trein_curso c     on c.id = m.curso_id
  where ce.codigo = upper(trim(p_codigo));
$$;
grant execute on function public.trein_conferir_certificado(text) to anon, authenticated;

-- =====================================================================
--  Storage: bucket privado "treinamentos" (apostilas e materiais)
--  Crie o bucket PRIVADO pelo painel ANTES de rodar estas políticas.
--  Os arquivos ficam em "<curso_id>/arquivo.pdf".
-- =====================================================================
drop policy if exists trein_stor_read on storage.objects;
create policy trein_stor_read on storage.objects
  for select using (
    bucket_id = 'treinamentos'
    and ( public.trein_is_equipe()
          or public.trein_pode_ver(((storage.foldername(name))[1])::uuid) )
  );
drop policy if exists trein_stor_write on storage.objects;
create policy trein_stor_write on storage.objects
  for insert with check ( bucket_id = 'treinamentos' and public.trein_is_equipe() );
drop policy if exists trein_stor_modify on storage.objects;
create policy trein_stor_modify on storage.objects
  for update using ( bucket_id = 'treinamentos' and public.trein_is_equipe() )
  with check ( bucket_id = 'treinamentos' and public.trein_is_equipe() );
drop policy if exists trein_stor_delete on storage.objects;
create policy trein_stor_delete on storage.objects
  for delete using ( bucket_id = 'treinamentos' and public.trein_is_equipe() );
