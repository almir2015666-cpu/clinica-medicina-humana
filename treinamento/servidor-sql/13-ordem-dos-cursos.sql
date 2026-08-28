-- =====================================================================
--  A ordem em que os cursos aparecem
--
--  Rode no SQL Editor. Pode rodar mais de uma vez.
--
--  POR QUE ESTE ARQUIVO EXISTE
--  A `ordem` foi sendo preenchida na mão, na sequência em que cada curso
--  entrou: os treze do 02-cursos.sql ficaram de 1 a 13, e os seis do
--  09-cursos-novos.sql foram para o fim. Isso deixou o NR-26 depois da
--  Brigada e o NR-01 — que é a integração, o primeiro curso que alguém
--  faz — na décima quarta posição. Quem procura na lista não acha.
--
--  A REGRA, agora escrita num lugar só:
--    1. Primeiro as NR, em ordem NUMÉRICA (NR-01, NR-05, ... NR-35).
--       Numérica e não alfabética: em texto puro, "NR-10" vem antes de
--       "NR-05", que é exatamente o embaralhado que se quer evitar.
--    2. Depois os cursos sem número, em ordem ALFABÉTICA
--       (BRIG, DD, DD-REC, LOTO).
--
--  Variações do mesmo número ficam juntas e na ordem que faz sentido:
--  NR-01-INT4 antes do NR-01-INT8 (4h antes de 8h), NR-10 antes do
--  NR-10-SEP (o básico antes do complementar).
--
--  A ordem vale para a vitrine do site E para a lista de marcar cursos do
--  SistemaCMH: as duas leem `order=ordem`. Arrumar aqui arruma nos dois.
-- =====================================================================

update public.trein_curso c
   set ordem = novo.ordem
  from (values
    -- as NR, por número
    ('NR-01-INT4',  1),
    ('NR-01-INT8',  2),
    ('NR-05',       3),
    ('NR-06',       4),
    ('NR-10',       5),
    ('NR-10-SEP',   6),
    ('NR-11',       7),
    ('NR-12',       8),
    ('NR-17',       9),
    ('NR-18',      10),
    ('NR-20',      11),
    ('NR-26',      12),
    ('NR-33',      13),
    ('NR-34.5',    14),
    ('NR-35',      15),
    -- e o que não tem número, em ordem alfabética
    ('BRIG',       16),
    ('DD',         17),
    ('DD-REC',     18),
    ('LOTO',       19)
  ) as novo(codigo, ordem)
 where c.codigo = novo.codigo;

-- Curso que entrar depois e não estiver na lista acima ficaria com a ordem
-- antiga e cairia no meio dos outros. Estes vão para o fim, onde ao menos
-- dá para vê-los e decidir o lugar certo.
update public.trein_curso
   set ordem = 90 + ordem
 where codigo not in ('NR-01-INT4','NR-01-INT8','NR-05','NR-06','NR-10',
                      'NR-10-SEP','NR-11','NR-12','NR-17','NR-18','NR-20',
                      'NR-26','NR-33','NR-34.5','NR-35',
                      'BRIG','DD','DD-REC','LOTO')
   and ordem < 90;

-- Confira: tem de sair NR-01 em cima e LOTO embaixo, sem buraco nem
-- número repetido nos dezenove primeiros.
select ordem, codigo, titulo, ativo
  from public.trein_curso
 order by ordem, codigo;
