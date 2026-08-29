-- =====================================================================
--  A PROVA ABERTA PASSA A SOBREVIVER
--
--  Rode quando quiser. Pode rodar mais de uma vez.
--
--  DOIS PROBLEMAS, UM CONSERTO
--
--  1. DAVA PARA LER O BANCO INTEIRO SEM RESPONDER NADA.
--     A espera de 30 minutos e o limite de 3 por dia contam TENTATIVAS,
--     e tentativa so existe quando o aluno envia. Abrir a prova nao conta.
--     Entao bastava abrir, ler as 10, fechar, abrir de novo, ler outras
--     10, e em umas quinze rodadas ele teria visto as 150 questoes sem
--     nunca ter sido reprovado uma vez.
--
--     A funcao ja apagava o sorteio anterior nao usado, mas isso resolve
--     outra coisa: impede escolher o sorteio mais facil para responder.
--     Nao impede ter LIDO os anteriores.
--
--  2. RECARREGAR A PAGINA PERDIA A PROVA.
--     Quem apertava F5 no meio, ou caiu a internet, ou fechou sem querer,
--     voltava e recebia uma prova NOVA, perdendo as respostas ja dadas.
--     Numa prova de dez questoes isso e recomecar do zero por acidente.
--
--  O conserto e o mesmo para os dois: enquanto houver uma prova aberta e
--  ainda valida, o servidor devolve A MESMA, e nao uma nova. Reabrir para
--  de ser uma forma de ver questao diferente, e passa a ser o jeito
--  normal de voltar para onde se estava.
--
--  Para devolver a mesma prova e preciso guardar tambem a ORDEM em que as
--  alternativas foram embaralhadas. Sem ela, as questoes voltariam iguais
--  mas com as alternativas em outra posicao, e o gabarito guardado, que
--  aponta posicao, deixaria de bater.
-- =====================================================================

alter table public.trein_sorteio
  add column if not exists ordem jsonb;

comment on column public.trein_sorteio.ordem is
  'Ordem em que as alternativas de cada questao foram embaralhadas, na '
  'mesma sequencia de `questoes`. Guardada para que reabrir a prova '
  'devolva exatamente a mesma, com as alternativas nas mesmas posicoes.';

-- Sorteio velho e lixo: ninguem volta a uma prova aberta ontem, e deixar
-- acumular so faz a consulta do "tem prova aberta?" ficar mais lenta a
-- cada semana.
create index if not exists idx_trein_sorteio_aberto
  on public.trein_sorteio (matricula_id, criado_em desc)
  where not usado;

-- =====================================================================
--  Confira
-- =====================================================================
-- A coluna nova e o indice.
select column_name, data_type
  from information_schema.columns
 where table_schema = 'public' and table_name = 'trein_sorteio'
 order by ordinal_position;

select indexname from pg_indexes
 where schemaname = 'public' and tablename = 'trein_sorteio';
