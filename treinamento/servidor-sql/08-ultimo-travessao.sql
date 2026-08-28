-- =====================================================================
--  O último travessão do catálogo
--
--  Rode no SQL Editor. Pode rodar mais de uma vez.
--
--  O 06 limpou os campos do certificado, mas o TÍTULO do curso ficou de
--  fora — e é ele que aparece no cartão do site. Sobrou um:
--  "Eletricidade — complementar (SEP)".
--
--  A segunda parte é uma rede: se algum dia entrar travessão em qualquer
--  campo de texto do catálogo, este comando limpa.
-- =====================================================================

update public.trein_curso
   set titulo = 'Eletricidade: complementar (SEP)'
 where codigo = 'NR-10-SEP';

update public.trein_curso
   set titulo    = replace(replace(titulo, ' — ', ': '), '—', '-'),
       subtitulo = replace(replace(subtitulo, ' — ', ', '), '—', '-'),
       descricao = replace(replace(descricao, ' — ', ', '), '—', '-')
 where titulo like '%—%' or subtitulo like '%—%' or descricao like '%—%';

-- Confira: tem de voltar vazio
select codigo, titulo, subtitulo
  from public.trein_curso
 where titulo like '%—%' or subtitulo like '%—%' or descricao like '%—%'
    or titulo_certificado like '%—%' or conteudo_programatico like '%—%';
