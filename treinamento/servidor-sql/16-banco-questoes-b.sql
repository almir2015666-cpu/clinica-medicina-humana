-- =====================================================================
--  Banco de questoes B: mais 30 perguntas para 5 cursos
--  NR-10-SEP, NR-11, NR-12, NR-17 e NR-18
--
--  Rode no SQL Editor. Pode rodar mais de uma vez: cada bloco apaga
--  SOMENTE as questoes de ordem 11 a 40 do seu curso antes de inserir.
--  As 10 primeiras (as do 12-provas-demais-cursos.sql) ficam intactas.
--
--  ATENÇÃO: ESTAS PERGUNTAS PRECISAM DA CONFERIDA DO RESPONSÁVEL TÉCNICO
--  ANTES DE VALER PARA CERTIFICADO.
--  Foram escritas a partir do conteúdo usual de cada norma e do que se
--  cobra em campo. São coerentes com as normas, mas quem responde pela
--  prova é o responsável técnico — prova errada reprova quem sabe e
--  aprova quem não sabe, e é o certificado dele que está em jogo.
--
--  POR QUE ISSO EXISTE
--  Com 40 questões por curso, a prova passa a sortear 10 de um banco
--  grande: duas turmas não recebem a mesma prova e o aluno que colou o
--  gabarito do colega não vai longe. Só funciona se não houver repetição,
--  então NENHUMA destas 30 repete assunto das 10 que já existiam. Onde o
--  tema chegou perto (aterramento, escada, EPI), a pergunta cobra outra
--  etapa do serviço, não a mesma resposta com outras palavras.
--
--  A COLUNA `correta` É O ÍNDICE, COMEÇANDO EM ZERO
--  Se a resposta certa é a primeira alternativa, `correta` é 0. A posição
--  da resposta certa foi espalhada de propósito pelos quatro índices, em
--  proporção parecida: aluno que decora padrão de gabarito não aprende
--  norma nenhuma.
--
--  CADA ARRAY FICA NUMA LINHA SÓ, de propósito: o Postgres recusa JSON com
--  quebra de linha dentro do texto ("Character with value 0x0d must be
--  escaped"). Foi o erro que derrubou a primeira versão do arquivo do
--  NR-20 e não custa nada evitar de novo.
--
--  As alternativas erradas são erros que se ouve na obra e no chão de
--  fábrica, não absurdo. Alternativa ridícula não mede nada: o aluno
--  elimina por eliminação e passa sem ter entendido o risco.
-- =====================================================================


-- =====================================================================
--  NR-10-SEP — Complementar Sistema Elétrico de Potência
--  As 10 primeiras cobraram o que é o SEP e as regras gerais. Estas 30
--  vão para a rotina da equipe de rede: cabo caído, religador, tensão de
--  passo, ferramenta isolante, cesto aéreo e a hora de reenergizar. É aí
--  que a linha de distribuição mata, e quase sempre em baixa tensão.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-10-SEP')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Qual é a ordem correta para instalar e retirar o aterramento temporário na rede?',
     '["Tanto faz a ordem, desde que todos os cabos fiquem bem presos", "Primeiro nas fases e depois no terra, e na retirada a mesma sequência", "Primeiro o cabo no ponto de terra e depois nas fases, e na retirada na ordem inversa", "Somente nas fases, porque o poste já tem aterramento próprio"]', 2, 11),

    ('Um cabo da rede rompeu e caiu na calçada. Qual é a conduta?',
     '["Isolar a área a distância, não deixar ninguém se aproximar e comunicar o centro de operação", "Afastar o cabo com um pedaço de madeira seca", "Cobrir o cabo com terra para isolar do público", "Encostar o pé calçado para conferir se está mesmo energizado"]', 0, 12),

    ('O que é a tensão de passo?',
     '["A tensão que aparece entre as duas mãos ao segurar um cabo", "A tensão medida na entrada do consumidor", "A tensão que sobra no circuito depois do desligamento", "A diferença de potencial entre os pés de quem caminha perto de um ponto energizado com o solo, que dá choque mesmo sem tocar em nada"]', 3, 13),

    ('O que precisa ser feito com o religamento automático antes do serviço na rede?',
     '["Nada: o religador só atua quando falta energia na região", "Deve ser bloqueado, para o circuito não voltar sozinho enquanto a equipe trabalha", "Basta avisar a equipe de que existe religador naquele trecho", "Deve ser mantido ativo, para testar o circuito durante o serviço"]', 1, 14),

    ('Como deve ser a vestimenta em atividade com risco de arco elétrico no SEP?',
     '["Resistente à chama, certificada e com proteção compatível com a energia que pode ser liberada no arco", "Qualquer uniforme de algodão grosso resolve", "Uniforme sintético, por ser mais leve e secar rápido", "Uniforme comum, desde que se use luva isolante"]', 0, 15),

    ('Antes de calçar a luva isolante de borracha, o trabalhador deve:',
     '["Apenas olhar contra a luz para procurar furo", "Apenas lavar com água e sabão", "Apenas conferir a cor, que já indica a classe de tensão", "Inspecionar, fazer o teste de inflação com ar, conferir a validade do ensaio e usar a luva de cobertura por cima"]', 3, 16),

    ('Que tipo de escada se usa em serviço na rede elétrica?',
     '["Escada metálica, por ser mais resistente ao uso diário", "Escada de material isolante, como fibra de vidro, nunca a metálica", "Qualquer escada, desde que esteja amarrada no poste", "Escada de madeira pintada com tinta isolante"]', 1, 17),

    ('Sobre o trabalho realizado no cesto aéreo do caminhão:',
     '["O trabalhador pode passar do cesto para o poste, se for mais rápido assim", "O cinto pode ser preso na estrutura do poste ou no cabo mensageiro", "O equipamento deve estar inspecionado e ensaiado, o veículo posicionado e sinalizado, e o trabalhador permanece no cesto com o cinto preso ao ponto previsto", "Basta calçar as rodas do caminhão antes de subir"]', 2, 18),

    ('Sobre a vara de manobra e as demais ferramentas isolantes:',
     '["Podem ser usadas na chuva fina, já que são isolantes", "Devem estar limpas, secas, sem trincas e dentro da validade do ensaio, e o trabalhador segura somente abaixo do limitador", "Podem ser reparadas com fita isolante quando trincam", "Servem também de alavanca para soltar peças presas"]', 1, 19),

    ('Antes de iniciar o serviço na rede em via pública, é preciso:',
     '["Apenas ligar o pisca-alerta do veículo", "Apenas avisar o morador da casa em frente", "Isolar e sinalizar a área com cones e cavaletes, protegendo a equipe do trânsito de veículos e de pedestres", "Apenas trabalhar depressa para atrapalhar menos o trânsito"]', 2, 20),

    ('Como deve ser a comunicação de uma manobra entre a equipe e o centro de operação?',
     '["Padronizada: quem recebe a ordem repete o que entendeu e confirma o equipamento pelo nome e pelo número antes de executar", "Rápida e curta, para não ocupar o rádio", "Por mensagem de celular, que fica registrada", "Feita só no fim do dia, no relatório de serviço"]', 0, 21),

    ('Terminado o serviço, o que precisa acontecer antes de a rede ser reenergizada?',
     '["Basta avisar o encarregado da equipe", "Basta descer do poste e recolher as ferramentas", "Basta retirar os cones e liberar o trânsito", "Retirar os aterramentos temporários, conferir que a equipe e as ferramentas estão fora e comunicar o centro de operação para liberar"]', 3, 22),

    ('Sobre a sala de baterias de uma subestação:',
     '["É ambiente comum, sem risco além do peso das baterias", "O único cuidado é manter a porta trancada", "Basta um extintor na entrada", "Há liberação de hidrogênio e risco de ácido: exige ventilação, proibição de chama ou faísca e EPI adequado"]', 3, 23),

    ('Por que um banco de capacitores exige cuidado mesmo depois de desligado?',
     '["Porque esquenta muito e demora a esfriar", "Porque guarda carga elétrica residual: é preciso aguardar a descarga e aterrar antes de tocar", "Porque pode vazar óleo e deixar o piso escorregadio", "Porque religa sozinho depois de alguns minutos"]', 1, 24),

    ('Princípio de incêndio em equipamento elétrico energizado. O que usar?',
     '["Água em jato, para resfriar mais rápido", "Espuma mecânica, que abafa melhor", "Desligar a energia quando for possível e usar extintor de CO2 ou pó químico, nunca água", "Areia jogada por cima do equipamento"]', 2, 25),

    ('Um trabalhador sofreu choque e ficou desacordado no alto do poste. O que a equipe faz?',
     '["Confirmar que o circuito está desenergizado e executar o resgate para descer a vítima o quanto antes, iniciando os primeiros socorros", "Aguardar o corpo de bombeiros antes de qualquer ação", "Subir de imediato para socorrer, sem verificar a tensão", "Cortar o talabarte para a vítima descer mais depressa"]', 0, 26),

    ('Para que serve o prontuário das instalações elétricas com os procedimentos de trabalho?',
     '["Reunir esquemas, procedimentos, laudos e registros que orientam e comprovam como o serviço deve ser feito", "Registrar a frequência e as horas extras da equipe", "Controlar o estoque de material do almoxarifado", "Atender apenas a auditoria do cliente"]', 0, 27),

    ('Sobre a reciclagem do treinamento da NR-10:',
     '["É feita apenas quando a empresa achar necessário", "Vale para sempre depois do curso inicial", "É periódica e também exigida na mudança de função, no retorno de afastamento prolongado e quando os procedimentos ou a instalação mudam", "Só é exigida para quem trabalha em alta tensão"]', 2, 28),

    ('Sobre a aptidão médica do trabalhador do SEP:',
     '["Basta o exame admissional feito uma vez", "O exame só é exigido para quem sobe em poste", "A empresa pode dispensar o exame de quem já tem experiência", "O trabalhador precisa estar apto no exame ocupacional, e quem não estiver apto não executa a atividade"]', 3, 29),

    ('Durante o lançamento ou a tração de cabos perto de uma rede energizada:',
     '["Pode-se trabalhar normalmente, porque o cabo novo está desligado", "O cabo lançado deve ser tratado como energizado, com aterramento, proteção da rede vizinha e controle das duas pontas", "Basta manter uma pessoa avisando quando o cabo chegar perto da rede", "Basta usar luva de vaqueta para segurar o cabo"]', 1, 30),

    ('Uma árvore está encostando na rede de distribuição. Como proceder com a poda?',
     '["Podar com tesoura de cabo longo, tomando cuidado com os galhos maiores", "Podar em dia seco, porque madeira seca não conduz", "Somente com equipe autorizada e com a rede desligada ou protegida, seguindo procedimento", "Pedir ao morador que pode ele mesmo, com escada de madeira"]', 2, 31),

    ('Um pintor vai trabalhar em uma fachada com rede energizada logo em frente. O correto é:',
     '["Ele pode trabalhar, desde que calce luva de borracha", "Manter a distância de segurança e solicitar à concessionária o desligamento ou a proteção isolante da rede antes do serviço", "Ele pode trabalhar se afastar os fios com um cabo de vassoura", "Ele pode trabalhar se alguém ficar observando de baixo"]', 1, 32),

    ('Qual capacete é adequado para o trabalhador do setor elétrico?',
     '["Capacete de classe apropriada ao risco elétrico, sem partes metálicas e com jugular", "Qualquer capacete que tenha Certificado de Aprovação", "Capacete com aba metálica frontal, que protege melhor a vista", "Boné de brim, quando o serviço é rápido e no chão"]', 0, 33),

    ('Como o trabalhador se protege da queda durante o serviço no poste?',
     '["Abraçando o poste com os braços e as pernas", "Com cinto abdominal preso na cintura", "Segurando firme no cabo mensageiro enquanto sobe", "Com cinto tipo paraquedista, talabarte de posicionamento e trava-quedas na subida, ancorados nos pontos previstos"]', 3, 34),

    ('Serviço em rede secundária, de baixa tensão, é menos perigoso?',
     '["Sim, porque a tensão é baixa demais para matar alguém", "Não: boa parte dos acidentes fatais acontece em baixa tensão, e os procedimentos valem igual", "Sim, desde que o trabalhador use luva de vaqueta", "Sim, quando o serviço dura poucos minutos"]', 1, 35),

    ('No mesmo poste passam rede primária, rede secundária e cabos de telecomunicação. O que fazer?',
     '["Considerar que os cabos mais baixos estão sempre desligados", "Identificar os circuitos pela cor da capa dos cabos", "Perguntar ao morador qual cabo é de qual serviço", "Não presumir nada: identificar os circuitos conforme o procedimento e confirmar com o centro de operação antes de qualquer intervenção"]', 3, 36),

    ('A ferramenta isolante ficou molhada pela chuva durante o serviço. O que fazer?',
     '["Continuar, porque a borracha não perde a proteção com água", "Secar na roupa e seguir o serviço", "Interromper a atividade: material isolante molhado ou sujo perde a proteção e só volta ao uso limpo, seco e inspecionado", "Usar somente para tocar pontos de baixa tensão"]', 2, 37),

    ('Diante de uma situação de emergência com risco de vida na instalação:',
     '["Qualquer pessoa pode acionar o desligamento de emergência, mesmo sem ser da equipe", "Somente o encarregado da equipe pode desligar", "Somente o centro de operação pode desligar, sem exceção", "É preciso preencher a autorização antes de desligar"]', 0, 38),

    ('O que é o trabalho ao potencial?',
     '["A técnica em que o trabalhador é colocado no mesmo potencial elétrico da rede energizada, exigindo equipe, equipamento e procedimento específicos", "O trabalho feito somente em redes de baixa tensão", "O trabalho feito com a rede aterrada nas duas pontas", "O trabalho feito com bastão isolante a partir do solo"]', 0, 39),

    ('Serviço na rede durante a noite exige:',
     '["Somente uma lanterna de mão para cada trabalhador", "Iluminação adequada da frente de trabalho e reforço da sinalização para o trânsito, além dos cuidados de sempre", "Reduzir a equipe, para atrapalhar menos a via", "Dispensar a sinalização, porque circulam menos veículos"]', 1, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-10-SEP';


-- =====================================================================
--  NR-11 — Transporte, movimentação, armazenagem e manuseio de materiais
--  As 10 primeiras ficaram na direção da empilhadeira. Estas 30 abrem o
--  curso para o resto da norma: pilha, porta-pallets, doca, ponte
--  rolante, cabo de aço, cinta e o transporte manual de saco. É o mesmo
--  trabalhador que faz tudo isso, e o acidente raramente é ao volante.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-11')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Como deve ser feito o empilhamento de materiais no depósito?',
     '["Empilhando o máximo que couber, até encostar no teto", "Com pilhas estáveis, com altura compatível com a base e o material, sem obstruir iluminação, extintores e chuveiros automáticos", "Colocando as caixas mais pesadas por cima, para prensar as de baixo", "Encostando as pilhas na parede, que dá firmeza"]', 1, 11),

    ('O pallet tem tábuas quebradas e pregos soltos. O que fazer?',
     '["Usar assim mesmo, se a carga for leve", "Reforçar com fita adesiva e usar", "Colocar outro pallet por cima e movimentar os dois juntos", "Retirar de uso e separar para reparo ou descarte"]', 3, 12),

    ('O que acontece com a capacidade da empilhadeira quando a carga é mais comprida ou fica afastada do encosto?',
     '["A capacidade diminui, porque o centro de carga se afasta e cresce o risco de tombamento para a frente", "A capacidade não muda, porque o peso continua o mesmo", "A capacidade aumenta, porque a carga fica mais equilibrada", "A capacidade só muda quando a carga é mais alta"]', 0, 13),

    ('Pode-se levantar uma carga apoiada em apenas um dos garfos?',
     '["Pode, quando a carga é leve", "Pode, se o operador tiver experiência", "Não: a carga precisa apoiar nos dois garfos, centralizada e encostada no suporte", "Pode, se um colega segurar do outro lado"]', 2, 14),

    ('Na troca do cilindro de GLP da empilhadeira, o correto é:',
     '["Trocar com o motor ligado, para não perder a pressão da linha", "Trocar em qualquer lugar, desde que seja rápido", "Desligar o motor, fechar a válvula, trocar em local ventilado e longe de chama ou faísca, usando luva e óculos", "Aquecer a válvula com a mão para soltar com mais facilidade"]', 2, 15),

    ('Sobre a sala de carga das baterias das empilhadeiras elétricas:',
     '["Exige ventilação, proibição de chama e faísca e EPI contra respingo de ácido, porque a carga libera hidrogênio", "Basta manter a sala trancada fora do horário", "Pode ficar no mesmo local do abastecimento de combustível", "Basta ter um extintor na porta"]', 0, 16),

    ('Empilhadeira a combustão trabalhando dentro de galpão fechado. Qual é o risco principal?',
     '["Somente o ruído do motor", "Somente o incômodo do cheiro para a equipe", "Somente o aquecimento do ambiente", "Acúmulo de monóxido de carbono, gás sem cor e sem cheiro que intoxica e mata"]', 3, 17),

    ('Por que não se faz curva com a empilhadeira em velocidade?',
     '["Porque desgasta demais os pneus dianteiros", "Porque a empilhadeira se apoia em três pontos e a força da curva pode tombá-la de lado, ainda mais com a carga elevada", "Porque a direção traseira trava nas curvas fechadas", "Porque a carga escorrega dos garfos, e é só isso"]', 1, 18),

    ('Antes de entrar com a empilhadeira dentro de uma carreta encostada na doca:',
     '["Basta o motorista da carreta puxar o freio de mão", "Basta conferir se a rampa está seca", "Basta a carreta estar bem encostada na doca", "É preciso calçar as rodas, travar a carreta, garantir que o motorista não vai sair com o veículo e conferir o piso e o nivelador"]', 3, 19),

    ('Sobre o nivelador ou a rampa de acesso da doca:',
     '["Pode ser improvisado com tábuas e chapas soltas", "Deve estar em bom estado, bem apoiado e com capacidade para o peso do equipamento somado ao da carga", "Basta que esteja limpo e sem óleo", "Pode ser usado com folga entre a doca e o veículo, se a passagem for rápida"]', 1, 20),

    ('Sobre as vias de circulação do setor:',
     '["Podem ser usadas para deixar material por pouco tempo", "Podem ser estreitadas quando o estoque aumenta", "Devem ser demarcadas, desobstruídas e dimensionadas para o equipamento, sem bloquear saídas de emergência", "Só precisam de demarcação onde passa gente a pé"]', 2, 21),

    ('A empilhadeira vai ficar parada alguns minutos com a carga no alto. Isso é:',
     '["Errado: carga elevada parada é risco de queda e de tombamento, e ninguém pode circular ou permanecer embaixo dela", "Aceitável, se a carga estiver bem encaixada nos garfos", "Aceitável, se ninguém estiver por perto naquele momento", "Aceitável, desde que o operador continue no assento"]', 0, 22),

    ('O checklist do turno apontou o freio falhando. O que fazer?',
     '["Não operar, sinalizar o equipamento como impedido de uso e comunicar a manutenção e a chefia", "Operar só em velocidade baixa até o fim do turno", "Operar apenas dentro do galpão, onde o piso é plano", "Anotar e deixar o assunto para o operador do próximo turno"]', 0, 23),

    ('O operador percebeu um defeito que considera simples e quer consertar. Isso é:',
     '["Correto, se ele tiver a ferramenta necessária", "Correto, quando é só um ajuste rápido", "Errado: manutenção e reparo são feitos por profissional capacitado para essa tarefa", "Correto, desde que ele comunique depois"]', 2, 24),

    ('Há vazamento no sistema hidráulico. Como localizar o ponto?',
     '["Passando a mão ao longo da mangueira para sentir o óleo", "Com o equipamento desligado e despressurizado, por inspeção visual ou com um pedaço de papelão: o jato de óleo sob pressão perfura a pele", "Aproximando o rosto da mangueira para enxergar melhor", "Apertando a mangueira com a mão para ver onde escapa"]', 1, 25),

    ('Ao descer da empilhadeira para resolver outra tarefa, o operador deve:',
     '["Deixar ligada, se for voltar em poucos minutos", "Deixar a chave na ignição para outro colega usar", "Deixar em ponto morto com o motor ligado", "Baixar os garfos, acionar o freio de estacionamento, desligar e levar a chave consigo, para ninguém não autorizado usar"]', 3, 26),

    ('Uso de celular durante a operação da empilhadeira:',
     '["Permitido em ligações rápidas", "Proibido: mesmo com fone, a atenção cai e o operador deixa de perceber pedestres e obstáculos", "Permitido com o equipamento em movimento lento", "Permitido para conferir a lista de separação de pedidos"]', 1, 27),

    ('O operador dormiu mal, está tomando remédio que dá sono e se sente lento. O que fazer?',
     '["Comunicar a chefia e não operar naquele dia", "Operar somente cargas leves", "Tomar café e operar com atenção redobrada", "Operar apenas a primeira metade do turno"]', 0, 28),

    ('Sobre a estrutura porta-pallets do estoque:',
     '["A capacidade é a mesma em qualquer nível da estrutura", "Longarina amassada pode seguir em uso, desde que ainda sustente a carga", "A capacidade só importa nos níveis mais altos", "Cada nível tem capacidade definida, que deve estar sinalizada, e avaria na estrutura precisa ser comunicada e a posição interditada"]', 3, 29),

    ('Para pegar uma caixa em um nível alto do porta-pallets, o trabalhador pode subir na estrutura?',
     '["Pode, se subir devagar e com cuidado", "Pode, se um colega segurar embaixo", "Não: usa-se escada apropriada ou equipamento de elevação previsto para pessoas", "Pode, quando a estrutura é de aço reforçado"]', 2, 30),

    ('Sobre a torre e as correntes de elevação da empilhadeira:',
     '["Pode-se subir na torre para alcançar um item, com o equipamento parado", "Pode-se apoiar a mão na corrente para se equilibrar", "Pode-se limpar a corrente com a máquina em movimento lento", "Não se coloca a mão nem o corpo na torre: é zona de esmagamento e corte, mesmo com o equipamento parado"]', 3, 31),

    ('Sobre o transporte manual de sacos e volumes feito por um trabalhador:',
     '["Cada um carrega o quanto aguentar, sem limite", "Pode-se carregar qualquer distância, desde que em ritmo lento", "A norma limita a distância do percurso: acima disso, o transporte deve ser feito por meio mecânico", "Só é exigida ajuda quando o volume passa de 100 quilos"]', 2, 32),

    ('Durante o içamento com ponte rolante, quem orienta o movimento?',
     '["Um sinaleiro definido, com gestos padronizados, e somente ele orienta o operador", "Qualquer pessoa por perto que esteja enxergando melhor", "O próprio operador, olhando de cima da cabine", "O encarregado, gritando do outro lado do galpão"]', 0, 33),

    ('Como se avalia o cabo de aço de uma talha ou de um guincho?',
     '["Basta olhar se está bem engraxado", "Inspecionando fios rompidos, amassamento, corrosão e deformação, e retirando de uso quando atinge o critério de substituição", "Basta puxar com força para testar a resistência", "Basta trocar uma vez por ano, sem precisar inspecionar"]', 1, 34),

    ('Sobre o gancho usado no içamento:',
     '["Pode ser usado com a trava quebrada, se a carga for leve", "Pode ser aquecido e entortado para caber na alça da peça", "Deve ter a trava de segurança funcionando, sem trincas nem abertura excessiva, e a carga apoiada no fundo do gancho", "Pode receber a carga na ponta, quando o ângulo ajuda"]', 2, 35),

    ('Sobre as cintas e eslingas de içamento:',
     '["Podem ser usadas com cortes leves na costura", "Podem receber um nó quando ficam compridas demais", "A capacidade não muda com o ângulo entre os ramos", "Devem ser inspecionadas antes do uso, respeitar a capacidade conforme o ângulo e receber protetor nas quinas da carga"]', 3, 36),

    ('Sobre o elevador de carga do estabelecimento:',
     '["Pode transportar pessoas quando o elevador social está em manutenção", "É destinado somente a carga, com a capacidade indicada de forma visível, e não transporta pessoas", "Pode levar uma pessoa acompanhando a carga", "Pode ser carregado acima da capacidade em percursos curtos"]', 1, 37),

    ('Sobre a armazenagem no depósito:',
     '["Deve-se manter afastamento das paredes e corredores livres, sem obstruir extintores, quadros elétricos e saídas", "Pode-se encostar tudo nas paredes para aproveitar espaço", "Extintores podem ficar atrás das pilhas, desde que sinalizados", "Os corredores podem ser ocupados durante o recebimento de mercadoria"]', 0, 38),

    ('A carga é mais comprida que os garfos e fica balançando. O que fazer?',
     '["Transportar devagar, com a carga apoiada do jeito que deu", "Pedir para um colega ir ao lado segurando a ponta", "Usar o acessório apropriado, como extensor ou garfo mais longo, e amarrar a carga quando for necessário", "Elevar mais a carga, que assim ela firma"]', 2, 39),

    ('Piso molhado ou com resto de óleo no caminho da empilhadeira. O que muda?',
     '["Nada, porque os pneus são maciços", "Basta ligar o pisca-alerta ao passar pelo trecho", "Basta acelerar para atravessar depressa", "Aumenta a distância de frenagem e o risco de derrapagem: reduzir a velocidade, evitar manobra brusca e providenciar a limpeza"]', 3, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-11';


-- =====================================================================
--  NR-12 — Máquinas e equipamentos
--  As 10 primeiras trataram de proteção, bloqueio e parada de emergência.
--  Estas 30 avançam para o resto do chão de fábrica: cortina de luz, modo
--  de operação, transportador de correia, máquina usada comprada de
--  terceiro, prensa, serra e o direito de parar quando falta proteção.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-12')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Para que serve a cortina de luz instalada na frente da máquina?',
     '["Detectar a entrada da mão ou do corpo na zona de perigo e interromper o movimento, e por isso precisa ficar na distância calculada", "Iluminar melhor a peça durante a operação", "Contar quantas peças passaram no turno", "Avisar o operador com um sinal luminoso quando o ciclo termina"]', 0, 11),

    ('O que é a zona de perigo de uma máquina?',
     '["A área onde fica o painel elétrico", "O lugar onde o operador guarda as ferramentas", "Qualquer região dentro ou ao redor da máquina onde exista risco para quem está exposto", "Somente o ponto exato onde a peça é cortada"]', 2, 12),

    ('Quais são riscos mecânicos típicos das máquinas?',
     '["Somente o corte por peça afiada", "Esmagamento, corte, cisalhamento, prensagem, arrastamento, perfuração e projeção de peças", "Somente o choque elétrico vindo do painel", "Somente o ruído e a vibração do equipamento"]', 1, 13),

    ('Faltou energia e a máquina parou no meio do ciclo. Quando a energia voltar:',
     '["A máquina deve retomar o ciclo de onde parou, para não perder a peça", "A máquina pode religar sozinha, desde que o operador esteja no posto", "A máquina religa automaticamente em velocidade reduzida", "A máquina não pode partir sozinha: o religamento exige comando manual e voluntário do operador"]', 3, 14),

    ('Para que serve a chave seletora de modo de operação, com bloqueio por chave ou senha?',
     '["Para escolher a velocidade conforme o material trabalhado", "Para trocar o programa de produção do dia", "Para identificar quem operou a máquina em cada turno", "Para garantir que o modo de manutenção ou de ajuste só seja usado por quem é autorizado, com as proteções correspondentes a cada modo"]', 3, 15),

    ('Um ajuste exige a máquina em movimento com a proteção aberta. O correto é:',
     '["Trabalhar em modo manual, com velocidade reduzida e comando de ação continuada, por profissional autorizado e com a área controlada", "Trabalhar em modo automático, com atenção redobrada", "Retirar o sensor da porta para a máquina não ficar parando", "Pedir a um colega para ficar com a mão no botão de emergência"]', 0, 16),

    ('Qual é a diferença entre proteção fixa e proteção móvel?',
     '["Não há diferença: as duas são presas com parafuso", "A fixa é de acrílico e a móvel é de chapa", "A fixa só sai com ferramenta e permanece no lugar durante a operação; a móvel abre e por isso precisa de intertravamento", "A móvel só é usada em máquinas antigas"]', 2, 17),

    ('Por que roupa larga, cordão de crachá, corrente e cabelo solto são proibidos perto de partes rotativas?',
     '["Porque descaracterizam o uniforme da empresa", "Porque podem ser agarrados pela parte em movimento e arrastar o trabalhador para dentro da máquina", "Porque sujam a peça que está sendo produzida", "Porque atrapalham a identificação do trabalhador no setor"]', 1, 18),

    ('Como deve ser o dispositivo que dá a partida na máquina?',
     '["Um botão grande e livre, para ser encontrado rápido", "Protegido contra acionamento acidental, para a máquina não partir com uma esbarrada", "Uma alavanca que pode ficar travada na posição ligada", "Um pedal solto no chão, sem proteção em volta"]', 1, 19),

    ('Sobre o painel elétrico da máquina:',
     '["Pode ficar aberto durante a produção, para ventilar", "Pode ter a chave na fechadura, para facilitar o acesso", "Pode ter partes energizadas acessíveis, desde que sinalizadas", "Deve permanecer fechado, aterrado e sem partes energizadas acessíveis, e só é aberto por profissional autorizado"]', 3, 20),

    ('Para que serve o cabo de emergência esticado ao longo do transportador de correia?',
     '["Permitir que qualquer pessoa pare o equipamento puxando o cabo em qualquer ponto da extensão", "Servir de corrimão para quem passa ao lado", "Sustentar a estrutura da correia", "Marcar o limite da área de circulação"]', 0, 21),

    ('Sobre a travessia e a proteção de um transportador de correia:',
     '["Pode-se passar por cima da correia quando ela está parada", "Pode-se passar por baixo, se a correia estiver alta", "A travessia só é feita pela passarela ou passagem prevista, e tambores, roletes e demais partes móveis ficam protegidos", "Pode-se passar por cima com a correia em movimento, se for rápido"]', 2, 22),

    ('Quem executa a manutenção das máquinas e o que fica registrado?',
     '["Qualquer operador que conheça o equipamento, sem necessidade de registro", "O fornecedor, e apenas durante a garantia", "Profissional capacitado ou habilitado para a tarefa, com registro das intervenções realizadas", "O encarregado do setor, que anota no caderno pessoal"]', 2, 23),

    ('Para que servem o inventário e a apreciação de riscos das máquinas?',
     '["Para calcular a depreciação contábil dos equipamentos", "Para levantar quais máquinas existem e quais riscos cada uma apresenta, orientando as adequações e os prazos", "Para definir a produtividade esperada de cada máquina", "Para escolher o seguro do parque de equipamentos"]', 1, 24),

    ('A empresa comprou uma máquina usada de outra fábrica. O que precisa acontecer?',
     '["Pode operar como está, porque já funcionava antes", "Pode operar por seis meses, enquanto se faz a adaptação", "Basta treinar o operador que vai usá-la", "A máquina precisa ser avaliada e adequada às exigências de segurança antes de entrar em operação"]', 3, 25),

    ('A empresa mandou fabricar uma máquina na própria manutenção. O que é exigido?',
     '["Projeto e responsabilidade técnica de profissional habilitado, com as proteções e os dispositivos de segurança previstos", "Nada, porque não é máquina comprada de fabricante", "Somente uma placa de identificação com o nome da empresa", "Somente o teste de funcionamento antes do primeiro uso"]', 0, 26),

    ('Como se alimenta uma prensa que tem risco na zona de trabalho?',
     '["Com dispositivo de alimentação, pinça ou sistema automático, mantendo as mãos fora da zona de prensagem", "Com a mão, desde que o operador seja rápido", "Com a mão, quando o acionamento é por pedal", "Com um arame improvisado para empurrar a peça"]', 0, 27),

    ('Ao serrar uma peça pequena, ou no fim do corte na serra de bancada, o correto é:',
     '["Empurrar com a mão até o fim, para o corte sair reto", "Puxar a peça pelo outro lado da serra", "Segurar a peça com as duas mãos junto ao disco", "Usar o empurrador e a guia, mantendo as mãos afastadas do disco"]', 3, 28),

    ('O que protege o trabalhador da projeção de cavacos e partículas da máquina?',
     '["Apenas os óculos de proteção", "Anteparo ou proteção na própria máquina, somado a óculos ou protetor facial, porque a proteção coletiva vem primeiro", "Apenas manter distância da máquina em operação", "Apenas o protetor auricular e a máscara contra poeira"]', 1, 29),

    ('Sobre o uso do ar comprimido para limpeza:',
     '["Pode-se soprar a roupa e a pele para tirar o pó, se a pressão for baixa", "Pode-se apontar para o colega como brincadeira, porque é só ar", "Não se sopra o corpo nem a roupa: o ar comprimido penetra na pele e nos olhos e projeta partículas", "Pode-se soprar perto do ouvido para tirar poeira"]', 2, 30),

    ('Sobre o espaço ao redor da máquina:',
     '["Pode ser ocupado com as caixas de peças prontas", "Deve permitir a circulação e a operação com segurança, com piso limpo, nivelado e áreas demarcadas", "Só precisa ficar livre do lado do painel de comando", "Pode ser reduzido quando a produção aumenta"]', 1, 31),

    ('Iluminação insuficiente no posto de operação da máquina causa:',
     '["Apenas desconforto visual no fim do turno", "Apenas aumento do consumo de energia", "Erro no posicionamento da peça, aproximação indevida da zona de perigo e aumento de acidentes", "Apenas cansaço, sem relação com acidente"]', 2, 32),

    ('O trabalhador vai passar a operar uma máquina diferente da que sempre usou. O que é preciso?',
     '["Nada, porque ele já é operador experiente", "Apenas ler o manual no primeiro dia", "Apenas o acompanhamento de um colega na primeira hora", "Capacitação específica para aquela máquina, com os riscos e os procedimentos dela, antes de operar sozinho"]', 3, 33),

    ('Como se reduz o ruído gerado por uma máquina?',
     '["Com medidas na fonte e no caminho do som, como enclausuramento, manutenção e amortecimento, além do protetor auricular para o trabalhador", "Somente distribuindo protetor auricular na equipe", "Somente reduzindo o tempo de jornada no setor", "Somente afastando os demais trabalhadores da máquina"]', 0, 34),

    ('Sobre as máquinas autopropelidas que circulam dentro da fábrica:',
     '["Basta o operador buzinar quando achar necessário", "Basta demarcar o piso com faixa amarela", "Basta reduzir a velocidade nos corredores estreitos", "Precisam de sinalização sonora de ré, iluminação, freios em ordem e vias com circulação organizada"]', 3, 35),

    ('Em máquinas com partes aquecidas, como injetoras e estufas, o risco térmico é controlado:',
     '["Com isolamento térmico, proteções que impeçam o contato e sinalização das superfícies quentes, além do EPI adequado", "Apenas com aviso verbal ao operador no início do turno", "Apenas com luva de algodão para pegar as peças", "Apenas desligando a máquina no fim do expediente"]', 0, 36),

    ('Duas pessoas trabalham na mesma máquina, em posições diferentes. Antes de acionar:',
     '["Basta olhar o painel de comando", "Basta gritar o nome do colega uma vez", "É preciso confirmar, visualmente e por comunicação, que ninguém está na zona de perigo, seguindo o procedimento combinado", "Basta acionar devagar, para o colega perceber"]', 2, 37),

    ('Subir, sentar ou apoiar-se na máquina ou na esteira parada é:',
     '["Aceitável enquanto a máquina estiver desligada", "Proibido: a partida pode acontecer e a superfície não foi feita para sustentar pessoas", "Aceitável se o trabalhador tiver onde se segurar", "Aceitável para alcançar rapidamente um ponto alto"]', 1, 38),

    ('A máquina está sem uma das proteções e o encarregado mandou produzir assim. O que fazer?',
     '["Produzir, porque a ordem veio do superior", "Recusar a operação, comunicar a situação e registrar: risco grave e iminente dá ao trabalhador o direito de interromper", "Produzir apenas metade do lote e parar", "Produzir e comunicar o setor de segurança no fim do turno"]', 1, 39),

    ('A remoção de cavacos, aparas e resíduos da máquina deve ser feita:',
     '["Com a mão, durante a operação, para não parar a produção", "Com ar comprimido apontado para a zona de corte, com a máquina ligada", "Com a máquina parada e com ferramenta apropriada, como gancho, escova ou aspirador, usando luva resistente a corte", "Com um pano enrolado na mão, com a máquina em rotação baixa"]', 2, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-12';


-- MARCADOR-FIM-PARCIAL
