-- =====================================================================
--  FILA DE ASSINATURA DOS CERTIFICADOS
--
--  Rode DEPOIS do 37. Pode rodar mais de uma vez.
--
--  O que isto prepara
--  ------------------
--  O certificado passa a ter um PDF assinado com o e-CNPJ da clínica,
--  gerado sozinho, sem ninguém clicar. Este arquivo abre a fila: as
--  colunas que dizem em que pé está cada certificado, a função que
--  entrega UM certificado por vez a quem for assinar, e a que marca o
--  serviço como feito.
--
--  POR QUE UMA FILA, E NÃO SÓ UMA COLUNA "assinado"
--  ------------------------------------------------
--  Porque vai haver mais de um computador assinando. Dois SistemaCMH
--  abertos ao mesmo tempo, os dois procurando serviço, os dois achando o
--  mesmo certificado: o aluno receberia dois PDFs, cada um assinado uma
--  vez, e o segundo sobrescreveria o primeiro no meio do envio.
--
--  `for update skip locked` resolve isso dentro do banco, que é o único
--  lugar onde dá para resolver: o primeiro a chegar tranca a linha, e o
--  segundo PULA aquela e pega a próxima em vez de esperar. Nenhum
--  certificado é assinado duas vezes e nenhuma máquina fica parada.
--
--  E POR QUE A EQUIPE, E NÃO A CHAVE DE SERVIÇO
--  --------------------------------------------
--  O SistemaCMH vira .exe e é instalado em todo computador da clínica.
--  Chave de serviço dentro de um .exe é chave publicada: basta abrir o
--  arquivo com um editor. A equipe já pode ler qualquer certificado e
--  gravar no bucket, e isso basta para assinar. O programa assina com a
--  sessão de quem está logado nele, e o registro fica com o nome da
--  máquina, para depois se saber quem assinou o quê.
-- =====================================================================

alter table public.trein_certificado
  add column if not exists pdf_path      text,
  add column if not exists assinado_em   timestamptz,
  add column if not exists assinado_por  text,
  -- reserva: quem pegou o serviço e quando. Solta sozinha depois de 10
  -- minutos, senão um programa fechado no meio do caminho deixaria o
  -- certificado preso para sempre.
  add column if not exists reservado_em  timestamptz,
  add column if not exists reservado_por text;

create index if not exists idx_trein_cert_fila
  on public.trein_certificado (emitido_em)
  where pdf_path is null;

-- ---------------------------------------------------------------------
--  Pegar um serviço da fila
-- ---------------------------------------------------------------------
create or replace function public.trein_reservar_certificado(p_maquina text)
returns table (
  id uuid, codigo text, matricula_id uuid,
  nome text, cpf text, empresa text,
  curso_titulo text, carga_horaria int,
  emitido_em timestamptz, valido_ate date
)
language plpgsql volatile security definer set search_path = public as $$
declare
  v_id uuid;
begin
  if not public.trein_is_equipe() then
    raise exception 'SEM_PERMISSAO';
  end if;

  select c.id into v_id
    from public.trein_certificado c
   where c.pdf_path is null
     and (c.reservado_em is null
          or c.reservado_em < now() - interval '10 minutes')
   order by c.emitido_em
   -- `skip locked`: a segunda máquina não espera a primeira, pula para o
   -- próximo da fila. Sem isto, duas máquinas viram uma fila só.
   for update skip locked
   limit 1;

  if v_id is null then
    return;
  end if;

  update public.trein_certificado
     set reservado_em = now(), reservado_por = left(coalesce(p_maquina, '?'), 80)
   where public.trein_certificado.id = v_id;

  return query
    select c.id, c.codigo, c.matricula_id,
           c.nome, c.cpf, c.empresa,
           c.curso_titulo, c.carga_horaria,
           c.emitido_em, c.valido_ate
      from public.trein_certificado c
     where c.id = v_id;
end;
$$;
revoke execute on function public.trein_reservar_certificado(text) from public;
grant execute on function public.trein_reservar_certificado(text) to authenticated;

-- ---------------------------------------------------------------------
--  Dizer que ficou pronto
-- ---------------------------------------------------------------------
create or replace function public.trein_marcar_assinado(
  p_id uuid, p_path text, p_maquina text)
returns void
language plpgsql volatile security definer set search_path = public as $$
begin
  if not public.trein_is_equipe() then
    raise exception 'SEM_PERMISSAO';
  end if;
  update public.trein_certificado
     set pdf_path      = p_path,
         assinado_em   = now(),
         assinado_por  = left(coalesce(p_maquina, '?'), 80),
         reservado_em  = null,
         reservado_por = null
   where id = p_id;
end;
$$;
revoke execute on function public.trein_marcar_assinado(uuid, text, text) from public;
grant execute on function public.trein_marcar_assinado(uuid, text, text) to authenticated;

-- ---------------------------------------------------------------------
--  O PDF assinado no bucket privado
-- ---------------------------------------------------------------------
--  Fica em `certificados/<matricula>/<codigo>.pdf`. O aluno lê o dele, a
--  equipe lê todos. Ninguém sem login lê nenhum: a conferência pública é
--  feita pelo código, e não baixando o documento dos outros.
drop policy if exists trein_stor_read on storage.objects;
create policy trein_stor_read on storage.objects
  for select using (
    bucket_id = 'treinamentos'
    and (
      public.trein_is_equipe()

      or ( name like 'responsavel/%' and auth.uid() is not null )

      -- O certificado assinado: só o dono da matrícula. Vencido continua
      -- baixando o próprio documento, de propósito: o prazo encerra o
      -- acesso ao curso, não o direito ao papel do que já foi feito.
      or ( name like 'certificados/%'
           and exists (
             select 1 from public.trein_matricula m
              where m.aluno_id = auth.uid()
                and m.id::text = (storage.foldername(name))[2] ) )

      -- O material do curso: só com matrícula válida. O regex confere que
      -- a pasta tem cara de uuid ANTES de converter; sem isso o cast
      -- levanta exceção em vez de negar.
      or (
        (storage.foldername(name))[1] ~*
          '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
        and public.trein_pode_ver(((storage.foldername(name))[1])::uuid)
      )
    )
  );

-- =====================================================================
--  Confira
-- =====================================================================
-- (a) As cinco colunas novas.
select column_name
  from information_schema.columns
 where table_schema = 'public' and table_name = 'trein_certificado'
   and column_name in ('pdf_path','assinado_em','assinado_por',
                       'reservado_em','reservado_por')
 order by column_name;

-- (b) As duas funções da fila.
select proname
  from pg_proc p join pg_namespace n on n.oid = p.pronamespace
 where n.nspname = 'public'
   and proname in ('trein_reservar_certificado','trein_marcar_assinado')
 order by proname;

-- (c) Como está a fila hoje.
select count(*)                                    as certificados,
       count(*) filter (where pdf_path is not null) as ja_assinados,
       count(*) filter (where pdf_path is null)     as na_fila
  from public.trein_certificado;
