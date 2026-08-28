-- =====================================================================
--  O SORTEIO DA PROVA
--
--  Rode no SQL Editor. Pode rodar mais de uma vez.
--
--  O PROBLEMA
--  Até agora cada curso tinha exatamente 10 questões e a prova entregava
--  todas. Dois colegas da mesma empresa faziam a MESMA prova, na mesma
--  ordem — o primeiro passava e ditava as respostas para o resto do
--  turno. O certificado é nominal e vale numa fiscalização; uma prova que
--  se copia por telefone não mede nada.
--
--  O QUE MUDA
--  O banco de questões cresce para 40 por curso e a prova sorteia 10.
--  São 847 milhões de combinações possíveis (C(40,10)) — dois colegas
--  receberem as mesmas dez deixa de acontecer na prática.
--
--  POR QUE ISTO PRECISA DE UMA TABELA
--  A correção tem de saber QUAIS dez foram sorteadas. Sem registro, só
--  restaria corrigir o que o navegador mandou de volta — e aí bastaria
--  pedir a prova várias vezes, juntar as questões fáceis e responder só
--  essas. Gravando o sorteio, a correção usa as dez que a plataforma
--  escolheu, e não as que o aluno preferiu.
--
--  Guardar o sorteio também serve para a fiscalização: dá para mostrar
--  exatamente qual prova aquele trabalhador respondeu, e quando.
-- =====================================================================

create table if not exists public.trein_sorteio (
  id            uuid primary key default uuid_generate_v4(),
  matricula_id  uuid not null references public.trein_matricula(id) on delete cascade,
  -- os ids das questões, NA ORDEM em que foram mostradas
  questoes      uuid[] not null,
  -- Onde ficou a resposta certa de cada uma DEPOIS do embaralho das
  -- alternativas, na mesma ordem do array acima.
  --
  -- Por que não basta a `correta` da trein_questao: as alternativas são
  -- embaralhadas a cada prova, para "é a letra C" não virar resposta
  -- transmissível entre colegas. Embaralhadas, o índice guardado na
  -- tabela de questões aponta para a alternativa errada. O gabarito que
  -- vale é o desta prova, e ele nasce e morre aqui.
  gabarito      int[] not null default '{}',
  criado_em     timestamptz not null default now(),
  -- vira `true` quando essa prova é corrigida. Um sorteio só vale uma
  -- correção: sem isto, o aluno pediria a prova, anotaria, e mandaria a
  -- resposta do sorteio antigo depois de descobrir o gabarito.
  usado         boolean not null default false
);

create index if not exists idx_trein_sorteio_mat
  on public.trein_sorteio(matricula_id, criado_em desc);

-- para quem já tinha a tabela da primeira versão deste arquivo
alter table public.trein_sorteio
  add column if not exists gabarito int[] not null default '{}';

alter table public.trein_sorteio enable row level security;

-- NINGUÉM lê pelo navegador. O sorteio contém os ids das questões daquela
-- prova; com eles na mão, e pedindo provas repetidas, dá para mapear o
-- banco inteiro. Quem escreve e lê é a Edge Function, com service role,
-- que não passa por RLS.
drop policy if exists trein_sorteio_equipe on public.trein_sorteio;
create policy trein_sorteio_equipe on public.trein_sorteio
  for select using (public.trein_is_equipe());

-- Quantas questões a prova sorteia. Fica no curso, e não escondido na
-- função, porque um curso curto pode querer menos.
alter table public.trein_curso
  add column if not exists questoes_por_prova int not null default 10;

-- Confira: quantas questões cada curso tem no banco, e quantas a prova
-- sorteia. Curso com MENOS questões do que sorteia cai para o que tiver —
-- funciona, mas aí todo mundo faz a mesma prova de novo, que é o que
-- estamos consertando. A coluna `folga` mostra isso: quanto menor, mais
-- provas parecidas.
select c.codigo, c.titulo,
       count(q.id)                                  as no_banco,
       c.questoes_por_prova                         as sorteia,
       count(q.id) - c.questoes_por_prova           as folga
  from public.trein_curso c
  left join public.trein_questao q on q.curso_id = c.id
 where c.ativo
 group by c.id
 order by folga, c.ordem;
