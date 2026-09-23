-- =====================================================================
--  HOMOLOGAÇÃO — cadastrar quem avalia atestado, sem mexer no cargo
--
--  Rode UMA VEZ no SQL Editor do Supabase, DEPOIS do 01. Pode rodar de
--  novo.
--
--  COMO ERA, E POR QUE NÃO DAVA
--  ----------------------------
--  Quem avalia atestado era, literalmente, "quem tem a categoria Diretor
--  médico no SistemaCMH". Funcionou enquanto era um médico só, e trava
--  em tudo que veio depois:
--
--  * para dar a homologação a um segundo médico era preciso mudar a
--    CATEGORIA dele para "Diretor médico" — e a categoria aparece no
--    rodapé dos PDF, na lista de usuários e em quem pode o quê noutros
--    módulos. Dar acesso a uma tela mudava o cargo da pessoa no sistema
--    inteiro;
--  * tirar o acesso pedia o caminho contrário, com o mesmo estrago;
--  * e não havia onde ver, numa tela só, quem hoje avalia atestado.
--
--  O QUE ESTE ARQUIVO FAZ
--  ----------------------
--  Cria uma lista própria — `homol_medico` — e faz o `homol_eh_medico`
--  aceitar os DOIS caminhos: quem está na lista, ou quem tem a categoria
--  "Diretor médico" de sempre.
--
--  OS DOIS, e não só a lista, de propósito: no dia em que este arquivo
--  rodar, a lista está vazia. Se ela passasse a mandar sozinha, o Dr.
--  Everaldo perderia a homologação no mesmo instante — e ninguém
--  avaliaria atestado até alguém perceber. Mantendo a categoria como
--  segundo caminho, nada muda para quem já entrava, e a lista só
--  acrescenta.
-- =====================================================================

create table if not exists public.homol_medico (
  -- o mesmo id do usuário no SistemaCMH: uma linha aqui é uma pessoa lá
  id          uuid primary key references public.orc_usuarios(id) on delete cascade,
  nome        text not null,
  -- a assinatura que vai no parecer. Guardada aqui porque o cadastro do
  -- usuário pode não ter registro (quem é médico noutro conselho, quem
  -- mudou de CRM de estado), e o parecer não pode sair sem.
  registro    text,
  ativo       boolean not null default true,
  criado_em   timestamptz not null default now(),
  criado_por  text
);
alter table public.homol_medico enable row level security;

-- VER: a equipe da clínica que tem a Homologação liberada. O RH da
-- empresa não tem o que fazer com esta lista.
drop policy if exists homol_medico_ler on public.homol_medico;
create policy homol_medico_ler on public.homol_medico
  for select using (public.homol_is_equipe());

-- MEXER: a mesma equipe. Quem pode gerar o login do RH pode dizer quem
-- avalia o atestado — é a mesma pessoa, na mesma tela.
drop policy if exists homol_medico_mexer on public.homol_medico;
create policy homol_medico_mexer on public.homol_medico
  for all using (public.homol_is_equipe()) with check (public.homol_is_equipe());

grant select, insert, update, delete on public.homol_medico to authenticated;


-- ---------------------------------------------------------------------
--  O MÉDICO PASSA A SER "ESTÁ NA LISTA *OU* TEM A CATEGORIA"
--
--  A função vem inteira, como manda a casa. O que muda é o `or`.
-- ---------------------------------------------------------------------
create or replace function public.homol_eh_medico()
returns boolean
language sql stable security definer set search_path = public as $$
  select exists (
    select 1 from public.orc_usuarios u
     where u.id = auth.uid()
       and u.ativo
       and (
         -- 1. cadastrado na lista da homologação (o caminho novo)
         exists (select 1 from public.homol_medico m
                  where m.id = u.id and m.ativo)
         -- 2. ou a categoria de sempre, que continua valendo
         or translate(lower(coalesce(u.cargo, '')), 'é', 'e') = 'diretor medico'
       ));
$$;

-- O nome e o registro que saem no parecer: a lista ganha da categoria
-- quando a pessoa está nos dois, porque é nela que se escreve o registro
-- certo para assinar.
create or replace function public.homol_quem_sou()
returns table (papel text, nome text, empresa_cnpj text, empresa_nome text, registro text)
language sql stable security definer set search_path = public as $$
  select 'medico', u.nome, null::text, null::text,
         coalesce(
           (select nullif(btrim(m.registro), '') from public.homol_medico m
             where m.id = u.id and m.ativo),
           nullif(concat_ws(' ', u.profissao, u.registro), ''))
    from public.orc_usuarios u
   where u.id = auth.uid() and public.homol_eh_medico()
  union all
  select 'rh', c.nome, c.empresa_cnpj, c.empresa_nome, null
    from public.homol_eu() c
   where c.id is not null
   limit 1;
$$;
revoke execute on function public.homol_quem_sou() from public;
grant execute on function public.homol_quem_sou() to authenticated;
revoke execute on function public.homol_eh_medico() from public;
grant execute on function public.homol_eh_medico() to authenticated;


-- ---------------------------------------------------------- conferência
--  1. a tabela existe e está protegida
select relname, relrowsecurity as rls_ligada
  from pg_class where relname = 'homol_medico';

--  2. a função aceita os dois caminhos
select proname,
       (prosrc like '%homol_medico%')   as olha_a_lista,
       (prosrc like '%diretor medico%') as mantem_a_categoria
  from pg_proc where proname = 'homol_eh_medico';

--  3. quem avalia atestado hoje, pelos dois caminhos
select u.nome, u.cargo,
       (m.id is not null and m.ativo) as na_lista,
       (translate(lower(coalesce(u.cargo, '')), 'é', 'e') = 'diretor medico') as pela_categoria
  from public.orc_usuarios u
  left join public.homol_medico m on m.id = u.id
 where u.ativo
   and (m.id is not null
        or translate(lower(coalesce(u.cargo, '')), 'é', 'e') = 'diretor medico')
 order by u.nome;
