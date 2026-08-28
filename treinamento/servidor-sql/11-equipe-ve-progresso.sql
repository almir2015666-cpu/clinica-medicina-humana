-- =====================================================================
--  A equipe passa a enxergar o progresso das aulas
--
--  Rode no SQL Editor. Pode rodar mais de uma vez.
--
--  POR QUE ISTO EXISTE
--  No 01-esquema.sql, todas as tabelas ganharam uma política para a equipe
--  (`trein_is_equipe()`) — todas menos a `trein_progresso`, que ficou só
--  com as três políticas do aluno. Passou despercebido porque nada lia
--  essa tabela de fora até agora.
--
--  Agora lê: a tela "Acompanhar alunos" do SistemaCMH e o painel do
--  cliente precisam saber em que aula cada pessoa está. Sem esta política,
--  a RLS não dá erro nenhum — ela simplesmente devolve zero linhas, e a
--  tela mostraria "0 de 4" para quem já assistiu tudo. Erro calado é pior
--  do que erro barulhento, porque vira resposta errada ao cliente.
--
--  É SELECT e mais nada: quem marca aula como assistida é o aluno, no
--  navegador, e continua sendo só ele. A equipe olha, não escreve.
-- =====================================================================

drop policy if exists trein_prog_equipe on public.trein_progresso;
create policy trein_prog_equipe on public.trein_progresso
  for select using (public.trein_is_equipe());

-- Confira: a trein_progresso tem de aparecer aqui embaixo com uma política
-- de select para a equipe, como as outras.
select tablename, policyname, cmd
  from pg_policies
 where schemaname = 'public'
   and tablename like 'trein_%'
   and policyname like '%equipe%'
 order by tablename;
