-- =====================================================================
--  ATENÇÃO — LEIA ANTES DE RODAR
--
--  ESTE ARQUIVO APAGA E REESCREVE QUESTÕES.
--
--  Desde que o admin do site ganhou o editor de prova
--  (treinamento/admin.html), as questões passaram a ter DUAS fontes: estes
--  arquivos e a tela que o responsável técnico usa.
--
--  Rodar isto aqui joga fora toda correção de enunciado, de alternativa ou
--  de GABARITO feita pela tela naquela faixa de `ordem`. A perda é
--  silenciosa: ninguém é avisado, e o erro só reaparece quando um aluno
--  for reprovado por uma resposta que já tinha sido consertada.
--
--  Rode apenas quando o banco daquele curso estiver vazio, ou quando você
--  souber que quer descartar as edições feitas pela tela.
--
--  Para conferir o que existe hoje antes de decidir:
--      select c.codigo, count(q.id) as questoes
--        from public.trein_curso c
--        left join public.trein_questao q on q.curso_id = c.id
--       where c.ativo group by c.id order by c.ordem;
-- =====================================================================

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

    ('Antes de a equipe começar o serviço, já no local, o que deve ser feito?',
     '["Basta conferir se todo mundo trouxe o EPI", "A análise de risco da tarefa no próprio local, avaliando a rede, o poste, o tempo e o trânsito, com a participação de toda a equipe", "Basta o encarregado explicar o serviço no caminho", "Basta preencher a ordem de serviço no fim do dia"]', 1, 19),

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

    ('A equipe encontrou vazamento de óleo em um transformador. O que fazer?',
     '["Recolher o óleo com estopa e seguir o serviço", "Continuar o serviço, porque o óleo do transformador é isolante e não oferece risco", "Isolar a área, comunicar e não intervir sem procedimento: há risco de incêndio, de escorregão e de contato com produto perigoso", "Lavar o piso com água para tirar o óleo"]', 2, 37),

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

    ('Pode-se usar a empilhadeira para rebocar outro equipamento ou arrastar uma carga pelo chão?',
     '["Pode, desde que a distância seja curta", "Pode, se a corrente usada for resistente", "Pode, se um colega for acompanhando o percurso", "Não: o equipamento foi feito para elevar e transportar sobre os garfos, e o reboque improvisado compromete freio, direção e estabilidade"]', 3, 26),

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

    ('Um aprendiz de 17 anos pode operar a máquina se estiver acompanhado por um colega experiente?',
     '["Pode, desde que o acompanhamento seja o tempo todo", "Não pode: menores de 18 anos não operam, nem fazem manutenção, em máquinas com risco de acidente", "Pode, se o serviço for apenas de alimentação da máquina", "Pode, se houver autorização por escrito dos pais"]', 1, 18),

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


-- =====================================================================
--  NR-17 — Ergonomia
--  As 10 primeiras cobriram postura, peso e o básico do posto. Estas 30
--  entram nos anexos e na organização do trabalho: teleatendimento,
--  operador de caixa, turno, meta, vibração, pausa fisiológica e o posto
--  que precisa ser regulável porque nem todo mundo tem o mesmo corpo.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-17')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Qual deve ser a altura da superfície de trabalho?',
     '["Sempre a mesma em todos os postos, por padronização da empresa", "Sempre na altura do peito, para enxergar bem a tarefa", "Sempre a mais baixa possível, para poupar os ombros", "Compatível com a tarefa e com a estatura do trabalhador: mais alta no trabalho de precisão e mais baixa quando exige força"]', 3, 11),

    ('Como devem ficar dispostos os materiais e as ferramentas mais usados no posto?',
     '["Guardados no armário, para manter a bancada limpa", "Dentro da área de alcance das mãos, sem exigir torção do tronco nem braço esticado", "Sempre do lado esquerdo, por padrão", "Empilhados atrás do trabalhador, para liberar a frente"]', 1, 12),

    ('Qual é a posição adequada para o uso do teclado e do mouse?',
     '["Punhos retos, cotovelos junto ao corpo formando cerca de 90 graus e antebraços apoiados", "Punhos dobrados para cima, apoiados na borda da mesa", "Teclado bem afastado, com os braços esticados", "Mouse do outro lado da mesa, longe do teclado"]', 0, 13),

    ('Quando o apoio para os pés é necessário?',
     '["Sempre, em qualquer posto de trabalho sentado", "Nunca, porque atrapalha a circulação embaixo da mesa", "Quando, com a cadeira na altura correta para a bancada, os pés do trabalhador não alcançam o chão", "Somente para trabalhador com problema de coluna"]', 2, 14),

    ('Sobre o conforto térmico em atividades sedentárias:',
     '["Quanto mais frio o ambiente, maior a produtividade", "Deve-se evitar corrente de ar direcionada ao trabalhador e manter temperatura e umidade em faixas de conforto", "O ar-condicionado deve ficar sempre na menor temperatura possível", "Conforto térmico não é assunto de ergonomia"]', 1, 15),

    ('Sobre o ruído em atividades que exigem concentração e comunicação:',
     '["Só importa quando passa do limite de insalubridade", "Só importa nos setores de produção", "Mesmo abaixo do limite de insalubridade o ruído atrapalha a concentração e a conversa, e deve ser reduzido ao nível de conforto", "Resolve-se distribuindo protetor auricular no escritório"]', 2, 16),

    ('No trabalho de teleatendimento, a norma prevê:',
     '["Somente cadeira giratória com regulagem de altura", "Somente monitor de tela plana", "Somente o controle do tempo médio de atendimento", "Pausas específicas durante a jornada, conjunto de fone individual e mobiliário adequado, além de metas que não estimulem ritmo excessivo"]', 3, 17),

    ('No trabalho em caixa de supermercado, a norma exige:',
     '["Assento adequado, posto que permita alternar a postura e limite para o levantamento de volumes pesados", "Que o operador fique sempre em pé, para agilizar o atendimento", "Que o operador levante qualquer volume do carrinho do cliente", "Que o assento seja retirado nos horários de pico"]', 0, 18),

    ('Sobre a ginástica laboral e as pausas durante a jornada:',
     '["Ajudam, mas não substituem a correção do posto de trabalho e da organização da tarefa", "Substituem a avaliação ergonômica quando feitas todos os dias", "Servem apenas para descontrair a equipe", "Devem ser feitas fora do horário de trabalho"]', 0, 19),

    ('Ao movimentar um carrinho carregado, é preferível:',
     '["Puxar, porque assim o trabalhador enxerga o caminho", "Puxar com uma das mãos, girando o tronco", "Empurrar com os braços esticados e o corpo inclinado para trás", "Empurrar, usando a força das pernas e o peso do corpo, com os braços próximos ao tronco"]', 3, 20),

    ('Carrinho com rodas emperradas rodando em piso irregular:',
     '["Não interfere no esforço, porque o peso continua o mesmo", "Só atrapalha a velocidade do serviço", "Aumenta muito a força necessária e o risco de lesão: rodas e piso fazem parte da avaliação ergonômica", "Resolve-se colocando mais um trabalhador para empurrar"]', 2, 21),

    ('Por que a postura estática prolongada faz mal, mesmo sem esforço aparente?',
     '["Porque cansa principalmente a visão", "Porque o músculo fica contraído sem descanso, a circulação piora e aparecem fadiga e dor", "Porque o trabalhador perde o ritmo de produção", "Porque aumenta o gasto de energia do corpo"]', 1, 22),

    ('Sobre o trabalho noturno e em turnos:',
     '["Não tem relação com a ergonomia", "Basta pagar o adicional noturno previsto", "Afeta o sono e aumenta a fadiga e o erro: exige cuidado nas escalas, nas pausas e na organização do trabalho", "Resolve-se com café à disposição no setor"]', 2, 23),

    ('Sobre metas e premiação por produção:',
     '["Não devem existir mecanismos que estimulem ritmo excessivo de trabalho, porque adoecem o trabalhador", "São livres, desde que o trabalhador concorde", "São permitidas quando o valor pago é pequeno", "São obrigatórias para medir o desempenho da equipe"]', 0, 24),

    ('Sobre a ida ao banheiro e a hidratação durante a jornada:',
     '["Só podem acontecer nas pausas programadas", "O trabalhador deve poder atender às necessidades fisiológicas e se hidratar, sem depender de autorização a cada vez", "Devem ser controladas por senha, para não atrapalhar a produção", "Não são assunto da ergonomia"]', 1, 25),

    ('Há reflexo forte na tela do computador. Como corrigir?',
     '["Aumentando o brilho da tela ao máximo", "Trocando o monitor por um modelo maior", "Desligando metade das lâmpadas do setor", "Reposicionando a tela em relação à janela e às luminárias, usando persiana e evitando fontes de luz atrás ou à frente do monitor"]', 3, 26),

    ('Para reduzir a fadiga visual de quem passa o dia na tela:',
     '["Basta usar óculos de descanso", "Basta reduzir o tamanho da fonte na tela", "Basta trabalhar com a luz do teto apagada", "Fazer pausas curtas olhando para longe ao longo do dia, além de ajustar iluminação, brilho e distância da tela"]', 3, 27),

    ('Quando o trabalho é feito em casa, a ergonomia:',
     '["Deixa de ser responsabilidade da empresa", "Passa a ser problema apenas do trabalhador", "Continua valendo: a empresa deve orientar sobre a organização do posto e os cuidados com postura, pausas e iluminação", "Só vale quando a empresa fornece os móveis"]', 2, 28),

    ('Trabalho com os braços acima da altura dos ombros por longos períodos:',
     '["É seguro, desde que o objeto seja leve", "Sobrecarrega ombros e pescoço e deve ser reduzido com plataforma, ferramenta apropriada ou mudança da altura da tarefa", "Só é problema para quem tem mais de 50 anos", "Melhora com o uso de munhequeira"]', 1, 29),

    ('Duas pessoas vão levantar juntas uma carga pesada. O correto é:',
     '["Combinar antes quem dá o comando, levantar ao mesmo tempo e manter o passo sincronizado", "Cada um levantar assim que estiver pronto", "O mais forte levantar primeiro e o outro acompanhar", "Levantar bem rápido, para reduzir o tempo de esforço"]', 0, 30),

    ('Existe um peso máximo fixo que sirva para qualquer trabalhador e qualquer tarefa?',
     '["Não: o limite depende da avaliação, que considera frequência, distância, altura, postura e quem executa a tarefa", "Sim, 60 quilos para homens e 30 para mulheres", "Sim, 25 quilos para qualquer situação", "Sim, o peso que o próprio trabalhador disser que aguenta"]', 0, 31),

    ('O espaço embaixo da mesa está ocupado por caixas e pelo gabinete. Qual é o problema?',
     '["Nenhum, desde que o trabalhador caiba na cadeira", "O trabalhador não consegue aproximar as pernas nem mudar de posição, o que força a coluna e os braços", "Apenas dificulta a limpeza do setor", "Apenas prejudica a aparência do escritório"]', 1, 32),

    ('Trabalhadora gestante ou trabalhador com restrição médica no setor. O que a empresa faz?',
     '["Mantém a tarefa como está, porque a restrição é temporária", "Afasta do trabalho até o fim da restrição, sempre", "Adapta o posto e a tarefa conforme a orientação médica, mudando o que for necessário no mobiliário, no ritmo e nas pausas", "Transfere para outro setor sem avaliar a nova tarefa"]', 2, 33),

    ('Qual é o papel dos trabalhadores na avaliação ergonômica?',
     '["Nenhum: quem avalia é o profissional técnico", "Apenas responder a um questionário no fim do processo", "Apenas assinar o relatório final", "Participar informando as dificuldades reais da tarefa e ajudando a testar e validar as soluções propostas"]', 3, 34),

    ('Quais são sinais de alerta para lesões relacionadas ao trabalho?',
     '["Somente inchaço visível na articulação", "Somente dor que já impede o movimento", "Dor, formigamento, dormência, perda de força e cansaço que não passa com o descanso", "Somente cãibra durante a jornada"]', 2, 35),

    ('Sobre as ferramentas manuais usadas o dia inteiro:',
     '["Quanto mais pesada a ferramenta, menos esforço o trabalhador faz", "O formato do cabo não influencia no esforço", "O que importa é apenas que a ferramenta corte bem", "O cabo, o peso e o formato devem permitir pegada firme com a mão inteira, sem forçar o punho nem apertar com a ponta dos dedos"]', 3, 36),

    ('O uso prolongado de martelete, lixadeira ou furadeira de impacto exige:',
     '["Revezamento e pausas, manutenção do equipamento e luva antivibração, porque a vibração lesiona nervos e vasos da mão", "Somente protetor auricular", "Somente apertar com mais força para segurar melhor a ferramenta", "Somente trocar a ferramenta a cada cinco anos"]', 0, 37),

    ('Em que altura da prateleira devem ficar os itens mais pesados e mais usados?',
     '["Nos níveis mais altos, para liberar espaço embaixo", "Entre o quadril e os ombros, evitando agachar e levantar acima da cabeça", "No chão, porque a queda seria menor", "Tanto faz, desde que estejam organizados"]', 1, 38),

    ('O que a empresa deve fazer com as queixas de desconforto e dor relatadas pelos trabalhadores?',
     '["Registrar, analisar e usar como informação na avaliação ergonômica e no plano de melhorias", "Arquivar no prontuário e aguardar o afastamento", "Considerar somente quando houver atestado médico", "Encaminhar apenas ao setor de pessoal"]', 0, 39),

    ('O mesmo posto é usado por pessoas de estaturas diferentes e por canhotos. O que fazer?',
     '["Padronizar tudo pela média das pessoas do setor", "Deixar que cada um se vire e se adapte como puder", "Escolher os móveis pelo trabalhador mais alto da equipe", "Prever regulagens no mobiliário e nos equipamentos, para que cada trabalhador ajuste o posto ao próprio corpo"]', 3, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-17';


-- =====================================================================
--  NR-18 — Construção civil
--  As 10 primeiras trataram de guarda-corpo, andaime, escada, escavação e
--  carga suspensa. Estas 30 seguem para o resto do canteiro: bandeja,
--  tela de fachada, balancim, elevador de obra, betoneira, poeira de
--  sílica, telhado frágil, demolição e o que se faz com o entulho.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-18')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O trabalhador acabou de ser contratado para a obra. O que precisa acontecer antes de ele começar?',
     '["Basta receber os EPI e o crachá", "Basta assinar a ficha de registro", "Receber o treinamento de admissão, com informação sobre os riscos da obra e as medidas de proteção, antes de iniciar as atividades", "Receber o treinamento no primeiro sábado depois da admissão"]', 2, 11),

    ('Para que serve o programa de gerenciamento de riscos da obra?',
     '["Para calcular o custo da mão de obra por etapa", "Para identificar os riscos de cada etapa da obra e definir as medidas de prevenção, com prazos e responsáveis", "Para registrar a produtividade das equipes", "Para atender apenas a uma exigência do cliente"]', 1, 12),

    ('Para que serve a plataforma de proteção, conhecida como bandeja, instalada na fachada?',
     '["Para apoiar o material que sobe para as lajes", "Para servir de piso de trabalho dos pedreiros", "Para sustentar o andaime fachadeiro", "Para reter materiais e pessoas que caiam da periferia do edifício"]', 3, 13),

    ('A tela de proteção na fachada serve para:',
     '["Impedir a projeção e a queda de materiais para fora da obra, protegendo quem está embaixo e na rua", "Proteger a obra do sol e da chuva", "Esconder a obra da vizinhança", "Sustentar o guarda-corpo da periferia da laje"]', 0, 14),

    ('Vergalhões de espera apontando para cima na laje. O que fazer?',
     '["Proteger as pontas com dispositivo apropriado, para evitar perfuração em caso de queda ou esbarrão", "Pintar as pontas de amarelo e seguir o serviço", "Dobrar as pontas com marreta, se houver tempo", "Sinalizar a área com fita e liberar a circulação"]', 0, 15),

    ('No andaime suspenso, o balancim, o trabalhador se protege da queda:',
     '["Com o guarda-corpo do próprio balancim, que já basta", "Prendendo o talabarte na estrutura do balancim", "Prendendo o talabarte no cabo de sustentação da plataforma", "Com cinto tipo paraquedista ligado por trava-quedas a um cabo de segurança independente da estrutura do balancim"]', 3, 16),

    ('Sobre a cadeira suspensa usada em serviço de fachada:',
     '["Pode ser montada com corda comum, desde que de boa qualidade", "Pode ser usada por qualquer trabalhador da obra", "Exige trabalhador capacitado e autorizado, sistema de sustentação adequado e um cabo de segurança independente para o trava-quedas", "Dispensa o cinto, porque o trabalhador fica sentado"]', 2, 17),

    ('Sobre o elevador de obra de cremalheira:',
     '["Pode transportar carga e trabalhadores ao mesmo tempo, se houver espaço", "Deve ser operado por trabalhador qualificado, com a capacidade indicada e as portas e travas funcionando", "Pode ser operado por qualquer um que já tenha visto como funciona", "Pode ultrapassar a capacidade em viagens curtas"]', 1, 18),

    ('Sobre a operação da grua no canteiro:',
     '["A carga pode passar sobre a área de vivência, se for rápido", "A operação é feita por profissional qualificado, com sinaleiro e comunicação definida, e é interrompida com vento forte ou visibilidade ruim", "O operador decide sozinho quando parar por causa do vento", "Qualquer trabalhador pode dar os sinais para o operador"]', 1, 19),

    ('Sobre a betoneira do canteiro:',
     '["Deve ter as engrenagens e a correia protegidas e estar aterrada, e a limpeza só é feita com o equipamento desligado e bloqueado", "Pode operar sem a proteção da coroa, porque a rotação é lenta", "Pode ser limpa com a pá enquanto gira devagar", "Dispensa aterramento por ficar em área aberta"]', 0, 20),

    ('Sobre as ferramentas elétricas portáteis usadas na obra:',
     '["Emenda com fita isolante é aceitável, desde que bem enrolada", "Podem ser ligadas direto nos fios do quadro, quando não há tomada", "Podem ficar no chão molhado, se estiverem desligadas", "Devem ter cabo e plugue íntegros, aterramento ou duplo isolamento, e circuito protegido por dispositivo diferencial residual"]', 3, 21),

    ('No corte de blocos, pisos e concreto com serra, o principal risco à saúde é:',
     '["O ruído da máquina, apenas", "O peso da máquina nos braços do trabalhador", "A poeira de sílica, que causa doença pulmonar grave, e por isso se usa corte úmido, aspiração e respirador adequado", "O aquecimento do disco de corte"]', 2, 22),

    ('Serviço sobre telhado de material frágil, como telha de fibrocimento:',
     '["Pode ser feito pisando somente sobre os apoios da estrutura", "Pode ser feito por dois trabalhadores, para dividir o peso", "Pode ser feito com calçado de solado macio", "Exige tábuas ou passarelas apoiadas na estrutura e cinto ligado a cabo de segurança, porque a telha não sustenta o peso de uma pessoa"]', 3, 23),

    ('Sobre a proteção de quem passa na calçada em frente à obra:',
     '["Basta uma placa avisando que ali é obra", "Basta fita zebrada no limite do terreno", "O canteiro deve ser fechado com tapume e a passagem de pedestres protegida e sinalizada", "A responsabilidade é da prefeitura, não da obra"]', 2, 24),

    ('Como se retira o entulho dos pavimentos altos?',
     '["Por calha fechada até o recipiente de coleta, ou por equipamento de transporte, nunca jogando de cima", "Jogando pela janela no horário de menor movimento", "Jogando na área isolada com fita zebrada", "Descendo em baldes pelo poço do elevador"]', 0, 25),

    ('Sobre as escadas e rampas provisórias de circulação da obra:',
     '["Podem ser feitas com tábuas soltas apoiadas nos degraus de concreto", "Precisam ser fixas, com degraus regulares, largura suficiente e corrimão ou guarda-corpo onde há risco de queda", "Podem dispensar corrimão quando são largas", "Podem ter qualquer inclinação, desde que o trabalhador desça devagar"]', 1, 26),

    ('O poço do elevador e os vãos internos do prédio em construção devem:',
     '["Ficar abertos, para facilitar a passagem de materiais", "Ser fechados com proteção resistente ou receber guarda-corpo e sinalização, em todos os pavimentos", "Receber apenas uma corda esticada na entrada", "Ser fechados somente no pavimento onde há serviço em andamento"]', 1, 27),

    ('Antes de iniciar uma escavação, o que precisa ser verificado?',
     '["Somente o tipo de solo do terreno", "Somente a previsão do tempo para os próximos dias", "Somente a profundidade prevista em projeto", "A existência de redes subterrâneas de energia, gás, água, esgoto e telecomunicação, com levantamento junto às concessionárias"]', 3, 28),

    ('A obra fica embaixo de uma rede elétrica aérea. O correto é:',
     '["Manter a distância de segurança e solicitar à concessionária o desligamento ou a proteção isolante da rede antes dos serviços próximos", "Trabalhar com cuidado, evitando encostar as ferramentas nos fios", "Cobrir os fios com lona plástica", "Trabalhar somente em dias secos"]', 0, 29),

    ('Sobre o escoramento das fôrmas e a retirada delas:',
     '["A desforma pode começar assim que o concreto pega", "O escoramento pode ser reduzido para liberar a circulação", "O escoramento é feito conforme projeto, e a desforma segue a sequência e os prazos definidos pelo responsável técnico", "A retirada pode ser feita por qualquer equipe que estiver livre"]', 2, 30),

    ('Sobre um serviço de demolição:',
     '["Começa pelas paredes de baixo, para a estrutura ceder sozinha", "Pode ser feito pela equipe da obra, sem planejamento específico", "Exige planejamento e supervisão de profissional habilitado, isolamento da área e desligamento prévio das instalações de energia, água e gás", "Basta isolar a área com fita zebrada e começar"]', 2, 31),

    ('Como devem ficar os materiais estocados no canteiro?',
     '["Em pilhas estáveis, com altura e afastamento adequados, sem obstruir a circulação, os equipamentos de combate a incêndio e as saídas", "Encostados nas paredes recém-levantadas, que servem de apoio", "No corredor de circulação, para ficar perto da frente de serviço", "Empilhados o mais alto possível, para ocupar menos área"]', 0, 32),

    ('Sobre a circulação de caminhões e máquinas dentro do canteiro:',
     '["Basta o motorista buzinar ao entrar na obra", "Exige vias definidas, sinalização, alarme de ré e sinaleiro nas manobras, com a área de manobra isolada", "Basta os trabalhadores desviarem quando ouvirem o motor", "Só é preciso cuidado na entrada e na saída do canteiro"]', 1, 33),

    ('Trabalho prolongado com martelete e rompedor exige:',
     '["Apenas óculos de proteção", "Apenas luva de raspa", "Apenas máscara contra poeira", "Protetor auricular, revezamento entre trabalhadores e proteção contra a poeira, por causa do ruído, da vibração e do pó"]', 3, 34),

    ('O que é o diálogo diário de segurança, o DDS?',
     '["Uma conversa curta antes do serviço para tratar dos riscos do dia e das medidas de proteção", "A reunião mensal da comissão de segurança da obra", "O treinamento admissional dos trabalhadores novos", "A leitura do procedimento, assinada uma vez por mês"]', 0, 35),

    ('Trabalho ao sol em dias de calor forte. O que a obra precisa oferecer?',
     '["Apenas boné e camiseta de manga curta", "Água potável fresca em quantidade suficiente, locais de descanso à sombra, pausas e proteção contra as intempéries", "Apenas hidratação no horário do almoço", "Apenas a liberação do serviço quando alguém passar mal"]', 1, 36),

    ('Sobre o guincho de coluna usado para subir material:',
     '["Pode levar o trabalhador quando o elevador está ocupado", "Pode ser operado por qualquer ajudante disponível", "É destinado somente a materiais, é operado por trabalhador qualificado e a área de descarga precisa de proteção e sinalização", "Pode funcionar sem trava, se o operador segurar o cabo"]', 2, 37),

    ('Sobre o atendimento de primeiros socorros no canteiro:',
     '["Basta ter anotado o telefone do hospital mais próximo", "Basta o encarregado levar o acidentado no carro da obra", "Basta uma caixa com esparadrapo e algodão", "É preciso material de primeiros socorros disponível e pessoa treinada para o atendimento inicial e para acionar o socorro"]', 3, 38),

    ('Por que o contato prolongado com cimento e argamassa exige cuidado?',
     '["Porque mancha a roupa e a pele", "Porque o cimento é alcalino e pode causar irritação, dermatite e queimadura química, exigindo luva, bota e lavagem da pele", "Porque resseca somente a palma da mão", "Porque a argamassa esquenta ao endurecer e queima pelo calor"]', 1, 39),

    ('Solda ou corte com maçarico no canteiro exige:',
     '["Apenas máscara de solda e luva de raspa", "Apenas isolar o local com fita zebrada", "Afastar os materiais combustíveis, proteger o que não puder ser removido, manter extintor ao alcance e observar a área durante e depois do serviço", "Apenas avisar o encarregado do pavimento"]', 2, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-18';


-- a aprovação continua em 70% para todo mundo
update public.trein_curso set nota_minima = 70;

-- Confira o tamanho do banco de cada um dos cinco cursos:
select c.codigo, count(q.id) as perguntas, min(q.ordem) as primeira, max(q.ordem) as ultima
  from public.trein_curso c
  left join public.trein_questao q on q.curso_id = c.id
 where c.codigo in ('NR-10-SEP', 'NR-11', 'NR-12', 'NR-17', 'NR-18')
 group by c.id, c.codigo order by c.codigo;

-- Nenhuma linha deve aparecer aqui (ordem repetida dentro do mesmo curso):
select c.codigo, q.ordem, count(*)
  from public.trein_questao q join public.trein_curso c on c.id = q.curso_id
 group by c.codigo, q.ordem having count(*) > 1;
