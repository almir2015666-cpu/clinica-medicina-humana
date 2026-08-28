-- =====================================================================
--  A APOSTILA DEIXA DE SER PÚBLICA
--
--  Rode no SQL Editor DEPOIS do 29 e dos arquivos de conteúdo (30, 31,
--  32). Pode rodar mais de uma vez.
--
--  O QUE ESTAVA ERRADO
--  -------------------
--  A política `trein_curso_publico` devolve o curso para quem não está
--  logado — e tem de devolver mesmo: é ela que faz a vitrine listar os
--  cursos à venda. Mas RLS é linha, não coluna: ao acrescentar `apostila`
--  na mesma tabela, o material de estudo passou a sair junto.
--
--  Medido: com a chave pública do site, sem login nenhum,
--      GET /rest/v1/trein_curso?select=codigo,apostila
--  devolvia as apostilas inteiras. É o material que a clínica vende, de
--  graça, para quem souber montar um endereço.
--
--  A PÁGINA exigia matrícula. A API não. Tela que fecha a porta enquanto o
--  servidor deixa a janela aberta não fecha nada.
--
--  COMO FICA
--  ---------
--  Ninguém lê a coluna direto — nem anônimo, nem aluno logado. Quem quiser
--  a apostila passa pela função abaixo, que confere de quem é a matrícula
--  antes de devolver o texto.
--
--  Por que uma função, e não outra tabela: a tabela resolveria também, mas
--  custaria mover o conteúdo, reescrever os arquivos 30/31/32 e mexer no
--  admin. A função dá a mesma garantia e cabe num arquivo.
-- =====================================================================

-- 1. Tira a coluna do alcance de todo mundo.
--    `revoke ... (coluna)` é privilégio de COLUNA, coisa do Postgres, e o
--    PostgREST respeita: pedir `select=apostila` passa a dar erro em vez
--    de devolver o texto. As outras colunas continuam como estavam, então
--    a vitrine não sente nada.
revoke select (apostila) on public.trein_curso from anon, authenticated;

-- 2. A porta certa: devolve a apostila de UMA matrícula, conferindo dono.
--
--    `security definer` para poder ler a coluna que acabou de ser fechada;
--    a conferência de quem pode está aqui dentro, explícita.
create or replace function public.trein_apostila(p_matricula uuid)
returns table (codigo text, titulo text, carga_horaria int, apostila text)
language plpgsql stable security definer set search_path = public as $$
declare
  v_mat public.trein_matricula%rowtype;
begin
  select * into v_mat from public.trein_matricula where id = p_matricula;

  -- `is distinct from` e não `<>`: sem login `auth.uid()` é NULL, e em SQL
  -- `x <> NULL` não é falso, é NULL — a comparação simplesmente não
  -- barraria ninguém. Foi assim que a emissão de certificado ficou aberta
  -- por um tempo, e o erro não se repete aqui.
  if not found or v_mat.aluno_id is distinct from auth.uid() then
    raise exception 'MATRICULA_INVALIDA';
  end if;
  if v_mat.cancelada then
    raise exception 'MATRICULA_CANCELADA';
  end if;

  -- Vencido continua lendo, de propósito. A apostila é material de estudo,
  -- não é o acesso ao curso: quem já pagou e terminou pode consultar
  -- depois, e negar isso não protege nada — ele já leu tudo.
  return query
    select c.codigo, c.titulo, c.carga_horaria, c.apostila
      from public.trein_curso c
     where c.id = v_mat.curso_id;
end;
$$;
revoke execute on function public.trein_apostila(uuid) from public;
grant execute on function public.trein_apostila(uuid) to authenticated;

-- 3. E a porta da equipe, para o admin poder editar e ver a amostra.
create or replace function public.trein_apostila_curso(p_curso uuid)
returns table (codigo text, titulo text, carga_horaria int, apostila text)
language plpgsql stable security definer set search_path = public as $$
begin
  if not public.trein_is_equipe() then
    raise exception 'SEM_PERMISSAO';
  end if;
  return query
    select c.codigo, c.titulo, c.carga_horaria, c.apostila
      from public.trein_curso c
     where c.id = p_curso;
end;
$$;
revoke execute on function public.trein_apostila_curso(uuid) from public;
grant execute on function public.trein_apostila_curso(uuid) to authenticated;

-- =====================================================================
--  Confira
-- =====================================================================
-- (a) A coluna saiu do alcance de anon e authenticated. Os dois têm de
--     aparecer com `false`.
select r.rolname,
       has_column_privilege(r.rolname, 'public.trein_curso', 'apostila',
                            'select') as le_a_apostila,
       has_column_privilege(r.rolname, 'public.trein_curso', 'titulo',
                            'select') as le_o_titulo
  from pg_roles r
 where r.rolname in ('anon', 'authenticated');

-- (b) E o catálogo continua sendo lido normalmente (a vitrine depende
--     disto). Tem de listar os 19.
select count(*) as cursos_na_vitrine from public.trein_curso where ativo;
