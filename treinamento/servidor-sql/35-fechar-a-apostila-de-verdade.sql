-- =====================================================================
--  FECHAR A APOSTILA DE VERDADE
--
--  Rode DEPOIS do 33. Pode rodar mais de uma vez.
--
--  O 33 NÃO FUNCIONOU, E O ERRO É MEU
--  ----------------------------------
--  O 33 fez isto:
--
--      revoke select (apostila) on public.trein_curso from anon, ...;
--
--  e não mudou nada. Medido hoje, depois de o arquivo ter rodado: um
--  `GET /rest/v1/trein_curso?select=codigo,apostila`, com a chave pública
--  do site e sem login nenhum, devolveu a apostila inteira, 7.429
--  caracteres.
--
--  O motivo é uma regra do Postgres que eu não respeitei: privilégio de
--  TABELA e privilégio de COLUNA são duas coisas separadas, e revogar um
--  não mexe no outro. O Supabase já entrega o projeto com
--
--      grant all on all tables in schema public to anon, authenticated;
--
--  ou seja, com SELECT na TABELA inteira. Revogar a coluna procurou uma
--  permissão de coluna que nunca existiu, não encontrou nada, e saiu sem
--  erro. O SELECT da tabela continuou lá, valendo para todas as colunas
--  — inclusive a apostila.
--
--  Pior: a conferência que eu escrevi no próprio 33 respondia `false`
--  para `has_column_privilege`, porque o privilégio de coluna realmente
--  não existe. A conferência dizia "fechado" enquanto a porta estava
--  aberta. Uma conferência que só pergunta o que o comando fez, e não o
--  que o mundo lá fora enxerga, não confere nada. A daqui embaixo
--  pergunta pelo resultado.
--
--  O JEITO CERTO
--  -------------
--  Tirar o SELECT da tabela e devolver, uma por uma, as colunas que podem
--  sair. A apostila fica de fora da lista — e é a ausência dela na lista,
--  não um `revoke`, que fecha a porta.
-- =====================================================================

do $$
declare
  v_colunas text;
begin
  -- A lista é montada na hora, a partir do catálogo: assim uma coluna nova
  -- criada amanhã entra sozinha e ninguém precisa lembrar deste arquivo.
  -- A apostila é a única exceção, escrita aqui de propósito.
  select string_agg(quote_ident(column_name), ', ' order by ordinal_position)
    into v_colunas
    from information_schema.columns
   where table_schema = 'public'
     and table_name   = 'trein_curso'
     and column_name <> 'apostila';

  execute 'revoke select on public.trein_curso from anon, authenticated';
  execute format('grant select (%s) on public.trein_curso to anon, authenticated',
                 v_colunas);
end $$;

-- =====================================================================
--  Confira
-- =====================================================================
-- (a) O que cada papel enxerga AGORA. `le_a_apostila` tem de vir `false`
--     nos dois, e `le_o_titulo` `true` nos dois — é o título que a vitrine
--     usa, e sem ele a lista de cursos some do site.
select r.rolname as papel,
       has_column_privilege(r.rolname, 'public.trein_curso', 'apostila',
                            'select') as le_a_apostila,
       has_column_privilege(r.rolname, 'public.trein_curso', 'titulo',
                            'select') as le_o_titulo,
       has_table_privilege(r.rolname, 'public.trein_curso',
                           'select')  as select_na_tabela_inteira
  from pg_roles r
 where r.rolname in ('anon', 'authenticated');

-- (b) Quantas colunas cada papel pode ler. Tem de ser TODAS menos uma.
select r.rolname as papel,
       count(*) filter (
         where has_column_privilege(r.rolname, 'public.trein_curso',
                                    c.column_name, 'select')) as pode_ler,
       count(*) as existem
  from pg_roles r
 cross join information_schema.columns c
 where r.rolname in ('anon', 'authenticated')
   and c.table_schema = 'public' and c.table_name = 'trein_curso'
 group by r.rolname;

-- (c) E a vitrine continua de pé: 19.
select count(*) as cursos_na_vitrine from public.trein_curso where ativo;
