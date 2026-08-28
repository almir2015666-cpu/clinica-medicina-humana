-- =====================================================================
--  CONFERIR AGORA
--
--  Cole no SQL Editor e rode. Nao muda nada, so olha. Pode rodar quantas
--  vezes quiser, a qualquer hora.
--
--  Existe porque de fora do banco quase nada e visivel: com a chave
--  publica do site, `trein_aula` e `trein_questao` respondem ZERO, e nao
--  porque estejam vazias, mas porque a RLS nao devolve linha para quem
--  nao tem matricula. Medir por fora daria um retrato falso.
-- =====================================================================

with tudo as (

  select 1 as ordem, 'CATALOGO' as parte,
         'cursos na vitrine' as item,
         (select count(*) from public.trein_curso where ativo)::text as agora,
         '19' as esperado,
         (select count(*) from public.trein_curso where ativo) = 19 as ok

  union all select 2, 'CATALOGO', 'cursos com apostila',
    (select count(*) from public.trein_curso
      where ativo and coalesce(length(apostila), 0) > 400)::text,
    '19',
    (select count(*) from public.trein_curso
      where ativo and coalesce(length(apostila), 0) > 400) = 19

  union all select 3, 'CATALOGO', 'apostilas aprofundadas (acima de 8 mil letras)',
    (select count(*) from public.trein_curso
      where ativo and coalesce(length(apostila), 0) > 8000)::text,
    '19 no fim',
    (select count(*) from public.trein_curso
      where ativo and coalesce(length(apostila), 0) > 8000) = 19

  union all select 4, 'CATALOGO', 'cursos com conteudo programatico',
    (select count(*) from public.trein_curso
      where ativo and coalesce(length(conteudo_programatico), 0) > 50)::text,
    '19',
    (select count(*) from public.trein_curso
      where ativo and coalesce(length(conteudo_programatico), 0) > 50) = 19

  union all select 5, 'PROVA', 'questoes no banco',
    (select count(*) from public.trein_questao)::text,
    'pelo menos 2.500',
    (select count(*) from public.trein_questao) >= 2500

  union all select 6, 'PROVA', 'cursos com menos questoes do que a prova sorteia',
    (select count(*) from public.trein_curso c
      where c.ativo
        and (select count(*) from public.trein_questao q
              where q.curso_id = c.id) < coalesce(c.questoes_por_prova, 10))::text,
    '0',
    (select count(*) from public.trein_curso c
      where c.ativo
        and (select count(*) from public.trein_questao q
              where q.curso_id = c.id) < coalesce(c.questoes_por_prova, 10)) = 0

  union all select 7, 'PROVA', 'questoes com gabarito fora da faixa',
    (select count(*) from public.trein_questao
      where correta < 0
         or correta >= coalesce(jsonb_array_length(alternativas), 0))::text,
    '0',
    (select count(*) from public.trein_questao
      where correta < 0
         or correta >= coalesce(jsonb_array_length(alternativas), 0)) = 0

  union all select 8, 'AULAS', 'aulas com video publicadas',
    (select count(*) from public.trein_aula)::text,
    'pelo menos 1 por curso',
    (select count(*) from public.trein_aula) > 0

  union all select 9, 'AULAS', 'cursos SEM nenhuma aula',
    (select count(*) from public.trein_curso c
      where c.ativo and not exists
        (select 1 from public.trein_aula a where a.curso_id = c.id))::text,
    '0',
    (select count(*) from public.trein_curso c
      where c.ativo and not exists
        (select 1 from public.trein_aula a where a.curso_id = c.id)) = 0

  union all select 10, 'SEGURANCA', 'apostila fechada para quem nao tem login',
    (not has_column_privilege('anon','public.trein_curso',
                              'apostila','select'))::text,
    'true',
    not has_column_privilege('anon','public.trein_curso','apostila','select')

  union all select 11, 'SEGURANCA', 'titulo aberto (a vitrine depende dele)',
    has_column_privilege('anon','public.trein_curso','titulo','select')::text,
    'true',
    has_column_privilege('anon','public.trein_curso','titulo','select')

  union all select 12, 'SEGURANCA', 'porta da apostila do aluno',
    (select count(*) from pg_proc p join pg_namespace n on n.oid=p.pronamespace
      where n.nspname='public' and p.proname='trein_apostila')::text,
    '1',
    (select count(*) from pg_proc p join pg_namespace n on n.oid=p.pronamespace
      where n.nspname='public' and p.proname='trein_apostila') = 1

  union all select 13, 'SEGURANCA', 'bucket libera a assinatura para quem tem login',
    (select coalesce(bool_or(qual like '%responsavel%'), false)
       from pg_policies where schemaname='storage' and tablename='objects'
         and policyname='trein_stor_read')::text,
    'true',
    (select coalesce(bool_or(qual like '%responsavel%'), false)
       from pg_policies where schemaname='storage' and tablename='objects'
         and policyname='trein_stor_read')

  union all select 14, 'MOVIMENTO', 'cupons gerados',
    (select count(*) from public.trein_cupom)::text, '(informativo)', true

  union all select 15, 'MOVIMENTO', 'alunos cadastrados',
    (select count(*) from public.trein_aluno)::text, '(informativo)', true

  union all select 16, 'MOVIMENTO', 'matriculas ativas hoje',
    (select count(*) from public.trein_matricula
      where not cancelada and expira_em >= current_date)::text,
    '(informativo)', true

  union all select 17, 'MOVIMENTO', 'certificados emitidos',
    (select count(*) from public.trein_certificado)::text, '(informativo)', true
)
select parte, item, agora, esperado,
       case when esperado = '(informativo)' then '.'
            when ok then 'ok' else 'FALTA' end as situacao
  from tudo order by ordem;


-- =====================================================================
--  E, se algum curso estiver sem aula, quais sao
-- =====================================================================
select c.codigo, c.titulo, c.carga_horaria,
       (select count(*) from public.trein_aula a where a.curso_id = c.id) as aulas,
       (select count(*) from public.trein_questao q where q.curso_id = c.id) as questoes,
       coalesce(length(c.apostila), 0) as letras_da_apostila
  from public.trein_curso c
 where c.ativo
 order by aulas, c.ordem;
