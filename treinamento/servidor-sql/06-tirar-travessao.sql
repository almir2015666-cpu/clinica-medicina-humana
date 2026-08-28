-- =====================================================================
--  Tira o travessão do texto que sai no certificado
--
--  Rode DEPOIS do 05. Pode rodar mais de uma vez.
--
--  O 05 gravou o título e o conteúdo do NR-20 com travessão ("—"). No
--  documento impresso ele fica estranho, então vira dois-pontos ou vírgula
--  conforme a frase.
-- =====================================================================

update public.trein_curso
   set titulo_certificado = 'NR-20: Segurança e Saúde no Trabalho com '
                            'Inflamáveis e Combustíveis, Módulo Intermediário',
       conteudo_programatico = replace(
         conteudo_programatico,
         'revisão do item 20.8.8 — trabalhos',
         'revisão do item 20.8.8, sobre trabalhos')
 where codigo = 'NR-20';

-- rede: se sobrar travessão em qualquer curso, vira vírgula
update public.trein_curso
   set conteudo_programatico = replace(conteudo_programatico, ' — ', ', '),
       titulo_certificado    = replace(titulo_certificado, ' — ', ': ')
 where conteudo_programatico like '%—%' or titulo_certificado like '%—%';

-- Confira:
select codigo, titulo_certificado,
       case when conteudo_programatico like '%—%' then 'AINDA TEM'
            else 'ok' end as travessao
  from public.trein_curso
 where conteudo_programatico is not null or titulo_certificado is not null;
