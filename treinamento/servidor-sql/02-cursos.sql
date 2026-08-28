-- =====================================================================
--  Catálogo dos treinamentos
--
--  Rode DEPOIS do 01-esquema.sql, no mesmo lugar:
--  Supabase > SQL Editor > New query > cole > Run
--
--  Dá para rodar quantas vezes quiser: o `on conflict (codigo)` atualiza o
--  que já existe em vez de duplicar. É assim que se corrige um preço ou uma
--  descrição depois — muda aqui e roda de novo.
--
--  O PREÇO ESTÁ EM BRANCO DE PROPÓSITO
--  Eu não sei quanto vocês cobram, e chutar número numa página de venda é
--  pior do que deixar "Sob consulta", que é o que o site mostra quando o
--  preço é nulo. Preencha na coluna `preco` quando decidir.
--
--  A CARGA HORÁRIA É A USUAL DE MERCADO, E PRECISA DA SUA CONFERIDA
--  Cada Norma tem a sua, e algumas mudam conforme a atividade (a NR-10
--  básica é 40h, mas o complementar SEP é outro curso). Confira com o
--  responsável técnico antes de publicar: hora errada no certificado é
--  problema na fiscalização.
-- =====================================================================

insert into public.trein_curso
  (codigo, titulo, subtitulo, carga_horaria, validade_meses, nota_minima, descricao, ordem)
values
  ('NR-35', 'Trabalho em altura',
   'Capacitação e reciclagem', 8, 24, 70,
   'Capacitação e reciclagem, com uso de cinto, ancoragem e análise de risco da tarefa.', 1),

  ('NR-33', 'Espaços confinados',
   'Trabalhador, vigia e supervisor', 16, 12, 70,
   'Trabalhador autorizado, vigia e supervisor de entrada, com prática de resgate.', 2),

  ('NR-10', 'Segurança em eletricidade',
   'Básico', 40, 24, 70,
   'Para quem trabalha em instalações e serviços com eletricidade.', 3),

  ('NR-10-SEP', 'Eletricidade — complementar (SEP)',
   'Sistema Elétrico de Potência', 40, 24, 70,
   'Complementar da NR-10, para quem atua no Sistema Elétrico de Potência.', 4),

  ('NR-11', 'Operação de empilhadeira',
   'Movimentação de cargas', 16, 36, 70,
   'Movimentação, transporte e armazenagem com equipamento motorizado.', 5),

  ('NR-12', 'Máquinas e equipamentos',
   'Operação segura', 8, 24, 70,
   'Operação segura, proteções, dispositivos de segurança e procedimentos.', 6),

  ('NR-05', 'CIPA',
   'Formação dos membros', 20, 12, 70,
   'Formação dos membros da Comissão Interna de Prevenção de Acidentes e de Assédio.', 7),

  ('NR-06', 'Uso de EPI',
   'Equipamento de proteção individual', 4, 12, 70,
   'Escolha, uso correto, guarda e conservação dos equipamentos de proteção.', 8),

  ('NR-17', 'Ergonomia',
   'Postura e organização do trabalho', 4, 12, 70,
   'Postura, levantamento de peso, organização do trabalho e prevenção de lesões.', 9),

  ('NR-18', 'Construção civil',
   'Integração para canteiros', 8, 12, 70,
   'Integração e capacitações específicas para os canteiros de obra.', 10),

  ('NR-20', 'Inflamáveis e combustíveis',
   'Por classe de instalação', 8, 12, 70,
   'Capacitação por classe de instalação, para quem atua com líquidos e gases inflamáveis.', 11),

  ('DD', 'Direção defensiva',
   'Condução segura a serviço', 8, 24, 70,
   'Condução segura para quem dirige a serviço da empresa.', 12),

  ('BRIG', 'Brigada e primeiros socorros',
   'Emergência e evacuação', 16, 12, 70,
   'Combate a princípio de incêndio, evacuação e primeiros socorros.', 13)

on conflict (codigo) do update set
  titulo         = excluded.titulo,
  subtitulo      = excluded.subtitulo,
  carga_horaria  = excluded.carga_horaria,
  validade_meses = excluded.validade_meses,
  descricao      = excluded.descricao,
  ordem          = excluded.ordem;

-- Confira o que entrou:
select codigo, titulo, carga_horaria, validade_meses, preco, ativo
  from public.trein_curso order by ordem;
