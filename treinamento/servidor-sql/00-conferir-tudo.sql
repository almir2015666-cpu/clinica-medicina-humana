-- =====================================================================
--  CONFERIR TUDO — o que já foi feito e o que falta
--
--  Cole no SQL Editor e rode. Não muda nada: só olha.
--
--  Existe porque de fora do banco não dá para ver quase nada — a RLS
--  esconde as questões, o progresso e os alunos até de quem escreveu o
--  sistema. Esta consulta roda DENTRO, com os seus poderes, e responde
--  numa tela só o que exigiria abrir seis lugares diferentes.
--
--  Leia a coluna `situacao`: onde estiver FALTA, há trabalho a fazer.
-- =====================================================================

select * from (

  -- ---- as tabelas e colunas que cada arquivo cria ------------------
  select 1 as ordem, 'SQL 14 · sorteio da prova' as item,
         case when exists (select 1 from information_schema.tables
                            where table_schema = 'public'
                              and table_name = 'trein_sorteio')
              then 'OK' else 'FALTA rodar o 14' end as situacao,
         '' as detalhe
  union all
  select 2, 'SQL 20 · retrato no certificado',
         case when exists (select 1 from information_schema.columns
                            where table_schema = 'public'
                              and table_name = 'trein_certificado'
                              and column_name = 'curso_titulo')
              then 'OK' else 'FALTA rodar o 20' end, ''
  union all
  select 3, 'SQL 20 · trava do vídeo no banco',
         case when exists (select 1 from pg_trigger
                            where tgrelid = 'public.trein_progresso'::regclass
                              and tgname = 'trein_progresso_confere_tg')
              then 'OK' else 'FALTA rodar o 20' end, ''
  union all
  select 4, 'SQL 20 · aluno não reescreve o próprio nome',
         case when not exists (select 1 from pg_policies
                                where schemaname = 'public'
                                  and tablename = 'trein_aluno'
                                  and policyname = 'trein_aluno_upd')
              then 'OK' else 'FALTA rodar o 20' end, ''
  union all
  -- o 19 troca a função; se ela ainda cita `admins`, não foi rodado
  select 5, 'SQL 19 · só quem tem o módulo Treinamentos',
         case when position('admins' in
                   coalesce(pg_get_functiondef('public.trein_is_equipe()'::regprocedure), '')) = 0
              then 'OK' else 'FALTA rodar o 19' end, ''
  union all
  select 6, 'SQL 13 · ordem dos cursos',
         case when (select max(ordem) from public.trein_curso where ativo) <= 19
              then 'OK' else 'FALTA rodar o 13 de novo' end,
         'maior ordem: ' || (select max(ordem)::text from public.trein_curso where ativo)

  -- ---- conteúdo ----------------------------------------------------
  union all
  select 10, 'Cursos ativos no catálogo', 'OK',
         (select count(*)::text from public.trein_curso where ativo)
  union all
  select 11, 'Questões no banco (todos os cursos)',
         case when (select count(*) from public.trein_questao) >= 760
              then 'OK' else 'FALTA rodar 12 e 15 a 18' end,
         (select count(*)::text from public.trein_questao)
  union all
  select 12, 'Cursos SEM prova nenhuma',
         case when exists (select 1 from public.trein_curso c
                            where c.ativo and not exists
                              (select 1 from public.trein_questao q
                                where q.curso_id = c.id))
              then 'FALTA — o aluno assiste tudo e trava' else 'OK' end,
         coalesce((select string_agg(c.codigo, ', ' order by c.ordem)
                     from public.trein_curso c
                    where c.ativo and not exists
                      (select 1 from public.trein_questao q
                        where q.curso_id = c.id)), 'nenhum')
  union all
  select 13, 'Aulas (vídeos) publicadas',
         case when (select count(*) from public.trein_aula) > 0
              then 'OK' else 'FALTA subir os vídeos pelo admin' end,
         (select count(*)::text from public.trein_aula)
  union all
  select 14, 'Cursos SEM aula nenhuma',
         case when exists (select 1 from public.trein_curso c
                            where c.ativo and not exists
                              (select 1 from public.trein_aula a
                                where a.curso_id = c.id))
              then 'FALTA subir vídeo' else 'OK' end,
         (select count(*)::text from public.trein_curso c
           where c.ativo and not exists
             (select 1 from public.trein_aula a where a.curso_id = c.id))
         || ' de ' || (select count(*)::text from public.trein_curso where ativo)

  -- ---- quem administra ---------------------------------------------
  union all
  select 20, 'Pessoas que administram o treinamento', 'informativo',
         coalesce((select string_agg(u.usuario, ', ' order by u.usuario)
                     from public.orc_usuarios u
                    where u.ativo
                      and (u.admin or 'treinamento' = any(u.modulos))),
                  'NINGUÉM — ninguém consegue subir vídeo')

  -- ---- operação ----------------------------------------------------
  union all
  select 30, 'Cupons ativos', 'informativo',
         (select count(*)::text from public.trein_cupom where ativo)
  union all
  select 31, 'Alunos cadastrados', 'informativo',
         (select count(*)::text from public.trein_aluno)
  union all
  select 32, 'Certificados emitidos', 'informativo',
         (select count(*)::text from public.trein_certificado)
) t
order by ordem;


-- =====================================================================
--  Detalhe: quantas questões cada curso tem, e a folga do sorteio
--
--  `folga` é quantas questões sobram além das que a prova sorteia.
--  Folga pequena significa provas parecidas entre colegas — que é
--  exatamente o que o banco grande existe para evitar.
-- =====================================================================
select c.ordem, c.codigo, c.titulo,
       c.carga_horaria                              as horas,
       count(q.id)                                  as questoes,
       coalesce(c.questoes_por_prova, 10)           as sorteia,
       count(q.id) - coalesce(c.questoes_por_prova, 10) as folga,
       count(distinct a.id)                         as aulas
  from public.trein_curso c
  left join public.trein_questao q on q.curso_id = c.id
  left join public.trein_aula a    on a.curso_id = c.id
 where c.ativo
 group by c.id
 order by questoes, c.ordem;
