-- =====================================================================
--  LIMPAR AS QUESTÕES ÓRFÃS DO NR-35 DESATIVADO
--
--  Rode no SQL Editor. Pode rodar mais de uma vez.
--
--  O QUE ACONTECEU
--  ---------------
--  O 07-nr35-somente-reciclagem.sql DESATIVOU o curso 'NR-35' em vez de
--  apagá-lo — de propósito, para o histórico sobreviver — e criou o
--  'NR-35-REC' no lugar. Depois disso, a primeira versão do
--  12-provas-demais-cursos.sql ainda escrevia no código antigo, 'NR-35',
--  e gravou 10 questões num curso que ninguém pode cursar.
--
--  Elas não fazem mal hoje: curso inativo não aparece na vitrine e não
--  aceita matrícula. Mas atrapalham de duas formas:
--
--    1. A contagem mente. `count(distinct curso_id)` na trein_questao dá
--       20 num catálogo de 19, e quem for conferir vai procurar um erro
--       que não existe.
--    2. Se um dia alguém reativar o NR-35 sem olhar, ele nasce com uma
--       prova de 10 questões enquanto todo o resto tem 150 — e aí duas
--       pessoas do mesmo turno recebem a mesma prova, que é exatamente o
--       problema que o banco grande veio resolver.
--
--  O curso em si FICA. Ele é o registro de por que existe um NR-35-REC, e
--  apagá-lo levaria junto, por cascata, qualquer matrícula histórica.
-- =====================================================================

-- ANTES: veja o que vai ser apagado, e confirme que ninguém está
-- matriculado nesse curso. Se a segunda consulta trouxer alguma linha,
-- PARE e me avise: aí não é lixo, é gente.
select c.codigo, c.titulo, c.ativo, count(q.id) as questoes
  from public.trein_curso c
  left join public.trein_questao q on q.curso_id = c.id
 where not c.ativo
 group by c.id;

select m.id, m.aluno_id, m.expira_em, m.cancelada
  from public.trein_matricula m
  join public.trein_curso c on c.id = m.curso_id
 where not c.ativo;

-- A limpeza: apaga só as questões de curso INATIVO.
-- Escrito assim, e não com `codigo = 'NR-35'`, porque o problema não é
-- daquele curso: é de qualquer curso que sair do catálogo e deixar prova
-- para trás.
delete from public.trein_questao q
 using public.trein_curso c
 where c.id = q.curso_id
   and not c.ativo;

-- =====================================================================
--  Confira
-- =====================================================================
-- Tem de dar 2850 questões em 19 cursos.
select count(*) as total_questoes,
       count(distinct curso_id) as cursos_com_prova
  from public.trein_questao;

-- E o quadro por curso: 150 em todos, e a coluna `aulas` mostrando o que
-- ainda falta subir.
select c.ordem, c.codigo, c.titulo,
       c.carga_horaria                                    as horas,
       count(distinct q.id)                               as questoes,
       coalesce(c.questoes_por_prova, 10)                 as sorteia,
       count(distinct a.id)                               as aulas
  from public.trein_curso c
  left join public.trein_questao q on q.curso_id = c.id
  left join public.trein_aula    a on a.curso_id = c.id
 where c.ativo
 group by c.id
 order by c.ordem;
