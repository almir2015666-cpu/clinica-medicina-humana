-- =====================================================================
--  Apostilas — grupo 2: NR-20, BRIG, NR-11, NR-05, NR-10-SEP
--
--  Rode DEPOIS do 01-esquema.sql e do 05-certificado.sql.
--  Pode rodar quantas vezes quiser: são updates, não inserts.
--
--  O QUE ESTE ARQUIVO GRAVA
--  ------------------------
--  Duas coisas diferentes, e vale entender a diferença antes de mexer:
--
--  1) conteudo_programatico — a ementa. Uma linha por item. É o que sai
--     IMPRESSO NO VERSO DO CERTIFICADO. Por isso é curto e formal: quem
--     lê aquilo é o fiscal e o RH do cliente, não o aluno.
--
--  2) apostila — o material de estudo que o aluno abre no celular antes
--     da prova. Markdown simples, linguagem de obra, exemplo concreto.
--     É o oposto do verso do certificado: aqui o texto explica o porquê.
--
--  O NR-20 NÃO TEM conteudo_programatico AQUI, E É DE PROPÓSITO
--  -----------------------------------------------------------
--  O conteúdo programático do NR-20 já foi gravado no 05-certificado.sql,
--  copiado do certificado real que a clínica emitiu. Aquele texto vale
--  mais do que qualquer coisa que se escreva agora, porque já saiu no
--  papel assinado. Este arquivo escreve SOMENTE a apostila do NR-20 e
--  não encosta na coluna do verso.
--
--  ATENÇÃO — LEIA ANTES DE PUBLICAR
--  --------------------------------
--  ESTE CONTEÚDO É UMA MINUTA DIDÁTICA E PRECISA DA CONFERIDA DO
--  RESPONSÁVEL TÉCNICO (ENGENHEIRO OU TÉCNICO DE SEGURANÇA DO TRABALHO)
--  ANTES DE SER PUBLICADO PARA ALUNO. CARGA HORÁRIA, ITENS DE EMENTA E
--  PROCEDIMENTOS DE EMERGÊNCIA VARIAM CONFORME A NORMA VIGENTE, O PORTE
--  DA INSTALAÇÃO E O PROGRAMA DA EMPRESA CONTRATANTE. APOSTILA E VERSO
--  DE CERTIFICADO ERRADOS SÃO PROBLEMA NA FISCALIZAÇÃO, NÃO DETALHE.
-- =====================================================================

alter table public.trein_curso
  -- o material de estudo, em markdown simples
  add column if not exists apostila text;


-- =====================================================================
--  NR-20 — Inflamáveis e combustíveis
--  SÓ A APOSTILA. O conteudo_programatico fica como está.
-- =====================================================================
update public.trein_curso set apostila =
'## Por que esta norma existe

Inflamável não pega fogo do jeito que a gente imagina. O líquido em si quase não queima: o que queima é o vapor que sobe dele. Um tambor de solvente aberto no canto do galpão está soltando vapor mesmo parado, mesmo frio, mesmo sem ninguém perto. Esse vapor é mais pesado que o ar na maioria dos casos, então ele desce, corre pelo piso e vai se juntando na parte baixa, embaixo da bancada, na canaleta, no poço de bomba.

Quando alguém liga uma esmerilhadeira do outro lado do galpão, a faísca encontra aquele vapor que caminhou até lá. O fogo começa longe do tambor, e depois volta correndo até ele. É por isso que acidente com inflamável quase nunca acontece onde a pessoa estava olhando.

A NR-20 existe para quebrar essa sequência em três pontos: controlar o vapor, controlar a fonte de ignição e preparar a resposta para quando os dois se encontrarem mesmo assim.

> Fogo precisa de três coisas ao mesmo tempo: combustível, oxigênio e uma fonte de calor. Tirar qualquer uma das três apaga. Na prática, a que dá para tirar antes do acidente é a fonte de calor.

## Quando ela se aplica a você

Se você trabalha em local onde se armazena, manipula, transfere ou processa líquido inflamável, líquido combustível ou gás inflamável, a NR-20 é sua. Isso inclui posto de abastecimento, base de distribuição, sala de caldeira, oficina que usa solvente, depósito de tinta, área de pintura, planta química e caminhão tanque.

A capacitação tem níveis. O básico é para quem trabalha na área sem operar o processo. O intermediário é para quem opera, faz manutenção ou inspeciona. O avançado é para instalação classe III e para quem tem função de coordenação. Seu certificado precisa dizer qual nível você fez, e o nível precisa bater com a classe da instalação onde você entra.

- Reciclagem: o prazo mais comum é a cada dois anos, mas a empresa pode exigir antes
- Mudou de instalação ou de função? A capacitação pode não servir mais
- Trabalhador de empresa contratada faz o mesmo treinamento que o próprio

## Antes de começar

Nenhum serviço com inflamável começa sem papel. Não é burocracia: a Permissão de Trabalho é o único momento em que alguém para e pensa no serviço inteiro antes de a ferramenta ligar.

Confira, com a PT na mão:

- A análise preliminar de risco descreve o serviço que você vai fazer de verdade, e não um parecido
- A área foi isolada e sinalizada, com distância suficiente para o vapor não alcançar
- Foi feita medição de atmosfera com explosímetro, e o resultado está anotado na PT
- Linhas e equipamentos foram drenados, despressurizados, purgados e bloqueados
- O bloqueio está com cadeado e etiqueta, e a chave está com quem vai executar
- Os extintores estão no local, dentro da validade, e alguém sabe usar
- Existe vigia de fogo designado, e ele não tem outra tarefa

A PT tem hora de começar e hora de acabar. Se o turno virou, se a equipe mudou ou se a condição da área mudou, a PT venceu. Emitir de novo custa quinze minutos. Trabalhar com PT vencida custa outra coisa.

## Durante o trabalho

Transferência de líquido inflamável de um recipiente para outro gera eletricidade estática. O jato batendo no fundo do tambor acumula carga, e a carga procura o caminho para descarregar. Se o caminho for uma faísca no meio do vapor, acabou. Por isso o tambor que enche e o tambor que esvazia precisam estar aterrados e interligados entre si, com cabo e garra em metal limpo, sem tinta e sem ferrugem no ponto de contato.

Erros que aparecem em quase todo laudo de acidente:

- Usar balde ou galão plástico para transferir solvente, porque plástico não aterra
- Encher rápido demais, o que aumenta a estática
- Confiar no cheiro para saber se tem vapor, quando há vapor que anestesia o olfato
- Medir a atmosfera uma vez, no começo, e não medir mais durante o serviço
- Deixar pano embebido em solvente amontoado, que esquenta sozinho e pega fogo
- Usar celular, rádio ou ferramenta elétrica comum dentro da área classificada
- Escorar a porta corta fogo aberta porque estava incomodando

Fonte de ignição não é só chama. É faísca de esmerilhadeira, é o escapamento do caminhão, é a luz de emergência comum, é a solda, é o cigarro, é o motor da furadeira, é o sapato com prego batendo no piso, e é a própria estática do corpo de quem está de uniforme sintético.

## Equipamento

Dentro da área classificada, ferramenta e luminária têm de ser do tipo apropriado para atmosfera explosiva. Isso não é capricho: uma luminária comum tem faísca no interruptor.

Sobre proteção respiratória, que é onde mais se erra: máscara descartável de poeira não protege contra vapor de solvente. Vapor químico pede filtro químico, e filtro químico tem vida útil que corre mesmo guardado, depois de aberto. Em ambiente com falta de oxigênio ou com concentração alta demais, filtro nenhum resolve, e a única saída é ar mandado ou equipamento autônomo.

- Inspecione a máscara antes de vestir: borracha ressecada é vedação ruim
- Faça o teste de vedação com as mãos toda vez que colocar
- Barba por fazer impede a vedação, e aí o equipamento só dá falsa segurança
- Guarde em saco fechado, longe da própria área contaminada
- Roupa antichama não se lava com amaciante, que anula o tratamento
- Filtro vencido, cartucho batido ou cinto com costura solta vão para o descarte, e não para o armário

## Emergência

Os primeiros minutos decidem o resto. A ordem é sempre a mesma: alarme, retirada, contenção.

- Acione o alarme antes de tentar apagar qualquer coisa
- Corte a fonte: feche a válvula, desligue a bomba, pare a transferência
- Ataque princípio de incêndio somente se ele ainda for pequeno e você tiver saída pelas costas
- Em líquido inflamável use pó químico ou espuma, nunca água em jato direto, que espalha o líquido em chamas
- Vazamento sem fogo: afaste todo mundo do lado de baixo do vento, elimine ignição e contenha com material absorvente
- Saia pela rota de fuga sinalizada, ande, e vá até o ponto de encontro
- Não volte para buscar ferramenta, carteira ou celular

Se alguém se molhou de produto, leve ao chuveiro de emergência e deixe água correndo por no mínimo quinze minutos, tirando a roupa contaminada embaixo da água. Se caiu nos olhos, lava olhos pelo mesmo tempo, mantendo a pálpebra aberta. Leve a ficha de segurança do produto junto com a pessoa para o atendimento médico.

## O que a empresa deve, o que você deve

Da empresa: fazer a análise de riscos da instalação, classificar as áreas, manter o plano de resposta a emergência, treinar e reciclar todo mundo, fornecer os equipamentos certos, manter os sistemas de detecção e combate funcionando, e emitir as permissões de trabalho.

Sua: usar o que foi fornecido, seguir o procedimento mesmo quando o serviço é rápido, medir e registrar, comunicar vazamento ou condição insegura na hora, e participar dos simulados a sério.

> Direito de recusa: se o serviço oferece risco grave e iminente, você pode interromper e comunicar o superior. A norma protege quem para. Nenhuma pressa de produção paga um velório.

## Para lembrar

- O que pega fogo é o vapor, e vapor caminha pelo chão até longe
- Sem PT válida, com APR do serviço certo e medição anotada, não começa
- Aterramento e ligação equipotencial em toda transferência, sem exceção
- Faísca de esmeril e de celular também são fonte de ignição
- Água em jato direto espalha líquido inflamável em chamas
- Filtro respiratório tem validade que corre depois de aberto
- Alarme primeiro, combate depois, e só se o fogo ainda for princípio
- Recusar serviço com risco grave e iminente é direito seu'
where codigo = 'NR-20';


-- =====================================================================
--  BRIG — Brigada de incêndio e primeiros socorros (16h)
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Fundamentos do fogo: triângulo do fogo, propagação e classes de incêndio.
Prevenção de incêndio e identificação de riscos no ambiente de trabalho.
Agentes extintores e seleção do extintor conforme a classe do fogo.
Manuseio de extintores portáteis, hidrantes e mangueiras.
Sistemas de detecção, alarme, iluminação de emergência e sinalização.
Plano de emergência, rotas de fuga, abandono de área e ponto de encontro.
Organização da brigada: atribuições, comando e comunicação na emergência.
Avaliação da cena, segurança do socorrista e acionamento do socorro.
Suporte básico de vida: reanimação cardiopulmonar e uso do desfibrilador.
Obstrução de vias aéreas, desmaio, convulsão e estado de choque.
Controle de hemorragias e curativos de urgência.
Atendimento a queimaduras, fraturas, entorses e imobilização.
Movimentação, remoção e transporte de vítimas.
Exercícios simulados de abandono e de atendimento pré-hospitalar.',
  apostila =
'## Por que este treinamento existe

Incêndio em local de trabalho quase nunca começa grande. Começa do tamanho de uma lata de lixo. O que transforma aquilo em manchete é o tempo que se perde entre a primeira fumaça e a primeira ação correta: gente procurando extintor, gente discutindo se chama ou não chama os bombeiros, gente voltando para pegar a bolsa.

Com socorro médico é a mesma coisa. Uma parada cardíaca começa a matar célula de cérebro em quatro minutos. Ambulância em cidade grande leva mais. A conta é simples: quem está ao lado da pessoa quando ela cai é quem decide se ela vive. Não existe outro plano.

A brigada existe para que, nesses primeiros minutos, alguém no local saiba exatamente o que fazer e faça sem esperar ordem.

## Quando ela se aplica a você

Você faz parte da brigada, ou está se preparando para fazer. Isso significa que, no dia da emergência, você tem uma função definida no plano: combater, evacuar, prestar socorro ou controlar o ponto de encontro. Não é voluntariado de improviso.

A brigada atua na própria área onde trabalha, com os recursos que ela tem, e até a chegada do socorro público. Ela não substitui o Corpo de Bombeiros, e não entra em fogo grande. Reconhecer o que está grande demais faz parte do treinamento.

## Prevenção: o trabalho que ninguém vê

Noventa por cento do trabalho da brigada acontece antes do incêndio, andando pela área e olhando coisas chatas.

- Extintor com lacre rompido, manômetro na faixa vermelha ou validade vencida
- Extintor com caixa de papelão ou palete na frente
- Hidrante trancado, sem chave, ou com mangueira apodrecida
- Rota de fuga usada como depósito temporário que já dura seis meses
- Porta corta fogo escorada aberta com um extintor, o que é uma ironia comum
- Luz de emergência que nunca foi testada
- Quadro elétrico com gambiarra, benjamim, fio derretido ou cheiro de queimado
- Lixo, papelão e estopa acumulados perto de fonte de calor

## Classes de fogo e o extintor certo

Errar o agente extintor piora o incêndio. É o erro mais caro que a brigada pode cometer.

- Classe A: material sólido comum, como madeira, papel, tecido e plástico. Queima na superfície e no interior, e deixa brasa. Água é o melhor agente, por resfriamento.
- Classe B: líquido e gás inflamável, como gasolina, solvente, tinta e GLP. Queima só na superfície. Espuma, pó químico ou dióxido de carbono. Água em jato direto espalha o fogo.
- Classe C: equipamento elétrico energizado. O agente não pode conduzir corrente. Dióxido de carbono ou pó químico. Se der para desligar a energia com segurança, o fogo vira classe A ou B.
- Classe D: metal pirofórico, como magnésio e sódio. Precisa de pó especial. Água reage e explode.
- Classe K: óleo e gordura de cozinha em fritadeira. Agente químico úmido próprio. Água vira jato de gordura em chamas.

Para usar o extintor, lembre da sequência: puxar o pino, mirar na base do fogo, apertar o gatilho e varrer de um lado para o outro. Mirar no meio da chama não apaga nada, porque o que queima é o combustível embaixo.

> Aproxime-se com o vento nas costas, ajoelhado ou agachado, e sempre com a saída atrás de você. Se o extintor acabou e o fogo continua, a decisão já está tomada: sai.

## Evacuação

O alarme toca e o relógio começa. A ordem é alarme, abandono, combate, e não o contrário.

- Interrompa o serviço, desligue máquina e energia se der em segundos
- Oriente pela rota sinalizada, em voz firme, sem correria
- Ande, não corra, e não use elevador
- Em ambiente com fumaça, abaixe: o ar respirável fica perto do piso
- Antes de abrir uma porta, toque com as costas da mão. Quente, não abre
- Feche as portas ao sair, porque porta fechada segura fumaça e fogo
- Ajude quem tem dificuldade de locomoção, esse é o papel do evacuador
- No ponto de encontro, confira a lista e informe quem falta ao comando
- Ninguém volta. Quem volta vira a segunda vítima

## Primeiros socorros: os primeiros minutos

A primeira coisa nunca é a vítima. É a cena. Socorrista ferido não socorre ninguém, e ainda ocupa a ambulância.

Avalie: tem fio energizado, vazamento, máquina ligada, trânsito, fogo? Torne o local seguro. Calce a luva. Só então chegue perto. Chame ajuda cedo, pelo 192 do SAMU ou 193 dos bombeiros, e diga onde é e o que aconteceu.

### Reanimação cardiopulmonar

A pessoa não responde ao chamado e não respira normalmente, ou faz só um arquejo. Isso é parada cardíaca.

- Peça ajuda e o desfibrilador, apontando para uma pessoa específica
- Deite a vítima de costas em superfície dura
- Mãos empilhadas no centro do peito, braços esticados, ombro sobre a mão
- Comprima forte, cerca de cinco centímetros, e rápido, cem a cento e vinte por minuto
- Deixe o peito voltar por completo entre uma compressão e outra
- Não pare. Reveze com outro socorrista a cada dois minutos, porque cansaço derruba a qualidade
- Só pare se a pessoa reagir, se o socorro chegar ou se a cena ficar insegura

### Desfibrilador

O aparelho fala com você. Ligue, cole as pás no peito nu e seco conforme o desenho, e faça o que a voz mandar. Enquanto ele analisa, ninguém encosta na vítima. Se mandar chocar, avise em voz alta, olhe se todos se afastaram e aperte. Depois do choque, volte a comprimir na hora.

- Peito molhado se seca antes, peito peludo pode precisar de tricotomia
- Se houver marcapasso ou adesivo de medicamento, cole as pás alguns dedos ao lado
- Não desligue o aparelho até o socorro assumir

### Engasgo

Se a pessoa tosse e fala, incentive a tossir e não bata nas costas. Se ela não consegue emitir som e leva as mãos ao pescoço, aplique compressões abdominais por trás, acima do umbigo, até desobstruir. Se desmaiar, comece a reanimação.

### Hemorragia

- Pressione direto sobre o ferimento com pano limpo, com força e sem aliviar para espiar
- Encharcou, coloque outro pano por cima, sem tirar o de baixo
- Não remova objeto encravado, estabilize ao redor dele
- Torniquete só em membro, em sangramento que não para de jeito nenhum, e anote a hora
- Sangramento nasal: incline a cabeça para a frente e aperte a parte mole do nariz

### Queimadura

- Resfrie com água corrente em temperatura ambiente por dez a vinte minutos
- Retire anel, relógio e pulseira antes de inchar
- Não estoure bolha, não passe pasta de dente, manteiga, borra de café nem pomada
- Cubra com pano limpo e seco, sem algodão, que gruda
- Queimadura química: retire a roupa contaminada e lave por tempo prolongado
- Queimadura elétrica: desligue a energia antes de tocar na pessoa

### Fratura e entorse

Não tente endireitar o membro. Imobilize na posição em que está, incluindo a articulação de cima e a de baixo, com talas improvisadas e amarras que não apertem a circulação. Gelo protegido por pano ajuda no inchaço. Suspeita de lesão na coluna: não movimente, a não ser que haja risco de morte no local.

### Convulsão

- Afaste móveis e objetos e proteja a cabeça com algo macio
- Não segure a pessoa e não coloque nada na boca dela
- Marque a hora de início
- Passada a crise, vire de lado, afrouxe a roupa e fique junto até a pessoa se orientar
- Crise acima de cinco minutos, ou repetida, é emergência

### Estado de choque

Pele fria, pálida e suada, pulso rápido, respiração curta, confusão. Deite a pessoa, cubra para manter a temperatura, não dê nada para beber e monitore a respiração até o socorro chegar.

## O que a empresa deve, o que você deve

Da empresa: manter a brigada dimensionada e treinada, com reciclagem periódica, manter extintores, hidrantes, alarme, iluminação e sinalização em ordem, manter o plano de emergência escrito e fazer simulado de abandono.

Sua: conhecer sua função no plano, saber onde estão os equipamentos sem precisar procurar, inspecionar a área no dia a dia, participar do simulado a sério e manter o registro do seu treinamento em dia.

## Para lembrar

- Alarme primeiro, combate depois, e só em princípio de incêndio
- Água em líquido inflamável e em equipamento energizado nunca
- No extintor: puxar, mirar na base, apertar, varrer
- Fumaça mata antes do fogo, e o ar bom está perto do chão
- Cena segura antes da vítima, sempre
- Não respira normalmente e não responde: comprima o peito forte e rápido
- O desfibrilador fala, você obedece, e ninguém encosta na hora da análise
- No ponto de encontro se confere a lista, e ninguém volta'
where codigo = 'BRIG';


-- =====================================================================
--  NR-11 — Operação de empilhadeira e movimentação de cargas (16h)
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Legislação aplicável à movimentação, transporte e armazenagem de materiais.
Tipos de empilhadeira, componentes e princípios de funcionamento.
Estabilidade da carga: triângulo de estabilidade e diagrama de capacidade.
Centro de carga, distribuição de peso e limites do equipamento.
Inspeção diária do equipamento e registro das não conformidades.
Operação segura: partida, deslocamento, curvas, rampas e frenagem.
Elevação, empilhamento, desempilhamento e movimentação de paletes.
Circulação, sinalização, velocidade e convivência com pedestres.
Abastecimento, troca de bateria e cuidados com combustível e gases.
Armazenagem, estocagem e conservação de materiais em pilhas e porta paletes.
Elevação de pessoas e restrições ao uso de plataforma na empilhadeira.
Riscos de tombamento, atropelamento e queda de carga.
Manutenção preventiva, exame de saúde e habilitação do operador.
Prática supervisionada de operação e estacionamento seguro.',
  apostila =
'## Por que esta norma existe

Empilhadeira é o veículo que mais mata dentro de galpão. E ela não mata do jeito que se espera. A maioria dos operadores imagina que o risco é bater. O risco de verdade é outro: tombar de lado com o operador tentando pular fora, e atropelar quem estava atrás de uma pilha.

Empilhadeira pesa mais que um carro de passeio, muitas vezes o dobro, e todo esse peso está concentrado atrás para equilibrar a carga da frente. Ela freia mal, esterça pelas rodas traseiras e enxerga pouco. Quando tomba, cai em menos de um segundo, e o operador que salta acaba embaixo da estrutura de proteção. Quem fica sentado e usa cinto quase sempre sai andando.

> Se a empilhadeira começar a tombar, NÃO PULE. Segure o volante, incline o corpo para o lado contrário da queda, firme os pés e continue sentado com o cinto afivelado. A estrutura de proteção foi feita para isso, e o cinto é o que mantém você dentro dela.

## Quando ela se aplica a você

A norma vale para toda movimentação, transporte, armazenagem e manuseio de materiais, com equipamento motorizado ou não. Se você opera empilhadeira, transpaleteira elétrica, paleteira, ponte rolante ou guincho, ela é sua. Vale também para quem organiza a estocagem, porque pilha mal feita cai sozinha.

Para operar empilhadeira, três coisas precisam existir ao mesmo tempo:

- Treinamento com certificado dentro da validade
- Autorização por escrito da empresa, com o crachá ou credencial em mãos
- Exame de saúde em dia, com aptidão para a função

Idade mínima de dezoito anos. Habilitação de trânsito não substitui a autorização da empresa, e autorização de uma empresa não vale na outra.

## Antes de começar: a inspeção do turno

A checagem de início de turno leva cinco minutos e é obrigatória. O resultado vai para a ficha, mesmo quando está tudo bom, porque ficha em branco não prova nada.

Com o motor desligado:

- Pneus: desgaste, corte, pressão e roda com parafuso faltando
- Vazamento embaixo do equipamento, e nível de óleo, água e fluido hidráulico
- Garfos: trinca, empeno, desgaste no calcanhar e travas no lugar
- Correntes e mangueiras do mastro, sem folga desigual e sem vazamento
- Estrutura de proteção do operador e grade anteparo de carga firmes
- Cinto de segurança inteiro, com trava funcionando
- Placa de capacidade legível, e ela é do equipamento com o acessório instalado

Com o motor ligado:

- Freio de serviço e de estacionamento
- Direção, buzina, luzes, alarme de ré e sinalizador
- Subida, descida e inclinação do mastro, sem trepidação
- Vazamentos que só aparecem sob pressão

Achou problema que afeta a segurança, o equipamento sai de operação. Etiqueta de bloqueio, chave entregue e aviso à manutenção. Empilhadeira com freio ruim não é para o final do turno.

## Durante o trabalho

### Estabilidade

A empilhadeira se equilibra sobre um triângulo, e não sobre um retângulo. Os vértices são as duas rodas dianteiras e o centro do eixo traseiro. Enquanto o peso combinado do equipamento e da carga estiver dentro desse triângulo, ela fica de pé. Quando sai, tomba. Curva rápida joga o peso para fora do triângulo, e carga alta joga para cima, o que piora tudo.

Centro de carga é a distância do calcanhar do garfo até o meio do peso. A placa costuma falar em quinhentos milímetros. Carga mais comprida tem centro mais longe, e a capacidade real cai, mesmo que o peso seja o mesmo. Quem só olha o peso e ignora o comprimento tomba com carga dentro da capacidade nominal.

### Deslocamento

- Circule com os garfos baixos, cerca de quinze centímetros do piso, e mastro inclinado para trás
- Nunca ande com a carga elevada, porque ali o centro de gravidade está lá em cima
- Carga que tapa a visão: ande de ré, olhando para trás, ou peça um sinaleiro
- Em rampa com carga, suba de frente e desça de ré, com a carga sempre para o lado de cima
- Sem carga em rampa, o inverso: suba de ré e desça de frente
- Reduza em cruzamento, porta, piso molhado e mudança de iluminação, e buzine
- Distância de três comprimentos da empilhadeira da frente
- Não passe por cima de mangueira, cabo ou buraco sem olhar
- Pedestre sempre tem preferência, e você não aposta que ele viu você

### Carga

Encoste os garfos no palete até o calcanhar, com a maior abertura possível, e recue o mastro antes de erguer. Levante devagar, confira se o palete está inteiro e a carga amarrada, e só então movimente. No empilhamento, aproxime devagar, posicione, abaixe, recue reto e só depois vire.

Erros que aparecem sempre:

- Erguer carga só com a ponta do garfo
- Empurrar ou arrastar carga com o garfo de lado, o que entorta o mastro
- Improvisar contrapeso para levantar mais
- Levar passageiro, ou deixar alguém subir no garfo ou no palete
- Passar ou parar por baixo dos garfos elevados
- Fazer curva com carga alta
- Deixar o equipamento ligado e sair para resolver algo rápido
- Empilhar acima da altura estável ou sobre piso irregular

Elevação de pessoa só acontece com plataforma própria, fixada ao equipamento, com guarda corpo e travamento, e com o operador permanecendo nos controles o tempo todo. Palete com gente em cima não é plataforma.

### Estacionamento

Garfos no chão, mastro inclinado para a frente, comandos em neutro, freio de estacionamento acionado, chave retirada. Nunca em frente a extintor, hidrante, quadro elétrico, saída de emergência ou em rampa. Em rampa, sem alternativa, calce as rodas.

## Equipamento e abastecimento

Empilhadeira a combustão solta monóxido de carbono e não entra em ambiente fechado sem ventilação. Abastecimento com o motor desligado, sem chama e sem celular por perto. Troca de cilindro de GLP com válvula fechada, luva e sem torcer a mangueira.

Bateria de empilhadeira elétrica solta hidrogênio ao carregar, que é explosivo, e o eletrólito é ácido. Carregue em local ventilado e sinalizado, sem faísca, com óculos, luva e avental. Se cair ácido na pele, lave em água corrente por bastante tempo.

O operador também tem seus equipamentos: calçado de segurança, colete refletivo, capacete quando a área exige e protetor auricular quando o ruído exige.

## Emergência

- Tombamento: segure, incline para o lado oposto e não pule
- Carga caiu: pare tudo, isole a área e não tente segurar nada com o corpo
- Atropelamento: não mova a vítima se houver suspeita de lesão na coluna, acione o socorro e a brigada
- Incêndio no equipamento: desligue, saia e use extintor apropriado, lembrando que bateria e sistema elétrico pedem agente que não conduza
- Vazamento de fluido hidráulico quente pode penetrar a pele, então não procure furo com a mão

## O que a empresa deve, o que você deve

Da empresa: treinar e autorizar por escrito, manter os exames de saúde, fazer a manutenção preventiva e corretiva com registro, sinalizar e demarcar as vias, separar fluxo de pedestre, garantir piso adequado e iluminação, e manter as placas de capacidade legíveis.

Sua: inspecionar antes de operar, respeitar a capacidade e a velocidade, usar o cinto sempre, comunicar defeito e não improvisar. Improviso em movimentação de carga costuma ser a última decisão que alguém toma.

## Para lembrar

- Nunca pule de empilhadeira tombando, use o cinto e fique dentro da proteção
- Capacidade depende do peso E do centro de carga, e a placa é do conjunto montado
- Ande com garfo baixo e mastro inclinado para trás, nunca com carga erguida
- Em rampa, a carga fica sempre para o lado de cima
- Curva com carga alta é a receita clássica do tombamento
- Ninguém sobe em garfo ou palete, e ninguém passa sob carga suspensa
- Autorização por escrito, exame em dia e certificado válido, os três juntos
- Defeito de segurança tira o equipamento de operação na hora'
where codigo = 'NR-11';


-- =====================================================================
--  NR-05 — CIPA (20h)
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Objetivos, organização e funcionamento da Comissão Interna de Prevenção de Acidentes.
Composição, eleição, mandato e estabilidade dos representantes.
Atribuições dos membros, do presidente, do vice presidente e do secretário.
Estudo do ambiente, das condições de trabalho e dos riscos ocupacionais.
Mapa de riscos e inspeções de segurança planejadas.
Metodologia de investigação e análise de acidentes e de doenças do trabalho.
Conceito de acidente do trabalho, quase acidente e comunicação de acidente.
Noções de higiene ocupacional: agentes físicos, químicos e biológicos.
Noções de ergonomia e de prevenção de lesões por esforço repetitivo.
Prevenção e combate a incêndio e noções de primeiros socorros.
Prevenção e enfrentamento do assédio sexual e das demais formas de violência.
Relação entre a CIPA, o SESMT e o programa de gerenciamento de riscos.
Elaboração do plano de trabalho, atas e reuniões ordinárias.
Campanhas internas, SIPAT e divulgação das ações de prevenção.',
  apostila =
'## Por que esta comissão existe

Quem enxerga o risco primeiro não é o engenheiro de segurança. É o trabalhador que passa oito horas ali. Ele sabe qual degrau está solto, qual máquina precisa de um jeitinho para ligar, em qual horário o corredor fica escuro e qual colega já levou choque naquela tomada e não contou para ninguém.

A CIPA existe para transformar esse conhecimento em ação registrada. Sem ela, a informação morre na conversa do almoço. Com ela, vira item de ata, com responsável e prazo, e alguém precisa responder por que não foi feito.

O nome mudou: hoje é Comissão Interna de Prevenção de Acidentes e de Assédio. A prevenção do assédio entrou para dentro da comissão porque violência e assédio adoecem tanto quanto ruído e produto químico, e por muito mais tempo.

## Quando ela se aplica a você

Você foi eleito ou indicado para a CIPA, ou vai concorrer. A partir da posse, seu trabalho tem uma parte a mais, que não substitui a sua função, mas também não é favor: é obrigação legal da empresa dar o tempo para você exercer.

A comissão tem duas metades. Metade é indicada pelo empregador, e dela sai o presidente. Metade é eleita pelos trabalhadores em voto secreto, e dela sai o vice presidente. O mandato é de um ano, com direito a uma reeleição.

- O eleito tem estabilidade desde o registro da candidatura até um ano após o fim do mandato
- Estabilidade não é blindagem: protege contra dispensa sem justa causa, e existe para você poder falar sem medo
- Empresa com menos gente pode não ter CIPA, mas precisa ter designado, e ele faz papel parecido
- Onde há várias empresas no mesmo local, cabe à contratante integrar as ações

## Antes de começar o mandato

Chegar na primeira reunião sem saber onde se pisa é o jeito mais rápido de a CIPA virar comissão de cafezinho. Peça e leia:

- O inventário de riscos e o plano de ação do programa de gerenciamento de riscos
- O PCMSO e o que os exames mostraram, sem nomes
- As atas da CIPA anterior, e o que ficou pendente
- O histórico de acidentes, afastamentos e comunicações de acidente dos últimos anos
- O mapa de riscos atual, se existir
- O plano de emergência e a lista da brigada
- As ordens de serviço entregues aos trabalhadores

Compare com o que você vê no chão. Onde papel e realidade não batem, está o assunto da sua primeira reunião.

## Durante o mandato

### Reunião que serve para alguma coisa

A reunião é mensal, em horário de trabalho, e vira ata. Ata sem responsável e sem prazo é só um relato. Escreva assim: o que será feito, quem faz, até quando, e como se confere. Na reunião seguinte, primeiro item da pauta é a lista da reunião anterior.

### Inspeção de segurança

Ande pela área com olhos de quem não trabalha ali. Leve uma lista, e não a memória.

- Piso, escada, corrimão, iluminação e ventilação
- Proteções de máquina retiradas ou burladas, e por que foram burladas
- Extintor, hidrante, rota de fuga, saída com cadeado
- Quadro elétrico aberto, gambiarra, fio exposto
- EPI disponível, na medida certa, e em uso de verdade
- Armazenamento de produto químico, com ficha de segurança acessível
- Postura, peso levantado, repetição de movimento, mobiliário
- Sinalização, demarcação de tráfego e organização

> Anote a condição, e não a pessoa. Registro do tipo o fulano não usa o protetor gera briga e esconde o problema. Registro do tipo protetor auricular indisponível no turno da noite gera solução.

### Investigar acidente sem procurar culpado

Toda vez que a investigação termina em falta de atenção do trabalhador, ela parou cedo demais. Falta de atenção é o começo da pergunta, não a resposta. Pergunte por que até chegar em algo que a empresa consiga mudar: o procedimento existia, estava escrito de forma clara, tinha ferramenta certa, a produção dava tempo, a pessoa tinha sido treinada.

Investigue também o quase acidente, aquilo que quase pegou e ninguém registrou. Ele traz a mesma lição do acidente grave pelo preço de um susto.

### Assédio e violência

A comissão acompanha as medidas de prevenção ao assédio sexual e às demais formas de violência no trabalho. Isso inclui divulgar os canais de denúncia, garantir que exista canal com sigilo, e incluir o tema nas capacitações.

- Assédio sexual é conduta de conotação sexual não desejada, e não brincadeira
- Assédio moral é a humilhação repetida que empurra a pessoa a pedir demissão
- Quem recebe um relato guarda sigilo e encaminha, e não investiga por conta própria
- Vítima e testemunha não podem ser retaliadas

### Reconhecer o risco pelo nome certo

Na inspeção ajuda saber em que gaveta cada coisa cai, porque isso muda a medida que se cobra.

- Risco físico: ruído, calor, frio, vibração, umidade e radiação
- Risco químico: poeira, fumo de solda, névoa, gás, vapor e produto que entra pela pele
- Risco biológico: bactéria, vírus e fungo, comum em saúde, limpeza e coleta de resíduo
- Risco ergonômico: peso levantado, repetição, postura forçada, ritmo imposto e jornada
- Risco de acidente: máquina sem proteção, piso ruim, altura, eletricidade, animal peçonhento

A ordem de preferência das medidas também é sempre a mesma: primeiro eliminar o risco, depois reduzir na fonte, depois medida coletiva, depois medida administrativa como rodízio e sinalização, e só no fim o EPI. Quando a única resposta que a empresa dá é comprar mais EPI, a comissão tem assunto para a próxima ata.

Ergonomia costuma ser o risco mais ignorado porque não machuca hoje. Ele cobra em três anos, na forma de afastamento por lesão de ombro, de punho ou de coluna, e aí não tem conserto rápido.

### Mapa de riscos e campanhas

O mapa de risco é um desenho da área com círculos coloridos por tipo de risco, e o tamanho do círculo indica a intensidade. Ele só funciona se ficar afixado onde as pessoas passam e se for atualizado quando a área muda.

A SIPAT é a semana de prevenção. Ela vale pelo que fica depois: um risco corrigido vale mais que um dia inteiro de palestra.

## Emergência

A CIPA não substitui a brigada, mas costuma ser quem está perto quando algo acontece. Nos primeiros minutos: garanta a cena segura, acione o socorro e a brigada, não mova vítima com suspeita de lesão na coluna, e preserve o local do acidente até a análise, tirando foto antes de qualquer coisa ser mexida.

Depois: acompanhe a emissão da comunicação de acidente de trabalho, que é direito do trabalhador e obrigação da empresa, mesmo quando não houve afastamento.

## O que a empresa deve, o que você deve

Da empresa: convocar a eleição no prazo, garantir o treinamento antes da posse, ceder tempo para reuniões e inspeções, fornecer as informações técnicas pedidas, responder às recomendações da comissão e manter os registros.

Sua: participar das reuniões, fazer as inspeções, levar o que ouve do colega, cobrar prazo com educação e insistência, registrar tudo. E entender que a CIPA não executa a obra, ela identifica, recomenda e acompanha, com a força de estar escrito.

## Para lembrar

- Metade indicada com o presidente, metade eleita com o vice, mandato de um ano
- Estabilidade vai do registro da candidatura até um ano depois do mandato
- Ata sem responsável e sem prazo não vale nada
- Registre a condição insegura, nunca o nome de quem errou
- Falta de atenção não é causa de acidente, é sinal de que a análise parou cedo
- Quase acidente ensina o mesmo que o acidente, e sai de graça
- A comissão também cuida da prevenção ao assédio, com sigilo e sem retaliação
- A CIPA recomenda e acompanha, e a força dela é o registro'
where codigo = 'NR-05';


-- =====================================================================
--  NR-10-SEP — Complementar Sistema Elétrico de Potência (40h, avançado)
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Organização do Sistema Elétrico de Potência: geração, transmissão e distribuição.
Equipamentos e instalações de alta tensão e suas particularidades operacionais.
Riscos típicos do SEP: choque, arco elétrico, campos, altura e ambiente.
Análise de risco, procedimentos de trabalho e ordens de serviço no sistema elétrico.
Manobras, desenergização, teste de ausência de tensão e aterramento temporário.
Equipotencialização, proteção contra tensão induzida e contra descargas atmosféricas.
Sistemas de proteção coletiva aplicáveis a linhas e subestações.
Equipamentos de proteção individual para alta tensão e vestimenta antichama.
Trabalho em linha viva, métodos ao potencial e à distância, e suas restrições.
Trabalho em altura, em espaço confinado e em área classificada dentro do SEP.
Liberação da instalação para o serviço e para o retorno à operação, com responsabilidades definidas.
Autorização do trabalhador, supervisão e comunicação entre equipes e centro de operação.
Acidentes típicos no SEP, análise de casos e resposta a emergência.
Primeiros socorros com ênfase em vítima de choque elétrico e queimadura por arco.',
  apostila =
'## Por que este complementar existe

A NR-10 básica ensina a não morrer perto da eletricidade. O complementar SEP ensina a trabalhar dentro de um sistema que não desliga por vontade sua.

No Sistema Elétrico de Potência a energia vem de longe, atravessa quilômetros e pode voltar por caminhos que você não vê. Um circuito aberto na sua ponta pode estar energizado pela outra, por realimentação de gerador particular, por transformador alimentado pelo lado de baixa, por acoplamento capacitivo ou por religamento automático comandado de um centro de operação a centenas de quilômetros dali.

Some a isso o arco elétrico. Em alta tensão, um curto abre um arco que passa de dez mil graus, mais quente que a superfície do sol, com pressão que arremessa a pessoa e luz que cega. O arco não precisa de contato: basta chegar perto demais. Ele queima roupa comum contra a pele, e quem sobrevive costuma sobreviver pelo tecido que estava vestindo.

> No SEP a pergunta nunca é apenas está desligado. A pergunta é quem desligou, por onde ainda pode chegar tensão, e quem garante que não volta enquanto eu estiver lá dentro.

## Quando ele se aplica a você

O complementar SEP é para quem intervém no sistema elétrico de potência e nas suas proximidades: linha de transmissão e distribuição, subestação, usina, rede aérea e subterrânea, medição, e também para quem faz serviço de terceiro nessas áreas.

Ele não substitui o básico, soma a ele. Sem o básico válido, o SEP não vale.

Para ser trabalhador autorizado, três condições ao mesmo tempo: qualificação ou capacitação comprovada, autorização formal da empresa por escrito, e aptidão no exame de saúde para a atividade, considerando trabalho em altura e riscos associados. Reciclagem bienal, e nova capacitação quando muda a função, muda a empresa ou muda o método de trabalho.

## Antes de começar

O serviço começa na mesa, com papel, e não no poste.

- Ordem de serviço específica, dizendo o que será feito e onde, com identificação do circuito
- Análise de risco da tarefa, feita para aquele serviço e assinada pela equipe que vai executar
- Procedimento de trabalho escrito para a atividade, e não para uma atividade parecida
- Comunicação e autorização do centro de operação, com bloqueio do religamento automático
- Definição de quem é o supervisor e de quem comanda a manobra
- Confirmação de que a equipe tem número mínimo de pessoas e que ninguém trabalha sozinho
- Condição climática avaliada, porque descarga atmosférica na região interrompe o serviço

Confira também a validade das ferramentas isolantes e dos equipamentos de proteção, com os ensaios elétricos em dia. Luva de borracha vencida é luva comum.

## Durante o trabalho

### A sequência da desenergização

Ela tem ordem, e a ordem não muda:

- Seccionamento do circuito, com abertura visível ou comprovada
- Impedimento de reenergização, com bloqueio físico, cadeado e etiqueta de identificação
- Constatação da ausência de tensão, com detector próprio para a classe de tensão, testado antes e depois no próprio local
- Instalação do aterramento temporário, com equipotencialização da zona de trabalho
- Proteção dos elementos energizados que ficaram perto, com cobertura ou barreira
- Sinalização e delimitação da área de trabalho

O aterramento temporário é a linha que separa o susto do velório. Ele existe para que, se a tensão voltar por engano, a corrente encontre um caminho de baixa resistência longe do seu corpo, e a proteção atue. Instale sempre do lado de terra primeiro e retire por último, e mantenha o trabalho entre os pontos aterrados.

Para reenergizar, o caminho é o inverso, com uma regra a mais: retirada de ferramentas, conferência de que não há ninguém na instalação, retirada dos aterramentos, retirada do bloqueio pelo mesmo profissional que bloqueou, remoção da sinalização e só então a manobra. Bloqueio se retira com o cadeado próprio, e nunca com o alicate porque a chave sumiu.

### Erros que aparecem nas análises de acidente

- Testar o detector só depois de usar, e descobrir que ele já estava com pilha fraca
- Confiar em circuito identificado no desenho, sem conferir no campo
- Aterrar de um lado só, quando há alimentação pelos dois
- Esquecer da tensão induzida em linha paralela que continua energizada
- Trabalhar em circuito de baixa alimentado por transformador que tem tensão no primário
- Trocar de equipe no meio do serviço sem repassar a condição de bloqueio
- Aproximar escada, cesto ou ferramenta da zona controlada sem calcular a distância
- Usar roupa sintética por baixo da vestimenta antichama, que derrete e gruda na pele
- Começar manobra com tempestade se aproximando

### Linha viva

Trabalho energizado em alta tensão só acontece quando há impossibilidade técnica de desligar ou risco maior no desligamento, com procedimento específico, equipe treinada no método e supervisão permanente. O método ao potencial coloca a equipe no mesmo potencial do condutor. O método à distância usa vara de manobra e mantém afastamento. Nos dois, a distância de segurança é calculada e não estimada no olho.

Quem não foi treinado naquele método específico não participa, nem para ajudar.

## Equipamento

A vestimenta antichama é o equipamento que decide o desfecho de um arco. Ela é escolhida pelo nível de energia incidente calculado para aquele ponto da instalação, e vale como conjunto: camisa, calça, capuz com viseira, luvas e balaclava. Nada sintético por baixo, e nada de camisa aberta por calor.

- Luva isolante de borracha na classe da tensão, com luva de cobertura em couro por cima
- Inspecione a luva antes de cada uso, com teste de inflação para achar furo
- Ensaio elétrico periódico das luvas, mangas, varas e detectores, com registro
- Capacete classe elétrica, sem furo e sem adesivo que esconda trinca
- Cinturão tipo paraquedista e talabarte para trabalho em altura, com ancoragem definida
- Detector de tensão apropriado à classe, testado antes e depois de cada uso
- Ferramenta isolada, e não apenas com cabo plastificado

Equipamento com corte, ressecamento, queimadura, contaminação por óleo ou ensaio vencido vai para descarte controlado. Deixar no armário para uma emergência é como manter um extintor vazio pendurado.

## Emergência

Choque em alta tensão não se socorre puxando a vítima. A primeira ação é desenergizar, e a segunda é confirmar que desenergizou.

- Acione o centro de operação e peça o desligamento e o bloqueio do religamento
- Não entre na zona sem confirmação, mesmo com a vítima à vista
- Cuidado com a tensão de passo em torno de cabo caído no solo: afaste-se com passos curtos, sem separar os pés
- Confirmada a desenergização e instalado o aterramento, resgate conforme o procedimento
- Vítima em altura precisa de resgate planejado, porque suspensão prolongada no cinturão mata
- No solo, avalie resposta e respiração e inicie reanimação cardiopulmonar imediatamente, com desfibrilador se houver
- Queimadura por arco: cubra com pano limpo e seco, não estoure bolha, não passe nada, e leve ao hospital
- Toda vítima de choque vai para avaliação médica mesmo que se levante e diga que está bem, porque arritmia aparece depois

## O que a empresa deve, o que você deve

Da empresa: manter o prontuário das instalações elétricas, os procedimentos escritos, o estudo de arco elétrico e a definição das vestimentas, a autorização formal dos trabalhadores, a reciclagem no prazo, os ensaios dos equipamentos, e a comunicação formal com o centro de operação.

Sua: seguir a sequência sem pular etapa, testar o detector, aterrar, bloquear com o seu cadeado, recusar serviço sem procedimento e sem condição segura, e nunca liberar a instalação sem conferir que a equipe inteira saiu.

> Direito de recusa: diante de risco grave e iminente, você interrompe as atividades e comunica ao superior. No SEP isso é rotina profissional, e não insubordinação.

## Para lembrar

- Desligado no desenho não é desligado no campo: teste sempre, no local
- Detector se testa antes e depois de usar, na própria classe de tensão
- Bloqueio, etiqueta e cadeado seu, retirado por você
- Aterramento temporário é o que segura a energia que volta por engano
- Tensão induzida e realimentação energizam circuito que você jurava morto
- A vestimenta antichama é escolhida pelo cálculo do arco, e sem sintético por baixo
- Cabo caído no chão: passos curtos, sem separar os pés, e ninguém se aproxima
- Toda vítima de choque vai ao médico, mesmo andando e falando
- Religamento automático bloqueado e confirmado antes de qualquer intervenção'
where codigo = 'NR-10-SEP';


-- =====================================================================
--  Conferência
-- =====================================================================
select codigo,
       coalesce(cardinality(
         array_remove(string_to_array(trim(conteudo_programatico), chr(10)), '')
       ), 0)                                          as itens_conteudo,
       coalesce(cardinality(
         array_remove(regexp_split_to_array(trim(coalesce(apostila, '')), '\s+'), '')
       ), 0)                                          as palavras_apostila,
       case when apostila is null then 'FALTA a apostila' else 'ok' end as material
  from public.trein_curso
 where codigo in ('NR-20', 'BRIG', 'NR-11', 'NR-05', 'NR-10-SEP')
 order by codigo;
