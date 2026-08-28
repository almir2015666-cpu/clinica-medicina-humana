-- =====================================================================
--  APOSTILAS, GRUPO 3: EPI, ergonomia, sinalizacao, LOTO, trabalho a
--  quente, as duas integracoes e as duas direcoes defensivas
--
--  Rode no SQL Editor. Pode rodar quantas vezes quiser: sao updates por
--  codigo, nao inserem nada e nao duplicam nada.
--
--  ATENCAO: ESTE CONTEUDO PRECISA DA CONFERIDA DO RESPONSAVEL TECNICO
--  ANTES DE SER PUBLICADO. A apostila e o material que o aluno leva para
--  o trabalho e estuda antes da prova, e o conteudo programatico sai
--  IMPRESSO NO VERSO DO CERTIFICADO. Texto errado no verso e problema na
--  fiscalizacao, e orientacao errada na apostila e acidente. Quem assina
--  tecnicamente pelo curso e quem decide o que fica.
--
--  O QUE ESTE ARQUIVO GRAVA
--  ------------------------
--  Duas colunas por curso:
--    conteudo_programatico : a ementa, um item por linha, frase curta e
--                            formal. E o verso do certificado.
--    apostila              : o material de estudo, em markdown simples.
--                            So titulo, subtitulo, paragrafo, lista,
--                            negrito e linha de destaque.
--
--  OS PARES SAO DE PROPOSITO DIFERENTES
--  ------------------------------------
--  NR-01-INT4 e NR-01-INT8 sao o mesmo assunto em profundidades
--  diferentes, e as apostilas nao se repetem. A de 4 horas e para quem
--  foi admitido ontem: o que ele precisa saber para atravessar a primeira
--  semana inteiro. A de 8 horas e gestao de risco: GRO, inventario, plano
--  de acao e hierarquia de controle.
--
--  DD e DD-REC seguem a mesma logica. O DD ensina a conduzir com
--  seguranca. O DD-REC e para quem ja dirige ha anos e trata do que
--  derruba motorista experiente: fadiga, noite, chuva, carga mal presa,
--  pressa e os primeiros minutos depois de uma batida.
--
--  SEM TRAVESSAO
--  -------------
--  Os arquivos 06 e 08 tiraram o travessao do catalogo porque no
--  documento impresso ele fica estranho. Este arquivo ja nasce sem
--  nenhum, em qualquer das duas colunas.
--
--  NAO HA APOSTROFO NO TEXTO. As frases foram escritas sem apostrofo de
--  proposito, para nao quebrar o literal do Postgres.
-- =====================================================================

-- A coluna da apostila, caso este arquivo seja o primeiro do grupo a
-- rodar neste banco. Se ja existir, nao acontece nada.
alter table public.trein_curso
  add column if not exists apostila text;


-- =====================================================================
--  NR-06: uso de EPI (4 horas)
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Conceito de EPI e de EPC, e a ordem de prioridade das medidas de protecao.
Obrigacoes do empregador quanto ao fornecimento, higienizacao e substituicao.
Obrigacoes do trabalhador quanto ao uso, guarda e conservacao.
Certificado de Aprovacao: para que serve e como se confere a validade.
Protecao da cabeca: capacete, jugular e criterios de descarte.
Protecao dos olhos e da face: oculos, protetor facial e mascara de solda.
Protecao auditiva: tipos de protetor, atenuacao e uso continuo na exposicao.
Protecao respiratoria: escolha do filtro, vedacao e limites de uso.
Protecao das maos, dos pes e do corpo conforme o risco de cada tarefa.
Protecao contra quedas: cinto paraquedista, talabarte e ponto de ancoragem.
Inspecao antes do uso, higienizacao, guarda e descarte do equipamento.
Ficha de entrega, registro de treinamento e comunicacao de EPI danificado.',
  apostila =
'## Por que esta norma existe

O equipamento de protecao individual e a ultima barreira entre voce e o risco. Nao e a primeira. Antes dele vem eliminar o perigo, trocar o produto por um menos agressivo, isolar a maquina, enclausurar o ruido, instalar exaustao, mudar o jeito de fazer a tarefa. So quando nada disso resolve por completo e que entra o EPI.

Isso muda como voce deve olhar para o capacete e para o protetor auricular. Eles nao tornam o local seguro. Eles reduzem o dano quando o resto falhar. Um trabalhador de capacete embaixo de uma carga suspensa continua correndo risco de morte.

A NR-06 existe para garantir tres coisas: que o equipamento certo seja escolhido para o risco certo, que ele seja entregue de graca e em bom estado, e que quem usa saiba usar.

> EPI que fica na mochila protege exatamente zero por cento. O numero de acidentes com equipamento entregue e nao usado e maior do que o de equipamento que falhou.

## Quando ela se aplica a voce

Sempre que houver risco que as medidas coletivas nao eliminaram. Na pratica isso cobre quase todo servico de obra, de industria e de manutencao: ruido acima do limite, poeira, produto quimico, respingo de solda, borda viva, piso escorregadio, trabalho acima de dois metros, energia eletrica.

A empresa e obrigada a fornecer sem cobrar nada. Se o equipamento quebrou ou vencer, ela troca. Se o seu servico mudou e o risco mudou junto, ela fornece o novo. Voce nao paga por EPI, nem quando o dano foi seu.

## Antes de comecar

Todo EPI tem um numero de Certificado de Aprovacao, o CA, gravado no proprio equipamento ou na etiqueta. Ele diz que aquele modelo foi ensaiado e aprovado para aquele risco. CA vencido ou ilegivel vale como equipamento sem protecao.

Antes de vestir, faca a inspecao rapida:

- Capacete: casco sem trinca, sem furo de parafuso, sem tinta ou solvente por cima, jugular inteira e presa.
- Oculos: lente sem risco fundo que atrapalhe a visao, haste firme.
- Protetor auditivo: plug limpo e sem endurecer, concha com almofada macia e arco com pressao.
- Luva: sem furo, sem corte, seca por dentro, do material certo para o produto.
- Bota: solado com desenho vivo, biqueira intacta, sem rasgo no cabedal.
- Cinto paraquedista: fita sem corte nem queimadura, costura inteira, fivela e mosquetao travando.

**Equipamento reprovado na inspecao sai de circulacao na hora.** Nao volta para o armario para outro pegar por engano.

## Durante o trabalho

O EPI so protege se estiver do jeito que foi projetado. Protetor auricular tipo plug precisa entrar no canal, nao encostar na orelha. Respirador precisa vedar na pele: barba fechada impede a vedacao e transforma a mascara em enfeite. Capacete com a jugular solta cai antes da cabeca bater.

Tirar o protetor auditivo por cinco minutos parece pouco, mas a exposicao ao ruido conta pelo tempo total do dia. Cinco minutos de britadeira sem protecao jogam fora boa parte da protecao das oito horas.

Trocar EPI com colega tambem tem regra. Protetor auricular de insercao e respirador sao de uso pessoal, por causa de infeccao e de vedacao. Capacete e bota tem ajuste individual.

## Equipamento e os cuidados

Depois do turno, limpe. Protetor auricular com agua e sabao neutro. Mascara com o pano e o produto que a empresa indicar. Cinto pendurado, nunca dobrado no fundo da caixa junto com ferramenta. Luva de raspa seca ao ar, longe de calor.

Guarde em lugar seco, sem sol direto e sem produto quimico ao lado. Plastico de capacete resseca com sol e com solvente: um capacete que passou o verao no painel do carro ja nao aguenta o impacto para o qual foi ensaiado.

Filtro de respirador tem vida util. Vence pelo prazo, pelo cheiro que comeca a passar e pela dificuldade de puxar o ar. Nao existe lavar filtro.

## O que a empresa deve, o que voce deve

A empresa deve escolher o equipamento adequado ao risco com orientacao do responsavel tecnico, fornecer gratuitamente, exigir o uso, treinar, substituir quando danificar ou vencer, higienizar quando for o caso e registrar tudo na ficha de entrega.

Voce deve usar apenas para o fim a que se destina, cuidar, guardar, comunicar qualquer alteracao que deixe o equipamento improprio e cumprir o que foi ensinado no treinamento. Assinar a ficha de entrega nao e formalidade: e a prova de que voce recebeu, e tambem de que a empresa cumpriu.

Recusar o uso e falta grave e pode gerar sancao disciplinar. Mas o inverso tambem vale: se o EPI que voce recebeu machuca, aperta, embaca ou nao serve para o risco daquela tarefa, isso e problema tecnico e precisa ser comunicado, e nao resolvido tirando o equipamento escondido.

## Para lembrar

- **O EPI e a ultima barreira, nao a primeira.** Se da para eliminar o risco, elimine.
- Confira o **CA** e a validade. Sem CA nao ha protecao comprovada.
- Inspecione antes de vestir, todo dia, e retire de uso o que reprovar.
- **Respirador nao veda em rosto com barba.**
- Protecao auditiva vale pelo tempo inteiro de exposicao, nao pela maior parte dele.
- Limpe, seque e guarde longe de sol, calor e produto quimico.
- EPI e gratuito. Voce nunca paga, nem por perda nem por dano.
- Comunicou defeito e nao veio troca? Registre. Trabalhar sem protecao nao e opcao.'
where codigo = 'NR-06';


-- =====================================================================
--  NR-17: ergonomia (4 horas)
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Conceito de ergonomia e adaptacao do trabalho as caracteristicas do trabalhador.
Avaliacao ergonomica preliminar e analise ergonomica do trabalho.
Levantamento, transporte e descarga manual de materiais.
Postura sentada, postura em pe e alternancia entre elas.
Mobiliario, bancada, assento e apoio para os pes.
Trabalho com computador: tela, teclado, mouse e distancia de leitura.
Movimentos repetitivos, forca excessiva e tempo de recuperacao.
Organizacao do trabalho: ritmo, metas, pausas e revezamento.
Condicoes ambientais: iluminacao, ruido, temperatura e ventilacao.
Sinais precoces de lesao por esforco e distubios osteomusculares.
Manuseio de cargas com auxilio mecanico e trabalho em dupla.
Comunicacao de desconforto e acompanhamento pela saude ocupacional.',
  apostila =
'## Por que esta norma existe

Acidente de trabalho todo mundo reconhece: cai, corta, queima. A lesao por esforco nao tem esse barulho. Ela chega devagar, ao longo de meses, e quando incomoda de verdade ja virou tendinite, hernia de disco ou ombro que nao levanta mais.

A NR-17 existe para inverter a logica que sempre se usou. Em vez de exigir que o corpo do trabalhador aguente o posto de trabalho, ela manda **adaptar o posto ao corpo de quem trabalha**. A bancada e que sobe, o peso e que diminui, a pausa e que entra na conta da producao.

Isso vale para obra, para linha de producao, para almoxarifado, para escritorio e para teleatendimento. Onde ha gente trabalhando ha ergonomia.

## Quando ela se aplica a voce

Se voce levanta peso, repete o mesmo movimento centenas de vezes por turno, fica muito tempo na mesma posicao, trabalha agachado, com o braco acima do ombro, com o pulso torcido, ou passa o dia numa cadeira ruim, a norma esta falando de voce.

A empresa faz uma avaliacao ergonomica preliminar dos postos. Quando ela aponta risco, vem a analise ergonomica do trabalho, mais completa, feita por profissional habilitado, com recomendacoes que viram plano de acao.

> Dor que vai e volta sempre no mesmo lugar e no mesmo horario do turno nao e cansaco normal. E aviso.

## Antes de comecar

Antes de erguer qualquer coisa, faca tres perguntas: quanto pesa, para onde vai, e da para nao carregar no braco.

Boa parte das lesoes de coluna acontece em cargas que ninguem considerava pesadas. O que machuca nao e so o peso, e a combinacao de peso, distancia do corpo, altura de pega e giro de tronco. Vinte quilos colados no peito sao muito menos agressivos que dez quilos de braco esticado com o corpo torcido.

Olhe o caminho antes: piso molhado, degrau, mangueira no chao, porta fechada, gente passando. Carga na frente do rosto tapa a vista, e o tropeco vem dai.

## Durante o trabalho

O levantamento correto e sempre o mesmo desenho:

- Chegue perto da carga, pes afastados na largura dos ombros.
- Dobre os joelhos e o quadril, e mantenha as costas retas.
- Pegue firme, com as duas maos, e traga a carga junto ao corpo.
- Suba com a forca das pernas, sem solavanco.
- **Para mudar de direcao, mova os pes. Nunca gire o tronco com peso na mao.**
- Para descer, dobre os joelhos de novo. Nao largue a carga de qualquer jeito.

Se a carga e comprida, desengoncada, ou se voce precisa prender a respiracao para levantar, ela nao e sua sozinho. Chame ajuda ou use carrinho, paleteira, talha. Pedir equipamento nao e frescura, e a solucao que a norma manda usar primeiro.

Para quem fica em pe o turno inteiro: alterne o apoio, use um estrado para descansar um pe, e cadeira para as pausas. Para quem fica sentado: pes apoiados no chao ou no descanso, joelhos em angulo aberto, coluna encostada, tela na altura dos olhos, antebraco apoiado. Cotovelo no ar o dia todo vira dor de ombro.

Movimento repetitivo pede tempo de recuperacao. Vinte minutos parados alongando resolvem menos do que pequenas trocas de tarefa distribuidas no turno.

### Luz, ruido e calor tambem sao ergonomia

Iluminacao fraca faz o trabalhador aproximar o rosto da peca e curvar o pescoco o dia inteiro. Iluminacao forte e mal posicionada gera reflexo na tela e na chapa polida, e o resultado e o mesmo: dor de cabeca no fim do turno e postura torta para fugir do brilho. A luz deve chegar de lado, sobre a tarefa, e nao de frente para os olhos.

Ruido continuo cansa mesmo abaixo do limite que causa surdez, porque obriga a atencao a trabalhar dobrado. Calor faz perder liquido, tira forca e aumenta o erro. Agua fresca ao alcance da mao e pausa em local ameno nao sao cortesia: sao medida de controle.

## A organizacao do trabalho tambem e ergonomia

Este e o ponto que mais se esquece. Uma bancada perfeita nao salva ninguem se a meta exige ritmo que impede parar. Pressao por producao, jornada esticada, banheiro contado, hora extra frequente e revezamento mal feito produzem lesao do mesmo jeito que ferramenta pesada.

Por isso a norma trata de pausas, de metas, de ritmo e de conteudo da tarefa. Um posto ergonomico com ritmo desumano continua sendo um posto que adoece.

## O que a empresa deve, o que voce deve

A empresa deve avaliar os postos, adequar mobiliario e equipamento, fornecer meio mecanico para cargas, organizar pausas, tratar as recomendacoes da analise ergonomica em plano de acao com prazo e responsavel, e acompanhar a saude de quem esta exposto.

Voce deve usar os recursos que existem, mesmo quando dao um pouco mais de trabalho, aplicar a tecnica de levantamento que aprendeu, fazer as pausas de verdade e, principalmente, **comunicar cedo**. Formigamento na mao ao acordar, dor no ombro que aparece sempre depois da mesma tarefa, ardencia no antebraco: isso vai para a saude ocupacional enquanto ainda tem conserto facil.

Esconder sintoma para nao perder producao ou para nao ser trocado de funcao e o caminho mais curto para o afastamento longo.

## Para lembrar

- Ergonomia e **adaptar o trabalho ao trabalhador**, e nao o contrario.
- Peso longe do corpo e giro de tronco machucam mais que peso alto.
- **Pernas levantam, costas nao.** Para virar, mexa os pes.
- Carga que exige prender a respiracao pede ajuda ou equipamento.
- Alterne postura e alterne tarefa: o corpo precisa de tempo de recuperacao.
- Tela na altura dos olhos, pes apoiados, antebraco apoiado.
- Ritmo, meta e pausa fazem parte da ergonomia tanto quanto a bancada.
- Dor que repete no mesmo lugar e no mesmo horario e para comunicar hoje.'
where codigo = 'NR-17';


-- =====================================================================
--  NR-26: sinalizacao de seguranca (4 horas)
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Finalidade da sinalizacao de seguranca e seus limites como medida de protecao.
Cores de seguranca e seu significado padronizado no ambiente de trabalho.
Vermelho, amarelo, verde, azul, laranja e branco: onde cada um se aplica.
Delimitacao de areas, faixas de circulacao e sinalizacao de piso.
Identificacao de tubulacoes por cor e por rotulo de conteudo.
Rotulagem preventiva de produtos quimicos e sistema globalmente harmonizado.
Pictogramas de perigo, palavra de advertencia e frases de perigo.
Ficha com dados de seguranca do produto quimico: onde fica e como se le.
Sinalizacao de emergencia: saidas, extintores, hidrantes e chuveiro de seguranca.
Placas de advertencia, de proibicao e de obrigacao em area de obra.
Sinalizacao provisoria de servico, bloqueio de area e cones.
Responsabilidade pelo respeito a sinalizacao e o que fazer quando ela falta.',
  apostila =
'## Por que esta norma existe

Sinalizacao e a maneira mais barata e mais rapida de avisar de um perigo. Uma faixa no chao, uma cor numa tubulacao ou um pictograma num rotulo dizem em um segundo o que um procedimento leva tres paginas para explicar. E ha situacoes em que so existe esse segundo.

A NR-26 padroniza essas cores e esses rotulos. O ganho da padronizacao e que a mensagem funciona para quem chegou hoje, para o terceiro que nunca entrou naquela area e para o motorista que so veio entregar.

> Sinalizacao avisa, nao protege. Placa de alta tensao nao isola nada. Ela existe para que voce nao chegue perto do que continua energizado.

## Quando ela se aplica a voce

Em toda a instalacao. Voce e afetado nas duas pontas: como quem **le** a sinalizacao para saber por onde andar e o que nao tocar, e como quem **coloca** sinalizacao quando abre um servico, isola uma area ou transfere um produto para outro recipiente.

A segunda ponta e onde mais se erra. Quem passa produto quimico do tambor para o galao e nao rotula cria um risco que nao existia.

## As cores e o que elas dizem

- **Vermelho**: identifica equipamento e material de combate a incendio. Extintor, hidrante, sirene, botao de parada de emergencia, caixa de mangueira. Por isso nao se pinta de vermelho o que nao for de emergencia, e nao se guarda nada em cima da area vermelha do piso.
- **Amarelo**: cuidado, atencao. Corrimao, parapeito, borda de plataforma, batente de degrau, partes moveis de maquina, faixas de piso que avisam desnivel ou passagem baixa.
- **Verde**: seguranca. Caixa de primeiros socorros, chuveiro de emergencia e lava olhos, macas, quadro de aviso de seguranca, EPI guardado.
- **Azul**: acao obrigatoria e advertencia contra acionamento. Placa que manda usar protetor auricular, e o aviso posto no comando de equipamento em manutencao para que ninguem ligue.
- **Laranja**: partes moveis e perigosas de maquina expostas, face interna de guarda que foi aberta, borda cortante.
- **Branco**: circulacao. Faixa de pedestre interna, area de armazenamento demarcada, direcao de fluxo.
- **Purpura**: risco de radiacao ionizante.
- **Lilas**: perigo de radiacao nao ionizante em alguns arranjos, conforme o padrao interno.

O que voce nao pode fazer e inventar cor. Fita amarela improvisada para dizer proibido passar confunde: amarelo e atencao, isolamento de area e feito com o material e a placa que a empresa definiu.

## Tubulacao: a cor do tubo salva vida

Numa industria passam agua, vapor, ar comprimido, gas combustivel, acido e produto inflamavel pelo mesmo corredor de tubos. Abrir a valvula errada, ou soldar no tubo errado, e acidente grave.

Por isso a tubulacao recebe cor de identificacao e, junto dela, **rotulo com o nome do produto e seta indicando o sentido do fluxo**. A regra pratica e simples: se voce nao consegue ler no proprio tubo o que passa dentro dele, voce nao abre, nao corta, nao solda e nao apoia nada nele. Vai perguntar.

## Rotulo de produto quimico

O rotulo preventivo segue o sistema harmonizado e traz sempre os mesmos elementos: **pictograma** em losango vermelho, **palavra de advertencia** (perigo ou atencao), nome do produto, frases de perigo, frases de precaucao e quem fabrica.

Os pictogramas mais comuns na obra e na industria sao chama para inflamavel, caveira para toxico agudo, ponto de exclamacao para irritante, tubos de ensaio derramando para corrosivo, e o busto com a mancha no torax para produto que causa dano grave a longo prazo.

Cada produto tem tambem a ficha com dados de seguranca. E o documento que diz o que fazer no derramamento, no contato com a pele, na inalacao e no incendio. Ela precisa estar acessivel onde o produto e usado, e nao trancada numa gaveta do escritorio.

**Recipiente sem rotulo se trata como desconhecido: ninguem abre, ninguem cheira, ninguem usa.** Garrafa de refrigerante com liquido dentro e um dos acidentes mais antigos e mais bobos que existem.

## Emergencia

A sinalizacao de emergencia so funciona se estiver visivel no dia ruim, com fumaca, correria e pouca luz. Saida de emergencia, luminaria autonoma, seta de rota de fuga, extintor e chuveiro lava olhos precisam estar desobstruidos o tempo todo.

Ninguem encosta pallet na frente do hidrante, nem guarda material no corredor de saida, nem pendura pano no extintor. Se voce viu isso, tirar leva trinta segundos e faz parte do seu trabalho.

## O que a empresa deve, o que voce deve

A empresa deve padronizar e manter a sinalizacao, rotular tudo, identificar tubulacoes, disponibilizar as fichas de seguranca, treinar os trabalhadores no significado das cores e dos pictogramas, e repor placa apagada ou quebrada.

Voce deve respeitar a sinalizacao mesmo quando ela atrapalha o caminho, sinalizar o servico que abrir, rotular todo recipiente que encher, nao remover placa nem isolamento de area que nao seja seu, e avisar quando faltar sinalizacao ou quando ela estiver ilegivel.

## Para lembrar

- **Sinalizacao avisa, nao protege.** Continue tratando o perigo como perigo.
- Vermelho e incendio, amarelo e cuidado, verde e seguranca, azul e obrigacao.
- Nao se guarda nem se encosta nada sobre area vermelha ou de emergencia.
- Tubo sem identificacao legivel nao se abre, nao se corta e nao se solda.
- Todo recipiente rotulado, inclusive o pequeno que voce encheu agora.
- **Recipiente sem rotulo e produto desconhecido e ninguem usa.**
- A ficha de seguranca fica onde o produto e usado.
- Servico aberto e area isolada, com a placa e a barreira que a empresa definiu.'
where codigo = 'NR-26';


-- =====================================================================
--  LOTO: bloqueio e etiquetagem (4 horas)
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Objetivo do bloqueio e etiquetagem e sua relacao com a seguranca em maquinas.
Acidentes por partida inesperada e por energia residual armazenada.
Tipos de energia perigosa: eletrica, mecanica, hidraulica, pneumatica e termica.
Energia quimica, gravitacional e energia acumulada em molas e capacitores.
Identificacao dos pontos de isolamento de cada equipamento.
Dispositivos de bloqueio: cadeado, garra multipla, bloqueador de valvula e disjuntor.
Etiqueta de identificacao: quem bloqueou, quando e por que.
Sequencia de aplicacao do bloqueio, do desligamento a dissipacao de energia.
Teste de energia zero antes de iniciar a intervencao.
Bloqueio individual, bloqueio de grupo e caixa de bloqueio coletivo.
Passagem de turno com equipamento bloqueado e continuidade do servico.
Sequencia de liberacao, retirada de cadeado esquecido e retomada segura.',
  apostila =
'## Por que este procedimento existe

A maioria dos acidentes graves de manutencao tem a mesma historia. O equipamento parou, o mecanico entrou, e alguem ligou. Ou o equipamento parou, o mecanico entrou, e a maquina se moveu sozinha porque ainda havia pressao no circuito, peso suspenso ou mola comprimida.

LOTO vem de lockout e tagout: **bloquear** a fonte de energia com um cadeado fisico e **etiquetar** dizendo quem bloqueou. Nao e norma numerada no Brasil, mas e exigido na pratica pela NR-12 e por qualquer sistema de gestao serio, porque e o unico jeito comprovado de garantir que a maquina nao volte a funcionar enquanto tem gente dentro dela.

> Aviso verbal nao e bloqueio. Cartaz sozinho nao e bloqueio. Botao de emergencia apertado nao e bloqueio. Bloqueio e cadeado.

## Quando ele se aplica a voce

Sempre que voce for intervir num equipamento em que a partida inesperada, o movimento residual ou a liberacao de energia possam machucar alguem. Manutencao mecanica ou eletrica, limpeza interna, desobstrucao, troca de ferramenta, ajuste, inspecao dentro de zona de risco, retirada de protecao.

A duvida comum e o servico rapido. **Servico rapido e o que mais mata**, exatamente porque a pessoa acha que nao vale a pena bloquear por dois minutos. Vale.

Vale a pena dizer tambem o que **nao** conta como bloqueio, porque cada um destes ja apareceu em relatorio de acidente grave:

- Botao de emergencia apertado. Ele para, mas nao impede que alguem gire e ligue.
- Chave geral desligada sem cadeado, com o painel destrancado.
- Aviso no radio ou combinacao verbal com o operador.
- Placa de papel colada no comando, sozinha.
- Fusivel retirado e guardado no bolso.
- Colega postado na frente do painel para nao deixar ninguem ligar.

Todos falham do mesmo jeito: dependem de alguem lembrar. O cadeado nao depende.

## Todas as energias, nao so a eletrica

Bloquear o disjuntor e o passo mais lembrado e quase nunca e o unico. Faca a lista do equipamento:

- **Eletrica**: painel, disjuntor, chave seccionadora, tomada industrial.
- **Mecanica**: eixo girando por inercia, volante, correia, rolo que continua rodando depois de desligado.
- **Hidraulica**: pressao no cilindro e na tubulacao, mesmo com a bomba parada.
- **Pneumatica**: ar comprimido no reservatorio e nas linhas.
- **Gravitacional**: caçamba levantada, mesa elevatoria, carga suspensa, contrapeso.
- **Termica**: vapor, agua quente, superficie que ainda esta a duzentos graus.
- **Quimica**: produto na linha, gas residual, vapor inflamavel.
- **Acumulada**: mola comprimida, capacitor carregado, acumulador hidraulico.

Cada uma dessas precisa ser isolada e depois **dissipada**: abrir o purgador, aliviar a pressao, descer a carga e apoiar no calco, aterrar, drenar, esperar esfriar.

## A sequencia do bloqueio

- Avise quem opera e quem depende do equipamento.
- Desligue pelo comando normal, na ordem correta de parada.
- Isole cada fonte de energia identificada no ponto proprio.
- Aplique o **seu** dispositivo de bloqueio em cada ponto isolado.
- Prenda a etiqueta com o seu nome, a data, a hora e o motivo.
- Dissipe a energia residual: alivie, drene, descarregue, calce, aterre.
- Faca o **teste de energia zero**: tente acionar pelo comando, meça com instrumento, confirme que nao ha pressao nem movimento.
- So depois disso ponha a mao no equipamento.

O teste de energia zero e o passo que ninguem pode pular. Ele e a diferenca entre acreditar que a maquina esta desligada e saber que esta.

## Cada um com o seu cadeado

O cadeado e individual, e a chave fica com quem esta trabalhando, no bolso. Nao existe cadeado do setor pendurado com a chave no quadro.

Quando a equipe e grande, usa se garra multipla, que aceita varios cadeados no mesmo ponto, ou caixa de bloqueio coletivo: a chave do bloqueio principal fica trancada dentro da caixa, e cada trabalhador poe o seu cadeado na tampa. **Enquanto houver um unico cadeado na caixa, a chave nao sai, e o equipamento nao liga.**

Se o servico atravessa a troca de turno, o bloqueio nao e retirado. Quem entra coloca o cadeado antes de quem sai retirar o seu, e o equipamento nunca fica sem protecao no intervalo.

## A liberacao

Liberar tem regra tanto quanto bloquear:

- Termine o servico e recoloque todas as protecoes que foram retiradas.
- Retire ferramenta, pano, escada e peca de dentro da maquina.
- Confira que nao ha ninguem na zona de risco, e avise em voz alta.
- Cada trabalhador retira o proprio cadeado e a propria etiqueta.
- Religue e acompanhe a primeira partida.

Cadeado esquecido por alguem que foi embora nao se corta por conta propria. Existe um procedimento de excecao, com autorizacao de quem responde pela area, tentativa de contato com o dono do cadeado e conferencia fisica de que nao ha pessoa no equipamento. **Cortar cadeado dos outros por pressa e uma das piores decisoes possiveis dentro de uma fabrica.**

## O que a empresa deve, o que voce deve

A empresa deve ter procedimento escrito por equipamento, com os pontos de isolamento mapeados, fornecer cadeados e dispositivos suficientes, treinar e autorizar formalmente quem bloqueia, e auditar.

Voce deve bloquear sempre, com o seu cadeado, testar energia zero, nunca confiar em bloqueio feito por outro sem colocar o seu, nunca operar equipamento etiquetado por terceiro, e comunicar quando faltar dispositivo ou quando o ponto de isolamento nao existir.

## Para lembrar

- **Bloqueio e cadeado fisico.** Aviso e cartaz nao bloqueiam nada.
- Liste todas as energias, nao apenas a eletrica.
- Isolou, dissipou. Pressao, carga suspensa, calor e mola tambem matam.
- **Teste de energia zero antes de encostar.** Sempre.
- Cadeado individual, chave no bolso do dono.
- Um cadeado na caixa ja impede a partida de todo o conjunto.
- Servico rapido tambem se bloqueia.
- Cadeado de terceiro nao se corta: existe procedimento para isso.'
where codigo = 'LOTO';


-- =====================================================================
--  NR-34.5: trabalho a quente (8 horas)
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Definicao de trabalho a quente e atividades abrangidas pelo procedimento.
Riscos de incendio, explosao, queimadura, radiacao e fumos metalicos.
Permissao de trabalho: emissao, validade, encerramento e responsaveis.
Analise de risco da tarefa e inspecao previa da area de execucao.
Identificacao e remocao de materiais combustiveis no entorno.
Medicao de gases e atmosferas explosivas antes e durante o servico.
Isolamento da area, biombos, mantas e protecao de aberturas e drenos.
Funcao do vigia de fogo, seus limites e a vigilancia apos o termino.
Equipamentos de oxicorte: cilindros, mangueiras, valvulas e retorno de chama.
Solda eletrica: cabos, aterramento, porta eletrodo e risco de choque.
Protecao individual especifica: mascara de solda, vestimenta e respiratoria.
Trabalho a quente em espaco confinado, em altura e proximo a inflamaveis.
Ventilacao, exaustao e controle da exposicao a fumos de solda.
Emergencia: combate a principio de incendio, alarme e atendimento a queimadura.',
  apostila =
'## Por que esta norma existe

Trabalho a quente e toda atividade que produz chama, calor intenso ou faisca: solda eletrica, oxicorte, esmerilhamento, maçarico, aquecimento com macarico, corte com disco abrasivo.

O item 34.5 da NR-34 organizou esse trabalho na industria naval, e o procedimento que ele descreve virou referencia para obra e para industria em geral, junto com o que a NR-20 exige perto de inflamaveis.

A razao e simples de entender e dificil de esquecer depois que se ve uma vez. Uma faisca de esmeril viaja mais de dez metros, entra por fresta, cai por vao de piso e continua quente depois de cair. Ela nao precisa iniciar o fogo na hora: pode ficar horas em uma poeira de serragem ou em um pano com oleo e virar incendio quando ja nao ha ninguem no local.

> Grande parte dos incendios industriais comeca em servico de solda ja terminado. O fogo aparece depois que a equipe foi embora.

## Quando ela se aplica a voce

Sempre que houver chama, calor ou faisca fora de um local fixo e preparado para isso. Numa bancada de solda, com piso incombustivel e exaustao, o risco esta controlado pelo proprio arranjo do local. Fora dela, cada servico e um caso novo e precisa de **permissao de trabalho**.

A permissao nao e burocracia. E o documento em que alguem tecnicamente responsavel olhou aquela area, aquele dia e aquela tarefa e disse o que precisa ser feito antes de acender.

## Antes de comecar

A permissao de trabalho traz a analise de risco e as condicoes. Antes de assinar e antes de acender, confira voce mesmo:

- **Combustivel no entorno**: retire tudo que queima num raio adequado. Papelao, madeira, estopa, plastico, tambor vazio de solvente, isolamento termico, pintura fresca.
- **O que nao da para retirar**: cobre com manta de protecao termica, nunca com lona plastica.
- **Aberturas**: vao de piso, junta de dilatacao, canaleta, ralo, dreno e caixa de passagem sao por onde a faisca some. Tape.
- **Atmosfera**: onde houver historico de gas, vapor ou liquido inflamavel, ha medicao antes e monitoramento durante. Tanque, linha e area classificada nao recebem chama sem liberacao explicita.
- **Ventilacao**: fumo de solda em local fechado intoxica. Exaustao local ou ventilacao forcada.
- **Extintor**: do tipo certo, carregado, ao alcance da mao, e nao a cinquenta metros.
- **Isolamento**: biombo para proteger a vista de quem passa, sinalizacao e barreira.

Confira o equipamento tambem. Cabo de solda com emenda descascada, porta eletrodo trincado, mangueira de oxicorte ressecada, cilindro deitado ou sem capacete, valvula corta chamas ausente: nada disso entra em servico.

## Durante o trabalho

O vigia de fogo fica com uma tarefa unica: olhar o entorno e a trajetoria das faiscas, com extintor na mao. **Ele nao ajuda a segurar peca, nao busca ferramenta e nao vai almoçar antes.** No momento em que ele faz outra coisa, deixou de existir.

Ele precisa saber acionar o alarme, saber onde fica o hidrante, e ter meio de comunicacao. Quando o servico e feito de um lado de uma parede ou de um piso, a vigilancia acontece **dos dois lados**: calor atravessa chapa e a faisca cai no andar de baixo.

Para o soldador, tres cuidados que custam caro quando faltam:

- Aterramento do circuito de solda preso na peca, perto do ponto de trabalho. Retorno improvisado por estrutura faz corrente circular por onde ninguem espera.
- Vestimenta de raspa ou tecido tratado, sem bolso aberto e sem bainha virada, que e onde a escoria se aloja. Nada de tecido sintetico por baixo: ele derrete na pele.
- Mascara com o tom de lente adequado ao processo. Vista de solda queima em segundos e a dor chega horas depois.

Em espaco confinado, trabalho a quente soma duas normas: nao entra sem liberacao de espaco confinado, sem vigia proprio e sem monitoramento continuo de atmosfera. Em altura, a faisca cai sobre gente e material que estao muito longe do seu campo de visao.

## Cilindros e gases

Cilindro fica em pe, amarrado, com valvula protegida e longe de fonte de calor. Oxigenio e graxa ou oleo formam combinacao explosiva: mao engraxada nao encosta em valvula de oxigenio.

Mangueira tem cor propria por gas e nao se troca uma pela outra. **Valvula corta chamas nos dois lados evita o retorno de chama**, que e quando o fogo entra pela mangueira e chega ao cilindro. Vazamento se procura com agua e sabao, nunca com isqueiro.

Ao terminar, feche primeiro a valvula do cilindro, alivie a pressao das mangueiras e recolha o conjunto.

## Depois de apagar: a parte esquecida

O servico nao termina quando o maçarico apaga. A vigilancia continua por um periodo definido no procedimento, tipicamente pelo menos trinta minutos, e mais tempo quando ha material combustivel proximo, vao de piso ou dificuldade de acesso.

Passe a mao pela area com o dorso, olhe o piso de baixo, procure cheiro de queimado, confira as caixas e canaletas que voce tapou. So depois disso a permissao e encerrada e assinada.

## Emergencia

Se o fogo comecou, ataque enquanto e principio, com o extintor certo e com saida garantida atras de voce. Se ele passou disso, acione o alarme, evacue e feche o que der para fechar.

Queimadura se resfria com agua corrente em abundancia, por varios minutos. Nao se passa pasta, pomada caseira, oleo nem manteiga, e nao se estoura bolha. Roupa colada na pele nao se arranca. Vista de solda queimada se trata com compressa fria, ambiente escuro e avaliacao medica.

## Para lembrar

- **Sem permissao de trabalho valida, nao acende.**
- Faisca viaja longe, entra por fresta e cai por vao de piso: tape tudo.
- Retire o combustivel; o que nao sair, cubra com manta, nunca com plastico.
- Onde houver inflamavel, mede se gas antes e durante.
- **Vigia de fogo nao faz outra coisa**, e vigia os dois lados da parede.
- Cilindro em pe e amarrado; oxigenio nunca perto de graxa ou oleo.
- Valvula corta chamas nos dois lados da mangueira.
- **A vigilancia continua depois de apagar**, no minimo trinta minutos.
- Queimadura: agua corrente e servico medico. Nada de pomada caseira.'
where codigo = 'NR-34.5';


-- =====================================================================
--  NR-01-INT4: integracao de seguranca, 4 horas
--  Publico: recem admitido. Foco: atravessar a primeira semana inteiro.
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Apresentacao da empresa, das areas e das regras de convivencia no local de trabalho.
Direitos e deveres do trabalhador quanto a seguranca e a saude no trabalho.
Ordem de servico: o que ela informa e por que deve ser assinada e compreendida.
Riscos existentes nas areas por onde o trabalhador vai circular.
Circulacao segura, faixas de pedestre, transito de veiculos e areas restritas.
Equipamentos de protecao individual exigidos e como obte los.
Regras basicas de altura, eletricidade, maquinas e produtos quimicos.
Sinalizacao, isolamento de area e placas que nao podem ser ultrapassadas.
Comunicacao de condicao insegura e a quem recorrer em cada situacao.
Procedimento em caso de acidente, mal estar ou quase acidente.
Rota de fuga, ponto de encontro e alarme de emergencia.
O direito de recusar tarefa com risco grave e iminente.',
  apostila =
'## Bem vindo, e a razao desta conversa

Voce esta comecando. Este material trata de uma coisa so: **o que voce precisa saber hoje para chegar inteiro no fim da primeira semana.**

Isso nao e exagero de treinamento. Trabalhador recem admitido se acidenta mais que o veterano, e nao por falta de capricho. E porque ele ainda nao sabe por onde a empilhadeira passa, nao sabe qual porta abre para dentro, nao sabe que aquele piso fica escorregadio depois da lavagem, e tem vergonha de perguntar.

> A pergunta que voce nao fez hoje e o acidente da semana que vem. Ninguem aqui acha ruim que voce pergunte. Acham ruim quando voce adivinha.

## Seus direitos e seus deveres

A lei e clara nos dois lados. A empresa deve informar os riscos do seu trabalho, fornecer equipamento de protecao de graca, treinar e manter o local seguro. Voce deve seguir as instrucoes, usar o que recebeu, cuidar da sua seguranca e da de quem esta ao seu lado, e avisar quando algo estiver errado.

Ha um direito que precisa ser dito com todas as letras: **voce pode interromper uma tarefa quando houver risco grave e iminente**, e deve comunicar imediatamente ao superior. Ninguem e punido por isso. Punido e quem manda alguem entrar num risco desses.

## A ordem de servico

Logo no inicio voce recebe a ordem de servico da sua funcao. E um papel curto que diz quais riscos existem na sua atividade, como se protege deles, e o que e proibido.

Leia antes de assinar. Se tiver palavra que voce nao entendeu, pergunte na hora. Assinatura em documento que voce nao leu nao ajuda voce em nada.

## As primeiras coisas a aprender no local

Antes de comecar o servico, procure saber, com quem ja esta la:

- Onde ficam as **saidas de emergencia** e para onde vai a rota de fuga.
- Onde e o **ponto de encontro** e como e o som do alarme.
- Onde estao o extintor, o hidrante e a caixa de primeiros socorros.
- Quem e o seu encarregado e quem e o tecnico de seguranca da area.
- Por onde passa veiculo, empilhadeira ou carga suspensa.
- Onde ficam o vestiario, o refeitorio e a agua potavel.

Circule pelas faixas marcadas. Area demarcada e isolada nao se atravessa por atalho, mesmo vazia: se esta isolada, alguem isolou por um motivo que voce ainda nao conhece.

## O basico de cada risco

**Altura.** Acima de dois metros, so com treinamento especifico, cinto paraquedista e ponto de ancoragem definido. Escada apoiada nao e plataforma de trabalho, e ninguem sobe em caixa, tambor ou pallet empilhado.

**Eletricidade.** Painel eletrico e area de eletricista autorizado. Voce nao abre, nao mexe e nao improvisa emenda. Fio descascado, tomada quente e cheiro de queimado se comunica na hora.

**Maquinas.** Protecao de maquina nao se retira nem se amarra para ficar aberta. Maquina com etiqueta ou cadeado de manutencao nao se liga por nenhum motivo, nem para testar.

**Produto quimico.** Recipiente sem rotulo e produto desconhecido. Nao cheire, nao prove, nao transfira para garrafa de bebida. Antes de usar, leia o rotulo e pergunte qual protecao e exigida.

**Piso e organizacao.** Grande parte das quedas acontece em piso escorregadio, tropeço em cabo e ferramenta largada. Recolher o que voce usou faz parte da tarefa, e nao e servico de limpeza.

## Seu EPI

O equipamento e entregue de graca, contra assinatura na ficha. Confira antes de usar e comunique defeito. Bota, capacete e o que mais a sua funcao exigir se usam o tempo todo em area de risco, e nao apenas quando passa a fiscalizacao.

Se o equipamento nao serve, aperta ou machuca, isso se resolve pedindo troca, e nunca deixando de usar.

## Sobre pegar peso e sobre o corpo

Muita gente se machuca na primeira semana tentando mostrar servico. Carga que pesa demais para um se leva em dois, ou com carrinho. Para levantar, chegue perto, dobre os joelhos, mantenha as costas retas e traga o peso junto ao corpo. **Para virar, mova os pes; nunca gire o tronco com peso na mao.**

Beba agua ao longo do turno, principalmente em servico ao sol. Desidratacao da tontura, camaibra e erro de atencao, e isso e acidente esperando acontecer. Se estiver tomando remedio que da sono, avise o encarregado antes de comecar.

## Se acontecer alguma coisa

- **Nao se mexe no acidentado sem necessidade.** Chame ajuda e a brigada.
- Comunique o acidente imediatamente, por menor que pareça. Corte pequeno que infecciona vira afastamento, e acidente nao comunicado no dia complica o seu direito depois.
- Mal estar, tontura, falta de ar e dor no peito param o servico na hora.
- **Quase acidente tambem se comunica.** A carga que quase caiu hoje e a que cai amanha.
- Ao ouvir o alarme, pare, desligue o que estiver na mao, saia pela rota e va ao ponto de encontro. Nao volte para buscar nada.

## O que ninguem faz aqui

- Nao se corre no local de trabalho, nem para atender ao radio.
- Nao se usa celular caminhando em area de circulacao de veiculo.
- Nao se trabalha sob efeito de alcool ou de medicamento que da sono sem avisar.
- Nao se improvisa ferramenta nem se sobe em estrutura provisoria.
- Nao se faz brincadeira de empurrar, assustar ou apontar mangueira de ar.

## Para lembrar

- Na duvida, **pergunte antes**. Nunca adivinhe.
- Saiba hoje onde ficam a saida, o alarme e o ponto de encontro.
- Leia a ordem de servico antes de assinar.
- Area isolada nao se atravessa; protecao de maquina nao se retira.
- **Todo acidente e todo quase acidente se comunicam no mesmo dia.**
- EPI e gratuito e se usa o tempo inteiro na area de risco.
- Recipiente sem rotulo ninguem abre.
- **Risco grave e iminente da a voce o direito de parar**, avisando o superior.'
where codigo = 'NR-01-INT4';


-- =====================================================================
--  NR-01-INT8: integracao a NR-01, 8 horas
--  Publico: quem participa da gestao de risco. Foco: GRO, PGR, inventario,
--  plano de acao e hierarquia de controle.
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Estrutura das Normas Regulamentadoras e o papel da NR-01 como norma geral.
Gerenciamento de riscos ocupacionais: conceito, abrangencia e ciclo de melhoria.
Programa de gerenciamento de riscos: composicao, guarda e prazos de revisao.
Levantamento preliminar de perigos e fontes de informacao utilizadas.
Inventario de riscos: identificacao, avaliacao e classificacao por severidade e probabilidade.
Matriz de risco, criterios de tolerabilidade e priorizacao das acoes.
Hierarquia de medidas de controle, da eliminacao ao equipamento individual.
Plano de acao: medida, responsavel, prazo e verificacao de eficacia.
Analise de acidentes e de quase acidentes e retorno ao inventario.
Emergencias: cenarios previstos, recursos necessarios e simulados.
Interfaces com o programa de controle medico e com o exame ocupacional.
Papeis da direcao, do SESMT, da CIPA, das liderancas e dos trabalhadores.
Contratantes e contratadas: responsabilidade solidaria e harmonizacao de riscos.
Documentacao, indicadores, auditoria e fiscalizacao do trabalho.',
  apostila =
'## Por que esta norma existe

As demais normas dizem como fazer cada tarefa perigosa. A NR-01 diz **como a empresa deve enxergar o proprio risco antes de qualquer tarefa comecar**. Ela e a norma que organiza as outras.

A mudanca de fundo foi trocar programa de papel por processo vivo. Nao basta ter um documento arquivado: e preciso saber quais perigos existem, quanto valem, o que esta sendo feito a respeito, por quem, ate quando, e se funcionou.

Este material e para quem participa desse processo: lideranca, membro de CIPA, encarregado, tecnico, quem emite ordem de servico e quem responde por contrato de terceiros.

> Inventario que nunca muda e sinal ruim. Se em dois anos nada foi acrescentado nem baixado, ninguem esta olhando para o processo real.

## O gerenciamento de riscos ocupacionais

O GRO nao e um documento, e um ciclo. Ele se repete sem parar:

- **Levantar** os perigos de cada processo, area e funcao.
- **Avaliar** os riscos que decorrem deles.
- **Classificar** por gravidade e probabilidade, para saber o que vem primeiro.
- **Controlar**, seguindo a hierarquia de medidas.
- **Acompanhar** a eficacia e voltar ao inicio quando algo muda.

O que dispara uma nova volta do ciclo: maquina nova, produto novo, mudanca de layout, mudanca de processo, acidente, quase acidente, resultado de exame ocupacional que aponta grupo afetado, inspecao que encontra desvio repetido, e o prazo de revisao periodica.

## O documento: PGR

O programa de gerenciamento de riscos e onde o ciclo fica registrado. Ele tem duas pecas centrais, e as duas precisam existir de verdade:

**Inventario de riscos.** A relacao dos perigos identificados, onde ocorrem, quem esta exposto, qual a consequencia possivel, quais controles ja existem e qual a classificacao resultante. Deve descrever o trabalho como ele acontece, incluindo a manutencao, a partida, a parada e o servico eventual, e nao apenas a operacao normal.

**Plano de acao.** Cada risco que precisa ser tratado vira uma linha com quatro campos que nao podem ficar vazios: **a medida, o responsavel com nome, o prazo com data e a forma de verificar se deu certo**. Plano sem responsavel e sem data e lista de desejos.

Micro e pequenas empresas de menor grau de risco tem tratamento simplificado, e a declaracao de inexistencia de risco so vale quando ela e verdadeira. Prestar declaracao falsa e problema serio, e cai por terra no primeiro acidente.

## Como se classifica um risco

A classificacao combina duas perguntas: **quao grave e a consequencia possivel** e **qual a probabilidade de acontecer**. A matriz cruza as duas e devolve um nivel.

O que importa e o uso que se faz do resultado. O nivel define prazo e prioridade. Risco intoleravel exige medida antes de continuar a atividade. Risco moderado entra no plano com prazo. Risco baixo fica monitorado.

Dois erros comuns aparecem aqui. O primeiro e classificar pela frequencia do acidente passado, e nao pelo dano possivel: uma tarefa que nunca deu problema mas pode matar continua sendo risco alto. O segundo e classificar considerando o EPI como se ele eliminasse o risco. Ele reduz a consequencia; nao apaga o perigo.

## Hierarquia de controle

Esta e a espinha da NR-01 e vale a ordem, e nao apenas a lista:

- **Eliminacao** do perigo ou do fator de risco. Deixar de usar o produto, suprimir a etapa, mudar o projeto.
- **Substituicao** por algo menos perigoso.
- **Controles de engenharia**: enclausuramento, protecao fisica, exaustao, intertravamento, automacao, guarda corpo.
- **Controles administrativos**: procedimento, permissao de trabalho, sinalizacao, rodizio, limitacao de tempo de exposicao, treinamento.
- **Equipamento de protecao individual**, por ultimo.

Descer direto para o EPI e o atalho mais comum e o mais caro. Ele transfere a protecao inteira para o comportamento humano, que falha em dia de pressa, de calor e de cansaço.

Enquanto a medida definitiva nao fica pronta, adota se medida de controle provisoria, com prazo, e ela nao pode virar permanente por inercia.

## Acidente e quase acidente alimentam o sistema

Todo acidente e todo quase acidente devem ser analisados buscando causa, e nao culpado. Analise que termina em ato inseguro do trabalhador quase sempre parou cedo demais: falta perguntar por que aquele comportamento era possivel, por que era mais rapido, e por que ninguem barrou antes.

O resultado da analise volta para o inventario e para o plano de acao. **Analise que nao gera acao no plano e apenas arquivo.**

## Quem responde por que

A direcao responde pela seguranca e nao pode delegar essa responsabilidade. O SESMT assessora tecnicamente. A CIPA identifica riscos, acompanha e cobra. A lideranca direta executa e verifica no dia a dia. O trabalhador cumpre, colabora e comunica.

Em contrato de terceiros, a contratante harmoniza os riscos, informa os perigos da sua area, e nao pode alegar desconhecimento do que acontece dentro dela. Contratada com PGR proprio nao dispensa a contratante de olhar.

## Documentacao e fiscalizacao

Os documentos precisam ficar disponiveis para os trabalhadores, para a CIPA e para a fiscalizacao, com historico. Ordens de servico, registros de treinamento com carga horaria e conteudo, fichas de EPI, analises de acidente e evidencias de cumprimento do plano de acao.

Bons indicadores para acompanhar: percentual de acoes do plano concluidas no prazo, tempo medio de tratamento de desvio, quase acidentes reportados por periodo, e reincidencia de acidente por mesma causa.

## Para lembrar

- **GRO e ciclo, PGR e o registro dele.** Nenhum dos dois vive de arquivo.
- O inventario tem de cobrir manutencao, partida, parada e servico eventual.
- Plano de acao sem responsavel, prazo e verificacao nao e plano.
- Classifique pelo **dano possivel**, e nao pela sorte que se teve ate agora.
- **Respeite a hierarquia**: EPI e o ultimo recurso, nunca o primeiro.
- Medida provisoria tem prazo e nao pode virar definitiva.
- Analise de acidente busca causa, e o resultado volta para o plano.
- Mudou processo, maquina ou produto: revise o inventario antes de operar.'
where codigo = 'NR-01-INT8';


-- =====================================================================
--  DD: direcao defensiva (8 horas)
--  Foco: conducao segura basica de quem dirige a servico.
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Conceito de direcao defensiva e responsabilidade do condutor a servico.
Condicoes adversas de via, de veiculo, de tempo, de luz e de transito.
Inspecao diaria do veiculo antes da saida e itens de verificacao obrigatoria.
Ajuste do posto de conducao, do cinto de seguranca e dos espelhos.
Distancia de seguimento e calculo do tempo de reacao e de frenagem.
Pontos cegos do veiculo e cuidados com veiculos longos.
Ultrapassagem segura, mudanca de faixa e uso de indicadores de direcao.
Cruzamentos, rotatorias e conversoes com travessia de pedestres.
Convivencia com motociclistas, ciclistas e pedestres nas vias urbanas.
Velocidade compativel, sinalizacao de transito e limites legais.
Alcool, medicamentos e uso do celular ao volante.
Documentacao do condutor e do veiculo e infracoes de transito.
Estacionamento, manobra em re e uso de auxiliar de manobra.
Conduta em caso de pane, parada em via e sinalizacao do veiculo.',
  apostila =
'## Por que este treinamento existe

Dirigir a servico e a atividade mais perigosa da maioria das empresas, e quase nunca e tratada como tal. A pessoa que passa o dia na rua com um veiculo da empresa esta exposta a mais risco do que boa parte do pessoal da producao, so que sem colega por perto e sem supervisao direta.

Direcao defensiva e simples de definir: **e dirigir contando com o erro dos outros**. Voce pode fazer tudo certo e ainda assim se envolver num acidente porque alguem furou o sinal. A conducao defensiva trabalha na margem que sobra: distancia, visibilidade, velocidade e atencao suficientes para que o erro alheio nao vire colisao.

> Ter razao no transito nao evita batida nenhuma. A preferencia protege voce no boletim, e nao no impacto.

## As condicoes adversas

Quase todo acidente e a soma de condicoes que ja estavam la:

- **Via**: buraco, curva fechada, pista estreita, obra, lombada sem sinalizacao, cascalho.
- **Veiculo**: pneu careca, freio gasto, farol queimado, palheta ressecada, carga solta.
- **Tempo**: chuva, neblina, vento lateral, sol baixo no horizonte.
- **Luz**: noite, tunel, entrada e saida de garagem, sombra sob viaduto.
- **Transito**: congestionamento, moto entre faixas, caminhao lento, ônibus parando.
- **Condutor**: sono, pressa, raiva, remedio, celular.

Reconhecer a condicao adversa e o comeco. A resposta e quase sempre a mesma e vale para todas: **reduzir a velocidade e aumentar a distancia**.

## Antes de sair

Inspecao rapida, todo dia, antes de ligar. Leva tres minutos:

- Pneus: calibragem, desenho e ausencia de corte na lateral. Nao esqueça o estepe.
- Fluidos: oleo, agua, freio, limpador de para brisa.
- Luzes: farol baixo e alto, lanterna, freio, seta, luz de re, pisca alerta.
- Freio: pedal firme, sem afundar, e freio de estacionamento segurando.
- Palhetas e vidros limpos; espelhos ajustados e inteiros.
- Cinto de todos os assentos, triangulo, macaco, chave de roda e extintor onde exigido.
- Documento do veiculo e sua habilitacao dentro da validade e da categoria.

Ajuste o banco antes de sair, e nao em movimento: encosto quase reto, pernas com folga para pisar fundo, maos na direcao, apoio de cabeca na altura das orelhas. **Cinto sempre, inclusive nos cem metros da portaria ate a rua.**

Pane ou defeito encontrado na inspecao nao vira problema para depois. Veiculo com freio ou pneu ruim nao sai.

## Durante a viagem

**Distancia de seguimento.** Escolha um ponto fixo na via, um poste ou uma placa. Quando o veiculo da frente passar por ele, conte: se voce chegar la antes de dois segundos, esta perto demais. Em chuva, subida de serra ou com carga, use quatro segundos ou mais. Essa distancia e o unico espaco que voce tem para reagir, e reagir leva quase um segundo mesmo com o motorista atento.

**Olhe longe.** Motorista que olha so o para choque da frente freia em cima da hora. Olhando o segundo ou terceiro veiculo adiante voce ve o congestionamento se formar e freia suave.

**Pontos cegos.** Todo veiculo tem, e o seu e maior do que voce imagina. Antes de mudar de faixa: espelho interno, espelho externo, seta, e um giro rapido de cabeça. Ao lado do caminhao, a regra que salva vida e a inversa: se voce nao ve o rosto do motorista no espelho dele, ele nao ve voce.

**Ultrapassagem.** So com visibilidade total, faixa que permite, espaco de sobra e sem inclinacao para se enfiar de volta a força. Na duvida, nao ultrapasse. Chegar cinco minutos depois nunca custou o emprego de ninguem.

**Cruzamentos e rotatorias.** Sinal verde nao e garantia. Antes de entrar, olhe para os dois lados. Ao converter, procure o pedestre que atravessa a via para onde voce esta virando: e ali que ele e atropelado.

**Moto.** Ela aparece do nada porque estava no seu ponto cego ou entre as faixas. Nunca abra a porta sem olhar o retrovisor, e nunca mude de faixa sem seta com antecedencia.

## Velocidade e as regras que nao se negocia

Velocidade compativel nem sempre e a do limite da placa. Com pista molhada, escola no horario de saida ou fila parada adiante, o compativel e menos.

Alcool e zero. Nao existe limite tolerado para quem dirige a servico. Medicamento para alergia, dor forte, ansiedade ou sono precisa ser conversado antes: muitos derrubam o tempo de reacao tanto quanto bebida.

Celular na mao e infracao gravissima e, mais que isso, e a maior causa moderna de colisao traseira. Com o celular no colo, os olhos saem da pista por dois a tres segundos, o que a oitenta por hora significa atravessar quase um quarteirao no escuro. **Se precisa responder, encoste.**

## Manobra, parada e pane

A maioria dos sinistros de frota acontece em baixa velocidade: manobra em pátio, re em cliente, portao de garagem. Antes de dar re, contorne o veiculo a pe e olhe o que ha atras. Onde houver auxiliar de manobra, ele fica sempre visivel para voce, nunca atras do veiculo.

Em caso de pane, saia da pista se conseguir, ligue o pisca alerta, coloque o triangulo a uma distancia que de tempo de frear a quem vem atras, e espere **fora do veiculo e atras da defensa**, nunca sentado dentro do carro na faixa. Colidido por tras em acostamento e um dos acidentes mais fatais que existem.

## Para lembrar

- **Direcao defensiva e contar com o erro do outro.** Preferencia nao protege ninguem.
- Inspecao antes de sair, todo dia. Veiculo com pneu ou freio ruim nao sai.
- **Dois segundos de distancia; quatro na chuva ou com carga.**
- Olhe alem do veiculo da frente e antecipe a frenagem.
- Seta com antecedencia, espelho e giro de cabeca antes de mudar de faixa.
- Se voce nao ve o motorista do caminhao no espelho dele, ele nao ve voce.
- **Alcool zero. Celular so com o veiculo parado.** Remedio que da sono se comunica.
- Em pane: pisca alerta, triangulo e espera fora do veiculo, atras da defensa.'
where codigo = 'DD';


-- =====================================================================
--  DD-REC: direcao defensiva, reciclagem (8 horas)
--  Foco: fadiga, noite, chuva, carga, comportamento de risco e os
--  primeiros minutos apos o acidente.
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Revisao critica dos habitos adquiridos apos anos de conducao a servico.
Fadiga e privacao de sono: efeitos sobre o tempo de reacao e a atencao.
Sinais de sonolencia ao volante e a unica medida realmente eficaz.
Ritmo biologico, janelas de maior risco e planejamento da jornada.
Conducao noturna: ofuscamento, alcance do farol e leitura da via.
Chuva, aquaplanagem, neblina e pista com oleo no inicio da precipitacao.
Frenagem em piso de baixa aderencia e recuperacao de derrapagem.
Carga: distribuicao, amarracao, altura do centro de gravidade e excesso de peso.
Efeito da carga sobre a distancia de frenagem e sobre a estabilidade em curva.
Comportamento de risco: pressa, metas de entrega, disputa e distracao.
Uso de telefone, aplicativos de rota e outras fontes de desatencao.
Alcool, drogas e medicamentos de uso continuo na atividade profissional.
Primeiros minutos apos o acidente: sinalizar, proteger, socorrer e acionar.
Preservacao do local, comunicacao a empresa e registro do ocorrido.',
  apostila =
'## Por que reciclar quem ja dirige ha anos

Quem esta nesta reciclagem ja sabe dirigir. O problema nao e tecnica, e desgaste.

Depois de alguns anos, tres coisas acontecem com todo motorista profissional. A primeira e que os procedimentos viram automatismo e comecam a ser cortados: a inspeção some, a distancia encolhe, o cinto atrasa. A segunda e que a experiencia vira confianca, e confianca vira tolerancia a risco que antes nao se aceitava. A terceira e que a rotina de estrada cobra do corpo, e o corpo cansado dirige pior do que o corpo inexperiente.

Por isso esta reciclagem nao repete o basico. Ela trata do que derruba motorista bom: **cansaco, escuro, agua na pista, carga mal presa, pressa, e o que fazer nos primeiros minutos quando algo deu errado.**

> Ninguem bate porque esqueceu como se dirige. Bate porque estava cansado, com pressa, ou porque a pista mudou e a velocidade nao.

## Fadiga: o risco que ninguem sente chegar

Fadiga nao avisa como a bebida avisa. Ela reduz o tempo de reacao, estreita o campo visual e prejudica a decisao antes que a pessoa perceba que esta ruim. Depois de muitas horas acordado, o desempenho ao volante se aproxima do de quem bebeu.

Existe ainda a microssoneca: de dois a dez segundos de sono com os olhos as vezes abertos. Ela nao e escolha e nao pede licença. A cem por hora, cinco segundos sao quase cento e quarenta metros percorridos sem ninguem dirigindo.

Sinais que exigem parada imediata:

- Piscar demorado, olhos ardendo, cabeca pesando para frente.
- Bocejo em serie.
- Nao lembrar dos ultimos quilometros percorridos.
- Sair da faixa, passar por cima da faixa sonora, corrigir de susto.
- Ficar irritado, ou ficar lendo a mesma placa duas vezes.

A unica coisa que resolve sono e **dormir**. Cafe, ar frio, radio alto, banho e conversa empurram o problema por poucos minutos e escondem os sinais, o que piora a situacao. Encoste em lugar seguro e durma. Um cochilo curto recupera bem mais do que uma hora de café.

As janelas mais perigosas do dia sao a madrugada, entre duas e seis da manha, e o inicio da tarde, depois do almoço. Planeje a jornada contando com isso: dormir mal na vespera e um item de risco tanto quanto pneu careca.

## Noite

A noite concentra menos transito e mais mortes. O motivo e visual. O alcance do farol baixo e curto, e ha faixa de velocidade em que **voce dirige mais rapido do que enxerga**: quando o obstaculo aparece na luz, ja nao ha distancia para parar. Em estrada escura, a velocidade compativel e a que cabe dentro do farol.

Ofuscamento pelo farol de quem vem em sentido contrario cega por segundos. A resposta e olhar para a borda direita da pista e usar a faixa como referencia, reduzindo, e nao revidar com farol alto. Para brisa riscado, vidro sujo e oculos velhos espalham a luz e multiplicam o efeito.

Pedestre, ciclista, animal e veiculo parado sem sinalizacao sao o que mais mata a noite. Olho na borda da pista, e nao so na faixa.

## Chuva e piso escorregadio

O periodo mais perigoso e o **comeco da chuva**: a agua levanta o oleo acumulado no asfalto e a aderencia despenca antes de a pista lavar.

Aquaplanagem acontece quando o pneu deixa de escoar a agua e passa a flutuar. Ela depende de tres coisas: profundidade da agua, velocidade e sulco do pneu. Pneu no limite legal ja aquaplana muito mais cedo que pneu novo.

Se aquaplanou, o volante fica leve e o veiculo para de responder. A reacao correta e contra intuitiva:

- **Tire o pe do acelerador.** Nao freie bruscamente.
- Mantenha o volante firme na direcao em que voce quer ir, sem movimento brusco.
- Espere o pneu tocar de novo, e so entao corrija com suavidade.

Em derrapagem de traseira, olhe para onde quer ir e corrija na direcao da derrapagem, com movimentos pequenos. Em pista molhada, tudo aumenta: distancia de seguimento para quatro segundos ou mais, frenagem antecipada, curva entrada mais devagar.

Neblina pede farol baixo, nunca alto, velocidade bem reduzida e, se ficar impossivel, saida completa da pista com sinalizacao.

## Carga

Carga muda o veiculo. Mesmo dentro do peso, ela altera distancia de frenagem, estabilidade em curva e comportamento em manobra brusca.

- **Peso alto sobe o centro de gravidade** e aproxima o veiculo do tombamento em curva e em desvio repentino.
- Carga concentrada na traseira alivia a dianteira e tira direcao.
- Carga solta vira projetil na frenagem e empurra o veiculo na descida.
- Liquido em tanque parcialmente cheio se desloca e empurra na frenagem.

Amarre com o dispositivo proprio, confira a tensao depois dos primeiros quilometros e de novo apos cada parada, e proteja bordas vivas para a cinta nao cortar. Excesso de peso e infracao, arruina freio e pneu, e transforma qualquer descida em problema.

Com carga, aumente a distancia, entre nas curvas mais devagar e use o freio motor nas descidas longas, poupando o freio de servico.

## Comportamento: o fator que sobra

Depois de tecnica e equipamento, o que resta e decisao.

Pressa por meta de entrega, disputa com outro motorista, ultrapassagem no limite, celular no colo, aplicativo de rota mexido em movimento, comer dirigindo. Nada disso e falta de conhecimento: e escolha feita sob pressao.

Duas ideias ajudam. A primeira: **calcule o ganho real**. Numa viagem de cem quilometros, correr o trecho todo dez por cento mais rapido economiza poucos minutos e multiplica risco. A segunda: acordo antecipado. Decida antes de sair que o telefone toca sem ser atendido, que a rota se altera parado no acostamento, e que atraso se comunica em vez de se compensar no pedal.

Se a meta da empresa so fecha correndo, isso e um problema de gestao e precisa ser reportado, e nao resolvido no volante.

## Os primeiros minutos apos o acidente

O que se faz nos primeiros minutos define se havera uma vitima ou tres. A ordem importa:

- **Proteja o local antes de socorrer.** Pisca alerta, triangulo bem atras, colete refletivo. Segundo acidente sobre o primeiro e comum e costuma ser pior.
- **Nao movimente o ferido**, salvo risco de fogo ou de novo impacto. Lesao de coluna piora com transporte improvisado.
- Chame o socorro e informe direito: rodovia e quilometro ou endereço com referencia, quantas vitimas, se ha gente presa, se ha carga perigosa e qual o numero do painel de risco.
- Desligue o motor e, se souber e for seguro, desconecte a bateria. Nao fume nem deixe fumar perto.
- Estanque hemorragia com compressao direta e panos limpos, e converse com a vitima consciente para mante la calma.
- Acione a empresa e a seguradora, registre a ocorrencia com a autoridade e fotografe o local antes de liberar a via, quando houver essa possibilidade.
- **Nao assuma culpa nem discuta no local.** Passe os dados, colabore com a autoridade e deixe a apuracao para depois.

Depois do episodio, ha o retorno. Motorista que se envolveu em acidente grave costuma voltar tenso, dormir mal e reagir de forma exagerada por semanas. Isso e esperado e merece acompanhamento, e nao vergonha.

## Para lembrar

- **Contra sono so existe dormir.** Cafe apenas apaga o aviso.
- Madrugada e inicio de tarde sao as janelas de maior risco.
- A noite, ande na velocidade que cabe dentro do farol.
- **O comeco da chuva e o momento mais escorregadio.**
- Aquaplanou: tira o pe, volante firme, sem freada brusca.
- Carga alta tomba, carga solta empurra, carga liquida balança.
- Combine antes: celular nao se atende, rota so se mexe parado.
- No acidente: **sinalizar, nao mover o ferido, acionar socorro com local exato.**'
where codigo = 'DD-REC';


-- =====================================================================
--  CONFERENCIA
--
--  Tem de voltar nove linhas, uma por curso, todas com conteudo e
--  apostila preenchidos. Linha com itens = 0 ou palavras = 0 significa
--  que o update nao pegou, e quase sempre o codigo foi digitado errado
--  (repare no ponto de NR-34.5).
-- =====================================================================
select c.codigo,
       c.titulo,
       c.carga_horaria,
       array_length(string_to_array(trim(c.conteudo_programatico),
                                    chr(10)), 1) as itens_conteudo,
       array_length(regexp_split_to_array(trim(c.apostila),
                                          '\s+'), 1)   as palavras_apostila,
       case when c.conteudo_programatico like '%—%'
                 or c.apostila like '%—%' then 'TEM TRAVESSAO'
            else 'ok' end                              as travessao
  from public.trein_curso c
 where c.codigo in ('NR-06', 'NR-17', 'NR-26', 'LOTO', 'NR-34.5',
                    'NR-01-INT4', 'NR-01-INT8', 'DD', 'DD-REC')
 order by c.ordem;
