-- =====================================================================
--  Apostilas e conteúdo programático, grupo 1
--  NR-10, NR-33, NR-35-REC, NR-12 e NR-18
--
--  Rode no SQL Editor. Pode rodar quantas vezes quiser: são updates, não
--  inserts, e cada bloco reescreve o próprio curso pelo `codigo`.
--
--  O QUE ESTE ARQUIVO GRAVA
--  -----------------------
--  Duas colunas por curso:
--
--  `conteudo_programatico` é a ementa que sai impressa no VERSO do
--  certificado, um item por linha. Curta e formal, porque é documento.
--  O 05-certificado.sql criou essa coluna e deixou só o NR-20 preenchido;
--  estes cinco cursos saíam com uma página só. Agora saem com as duas.
--
--  `apostila` é o material de estudo que o aluno lê na plataforma antes da
--  prova. É criada aqui se ainda não existir. Markdown simples de
--  propósito: título, subtítulo, parágrafo, lista, negrito e a linha de
--  destaque que começa com sinal de maior. O aluno lê no celular, no
--  intervalo, e o que não renderizar bem em tela pequena não serve.
--
--  Nenhum travessão no texto gravado, pela mesma razão do 06 e do 08: no
--  certificado impresso ele fica estranho, e a rede de segurança daqueles
--  arquivos troca travessão por vírgula de qualquer jeito.
--
--  ATENÇÃO: ESTE CONTEÚDO PRECISA DA CONFERIDA DO RESPONSÁVEL TÉCNICO
--  ANTES DE SER PUBLICADO COMO MATERIAL DO CURSO.
--  Foi escrito a partir do conteúdo usual de cada norma e do que se cobra
--  em campo. É coerente com as normas, mas quem responde pelo treinamento
--  é o responsável técnico, e é o nome dele que vai no certificado.
--  Apostila com erro ensina errado, e o aluno leva o erro para a obra.
--
--  ESCOPO, DE PROPÓSITO
--  A NR-10 é de 40 horas e a NR-18 cobre um canteiro inteiro. Nenhuma
--  apostila esgota a norma, e não é para esgotar: cada uma cobre o que
--  mantém o trabalhador vivo e o que cai na prova, com profundidade real.
--  O resto é aula, prática e supervisão.
-- =====================================================================

-- A coluna de material de estudo. O 01-esquema.sql previu apostila em
-- arquivo, no Storage (`trein_aula.material_path`); isto aqui é o texto
-- lido dentro da plataforma, que não depende de download nem de PDF.
alter table public.trein_curso
  add column if not exists apostila text;


-- =====================================================================
--  NR-10, Segurança em instalações e serviços em eletricidade
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Riscos em instalações elétricas e introdução à segurança com eletricidade.
Choque elétrico: mecanismos, percurso da corrente e efeitos no corpo humano.
Arco elétrico, queimaduras, campos eletromagnéticos e risco de explosão.
Análise de risco e medidas de controle do risco elétrico.
Desenergização e as etapas obrigatórias para o serviço em circuito desligado.
Bloqueio, etiquetagem e impedimento de reenergização.
Aterramento temporário e sua função na proteção da equipe.
Equipamentos de proteção coletiva e individual aplicados à eletricidade.
Vestimenta de proteção contra arco elétrico e energia incidente.
Zonas de risco e controlada, e distâncias seguras de trabalho.
Documentação: prontuário, ordem de serviço e procedimentos escritos.
Habilitação, qualificação, capacitação e autorização do trabalhador.
Rotinas de trabalho, permissão de trabalho e reenergização da instalação.
Emergência: desligamento, socorro ao acidentado, ressuscitação e incêndio.',
  apostila =
'## Por que esta norma existe

A eletricidade não avisa. Não tem cheiro, não muda de cor e não faz barulho antes de causar o acidente. Por isso quase todo acidente elétrico grave começa do mesmo jeito: alguém trabalhou em um circuito que achava estar desligado. Achava. Não conferiu.

O choque mata com pouca corrente. A partir de cerca de 30 miliampères, menos do que uma lâmpada pequena consome, o músculo trava e a pessoa não consegue mais soltar o fio. Um pouco acima disso o coração entra em fibrilação e para de bombear. É questão de segundos, e a vítima costuma ser alguém experiente, que já fez aquele serviço centenas de vezes.

O arco elétrico é o outro perigo, e é o que queima. Quando uma ferramenta encosta onde não devia, ou um contato falha sob carga, o ar vira condutor e explode. A temperatura no ponto do arco passa de dez mil graus. Quem está perto leva queimadura profunda, sopro de pressão e metal derretido no rosto, e não existe reflexo humano que escape: acontece mais rápido do que se pisca o olho.

> Circuito desligado é aquele que VOCÊ testou, aterrou e bloqueou. Todo o resto é circuito ligado.

## Quando ela se aplica a você

A norma vale para quem trabalha em instalação elétrica e também para quem trabalha PERTO dela. Serralheiro que solda ao lado de um painel, pedreiro que fura parede com cabo embutido, pintor que trabalha próximo de rede aérea: todos estão na zona de risco, mesmo sem encostar em fio nenhum.

Para intervir na instalação, é preciso ser trabalhador autorizado. Isso significa três coisas juntas: ter o treinamento válido, estar apto no exame médico ocupacional e ter autorização formal da empresa por escrito para aquele tipo de serviço. Faltando uma, você não está autorizado, ainda que saiba fazer.

## Antes de começar

Serviço elétrico começa no papel, não na chave.

- Leia a ordem de serviço e o procedimento escrito da tarefa. Se o serviço não tem procedimento, ele não deveria começar.
- Faça ou confira a análise de risco: o que pode dar errado, quem está exposto, o que controla cada risco.
- Confira se há permissão de trabalho quando o procedimento exigir, com assinatura de quem libera.
- Levante todas as fontes de energia do circuito, inclusive as que ninguém lembra: gerador de emergência, nobreak, banco de capacitores, retorno por outro alimentador, painel solar.
- Confira o prontuário e os diagramas atualizados. Planta antiga já matou gente que confiou nela.
- Inspecione os equipamentos: detector de tensão, conjunto de aterramento, luva isolante dentro da validade e sem furo, vestimenta compatível com a energia incidente do local.

## Durante o trabalho

O serviço seguro é o serviço com o circuito desenergizado, e a desenergização tem uma sequência que não se inverte:

- Seccionar o circuito, abrindo o dispositivo de manobra.
- Impedir a religação, com bloqueio físico e etiqueta com seu nome, a data e o motivo.
- Constatar a ausência de tensão, medindo com detector adequado.
- Instalar o aterramento temporário, com equipotencialização das fases.
- Proteger os elementos energizados que ficaram por perto, com barreira ou isolação.
- Sinalizar e delimitar a área de trabalho.

Sobre a constatação de ausência de tensão: teste o detector em fonte conhecida ANTES, meça o circuito, e teste o detector de novo DEPOIS. Detector que quebrou no meio do caminho indica ausência de tensão em circuito vivo, e essa foi a última medição de muita gente.

O aterramento temporário é o que salva quando alguém religa por engano em outro ponto da instalação. Ele desvia a corrente para a terra em vez de mandar pelo seu corpo. Instale sempre pela ordem: primeiro a garra de terra, depois as fases. Na retirada, ao contrário: primeiro as fases, por último a terra.

Quando o serviço é em equipe, cada trabalhador coloca o SEU cadeado no dispositivo de bloqueio. O circuito só volta quando o último retirar o seu. Cadeado único do encarregado não protege ninguém: protege o cronograma.

Erros comuns que aparecem em quase todo acidente investigado:

- Usar somente a etiqueta, sem cadeado, porque o disjuntor não tinha furo. Existe dispositivo de bloqueio para praticamente todo tipo de disjuntor e válvula.
- Deixar o serviço no meio e voltar depois do almoço sem refazer a medição de tensão.
- Trabalhar com anel, relógio, corrente e crachá de metal. Metal no corpo vira condutor e vira ponto de queimadura.
- Usar ferramenta comum onde o procedimento pede ferramenta isolada.
- Aceitar mudança de escopo na hora. Serviço que muda de condição precisa de nova análise de risco, não de improviso.

A reenergização também tem ordem: retirar ferramentas e materiais, conferir que todas as pessoas saíram, remover o aterramento temporário, remover a sinalização, remover os bloqueios e só então religar. Quem dá a ordem de religar é o responsável pelo serviço, e ninguém mais.

## Equipamento

O EPI elétrico não é o mesmo EPI do resto da obra.

- Luva isolante de borracha tem classe conforme a tensão e prazo de ensaio. Antes de calçar, faça o teste de ar: enrole o punho, aperte e ouça. Furo mínimo já reprova a luva.
- Sobre a luva isolante vai a luva de cobertura, de couro, que protege a borracha do rasgo. A luva de couro sozinha não isola nada.
- A vestimenta de proteção contra arco tem classificação em calorias por centímetro quadrado, e precisa ser compatível com a energia incidente calculada para aquele painel. Roupa de brim comum pega fogo e continua queimando na pele.
- Por baixo da vestimenta, nada de tecido sintético. Sintético derrete e gruda na pele.
- Capacete de classe adequada, protetor facial próprio para arco elétrico e calçado sem parte metálica exposta.
- Equipamento com dano, com ensaio vencido ou que sofreu solicitação anormal sai de uso na hora. Marque, retire e informe. Equipamento reprovado que volta para o armário volta para a mão de alguém.

## Emergência

Nos primeiros segundos, a regra é uma só: **não toque na vítima antes de cortar a energia.** Socorrista que vira segunda vítima é o desfecho mais comum de acidente elétrico com mais de uma pessoa ferida.

- Desligue a chave geral ou o dispositivo que alimenta o ponto.
- Se não for possível desligar, afaste a vítima com material isolante e seco, sem encostar nela.
- Chame o socorro e avise que é acidente elétrico. A informação muda a conduta da equipe médica.
- Vítima sem respiração e sem sinais de circulação: inicie compressões torácicas imediatamente e use o desfibrilador assim que chegar. Choque costuma parar o coração em ritmo que o desfibrilador reverte.
- Queimadura elétrica é mais grave do que aparenta. A pele mostra dois pontos pequenos, mas o percurso da corrente queimou músculo por dentro. Toda vítima de choque vai para atendimento médico, mesmo andando e conversando.
- Incêndio em instalação elétrica se combate com extintor apropriado, nunca com água em circuito energizado.

## O que a empresa deve, o que você deve

A empresa deve manter o prontuário das instalações, os diagramas atualizados, os procedimentos escritos, a análise de risco, os equipamentos de proteção adequados e ensaiados, o treinamento válido e a autorização formal de cada trabalhador. Deve também garantir que o serviço tenha condições de ser feito desenergizado.

Você deve usar o que foi fornecido, seguir o procedimento, comunicar condição insegura e interromper a tarefa quando surgir risco grave e iminente. **Interromper o serviço diante de risco grave é direito seu e obrigação sua**, e não pode gerar punição.

## Para lembrar

- Só é desligado o circuito que você mesmo testou, aterrou e bloqueou.
- Teste o detector antes e depois de medir a ausência de tensão.
- Aterramento temporário entra pela terra e sai pelas fases.
- Cada pessoa da equipe coloca o próprio cadeado no bloqueio.
- Luva isolante passa pelo teste de ar e vem coberta pela luva de couro.
- Vestimenta de arco é escolhida pela energia incidente, não pelo tamanho.
- Na reenergização, pessoas e ferramentas saem antes de a chave voltar.
- Em acidente, corte a energia antes de tocar na vítima.'
where codigo = 'NR-10';


-- =====================================================================
--  NR-33, Segurança e saúde nos trabalhos em espaços confinados
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Definição de espaço confinado e identificação dos espaços da instalação.
Reconhecimento dos riscos atmosféricos, físicos, mecânicos e biológicos.
Deficiência e enriquecimento de oxigênio: efeitos e limites aceitáveis.
Gases inflamáveis, tóxicos e o limite inferior de explosividade.
Funções e responsabilidades do trabalhador autorizado, do vigia e do supervisor.
Permissão de entrada e trabalho: emissão, validade, suspensão e encerramento.
Avaliação atmosférica inicial e monitoramento contínuo durante a entrada.
Bloqueio, etiquetagem e isolamento de energias e de linhas de processo.
Ventilação, purga e limpeza prévia do espaço confinado.
Equipamentos de proteção respiratória e de proteção individual aplicáveis.
Comunicação, iluminação e equipamentos elétricos apropriados ao espaço.
Procedimentos, equipamentos e prática de resgate e salvamento.
Primeiros socorros, ressuscitação cardiopulmonar e remoção da vítima.
Direito de recusa e interrupção da entrada diante de risco grave.',
  apostila =
'## Por que esta norma existe

Espaço confinado é o acidente que quase sempre mata mais de uma pessoa. O padrão se repete no mundo inteiro: um trabalhador desce em um tanque, um silo, uma caixa de esgoto ou um poço, cai desacordado em poucos segundos, e o colega desce para socorrer sem equipamento nenhum. Morrem os dois. Às vezes três. Mais da metade dos mortos em espaço confinado são socorristas improvisados.

A razão é que o ar de dentro engana. Ele parece normal. Não há fumaça, não há cheiro forte, não há calor. Mas o oxigênio pode ter sido consumido pela ferrugem da parede do tanque, deslocado por um gás mais pesado, ou substituído pelo nitrogênio que alguém usou para purgar a linha ontem. Com oxigênio abaixo de mais ou menos 10 por cento, a pessoa perde a consciência em uma ou duas respirações. Sem tempo de gritar, sem tempo de subir.

> Ninguém entra em espaço confinado para socorrer alguém. Resgate é feito de fora, com equipamento, por quem treinou.

## Quando ela se aplica a você

Espaço confinado tem três características ao mesmo tempo: não foi projetado para ocupação humana contínua, tem meios limitados de entrada e saída, e pode ter ventilação insuficiente para manter o ar respirável.

Vale para o óbvio, como tanque, silo, caldeira, tubulação, vala profunda, poço, caixa de passagem, galeria e reservatório. Vale também para o que ninguém chama de confinado no dia a dia: fosso de elevador, interior de máquina grande, container fechado, porão, câmara de secagem. Se você precisa se contorcer para entrar e o ar de dentro não se renova sozinho, trate como confinado até alguém provar o contrário.

São três funções, e cada uma tem tarefa própria. O **trabalhador autorizado** é quem entra. O **vigia** fica do lado de fora, o tempo inteiro, sem outra tarefa. O **supervisor de entrada** é quem avalia, emite e encerra a permissão. Ninguém acumula função: vigia que ajuda a puxar mangueira, ou que sai para buscar ferramenta, deixou de ser vigia.

## Antes de começar

A entrada só acontece com Permissão de Entrada e Trabalho emitida, e a permissão não é papel de arquivo: é a lista do que foi controlado.

- Identifique o espaço e o serviço, e pergunte se dá para fazer o serviço de fora. Entrada evitada é o melhor controle que existe.
- Isole e bloqueie todas as energias e linhas que chegam ao espaço: elétrica, vapor, produto, ar comprimido, agitador. Bloqueio físico com cadeado, e não válvula fechada com aviso.
- Esvazie, limpe e purgue o espaço conforme o procedimento.
- Ventile, de preferência ventilação mecânica forçada, e mantenha ligada durante todo o trabalho.
- Meça a atmosfera ANTES de qualquer pessoa colocar a cabeça para dentro, com o detector calibrado e com prova de funcionamento feita no dia.
- Meça em camadas: perto do topo, no meio e no fundo. Gás pesado se acumula embaixo, gás leve sobe. Uma medição só, na boca do espaço, não diz nada sobre o fundo.
- Monte o sistema de resgate antes da entrada: tripé, talha, cabo, cinto de segurança tipo paraquedista e o conjunto respiratório autônomo à mão.

A ordem da medição é sempre a mesma: **oxigênio, depois inflamáveis, depois tóxicos.** O sensor de gás inflamável precisa de oxigênio para funcionar, então medir fora de ordem dá leitura falsa. As faixas aceitáveis são oxigênio entre 20,9 por cento como referência, com limites definidos no procedimento, gases inflamáveis abaixo de 10 por cento do limite inferior de explosividade, e contaminantes tóxicos abaixo do limite de tolerância.

## Durante o trabalho

A permissão vale para aquele turno, aquele serviço e aquelas condições. Mudou o serviço, virou o turno, saiu a equipe, houve interrupção longa ou apareceu situação diferente da prevista: a permissão é encerrada e o trabalho recomeça do zero.

- O monitoramento é contínuo, e não uma medição na entrada. Alarme tocou, todo mundo sai. Primeiro sai, depois se investiga.
- Cada pessoa que entra é registrada e cada saída também. O vigia sabe, a qualquer momento, quantas pessoas estão dentro e há quanto tempo.
- A comunicação entre vigia e quem entrou não pode falhar: rádio, cabo, sinal combinado. Silêncio prolongado é motivo de acionar o resgate.
- Ferramenta e iluminação dentro do espaço precisam ser apropriadas, com tensão de segurança e, onde houver risco de atmosfera inflamável, com proteção contra ignição.
- Nada de aumentar o oxigênio para melhorar o ar. Atmosfera enriquecida faz roupa e cabelo pegarem fogo com uma faísca mínima.

Erros comuns: entrar rápido só para dar uma olhada, confiar na medição de ontem, deixar o vigia acumular outra função, usar máscara de poeira achando que protege contra gás, e prender o cabo de resgate em qualquer estrutura em vez do ponto previsto.

## Equipamento

Máscara com filtro NÃO serve em espaço confinado com deficiência de oxigênio. Filtro purifica o ar que existe; se não há oxigênio, não há o que purificar. O que protege é equipamento de respiração autônoma ou de linha de ar comprimido com cilindro de escape.

- Detector de gases: calibrado, com certificado dentro do prazo e prova de resposta feita antes do uso.
- Cinto de segurança tipo paraquedista com ponto dorsal, ligado ao cabo do sistema de içamento.
- Tripé com talha ou guincho, para retirar a vítima de fora.
- Conjunto respiratório autônomo pronto, montado, com pressão conferida.
- Iluminação apropriada e ferramentas compatíveis com a atmosfera.
- Todo equipamento é inspecionado antes do uso e registrado. Costura desfiada, mosquetão que não trava, cabo com fio rompido: descarte, sem discussão.

## Emergência

Os primeiros minutos decidem tudo, e a primeira decisão é não descer.

- O vigia aciona o alarme e a equipe de resgate, e NÃO entra.
- Se a vítima está ligada ao sistema de içamento, o resgate começa de fora, puxando pelo tripé.
- Ninguém entra sem equipamento de respiração autônoma e sem ser da equipe de resgate.
- Ventilação forçada segue ligada durante o resgate.
- Fora do espaço, avalie respiração e circulação. Sem respiração, inicie ressuscitação cardiopulmonar. Em intoxicação, informe ao socorro qual produto estava no espaço.
- O plano de resgate é ensaiado, e o ensaio é o que revela que o tripé não passa pela boca de visita ou que o cabo é curto demais. Descobrir isso com vítima dentro é tarde.

## O que a empresa deve, o que você deve

A empresa deve identificar e sinalizar todos os espaços confinados da instalação, impedir a entrada não autorizada, manter procedimentos escritos, fornecer os equipamentos de medição, proteção e resgate, manter equipe de resgate disponível e capacitar trabalhador, vigia e supervisor com reciclagem periódica.

Você deve entrar somente com permissão válida, usar o que foi fornecido, comunicar qualquer condição diferente do previsto e **recusar a entrada quando faltar controle ou quando o risco for grave e iminente.** Essa recusa é direito garantido e não pode custar o seu emprego.

## Para lembrar

- Espaço confinado engana: o ar parece normal e não é.
- Nunca entre para socorrer. A maior parte dos mortos é socorrista.
- Meça na ordem: oxigênio, inflamáveis, tóxicos, e em três alturas.
- Bloqueie e etiquete todas as energias e linhas antes da entrada.
- O vigia não faz mais nada além de vigiar, e não entra nunca.
- Permissão vale para aquele turno e aquele serviço, e não para a semana.
- Filtro não protege onde falta oxigênio: só ar autônomo ou linha de ar.
- Alarme do detector significa sair primeiro e investigar depois.'
where codigo = 'NR-33';


-- =====================================================================
--  NR-35-REC, Trabalho em altura, RECICLAGEM
--
--  O código na base é NR-35-REC, e não NR-35: o 07-nr35-somente-reciclagem
--  renomeou o curso porque o inicial exige prática presencial. Quem faz
--  este curso já trabalha em altura, então a apostila é revisão
--  aprofundada, e não introdução.
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Revisão das definições, do campo de aplicação e das responsabilidades.
Análise de risco da tarefa e permissão de trabalho: revisão prática.
Seleção, resistência e verificação dos pontos de ancoragem.
Fator de queda, zona livre de queda e efeito pêndulo.
Sistemas de restrição, posicionamento, retenção de queda e trava-quedas.
Talabarte com absorvedor de energia: quando é obrigatório e como fica após uso.
Inspeção periódica, registro, vida útil e critérios de descarte dos equipamentos.
Trabalho em andaimes, plataformas elevatórias, escadas e cestos aéreos.
Condições impeditivas e interrupção da atividade em altura.
Síndrome do arnês e a urgência do resgate da vítima suspensa.
Plano de resgate: elaboração, recursos, ensaio e acionamento.
Primeiros socorros aplicados à queda e à suspensão inerte.
Análise de acidentes típicos e das falhas mais comuns em equipes experientes.',
  apostila =
'## Por que esta norma existe

Você já fez o curso inicial, já subiu centenas de vezes e provavelmente nunca caiu. É exatamente esse o motivo desta reciclagem. Queda de altura é o acidente que mais mata na construção brasileira, e a vítima típica não é o novato assustado: é o profissional experiente que naquele dia soltou o talabarte por trinta segundos para passar de um lado para o outro, porque já tinha feito aquilo mil vezes.

Quem cai de dois metros bate no chão a cerca de 22 quilômetros por hora. De cinco metros, a 36. Não existe reflexo que corrija a queda depois de iniciada, e não existe altura confortável: metade das mortes por queda acontece abaixo de quatro metros.

A reciclagem não repete o básico. Ela existe para corrigir o que a prática deforma: a ancoragem escolhida pelo que estava perto, o talabarte que continua em uso depois de ter absorvido uma queda, o cinto que ninguém inspeciona porque parece novo, e o plano de resgate que nunca foi ensaiado.

> Duas horas suspenso no cinto pode matar mesmo quem não se machucou na queda. O resgate tem prazo, e o prazo é curto.

## Quando ela se aplica a você

Trabalho em altura é toda atividade executada acima de dois metros do nível inferior onde haja risco de queda. Vale para andaime, telhado, plataforma, escada, torre, silo, poço e também para trabalho perto de abertura no piso.

A sua autorização depende de três coisas ao mesmo tempo: treinamento válido, aptidão no exame médico ocupacional para trabalho em altura e autorização formal da empresa. Reciclagem vencida derruba a autorização inteira, ainda que você suba melhor do que qualquer um da equipe.

## Antes de começar

A análise de risco não é o mesmo papel de sempre. Ela é da tarefa, do local e do dia.

- Confira se a análise contempla o local exato: laje molhada, telha frágil, rede elétrica próxima, movimentação de carga acima da cabeça, andaime de terceiros.
- Emita ou confira a permissão de trabalho quando houver exigência. Ela vale para aquele turno e aquelas condições.
- Avalie as condições impeditivas: vento forte, chuva, tempestade com raios, iluminação insuficiente, piso escorregadio, trabalhador indisposto ou sob efeito de medicamento que dá sonolência.
- Confirme que existe plano de resgate ANTES da subida, com equipe, equipamento e tempo de resposta definidos. Sem plano de resgate, não há trabalho em altura.
- Inspecione o seu equipamento com a lista de verificação e registre. Inspeção sem registro não existe para a fiscalização, e não serve para acompanhar a vida útil.

## Durante o trabalho

O ponto onde a experiência mais falha é a **ancoragem**. Ela precisa ser escolhida antes da subida, não improvisada em cima.

- Ancore preferencialmente ACIMA do nível da cintura. Ancoragem alta reduz o fator de queda e a distância de queda livre.
- Nunca ancore em tubulação de processo, eletroduto, guarda-corpo de andaime, corrimão, escada de mão, telha ou estrutura que você não conhece.
- Ponto de ancoragem tem de suportar a carga prevista e ser verificado por profissional habilitado quando for estrutura permanente.
- Em linha de vida horizontal, respeite o número máximo de usuários simultâneos previsto no projeto.

Sobre o **fator de queda**: ele é a relação entre a distância que você cai livre e o comprimento do talabarte. Ancorado acima da cabeça, o fator tende a zero e a força no corpo é pequena. Ancorado nos pés, com talabarte esticado, o fator chega a 2 e a força no corpo passa do que o organismo suporta, mesmo com o equipamento resistindo. É a diferença entre um susto e uma lesão de coluna.

A **zona livre de queda** é o espaço que precisa existir abaixo de você para o sistema frear antes do chão. Some o comprimento do talabarte, o alongamento do absorvedor de energia, a altura do seu corpo abaixo do ponto de conexão e uma folga de segurança. Se a conta não fecha, o absorvedor abre e você bate assim mesmo. Em altura pequena, talabarte longo é mais perigoso do que talabarte curto.

O **efeito pêndulo** aparece quando você trabalha deslocado lateralmente do ponto de ancoragem. Ao cair, você balança e bate na estrutura ao lado. Mantenha o ponto de ancoragem o mais alinhado possível com a posição de trabalho, ou use linha de vida.

Erros que aparecem justamente em quem tem prática:

- Deslocar-se com os dois ganchos soltos. Use talabarte duplo em Y e mantenha SEMPRE um gancho conectado. A conexão é alternada, nunca simultânea a zero.
- Prender o gancho no próprio talabarte para encurtá-lo. Isso reduz a resistência e anula o absorvedor.
- Usar o ponto peitoral ou lateral do cinto para reter queda. Retenção de queda é no ponto DORSAL. Os pontos laterais são de posicionamento, e o frontal só conforme a especificação do fabricante.
- Confundir restrição com retenção: restrição impede chegar à borda, retenção segura depois da queda. Quem monta um e acha que tem o outro descobre no ar.
- Subir em plataforma elevatória sem se ancorar no ponto do cesto, ou ancorar na estrutura externa, o que arranca a pessoa se a máquina se mover.

## Equipamento

- Cinto de segurança tipo paraquedista, com certificado de aprovação válido, ajustado ao corpo. Cinto folgado deixa o corpo escorregar no impacto e concentra a força onde não deve.
- Talabarte com absorvedor de energia sempre que houver possibilidade de queda com fator maior que zero. **Absorvedor que abriu, mesmo parcialmente, é descarte imediato.** Ele trabalhou uma vez e não trabalha duas.
- Trava-quedas retrátil ou deslizante em linha vertical, conectado ao ponto dorsal, mantido acima do usuário.
- Mosquetões e conectores com trava dupla. Conector que fecha sozinho e não trava é descarte.
- Inspeção antes de cada uso: costura desfiada, fita com corte, queimadura, mancha de produto químico, fivela deformada, cabo de aço com fio rompido, etiqueta ilegível.
- Critérios de descarte: equipamento que sofreu queda, equipamento com validade vencida, etiqueta ilegível, dano estrutural, contato com produto químico agressivo. Retire de circulação, inutilize e registre. Equipamento reprovado devolvido ao armário volta para a mão de alguém.

## Emergência

Quem ficou suspenso no cinto tem pressa, mesmo sem ferimento aparente. Com as pernas paradas, o sangue se acumula nos membros inferiores e deixa de voltar ao coração. É a síndrome do arnês, e ela pode levar à perda de consciência em poucos minutos e à morte em cerca de quinze a trinta minutos.

- Acione o plano de resgate imediatamente e marque a hora.
- Mantenha contato com a vítima e oriente que ela movimente as pernas ou apoie os pés em um degrau improvisado, se estiver consciente.
- Resgate de baixo para cima, com equipamento previsto. Ninguém sobe improvisando.
- Depois de retirada, mantenha a vítima em observação e leve a atendimento médico mesmo que ela diga estar bem. A volta brusca do sangue acumulado pode causar parada.
- Em caso de queda com impacto, suspeite de lesão de coluna: não movimente sem imobilização, salvo risco maior no local.
- Registre o acidente e retire de uso todo equipamento envolvido.

## O que a empresa deve, o que você deve

A empresa deve priorizar medidas que eliminem o trabalho em altura, depois as que evitem a queda, e só então as que retenham a queda. Deve fornecer equipamento certificado, garantir análise de risco, manter plano de resgate com recursos reais, assegurar exame médico e manter a capacitação em dia.

Você deve inspecionar e usar corretamente o equipamento, seguir o procedimento, comunicar condição insegura e **interromper a atividade diante de risco grave e iminente**, avisando o superior. Nenhuma pressa de cronograma justifica trinta segundos desconectado.

## Para lembrar

- Ancore acima da cintura: fator de queda menor, força no corpo menor.
- Talabarte duplo existe para você nunca ficar sem conexão ao se deslocar.
- Retenção de queda é no ponto dorsal. Lateral é posicionamento.
- Zona livre de queda insuficiente significa bater no chão com o equipamento funcionando.
- Absorvedor aberto, cinto que sofreu queda: descarte imediato, sem exceção.
- Sem plano de resgate ensaiado, não existe trabalho em altura autorizado.
- Suspensão inerte mata em minutos. Marque a hora e acione o resgate.
- Condição impeditiva, como vento e tempestade, interrompe o serviço.'
where codigo = 'NR-35-REC';


-- =====================================================================
--  NR-12, Segurança no trabalho em máquinas e equipamentos
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Princípios gerais de segurança em máquinas e equipamentos.
Riscos mecânicos: prensagem, corte, esmagamento, arraste, projeção e enroscamento.
Zonas de perigo, distâncias de segurança e alcance dos membros.
Proteções fixas, móveis e distâncias de proteção adequadas.
Dispositivos de intertravamento com e sem bloqueio.
Parada de emergência, rearme manual e partida acidental.
Comandos bimanuais, cortinas de luz e sensores de presença.
Bloqueio e etiquetagem de energias antes da manutenção e da limpeza.
Energias acumuladas: elétrica, hidráulica, pneumática, térmica, química e gravitacional.
Inspeção diária, manutenção preventiva e registro das intervenções.
Procedimentos de trabalho e segurança na operação, no ajuste e na limpeza.
Manual de instruções, inventário de máquinas e apreciação de riscos.
Sinalização, cores, advertências e capacitação do operador.
Emergência e primeiros socorros em amputação e esmagamento.',
  apostila =
'## Por que esta norma existe

A máquina não tem intenção nenhuma. Ela apenas repete o movimento que foi mandada fazer, com força suficiente para arrancar um dedo, um braço ou puxar uma pessoa inteira. E ela repete esse movimento no exato instante em que a mão de alguém está dentro dela, se nada impedir.

Os acidentes com máquina no Brasil têm um padrão que se repete. O operador percebe que a peça travou. A produção está atrasada. Ele enfia a mão para desentupir com a máquina ligada, porque tirar a proteção e desligar tudo demora, e porque já fez assim antes. A máquina completa o ciclo. O que sai de lá não volta.

O outro padrão é a manutenção. O mecânico desliga o botão do painel, entra na máquina, e o cilindro pneumático que ainda tinha pressão desce sozinho. Desligar não é o mesmo que descarregar.

> Máquina que se move sem alguém apertar nada não é máquina assombrada: é energia acumulada que ninguém aliviou.

## Quando ela se aplica a você

A norma vale para qualquer máquina ou equipamento, novo ou usado, em qualquer atividade. Vale para a prensa, a injetora e o torno, e vale igualmente para a serra circular do canteiro, a betoneira, a masseira da padaria, a esteira do armazém e a máquina de embalar.

Vale para quem opera, para quem faz manutenção, para quem limpa e para quem faz o ajuste de ferramenta. E aqui está o ponto que mais reprova em prova: a maior parte dos acidentes graves acontece em limpeza, desentupimento e ajuste, e não durante a produção normal.

Você só pode operar máquina para a qual foi capacitado, com autorização e depois de conhecer o procedimento daquela máquina específica. Saber operar torno não autoriza a operar a prensa ao lado.

## Antes de começar

Antes de dar partida, o operador confere a máquina, e essa conferência é diária.

- Todas as proteções estão no lugar, íntegras e fixadas.
- O botão de emergência está acessível, visível, sem obstrução, e alcançável da posição de trabalho.
- O intertravamento funciona: abriu a porta, a máquina para. Teste conforme o procedimento, nunca por improviso.
- Não há vazamento de óleo, ar ou produto, nem fiação exposta.
- O piso ao redor está limpo, seco e desobstruído.
- A ferramenta correta está montada e o ajuste confere com a ordem de produção.
- Há manual, procedimento e ficha da máquina disponíveis.

Qualquer item reprovado: a máquina não parte. Comunique, registre e aguarde a manutenção. Máquina liberada de boca não é máquina liberada.

## Durante o trabalho

O que protege é a barreira física, não a atenção. Atenção falha em toda jornada, todo dia, e é por isso que a norma trata a proteção como obrigação e não como opção.

- **Proteção fixa** só sai com ferramenta. É usada onde não há necessidade de acesso frequente.
- **Proteção móvel** é a porta ou tampa que se abre, e ela precisa ser intertravada: abriu, a máquina para. Nas máquinas em que o movimento continua por inércia, o intertravamento é com bloqueio, e a porta só destrava quando o movimento cessa.
- **Comando bimanual** exige as duas mãos ao mesmo tempo, fora da zona de perigo, com a máquina parando se uma mão soltar.
- **Cortina de luz e sensores** param o movimento quando algo entra na zona protegida, e precisam estar posicionados na distância de segurança calculada. Cortina montada perto demais para com a mão já dentro.
- **Parada de emergência** é para a emergência. Ela não é meio de parar a máquina em operação normal, e depois dela o retorno é por rearme manual e deliberado, nunca automático.

Nunca, em hipótese alguma:

- Anular, calçar, amarrar ou colar sensor de intertravamento para a máquina rodar de porta aberta. É a violação mais comum e a que mais amputa.
- Retirar proteção e prometer recolocar depois.
- Limpar, desentupir, lubrificar ou ajustar com a máquina energizada.
- Usar luva ou roupa larga, corrente, anel e cabelo solto perto de partes rotativas. Rotativo não corta: agarra e puxa.
- Deixar dois operadores trabalhando na mesma máquina sem que um saiba o que o outro comanda.

Para manutenção, limpeza e ajuste, a regra é bloqueio e etiquetagem. Desligue a chave geral da máquina, bloqueie com cadeado próprio, coloque a etiqueta com seu nome e a data, e depois **alivie as energias acumuladas**: descarregue o ar comprimido, alivie a pressão hidráulica, calce ou apoie o que pode descer por gravidade, espere esfriar o que está quente, drene o produto químico e descarregue capacitores. Só então teste o comando de partida para confirmar que a máquina não responde. Em equipe, cada um coloca o próprio cadeado e o último a sair é quem libera.

## Equipamento

A proteção da máquina é o equipamento principal, e ela é da empresa. O EPI vem depois dela, nunca no lugar dela.

- Óculos de segurança contra projeção de cavaco e partícula.
- Protetor auditivo onde o ruído exigir, conforme a avaliação.
- Calçado de segurança, e vestimenta ajustada ao corpo.
- Luva conforme o risco, e atenção: em máquina com parte rotativa exposta, luva pode ser proibida justamente porque agarra.
- Dispositivo de alimentação e retirada de peça, como pinça, empurrador e alimentador automático, que mantém a mão longe da zona de prensagem.

Dispositivo de segurança com defeito é motivo de parada da máquina, e não de continuar com cuidado redobrado. Registre a ocorrência: o histórico é o que prova quando o defeito começou.

## Emergência

Acidente com máquina costuma envolver membro preso, e os primeiros minutos definem se a pessoa perde a função ou não.

- Acione a parada de emergência e desligue a máquina.
- **Não tente puxar, girar ou desmontar por conta própria com a pessoa presa.** Movimento errado agrava o esmagamento. Chame a manutenção e o socorro.
- Controle a hemorragia com compressão direta, usando pano limpo.
- Em amputação, procure a parte amputada, envolva em pano limpo e umedecido, coloque em saco plástico fechado e este saco dentro de outro com gelo e água. Nunca coloque o membro em contato direto com o gelo.
- Mantenha a vítima aquecida, deitada, e não dê nada para beber.
- Isole a máquina e não a religue. Ela fica bloqueada até a investigação, porque a cena conta o que aconteceu.
- Comunique o acidente conforme o procedimento da empresa.

## O que a empresa deve, o que você deve

A empresa deve manter o inventário de máquinas, a apreciação de riscos, o manual em português, as proteções e dispositivos instalados e funcionando, a manutenção preventiva com registro, os procedimentos de trabalho e segurança escritos e a capacitação dos operadores, com reciclagem quando a máquina ou o processo mudar.

Você deve conferir a máquina antes de operar, respeitar as proteções, não improvisar, comunicar defeito e **interromper a tarefa diante de risco grave e iminente**. Máquina com proteção anulada é risco grave e iminente, e recusar operá-la é direito seu.

## Para lembrar

- Máquina não distrai: quem distrai é gente. Por isso a barreira é física.
- Proteção anulada é a causa número um de amputação.
- Limpeza, desentupimento e ajuste matam mais do que a produção normal.
- Desligar não basta: alivie ar, pressão, calor e gravidade.
- Cada pessoa da equipe põe o próprio cadeado no bloqueio.
- Parada de emergência não é botão de desligar do dia a dia.
- Rotativo agarra: nada de luva larga, anel, corrente ou cabelo solto.
- Com alguém preso na máquina, chame socorro e não improvise resgate.'
where codigo = 'NR-12';


-- =====================================================================
--  NR-18, Segurança e saúde no trabalho na indústria da construção
-- =====================================================================
update public.trein_curso set
  conteudo_programatico =
'Gerenciamento de riscos na construção e organização do canteiro de obras.
Áreas de vivência: sanitários, vestiário, refeitório, água potável e alojamento.
Proteção contra quedas: periferia, aberturas no piso, poços e vãos.
Andaimes: montagem, travamento, piso completo, guarda-corpo e rodapé.
Escadas, rampas e passarelas de circulação na obra.
Instalações elétricas provisórias, quadros, extensões e aterramento.
Máquinas e ferramentas do canteiro: serra circular, betoneira e policorte.
Movimentação e içamento de cargas, amarração, sinalização e área isolada.
Escavações e fundações: taludes, escoramento e acesso à vala.
Armações de aço, formas, concretagem e desforma.
Demolições, trabalhos a quente e controle de fontes de ignição.
Sinalização de segurança, circulação de veículos e trânsito de pedestres.
Ordem de serviço, uso de EPI e treinamentos admissional e periódico.
Emergência: rota de fuga, brigada, primeiros socorros e comunicação do acidente.',
  apostila =
'## Por que esta norma existe

A construção civil é o setor que mais mata trabalhador no Brasil, e três causas respondem pela maior parte: **queda de altura, choque elétrico e soterramento**. Não são acidentes exóticos. São a periferia de laje sem guarda-corpo, o cabo descascado ligado na gambiarra, e a vala de dois metros aberta em terreno arenoso sem escoramento porque o serviço era rápido.

O canteiro tem uma característica que o torna perigoso mesmo para quem sabe o que faz: ele muda todo dia. A abertura que ontem estava fechada hoje está aberta. A escada que estava ali foi levada. O andaime foi mexido pela equipe da noite. Segurança em obra não é decorar o local, é conferir o local.

E o canteiro é coletivo. O pedreiro que trabalha embaixo depende de o carpinteiro de cima não deixar cair uma peça. O acidente na obra quase nunca é de uma pessoa só.

> Na obra, você não é responsável apenas pelo seu risco. O que você deixa solto, mal amarrado ou mal fechado cai na cabeça de outra pessoa.

## Quando ela se aplica a você

Vale para o canteiro inteiro e para toda a frente de serviço, incluindo reforma, manutenção predial e demolição. Vale para o empregado direto e para quem é da empresa contratada: a NR-18 não distingue crachá quando o assunto é risco.

Ninguém começa sem integração. A integração é o treinamento admissional em que você conhece os riscos daquela obra, as regras da casa, as rotas de fuga e o que fazer em emergência. É diferente do treinamento por atividade, que é específico da tarefa, e da ordem de serviço, que é o papel em que a empresa registra por escrito o que você pode e não pode fazer.

## Antes de começar

Antes da tarefa, quatro conferências valem mais do que qualquer discurso.

- **A tarefa:** existe ordem de serviço, procedimento ou permissão de trabalho para o que vou fazer? Fui treinado nisso?
- **O local:** o piso está firme e desobstruído? Tem abertura no piso perto? A periferia tem proteção? Há linha elétrica aérea acima? Passa veículo por aqui?
- **O que está acima e abaixo:** tem gente trabalhando embaixo de mim? Tem carga suspensa passando? A área precisa ser isolada?
- **O equipamento:** o EPI está íntegro e no tamanho? A ferramenta está em condição? O andaime foi liberado?

Se o serviço envolve altura, espaço confinado, eletricidade, escavação profunda ou trabalho a quente, ele entra também na norma específica, e o canteiro precisa cumprir as duas. A NR-18 não substitui a NR-35 nem a NR-10.

## Durante o trabalho

**Proteção contra quedas.** Toda periferia de laje, poço de elevador, escada, abertura no piso e vão precisa de proteção. Guarda-corpo com travessão superior a cerca de 1,20 metro, travessão intermediário a cerca de 0,70 metro e rodapé de aproximadamente 0,20 metro, resistente e fixado. Abertura no piso é fechada com tampa fixada e sinalizada, não com pedaço de compensado solto. **Proteção retirada para passar material é reposta na hora, pela mesma pessoa que retirou.**

**Andaimes.** Piso completo, sem tábua faltando e sem vão para o pé passar. Travado à estrutura, apoiado em base firme e nivelada, com guarda-corpo e rodapé. Acesso por escada incorporada, e não escalando a estrutura. Montagem e desmontagem são feitas por trabalhador capacitado, com supervisão, e o andaime é liberado antes do uso. Andaime não é depósito: material em excesso sobre a plataforma derruba o conjunto.

**Escadas.** Escada de mão é para acesso e serviço rápido, com um metro sobrando acima do ponto de apoio, amarrada no topo e apoiada em piso firme. Nunca em cima de caixote, laje molhada ou improviso. Escada com degrau faltando ou trincado sai de circulação.

**Elétrica provisória.** Quadro fechado, com disjuntor e dispositivo diferencial residual, aterrado. Extensão com cabo íntegro e plugue de verdade, nunca fio enfiado direto na tomada. Nada de emenda com fita improvisada, e nada de cabo passando por poça de água ou por onde a carriola atropela. Só eletricista autorizado mexe no quadro.

**Escavações.** Vala acima de 1,25 metro exige escoramento ou talude conforme o projeto, com escada de acesso a cada 25 metros de extensão e a menos de 15 metros de qualquer trabalhador. O material retirado fica afastado da borda. Soterramento acontece em segundos e um metro cúbico de terra pesa mais de uma tonelada e meia: ninguém se solta sozinho.

**Içamento de carga.** Área isolada e sinalizada embaixo, ninguém circula ou permanece sob a carga, amarração conferida por quem foi capacitado, e sinalização feita por uma pessoa só. Cabo, cinta e gancho são inspecionados antes do turno, e gancho sem trava é reprovado.

**Máquinas da obra.** Serra circular com coifa protetora, cutelo divisor, coletor de serragem e mesa estável, operada por trabalhador capacitado. Betoneira com proteção de correias e coroa, e limpeza somente com a máquina desligada e bloqueada. Policorte com proteção do disco e óculos obrigatórios.

**Ordem e limpeza.** Entulho retirado, prego virado ou removido, material empilhado de forma estável e longe da periferia, circulação livre. A maior parte das quedas de mesmo nível é evidência de canteiro desorganizado, e o tombo de mesmo nível afasta gente do trabalho por semanas.

## Equipamento

- Capacete com jugular em todo o canteiro, sem exceção e sem visita descoberta.
- Óculos de segurança para corte, esmerilhamento, perfuração e qualquer serviço com projeção.
- Calçado de segurança fechado, protetor auditivo conforme a avaliação, luva conforme o risco da tarefa.
- Protetor respiratório adequado para poeira de corte de concreto, argamassa seca, sílica, tinta e produto químico. Poeira de sílica causa doença que aparece anos depois, e não dói na hora.
- Cinto tipo paraquedista com talabarte duplo onde houver risco de queda, sempre ancorado em ponto adequado.
- Inspecione o EPI todo dia e troque o que estiver danificado. Capacete que sofreu impacto forte é descartado, mesmo sem trinca visível.

## Emergência

- Pare o serviço, isole a área e não deixe o acidente virar dois acidentes.
- Acione a brigada e o socorro, e mande alguém receber a ambulância no portão. Obra grande sem quem oriente a entrada perde minutos preciosos.
- Em queda com impacto, não movimente a vítima sem imobilização, salvo risco maior no local.
- Em choque, corte a energia antes de tocar na pessoa.
- Em soterramento, não escave com máquina sobre a vítima e não entre na vala sem escoramento: quem entra vira a segunda vítima.
- Hemorragia se controla com compressão direta, com pano limpo.
- Comunique a ocorrência à liderança, e registre. Acidente sem registro se repete no mês seguinte, no mesmo lugar.

## O que a empresa deve, o que você deve

A empresa deve manter o gerenciamento de riscos da obra, o programa e as medidas de proteção coletiva, as áreas de vivência com sanitário, vestiário, refeitório e água potável, as instalações elétricas em condições, os treinamentos admissional e periódico, os EPI adequados e a supervisão do serviço. Proteção coletiva vem antes da individual, sempre.

Você deve usar o EPI, respeitar a sinalização e o isolamento, não retirar proteção coletiva sem autorização e sem repor, comunicar condição insegura e **interromper a atividade diante de risco grave e iminente**. Cronograma atrasado se recupera. Coluna quebrada não.

## Para lembrar

- Queda, choque e soterramento são o que mais mata na construção.
- Guarda-corpo tem travessão superior, intermediário e rodapé, e é resistente.
- Proteção retirada é reposta na hora, por quem retirou.
- Andaime precisa de piso completo, travamento, guarda-corpo e acesso próprio.
- Vala acima de 1,25 metro pede escoramento ou talude, e escada de saída perto.
- Ninguém passa nem permanece embaixo de carga suspensa.
- Quadro provisório é fechado, aterrado e com disjuntor diferencial residual.
- Capacete com jugular vale para o canteiro inteiro, o tempo inteiro.'
where codigo = 'NR-18';


-- =====================================================================
--  Confira o que entrou
--
--  `itens_conteudo` conta as linhas do verso do certificado, e
--  `palavras_apostila` conta as palavras do material de estudo. Curso que
--  aparecer com zero, ou com número muito fora do esperado, não gravou.
-- =====================================================================
select c.codigo,
       c.titulo,
       coalesce(array_length(string_to_array(btrim(c.conteudo_programatico),
                                             chr(10)), 1), 0) as itens_conteudo,
       coalesce(array_length(regexp_split_to_array(btrim(c.apostila),
                                                   E'\\s+'), 1), 0) as palavras_apostila
  from public.trein_curso c
 where c.codigo in ('NR-10', 'NR-33', 'NR-35-REC', 'NR-12', 'NR-18')
 order by c.codigo;
