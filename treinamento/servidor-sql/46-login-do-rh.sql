-- =====================================================================
--  LOGIN PRÓPRIO PARA O RH DA EMPRESA CLIENTE
--
--  Rode DEPOIS do 45. Pode rodar mais de uma vez.
--
--  POR QUE TROCAR O CÓDIGO POR LOGIN
--  O painel nasceu abrindo com o código do cupom, porque era o que o RH
--  já tinha na mão. Funciona, mas o código circula: ele vai por e-mail
--  para a empresa inteira, é colado em grupo, é repassado ao encarregado.
--  Quem recebe de segunda mão passa a ver a lista de gente da empresa.
--
--  Com login, o acesso é nominal e revogável: dá para saber quem entrou,
--  e dá para tirar o acesso de quem saiu da empresa sem trocar o código
--  de todo mundo.
--
--  E resolve uma limitação que o código tinha: o cupom é de uma compra,
--  e a empresa faz várias ao longo do ano. Pelo código, o RH via só a
--  turma daquela compra. Pelo login, ele vê TUDO da empresa dele, porque
--  o vínculo passa a ser o CNPJ.
-- =====================================================================

create table if not exists public.trein_rh (
  -- o mesmo id do usuário no Auth: uma linha aqui é uma conta lá
  id            uuid primary key references auth.users(id) on delete cascade,
  nome          text not null,
  email         text not null,
  -- Só os dígitos. CNPJ digitado com ponto num lugar e sem ponto no
  -- outro é o jeito mais fácil de o RH não enxergar a própria empresa.
  empresa_cnpj  text not null,
  empresa_nome  text,
  ativo         boolean not null default true,
  criado_por    text,
  criado_em     timestamptz not null default now(),
  ultimo_acesso timestamptz
);

create index if not exists idx_trein_rh_cnpj on public.trein_rh (empresa_cnpj);

alter table public.trein_rh enable row level security;

-- O RH lê a própria linha, e só ela: é assim que a tela sabe o nome da
-- empresa dele. Ninguém lista os outros.
drop policy if exists trein_rh_self on public.trein_rh;
create policy trein_rh_self on public.trein_rh
  for select using (id = auth.uid());

-- A equipe da clínica administra.
drop policy if exists trein_rh_equipe on public.trein_rh;
create policy trein_rh_equipe on public.trein_rh
  for all using (public.trein_is_equipe()) with check (public.trein_is_equipe());

-- ---------------------------------------------------------------------
--  A turma da empresa de quem está logado
-- ---------------------------------------------------------------------
--  Não recebe parâmetro nenhum, de propósito: quem decide qual empresa
--  vai ser mostrada é o login, e não algo que o navegador manda. Sem
--  parâmetro não existe "e se eu pedir a empresa do vizinho".
create or replace function public.trein_minha_turma()
returns table (
  empresa        text,
  cupom          text,
  aluno          text,
  cpf_masc       text,
  curso          text,
  codigo_curso   text,
  carga_horaria  int,
  situacao       text,
  aulas_feitas   int,
  aulas_total    int,
  expira_em      date,
  certificado    text,
  emitido_em     date
)
language plpgsql stable security definer set search_path = public as $$
declare
  v_rh public.trein_rh%rowtype;
begin
  select * into v_rh from public.trein_rh where id = auth.uid();
  if not found or not v_rh.ativo then
    raise exception 'SEM_ACESSO';
  end if;

  return query
  select
    coalesce(v_rh.empresa_nome, cu.empresa),
    cu.codigo,
    al.nome,
    case when length(regexp_replace(al.cpf, '\D', '', 'g')) = 11
         then substr(regexp_replace(al.cpf, '\D', '', 'g'), 1, 3)
              || '.***.***-'
              || substr(regexp_replace(al.cpf, '\D', '', 'g'), 10, 2)
         else '***' end,
    c.titulo,
    c.codigo,
    c.carga_horaria,
    case
      when ce.id is not null and m.expira_em < current_date then 'Aprovado, vencido'
      when ce.id is not null                                then 'Aprovado'
      when m.cancelada                                      then 'Cancelado'
      when m.expira_em < current_date                       then 'Prazo vencido'
      when coalesce(feitas.q, 0) = 0                        then 'Não começou'
      when coalesce(feitas.q, 0) >= coalesce(tot.q, 0)
       and coalesce(tot.q, 0) > 0                           then 'Aulas concluídas, falta a prova'
      else 'Em andamento'
    end,
    coalesce(feitas.q, 0)::int,
    coalesce(tot.q, 0)::int,
    m.expira_em,
    ce.codigo,
    ce.emitido_em::date
  from public.trein_cupom cu
  join public.trein_matricula m on m.cupom_id = cu.id
  join public.trein_aluno al on al.id = m.aluno_id
  join public.trein_curso c on c.id = m.curso_id
  left join public.trein_certificado ce on ce.matricula_id = m.id
  left join lateral (
    select count(*) as q from public.trein_aula a where a.curso_id = c.id
  ) tot on true
  left join lateral (
    select count(*) as q from public.trein_progresso p
     where p.matricula_id = m.id and p.concluida
  ) feitas on true
  -- O vínculo é o CNPJ, e não o cupom: a empresa compra várias vezes ao
  -- longo do ano, e o RH precisa ver tudo, e não só a última compra.
  where regexp_replace(coalesce(cu.empresa_cnpj, ''), '\D', '', 'g')
      = v_rh.empresa_cnpj
  order by al.nome, c.ordem;
end;
$$;
revoke execute on function public.trein_minha_turma() from public;
grant execute on function public.trein_minha_turma() to authenticated;

-- ---------------------------------------------------------------------
--  Marcar que ele entrou
-- ---------------------------------------------------------------------
create or replace function public.trein_rh_entrou()
returns void
language plpgsql volatile security definer set search_path = public as $$
begin
  update public.trein_rh set ultimo_acesso = now() where id = auth.uid();
end;
$$;
revoke execute on function public.trein_rh_entrou() from public;
grant execute on function public.trein_rh_entrou() to authenticated;

-- =====================================================================
--  Confira
-- =====================================================================
select 'tabela' as o_que,
       (select count(*) from information_schema.tables
         where table_schema='public' and table_name='trein_rh')::text as achei,
       '1' as esperado
union all
select 'politicas da tabela',
       (select count(*)::text from pg_policies
         where schemaname='public' and tablename='trein_rh'), '2'
union all
select 'funcao da turma',
       (select count(*)::text from pg_proc p
          join pg_namespace n on n.oid=p.pronamespace
         where n.nspname='public' and p.proname='trein_minha_turma'), '1'
union all
select 'anon NAO executa a funcao',
       (select (not has_function_privilege('anon', p.oid, 'execute'))::text
          from pg_proc p join pg_namespace n on n.oid=p.pronamespace
         where n.nspname='public' and p.proname='trein_minha_turma'), 'true';
