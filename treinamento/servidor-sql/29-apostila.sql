-- =====================================================================
--  A APOSTILA DO CURSO
--
--  Rode no SQL Editor ANTES dos arquivos 30, 31 e 32, que preenchem o
--  texto. Pode rodar mais de uma vez.
--
--  POR QUE ELA EXISTE
--  O vídeo ensina, mas ninguém revê uma aula de 40 minutos para conferir
--  uma dúvida na hora do serviço. A apostila é o que a pessoa abre no
--  celular no meio do turno, e o que ela consulta antes da prova. Sem
--  material escrito, o curso acaba quando o vídeo acaba.
--
--  POR QUE NO BANCO, E NÃO NUM PDF NO STORAGE
--  Porque quem responde pelo conteúdo é o responsável técnico, que não
--  edita PDF nem escreve SQL. No banco, o texto aparece num campo do
--  admin: corrigir uma frase é abrir, escrever e salvar. Num PDF seria
--  refazer o arquivo, subir de novo e torcer para ninguém ter baixado a
--  versão errada.
-- =====================================================================

alter table public.trein_curso
  -- Markdown simples: ## título, ### subtítulo, - lista, **negrito** e
  -- linhas começando com > viram destaque. Não é markdown completo de
  -- propósito: o que o navegador desenha tem de ser previsível, e um
  -- interpretador inteiro no meio de um texto que vem do banco é uma
  -- porta de entrada que não vale a comodidade.
  add column if not exists apostila text;

-- Quantas palavras cada apostila tem, e quantos itens de conteúdo
-- programático. Curso sem apostila aparece com zero.
select c.ordem, c.codigo, c.titulo,
       coalesce(array_length(
         string_to_array(regexp_replace(coalesce(c.apostila, ''),
                                        '\s+', ' ', 'g'), ' '), 1), 0)
         as palavras_apostila,
       coalesce(array_length(
         string_to_array(trim(coalesce(c.conteudo_programatico, '')),
                         E'\n'), 1), 0)
         as itens_do_verso
  from public.trein_curso c
 where c.ativo
 order by palavras_apostila, c.ordem;
