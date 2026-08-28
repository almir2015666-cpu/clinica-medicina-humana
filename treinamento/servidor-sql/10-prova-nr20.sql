-- =====================================================================
--  A prova do NR-20: 10 questoes, aprovacao com 70%
--
--  Rode no SQL Editor. Pode rodar mais de uma vez (apaga e recria).
--
--  ATENÇÃO: ESTAS PERGUNTAS PRECISAM DA CONFERIDA DA ANANDDA.
--  Foram escritas a partir do conteúdo programático do certificado real de
--  vocês. São coerentes com a norma, mas quem responde pela prova é o
--  responsável técnico — prova errada reprova quem sabe e aprova quem não.
--
--  Escolhi o NR-20 porque é o único curso com conteúdo programático
--  cadastrado. Os outros ficam sem prova até alguém escrever, e a tela
--  avisa com todas as letras em vez de deixar o aluno num curso que não
--  termina.
--
--  O DELETE SÓ APAGA A FAIXA 1-10, que é a que este arquivo escreve.
--  Antes ele apagava TODAS as questões do curso. Como os arquivos 15 a 18
--  acrescentam a faixa 11-40, rodar este depois deles varreria as 570
--  questões novas sem avisar — e a prova voltaria a ser sempre a mesma.
--  Com a faixa, a ordem em que se roda deixa de importar.
----  A COLUNA `correta` É O ÍNDICE, COMEÇANDO EM ZERO
--  Se a resposta certa é a primeira alternativa, `correta` é 0.
--  Esta tabela nunca é lida pelo navegador: a RLS proíbe, e só a Edge
--  Function (com service role) enxerga o gabarito.
--
--  CADA ARRAY FICA NUMA LINHA SÓ, de propósito: o Postgres recusa JSON com
--  quebra de linha dentro do texto ("Character with value 0x0d must be
--  escaped"). Foi o erro da primeira versão deste arquivo.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-20')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O que caracteriza um líquido como inflamável, segundo a NR-20?',
     '["Ter ponto de fulgor igual ou inferior a 60 graus Celsius", "Ser armazenado em tambor metálico", "Ter cor escura e cheiro forte", "Ser transportado em caminhão-tanque"]', 0, 1),

    ('Antes de iniciar um trabalho a quente em área com inflamáveis, o que é indispensável?',
     '["Avisar o colega ao lado", "Emitir a Permissão de Trabalho e eliminar as fontes de ignição", "Usar apenas protetor auricular", "Esperar o fim do expediente"]', 1, 2),

    ('Qual é a ordem correta na hierarquia de controle dos riscos?',
     '["EPI, engenharia e por último a eliminação", "Administrativa, EPI e por último a eliminação", "Eliminação, engenharia, administrativa e por último o EPI", "Tanto faz, desde que o risco diminua"]', 2, 3),

    ('O EPI pode substituir uma medida de proteção coletiva?',
     '["Sim, se for mais barato", "Sim, se o trabalhador preferir", "Não. O EPI complementa, e só é a medida principal quando a coletiva não é viável ou está em implantação", "Sim, desde que tenha CA válido"]', 2, 4),

    ('Diante de um princípio de incêndio com líquido inflamável, o que NÃO se deve fazer?',
     '["Acionar o alarme e a brigada", "Jogar água diretamente sobre o líquido em chamas", "Usar extintor de pó químico ou espuma", "Isolar a área e afastar as pessoas"]', 1, 5),

    ('Um espaço confinado com atmosfera inflamável exige, além da NR-20, a aplicação de qual norma?',
     '["NR-35", "NR-33", "NR-17", "NR-24"]', 1, 6),

    ('O que é a Análise Preliminar de Risco (APR)?',
     '["Um relatório enviado ao órgão fiscalizador todo mês", "O levantamento dos perigos da tarefa e das medidas de controle, feito ANTES de começar o trabalho", "A lista de EPI entregues ao trabalhador", "O exame médico admissional"]', 1, 7),

    ('Ao encontrar um colega desacordado dentro de área com vazamento de inflamável, a primeira atitude é:',
     '["Entrar imediatamente para retirá-lo", "Acionar a emergência e não entrar sem equipamento e autorização", "Abrir todas as janelas e esperar", "Tentar reanimá-lo de onde está"]', 1, 8),

    ('Qual a função do vigia de fogo no trabalho a quente?',
     '["Anotar o horário de início e fim do serviço", "Vigiar a área durante e após o serviço, pronto para agir em caso de princípio de incêndio", "Segurar a mangueira de solda", "Conferir o crachá de quem entra"]', 1, 9),

    ('Sobre proteção respiratória em atmosfera com deficiência de oxigênio, é correto afirmar:',
     '["Máscara com filtro químico é suficiente", "Qualquer respirador PFF2 resolve", "É preciso equipamento com suprimento de ar, porque o filtro não cria oxigênio", "Basta prender a respiração e agir rápido"]', 2, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-20';

-- a aprovação é 70%, como combinado
update public.trein_curso set nota_minima = 70;

-- Confira quantas perguntas cada curso tem:
select c.codigo, c.titulo, c.nota_minima, count(q.id) as perguntas
  from public.trein_curso c
  left join public.trein_questao q on q.curso_id = c.id
 group by c.id order by perguntas desc, c.ordem;
