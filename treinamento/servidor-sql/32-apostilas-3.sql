-- =====================================================================
--  APOSTILAS, GRUPO 3: EPI, ergonomia, sinalização, LOTO, trabalho a
--  quente, as duas integrações e as duas direções defensivas
--
--  Rode no SQL Editor. Pode rodar quantas vezes quiser: são updates por
--  código, não inserem nada e não duplicam nada.
--
--  ATENÇÃO: ESTE CONTEÚDO PRECISA DA CONFERIDA DO RESPONSÁVEL TÉCNICO
--  ANTES DE SER PUBLICADO. A apostila é o material que o aluno leva para
--  o trabalho e estuda antes da prova, e o conteúdo programático sai
--  IMPRESSO NO VERSO DO CERTIFICADO. Texto errado no verso é problema na
--  fiscalização, e orientação errada na apostila é acidente. Quem assina
--  tecnicamente pelo curso é quem decide o que fica.
--
--  O QUE ESTE ARQUIVO GRAVA
--  ------------------------
--  Duas colunas por curso:
--    conteudo_programatico : a ementa, um item por linha, frase curta e
--                            formal. É o verso do certificado.
--    apostila              : o material de estudo, em markdown simples.
--                            Só título, subtítulo, parágrafo, lista,
--                            negrito e linha de destaque.
--
--  OS PARES SÃO DE PROPÓSITO DIFERENTES
--  ------------------------------------
--  NR-01-INT4 e NR-01-INT8 são o mesmo assunto em profundidades
--  diferentes, e as apostilas não se repetem. A de 4 horas é para quem
--  foi admitido ontem: o que ele precisa saber para atravessar a primeira
--  semana inteiro. A de 8 horas é gestão de risco: GRO, inventário, plano
--  de ação e hierarquia de controle.
--
--  DD e DD-REC seguem a mesma lógica. O DD ensina a conduzir com
--  segurança. O DD-REC é para quem já dirige há anos e trata do que
--  derruba motorista experiente: fadiga, noite, chuva, carga mal presa,
--  pressa e os primeiros minutos depois de uma batida.
--
--  SEM TRAVESSÃO
--  -------------
--  Os arquivos 06 e 08 tiraram o travessão do catálogo porque no
--  documento impresso ele fica estranho. Este arquivo já nasce sem
--  nenhum, em qualquer das duas colunas.
--
--  NÃO HÁ APÓSTROFO NO TEXTO. As frases foram escritas sem apóstrofo de
--  propósito, para não quebrar o literal do Postgres.
-- =====================================================================

-- A coluna da apostila, caso este arquivo seja o primeiro do grupo a
-- rodar neste banco. Se já existir, não acontece nada.
alter table public.trein_curso
  add column if not exists apostila text;


-- =====================================================================
--  NR-06: uso de EPI (4 horas)
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Conceito de EPI e de EPC, e a ordem de prioridade das medidas de proteção.
Obrigações do empregador quanto ao fornecimento, higienização e substituição.
Obrigações do trabalhador quanto ao uso, guarda e conservação.
Certificado de Aprovação: para que serve e como se confere a validade.
Proteção da cabeça: capacete, jugular e critérios de descarte.
Proteção dos olhos e da face: óculos, protetor facial e máscara de solda.
Proteção auditiva: tipos de protetor, atenuação e uso contínuo na exposição.
Proteção respiratória: escolha do filtro, vedação e limites de uso.
Proteção das mãos, dos pés e do corpo conforme o risco de cada tarefa.
Proteção contra quedas: cinto paraquedista, talabarte e ponto de ancoragem.
Inspeção antes do uso, higienização, guarda e descarte do equipamento.
Ficha de entrega, registro de treinamento e comunicação de EPI danificado.',
  apostila =
'## Por que esta norma existe

O equipamento de proteção individual é a última barreira entre você e o risco. Não é a primeira. Antes dele vem eliminar o perigo, trocar o produto por um menos agressivo, isolar a máquina, enclausurar o ruído, instalar exaustão, mudar o jeito de fazer a tarefa. Só quando nada disso resolve por completo é que entra o EPI.

Isso muda como você deve olhar para o capacete e para o protetor auricular. Eles não tornam o local seguro. Eles reduzem o dano quando o resto falhar. Um trabalhador de capacete embaixo de uma carga suspensa continua correndo risco de morte.

A NR-06 existe para garantir três coisas: que o equipamento certo seja escolhido para o risco certo, que ele seja entregue de graça e em bom estado, e que quem usa saiba usar.

> EPI que fica na mochila protege exatamente zero por cento. O número de acidentes com equipamento entregue e não usado é maior do que o de equipamento que falhou.

## Quando ela se aplica a você

Sempre que houver risco que as medidas coletivas não eliminaram. Na prática isso cobre quase todo serviço de obra, de indústria e de manutenção: ruído acima do limite, poeira, produto químico, respingo de solda, borda viva, piso escorregadio, trabalho acima de dois metros, energia elétrica.

A empresa é obrigada a fornecer sem cobrar nada. Se o equipamento quebrou ou venceu, ela troca. Se o seu serviço mudou e o risco mudou junto, ela fornece o novo. Você não paga por EPI, nem quando o dano foi seu.

## Antes de começar

Todo EPI tem um número de Certificado de Aprovação, o CA, gravado no próprio equipamento ou na etiqueta. Ele diz que aquele modelo foi ensaiado e aprovado para aquele risco. CA vencido ou ilegível vale como equipamento sem proteção.

Antes de vestir, faça a inspeção rápida:

- Capacete: casco sem trinca, sem furo de parafuso, sem tinta ou solvente por cima, jugular inteira e presa.
- Óculos: lente sem risco fundo que atrapalhe a visão, haste firme.
- Protetor auditivo: plugue limpo e sem endurecer, concha com almofada macia e arco com pressão.
- Luva: sem furo, sem corte, seca por dentro, do material certo para o produto.
- Bota: solado com desenho vivo, biqueira intacta, sem rasgo no cabedal.
- Cinto paraquedista: fita sem corte nem queimadura, costura inteira, fivela e mosquetão travando.

**Equipamento reprovado na inspeção sai de circulação na hora.** Não volta para o armário para outro pegar por engano.

## Durante o trabalho

O EPI só protege se estiver do jeito que foi projetado. Protetor auricular tipo plugue precisa entrar no canal, não encostar na orelha. Respirador precisa vedar na pele: barba fechada impede a vedação e transforma a máscara em enfeite. Capacete com a jugular solta cai antes da cabeça bater.

Tirar o protetor auditivo por cinco minutos parece pouco, mas a exposição ao ruído conta pelo tempo total do dia. Cinco minutos de britadeira sem proteção jogam fora boa parte da proteção das oito horas.

Trocar EPI com colega também tem regra. Protetor auricular de inserção e respirador são de uso pessoal, por causa de infecção e de vedação. Capacete e bota têm ajuste individual.

## Equipamento e os cuidados

Depois do turno, limpe. Protetor auricular com água e sabão neutro. Máscara com o pano e o produto que a empresa indicar. Cinto pendurado, nunca dobrado no fundo da caixa junto com ferramenta. Luva de raspa seca ao ar, longe de calor.

Guarde em lugar seco, sem sol direto e sem produto químico ao lado. O plástico do capacete resseca com sol e com solvente: um capacete que passou o verão no painel do carro já não aguenta o impacto para o qual foi ensaiado.

Filtro de respirador tem vida útil. Vence pelo prazo, pelo cheiro que começa a passar e pela dificuldade de puxar o ar. Não existe lavar filtro.

## O que a empresa deve, o que você deve

A empresa deve escolher o equipamento adequado ao risco com orientação do responsável técnico, fornecer gratuitamente, exigir o uso, treinar, substituir quando danificar ou vencer, higienizar quando for o caso e registrar tudo na ficha de entrega.

Você deve usar apenas para o fim a que se destina, cuidar, guardar, comunicar qualquer alteração que deixe o equipamento impróprio e cumprir o que foi ensinado no treinamento. Assinar a ficha de entrega não é formalidade: é a prova de que você recebeu, e também de que a empresa cumpriu.

Recusar o uso é falta grave e pode gerar sanção disciplinar. Mas o inverso também vale: se o EPI que você recebeu machuca, aperta, embaça ou não serve para o risco daquela tarefa, isso é problema técnico e precisa ser comunicado, e não resolvido tirando o equipamento escondido.

## Para lembrar

- **O EPI é a última barreira, não a primeira.** Se dá para eliminar o risco, elimine.
- Confira o **CA** e a validade. Sem CA não há proteção comprovada.
- Inspecione antes de vestir, todo dia, e retire de uso o que reprovar.
- **Respirador não veda em rosto com barba.**
- Proteção auditiva vale pelo tempo inteiro de exposição, não pela maior parte dele.
- Limpe, seque e guarde longe de sol, calor e produto químico.
- EPI é gratuito. Você nunca paga, nem por perda nem por dano.
- Comunicou defeito e não veio troca? Registre. Trabalhar sem proteção não é opção.'
where codigo = 'NR-06';


-- =====================================================================
--  NR-17: ergonomia (4 horas)
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Conceito de ergonomia e adaptação do trabalho às características do trabalhador.
Avaliação ergonômica preliminar e análise ergonômica do trabalho.
Levantamento, transporte e descarga manual de materiais.
Postura sentada, postura em pé e alternância entre elas.
Mobiliário, bancada, assento e apoio para os pés.
Trabalho com computador: tela, teclado, mouse e distância de leitura.
Movimentos repetitivos, força excessiva e tempo de recuperação.
Organização do trabalho: ritmo, metas, pausas e revezamento.
Condições ambientais: iluminação, ruído, temperatura e ventilação.
Sinais precoces de lesão por esforço e distúrbios osteomusculares.
Manuseio de cargas com auxílio mecânico e trabalho em dupla.
Comunicação de desconforto e acompanhamento pela saúde ocupacional.',
  apostila =
'## Por que esta norma existe

Acidente de trabalho todo mundo reconhece: cai, corta, queima. A lesão por esforço não tem esse barulho. Ela chega devagar, ao longo de meses, e quando incomoda de verdade já virou tendinite, hérnia de disco ou ombro que não levanta mais.

A NR-17 existe para inverter a lógica que sempre se usou. Em vez de exigir que o corpo do trabalhador aguente o posto de trabalho, ela manda **adaptar o posto ao corpo de quem trabalha**. A bancada é que sobe, o peso é que diminui, a pausa é que entra na conta da produção.

Isso vale para obra, para linha de produção, para almoxarifado, para escritório e para teleatendimento. Onde há gente trabalhando há ergonomia.

## Quando ela se aplica a você

Se você levanta peso, repete o mesmo movimento centenas de vezes por turno, fica muito tempo na mesma posição, trabalha agachado, com o braço acima do ombro, com o pulso torcido, ou passa o dia numa cadeira ruim, a norma está falando de você.

A empresa faz uma avaliação ergonômica preliminar dos postos. Quando ela aponta risco, vem a análise ergonômica do trabalho, mais completa, feita por profissional habilitado, com recomendações que viram plano de ação.

> Dor que vai e volta sempre no mesmo lugar e no mesmo horário do turno não é cansaço normal. É aviso.

## Antes de começar

Antes de erguer qualquer coisa, faça três perguntas: quanto pesa, para onde vai, e dá para não carregar no braço.

Boa parte das lesões de coluna acontece em cargas que ninguém considerava pesadas. O que machuca não é só o peso, é a combinação de peso, distância do corpo, altura de pega e giro de tronco. Vinte quilos colados no peito são muito menos agressivos que dez quilos de braço esticado com o corpo torcido.

Olhe o caminho antes: piso molhado, degrau, mangueira no chão, porta fechada, gente passando. Carga na frente do rosto tapa a vista, e o tropeço vem daí.

## Durante o trabalho

O levantamento correto é sempre o mesmo desenho:

- Chegue perto da carga, pés afastados na largura dos ombros.
- Dobre os joelhos e o quadril, e mantenha as costas retas.
- Pegue firme, com as duas mãos, e traga a carga junto ao corpo.
- Suba com a força das pernas, sem solavanco.
- **Para mudar de direção, mova os pés. Nunca gire o tronco com peso na mão.**
- Para descer, dobre os joelhos de novo. Não largue a carga de qualquer jeito.

Se a carga é comprida, desengonçada, ou se você precisa prender a respiração para levantar, ela não é sua sozinho. Chame ajuda ou use carrinho, paleteira, talha. Pedir equipamento não é frescura, é a solução que a norma manda usar primeiro.

Para quem fica em pé o turno inteiro: alterne o apoio, use um estrado para descansar um pé, e cadeira para as pausas. Para quem fica sentado: pés apoiados no chão ou no descanso, joelhos em ângulo aberto, coluna encostada, tela na altura dos olhos, antebraço apoiado. Cotovelo no ar o dia todo vira dor de ombro.

Movimento repetitivo pede tempo de recuperação. Vinte minutos parados alongando resolvem menos do que pequenas trocas de tarefa distribuídas ao longo do turno.

### Luz, ruído e calor também são ergonomia

Iluminação fraca faz o trabalhador aproximar o rosto da peça e curvar o pescoço o dia inteiro. Iluminação forte e mal posicionada gera reflexo na tela e na chapa polida, e o resultado é o mesmo: dor de cabeça no fim do turno e postura torta para fugir do brilho. A luz deve chegar de lado, sobre a tarefa, e não de frente para os olhos.

Ruído contínuo cansa mesmo abaixo do limite que causa surdez, porque obriga a atenção a trabalhar dobrado. Calor faz perder líquido, tira força e aumenta o erro. Água fresca ao alcance da mão e pausa em local ameno não são cortesia: são medida de controle.

## A organização do trabalho também é ergonomia

Este é o ponto que mais se esquece. Uma bancada perfeita não salva ninguém se a meta exige ritmo que impede parar. Pressão por produção, jornada esticada, banheiro contado, hora extra frequente e revezamento mal feito produzem lesão do mesmo jeito que ferramenta pesada.

Por isso a norma trata de pausas, de metas, de ritmo e de conteúdo da tarefa. Um posto ergonômico com ritmo desumano continua sendo um posto que adoece.

## O que a empresa deve, o que você deve

A empresa deve avaliar os postos, adequar mobiliário e equipamento, fornecer meio mecânico para cargas, organizar pausas, tratar as recomendações da análise ergonômica em plano de ação com prazo e responsável, e acompanhar a saúde de quem está exposto.

Você deve usar os recursos que existem, mesmo quando dão um pouco mais de trabalho, aplicar a técnica de levantamento que aprendeu, fazer as pausas de verdade e, principalmente, **comunicar cedo**. Formigamento na mão ao acordar, dor no ombro que aparece sempre depois da mesma tarefa, ardência no antebraço: isso vai para a saúde ocupacional enquanto ainda tem conserto fácil.

Esconder sintoma para não perder produção ou para não ser trocado de função é o caminho mais curto para o afastamento longo.

## Para lembrar

- Ergonomia é **adaptar o trabalho ao trabalhador**, e não o contrário.
- Peso longe do corpo e giro de tronco machucam mais que peso alto.
- **Pernas levantam, costas não.** Para virar, mexa os pés.
- Carga que exige prender a respiração pede ajuda ou equipamento.
- Alterne postura e alterne tarefa: o corpo precisa de tempo de recuperação.
- Tela na altura dos olhos, pés apoiados, antebraço apoiado.
- Ritmo, meta e pausa fazem parte da ergonomia tanto quanto a bancada.
- Dor que repete no mesmo lugar e no mesmo horário é para comunicar hoje.'
where codigo = 'NR-17';


-- =====================================================================
--  NR-26: sinalização de segurança (4 horas)
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Finalidade da sinalização de segurança e seus limites como medida de proteção.
Cores de segurança e seu significado padronizado no ambiente de trabalho.
Vermelho, amarelo, verde, azul, laranja e branco: onde cada um se aplica.
Delimitação de áreas, faixas de circulação e sinalização de piso.
Identificação de tubulações por cor e por rótulo de conteúdo.
Rotulagem preventiva de produtos químicos e sistema globalmente harmonizado.
Pictogramas de perigo, palavra de advertência e frases de perigo.
Ficha com dados de segurança do produto químico: onde fica e como se lê.
Sinalização de emergência: saídas, extintores, hidrantes e chuveiro de segurança.
Placas de advertência, de proibição e de obrigação em área de obra.
Sinalização provisória de serviço, bloqueio de área e cones.
Responsabilidade pelo respeito à sinalização e o que fazer quando ela falta.',
  apostila =
'## Por que esta norma existe

Sinalização é a maneira mais barata e mais rápida de avisar de um perigo. Uma faixa no chão, uma cor numa tubulação ou um pictograma num rótulo dizem em um segundo o que um procedimento leva três páginas para explicar. E há situações em que só existe esse segundo.

A NR-26 padroniza essas cores e esses rótulos. O ganho da padronização é que a mensagem funciona para quem chegou hoje, para o terceiro que nunca entrou naquela área e para o motorista que só veio entregar.

> Sinalização avisa, não protege. Placa de alta tensão não isola nada. Ela existe para que você não chegue perto do que continua energizado.

## Quando ela se aplica a você

Em toda a instalação. Você é afetado nas duas pontas: como quem **lê** a sinalização para saber por onde andar e o que não tocar, e como quem **coloca** sinalização quando abre um serviço, isola uma área ou transfere um produto para outro recipiente.

A segunda ponta é onde mais se erra. Quem passa produto químico do tambor para o galão e não rotula cria um risco que não existia.

## As cores e o que elas dizem

- **Vermelho**: identifica equipamento e material de combate a incêndio. Extintor, hidrante, sirene, botão de parada de emergência, caixa de mangueira. Por isso não se pinta de vermelho o que não for de emergência, e não se guarda nada em cima da área vermelha do piso.
- **Amarelo**: cuidado, atenção. Corrimão, parapeito, borda de plataforma, batente de degrau, partes móveis de máquina, faixas de piso que avisam desnível ou passagem baixa.
- **Verde**: segurança. Caixa de primeiros socorros, chuveiro de emergência e lava olhos, maca, quadro de aviso de segurança, EPI guardado.
- **Azul**: ação obrigatória e advertência contra acionamento. Placa que manda usar protetor auricular, e o aviso posto no comando de equipamento em manutenção para que ninguém ligue.
- **Laranja**: partes móveis e perigosas de máquina expostas, face interna de guarda que foi aberta, borda cortante.
- **Branco**: circulação. Faixa de pedestre interna, área de armazenamento demarcada, direção de fluxo.
- **Púrpura**: risco de radiação ionizante.
- **Lilás**: identificação de canalizações e sinalizações específicas conforme o padrão adotado na instalação.

O que você não pode fazer é inventar cor. Fita amarela improvisada para dizer proibido passar confunde: amarelo é atenção, e isolamento de área se faz com o material e a placa que a empresa definiu.

## Tubulação: a cor do tubo salva vida

Numa indústria passam água, vapor, ar comprimido, gás combustível, ácido e produto inflamável pelo mesmo corredor de tubos. Abrir a válvula errada, ou soldar no tubo errado, é acidente grave.

Por isso a tubulação recebe cor de identificação e, junto dela, **rótulo com o nome do produto e seta indicando o sentido do fluxo**. A regra prática é simples: se você não consegue ler no próprio tubo o que passa dentro dele, você não abre, não corta, não solda e não apoia nada nele. Vai perguntar.

## Rótulo de produto químico

O rótulo preventivo segue o sistema harmonizado e traz sempre os mesmos elementos: **pictograma** em losango vermelho, **palavra de advertência** (perigo ou atenção), nome do produto, frases de perigo, frases de precaução e quem fabrica.

Os pictogramas mais comuns na obra e na indústria são a chama para inflamável, a caveira para tóxico agudo, o ponto de exclamação para irritante, os tubos de ensaio derramando para corrosivo, e o busto com a mancha no tórax para produto que causa dano grave à saúde.

Cada produto tem também a ficha com dados de segurança. É o documento que diz o que fazer no derramamento, no contato com a pele, na inalação e no incêndio. Ela precisa estar acessível onde o produto é usado, e não trancada numa gaveta do escritório.

**Recipiente sem rótulo se trata como desconhecido: ninguém abre, ninguém cheira, ninguém usa.** Garrafa de refrigerante com líquido dentro é um dos acidentes mais antigos e mais bobos que existem.

## Emergência

A sinalização de emergência só funciona se estiver visível no dia ruim, com fumaça, correria e pouca luz. Saída de emergência, luminária autônoma, seta de rota de fuga, extintor e chuveiro lava olhos precisam estar desobstruídos o tempo todo.

Ninguém encosta pallet na frente do hidrante, nem guarda material no corredor de saída, nem pendura pano no extintor. Se você viu isso, tirar leva trinta segundos e faz parte do seu trabalho.

## O que a empresa deve, o que você deve

A empresa deve padronizar e manter a sinalização, rotular tudo, identificar tubulações, disponibilizar as fichas de segurança, treinar os trabalhadores no significado das cores e dos pictogramas, e repor placa apagada ou quebrada.

Você deve respeitar a sinalização mesmo quando ela atrapalha o caminho, sinalizar o serviço que abrir, rotular todo recipiente que encher, não remover placa nem isolamento de área que não seja seu, e avisar quando faltar sinalização ou quando ela estiver ilegível.

## Para lembrar

- **Sinalização avisa, não protege.** Continue tratando o perigo como perigo.
- Vermelho é incêndio, amarelo é cuidado, verde é segurança, azul é obrigação.
- Não se guarda nem se encosta nada sobre área vermelha ou de emergência.
- Tubo sem identificação legível não se abre, não se corta e não se solda.
- Todo recipiente rotulado, inclusive o pequeno que você encheu agora.
- **Recipiente sem rótulo é produto desconhecido e ninguém usa.**
- A ficha de segurança fica onde o produto é usado.
- Serviço aberto é área isolada, com a placa e a barreira que a empresa definiu.'
where codigo = 'NR-26';


-- =====================================================================
--  LOTO: bloqueio e etiquetagem (4 horas)
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Objetivo do bloqueio e etiquetagem e sua relação com a segurança em máquinas.
Acidentes por partida inesperada e por energia residual armazenada.
Tipos de energia perigosa: elétrica, mecânica, hidráulica, pneumática e térmica.
Energia química, gravitacional e energia acumulada em molas e capacitores.
Identificação dos pontos de isolamento de cada equipamento.
Dispositivos de bloqueio: cadeado, garra múltipla, bloqueador de válvula e de disjuntor.
Etiqueta de identificação: quem bloqueou, quando e por quê.
Sequência de aplicação do bloqueio, do desligamento à dissipação de energia.
Teste de energia zero antes de iniciar a intervenção.
Bloqueio individual, bloqueio de grupo e caixa de bloqueio coletivo.
Passagem de turno com equipamento bloqueado e continuidade do serviço.
Sequência de liberação, retirada de cadeado esquecido e retomada segura.',
  apostila =
'## Por que este procedimento existe

A maioria dos acidentes graves de manutenção tem a mesma história. O equipamento parou, o mecânico entrou, e alguém ligou. Ou o equipamento parou, o mecânico entrou, e a máquina se moveu sozinha porque ainda havia pressão no circuito, peso suspenso ou mola comprimida.

LOTO vem de lockout e tagout: **bloquear** a fonte de energia com um cadeado físico e **etiquetar** dizendo quem bloqueou. Não é norma numerada no Brasil, mas é exigido na prática pela NR-12 e por qualquer sistema de gestão sério, porque é o único jeito comprovado de garantir que a máquina não volte a funcionar enquanto tem gente dentro dela.

> Aviso verbal não é bloqueio. Cartaz sozinho não é bloqueio. Botão de emergência apertado não é bloqueio. Bloqueio é cadeado.

## Quando ele se aplica a você

Sempre que você for intervir num equipamento em que a partida inesperada, o movimento residual ou a liberação de energia possam machucar alguém. Manutenção mecânica ou elétrica, limpeza interna, desobstrução, troca de ferramenta, ajuste, inspeção dentro de zona de risco, retirada de proteção.

A dúvida comum é o serviço rápido. **Serviço rápido é o que mais mata**, exatamente porque a pessoa acha que não vale a pena bloquear por dois minutos. Vale.

Vale a pena dizer também o que **não** conta como bloqueio, porque cada um destes já apareceu em relatório de acidente grave:

- Botão de emergência apertado. Ele para, mas não impede que alguém gire e ligue.
- Chave geral desligada sem cadeado, com o painel destrancado.
- Aviso no rádio ou combinação verbal com o operador.
- Placa de papel colada no comando, sozinha.
- Fusível retirado e guardado no bolso.
- Colega postado na frente do painel para não deixar ninguém ligar.

Todos falham do mesmo jeito: dependem de alguém lembrar. O cadeado não depende.

## Todas as energias, não só a elétrica

Bloquear o disjuntor é o passo mais lembrado e quase nunca é o único. Faça a lista do equipamento:

- **Elétrica**: painel, disjuntor, chave seccionadora, tomada industrial.
- **Mecânica**: eixo girando por inércia, volante, correia, rolo que continua rodando depois de desligado.
- **Hidráulica**: pressão no cilindro e na tubulação, mesmo com a bomba parada.
- **Pneumática**: ar comprimido no reservatório e nas linhas.
- **Gravitacional**: caçamba levantada, mesa elevatória, carga suspensa, contrapeso.
- **Térmica**: vapor, água quente, superfície que ainda está a duzentos graus.
- **Química**: produto na linha, gás residual, vapor inflamável.
- **Acumulada**: mola comprimida, capacitor carregado, acumulador hidráulico.

Cada uma dessas precisa ser isolada e depois **dissipada**: abrir o purgador, aliviar a pressão, descer a carga e apoiar no calço, aterrar, drenar, esperar esfriar.

## A sequência do bloqueio

- Avise quem opera e quem depende do equipamento.
- Desligue pelo comando normal, na ordem correta de parada.
- Isole cada fonte de energia identificada no ponto próprio.
- Aplique o **seu** dispositivo de bloqueio em cada ponto isolado.
- Prenda a etiqueta com o seu nome, a data, a hora e o motivo.
- Dissipe a energia residual: alivie, drene, descarregue, calce, aterre.
- Faça o **teste de energia zero**: tente acionar pelo comando, meça com instrumento, confirme que não há pressão nem movimento.
- Só depois disso ponha a mão no equipamento.

O teste de energia zero é o passo que ninguém pode pular. Ele é a diferença entre acreditar que a máquina está desligada e saber que está.

## Cada um com o seu cadeado

O cadeado é individual, e a chave fica com quem está trabalhando, no bolso. Não existe cadeado do setor pendurado com a chave no quadro.

Quando a equipe é grande, usa-se garra múltipla, que aceita vários cadeados no mesmo ponto, ou caixa de bloqueio coletivo: a chave do bloqueio principal fica trancada dentro da caixa, e cada trabalhador põe o seu cadeado na tampa. **Enquanto houver um único cadeado na caixa, a chave não sai, e o equipamento não liga.**

Se o serviço atravessa a troca de turno, o bloqueio não é retirado. Quem entra coloca o cadeado antes de quem sai retirar o seu, e o equipamento nunca fica sem proteção no intervalo.

## A liberação

Liberar tem regra tanto quanto bloquear:

- Termine o serviço e recoloque todas as proteções que foram retiradas.
- Retire ferramenta, pano, escada e peça de dentro da máquina.
- Confira que não há ninguém na zona de risco, e avise em voz alta.
- Cada trabalhador retira o próprio cadeado e a própria etiqueta.
- Religue e acompanhe a primeira partida.

Cadeado esquecido por alguém que foi embora não se corta por conta própria. Existe um procedimento de exceção, com autorização de quem responde pela área, tentativa de contato com o dono do cadeado e conferência física de que não há pessoa no equipamento. **Cortar cadeado dos outros por pressa é uma das piores decisões possíveis dentro de uma fábrica.**

## O que a empresa deve, o que você deve

A empresa deve ter procedimento escrito por equipamento, com os pontos de isolamento mapeados, fornecer cadeados e dispositivos suficientes, treinar e autorizar formalmente quem bloqueia, e auditar.

Você deve bloquear sempre, com o seu cadeado, testar energia zero, nunca confiar em bloqueio feito por outro sem colocar o seu, nunca operar equipamento etiquetado por terceiro, e comunicar quando faltar dispositivo ou quando o ponto de isolamento não existir.

## Para lembrar

- **Bloqueio é cadeado físico.** Aviso e cartaz não bloqueiam nada.
- Liste todas as energias, não apenas a elétrica.
- Isolou, dissipou. Pressão, carga suspensa, calor e mola também matam.
- **Teste de energia zero antes de encostar.** Sempre.
- Cadeado individual, chave no bolso do dono.
- Um cadeado na caixa já impede a partida de todo o conjunto.
- Serviço rápido também se bloqueia.
- Cadeado de terceiro não se corta: existe procedimento para isso.'
where codigo = 'LOTO';


-- =====================================================================
--  NR-34.5: trabalho a quente (8 horas)
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Definição de trabalho a quente e atividades abrangidas pelo procedimento.
Riscos de incêndio, explosão, queimadura, radiação e fumos metálicos.
Permissão de trabalho: emissão, validade, encerramento e responsáveis.
Análise de risco da tarefa e inspeção prévia da área de execução.
Identificação e remoção de materiais combustíveis no entorno.
Medição de gases e atmosferas explosivas antes e durante o serviço.
Isolamento da área, biombos, mantas e proteção de aberturas e drenos.
Função do vigia de fogo, seus limites e a vigilância após o término.
Equipamentos de oxicorte: cilindros, mangueiras, válvulas e retorno de chama.
Solda elétrica: cabos, aterramento, porta eletrodo e risco de choque.
Proteção individual específica: máscara de solda, vestimenta e respiratória.
Trabalho a quente em espaço confinado, em altura e próximo a inflamáveis.
Ventilação, exaustão e controle da exposição a fumos de solda.
Emergência: combate a princípio de incêndio, alarme e atendimento a queimadura.',
  apostila =
'## Por que esta norma existe

Trabalho a quente é toda atividade que produz chama, calor intenso ou faísca: solda elétrica, oxicorte, esmerilhamento, maçarico, aquecimento, corte com disco abrasivo.

O item 34.5 da NR-34 organizou esse trabalho na indústria naval, e o procedimento que ele descreve virou referência para obra e para indústria em geral, junto com o que a NR-20 exige perto de inflamáveis.

A razão é simples de entender e difícil de esquecer depois que se vê uma vez. Uma faísca de esmeril viaja mais de dez metros, entra por fresta, cai por vão de piso e continua quente depois de cair. Ela não precisa iniciar o fogo na hora: pode ficar horas numa poeira de serragem ou num pano com óleo e virar incêndio quando já não há ninguém no local.

> Grande parte dos incêndios industriais começa em serviço de solda já terminado. O fogo aparece depois que a equipe foi embora.

## Quando ela se aplica a você

Sempre que houver chama, calor ou faísca fora de um local fixo e preparado para isso. Numa bancada de solda, com piso incombustível e exaustão, o risco está controlado pelo próprio arranjo do local. Fora dela, cada serviço é um caso novo e precisa de **permissão de trabalho**.

A permissão não é burocracia. É o documento em que alguém tecnicamente responsável olhou aquela área, aquele dia e aquela tarefa e disse o que precisa ser feito antes de acender.

## Antes de começar

A permissão de trabalho traz a análise de risco e as condições. Antes de assinar e antes de acender, confira você mesmo:

- **Combustível no entorno**: retire tudo que queima num raio adequado. Papelão, madeira, estopa, plástico, tambor vazio de solvente, isolamento térmico, pintura fresca.
- **O que não dá para retirar**: cubra com manta de proteção térmica, nunca com lona plástica.
- **Aberturas**: vão de piso, junta de dilatação, canaleta, ralo, dreno e caixa de passagem são por onde a faísca some. Tape.
- **Atmosfera**: onde houver histórico de gás, vapor ou líquido inflamável, há medição antes e monitoramento durante. Tanque, linha e área classificada não recebem chama sem liberação explícita.
- **Ventilação**: fumo de solda em local fechado intoxica. Exaustão local ou ventilação forçada.
- **Extintor**: do tipo certo, carregado, ao alcance da mão, e não a cinquenta metros.
- **Isolamento**: biombo para proteger a vista de quem passa, sinalização e barreira.

Confira o equipamento também. Cabo de solda com emenda descascada, porta eletrodo trincado, mangueira de oxicorte ressecada, cilindro deitado ou sem capacete, válvula corta chamas ausente: nada disso entra em serviço.

## Durante o trabalho

O vigia de fogo fica com uma tarefa única: olhar o entorno e a trajetória das faíscas, com extintor na mão. **Ele não ajuda a segurar peça, não busca ferramenta e não vai almoçar antes.** No momento em que ele faz outra coisa, deixou de existir.

Ele precisa saber acionar o alarme, saber onde fica o hidrante, e ter meio de comunicação. Quando o serviço é feito de um lado de uma parede ou de um piso, a vigilância acontece **dos dois lados**: calor atravessa chapa e a faísca cai no andar de baixo.

Para o soldador, três cuidados que custam caro quando faltam:

- Aterramento do circuito de solda preso na peça, perto do ponto de trabalho. Retorno improvisado pela estrutura faz corrente circular por onde ninguém espera.
- Vestimenta de raspa ou tecido tratado, sem bolso aberto e sem bainha virada, que é onde a escória se aloja. Nada de tecido sintético por baixo: ele derrete na pele.
- Máscara com o tom de lente adequado ao processo. Vista de solda queima em segundos e a dor chega horas depois.

Em espaço confinado, trabalho a quente soma duas normas: não se entra sem liberação de espaço confinado, sem vigia próprio e sem monitoramento contínuo de atmosfera. Em altura, a faísca cai sobre gente e material que estão muito longe do seu campo de visão.

## Cilindros e gases

Cilindro fica em pé, amarrado, com válvula protegida e longe de fonte de calor. Oxigênio e graxa ou óleo formam combinação explosiva: mão engraxada não encosta em válvula de oxigênio.

Mangueira tem cor própria por gás e não se troca uma pela outra. **Válvula corta chamas nos dois lados evita o retorno de chama**, que é quando o fogo entra pela mangueira e chega ao cilindro. Vazamento se procura com água e sabão, nunca com isqueiro.

Ao terminar, feche primeiro a válvula do cilindro, alivie a pressão das mangueiras e recolha o conjunto.

## Depois de apagar: a parte esquecida

O serviço não termina quando o maçarico apaga. A vigilância continua por um período definido no procedimento, tipicamente pelo menos trinta minutos, e mais tempo quando há material combustível próximo, vão de piso ou dificuldade de acesso.

Passe a mão pela área com o dorso, olhe o piso de baixo, procure cheiro de queimado, confira as caixas e canaletas que você tapou. Só depois disso a permissão é encerrada e assinada.

## Emergência

Se o fogo começou, ataque enquanto é princípio, com o extintor certo e com saída garantida atrás de você. Se ele passou disso, acione o alarme, evacue e feche o que der para fechar.

Queimadura se resfria com água corrente em abundância, por vários minutos. Não se passa pasta, pomada caseira, óleo nem manteiga, e não se estoura bolha. Roupa colada na pele não se arranca. Vista de solda queimada se trata com compressa fria, ambiente escuro e avaliação médica.

## Para lembrar

- **Sem permissão de trabalho válida, não acende.**
- Faísca viaja longe, entra por fresta e cai por vão de piso: tape tudo.
- Retire o combustível; o que não sair, cubra com manta, nunca com plástico.
- Onde houver inflamável, mede-se gás antes e durante.
- **Vigia de fogo não faz outra coisa**, e vigia os dois lados da parede.
- Cilindro em pé e amarrado; oxigênio nunca perto de graxa ou óleo.
- Válvula corta chamas nos dois lados da mangueira.
- **A vigilância continua depois de apagar**, no mínimo trinta minutos.
- Queimadura: água corrente e serviço médico. Nada de pomada caseira.'
where codigo = 'NR-34.5';


-- =====================================================================
--  NR-01-INT4: integração de segurança, 4 horas
--  Público: recém admitido. Foco: atravessar a primeira semana inteiro.
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Apresentação da empresa, das áreas e das regras de convivência no local de trabalho.
Direitos e deveres do trabalhador quanto à segurança e à saúde no trabalho.
Ordem de serviço: o que ela informa e por que deve ser assinada e compreendida.
Riscos existentes nas áreas por onde o trabalhador vai circular.
Circulação segura, faixas de pedestre, trânsito de veículos e áreas restritas.
Equipamentos de proteção individual exigidos e como obtê-los.
Regras básicas de altura, eletricidade, máquinas e produtos químicos.
Sinalização, isolamento de área e placas que não podem ser ultrapassadas.
Comunicação de condição insegura e a quem recorrer em cada situação.
Procedimento em caso de acidente, mal estar ou quase acidente.
Rota de fuga, ponto de encontro e alarme de emergência.
O direito de recusar tarefa com risco grave e iminente.',
  apostila =
'## Bem vindo, e a razão desta conversa

Você está começando. Este material trata de uma coisa só: **o que você precisa saber hoje para chegar inteiro no fim da primeira semana.**

Isso não é exagero de treinamento. Trabalhador recém admitido se acidenta mais que o veterano, e não por falta de capricho. É porque ele ainda não sabe por onde a empilhadeira passa, não sabe qual porta abre para dentro, não sabe que aquele piso fica escorregadio depois da lavagem, e tem vergonha de perguntar.

> A pergunta que você não fez hoje é o acidente da semana que vem. Ninguém aqui acha ruim que você pergunte. Acham ruim quando você adivinha.

## Seus direitos e seus deveres

A lei é clara nos dois lados. A empresa deve informar os riscos do seu trabalho, fornecer equipamento de proteção de graça, treinar e manter o local seguro. Você deve seguir as instruções, usar o que recebeu, cuidar da sua segurança e da de quem está ao seu lado, e avisar quando algo estiver errado.

Há um direito que precisa ser dito com todas as letras: **você pode interromper uma tarefa quando houver risco grave e iminente**, e deve comunicar imediatamente ao superior. Ninguém é punido por isso. Punido é quem manda alguém entrar num risco desses.

## A ordem de serviço

Logo no início você recebe a ordem de serviço da sua função. É um papel curto que diz quais riscos existem na sua atividade, como se protege deles, e o que é proibido.

Leia antes de assinar. Se tiver palavra que você não entendeu, pergunte na hora. Assinatura em documento que você não leu não ajuda você em nada.

## As primeiras coisas a aprender no local

Antes de começar o serviço, procure saber, com quem já está lá:

- Onde ficam as **saídas de emergência** e para onde vai a rota de fuga.
- Onde é o **ponto de encontro** e como é o som do alarme.
- Onde estão o extintor, o hidrante e a caixa de primeiros socorros.
- Quem é o seu encarregado e quem é o técnico de segurança da área.
- Por onde passa veículo, empilhadeira ou carga suspensa.
- Onde ficam o vestiário, o refeitório e a água potável.

Circule pelas faixas marcadas. Área demarcada e isolada não se atravessa por atalho, mesmo vazia: se está isolada, alguém isolou por um motivo que você ainda não conhece.

## O básico de cada risco

**Altura.** Acima de dois metros, só com treinamento específico, cinto paraquedista e ponto de ancoragem definido. Escada apoiada não é plataforma de trabalho, e ninguém sobe em caixa, tambor ou pallet empilhado.

**Eletricidade.** Painel elétrico é área de eletricista autorizado. Você não abre, não mexe e não improvisa emenda. Fio descascado, tomada quente e cheiro de queimado se comunica na hora.

**Máquinas.** Proteção de máquina não se retira nem se amarra para ficar aberta. Máquina com etiqueta ou cadeado de manutenção não se liga por nenhum motivo, nem para testar.

**Produto químico.** Recipiente sem rótulo é produto desconhecido. Não cheire, não prove, não transfira para garrafa de bebida. Antes de usar, leia o rótulo e pergunte qual proteção é exigida.

**Piso e organização.** Grande parte das quedas acontece em piso escorregadio, tropeço em cabo e ferramenta largada. Recolher o que você usou faz parte da tarefa, e não é serviço de limpeza.

## Seu EPI

O equipamento é entregue de graça, contra assinatura na ficha. Confira antes de usar e comunique defeito. Bota, capacete e o que mais a sua função exigir se usam o tempo todo em área de risco, e não apenas quando passa a fiscalização.

Se o equipamento não serve, aperta ou machuca, isso se resolve pedindo troca, e nunca deixando de usar.

## Sobre pegar peso e sobre o corpo

Muita gente se machuca na primeira semana tentando mostrar serviço. Carga que pesa demais para um se leva em dois, ou com carrinho. Para levantar, chegue perto, dobre os joelhos, mantenha as costas retas e traga o peso junto ao corpo. **Para virar, mova os pés; nunca gire o tronco com peso na mão.**

Beba água ao longo do turno, principalmente em serviço ao sol. Desidratação dá tontura, cãibra e erro de atenção, e isso é acidente esperando acontecer. Se estiver tomando remédio que dá sono, avise o encarregado antes de começar.

## Se acontecer alguma coisa

- **Não se mexe no acidentado sem necessidade.** Chame ajuda e a brigada.
- Comunique o acidente imediatamente, por menor que pareça. Corte pequeno que infecciona vira afastamento, e acidente não comunicado no dia complica o seu direito depois.
- Mal estar, tontura, falta de ar e dor no peito param o serviço na hora.
- **Quase acidente também se comunica.** A carga que quase caiu hoje é a que cai amanhã.
- Ao ouvir o alarme, pare, desligue o que estiver na mão, saia pela rota e vá ao ponto de encontro. Não volte para buscar nada.

## O que ninguém faz aqui

- Não se corre no local de trabalho, nem para atender ao rádio.
- Não se usa celular caminhando em área de circulação de veículo.
- Não se trabalha sob efeito de álcool ou de medicamento que dá sono sem avisar.
- Não se improvisa ferramenta nem se sobe em estrutura provisória.
- Não se faz brincadeira de empurrar, assustar ou apontar mangueira de ar.

## Para lembrar

- Na dúvida, **pergunte antes**. Nunca adivinhe.
- Saiba hoje onde ficam a saída, o alarme e o ponto de encontro.
- Leia a ordem de serviço antes de assinar.
- Área isolada não se atravessa; proteção de máquina não se retira.
- **Todo acidente e todo quase acidente se comunicam no mesmo dia.**
- EPI é gratuito e se usa o tempo inteiro na área de risco.
- Recipiente sem rótulo ninguém abre.
- **Risco grave e iminente dá a você o direito de parar**, avisando o superior.'
where codigo = 'NR-01-INT4';


-- =====================================================================
--  NR-01-INT8: integração à NR-01, 8 horas
--  Público: quem participa da gestão de risco. Foco: GRO, PGR,
--  inventário, plano de ação e hierarquia de controle.
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Estrutura das Normas Regulamentadoras e o papel da NR-01 como norma geral.
Gerenciamento de riscos ocupacionais: conceito, abrangência e ciclo de melhoria.
Programa de gerenciamento de riscos: composição, guarda e prazos de revisão.
Levantamento preliminar de perigos e fontes de informação utilizadas.
Inventário de riscos: identificação, avaliação e classificação dos riscos ocupacionais.
Matriz de risco, critérios de tolerabilidade e priorização das ações.
Hierarquia de medidas de controle, da eliminação ao equipamento individual.
Plano de ação: medida, responsável, prazo e verificação de eficácia.
Análise de acidentes e de quase acidentes e retorno ao inventário.
Emergências: cenários previstos, recursos necessários e simulados.
Interfaces com o programa de controle médico e com o exame ocupacional.
Papéis da direção, do SESMT, da CIPA, das lideranças e dos trabalhadores.
Contratantes e contratadas: responsabilidades e harmonização de riscos.
Documentação, indicadores, auditoria e fiscalização do trabalho.',
  apostila =
'## Por que esta norma existe

As demais normas dizem como fazer cada tarefa perigosa. A NR-01 diz **como a empresa deve enxergar o próprio risco antes de qualquer tarefa começar**. Ela é a norma que organiza as outras.

A mudança de fundo foi trocar programa de papel por processo vivo. Não basta ter um documento arquivado: é preciso saber quais perigos existem, quanto valem, o que está sendo feito a respeito, por quem, até quando, e se funcionou.

Este material é para quem participa desse processo: liderança, membro de CIPA, encarregado, técnico, quem emite ordem de serviço e quem responde por contrato de terceiros.

> Inventário que nunca muda é sinal ruim. Se em dois anos nada foi acrescentado nem baixado, ninguém está olhando para o processo real.

## O gerenciamento de riscos ocupacionais

O GRO não é um documento, é um ciclo. Ele se repete sem parar:

- **Levantar** os perigos de cada processo, área e função.
- **Avaliar** os riscos que decorrem deles.
- **Classificar** por gravidade e probabilidade, para saber o que vem primeiro.
- **Controlar**, seguindo a hierarquia de medidas.
- **Acompanhar** a eficácia e voltar ao início quando algo muda.

O que dispara uma nova volta do ciclo: máquina nova, produto novo, mudança de layout, mudança de processo, acidente, quase acidente, resultado de exame ocupacional que aponta grupo afetado, inspeção que encontra desvio repetido, e o prazo de revisão periódica.

## O documento: PGR

O programa de gerenciamento de riscos é onde o ciclo fica registrado. Ele tem duas peças centrais, e as duas precisam existir de verdade:

**Inventário de riscos.** A relação dos perigos identificados, onde ocorrem, quem está exposto, qual a consequência possível, quais controles já existem e qual a classificação resultante. Deve descrever o trabalho como ele acontece, incluindo a manutenção, a partida, a parada e o serviço eventual, e não apenas a operação normal.

**Plano de ação.** Cada risco que precisa ser tratado vira uma linha com quatro campos que não podem ficar vazios: **a medida, o responsável com nome, o prazo com data e a forma de verificar se deu certo**. Plano sem responsável e sem data é lista de desejos.

Micro e pequenas empresas de menor grau de risco têm tratamento simplificado, e a declaração de inexistência de risco só vale quando ela é verdadeira. Prestar declaração falsa é problema sério, e cai por terra no primeiro acidente.

## Como se classifica um risco

A classificação combina duas perguntas: **quão grave é a consequência possível** e **qual a probabilidade de acontecer**. A matriz cruza as duas e devolve um nível.

O que importa é o uso que se faz do resultado. O nível define prazo e prioridade. Risco intolerável exige medida antes de continuar a atividade. Risco moderado entra no plano com prazo. Risco baixo fica monitorado.

Dois erros comuns aparecem aqui. O primeiro é classificar pela frequência do acidente passado, e não pelo dano possível: uma tarefa que nunca deu problema mas pode matar continua sendo risco alto. O segundo é classificar considerando o EPI como se ele eliminasse o risco. Ele reduz a consequência; não apaga o perigo.

## Hierarquia de controle

Esta é a espinha da NR-01 e vale a ordem, e não apenas a lista:

- **Eliminação** do perigo ou do fator de risco. Deixar de usar o produto, suprimir a etapa, mudar o projeto.
- **Substituição** por algo menos perigoso.
- **Controles de engenharia**: enclausuramento, proteção física, exaustão, intertravamento, automação, guarda corpo.
- **Controles administrativos**: procedimento, permissão de trabalho, sinalização, rodízio, limitação de tempo de exposição, treinamento.
- **Equipamento de proteção individual**, por último.

Descer direto para o EPI é o atalho mais comum e o mais caro. Ele transfere a proteção inteira para o comportamento humano, que falha em dia de pressa, de calor e de cansaço.

Enquanto a medida definitiva não fica pronta, adota-se medida de controle provisória, com prazo, e ela não pode virar permanente por inércia.

## Acidente e quase acidente alimentam o sistema

Todo acidente e todo quase acidente devem ser analisados buscando causa, e não culpado. Análise que termina em ato inseguro do trabalhador quase sempre parou cedo demais: falta perguntar por que aquele comportamento era possível, por que era mais rápido, e por que ninguém barrou antes.

O resultado da análise volta para o inventário e para o plano de ação. **Análise que não gera ação no plano é apenas arquivo.**

## Quem responde por quê

A direção responde pela segurança e não pode delegar essa responsabilidade. O SESMT assessora tecnicamente. A CIPA identifica riscos, acompanha e cobra. A liderança direta executa e verifica no dia a dia. O trabalhador cumpre, colabora e comunica.

Em contrato de terceiros, a contratante harmoniza os riscos, informa os perigos da sua área, e não pode alegar desconhecimento do que acontece dentro dela. Contratada com PGR próprio não dispensa a contratante de olhar.

## Documentação e fiscalização

Os documentos precisam ficar disponíveis para os trabalhadores, para a CIPA e para a fiscalização, com histórico. Ordens de serviço, registros de treinamento com carga horária e conteúdo, fichas de EPI, análises de acidente e evidências de cumprimento do plano de ação.

Bons indicadores para acompanhar: percentual de ações do plano concluídas no prazo, tempo médio de tratamento de desvio, quase acidentes reportados por período, e reincidência de acidente por mesma causa.

## Para lembrar

- **GRO é ciclo, PGR é o registro dele.** Nenhum dos dois vive de arquivo.
- O inventário tem de cobrir manutenção, partida, parada e serviço eventual.
- Plano de ação sem responsável, prazo e verificação não é plano.
- Classifique pelo **dano possível**, e não pela sorte que se teve até agora.
- **Respeite a hierarquia**: EPI é o último recurso, nunca o primeiro.
- Medida provisória tem prazo e não pode virar definitiva.
- Análise de acidente busca causa, e o resultado volta para o plano.
- Mudou processo, máquina ou produto: revise o inventário antes de operar.'
where codigo = 'NR-01-INT8';


-- =====================================================================
--  DD: direção defensiva (8 horas)
--  Foco: condução segura básica de quem dirige a serviço.
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Conceito de direção defensiva e responsabilidade do condutor a serviço.
Condições adversas de via, de veículo, de tempo, de luz e de trânsito.
Inspeção diária do veículo antes da saída e itens de verificação obrigatória.
Ajuste do posto de condução, do cinto de segurança e dos espelhos.
Distância de seguimento e cálculo do tempo de reação e de frenagem.
Pontos cegos do veículo e cuidados com veículos longos.
Ultrapassagem segura, mudança de faixa e uso de indicadores de direção.
Cruzamentos, rotatórias e conversões com travessia de pedestres.
Convivência com motociclistas, ciclistas e pedestres nas vias urbanas.
Velocidade compatível, sinalização de trânsito e limites legais.
Álcool, medicamentos e uso do celular ao volante.
Documentação do condutor e do veículo e infrações de trânsito.
Estacionamento, manobra em ré e uso de auxiliar de manobra.
Conduta em caso de pane, parada em via e sinalização do veículo.',
  apostila =
'## Por que este treinamento existe

Dirigir a serviço é a atividade mais perigosa da maioria das empresas, e quase nunca é tratada como tal. A pessoa que passa o dia na rua com um veículo da empresa está exposta a mais risco do que boa parte do pessoal da produção, só que sem colega por perto e sem supervisão direta.

Direção defensiva é simples de definir: **é dirigir contando com o erro dos outros**. Você pode fazer tudo certo e ainda assim se envolver num acidente porque alguém furou o sinal. A condução defensiva trabalha na margem que sobra: distância, visibilidade, velocidade e atenção suficientes para que o erro alheio não vire colisão.

> Ter razão no trânsito não evita batida nenhuma. A preferência protege você no boletim, e não no impacto.

## As condições adversas

Quase todo acidente é a soma de condições que já estavam lá:

- **Via**: buraco, curva fechada, pista estreita, obra, lombada sem sinalização, cascalho.
- **Veículo**: pneu careca, freio gasto, farol queimado, palheta ressecada, carga solta.
- **Tempo**: chuva, neblina, vento lateral, sol baixo no horizonte.
- **Luz**: noite, túnel, entrada e saída de garagem, sombra sob viaduto.
- **Trânsito**: congestionamento, moto entre faixas, caminhão lento, ônibus parando.
- **Condutor**: sono, pressa, raiva, remédio, celular.

Reconhecer a condição adversa é o começo. A resposta é quase sempre a mesma e vale para todas: **reduzir a velocidade e aumentar a distância**.

## Antes de sair

Inspeção rápida, todo dia, antes de ligar. Leva três minutos:

- Pneus: calibragem, desenho e ausência de corte na lateral. Não esqueça o estepe.
- Fluidos: óleo, água, freio, limpador de para brisa.
- Luzes: farol baixo e alto, lanterna, freio, seta, luz de ré, pisca alerta.
- Freio: pedal firme, sem afundar, e freio de estacionamento segurando.
- Palhetas e vidros limpos; espelhos ajustados e inteiros.
- Cinto de todos os assentos, triângulo, macaco, chave de roda e extintor onde exigido.
- Documento do veículo e sua habilitação dentro da validade e da categoria.

Ajuste o banco antes de sair, e não em movimento: encosto quase reto, pernas com folga para pisar fundo, mãos na direção, apoio de cabeça na altura das orelhas. **Cinto sempre, inclusive nos cem metros da portaria até a rua.**

Pane ou defeito encontrado na inspeção não vira problema para depois. Veículo com freio ou pneu ruim não sai.

## Durante a viagem

**Distância de seguimento.** Escolha um ponto fixo na via, um poste ou uma placa. Quando o veículo da frente passar por ele, conte: se você chegar lá antes de dois segundos, está perto demais. Em chuva, em serra ou com carga, use quatro segundos ou mais. Essa distância é o único espaço que você tem para reagir, e reagir leva quase um segundo mesmo com o motorista atento.

**Olhe longe.** Motorista que olha só o para choque da frente freia em cima da hora. Olhando o segundo ou o terceiro veículo adiante você vê o congestionamento se formar e freia suave.

**Pontos cegos.** Todo veículo tem, e o seu é maior do que você imagina. Antes de mudar de faixa: espelho interno, espelho externo, seta, e um giro rápido de cabeça. Ao lado do caminhão, a regra que salva vida é a inversa: se você não vê o rosto do motorista no espelho dele, ele não vê você.

**Ultrapassagem.** Só com visibilidade total, faixa que permite, espaço de sobra e sem depender de se enfiar de volta à força. Na dúvida, não ultrapasse. Chegar cinco minutos depois nunca custou o emprego de ninguém.

**Cruzamentos e rotatórias.** Sinal verde não é garantia. Antes de entrar, olhe para os dois lados. Ao converter, procure o pedestre que atravessa a via para onde você está virando: é ali que ele é atropelado.

**Moto.** Ela aparece do nada porque estava no seu ponto cego ou entre as faixas. Nunca abra a porta sem olhar o retrovisor, e nunca mude de faixa sem seta com antecedência.

## Velocidade e as regras que não se negociam

Velocidade compatível nem sempre é a do limite da placa. Com pista molhada, escola no horário de saída ou fila parada adiante, o compatível é menos.

Álcool é zero. Não existe limite tolerado para quem dirige a serviço. Medicamento para alergia, dor forte, ansiedade ou sono precisa ser conversado antes: muitos derrubam o tempo de reação tanto quanto bebida.

Celular na mão é infração gravíssima e, mais que isso, é a maior causa moderna de colisão traseira. Com o celular no colo, os olhos saem da pista por dois a três segundos, o que a oitenta por hora significa atravessar quase um quarteirão no escuro. **Se precisa responder, encoste.**

## Manobra, parada e pane

A maioria dos sinistros de frota acontece em baixa velocidade: manobra em pátio, ré em cliente, portão de garagem. Antes de dar ré, contorne o veículo a pé e olhe o que há atrás. Onde houver auxiliar de manobra, ele fica sempre visível para você, nunca atrás do veículo.

Em caso de pane, saia da pista se conseguir, ligue o pisca alerta, coloque o triângulo a uma distância que dê tempo de frear a quem vem atrás, e espere **fora do veículo e atrás da defensa**, nunca sentado dentro do carro na faixa. Ser colidido por trás no acostamento é um dos acidentes mais fatais que existem.

## Para lembrar

- **Direção defensiva é contar com o erro do outro.** Preferência não protege ninguém.
- Inspeção antes de sair, todo dia. Veículo com pneu ou freio ruim não sai.
- **Dois segundos de distância; quatro na chuva ou com carga.**
- Olhe além do veículo da frente e antecipe a frenagem.
- Seta com antecedência, espelho e giro de cabeça antes de mudar de faixa.
- Se você não vê o motorista do caminhão no espelho dele, ele não vê você.
- **Álcool zero. Celular só com o veículo parado.** Remédio que dá sono se comunica.
- Em pane: pisca alerta, triângulo e espera fora do veículo, atrás da defensa.'
where codigo = 'DD';


-- =====================================================================
--  DD-REC: direção defensiva, reciclagem (8 horas)
--  Foco: fadiga, noite, chuva, carga, comportamento de risco e os
--  primeiros minutos após o acidente.
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Revisão crítica dos hábitos adquiridos após anos de condução a serviço.
Fadiga e privação de sono: efeitos sobre o tempo de reação e a atenção.
Sinais de sonolência ao volante e a única medida realmente eficaz.
Ritmo biológico, janelas de maior risco e planejamento da jornada.
Condução noturna: ofuscamento, alcance do farol e leitura da via.
Chuva, aquaplanagem, neblina e pista com óleo no início da precipitação.
Frenagem em piso de baixa aderência e recuperação de derrapagem.
Carga: distribuição, amarração, altura do centro de gravidade e excesso de peso.
Efeito da carga sobre a distância de frenagem e sobre a estabilidade em curva.
Comportamento de risco: pressa, metas de entrega, disputa e distração.
Uso de telefone, aplicativos de rota e outras fontes de desatenção.
Álcool, drogas e medicamentos de uso contínuo na atividade profissional.
Primeiros minutos após o acidente: sinalizar, proteger, socorrer e acionar.
Preservação do local, comunicação à empresa e registro do ocorrido.',
  apostila =
'## Por que reciclar quem já dirige há anos

Quem está nesta reciclagem já sabe dirigir. O problema não é técnica, é desgaste.

Depois de alguns anos, três coisas acontecem com todo motorista profissional. A primeira é que os procedimentos viram automatismo e começam a ser cortados: a inspeção some, a distância encolhe, o cinto atrasa. A segunda é que a experiência vira confiança, e confiança vira tolerância a risco que antes não se aceitava. A terceira é que a rotina de estrada cobra do corpo, e o corpo cansado dirige pior do que o corpo inexperiente.

Por isso esta reciclagem não repete o básico. Ela trata do que derruba motorista bom: **cansaço, escuro, água na pista, carga mal presa, pressa, e o que fazer nos primeiros minutos quando algo deu errado.**

> Ninguém bate porque esqueceu como se dirige. Bate porque estava cansado, com pressa, ou porque a pista mudou e a velocidade não.

## Fadiga: o risco que ninguém sente chegar

Fadiga não avisa como a bebida avisa. Ela reduz o tempo de reação, estreita o campo visual e prejudica a decisão antes que a pessoa perceba que está ruim. Depois de muitas horas acordado, o desempenho ao volante se aproxima do de quem bebeu.

Existe ainda a microssoneca: de dois a dez segundos de sono, com os olhos às vezes abertos. Ela não é escolha e não pede licença. A cem por hora, cinco segundos são quase cento e quarenta metros percorridos sem ninguém dirigindo.

Sinais que exigem parada imediata:

- Piscar demorado, olhos ardendo, cabeça pesando para frente.
- Bocejo em série.
- Não lembrar dos últimos quilômetros percorridos.
- Sair da faixa, passar por cima da faixa sonora, corrigir de susto.
- Ficar irritado, ou ficar lendo a mesma placa duas vezes.

A única coisa que resolve sono é **dormir**. Café, ar frio, rádio alto, banho e conversa empurram o problema por poucos minutos e escondem os sinais, o que piora a situação. Encoste em lugar seguro e durma. Um cochilo curto recupera bem mais do que uma hora de café.

As janelas mais perigosas do dia são a madrugada, entre duas e seis da manhã, e o início da tarde, depois do almoço. Planeje a jornada contando com isso: dormir mal na véspera é um item de risco tanto quanto pneu careca.

## Noite

A noite concentra menos trânsito e mais mortes. O motivo é visual. O alcance do farol baixo é curto, e há faixa de velocidade em que **você dirige mais rápido do que enxerga**: quando o obstáculo aparece na luz, já não há distância para parar. Em estrada escura, a velocidade compatível é a que cabe dentro do farol.

Ofuscamento pelo farol de quem vem em sentido contrário cega por segundos. A resposta é olhar para a borda direita da pista e usar a faixa como referência, reduzindo, e não revidar com farol alto. Para brisa riscado, vidro sujo e óculos velhos espalham a luz e multiplicam o efeito.

Pedestre, ciclista, animal e veículo parado sem sinalização são o que mais mata à noite. Olho na borda da pista, e não só na faixa.

## Chuva e piso escorregadio

O período mais perigoso é o **começo da chuva**: a água levanta o óleo acumulado no asfalto e a aderência despenca antes de a pista lavar.

Aquaplanagem acontece quando o pneu deixa de escoar a água e passa a flutuar. Ela depende de três coisas: profundidade da água, velocidade e sulco do pneu. Pneu no limite legal já aquaplana muito mais cedo que pneu novo.

Se aquaplanou, o volante fica leve e o veículo para de responder. A reação correta é contra intuitiva:

- **Tire o pé do acelerador.** Não freie bruscamente.
- Mantenha o volante firme na direção em que você quer ir, sem movimento brusco.
- Espere o pneu tocar de novo, e só então corrija com suavidade.

Em derrapagem de traseira, olhe para onde quer ir e corrija na direção da derrapagem, com movimentos pequenos. Em pista molhada tudo aumenta: distância de seguimento para quatro segundos ou mais, frenagem antecipada, entrada de curva mais devagar.

Neblina pede farol baixo, nunca alto, velocidade bem reduzida e, se ficar impossível, saída completa da pista com sinalização.

## Carga

Carga muda o veículo. Mesmo dentro do peso, ela altera distância de frenagem, estabilidade em curva e comportamento em manobra brusca.

- **Peso alto sobe o centro de gravidade** e aproxima o veículo do tombamento em curva e em desvio repentino.
- Carga concentrada na traseira alivia a dianteira e tira direção.
- Carga solta vira projétil na frenagem e empurra o veículo na descida.
- Líquido em tanque parcialmente cheio se desloca e empurra na frenagem.

Amarre com o dispositivo próprio, confira a tensão depois dos primeiros quilômetros e de novo após cada parada, e proteja bordas vivas para a cinta não cortar. Excesso de peso é infração, arruína freio e pneu, e transforma qualquer descida em problema.

Com carga, aumente a distância, entre nas curvas mais devagar e use o freio motor nas descidas longas, poupando o freio de serviço.

## Comportamento: o fator que sobra

Depois de técnica e equipamento, o que resta é decisão.

Pressa por meta de entrega, disputa com outro motorista, ultrapassagem no limite, celular no colo, aplicativo de rota mexido em movimento, comer dirigindo. Nada disso é falta de conhecimento: é escolha feita sob pressão.

Duas ideias ajudam. A primeira: **calcule o ganho real**. Numa viagem de cem quilômetros, correr o trecho todo dez por cento mais rápido economiza poucos minutos e multiplica risco. A segunda: acordo antecipado. Decida antes de sair que o telefone toca sem ser atendido, que a rota se altera parado no acostamento, e que atraso se comunica em vez de se compensar no pedal.

Se a meta da empresa só fecha correndo, isso é um problema de gestão e precisa ser reportado, e não resolvido no volante.

## Os primeiros minutos após o acidente

O que se faz nos primeiros minutos define se haverá uma vítima ou três. A ordem importa:

- **Proteja o local antes de socorrer.** Pisca alerta, triângulo bem atrás, colete refletivo. Segundo acidente sobre o primeiro é comum e costuma ser pior.
- **Não movimente o ferido**, salvo risco de fogo ou de novo impacto. Lesão de coluna piora com transporte improvisado.
- Chame o socorro e informe direito: rodovia e quilômetro ou endereço com referência, quantas vítimas, se há gente presa, se há carga perigosa e qual o número do painel de risco.
- Desligue o motor e, se souber e for seguro, desconecte a bateria. Não fume nem deixe fumar perto.
- Estanque hemorragia com compressão direta e panos limpos, e converse com a vítima consciente para mantê-la calma.
- Acione a empresa e a seguradora, registre a ocorrência com a autoridade e fotografe o local antes de liberar a via, quando houver essa possibilidade.
- **Não assuma culpa nem discuta no local.** Passe os dados, colabore com a autoridade e deixe a apuração para depois.

Depois do episódio, há o retorno. Motorista que se envolveu em acidente grave costuma voltar tenso, dormir mal e reagir de forma exagerada por semanas. Isso é esperado e merece acompanhamento, e não vergonha.

## Para lembrar

- **Contra sono só existe dormir.** Café apenas apaga o aviso.
- Madrugada e início de tarde são as janelas de maior risco.
- À noite, ande na velocidade que cabe dentro do farol.
- **O começo da chuva é o momento mais escorregadio.**
- Aquaplanou: tira o pé, volante firme, sem freada brusca.
- Carga alta tomba, carga solta empurra, carga líquida balança.
- Combine antes: celular não se atende, rota só se mexe parado.
- No acidente: **sinalizar, não mover o ferido, acionar socorro com local exato.**'
where codigo = 'DD-REC';


-- =====================================================================
--  CONFERÊNCIA
--
--  Tem de voltar nove linhas, uma por curso, todas com conteúdo e
--  apostila preenchidos. Linha com itens = 0 ou palavras = 0 significa
--  que o update não pegou, e quase sempre o código foi digitado errado
--  (repare no ponto de NR-34.5).
-- =====================================================================
select c.codigo,
       c.titulo,
       c.carga_horaria,
       array_length(string_to_array(trim(c.conteudo_programatico),
                                    chr(10)), 1) as itens_conteudo,
       array_length(regexp_split_to_array(trim(c.apostila),
                                          '\s+'), 1)   as palavras_apostila,
       case when c.conteudo_programatico like '%' || chr(8212) || '%'
                 or c.apostila like '%' || chr(8212) || '%'
            then 'TEM TRAVESSAO' else 'ok' end          as travessao
  from public.trein_curso c
 where c.codigo in ('NR-06', 'NR-17', 'NR-26', 'LOTO', 'NR-34.5',
                    'NR-01-INT4', 'NR-01-INT8', 'DD', 'DD-REC')
 order by c.ordem;
