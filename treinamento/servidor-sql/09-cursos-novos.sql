-- =====================================================================
--  Cursos que faltavam no catálogo
--
--  Rode no SQL Editor. Pode rodar mais de uma vez.
--
--  DE ONDE VEIO A LISTA
--  --------------------
--  Comparando o nosso catálogo com o do concorrente usado como referência
--  (isesmt.com), estes seis apareciam lá e não aqui. A carga horária é a
--  que eles anunciam — CONFIRA com a Anandda antes de vender, porque hora
--  errada no certificado é problema na fiscalização, não detalhe.
--
--  O LOTO chama atenção: não é NR numerada, é procedimento de bloqueio e
--  etiquetagem (lockout/tagout), muito pedido pela indústria. Estava fora
--  do nosso catálogo e é dos mais procurados.
-- =====================================================================

insert into public.trein_curso
  (codigo, titulo, subtitulo, carga_horaria, validade_meses, nota_minima,
   descricao, ordem)
values
  ('NR-01-INT4', 'Integração de Segurança do Trabalho',
   'NR-01, versão de 4 horas', 4, 12, 70,
   'Integração de segurança para quem começa na empresa: riscos gerais, '
   'ordens de serviço e as regras da casa.', 14),

  ('NR-01-INT8', 'Integração à Norma Regulamentadora NR-01',
   'Versão de 8 horas', 8, 12, 70,
   'Integração completa à NR-01: gerenciamento de riscos, responsabilidades '
   'e o programa da organização.', 15),

  ('NR-26', 'Sinalização de segurança',
   'Cores, rótulos e identificação', 4, 24, 70,
   'Cores na segurança do trabalho, rotulagem preventiva de produtos '
   'químicos e identificação de tubulações.', 16),

  ('NR-34.5', 'Trabalho a quente',
   'Solda, corte e atividades com chama', 8, 12, 70,
   'Segurança para trabalhos a quente: permissão de trabalho, controle de '
   'fontes de ignição, vigia de fogo e emergência.', 17),

  ('LOTO', 'LOTO: bloqueio e etiquetagem',
   'Lockout e Tagout', 4, 12, 70,
   'Procedimento de bloqueio e etiquetagem de energias perigosas antes de '
   'manutenção: quem bloqueia, como se identifica e como se libera.', 18),

  ('DD-REC', 'Direção defensiva (reciclagem)',
   'Periódico', 8, 24, 70,
   'Reciclagem da direção defensiva para quem dirige a serviço da empresa.',
   19)

on conflict (codigo) do update set
  titulo        = excluded.titulo,
  subtitulo     = excluded.subtitulo,
  carga_horaria = excluded.carga_horaria,
  descricao     = excluded.descricao,
  ordem         = excluded.ordem,
  ativo         = true;

-- Confira o catálogo completo:
select codigo, titulo, carga_horaria, preco, ativo
  from public.trein_curso order by ativo desc, ordem;
