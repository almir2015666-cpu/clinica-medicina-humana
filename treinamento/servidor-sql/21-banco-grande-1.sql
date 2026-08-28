-- =====================================================================
--  Banco grande — parte 1
--  NR-10, NR-33, NR-35-REC, NR-12 e NR-18
--  110 questões novas por curso, ordem 41 a 150. São 550 questões.
--
--  Rode no SQL Editor. Pode rodar mais de uma vez: cada bloco apaga só as
--  suas próprias questões (ordem 41 a 150) antes de inserir de novo.
--
--  ATENÇÃO: ESTAS PERGUNTAS PRECISAM DA CONFERIDA DO RESPONSÁVEL TÉCNICO
--  ANTES DE VALEREM PARA CERTIFICADO.
--  Foram escritas a partir do conteúdo usual de cada norma e do que se
--  cobra em campo. São coerentes com as normas, mas quem responde pela
--  prova é o responsável técnico — prova errada reprova quem sabe e
--  aprova quem não sabe, e é o certificado dele que está em jogo.
--
--  PARA QUE SERVE ESTE ARQUIVO
--  A prova sorteia 10 questões do banco do curso. Com 40 cadastradas o
--  sorteio já não repete tanto, mas em turma grande o gabarito ainda
--  circula. Com 150, duas provas seguidas praticamente não se parecem e
--  decorar deixa de compensar: sai mais barato aprender a norma.
--
--  AS 40 PRIMEIRAS CONTINUAM VALENDO
--  As questões de ordem 1 a 40 vieram dos arquivos 12 e 15 a 18 e NÃO são
--  apagadas aqui: o delete de cada bloco tem `ordem between 41 and 150`.
--  Rodar este arquivo depois daqueles deixa o curso com 150 questões, não
--  com 110. A ordem em que se roda não importa.
--
--  NENHUMA QUESTÃO REPETE AS 40 QUE JÁ EXISTIAM
--  Nem o mesmo fato escrito com outras palavras. Cada questão nova foi
--  conferida contra todas as antigas do mesmo curso. Isso importa mais do
--  que parece: duas versões da mesma pergunta com gabaritos diferentes
--  reprovam justamente quem estudou.
--
--  A COLUNA `correta` É O ÍNDICE, COMEÇANDO EM ZERO
--  Se a resposta certa é a primeira alternativa, `correta` é 0. A posição
--  da resposta certa foi espalhada pelos quatro índices, sem padrão fixo:
--  aluno que decora sequência de gabarito não aprende norma nenhuma.
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
--  NR-10 — Segurança em instalações e serviços em eletricidade
--  (questões 41 a 150)
--  As 40 primeiras cobriram o básico: desenergização, choque, arco,
--  aterramento. Estas puxam para o que mata depois do básico: a volta da
--  energia, a fonte que ninguém lembrou de desligar, o EPI vencido e o
--  serviço que mudou de condição no meio.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-10')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O serviço acabou e a instalação vai ser religada. Qual é a ordem correta da reenergização?',
     '["Ligar tudo de uma vez e depois conferir se ficou alguém no local", "Retirar o aterramento temporário primeiro e o bloqueio só no fim do dia", "Retirar ferramentas e pessoas, remover o aterramento temporário, remover a sinalização, remover o bloqueio e só então religar", "Religar e depois avisar a equipe pelo rádio"]', 2, 41),

    ('Quem dá a ordem para reenergizar a instalação?',
     '["O responsável pelo serviço, depois de confirmar que todos saíram e que a instalação está em condição de operar", "O operador da produção, porque é quem precisa da máquina", "Qualquer trabalhador que já tenha terminado a parte dele", "O primeiro que chegar ao painel depois do almoço"]', 0, 42),

    ('Numa equipe de cinco pessoas trabalhando no mesmo circuito, como fica o bloqueio?',
     '["Um cadeado só, do encarregado, serve para a equipe inteira", "Cada trabalhador coloca o seu próprio cadeado, e o circuito só volta quando o último retirar o dele", "Basta uma etiqueta com o nome da equipe", "O cadeado fica com o vigia da portaria"]', 1, 43),

    ('O dispositivo a ser bloqueado não tem furo nem lugar para prender cadeado. O que fazer?',
     '["Deixar um colega de guarda no painel o dia inteiro", "Desistir do bloqueio e confiar na etiqueta", "Amarrar o disjuntor com arame", "Usar dispositivo de bloqueio apropriado, como garra, caixa de bloqueio ou trava específica, ou bloquear em ponto anterior do circuito"]', 3, 44),

    ('O que a etiqueta colocada junto ao bloqueio precisa informar?',
     '["Quem bloqueou, a data e o motivo, para que qualquer um saiba a quem procurar", "O número do patrimônio do painel", "A tensão nominal do circuito", "Só a palavra perigo"]', 0, 45),

    ('Um colega bloqueou o painel, foi embora e levou a chave do cadeado. O que fazer?',
     '["Cortar o cadeado na hora, porque a produção está parada", "Ligar por outro caminho, contornando o disjuntor bloqueado", "Seguir o procedimento da empresa para remoção excepcional de bloqueio, com autorização do responsável e conferência de que ninguém está na instalação", "Esperar o colega voltar na próxima semana sem avisar ninguém"]', 2, 46),

    ('Por que a vestimenta para risco de arco elétrico precisa ter classificação compatível com a energia incidente?',
     '["Porque é exigência apenas do fabricante da roupa", "Para durar mais lavagens", "Para o trabalhador ser reconhecido de longe", "Para o tecido não derreter e a roupa suportar o calor do arco sem entrar em combustão"]', 3, 47),

    ('O trabalhador vai vestir a roupa de proteção contra arco. O que ele não pode usar por baixo dela?',
     '["Camiseta de algodão", "Roupa íntima de tecido sintético, que derrete com o calor", "Meia de algodão", "Camisa de mangas compridas"]', 1, 48),

    ('Além da roupa, o que protege o rosto e os olhos em serviço com risco de arco elétrico?',
     '["Capacete com viseira ou balaclava próprios para arco elétrico, junto com o capacete de classe adequada", "Máscara de solda de vidro comum", "Boné com aba", "Óculos escuros comuns"]', 0, 49),

    ('Antes de escavar ou perfurar piso e paredes na empresa, o cuidado elétrico é:',
     '["Perfurar devagar e parar assim que sentir resistência", "Levantar as interferências antes, identificando eletrodutos e cabos embutidos ou enterrados, e desligar o que for necessário", "Usar somente ferramenta com cabo emborrachado", "Confiar na planta antiga da instalação, que costuma bastar"]', 1, 50),

    ('Antes de desligar o quadro geral para executar o serviço, é preciso saber:',
     '["Apenas quantas máquinas vão parar de produzir", "Apenas o horário de menor movimento na empresa", "Apenas se o gerador vai assumir a carga sozinho", "Quais circuitos essenciais dependem dele, como iluminação de emergência, bombas de incêndio e exaustão, para tratar cada um antes de desligar"]', 3, 51),

    ('Quem responde tecnicamente pelo projeto e pelas alterações de uma instalação elétrica?',
     '["O eletricista que executa o serviço no dia", "Profissional legalmente habilitado, com registro no conselho de classe", "O encarregado da manutenção da empresa", "O fornecedor do material elétrico"]', 1, 52),

    ('Para que serve o estrado ou tapete isolante colocado em frente ao painel elétrico?',
     '["Para servir de apoio a ferramentas", "Para amortecer o barulho da manobra", "Para isolar o trabalhador do piso e dificultar o fechamento do circuito pelo corpo até a terra", "Para não sujar o piso da sala"]', 2, 53),

    ('Para que serve o bastão de manobra em instalação de alta tensão?',
     '["Para apoiar a escada no poste", "Para medir a distância até o cabo", "Para alcançar objetos caídos atrás do painel", "Para operar chaves e aplicar aterramento mantendo o trabalhador longe da parte energizada"]', 3, 54),

    ('O serviço vai ser feito num quadro dentro de uma sala por onde outras pessoas passam. O que a norma espera?',
     '["Que o trabalhador avise por rádio e siga o serviço", "Que a área seja isolada e sinalizada, com barreiras e placas, impedindo aproximação de quem não é da equipe", "Que a porta fique aberta para ventilar", "Que o serviço seja feito no horário de almoço, sem sinalização"]', 1, 55),

    ('O conjunto de aterramento temporário precisa ser escolhido conforme:',
     '["A cor do cabo disponível no almoxarifado", "O tamanho do painel", "A corrente de curto-circuito prevista no ponto, para suportar sem se romper caso a energia volte", "O gosto do eletricista"]', 2, 56),

    ('Por que o aterramento temporário deve ficar, sempre que possível, visível do local de trabalho?',
     '["Para facilitar a limpeza do painel", "Porque o cabo esquenta se ficar escondido", "Para enfeitar o serviço", "Para a equipe conferir a qualquer momento que a proteção continua instalada e ninguém a retirou"]', 3, 57),

    ('A instalação tem entrada da concessionária e também um gerador de emergência. Antes de trabalhar:',
     '["Todas as fontes possíveis de energia devem ser identificadas, seccionadas e bloqueadas, inclusive o gerador", "Basta desligar o gerador, porque ele é a fonte mais perigosa", "Basta avisar o pessoal da manutenção que existe um gerador", "Basta desligar a chave geral da concessionária"]', 0, 58),

    ('Por que um nobreak exige cuidado mesmo com o disjuntor geral desligado?',
     '["Porque as baterias continuam alimentando a saída e mantêm circuitos energizados", "Porque ele só liga quando alguém aperta o botão", "Porque ele descarrega sozinho em poucos segundos", "Porque ele apita e atrapalha a comunicação"]', 0, 59),

    ('O que é o retorno de energia que preocupa em serviço elétrico?',
     '["A conta de luz que volta mais cara", "Energia chegando ao ponto de trabalho por um caminho não previsto, como gerador, outro alimentador ou ligação provisória de vizinho", "O aumento de tensão depois de uma tempestade", "A corrente que passa pelo aterramento em condição normal"]', 1, 60),

    ('Que cuidado o banco de baterias de uma sala elétrica exige?',
     '["Nenhum, porque a tensão é baixa", "Ventilação do local, ferramenta isolada e cuidado com curto entre polos, além do risco químico do eletrólito", "Só cuidado com o peso das baterias", "Apenas manter a sala trancada"]', 1, 61),

    ('Ao usar multímetro ou alicate amperímetro em painel industrial, é preciso:',
     '["Retirar as pontas de prova e encostar os fios direto", "Usar qualquer aparelho, desde que tenha bateria boa", "Usar instrumento de categoria e faixa compatíveis com a instalação, com pontas de prova íntegras", "Usar sempre a escala mais baixa para dar mais precisão"]', 2, 62),

    ('A ponta de prova do instrumento está com o cabo ressecado e o isolamento rachado. O que fazer?',
     '["Usar só nas medições de baixa tensão", "Retirar de uso e substituir, porque a falha do isolamento coloca a mão do trabalhador no circuito", "Segurar pela parte boa do cabo", "Enrolar fita isolante e continuar a medição"]', 1, 63),

    ('Um fusível queima toda semana no mesmo circuito. O que não se pode fazer?',
     '["Conferir se há sobrecarga na instalação", "Verificar se algum equipamento está com defeito", "Investigar o motivo da queima", "Trocar por fusível de amperagem maior para ele parar de queimar"]', 3, 64),

    ('Um cabo de alimentação está emendado com fita e sem nenhum tipo de conector apropriado. A avaliação correta é:',
     '["Tudo bem, se a fita for de boa qualidade", "Tudo bem, se for uso temporário", "É irregular: a emenda precisa ser feita com material e técnica que mantenham o isolamento e a resistência mecânica originais", "Só é problema em alta tensão"]', 2, 65),

    ('Um cabo de extensão atravessa o corredor por onde passam pessoas e carrinhos. O correto é:',
     '["Elevar, proteger com canaleta ou passar por rota alternativa, evitando esmagamento e tropeço", "Amarrar o cabo no corrimão", "Deixar assim e avisar quem passa", "Cobrir com papelão"]', 0, 66),

    ('Encontrou-se um quadro elétrico sendo usado para guardar vassoura, pano e material de limpeza. O que isso representa?',
     '["Situação aceitável se o quadro ficar trancado", "Bom aproveitamento de espaço", "Risco de contato acidental, de incêndio e de impedir a manobra rápida do disjuntor: o quadro deve ser esvaziado e mantido só com o que é dele", "Problema apenas de organização, sem risco elétrico"]', 2, 67),

    ('Por que a área na frente de um quadro elétrico precisa ficar desobstruída?',
     '["Para caber o carrinho de ferramentas", "Por exigência da limpeza, não da segurança", "Para o quadro não esquentar", "Para permitir manobra, manutenção e saída rápida em caso de emergência"]', 3, 68),

    ('Quadros e painéis situados em áreas de circulação de pessoas devem:',
     '["Ficar trancados e sinalizados, com acesso restrito a pessoal autorizado", "Ficar abertos para facilitar o trabalho da manutenção", "Ficar sem identificação, para não chamar atenção", "Ficar com a porta encostada para ventilar"]', 0, 69),

    ('Um disjuntor desarma sempre que a máquina liga. Um trabalhador não autorizado insiste em rearmar. Qual a orientação?',
     '["Rearmar quantas vezes for preciso até a máquina ficar", "Prender o disjuntor com fita para ele não desarmar", "Parar de rearmar e acionar a manutenção: o desarme repetido indica defeito, e insistir pode provocar incêndio ou acidente", "Trocar o disjuntor por um de corrente maior"]', 2, 70),

    ('Em área molhada ou ao tempo, o quadro e os componentes elétricos precisam:',
     '["Ser desligados sempre que chove", "Ser apenas cobertos com lona quando chove", "Ter grau de proteção adequado ao ambiente, mantendo prensa-cabos e vedações íntegros", "Ser instalados a pelo menos 3 metros do chão"]', 2, 71),

    ('Serviço elétrico em área classificada, com risco de atmosfera explosiva, exige além do previsto na NR-10:',
     '["Apenas usar roupa de algodão", "Apenas trabalhar em dupla", "Nada de diferente, porque o risco é o mesmo", "Atender também os requisitos de área classificada, com equipamento e ferramenta apropriados e liberação específica da área"]', 3, 72),

    ('A tarefa elétrica também vai acontecer dentro de um tanque. Como fica a liberação?',
     '["Nenhuma permissão é necessária se o tanque estiver limpo", "Só a permissão elétrica basta", "Só a permissão de espaço confinado basta", "Valem as duas exigências ao mesmo tempo, com medição de atmosfera, vigia e as medidas elétricas previstas"]', 3, 73),

    ('Para que serve a ordem de serviço ou o procedimento escrito de uma tarefa elétrica?',
     '["Para a empresa cobrar do cliente", "Para justificar o tempo gasto no serviço", "Para descrever os passos, os riscos e as medidas de controle, de modo que a tarefa não dependa da memória de quem executa", "Para substituir o treinamento do trabalhador"]', 2, 74),

    ('Quem trabalha em sistema elétrico de potência, como redes e subestações da concessionária, precisa:',
     '["Do curso básico e também do treinamento complementar específico para esse tipo de instalação", "De nada além do exame médico", "Somente do curso básico de segurança em eletricidade", "Somente da autorização do encarregado"]', 0, 75),

    ('Que documentos comprovam que o trabalhador está regular para o serviço elétrico?',
     '["Apenas o comprovante de entrega dos EPIs", "Apenas a carteira de trabalho assinada", "Certificado do treinamento, autorização formal da empresa e atestado de saúde ocupacional válido", "Apenas o crachá da empresa"]', 2, 76),

    ('O trabalhador percebe que a condição do serviço é diferente da prevista na análise de risco. O que ele deve fazer?',
     '["Seguir assim mesmo, porque a permissão já foi assinada", "Interromper a tarefa, comunicar o responsável e refazer a análise antes de continuar", "Resolver por conta e comunicar no fim do dia", "Chamar outro colega para dividir a responsabilidade"]', 1, 77),

    ('Em serviço elétrico, a norma trata o trabalho isolado como:',
     '["Preferível, porque evita distração", "Situação a evitar: em serviço com risco elétrico relevante, é preciso haver quem possa socorrer e acionar ajuda", "Indiferente, desde que o trabalhador seja experiente", "Permitido sempre que o serviço for rápido"]', 1, 78),

    ('Por que se espera que integrantes da equipe saibam prestar primeiros socorros e realizar reanimação?',
     '["Porque a parada cardiorrespiratória por choque exige atendimento nos primeiros minutos, antes da chegada do socorro", "Porque é exigência apenas para o supervisor", "Para reduzir o custo do plano de saúde", "Para substituir o serviço médico da empresa"]', 0, 79),

    ('Sobre o desfibrilador externo automático em locais com risco elétrico:',
     '["Só médico pode usar", "É um equipamento que orienta o socorrista por voz e pode ser usado por pessoa treinada enquanto o socorro não chega", "Serve apenas para vítimas conscientes", "Substitui a massagem cardíaca"]', 1, 80),

    ('A queimadura por eletricidade costuma ter uma característica que engana:',
     '["Ela nunca precisa de atendimento", "Ela sempre dói muito, o que facilita o diagnóstico", "Ela aparece só na pele e some sozinha", "Ela pode ter aparência pequena na entrada e na saída da corrente e ter destruído muito tecido por dentro"]', 3, 81),

    ('O que não se deve fazer numa queimadura de trabalhador acidentado?',
     '["Cobrir com pano limpo", "Furar bolhas e passar pasta de dente, manteiga ou borra de café", "Encaminhar ao atendimento médico", "Resfriar com água corrente limpa"]', 1, 82),

    ('Uma pessoa foi atingida por cabo de alta tensão e está caída ao solo. Qual o primeiro cuidado de quem chega?',
     '["Correr e puxar a vítima pelos braços", "Jogar água para desligar a energia", "Manter distância segura, isolar o local e acionar a concessionária e o socorro, pois o solo em volta pode estar energizado", "Encostar com um cabo de vassoura de metal para testar"]', 2, 83),

    ('Começou um princípio de incêndio dentro de um painel elétrico energizado. O que usar?',
     '["Extintor apropriado para equipamento energizado, como dióxido de carbono ou pó, depois de desligar a energia se for possível com segurança", "Areia jogada com pá dentro do painel", "Cobrir com um pano molhado", "Água do hidrante, que é o que apaga melhor"]', 0, 84),

    ('Por que se procura desligar a energia antes de combater um incêndio de origem elétrica?',
     '["Porque a fumaça diminui", "Para economizar energia", "Porque enquanto houver energia a fonte de calor continua e o agente extintor pode conduzir corrente até quem combate", "Porque o extintor não funciona com energia ligada"]', 2, 85),

    ('O que significa a ferramenta elétrica portátil com o símbolo de dois quadrados, um dentro do outro?',
     '["Que ela tem dupla isolação, e por isso não depende do pino de terra, mas continua exigindo cabo e carcaça íntegros", "Que ela pode ser usada na chuva", "Que ela é de uso exclusivo do eletricista", "Que ela é bivolt"]', 0, 86),

    ('Para que serve a equipotencialização entre massas metálicas de uma instalação?',
     '["Para aumentar a corrente do circuito", "Para reduzir a conta de energia", "Para deixar a instalação mais bonita", "Para evitar diferença de potencial entre partes metálicas que a pessoa possa tocar ao mesmo tempo"]', 3, 87),

    ('Serviço em sistema de proteção contra descargas atmosféricas, o para-raios, durante tempestade:',
     '["Pode ser feito, porque o sistema está aterrado", "Deve ser interrompido: a estrutura pode conduzir a descarga a qualquer momento", "Pode ser feito com luva isolante", "Pode ser feito se o trabalhador estiver com bota de borracha"]', 1, 88),

    ('Serviço elétrico externo, em rede ou poste, com tempestade elétrica se aproximando:',
     '["Continua, porque o risco só existe com chuva forte", "Continua, se faltar pouco para terminar", "Deve ser interrompido e a equipe recolhida a local seguro", "Continua, desde que dois trabalhadores fiquem no solo"]', 2, 89),

    ('Serviços próximos a rede energizada precisam respeitar:',
     '["Somente a orientação verbal do encarregado", "A distância que o trabalhador achar confortável", "As distâncias mínimas de aproximação definidas para a tensão da rede, com desligamento, isolação ou afastamento quando não for possível respeitá-las", "Apenas o limite de 1 metro em qualquer tensão"]', 2, 90),

    ('Uma equipe vai podar árvore cujos galhos encostam na rede elétrica. O correto é:',
     '["Podar com escada de alumínio e podão comum", "Solicitar o desligamento ou a proteção da rede à concessionária e usar equipe e ferramentas apropriadas", "Podar com chuva fina, porque a árvore fica mais leve", "Cortar os galhos e deixar caírem sobre a rede"]', 1, 91),

    ('Numa instalação fotovoltaica, mesmo com o inversor desligado:',
     '["A tensão desaparece ao cobrir um único módulo", "Não há tensão em lugar nenhum", "Os módulos continuam gerando tensão contínua enquanto houver luz, e esse lado permanece energizado", "A tensão só existe à noite"]', 2, 92),

    ('Sobre o cabo e o porta-eletrodo da máquina de solda elétrica:',
     '["Devem estar íntegros e com garra e porta-eletrodo isolados, pois a máquina de solda também oferece risco de choque", "Não oferecem risco porque a tensão é baixa", "Podem ficar em contato com poça de água sem problema", "Emenda com fita é normal em máquina de solda"]', 0, 93),

    ('Ao medir corrente com transformador de corrente instalado, um cuidado clássico é:',
     '["Sempre curto-circuitar o primário antes", "Retirar o aterramento do painel para medir melhor", "Medir sempre com o painel aberto e sem EPI", "Nunca deixar o secundário do transformador de corrente aberto, porque aparecem tensões perigosas nos terminais"]', 3, 94),

    ('Levar trena metálica, vergalhão ou escada de alumínio para perto de rede energizada:',
     '["É perigoso, porque o material conduz e pode aproximar o trabalhador da tensão sem que ele perceba", "É seguro em rede de baixa tensão", "É permitido se for rápido", "É seguro se o trabalhador usar luva de raspa"]', 0, 95),

    ('Uma chave de fenda caiu dentro do painel energizado. O que fazer?',
     '["Usar outra ferramenta metálica para empurrar", "Não tentar recuperar com o painel energizado: desenergizar, bloquear e só então retirar a ferramenta", "Sacudir o painel até a ferramenta cair", "Enfiar a mão rápido e pegar"]', 1, 96),

    ('Limpar painel elétrico energizado com pano úmido é:',
     '["Recomendado, porque tira melhor a poeira", "Aceitável se o pano for bem torcido", "Inadequado: a umidade cria caminho para a corrente, e a limpeza deve ser feita com o painel desenergizado", "Aceitável em painel de baixa tensão"]', 2, 97),

    ('Sobre usar ar comprimido para limpar poeira de painel elétrico:',
     '["Só deve ser feito com o painel desenergizado e conforme o procedimento, pois o jato pode espalhar contaminante e projetar partícula", "Pode ser feito com o painel ligado, se o jato for fraco", "Pode ser feito sem óculos de proteção", "É a melhor solução em qualquer situação"]', 0, 98),

    ('O turno acabou e o serviço bloqueado continua no turno seguinte. O correto é:',
     '["Fazer a passagem formal do serviço, com a equipe que entra assumindo e colocando os próprios bloqueios antes que a anterior retire os dela", "Deixar o cadeado da equipe anterior e ninguém mais mexer", "Religar a instalação durante a noite e desligar de manhã", "Retirar os bloqueios e recolocá-los amanhã"]', 0, 99),

    ('Trabalhador de empresa contratada vai executar serviço elétrico na planta do cliente. Quem autoriza?',
     '["Qualquer supervisor do cliente, verbalmente", "A portaria, ao liberar o acesso", "Ele mesmo, porque tem certificado", "O empregador dele o autoriza como trabalhador, e o serviço só começa depois da liberação da empresa contratante, conforme os procedimentos do local"]', 3, 100),

    ('Sobre a inspeção periódica das instalações elétricas:',
     '["Só é feita quando ocorre acidente", "É prevista e registrada, e serve para encontrar defeito antes que ele vire acidente", "É responsabilidade da concessionária", "É dispensada em instalação nova"]', 1, 101),

    ('Para que serve a inspeção termográfica em painéis elétricos?',
     '["Para localizar pontos de aquecimento anormal, como conexão frouxa, antes que provoquem falha ou incêndio", "Para conferir a cor dos cabos", "Para substituir a manutenção preventiva", "Para medir a temperatura ambiente da sala"]', 0, 102),

    ('Sentiu-se cheiro de queimado perto de um quadro elétrico, sem fogo aparente. O que fazer?',
     '["Afastar as pessoas, comunicar a manutenção e avaliar o desligamento do circuito: cheiro de queimado indica aquecimento e risco de incêndio", "Jogar água preventivamente", "Ignorar, porque quadro sempre tem cheiro", "Abrir a porta e assoprar"]', 0, 103),

    ('O uso de adaptadores de tomada em cascata e réguas ligadas umas nas outras:',
     '["Só é problema se houver mais de dez aparelhos", "É aceitável em escritórios", "É solução prática e sem risco", "Sobrecarrega o ponto, aquece as conexões e é causa comum de incêndio: deve ser eliminado com pontos elétricos suficientes"]', 3, 104),

    ('Uma ligação clandestina, o chamado gato, encontrada dentro da empresa deve ser tratada como:',
     '["Assunto exclusivamente da concessionária, sem risco para quem trabalha", "Risco elétrico grave: instalação sem proteção, sem dimensionamento e sem registro, que precisa ser desfeita e regularizada", "Problema de custo apenas", "Situação aceitável enquanto a obra estiver em andamento"]', 1, 105),

    ('Entre as responsabilidades do empregador em serviços com eletricidade está:',
     '["Fornecer EPIs e ferramentas adequadas, garantir treinamento, procedimentos e a autorização formal dos trabalhadores", "Autorizar verbalmente e conferir depois", "Exigir produção mesmo com risco identificado", "Deixar o trabalhador comprar o próprio EPI"]', 0, 106),

    ('Um serviço vai desligar um quadro que alimenta equipamentos de outro setor. Antes de executar, o correto é:',
     '["Desligar apenas metade do quadro, para reduzir o impacto", "Desligar e avisar depois, porque o serviço é rápido", "Pedir ao operador do outro setor que desligue os equipamentos dele na hora", "Comunicar e programar previamente com as áreas afetadas, para não parar equipamento crítico de surpresa nem provocar improviso de quem for atingido"]', 3, 107),

    ('Antes de liberar a equipe para a tarefa, o que se espera do supervisor ou responsável?',
     '["Entregar a permissão assinada em branco", "Delegar a conferência ao mais novo da equipe", "Conferir apenas se todos assinaram a lista de presença", "Verificar as condições do local, os bloqueios, os equipamentos e se os trabalhadores estão autorizados e aptos naquele dia"]', 3, 108),

    ('O teste de ausência de tensão deve ser feito:',
     '["Em todos os condutores do circuito, incluindo o neutro, antes de qualquer contato", "Somente na entrada do painel", "Somente se o disjuntor for antigo", "Só na fase que será manipulada"]', 0, 109),

    ('Um cabo desenergizado corre paralelo a uma linha energizada de longa extensão. Que fenômeno pode aparecer nele?',
     '["Tensão induzida, capaz de provocar choque, o que exige aterramento temporário nas duas extremidades da área de trabalho", "Aumento de resistência apenas", "Aquecimento do cabo somente", "Nenhum, cabo desligado é sempre cabo morto"]', 0, 110),

    ('Trabalhador que precisa entrar em subestação de acesso restrito deve:',
     '["Entrar acompanhado de qualquer colega", "Entrar somente com autorização, controle de acesso e acompanhamento previsto no procedimento do local", "Entrar quando encontrar a porta aberta", "Entrar e avisar depois pelo rádio"]', 1, 111),

    ('Uma placa de advertência colocada no disjuntor durante o serviço serve para:',
     '["Cumprir exigência do seguro", "Substituir o cadeado de bloqueio", "Avisar de forma clara que existe gente trabalhando e que a manobra está proibida, complementando o bloqueio físico", "Identificar o circuito para a limpeza"]', 2, 112),

    ('Sobre a execução de serviço elétrico quando existe também risco de queda:',
     '["O cinto substitui o desligamento do circuito", "A norma de eletricidade dispensa a proteção contra queda", "Valem as duas exigências ao mesmo tempo, com sistema de proteção contra queda além das medidas elétricas", "Basta um colega segurar a escada embaixo"]', 2, 113),

    ('Trabalhador que se recusa a executar tarefa elétrica por identificar risco grave e iminente:',
     '["Está cometendo insubordinação", "Está exercendo o direito de interromper a tarefa, devendo comunicar de imediato o superior", "Só pode fazer isso com autorização do sindicato", "Só pode fazer isso se estiver com o certificado em mãos"]', 1, 114),

    ('Sobre a análise de risco de uma tarefa elétrica, é correto dizer que:',
     '["Basta assinar depois que o serviço terminar", "Serve para qualquer serviço da empresa, uma vez feita", "Deve considerar a tarefa, o local, as pessoas e as condições daquele dia, sendo revista quando algo muda", "É documento do setor administrativo"]', 2, 115),

    ('Um estagiário quer acompanhar o serviço elétrico para aprender. O correto é:',
     '["Permitir apenas acompanhamento sob supervisão de profissional autorizado, sem executar intervenção por conta própria", "Não permitir presença nenhuma na empresa", "Permitir que ele opere o painel se estiver de luva", "Deixar ele executar sozinho a parte fácil"]', 0, 116),

    ('Sobre o uso de rádio comunicador e celular durante serviço elétrico:',
     '["Só o supervisor pode ter rádio", "O uso é livre em qualquer momento", "A comunicação deve ser prevista no procedimento, e o uso pessoal do celular é evitado por distrair em atividade de risco", "É proibido qualquer meio de comunicação"]', 2, 117),

    ('Uma ferramenta isolada apresenta o cabo com a borracha rachada e rasgada. O que fazer?',
     '["Lixar a parte danificada", "Recobrir com fita isolante e continuar usando", "Usar apenas em circuitos de baixa tensão", "Retirar de uso, pois a isolação danificada não protege mais e a ferramenta perde a característica que a tornava segura"]', 3, 118),

    ('Sobre o crachá de cordão e outros objetos pendurados durante o serviço elétrico:',
     '["Objetos pendurados devem ser retirados, pois podem tocar partes energizadas ou enroscar em componentes", "Só é problema se o cordão for metálico", "Só é problema em alta tensão", "Cordão de crachá é sempre inofensivo"]', 0, 119),

    ('O trabalhador percebeu que o colega está prestes a tocar em parte energizada. O que fazer?',
     '["Comunicar apenas ao supervisor no fim do turno", "Filmar para mostrar depois no diálogo de segurança", "Avisar imediatamente e interromper a ação, mesmo que o colega seja mais experiente", "Esperar para não constranger"]', 2, 120),

    ('Sobre o uso de calçado em serviço elétrico:',
     '["Qualquer tênis serve, desde que seja fechado", "O calçado deve ser adequado ao risco, sem componentes metálicos expostos que favoreçam o contato elétrico", "Chinelo é aceitável em serviço rápido", "Bota com biqueira de aço é sempre a melhor escolha em eletricidade"]', 1, 121),

    ('O que a norma espera quanto às condições do trabalhador no dia do serviço elétrico?',
     '["Que esteja apto, descansado e sem uso de substância que reduza a atenção, comunicando alteração de saúde ao responsável", "Que tenha almoçado bem", "Que tenha mais de cinco anos de experiência", "Que ele esteja de uniforme, apenas"]', 0, 122),

    ('Ao encontrar uma instalação sem projeto, sem identificação e sem prontuário, a equipe deve:',
     '["Trabalhar mesmo assim, seguindo a intuição", "Levantar as informações necessárias e as condições reais antes de intervir, tratando toda parte não identificada como energizada", "Desligar tudo aleatoriamente até achar o circuito", "Recusar qualquer serviço na empresa"]', 1, 123),

    ('O que significa tratar como energizado todo circuito ainda não testado?',
     '["Recomendação do fabricante do detector", "Exagero de quem tem medo", "Regra prática de segurança: só se considera desligado o que foi seccionado, bloqueado, testado e aterrado", "Regra que vale apenas em alta tensão"]', 2, 124),

    ('Quando a energia precisa ser mantida ligada porque o desligamento traria risco maior, como em hospital:',
     '["Basta o consentimento verbal do gerente", "A norma proíbe qualquer serviço nessa condição", "A situação é avaliada e justificada tecnicamente, com procedimento específico, equipe habilitada e medidas adicionais de controle", "O serviço pode ser feito da forma habitual, sem cuidados extras"]', 2, 125),

    ('Sobre a montagem de andaime metálico próximo a partes energizadas:',
     '["Basta aterrar o andaime", "Basta avisar o operador da subestação", "Não há risco, porque o andaime fica no chão", "É preciso avaliar a distância de aproximação, e desligar, isolar ou afastar a rede antes da montagem e do uso"]', 3, 126),

    ('A empresa comprou detectores de tensão novos. Antes de entrar em uso, eles precisam:',
     '["Ser verificados quanto a funcionamento, faixa de tensão e integridade, e ter uso ensinado a quem vai empregá-los", "Ser pintados com a cor da empresa", "Ser testados apenas quando falharem", "Ser guardados no armário do supervisor"]', 0, 127),

    ('O que se espera do registro das intervenções feitas em uma instalação elétrica?',
     '["Que seja feito só quando ocorre acidente", "Que fique documentado o que foi alterado, por quem e quando, mantendo o histórico e os desenhos atualizados", "Que fique guardado apenas na memória do eletricista antigo", "Que seja destruído ao fim do ano"]', 1, 128),

    ('Uma tarefa elétrica foi interrompida no meio e a equipe saiu para outro serviço. O que deve acontecer?',
     '["Manter bloqueio e sinalização, isolar a área e deixar registrado o estado da instalação, para ninguém encontrar o painel aberto sem saber", "Retirar o bloqueio e recolocar quando voltar", "Fechar as portas e retirar as placas", "Deixar tudo aberto para agilizar a volta"]', 0, 129),

    ('Sobre a distância entre o trabalhador e a parte energizada em serviço com a instalação ligada:',
     '["Não existe limite definido", "Depende apenas do tempo de exposição", "Pode ser reduzida quando o trabalhador usa luva", "Deve respeitar os limites definidos para a tensão, com uso de isolação, barreiras e ferramentas apropriadas quando houver aproximação"]', 3, 130),

    ('Qual a diferença entre a barreira e a sinalização usadas em serviço elétrico?',
     '["Não há diferença, são a mesma coisa", "A barreira impede fisicamente o acesso e a sinalização informa o risco: as duas se completam e uma não substitui a outra", "A sinalização impede o acesso e a barreira apenas informa", "Ambas servem apenas para atender à fiscalização"]', 1, 131),

    ('O que se faz com o EPI elétrico ao fim do serviço?',
     '["Guarda na caixa de ferramentas junto com alicates e chaves", "Deixa dentro do carro, ao sol", "Deixa no chão do painel para o próximo usar", "Inspeciona, limpa conforme a orientação e guarda em local apropriado, protegido de calor, umidade e produto químico"]', 3, 132),

    ('Sobre a validade do treinamento de segurança em eletricidade quando o trabalhador troca de empresa:',
     '["A nova empresa avalia, complementa quando necessário e emite a sua própria autorização para os serviços e instalações dela", "É preciso refazer todos os cursos do zero, sempre", "O trabalhador fica autorizado assim que apresenta o certificado à portaria", "O certificado antigo garante a autorização automática na nova empresa"]', 0, 133),

    ('Trabalhador retorna de afastamento longo por doença. Sobre a atuação em serviços elétricos:',
     '["Volta direto às mesmas atividades", "Precisa de avaliação de aptidão e, conforme a mudança de condições, de reciclagem antes de voltar a executar", "Fica proibido de trabalhar com eletricidade para sempre", "Só precisa avisar o encarregado"]', 1, 134),

    ('Sobre trabalhar embaixo de linha energizada com caminhão munck ou guindaste:',
     '["É proibido em qualquer situação", "Basta aterrar o caminhão", "Basta o operador tomar cuidado com a lança", "É preciso avaliar previamente a distância, sinalizar, usar sinaleiro e, quando não for possível manter o afastamento, solicitar o desligamento da rede"]', 3, 135),

    ('Se a lança de um equipamento encostar em rede energizada e o operador estiver dentro da cabine, o mais seguro geralmente é:',
     '["Sair correndo pela escada da máquina", "Permanecer na cabine e aguardar o desligamento, saltando com os pés juntos e sem tocar máquina e solo ao mesmo tempo apenas se houver risco maior, como incêndio", "Descer devagar segurando na estrutura", "Descer e tocar o solo com uma mão para descarregar"]', 1, 136),

    ('O trabalhador chegou ao serviço e o EPI que deveria usar não está disponível. O correto é:',
     '["Executar rápido e sem o EPI", "Não iniciar a tarefa e comunicar ao responsável, que deve providenciar o equipamento adequado", "Pegar emprestado o EPI vencido do colega", "Improvisar com o que houver"]', 1, 137),

    ('Sobre painéis com portas que abrem para dentro da rota de fuga da sala elétrica:',
     '["Só interferem se a sala for pequena", "Devem ser removidas as portas", "Não interferem em nada", "Interferem na evacuação e devem ser avaliados, pois em emergência a saída precisa estar livre e desimpedida"]', 3, 138),

    ('Sala elétrica sem iluminação de emergência é um problema porque:',
     '["Se faltar energia durante o serviço, o trabalhador fica no escuro junto a partes energizadas, sem enxergar a saída", "Dificulta a leitura do manual", "Prejudica a filmagem das câmeras", "Aumenta o consumo de energia"]', 0, 139),

    ('Uma modificação improvisada foi feita num circuito e ninguém atualizou os desenhos. Qual o risco para quem for atender depois?',
     '["Apenas dificuldade de manutenção, sem risco", "Somente problema de organização documental", "Nenhum, se a modificação funcionar", "A próxima equipe desliga o que acredita ser o circuito certo e trabalha em algo que continua energizado"]', 3, 140),

    ('Sobre motores e equipamentos que giram por inércia depois de desligados:',
     '["Só param se alguém segurar o eixo", "Param imediatamente ao desligar", "Podem continuar girando e até gerar tensão, exigindo espera e verificação antes da intervenção", "Não oferecem risco elétrico algum"]', 2, 141),

    ('Um trabalhador quer ligar equipamento de 220 volts numa tomada de 127 volts usando adaptador improvisado. Isso:',
     '["É aceitável se for por pouco tempo", "Cria risco de sobrecarga, aquecimento e falha da isolação, além de danificar o equipamento: cada ponto deve ter tensão e proteção compatíveis", "Só é problema para o equipamento, não para as pessoas", "É seguro se o disjuntor for de amperagem alta"]', 1, 142),

    ('O dispositivo diferencial residual desarma repetidamente num circuito. O que isso indica?',
     '["Que a tensão da rede está baixa", "Que faltou aterrar o quadro apenas", "Que ele é muito sensível e deve ser retirado", "Que existe fuga de corrente para a terra e a causa precisa ser investigada, e não o dispositivo eliminado"]', 3, 143),

    ('Uma emenda mal-feita provoca aquecimento porque:',
     '["A tensão do circuito diminui", "O disjuntor não consegue enxergar a emenda", "A corrente aumenta sozinha", "O mau contato eleva a resistência no ponto e a passagem da corrente gera calor, podendo iniciar incêndio"]', 3, 144),

    ('Ferramentas e materiais deixados sobre o painel durante o serviço:',
     '["Podem ficar ali se o painel estiver desenergizado", "São aceitáveis para agilizar o trabalho", "Devem ser mantidos em local apropriado, porque podem cair sobre partes energizadas e provocar curto e arco", "Só são problema se forem metálicos e pesados"]', 2, 145),

    ('Sobre os degraus e a estrutura do poste durante serviço em rede aérea:',
     '["Só precisam de verificação em poste de madeira", "A verificação é responsabilidade da prefeitura", "Podem ser usados sem verificação", "Devem ser avaliados antes da escalada, pois poste deteriorado, degrau solto e base comprometida já causaram queda e contato acidental"]', 3, 146),

    ('Quando a tarefa envolve mais de uma equipe trabalhando no mesmo sistema elétrico:',
     '["As equipes revezam o mesmo cadeado", "Cada equipe cuida de si e não precisa avisar a outra", "É preciso coordenação, bloqueio de todas as equipes e comunicação clara, porque a manobra de uma afeta a segurança da outra", "Uma equipe assume o bloqueio pela outra"]', 2, 147),

    ('O treinamento de segurança em eletricidade precisa incluir parte prática porque:',
     '["O trabalhador precisa saber manusear detector, bloqueio, aterramento e EPI antes de encontrar o painel real", "É exigência do setor de recursos humanos", "Facilita a emissão do certificado", "Aumenta a carga horária do curso"]', 0, 148),

    ('Um trabalhador foi treinado, mas nunca foi formalmente autorizado pela empresa. Ele pode intervir na instalação?',
     '["Pode, se o supervisor estiver por perto", "Pode, em serviços de baixa tensão", "Pode, o certificado basta", "Não pode: além da capacitação, é necessária a autorização formal do empregador para aquelas instalações e serviços"]', 3, 149),

    ('Qual é a mensagem central da segurança em eletricidade que se espera de quem conclui este curso?',
     '["Que o eletricista experiente pode dispensar procedimentos", "Que o risco elétrico é invisível e não avisa: só o procedimento cumprido por inteiro, com desligamento, bloqueio, teste e aterramento, protege de verdade", "Que a proteção depende principalmente do EPI", "Que o risco só existe em alta tensão"]', 1, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-10';

-- =====================================================================
--  NR-33 — Segurança e saúde nos trabalhos em espaços confinados
--  (questões 41 a 150)
--  As 40 primeiras trataram do que é espaço confinado, do vigia e da
--  atmosfera. Estas avançam para a permissão, o bloqueio das energias, o
--  resgate ensaiado e os detalhes que transformam uma entrada de rotina
--  em acidente com mais de uma vítima.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-33')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Quem assina a Permissão de Entrada e Trabalho autorizando a entrada?',
     '["O porteiro da empresa", "O trabalhador que vai entrar", "O supervisor de entrada, depois de verificar que todas as medidas exigidas foram cumpridas", "O vigia, porque é quem fica na boca do espaço"]', 2, 41),

    ('O que a permissão de entrada precisa registrar?',
     '["Somente o horário de início", "Somente a assinatura do supervisor", "Apenas o nome de quem entrou", "Os riscos, as medidas de controle, os resultados das medições, os equipamentos exigidos, a equipe e o período de validade"]', 3, 42),

    ('A condição do serviço mudou depois da liberação: apareceu vazamento de produto na linha vizinha. A permissão:',
     '["Deve ser cancelada, com todos saindo, e só se emite nova permissão depois de reavaliada a situação", "Vale para o restante do turno", "Vale se o vigia autorizar a continuidade", "Continua valendo, porque a assinatura já foi dada"]', 0, 43),

    ('Onde a permissão de entrada deve ficar durante o serviço?',
     '["No bolso do trabalhador que está dentro", "Arquivada assim que todos entram", "Guardada no escritório da segurança do trabalho", "Disponível na entrada do espaço confinado, à vista da equipe e de quem fiscaliza"]', 3, 44),

    ('Depois de encerrado o serviço, o que se faz com as permissões emitidas?',
     '["Descarta imediatamente", "São arquivadas pela empresa e ficam disponíveis para consulta, porque são o registro de como a entrada foi controlada", "Ficam com o trabalhador que entrou", "São entregues ao cliente e apagadas do sistema"]', 1, 45),

    ('Antes de a equipe entrar, uma conversa de alinhamento é feita para:',
     '["Definir quem vai buscar o café", "Repassar a tarefa, os riscos, os sinais de comunicação, o plano de emergência e conferir se todos entenderam o próprio papel", "Sortear quem entra primeiro", "Cumprir formalidade sem conteúdo prático"]', 1, 46),

    ('O detector de gases precisa passar por que verificações antes do uso?',
     '["Verificação de funcionamento com gás padrão e calibração dentro da validade, além de bateria e sensores em ordem", "Apenas limpar a tela", "Apenas conferir a data de fabricação", "Apenas conferir se liga"]', 0, 47),

    ('Por que o detector de gases precisa ter alarme sonoro e visual?',
     '["Para indicar o fim da bateria", "Para chamar a atenção de quem passa perto", "Porque em ambiente barulhento ou de pouca visibilidade o trabalhador precisa perceber o alarme de qualquer forma", "Para gravar a medição"]', 2, 48),

    ('Qual a sequência usual de leitura na avaliação da atmosfera?',
     '["Inflamáveis, tóxicos e depois oxigênio", "A ordem não importa", "Tóxicos, oxigênio e depois inflamáveis", "Oxigênio, gases e vapores inflamáveis e depois agentes tóxicos"]', 3, 49),

    ('A medição mostrou 12% do limite inferior de explosividade. Como agir?',
     '["Entrar com extintor na mão", "Entrar apenas com máscara de pó", "Entrar normalmente, o valor é baixo", "Não entrar: acima do limite aceito pela empresa, é preciso ventilar e eliminar a fonte antes de nova medição"]', 3, 50),

    ('O detector apitou indicando bateria fraca no meio do serviço. O que fazer?',
     '["Sacudir o aparelho para melhorar o contato", "Continuar, porque o alarme de gás ainda funciona", "Interromper e retirar a equipe, substituindo por equipamento em condição de uso antes de retomar", "Desligar o alarme e seguir"]', 2, 51),

    ('Antes de abrir a tampa e avaliar o interior, a amostragem correta é feita:',
     '["Jogando um pedaço de papel aceso dentro", "Descendo o detector amarrado depois que alguém já entrou", "Colocando o rosto na abertura para sentir o cheiro", "Com mangueira de amostragem ou sonda, mantendo o trabalhador fora da zona de risco"]', 3, 52),

    ('Para que serve a purga ou lavagem do equipamento antes da entrada?',
     '["Remover resíduos, vapores e gases remanescentes do produto antes de qualquer entrada", "Testar a resistência do tanque", "Aquecer o interior", "Deixar o tanque bonito por dentro"]', 0, 53),

    ('Por que apenas fechar a válvula da tubulação que chega ao equipamento não é suficiente?',
     '["Porque a válvula precisa ser lubrificada antes", "Porque a válvula pode ser difícil de operar", "Porque válvula pode vazar, ser aberta por engano ou falhar internamente, e por isso se usa bloqueio físico com raquete ou desconexão", "Porque a válvula enferruja"]', 2, 54),

    ('O motor do agitador do tanque foi desligado no painel. Falta o quê?',
     '["Seccionar, bloquear com cadeado individual, sinalizar e testar a impossibilidade de partida antes de qualquer entrada", "Avisar a produção por rádio apenas", "Colocar uma placa de aviso na porta do painel", "Nada, desligar no painel é suficiente"]', 0, 55),

    ('Além da energia elétrica, que outras energias precisam ser controladas antes da entrada?',
     '["Somente a pneumática", "Somente a energia térmica", "Somente a elétrica, as outras não oferecem risco", "Energia mecânica, hidráulica, pneumática, térmica, química e a energia potencial de peças que podem cair ou material que pode escorrer"]', 3, 56),

    ('Para entrada por abertura no alto, com descida vertical, o trabalhador usa:',
     '["Escada de mão apoiada no interior", "Somente o apoio dos colegas", "Uma corda amarrada na cintura", "Cinturão tipo paraquedista ligado a sistema de içamento e retenção de queda, permitindo retirada sem que alguém precise entrar"]', 3, 57),

    ('O vigia determinou a saída e o trabalhador lá dentro responde que falta pouco e não quer sair. O que deve acontecer?',
     '["O vigia aguarda ele terminar o que está fazendo", "A saída é imediata: a determinação do vigia é cumprida na hora, e o motivo é discutido depois, do lado de fora", "O vigia chama o supervisor e aguarda a decisão dele", "O trabalhador pode continuar enquanto o detector não estiver alarmando"]', 1, 58),

    ('Por que o resgate sem entrada, feito de fora, é a alternativa preferida?',
     '["Porque dispensa equipe de emergência", "Porque é mais barato", "Porque toda entrada de socorrista cria mais uma vítima em potencial, e a retirada externa evita esse risco", "Porque é mais rápido de treinar"]', 2, 59),

    ('O plano de emergência do espaço confinado precisa:',
     '["Ser específico para aquele espaço e aquela tarefa, com recursos, meios de comunicação e responsáveis definidos", "Ser guardado no setor de compras", "Ser escrito depois do primeiro acidente", "Ser um documento genérico da empresa"]', 0, 60),

    ('Durante todo o tempo em que houver trabalhador dentro do espaço confinado:',
     '["Basta o vigia saber gritar por ajuda", "A equipe de emergência pode estar em outra unidade da empresa", "Os recursos de resgate e a equipe treinada precisam estar disponíveis e prontos para agir de imediato", "Basta ter o telefone dos bombeiros anotado"]', 2, 61),

    ('Por que não se pode contar apenas com o socorro externo para o resgate?',
     '["Porque o socorro externo cobra caro", "Porque o tempo de chegada é incompatível com o tempo que uma pessoa suporta em atmosfera deficiente ou tóxica", "Porque o socorro externo não tem equipamento", "Porque a empresa não pode chamar bombeiros"]', 1, 62),

    ('Com que frequência a empresa deve exercitar o plano de emergência dos espaços confinados?',
     '["Somente na semana interna de prevenção de acidentes", "Nunca, basta ter o plano escrito", "Periodicamente, com simulados que testem os equipamentos, a comunicação e o tempo de resposta da equipe", "Somente quando a fiscalização avisa que virá"]', 2, 63),

    ('Um trabalhador foi retirado desacordado do espaço confinado. O que se faz em seguida?',
     '["Esperar ele acordar antes de chamar socorro", "Deixar descansando à sombra até melhorar", "Levar para local ventilado, avaliar consciência e respiração, iniciar os primeiros socorros e acionar atendimento médico imediatamente", "Dar água e mandar para casa"]', 2, 64),

    ('O espaço confinado tem duas aberturas por onde entram trabalhadores. Como fica a vigia?',
     '["Cada acesso em uso precisa de vigilância, com número de vigias suficiente para acompanhar todos os que entraram", "O supervisor cobre a segunda abertura por câmera", "A segunda abertura pode ser fechada com a equipe dentro", "Um vigia consegue cobrir as duas de longe"]', 0, 65),

    ('Quantos trabalhadores um vigia pode acompanhar?',
     '["Quantos couberem no espaço", "Um número que ele consiga efetivamente controlar e manter comunicação, conforme definido na análise de riscos e na permissão", "Sempre no máximo dez", "Não há relação entre vigia e número de trabalhadores"]', 1, 66),

    ('O supervisor pediu ao vigia que fizesse também a anotação de estoque durante o serviço. A resposta correta é:',
     '["Aceitar, se der para conciliar", "Recusar: o vigia não pode assumir tarefa que o afaste da vigilância permanente da entrada", "Aceitar e revezar a atenção", "Aceitar se o serviço dentro for curto"]', 1, 67),

    ('Quando não há visão direta de quem está dentro, a comunicação pode ser feita por:',
     '["Rádio, telefone, corda-guia com código de sinais ou outro meio combinado antes e testado", "Batidas aleatórias na parede do tanque", "Grito, sempre que necessário", "Nada, basta esperar a saída"]', 0, 68),

    ('Como devem ser as ligações elétricas dos equipamentos usados dentro do espaço confinado?',
     '["Comuns, ligadas em qualquer tomada", "Alimentadas em baixa tensão de segurança ou protegidas conforme a análise de risco, com transformador e tomadas mantidos fora do espaço", "Feitas com emenda dentro do espaço para encurtar o cabo", "Sem aterramento, para evitar faísca"]', 1, 69),

    ('Cilindros de oxigênio e de gás combustível usados em solda podem entrar no espaço confinado?',
     '["Podem, se forem pequenos", "Não: os cilindros ficam fora e apenas as mangueiras entram, sendo retiradas nas paradas", "Podem, se estiverem deitados", "Podem, se a atmosfera estiver limpa"]', 1, 70),

    ('Por que as mangueiras do maçarico devem ser retiradas do espaço nas paradas para refeição?',
     '["Porque um vazamento com ninguém acompanhando pode acumular gás e criar atmosfera explosiva ou deficiente de oxigênio", "Para preservar a borracha", "Porque a norma proíbe deixar ferramentas no local", "Para não sujar"]', 0, 71),

    ('Pintura interna de tanque com tinta à base de solvente exige:',
     '["Apenas manter a porta aberta", "Apenas máscara de pó", "Ventilação eficiente, controle da atmosfera, proteção respiratória com suprimento de ar e eliminação de fontes de ignição", "Apenas óculos de proteção"]', 2, 72),

    ('Vala profunda, poço e galeria em obra podem ser espaços confinados?',
     '["Não, espaço confinado é só tanque e silo", "Sim, quando têm meios limitados de entrada e saída, ventilação insuficiente e podem conter atmosfera perigosa", "Somente se tiverem tampa", "Somente em obras industriais"]', 1, 73),

    ('Por que caixas e redes de esgoto são especialmente perigosas?',
     '["Porque acumulam gás sulfídrico e metano e podem ter falta de oxigênio, matando em poucas respirações", "Porque são escuras", "Porque são estreitas", "Pelo mau cheiro apenas"]', 0, 74),

    ('Em silo com grão armazenado, além do risco de engolfamento, o trabalhador deve saber que:',
     '["Nunca se deve caminhar sobre o produto, e a entrada exige sistema de retenção e o desligamento e bloqueio dos equipamentos de descarga", "Basta pisar nas bordas", "O risco só existe com silo cheio", "O grão é sempre firme para caminhar"]', 0, 75),

    ('Um equipamento foi inertizado com nitrogênio para a parada. O que isso significa para quem entra?',
     '["Que o ambiente ficou mais seguro", "Que a atmosfera é mortal por falta de oxigênio, sem cheiro nem aviso, e a entrada só ocorre após ventilação e medição comprovando condição segura", "Que basta usar máscara com filtro químico", "Que a entrada pode ser rápida, prendendo a respiração"]', 1, 76),

    ('Por que a atmosfera com falta de oxigênio engana tanto?',
     '["Porque provoca dor de cabeça horas antes", "Porque deixa a visão amarelada", "Porque provoca tosse antes de tudo", "Porque não tem cheiro, cor nem sabor e a pessoa perde a consciência em segundos, sem tempo de reagir ou pedir ajuda"]', 3, 77),

    ('Um trabalhador levou máscara descartável do tipo PFF2 para entrar no tanque. Está correto?',
     '["Está, se o serviço for de menos de dez minutos", "Está, porque filtra bem", "Não está: máscara com filtro não fornece oxigênio e não protege em atmosfera deficiente ou imediatamente perigosa à vida", "Está, se ele usar duas ao mesmo tempo"]', 2, 78),

    ('Trabalhador de barba comprida que precisa usar respirador facial vedante:',
     '["Pode usar com fita adesiva no rosto", "Pode usar se molhar a barba antes", "Pode usar normalmente, apertando mais as tiras", "Não obtém vedação adequada, e a empresa deve tratar isso, seja com a retirada da barba, seja com equipamento de outro tipo"]', 3, 79),

    ('Fumar, acender isqueiro ou riscar fósforo perto da abertura do espaço confinado:',
     '["É permitido a partir de dois metros da boca", "É permitido quando a última medição de inflamáveis deu zero", "É permitido ao vigia, que permanece do lado de fora", "É proibido: vapores inflamáveis saem pela abertura e a chama alcança o interior"]', 3, 80),

    ('O trabalhador vai entrar por passagem muito estreita usando conjunto autônomo de respiração nas costas. Qual é o problema?',
     '["O conjunto pode não passar pela abertura e ainda prender na saída de emergência, o que precisa ser previsto na escolha do equipamento e no plano de resgate", "O cilindro pesa e cansa o trabalhador, sem outra consequência", "Nenhum: basta entrar de lado e com calma", "O equipamento autônomo não pode ser usado em espaço confinado"]', 0, 81),

    ('Um trabalhador tem problema de saúde que pode causar desmaio. Sobre a entrada em espaço confinado:',
     '["Pode entrar se avisar o vigia", "A aptidão precisa ser avaliada no exame médico ocupacional, e a atividade só é liberada se ele estiver apto", "Pode entrar com acompanhante", "Pode entrar em espaços rasos"]', 1, 82),

    ('A empresa mudou o processo e passou a usar outro produto químico nos tanques. Em relação ao treinamento:',
     '["É preciso capacitação sobre os novos riscos antes de a equipe voltar a entrar", "Basta comunicar por circular interna", "Basta atualizar a permissão", "Nada muda, o curso já foi feito"]', 0, 83),

    ('O registro do treinamento de espaço confinado deve conter:',
     '["Conteúdo, carga horária, data, nome e qualificação do instrutor e a identificação dos participantes, ficando arquivado pela empresa", "Apenas o nome do curso", "Apenas a assinatura do gerente", "Apenas a lista de presença"]', 0, 84),

    ('Antes de assinar a permissão, o supervisor de entrada verifica:',
     '["Somente a validade dos crachás", "Somente se a equipe está uniformizada", "Se os bloqueios foram feitos, se as medições estão dentro dos limites, se os equipamentos estão disponíveis e se o resgate está pronto", "Somente o horário previsto de término"]', 2, 85),

    ('Ao encerrar o serviço, antes de fechar o espaço confinado, é preciso:',
     '["Conferir que todas as pessoas saíram, retirar ferramentas e materiais e confirmar a contagem com a lista de entrada", "Contar apenas os capacetes na entrada", "Deixar a conferência para o turno seguinte", "Fechar rápido para liberar a área"]', 0, 86),

    ('Por que se controla nominalmente quem entra e quem sai, com horário?',
     '["Para justificar o tempo do serviço ao cliente", "Para calcular o pagamento de horas extras", "Para que, em qualquer emergência, se saiba na hora quantas pessoas estão dentro e quem são", "Para o setor de pessoal"]', 2, 87),

    ('A equipe vai parar para o almoço no meio do serviço. Como fica o espaço confinado?',
     '["Fica com um trabalhador dentro esperando", "Fica sob a guarda do vigia sozinho", "Fica aberto com as ferramentas dentro, para retomar depois", "Todos saem, o acesso é sinalizado e bloqueado, e na volta as condições e as medições são reavaliadas antes da nova entrada"]', 3, 88),

    ('Na troca de turno com serviço em andamento no espaço confinado:',
     '["O supervisor anterior continua respondendo pelo turno seguinte", "Basta trocar o nome na permissão", "A equipe nova entra e a anterior sai por conta própria", "A passagem é formal, com a nova equipe informada das condições, e a permissão é revalidada ou emitida nova conforme o procedimento"]', 3, 89),

    ('Empresa contratada e contratante executam serviços no mesmo espaço confinado. O que precisa ocorrer?',
     '["Os procedimentos precisam ser integrados e as informações de risco compartilhadas, com responsabilidades definidas antes do início", "A contratante se isenta ao contratar", "A contratada assume a permissão sozinha", "Cada uma segue o próprio procedimento sem conversar"]', 0, 90),

    ('Trabalhador identificou que a medição não foi feita e se recusa a entrar. Essa atitude é:',
     '["Insubordinação", "Correta: qualquer trabalhador pode interromper a entrada diante de risco grave e iminente, comunicando o responsável", "Aceitável apenas se ele for o vigia", "Aceitável apenas com autorização do sindicato"]', 1, 91),

    ('Soou o alarme geral de emergência da planta enquanto havia gente dentro do espaço confinado. O que fazer?',
     '["Fechar a tampa para proteger quem está dentro", "Terminar o serviço primeiro", "Retirar imediatamente os trabalhadores e seguir o plano de emergência da unidade", "Aguardar a confirmação do supervisor de produção"]', 2, 92),

    ('A ventilação forçada parou de funcionar durante o serviço. Qual a conduta?',
     '["Continuar, se o serviço estiver quase no fim", "Retirar todos, corrigir a falha, ventilar novamente e só reentrar após nova medição com resultado seguro", "Abrir mais uma tampa e continuar", "Reduzir o número de pessoas dentro"]', 1, 93),

    ('Qual a diferença entre insuflar ar e exaurir o ar do espaço confinado?',
     '["Exaurir só serve para poeira", "Insuflar só serve para calor", "Nenhuma, o efeito é o mesmo", "Insuflar empurra ar limpo para dentro e exaurir retira o ar contaminado, e a escolha depende do contaminante e do formato do espaço"]', 3, 94),

    ('De onde deve vir o ar usado na ventilação do espaço confinado?',
     '["Do interior de outro tanque já ventilado", "Do ar comprimido da fábrica", "De qualquer ponto próximo, para encurtar a mangueira", "De local limpo, longe de escapamento de motor, saída de exaustão e outras fontes de contaminação"]', 3, 95),

    ('Por que a ferrugem dentro de um tanque fechado é um problema de atmosfera?',
     '["Porque solta pó tóxico", "Porque o processo de oxidação consome o oxigênio do ar confinado e pode deixar a atmosfera deficiente", "Porque gera calor excessivo", "Porque danifica o detector"]', 1, 96),

    ('Restos orgânicos em decomposição dentro de um espaço confinado podem:',
     '["Reduzir a temperatura interna", "Apenas provocar mau cheiro", "Consumir oxigênio e gerar gases tóxicos e inflamáveis, criando atmosfera perigosa", "Aumentar a concentração de oxigênio"]', 2, 97),

    ('Soldar dentro de espaço confinado altera a atmosfera porque:',
     '["Aumenta o oxigênio disponível", "Consome oxigênio e gera fumos metálicos e gases, exigindo exaustão local e monitoramento contínuo", "Torna o ar mais seco apenas", "Não altera nada se a solda for pequena"]', 1, 98),

    ('O trabalho vai ocorrer em tanque que armazenava ácido. O EPI precisa considerar:',
     '["Também a proteção da pele e dos olhos, com vestimenta, luva e calçado resistentes ao produto", "Somente o capacete", "Somente a bota de borracha", "Somente a proteção respiratória"]', 0, 99),

    ('Depois de sair de espaço confinado onde havia produto químico, o trabalhador deve:',
     '["Seguir o procedimento de descontaminação e higienização de si e do equipamento, sem levar contaminante para casa ou para o vestiário", "Sacudir a roupa no pátio", "Lavar a roupa junto com a dos colegas", "Guardar a roupa suja no armário e ir embora"]', 0, 100),

    ('O ruído dentro de espaço confinado tende a ser mais crítico porque:',
     '["O barulho vaza para fora", "O som reverbera nas paredes metálicas, aumentando a exposição e dificultando a comunicação com o vigia", "O ouvido funciona pior com pouca luz", "O ruído é sempre menor lá dentro"]', 1, 101),

    ('A umidade dentro do tanque agrava o risco elétrico porque:',
     '["Reduz a resistência do corpo e melhora o contato com as superfícies metálicas, tornando o choque mais grave", "Faz o disjuntor desarmar antes", "Impede o funcionamento da lanterna", "Aumenta a resistência do corpo"]', 0, 102),

    ('Antes de mandar alguém entrar, o supervisor precisa ter certeza de que:',
     '["Existe alguém disponível para o serviço", "A entrada é realmente necessária e não existe alternativa de executar a tarefa por fora do espaço", "O trabalhador aceita entrar", "O serviço será rápido"]', 1, 103),

    ('Qual é a lógica de eliminar a entrada sempre que possível?',
     '["Agilizar a produção", "Reduzir custo de mão de obra", "Se a tarefa puder ser feita sem entrar, com ferramenta remota, câmera ou limpeza por fora, o risco deixa de existir em vez de ser apenas controlado", "Evitar desgaste dos equipamentos"]', 2, 104),

    ('Uma escada portátil apoiada dentro do tanque como único meio de saída é problema porque:',
     '["Enferruja rápido", "Dificulta a passagem da mangueira de ventilação", "Ocupa espaço", "Pode escorregar, cair ou ficar inacessível em emergência, comprometendo a saída rápida e o resgate"]', 3, 105),

    ('A iluminação de emergência ou lanterna individual dentro do espaço serve para:',
     '["Garantir que uma falta de energia não deixe a equipe no escuro, sem enxergar a rota de saída", "Iluminar a área externa", "Substituir a iluminação principal", "Facilitar a leitura da permissão"]', 0, 106),

    ('Sobre o uso de rádio comum, que produz faísca, em espaço confinado com risco de inflamáveis:',
     '["Só podem ser usados equipamentos apropriados para a área classificada, sob risco de ignição da atmosfera", "Pode ser usado se ficar na mão do vigia", "Pode ser usado com o volume baixo", "Pode ser usado normalmente"]', 0, 107),

    ('Uma tarefa exige que dois trabalhadores entrem em espaços vizinhos, ligados entre si. Como tratar?',
     '["Como tarefa comum, sem permissão", "Como duas tarefas independentes", "Como um conjunto: os riscos se comunicam, e a avaliação, o bloqueio e a ventilação precisam considerar a ligação entre eles", "Como uma tarefa só, com um vigia e uma permissão genérica"]', 2, 108),

    ('A empresa mantém a relação dos espaços confinados atualizada quando:',
     '["Nunca precisa atualizar", "Sempre que um novo equipamento é instalado, alterado ou desativado, mantendo o levantamento fiel à realidade da planta", "Apenas a cada cinco anos", "Apenas quando muda o responsável técnico"]', 1, 109),

    ('A sinalização na entrada do espaço confinado precisa deixar claro:',
     '["O nome do supervisor", "O nome do fabricante do tanque", "Que a entrada é proibida sem permissão, alertando quem passa sobre o risco de morte", "A capacidade em litros"]', 2, 110),

    ('Uma tampa de espaço confinado foi retirada e o serviço não começou ainda. O que fazer com a abertura?',
     '["Cobrir com papelão", "Colocar uma placa a dez metros de distância", "Deixar aberta, agiliza", "Proteger e sinalizar a abertura para evitar queda de pessoas e materiais e impedir entrada não autorizada"]', 3, 111),

    ('Quem pode ser vigia de espaço confinado?',
     '["Trabalhador capacitado para a função, que conhece a tarefa, os riscos, os meios de comunicação e o plano de emergência", "Apenas quem já entrou no espaço antes", "O motorista da equipe, enquanto espera", "Qualquer pessoa disponível no momento"]', 0, 112),

    ('Um trabalhador quer entrar rapidamente só para buscar uma ferramenta esquecida. O correto é:',
     '["Entrar com o vigia junto", "Entrar prendendo a respiração", "Entrar rápido, sem permissão, já que é coisa de segundos", "Tratar como qualquer outra entrada, com permissão válida, medição e vigia"]', 3, 113),

    ('Uma medição indicou oxigênio em 19,0%. Como interpretar?',
     '["Valor abaixo do mínimo aceito, indicando que algo consumiu ou deslocou o oxigênio: é preciso ventilar e investigar antes de qualquer entrada", "Valor alto demais, com risco de explosão", "Valor irrelevante para a decisão", "Valor confortável, pode entrar"]', 0, 114),

    ('Concentração de oxigênio acima da faixa segura aumenta o risco de:',
     '["Sonolência", "Incêndio e combustão violenta de materiais e roupas, que queimam com muito mais facilidade", "Falta de ar", "Nada, quanto mais oxigênio melhor"]', 1, 115),

    ('Alguém sugeriu deixar um cilindro de oxigênio vazando devagar para melhorar o ar do tanque. A resposta é:',
     '["Aceitável se o cilindro ficar fora", "Aceitável se a vazão for baixa", "Boa ideia para conforto da equipe", "Jamais: enriquecer a atmosfera com oxigênio cria risco grave de incêndio e explosão, e a ventilação se faz com ar"]', 3, 116),

    ('Sobre a posição da mangueira de insuflação dentro do espaço:',
     '["Deve alcançar a região onde o trabalhador está e o local onde o contaminante se acumula, renovando o ar de toda a área ocupada", "Deve ficar sempre na parte de cima", "Deve ficar sempre encostada na parede", "Basta apontar para a boca do espaço"]', 0, 117),

    ('Gases mais pesados que o ar tendem a se acumular:',
     '["Somente perto da abertura", "No topo do espaço", "No fundo e nas partes baixas, como poços e recessos, mesmo quando a medição na boca dá resultado bom", "Distribuídos por igual"]', 2, 118),

    ('Trabalhador entrou, sentiu cheiro forte e voltou dizendo que passa depois de um tempo. Como agir?',
     '["Deixar continuar, o corpo se acostuma", "Interromper, medir de novo e investigar a fonte: acostumar com o cheiro é sinal de que o olfato deixou de avisar", "Fornecer máscara de pó e continuar", "Trocar de trabalhador"]', 1, 119),

    ('Sobre a carga horária e o conteúdo do treinamento de trabalhadores autorizados e vigias:',
     '["Basta assistir a um vídeo", "É o mesmo treinamento do supervisor", "Vale qualquer curso de segurança", "O treinamento é específico, com conteúdo e prática compatíveis com a função de cada um, incluindo uso dos equipamentos e simulação de resgate"]', 3, 120),

    ('Um trabalhador capacitado mudou de setor e agora vai atuar como vigia. O que é necessário?',
     '["Apenas anotação no crachá", "Apenas autorização verbal", "Nada, o certificado anterior serve para tudo", "Capacitação para a função de vigia, com as responsabilidades e as ações de emergência daquela função"]', 3, 121),

    ('Sobre o uso do celular pelo vigia durante o serviço:',
     '["Permitido se o trabalhador dentro autorizar", "Livre, se ele estiver sentado", "Deve ser evitado: qualquer distração reduz a chance de perceber a tempo que algo aconteceu lá dentro", "Permitido para assuntos de trabalho apenas em videochamada"]', 2, 122),

    ('A tarefa foi liberada para quatro horas, mas o serviço vai passar disso. Como proceder?',
     '["Continuar até terminar", "Encerrar a permissão, reavaliar as condições e emitir nova permissão antes de continuar", "Riscar o horário e escrever outro", "Pedir ao vigia para autorizar a extensão"]', 1, 123),

    ('Trabalhador dentro do espaço parou de responder ao chamado do vigia. Qual a primeira ação do vigia?',
     '["Ir buscar o supervisor", "Entrar imediatamente para ver o que houve", "Acionar o alarme e a equipe de resgate e iniciar a retirada pelos meios externos, sem entrar", "Aguardar alguns minutos e chamar de novo"]', 2, 124),

    ('Por que se treina o resgate com o mesmo equipamento e no mesmo espaço em que se trabalha?',
     '["Para testar a resistência do tripé", "Para desgastar menos o equipamento novo", "Porque no dia real não haverá tempo de aprender: a equipe precisa conhecer as passagens, os pontos e as limitações daquele espaço", "Para cumprir a carga horária do curso"]', 2, 125),

    ('Uma pessoa foi vista entrando em espaço confinado sem permissão. A conduta correta de quem viu é:',
     '["Anotar e relatar na reunião mensal", "Tirar foto para a comissão de segurança", "Não se meter, porque não é do seu setor", "Interromper imediatamente, chamar a pessoa de volta e comunicar o responsável"]', 3, 126),

    ('A empresa quer reduzir custo dispensando o vigia em entradas curtas. Essa decisão:',
     '["É inaceitável: a vigilância permanente é uma das principais barreiras contra a morte em espaço confinado", "É aceitável em espaços com boa ventilação natural", "Depende do tamanho do espaço", "É aceitável se o trabalhador for experiente"]', 0, 127),

    ('Ao inspecionar o cinturão e o cabo de içamento antes da entrada, procura-se:',
     '["Cortes, desgaste, fios rompidos, costuras abertas, corrosão e deformação em fivelas e conectores", "Somente a cor da fita", "Somente o nome do fabricante", "Somente sujeira"]', 0, 128),

    ('O guincho do tripé precisa ser:',
     '["De qualquer modelo, desde que levante peso", "Apropriado para elevação de pessoas, com capacidade compatível e mantido conforme a orientação do fabricante", "Improvisado com talha de corrente comum", "Substituído por corda com nó"]', 1, 129),

    ('O espaço confinado tem passagem estreita que dificulta a retirada de uma pessoa desacordada. Isso deve:',
     '["Impedir qualquer serviço no local", "Ser resolvido no momento da emergência", "Constar da análise de risco e do plano de resgate, definindo técnica, equipamento e equipe compatíveis com aquela passagem", "Ser ignorado, já que ninguém desmaia sempre"]', 2, 130),

    ('Sobre trabalhar sozinho na área externa enquanto alguém está dentro do espaço:',
     '["É aceitável se houver rádio", "Não é: além do vigia, é preciso haver como acionar ajuda e executar o resgate, o que uma pessoa sozinha não garante", "É aceitável em serviço de inspeção", "É aceitável se o trabalhador dentro for experiente"]', 1, 131),

    ('A medição contínua durante o serviço é importante porque:',
     '["O detector precisa gastar bateria", "A atmosfera pode mudar durante a tarefa, por causa do próprio serviço, de resíduo remexido ou de falha na ventilação", "A norma exige registro de hora em hora", "O supervisor precisa de dados para o relatório"]', 1, 132),

    ('Ao remover borra e resíduo do fundo de um tanque, o risco que aumenta é:',
     '["Somente o de danificar o equipamento", "Somente o de escorregar", "A liberação de gases e vapores retidos no material, que pode alterar a atmosfera de repente", "Somente o de sujar o uniforme"]', 2, 133),

    ('Sobre o uso de produto de limpeza dentro do espaço confinado:',
     '["Pode misturar produtos para limpar melhor", "Basta usar luva", "Pode ser qualquer produto, é só limpeza", "É preciso conhecer a ficha de segurança do produto, pois vapores em ambiente fechado podem intoxicar ou reagir com resíduos existentes"]', 3, 134),

    ('Misturar produtos de limpeza dentro de um espaço fechado pode:',
     '["Melhorar o resultado sem risco", "Reduzir o consumo de água", "Economizar tempo", "Gerar gases tóxicos, como cloro, em concentração perigosa num ambiente sem renovação de ar"]', 3, 135),

    ('Sobre a temperatura do equipamento antes da entrada:',
     '["Basta reduzir o tempo de permanência pela metade", "Não importa, o trabalhador se acostuma", "É preciso aguardar o resfriamento e avaliar o risco térmico, incluindo superfícies quentes e o calor acumulado no interior", "Basta usar luva de raspa"]', 2, 136),

    ('Trabalho em espaço confinado sob sol forte, em tanque metálico, exige atenção a:',
     '["Somente ao uso de boné", "Somente à hidratação", "Sobrecarga térmica, com pausas, hidratação, rodízio e acompanhamento de sinais de mal-estar", "Somente ao horário do almoço"]', 2, 137),

    ('Sinais de intoxicação que o vigia precisa saber reconhecer incluem:',
     '["Somente desmaio", "Fala arrastada, confusão, tontura, dor de cabeça, dificuldade de responder e mudança de comportamento", "Somente vômito", "Somente tosse"]', 1, 138),

    ('Um trabalhador dentro do espaço diz por rádio que está tudo bem, mas fala confuso e repete perguntas. O vigia deve:',
     '["Perguntar mais uma vez para confirmar", "Chamar o supervisor e aguardar orientação", "Confiar no que ele disse", "Determinar a saída imediata: a confusão é sinal clássico de intoxicação ou falta de oxigênio, e a própria pessoa não percebe"]', 3, 139),

    ('Por que a norma exige acompanhamento médico específico para quem trabalha em espaço confinado?',
     '["Porque a atividade exige condição física e psicológica compatível e porque a exposição a agentes precisa ser acompanhada ao longo do tempo", "Porque é exigência do plano de saúde", "Porque o exame substitui a análise de risco", "Para reduzir o absenteísmo"]', 0, 140),

    ('Alguém propôs medir a atmosfera com o detector amarrado na perna do primeiro trabalhador que descer. A avaliação correta:',
     '["Errada: a medição precisa acontecer antes da entrada, sem expor ninguém, e continuar durante todo o serviço", "Aceitável se ele descer devagar", "Aceitável se o detector for novo", "Boa ideia, economiza tempo"]', 0, 141),

    ('Sobre a responsabilidade do empregador nos trabalhos em espaço confinado:',
     '["Fica limitada a fornecer o detector", "Inclui identificar os espaços, implantar procedimentos, capacitar, fornecer equipamentos, garantir o resgate e impedir entrada sem permissão", "Fica limitada a contratar empresa especializada", "Se encerra com a assinatura da permissão"]', 1, 142),

    ('Sobre a responsabilidade do trabalhador autorizado:',
     '["Assumir a função de vigia quando faltar gente", "Liberar a permissão quando o supervisor não estiver", "Decidir sozinho quando entrar", "Cumprir os procedimentos, usar corretamente os equipamentos, comunicar riscos e sair imediatamente quando determinado ou ao perceber alteração"]', 3, 143),

    ('Se a permissão foi emitida mas o resgate não está disponível naquele momento:',
     '["A entrada pode ocorrer, porque a permissão já está assinada", "A entrada não pode ocorrer: a disponibilidade do resgate é condição para a entrada, e a permissão deixa de ser válida sem ela", "A entrada pode ocorrer com menos pessoas", "A entrada pode ocorrer com o vigia treinado em primeiros socorros"]', 1, 144),

    ('Uma boa análise de risco de espaço confinado considera também:',
     '["Apenas a temperatura", "Apenas o histórico de acidentes da empresa", "Apenas os gases esperados", "Os riscos do próprio serviço, como solda, corte, produtos químicos e ruído, além dos riscos do espaço e do que está em volta"]', 3, 145),

    ('Por que dizer que espaço confinado é o risco que mais mata quem vai socorrer?',
     '["Porque o socorro demora a chegar", "Porque os socorristas são despreparados", "Porque a maior parte das mortes ocorre com quem entra por impulso para ajudar e é vencido pela mesma atmosfera", "Porque o equipamento de resgate falha muito"]', 2, 146),

    ('Um espaço com boa ventilação natural e portas largas, mas com produto químico armazenado:',
     '["Depende apenas do tamanho", "Nunca será espaço confinado", "Precisa ser avaliado: a classificação depende do conjunto de meios de entrada e saída, ventilação e possibilidade de atmosfera perigosa", "Será sempre espaço confinado"]', 2, 147),

    ('A empresa terceirizou a limpeza de tanques. Sobre a fiscalização do serviço:',
     '["A contratante só responde se houver acidente com empregado próprio", "Basta exigir o certificado do curso na entrada", "A contratante não precisa acompanhar", "A contratante deve garantir que a contratada cumpra a norma, fornecendo informações dos riscos e acompanhando as condições de segurança"]', 3, 148),

    ('Antes de qualquer entrada, a pergunta que resume o cuidado central da norma é:',
     '["É possível fazer sem entrar e, se não for, a atmosfera está segura, as energias estão bloqueadas, o vigia está no posto e o resgate está pronto?", "Quem é o trabalhador mais magro da equipe?", "O supervisor já assinou o cartão de ponto?", "Quanto tempo vai demorar o serviço?"]', 0, 149),

    ('A frase que melhor resume o comportamento esperado de quem trabalha em espaço confinado é:',
     '["Quem tem prática consegue avaliar o ar pelo cheiro", "Nenhuma entrada sem permissão, nenhuma permissão sem medição e resgate prontos, nenhuma dúvida resolvida entrando para ver", "Serviço rápido dispensa formalidade", "O vigia resolve qualquer emergência sozinho"]', 1, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-33';


-- =====================================================================
--  NR-35-REC — Trabalho em altura, RECICLAGEM (questões 41 a 150)
--  Quem faz esta prova já passou pelo curso inicial e trabalha em altura.
--  Por isso nada de introdução: aqui se cobra escolha de ancoragem, fator
--  de queda na prática, resgate ensaiado, inspeção e descarte de EPI,
--  plataforma, andaime e as decisões de quem já tem prática e por isso
--  mesmo começa a pular etapa.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-35-REC')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('No cálculo da distância necessária abaixo do trabalhador, o que precisa ser somado?',
     '["O comprimento do talabarte, a abertura do absorvedor de energia, a altura do trabalhador abaixo do ponto de conexão e uma folga de segurança", "Apenas a altura do trabalhador", "Apenas a distância até o piso inferior", "Apenas o comprimento do talabarte"]', 0, 41),

    ('Na prática, o que reduz o fator de queda de um sistema?',
     '["Usar talabarte mais comprido", "Ancorar acima do nível do ombro e manter o talabarte o mais esticado possível, sem folga", "Ancorar abaixo dos pés para ter mais liberdade", "Trabalhar mais rápido"]', 1, 42),

    ('O que é o efeito pêndulo e por que ele preocupa?',
     '["É a vibração do cabo de aço quando alguém sobe", "É o giro do mosquetão dentro da argola", "É a oscilação do andaime com vento, que solta a amarração", "É o balanço lateral após a queda quando a ancoragem está deslocada da vertical, podendo lançar o trabalhador contra estrutura ou parede"]', 3, 43),

    ('Como se reduz o risco de efeito pêndulo?',
     '["Usando talabarte com absorvedor mais longo", "Mantendo a ancoragem o mais próximo possível da vertical em relação ao ponto de trabalho, ou usando linha de vida que acompanhe o deslocamento", "Descendo mais devagar", "Amarrando o talabarte no cinto do colega"]', 1, 44),

    ('Trava-quedas retrátil usado na horizontal, com a fita passando sobre uma quina metálica:',
     '["Exige modelo apropriado para uso horizontal e proteção de borda, pois a quina pode cortar a fita durante a queda", "Só precisa de mais folga no cabo", "Pode ser usado se a fita for de aço", "Funciona igual ao uso vertical"]', 0, 45),

    ('Trava-quedas retrátil conectado em ponto abaixo do dorsal do trabalhador:',
     '["É a instalação preferida", "Aumenta a distância de queda livre e o esforço sobre o corpo, e só é aceitável em equipamento projetado para essa condição", "Não muda nada no desempenho", "Reduz o fator de queda"]', 1, 46),

    ('No trava-quedas deslizante que corre em corda, o cuidado durante o uso é:',
     '["Manter o dispositivo abaixo da cintura, para não atrapalhar o movimento", "Manter o dispositivo acima, com o mínimo de folga, e nunca segurá-lo com a mão nem travá-lo, o que impediria a atuação na queda", "Prender o dispositivo com fita para ele não descer sozinho", "Usar o dispositivo em corda de qualquer diâmetro"]', 1, 47),

    ('A gaiola de proteção da escada tipo marinheiro:',
     '["Dispensa o cinto se a escada tiver menos de 10 metros", "Serve como ponto de ancoragem", "Substitui o sistema de proteção contra queda", "Não é sistema de retenção de queda: continua sendo necessário o trava-quedas ligado à linha de vida"]', 3, 48),

    ('Quantas pessoas podem usar simultaneamente um vão de linha de vida horizontal?',
     '["Quantas couberem no vão", "O número previsto no projeto do sistema, porque a carga e a flecha foram calculadas para isso", "Sempre duas", "Não há limite, o cabo é de aço"]', 1, 49),

    ('O que é a flecha de uma linha de vida horizontal e por que ela importa?',
     '["É a curvatura do cabo sob carga, que aumenta a distância de queda e precisa entrar no cálculo da zona livre", "É a marca pintada no cabo indicando o meio do vão", "É a folga da amarração na extremidade", "É o ângulo do cabo em relação ao piso"]', 0, 50),

    ('A linha de vida e os pontos de ancoragem instalados na obra devem ter:',
     '["Apenas a nota fiscal do material", "Apenas a inspeção do montador do andaime", "Apenas a aprovação verbal do encarregado", "Projeto e responsabilidade técnica de profissional legalmente habilitado, com registro"]', 3, 51),

    ('Uma cinta de ancoragem passada em torno de uma viga com quina viva precisa:',
     '["Ser substituída por corda de náilon", "Ser apertada com força para não escorregar", "Receber proteção de borda, porque a quina corta a fita quando a carga é aplicada", "Ser dobrada duas vezes"]', 2, 52),

    ('Sobre o laço estrangulado da cinta de ancoragem em torno da estrutura:',
     '["Reduz a capacidade de carga da cinta em relação ao uso direto e precisa ser considerado na escolha do equipamento", "Não altera nada", "Só pode ser usado em cinta de aço", "Aumenta a resistência da cinta"]', 0, 53),

    ('Um colega vai ancorar na tubulação de sprinkler porque é o ponto mais cômodo. Qual a avaliação?',
     '["Inaceitável: tubulações não foram projetadas para receber carga de queda, e a ancoragem precisa ser definida por quem tem competência técnica", "Aceitável se o tubo for de aço grosso", "Aceitável se a queda for de pouca altura", "Aceitável, tubulação é estrutura firme"]', 0, 54),

    ('Por que o plano de resgate não pode depender apenas do socorro público?',
     '["Porque falta equipamento de altura no corpo de bombeiros", "Porque o serviço público cobra pelo atendimento", "Porque o tempo de acionamento e chegada costuma superar o tempo que o trabalhador suporta suspenso pelo cinto", "Porque o socorro público não atende em obra"]', 2, 55),

    ('Quais sinais indicam o trauma da suspensão em trabalhador que ficou pendurado?',
     '["Apenas formigamento nas mãos", "Apenas aumento da temperatura corporal", "Apenas dor no ombro", "Palidez, suor, náusea, tontura, visão turva, queda da pressão e perda de consciência"]', 3, 56),

    ('Para que serve o estribo ou fita de alívio que alguns cintos possuem?',
     '["Para prender ferramentas", "Para o trabalhador suspenso apoiar os pés e movimentar as pernas, retardando os efeitos da suspensão inerte", "Para facilitar a subida por corda", "Para ajustar o cinto na cintura"]', 1, 57),

    ('Além do resgate por terceiros, o que a equipe treinada deve considerar?',
     '["Somente o resgate com escada Magirus", "Somente aguardar o socorro externo", "Nada, o resgate é sempre feito por outros", "A possibilidade de autorresgate ou de resgate pelo próprio colega da equipe, quando previsto e treinado, porque encurta muito o tempo de suspensão"]', 3, 58),

    ('Onde deve ficar o kit de resgate durante o trabalho em altura?',
     '["Guardado com o técnico de segurança em outra unidade", "No almoxarifado, para não estragar", "Disponível na frente de serviço, com equipe treinada para usá-lo de imediato", "No veículo da empresa, estacionado fora da obra"]', 2, 59),

    ('Com que frequência a equipe deve exercitar o resgate em altura?',
     '["Somente no curso inicial", "Periodicamente, com simulados que testem equipamentos, tempo de resposta e a técnica no local real de trabalho", "Somente quando ocorre um acidente", "Somente quando a empresa troca de fornecedor de EPI"]', 1, 60),

    ('Quem participa da elaboração da análise de risco do trabalho em altura?',
     '["Somente o setor de compras", "Os profissionais responsáveis pela atividade, com participação de quem vai executar, que conhece as condições reais do local", "Somente o cliente contratante", "Somente o instrutor do curso"]', 1, 61),

    ('Durante a tarefa, o vento aumentou e a plataforma começou a oscilar. A análise de risco:',
     '["Só é revista no dia seguinte", "Só muda se o supervisor determinar", "Continua válida, porque foi assinada de manhã", "Precisa ser reavaliada, com interrupção do serviço enquanto a condição não for segura"]', 3, 62),

    ('Em que situações a permissão de trabalho em altura é cancelada?',
     '["Quando muda a condição prevista, quando surge situação de risco não avaliada ou quando termina a validade ou a tarefa", "Somente quando ocorre acidente", "Somente quando o supervisor pede", "Somente ao fim do expediente"]', 0, 63),

    ('Quem assina a permissão de trabalho em altura?',
     '["Os responsáveis definidos no procedimento, entre eles quem libera a área e quem executa, cada um pela parte que lhe cabe", "Apenas o técnico de segurança, sozinho", "Apenas o engenheiro, uma vez por mês", "Apenas o trabalhador que executa"]', 0, 64),

    ('Ao encerrar a tarefa em altura, o que se espera da equipe?',
     '["Deixar as proteções removidas se o serviço continuar amanhã", "Comunicar apenas ao final da semana", "Sair e deixar o material no local para o dia seguinte", "Encerrar formalmente a permissão, retirar equipamentos e materiais, recompor as proteções coletivas removidas e devolver a área em condição segura"]', 3, 65),

    ('Uma proteção coletiva, como guarda-corpo, foi retirada para permitir o serviço. O correto é:',
     '["Substituir por fita zebrada em definitivo", "Avisar por rádio e seguir", "Deixar retirada até o fim da obra", "Manter medida compensatória enquanto durar a remoção e recolocar a proteção assim que a tarefa terminar"]', 3, 66),

    ('Qualquer trabalhador da equipe pode interromper o trabalho em altura quando:',
     '["Somente após consultar o setor de segurança por escrito", "Nunca, só o supervisor pode", "Identificar risco grave e iminente, comunicando imediatamente o responsável", "Somente se estiver com o certificado em mãos"]', 2, 67),

    ('Sobre a operação de plataforma elevatória com vento acima do limite indicado pelo fabricante:',
     '["Pode operar se houver dois trabalhadores na cesta", "Pode operar se a plataforma estiver apoiada em parede", "Pode operar com a lança recolhida pela metade", "Deve ser interrompida, pois o limite de vento faz parte das condições de estabilidade do equipamento"]', 3, 68),

    ('Superfície molhada em telhado ou plataforma após a chuva:',
     '["Não muda nada se o calçado for novo", "Aumenta muito o risco de escorregão e exige reavaliação da tarefa e, quando necessário, interrupção", "Só é problema em telha metálica", "Melhora a aderência da sola de borracha"]', 1, 69),

    ('Trabalho em altura no período noturno exige atenção especial a:',
     '["Iluminação adequada da área e do acesso, além do agravamento da fadiga e da menor percepção do entorno", "Somente ao aumento do ruído", "Somente ao pagamento do adicional", "Somente ao horário de intervalo"]', 0, 70),

    ('Serviço prolongado sobre telhado sob sol forte exige:',
     '["Apenas protetor solar", "Apenas iniciar mais cedo, sem outras medidas", "Apenas boné", "Hidratação, pausas, revezamento e atenção a sinais de mal-estar, que em altura podem provocar queda"]', 3, 71),

    ('Além da inspeção antes de cada uso, os equipamentos de proteção contra queda passam por:',
     '["Inspeção somente após um acidente", "Nada mais, a inspeção diária basta", "Inspeção periódica registrada, feita por pessoa capacitada conforme o procedimento da empresa e a orientação do fabricante", "Inspeção apenas quando são comprados"]', 2, 72),

    ('Um cinto foi reprovado na inspeção. O que se faz com ele?',
     '["Usar apenas em treinamento prático com carga", "Guardar separado para uso em emergência", "Inutilizar, cortando as fitas, e descartar, para que ninguém volte a usá-lo por engano", "Doar para outro setor"]', 2, 73),

    ('Sobre a vida útil dos equipamentos de proteção contra queda:',
     '["Seguem a validade e as condições definidas pelo fabricante, além da avaliação do estado real de conservação", "Duram enquanto o Certificado de Aprovação estiver ativo", "Duram cinco anos em qualquer condição", "Duram para sempre se não forem usados"]', 0, 74),

    ('A etiqueta do cinto está ilegível e não se consegue ler número de série nem data. O equipamento:',
     '["Pode ser usado até a próxima inspeção periódica", "Pode ser usado se estiver visualmente bom", "Deve ser retirado de uso, pois não é possível confirmar identificação, validade e rastreabilidade", "Pode ser usado com etiqueta escrita à mão"]', 2, 75),

    ('Um talabarte recebeu respingo de solda e apresenta pontos queimados na fita. A conduta é:',
     '["Continuar usando, pois a queimadura é superficial", "Usar apenas como talabarte de posicionamento", "Cortar a parte queimada e costurar", "Retirar de uso e substituir, porque o dano térmico compromete a resistência da fita"]', 3, 76),

    ('Sobre a limpeza do cinto e das cordas:',
     '["Não lavar nunca, para não perder a resistência", "Lavar com solvente e escova de aço", "Seguir a orientação do fabricante, geralmente com água e sabão neutro, secando à sombra e longe de fonte de calor", "Lavar na máquina com água quente e alvejante"]', 2, 77),

    ('Sobre o mosquetão com trava de rosca durante o uso:',
     '["A rosca precisa estar completamente fechada, e o conector deve ser conferido durante o serviço porque a rosca afrouxa com o movimento", "A rosca só precisa ser fechada em altura acima de 10 metros", "Basta apertar a rosca com alicate", "A rosca pode ficar solta, pois o gatilho já segura"]', 0, 78),

    ('Por que o mosquetão deve receber carga no eixo maior, com a trava fechada?',
     '["Porque é a única forma de encaixar", "Porque o fabricante prefere assim por estética", "Para ficar mais fácil de abrir", "Porque a resistência com carga no eixo menor ou com a trava aberta cai muito e pode romper na queda"]', 3, 79),

    ('Conectar um mosquetão diretamente em outro mosquetão:',
     '["Deve ser evitado, pois pode gerar carga em posição indevida e abertura acidental da trava", "Só é problema com mosquetão de alumínio", "É recomendado para facilitar a troca de ponto", "É prática correta para ganhar comprimento"]', 0, 80),

    ('Fazer um nó em uma corda de trabalho em altura:',
     '["Aumenta a resistência da corda", "Reduz a resistência da corda no ponto do nó e só deve ser feito quando previsto na técnica, com o nó adequado", "Não altera a resistência", "É proibido em qualquer situação"]', 1, 81),

    ('Emendar dois talabartes para alcançar um ponto mais distante:',
     '["É aceitável se os dois forem do mesmo fabricante", "É aceitável se houver absorvedor nos dois", "É solução aceitável em serviço rápido", "É inaceitável: aumenta a queda livre e o sistema deixa de ter o desempenho para o qual foi ensaiado"]', 3, 82),

    ('No uso do talabarte duplo em Y durante o deslocamento, o correto é:',
     '["Conectar as duas pernas sempre no mesmo ponto", "Manter sempre uma perna conectada enquanto a outra muda de ponto, garantindo conexão contínua", "Desconectar as duas para andar mais rápido em trechos curtos", "Conectar uma perna no cinto do colega"]', 1, 83),

    ('Conectar a perna livre do talabarte duplo em uma argola do próprio cinto durante o deslocamento:',
     '["É recomendado para reduzir o fator de queda", "É indiferente", "É sempre correto, evita que fique balançando", "Só é aceitável em ponto do cinto previsto pelo fabricante para essa finalidade, pois um ponto qualquer pode não suportar a carga da queda"]', 3, 84),

    ('Para que serve a argola dorsal do cinturão tipo paraquedista?',
     '["Para içar ferramentas", "Para prender a corda de sinalização", "Para posicionamento no poste", "Para conexão do sistema de retenção de queda, mantendo o corpo em posição adequada após a queda"]', 3, 85),

    ('As argolas laterais do cinturão servem para:',
     '["Retenção de queda", "Posicionamento no trabalho, com o talabarte de posicionamento, e nunca sozinhas como sistema de retenção de queda", "Içamento de pessoas", "Conexão do trava-quedas retrátil"]', 1, 86),

    ('A argola ventral, na frente do cinturão, é usada tipicamente para:',
     '["Guardar o rádio", "Retenção de queda em telhado", "Progressão e suspensão em acesso por corda e em sistemas de içamento, conforme o projeto do equipamento", "Fixação da linha de vida horizontal"]', 2, 87),

    ('No acesso por corda, o princípio básico é:',
     '["Uma corda basta, se for nova", "Dois sistemas independentes, o de progressão e o de segurança, cada um capaz de sustentar o trabalhador", "Três cordas sempre", "Uma corda e um colega segurando embaixo"]', 1, 88),

    ('Antes de usar plataforma elevatória, o operador deve:',
     '["Fazer a verificação diária conforme o checklist, incluindo comandos, parada de emergência, pneus, estabilizadores e vazamentos", "Verificar apenas o nível de combustível", "Confiar na inspeção do mês anterior", "Ligar e subir direto, se a máquina estiver na obra"]', 0, 89),

    ('Sobre o piso onde a plataforma elevatória vai operar:',
     '["Só importa se a elevação passar de 10 metros", "Qualquer terreno serve, o equipamento se ajusta sozinho", "Precisa ser avaliado quanto a resistência, nivelamento, buracos, valas e tampas frágeis, com uso dos estabilizadores quando previstos", "Basta estar seco"]', 2, 90),

    ('A cesta da plataforma elevatória tem carga máxima indicada. Ela considera:',
     '["O peso das pessoas, das ferramentas e dos materiais, e não pode ser excedida em nenhuma hipótese", "Somente o peso dos materiais", "Um valor médio, que admite folga de 20 por cento", "Somente o peso dos trabalhadores"]', 0, 91),

    ('Para que serve o comando de emergência situado na base da plataforma elevatória?',
     '["Para desligar o motor ao fim do dia", "Para o supervisor controlar o serviço", "Para permitir a descida do trabalhador por outra pessoa em caso de falha ou emergência na cesta", "Para movimentar a máquina no pátio"]', 2, 92),

    ('Quem pode operar plataforma elevatória de trabalho?',
     '["O motorista que trouxe a máquina", "Qualquer trabalhador autorizado para altura", "Trabalhador capacitado para operar aquele equipamento, além de atender aos requisitos de trabalho em altura", "O mais experiente da equipe, mesmo sem treinamento no equipamento"]', 2, 93),

    ('A montagem, a alteração e a desmontagem de andaime devem ser feitas:',
     '["Por trabalhador qualificado, sob supervisão e responsabilidade de profissional habilitado", "Pelo próprio pessoal que vai usar o andaime, sem supervisão", "Pelo fornecedor apenas na primeira montagem", "Por qualquer trabalhador disponível na obra"]', 0, 94),

    ('Uma prancha do piso do andaime está solta e outra falta. A conduta é:',
     '["Colocar uma tábua qualquer no lugar", "Sinalizar o vão com fita e continuar", "Trabalhar pisando com cuidado nas que restam", "Não usar o andaime até que o piso esteja completo, fixado e sem vãos"]', 3, 95),

    ('Sobre o andaime móvel, aquele com rodízios:',
     '["Pode ser deslocado empurrando pela plataforma superior", "Pode ser deslocado com trabalhador em cima, se for devagar", "Só pode ser deslocado sem ninguém e sem material solto sobre ele, e os rodízios ficam travados durante o uso", "Dispensa travamento dos rodízios se o piso for plano"]', 2, 96),

    ('A relação entre a altura e a base do andaime simplesmente apoiado importa porque:',
     '["Define quantos trabalhadores podem subir", "Define a cor da sinalização", "Define o preço do aluguel", "Acima de determinada proporção o andaime perde estabilidade e precisa ser ancorado à estrutura ou ter a base ampliada"]', 3, 97),

    ('Usar o andaime como ponto de ancoragem do cinto:',
     '["É prática correta, porque o andaime é estrutura metálica", "Só é possível quando o andaime foi projetado e verificado para receber a carga de uma queda, o que não é a regra", "É aceitável se o andaime estiver amarrado à parede", "É aceitável em andaime de até 6 metros"]', 1, 98),

    ('No balancim, além do trava-quedas ligado a cabo independente, é preciso verificar:',
     '["Somente a limpeza da plataforma", "Somente o rádio de comunicação", "Somente o funcionamento do motor", "Estado dos cabos de sustentação, dos dispositivos de segurança, da estrutura de fixação na cobertura e os contrapesos, conforme o projeto"]', 3, 99),

    ('Sobre a carga e o número de pessoas no balancim:',
     '["O limite pode ser excedido em serviço rápido", "Cabe quem couber, se a plataforma for longa", "Deve respeitar o limite do projeto, contando pessoas, ferramentas e materiais", "O limite vale só para materiais"]', 2, 100),

    ('Em trabalho sobre telhado, além das tábuas de circulação, o sistema de proteção contra queda deve:',
     '["Ser dispensado se o telhado tiver pouca inclinação", "Ter ancoragem definida em projeto, considerando a resistência da estrutura e o percurso do trabalhador até a cumeeira", "Ser ancorado na própria telha", "Ser ancorado na calha"]', 1, 101),

    ('Telhas metálicas em dia de sol forte apresentam um risco adicional:',
     '["Ficam muito quentes e escorregadias, provocando queimadura no contato e favorecendo o escorregão", "Perdem resistência mecânica pela metade", "Aumentam o risco elétrico", "Refletem luz e cansam a vista apenas"]', 0, 102),

    ('Em torre de telecomunicação ou estrutura treliçada, a progressão segura é feita:',
     '["Apenas com o cinto de posicionamento", "Segurando com as mãos e subindo rápido", "Com conexão contínua ao sistema de proteção, usando linha de vida ou talabarte duplo, sem nunca ficar desconectado", "Com um talabarte simples, trocando de ponto sem conexão intermediária"]', 2, 103),

    ('No trabalho em poste, o cinturão de posicionamento:',
     '["Substitui o sistema de retenção de queda", "Mantém o trabalhador na posição de trabalho, mas o sistema de retenção de queda continua necessário", "Só é usado por eletricista de alta tensão", "Dispensa a avaliação da estrutura do poste"]', 1, 104),

    ('Poda de árvore em altura com motosserra exige, além dos requisitos de altura:',
     '["Avaliação dos riscos da própria ferramenta e da queda de galhos, com EPI específico, técnica de corte e isolamento da área abaixo", "Somente luva de raspa", "Somente que o trabalhador seja experiente", "Somente óculos de proteção"]', 0, 105),

    ('Içar pessoas com guindaste, em cesto acoplado:',
     '["Pode ser feito com qualquer caçamba disponível", "É prática comum e liberada", "Só é admitido em situação excepcional, quando não houver alternativa mais segura, com equipamento apropriado, procedimento específico e medidas adicionais de controle", "É proibido em qualquer hipótese"]', 2, 106),

    ('Subir trabalhador em gaiola acoplada ao garfo de empilhadeira comum:',
     '["Não é: a empilhadeira comum não é equipamento para elevação de pessoas, e improvisar gaiola no garfo já causou muitas mortes", "É aceitável se a gaiola for amarrada", "É aceitável se alguém segurar a base", "É aceitável para serviço rápido"]', 0, 107),

    ('A empresa contratante que recebe equipe terceirizada para trabalho em altura deve:',
     '["Apenas liberar a entrada e cobrar o serviço", "Informar os riscos do local, garantir as condições e acompanhar o cumprimento das medidas de segurança", "Assumir a capacitação dos trabalhadores da contratada", "Exigir apenas a nota fiscal do serviço"]', 1, 108),

    ('Sobre a comunicação entre quem está em altura e a equipe que permanece no solo:',
     '["Não é necessária quando o serviço é curto", "Deve ser resolvida com gestos improvisados no momento", "Deve depender do celular pessoal de cada um", "Deve ser definida antes, com meio confiável e sinais combinados, porque ruído e distância impedem a conversa normal e a emergência depende do aviso rápido"]', 3, 109),

    ('Sobre a aptidão para trabalho em altura no exame médico:',
     '["Basta o exame admissional, sem repetição", "É avaliada periodicamente e sempre que houver situação que possa comprometer a saúde do trabalhador", "É avaliada só depois de acidente", "É avaliada apenas para quem trabalha acima de 10 metros"]', 1, 110),

    ('A reciclagem do treinamento de trabalho em altura precisa incluir:',
     '["Conteúdo prático, com uso dos equipamentos e das técnicas empregadas na empresa, além da revisão dos procedimentos", "Somente a leitura da norma atualizada", "Somente a avaliação escrita", "Somente a parte teórica, já que o trabalhador tem prática"]', 0, 111),

    ('Quem pode ministrar o treinamento de trabalho em altura?',
     '["Um representante do fabricante de EPI, sozinho", "Qualquer trabalhador com experiência de campo", "Profissionais capacitados para o assunto, sob responsabilidade de profissional habilitado em segurança do trabalho", "O encarregado da obra"]', 2, 112),

    ('Um trabalhador novo chegou à equipe dizendo ter feito o curso, mas não apresenta certificado. Ele pode subir?',
     '["Não pode: é preciso comprovar a capacitação e ser formalmente autorizado pela empresa antes de executar", "Pode, acompanhado do encarregado", "Pode, se o serviço for de menos de duas horas", "Pode, se disser em que empresa fez"]', 0, 113),

    ('Trabalhador menor de 18 anos em atividade de trabalho em altura:',
     '["Pode, a partir dos 16 anos com autorização dos pais", "Pode, como aprendiz", "Pode, se acompanhado de adulto", "Não pode, por se tratar de atividade considerada perigosa na legislação de proteção ao menor"]', 3, 114),

    ('Um colega da equipe está visivelmente abalado, contando um problema grave de família, e vai subir. O correto é:',
     '["Conversar, comunicar o responsável e avaliar o remanejamento da tarefa, pois a condição emocional afeta a atenção em altura", "Mandar subir com o talabarte curto", "Não interferir, é assunto pessoal", "Deixar subir, o trabalho distrai"]', 0, 115),

    ('Trabalhador em uso de medicamento novo receitado, que pode causar sonolência, deve:',
     '["Comunicar a situação ao responsável e ao serviço médico antes de executar trabalho em altura", "Continuar normalmente, se estiver se sentindo bem", "Reduzir a dose por conta própria", "Tomar o remédio só depois do expediente, por conta própria"]', 0, 116),

    ('Como as proteções coletivas se relacionam com o cinto no trabalho em altura?',
     '["A proteção coletiva só é exigida acima de 6 metros", "O cinto substitui a proteção coletiva", "A proteção coletiva vem primeiro, e o sistema individual é usado quando ela não é viável ou como complemento", "As duas são equivalentes"]', 2, 117),

    ('O guarda-corpo instalado precisa ter, para cumprir a função:',
     '["Apenas fita zebrada esticada entre colunas", "Apenas corda amarrada entre pilares", "Apenas o travessão superior", "Travessão superior, travessão intermediário e rodapé, com resistência compatível com o esforço previsto"]', 3, 118),

    ('Fita zebrada esticada na borda da laje serve como:',
     '["Ancoragem provisória", "Proteção contra queda equivalente ao guarda-corpo", "Apenas sinalização, que avisa mas não retém ninguém", "Proteção suficiente em altura pequena"]', 2, 119),

    ('Materiais e ferramentas próximos à borda da área de trabalho em altura:',
     '["Devem ser mantidos afastados e contidos, porque a queda de objeto atinge quem está abaixo e é causa frequente de acidente grave", "Só precisam de cuidado se forem pesados", "Podem ficar se a área estiver sinalizada com placa", "Podem ficar ali, se ninguém circular embaixo"]', 0, 120),

    ('Um trabalhador usa o capacete sem jugular em trabalho em altura. Qual o problema?',
     '["Nenhum, o capacete fica firme", "Sem a jugular o capacete cai na primeira inclinação ou queda, justamente quando protegeria a cabeça", "A jugular só serve em motocicleta", "A jugular só é exigida em espaço confinado"]', 1, 121),

    ('Antes de iniciar a jornada, o que a equipe deve verificar no local de trabalho em altura?',
     '["Apenas a previsão do tempo", "Apenas se todos estão uniformizados", "Apenas se a chave da sala está disponível", "As condições do acesso, das estruturas, dos pontos de ancoragem, do entorno e o que mudou desde o último dia de serviço"]', 3, 122),

    ('Ao usar linha de vida temporária de fita têxtil instalada pela própria equipe:',
     '["Um nó nas pontas resolve a fixação", "Basta esticar bem entre dois pontos firmes", "É preciso seguir o projeto e as instruções do fabricante quanto a pontos, vãos, tensionamento e número de usuários", "Qualquer viga serve como extremidade"]', 2, 123),

    ('Trabalho em altura sobre superfície com risco de acúmulo de energia elétrica, como próximo a rede:',
     '["Basta usar cinto de fita têxtil", "Basta trabalhar em dia seco", "Cabe somente à equipe de eletricidade se preocupar", "Exige tratamento conjunto dos dois riscos, com desligamento ou isolação da rede antes do serviço em altura"]', 3, 124),

    ('Uma tarefa em altura exige que o trabalhador fique parado em suspensão por bastante tempo. O que considerar?',
     '["Trocar o talabarte por corda", "Nada, o cinto é confortável", "Escolher o equipamento adequado à suspensão, prever apoio para os pés e pausas, e monitorar o trabalhador, pois a suspensão prolongada é nociva mesmo sem queda", "Reduzir a altura da tarefa"]', 2, 125),

    ('O trabalhador percebeu que o colega está com o cinto frouxo, com as tiras das pernas soltas. O que fazer?',
     '["Interromper e ajustar antes da subida, porque no impacto da queda o corpo escorrega dentro do cinto frouxo", "Só é problema se a queda for grande", "Amarrar a tira solta com fita adesiva", "Deixar para comentar no intervalo"]', 0, 126),

    ('Sobre a conexão do talabarte durante a subida e a descida da escada de acesso:',
     '["A proteção só vale ao chegar ao ponto de trabalho", "O risco de queda existe também no acesso, e a proteção precisa acompanhar todo o percurso", "A escada dispensa proteção se tiver corrimão", "Basta subir com as duas mãos livres"]', 1, 127),

    ('O que caracteriza uma boa área de vivência do sistema de proteção, ou seja, a zona livre de queda verificada no local?',
     '["Ser conferida no próprio local, considerando obstáculos, andaimes, estruturas e equipamentos abaixo que o trabalhador possa atingir", "Considerar apenas a distância até o solo", "Ser sempre de 6 metros", "Ser calculada no escritório e nunca conferida em campo"]', 0, 128),

    ('Depois de uma queda, mesmo sem lesão aparente e com o equipamento aparentemente íntegro:',
     '["Basta trocar o mosquetão", "Basta anotar no diário de obra", "O trabalhador volta ao serviço no mesmo turno", "O trabalhador é avaliado clinicamente e o ocorrido é investigado, e o equipamento solicitado sai de uso"]', 3, 129),

    ('Investigar uma queda ou quase queda serve para:',
     '["Encontrar o culpado e aplicar advertência", "Descobrir o que na tarefa, no equipamento, no procedimento e na organização permitiu o acontecido, e corrigir antes que se repita", "Cumprir exigência do seguro apenas", "Justificar o atraso da obra"]', 1, 130),

    ('Um quase acidente em altura, sem ninguém ferido, deve ser:',
     '["Comunicado apenas se houver testemunha", "Registrado somente no fim do mês", "Esquecido, já que não houve dano", "Comunicado e analisado, pois indica uma falha que na próxima vez pode terminar diferente"]', 3, 131),

    ('Sobre içar ferramentas e materiais até o ponto de trabalho:',
     '["Devem ser içados com corda e recipiente apropriado, com a área abaixo isolada", "Podem ser levados no bolso da calça", "Podem ser levados nas mãos durante a subida da escada", "Podem ser lançados de baixo para cima quando são leves"]', 0, 132),

    ('Um trabalhador quer conectar o talabarte na própria linha de vida de outro sistema, de outra empresa, instalada no local. O correto é:',
     '["Usar, já que está instalada e parece firme", "Só usar após confirmar com o responsável do local que o sistema é adequado, está inspecionado e comporta mais um usuário", "Usar se o cabo for de aço", "Usar se ninguém mais estiver conectado"]', 1, 133),

    ('Trabalhar em altura sozinho, sem ninguém para acionar socorro:',
     '["É aceitável quando o trabalhador é experiente", "Deve ser evitado: sem alguém para perceber a queda e acionar o resgate, o tempo de suspensão se torna fatal", "É aceitável em serviço de inspeção rápida", "É aceitável se o celular estiver com sinal"]', 1, 134),

    ('Sobre o uso de celular em altura durante a execução da tarefa:',
     '["Só é problema se o trabalhador estiver em plataforma", "Pode ser usado livremente para fotos do serviço", "Deve ser restrito ao necessário e feito em condição segura, pois a distração e o uso das mãos aumentam o risco de queda", "É proibido levar celular para a altura"]', 2, 135),

    ('O que se espera do supervisor durante o trabalho em altura?',
     '["Assinar a permissão e sair da área", "Delegar a fiscalização ao trabalhador mais antigo", "Somente conferir o resultado do serviço", "Acompanhar as condições, verificar o cumprimento dos procedimentos e interromper a tarefa quando a segurança não estiver garantida"]', 3, 136),

    ('Andaime fachadeiro com prancha de madeira no lugar de uma peça original do fabricante:',
     '["É aceitável se for reforçada com arame", "É aceitável se a madeira for grossa", "Não é aceitável: a substituição por peça não prevista altera o comportamento estrutural avaliado no projeto", "É aceitável em andaime de até três lances"]', 2, 137),

    ('Sobre a escada de acesso interna do andaime:',
     '["É o meio previsto de acesso, e subir pela estrutura externa expõe o trabalhador a queda e não deve ser feito", "Só é usada por quem monta o andaime", "Serve apenas para descer", "Pode ser dispensada, subindo pela estrutura externa"]', 0, 138),

    ('A empresa pretende usar cinto abdominal simples em uma tarefa de posicionamento. A avaliação correta é:',
     '["Aceitável, é mais confortável", "O cinturão tipo paraquedista é o exigido para trabalho em altura, e o cinto abdominal simples não retém queda com segurança", "Aceitável se o trabalhador for leve", "Aceitável em altura menor que 4 metros"]', 1, 139),

    ('Sobre a inspeção do trava-quedas retrátil antes do uso:',
     '["Basta sacudir o equipamento", "Basta verificar se a fita recolhe", "Além do recolhimento, é preciso verificar o travamento com puxada rápida, a integridade da fita ou cabo, o conector e o indicador de impacto", "Basta olhar a etiqueta"]', 2, 140),

    ('Um equipamento apresenta o indicador de impacto acionado. Isso significa que:',
     '["Ele precisa de lubrificação", "Ele está vencido apenas", "Ele foi usado muitas vezes", "Ele já absorveu uma queda e deve ser retirado de uso imediatamente"]', 3, 141),

    ('Sobre guardar cintos e talabartes na caixa de ferramentas junto com serras e brocas:',
     '["É prático e não causa problema", "Deve ser evitado: o contato com ferramenta cortante e com óleo danifica as fitas e compromete o equipamento", "Só é problema se a caixa for de metal", "É aceitável se o equipamento estiver ensacado"]', 1, 142),

    ('Uma chapa de piso ou grade foi removida de uma plataforma industrial para a manutenção. O que é exigido?',
     '["Fechar ou proteger o vão com guarda-corpo e sinalização enquanto durar a abertura, recolocando a chapa ao final", "Apenas avisar quem trabalha naquele setor", "Apenas encostar a chapa ao lado do vão, como aviso", "Apenas contornar o vão com fita zebrada até o fim do serviço"]', 0, 143),

    ('Uma reforma vai ocorrer em prédio ocupado, com moradores circulando. O trabalho em altura na fachada exige:',
     '["Apenas avisar a administração do condomínio", "Isolamento efetivo da área abaixo, sinalização, horários combinados e proteção contra queda de material", "Apenas trabalhar em fins de semana", "Apenas colocar um vigia sem barreira física"]', 1, 144),

    ('Se o procedimento da empresa é mais rigoroso do que a norma exige, o trabalhador deve:',
     '["Pedir para reduzir o procedimento ao mínimo legal", "Seguir apenas o mínimo da norma", "Seguir o procedimento da empresa, que é o compromisso assumido para aquele local e aquela tarefa", "Escolher o que for mais rápido"]', 2, 145),

    ('Um trabalhador experiente diz que faz o serviço há vinte anos sem cinto e nunca caiu. Como responder?',
     '["Concordar, a experiência vale mais que a norma", "Explicar que ausência de acidente não é prova de segurança e que a queda não avisa: o sistema existe para o dia em que a experiência não bastar", "Deixar ele decidir por conta própria", "Pedir que use o cinto só quando houver fiscalização"]', 1, 146),

    ('Por que a reciclagem periódica é exigida mesmo para quem trabalha em altura todos os dias?',
     '["Porque a rotina acomoda, procedimentos e equipamentos mudam, e a prática diária cria atalhos que precisam ser corrigidos", "Porque o certificado precisa de carimbo novo", "Porque a empresa precisa preencher indicador de treinamento", "Para gerar receita para os cursos"]', 0, 147),

    ('Além do prazo periódico, a reciclagem ou novo treinamento é exigida quando:',
     '["A empresa troca de fornecedor de uniforme", "O trabalhador muda de turno", "Há mudança nos procedimentos ou nos equipamentos, retorno de afastamento prolongado, mudança de empresa ou de posto com novos riscos", "O trabalhador completa 40 anos"]', 2, 148),

    ('Se após a reciclagem o trabalhador não demonstrar domínio prático dos equipamentos, a empresa deve:',
     '["Transferi-lo para outra obra da empresa", "Emitir o certificado assim mesmo, já que ele participou", "Não autorizá-lo até que a capacitação seja completada e o desempenho seja adequado", "Autorizá-lo apenas para alturas menores"]', 2, 149),

    ('Qual é a ideia que a reciclagem em trabalho em altura procura reforçar?',
     '["Que a experiência dispensa a conferência diária", "Que a segurança em altura é uma cadeia, e basta um elo relaxado, seja a ancoragem, o conector, a inspeção ou o resgate, para o sistema inteiro falhar", "Que o EPI resolve sozinho o problema da queda", "Que a análise de risco é formalidade de escritório"]', 1, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-35-REC';


-- =====================================================================
--  NR-12 — Segurança no trabalho em máquinas e equipamentos
--  (questões 41 a 150)
--  As 40 primeiras trataram de proteção, parada de emergência e
--  intertravamento. Estas descem ao detalhe do dia a dia: bloqueio de
--  todas as energias, energia acumulada, a máquina específica que o
--  trabalhador opera, a manutenção, a documentação e o improviso que
--  arranca dedo.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-12')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O que se espera de um sistema de segurança de máquina quanto a falhas?',
     '["Que funcione enquanto todos os componentes estiverem bons", "Que a falha de um componente não leve à perda da função de segurança nem crie situação perigosa", "Que seja consertado apenas na parada anual", "Que dependa da atenção do operador para compensar a falha"]', 1, 41),

    ('A chave de segurança da porta tem um atuador que se encaixa nela. Guardar um atuador reserva na gaveta é:',
     '["Boa prática de manutenção", "Burla da proteção: com o atuador reserva qualquer um engana a chave e opera com a porta aberta", "Aceitável se ficar trancado", "Exigência do fabricante"]', 1, 42),

    ('Para que serve a chave de segurança com bloqueio, que só libera a porta depois de um tempo?',
     '["Para impedir a abertura enquanto a máquina ainda tem movimento por inércia, liberando só quando o risco cessa", "Para economizar energia", "Para contar quantas vezes a porta é aberta", "Para dificultar o trabalho do operador"]', 0, 43),

    ('Por que o tempo de parada por inércia importa na escolha do dispositivo de segurança?',
     '["Porque a máquina continua se movendo depois do comando de parada, e a proteção precisa manter o acesso fechado até a parada real", "Porque define a produtividade da máquina", "Porque determina o tamanho da porta", "Porque define o consumo do motor"]', 0, 44),

    ('Um freio de máquina apresenta desgaste e demora mais para parar. Isso significa que:',
     '["Basta reduzir a velocidade de produção", "Só a produção é afetada", "A distância de segurança calculada deixou de valer, e a máquina precisa ser parada para manutenção", "Basta avisar o operador para ter mais cuidado"]', 2, 45),

    ('Onde os dispositivos de parada de emergência devem estar instalados?',
     '["Somente próximo da porta da fábrica", "Somente na sala de manutenção", "Somente no painel principal", "Em locais de fácil acesso e visualização a partir de qualquer posto de operação e das zonas de risco"]', 3, 46),

    ('A parada de emergência substitui a proteção fixa ou o intertravamento?',
     '["Substitui em máquinas pequenas", "Substitui quando o operador é experiente", "Substitui, pois para a máquina na hora", "Não substitui: ela é medida complementar, acionada depois que algo já deu errado"]', 3, 47),

    ('Usar o botão de emergência para parar a máquina no fim de cada ciclo de produção:',
     '["É obrigatório em máquinas automáticas", "É prática recomendada", "Deve ser evitado: o botão é para emergência, e o uso rotineiro desgasta o dispositivo e pode danificar a máquina", "É indiferente"]', 2, 48),

    ('Por que a cortina de luz precisa ser instalada a uma distância mínima da zona de perigo?',
     '["Para não sujar as lentes", "Porque a máquina leva um tempo para parar, e a distância garante que a mão não alcance o perigo antes da parada", "Para facilitar a limpeza do piso", "Para permitir a passagem de empilhadeira"]', 1, 49),

    ('O que é o muting, o bypass temporário de uma cortina de luz?',
     '["Colocar fita nas lentes", "Reduzir a sensibilidade do sensor", "Desligar a cortina quando ela atrapalha a produção", "Uma inibição automática e controlada, prevista em projeto, para permitir a passagem de material sem que a pessoa possa entrar"]', 3, 50),

    ('Um trabalhador contou que costuma inibir a cortina com um comando para agilizar a produção. Isso é:',
     '["Iniciativa de melhoria de processo", "Violação grave da proteção, que deve ser comunicada e corrigida, com apuração de como isso se tornou possível", "Aceitável em produção urgente", "Problema apenas se houver acidente"]', 1, 51),

    ('Para que serve o tapete de segurança instalado no piso em volta de uma célula automatizada?',
     '["Detectar a presença de pessoa na área e comandar a parada segura do equipamento", "Reduzir o ruído da máquina", "Marcar o limite de circulação apenas", "Evitar que o piso escorregue"]', 0, 52),

    ('Qual a diferença entre uma chave fim de curso comum e uma chave de segurança?',
     '["A chave de segurança serve só para portas grandes", "Não há diferença, mudam só o preço e a marca", "A chave de segurança tem construção específica, com abertura positiva e características que garantem a função mesmo com falha, o que a chave comum não oferece", "A chave comum é mais resistente"]', 2, 53),

    ('Numa manutenção com quatro pessoas trabalhando na mesma máquina, o bloqueio correto é:',
     '["Uma etiqueta com o nome da equipe", "Bloqueio do turno, retirado pelo turno seguinte", "Um cadeado do líder da equipe", "Cada trabalhador coloca o seu cadeado, geralmente com caixa de bloqueio, e a máquina só é liberada quando o último retirar o dele"]', 3, 54),

    ('Depois de desligar e bloquear a energia elétrica, o que ainda pode manter a máquina perigosa?',
     '["Apenas o calor do motor", "Apenas a poeira acumulada", "Nada, o bloqueio elétrico resolve tudo", "Energia acumulada em ar comprimido, óleo hidráulico, molas, capacitores e peças suspensas pela gravidade"]', 3, 55),

    ('Para trabalhar sob uma parte da máquina que fica suspensa, como o martelo de uma prensa, é preciso:',
     '["Usar escora ou dispositivo mecânico de retenção previsto para isso, além do bloqueio das energias", "Prender com corrente na estrutura", "Trabalhar rápido para reduzir a exposição", "Confiar na pressão hidráulica que a sustenta"]', 0, 56),

    ('Um acumulador hidráulico presente na máquina exige:',
     '["Despressurização e verificação antes da intervenção, pois mantém energia armazenada mesmo com a máquina desligada", "Apenas troca de óleo periódica", "Apenas aviso ao operador", "Nada de especial"]', 0, 57),

    ('Inversores de frequência e painéis com capacitores exigem, após o desligamento:',
     '["Apenas desligar o disjuntor geral", "Intervenção imediata, pois a energia acaba na hora", "Respeitar o tempo de descarga indicado pelo fabricante e confirmar a ausência de tensão antes de tocar", "Apenas aguardar dois segundos"]', 2, 58),

    ('Depois de bloquear as energias, uma verificação importante antes de iniciar a manutenção é:',
     '["Medir apenas a temperatura do motor", "Conferir o nível de óleo", "Perguntar ao operador se ele desligou", "Tentar acionar os comandos da máquina para confirmar que ela não parte, retornando os comandos à posição desligada em seguida"]', 3, 59),

    ('Uma ferramenta foi esquecida dentro da máquina após a manutenção. Qual o risco na partida?',
     '["Somente perda de tempo", "Nenhum, ela cai sozinha", "Projeção violenta da ferramenta, quebra de componentes e acidente com quem estiver perto, por isso a conferência antes de religar é obrigatória", "Somente dano à ferramenta"]', 2, 60),

    ('Antes de religar uma máquina grande, o que a norma espera?',
     '["Verificar que ninguém está em área de risco, avisar por sinal sonoro ou visual quando previsto e só então acionar", "Avisar apenas o encarregado do setor", "Religar e observar o comportamento", "Ligar direto, já que a manutenção acabou"]', 0, 61),

    ('Máquinas com partida automática ou remota exigem:',
     '["Sinalização clara de que podem partir sem aviso e medidas que impeçam a partida durante intervenção, com bloqueio efetivo", "Somente que o operador fique atento", "Somente uma placa na entrada do setor", "Somente aviso verbal ao pessoal do setor"]', 0, 62),

    ('Numa célula automatizada com robô, a proteção típica é:',
     '["Uma faixa pintada no piso", "Cerca perimetral com porta intertravada e dispositivos que garantem parada segura ao acesso", "Um aviso sonoro apenas", "A atenção do operador"]', 1, 63),

    ('Um técnico precisa entrar na célula do robô para ajuste. O correto é:',
     '["Entrar com o robô em velocidade normal, com cuidado", "Seguir o procedimento de modo de ajuste, com velocidade reduzida, dispositivo de habilitação e a área liberada de outras pessoas", "Entrar depois de avisar por rádio", "Entrar pela abertura de manutenção sem abrir a porta"]', 1, 64),

    ('A abertura de uma proteção do tipo grade precisa ser definida considerando:',
     '["Somente a ventilação necessária à máquina", "Somente a visibilidade que o operador precisa ter", "Somente o padrão de fabricação do fornecedor da grade", "A relação entre o tamanho da abertura e a distância até a zona de perigo, para que dedo, mão ou braço não alcancem a parte móvel"]', 3, 65),

    ('Numa prensa mecânica com freio e embreagem, a verificação periódica desses conjuntos importa porque:',
     '["Reduz o ruído da prensa", "Reduz o consumo de óleo", "Falha no freio provoca o repique, com o martelo descendo fora do comando, e isso ainda decepa mãos", "Melhora o acabamento da peça"]', 2, 66),

    ('Um dispositivo de retirada ou afastamento das mãos numa prensa serve para:',
     '["Segurar a peça durante o corte", "Substituir a manutenção do freio", "Aumentar a produção por hora", "Remover a mão do operador da zona de prensagem no momento do fechamento, quando outras medidas não são suficientes"]', 3, 67),

    ('Por que a alimentação manual de peças na zona de prensagem é a pior opção?',
     '["Porque exige mais treinamento", "Porque cansa mais o operador", "Porque coloca a mão dentro da zona de perigo a cada ciclo, e alimentação automática, semiautomática ou por dispositivo elimina essa exposição", "Porque produz menos peças"]', 2, 68),

    ('No pedal de acionamento de máquinas como prensas e guilhotinas, exige-se:',
     '["Pedal com mola mais fraca", "Pedal instalado longe do posto de operação", "Pedal livre, para facilitar o acionamento", "Pedal protegido contra acionamento acidental, evitando que uma queda de peça ou um passo em falso dispare a máquina"]', 3, 69),

    ('Numa guilhotina de chapas, além do dispositivo de proteção frontal, é preciso cuidar:',
     '["Do acesso pela parte traseira, onde a chapa sai e onde alguém pode alcançar a zona de corte", "Somente da iluminação do posto", "Somente do peso da chapa", "Somente da afiação da lâmina"]', 0, 70),

    ('Numa dobradeira, o risco principal para o operador é:',
     '["Projeção de cavaco", "Queimadura pelo óleo", "Ruído excessivo", "Esmagamento das mãos entre a matriz e o punção durante a dobra, exigindo proteção adequada e método de alimentação seguro"]', 3, 71),

    ('Numa injetora de plástico, o risco térmico e o de esmagamento são controlados por:',
     '["Proteções fixas e móveis intertravadas nas zonas de fechamento e de bico, com isolamento das partes aquecidas", "Somente pelo uso de luva térmica", "Somente por sinalização no piso", "Somente pelo bom senso do operador"]', 0, 72),

    ('A chave do mandril esquecida no torno é perigosa porque:',
     '["Impede o funcionamento do freio", "Desgasta o mandril", "Ao ligar a máquina ela é lançada com força, atingindo o operador e quem estiver por perto", "Desregula a rotação"]', 2, 73),

    ('No torno mecânico, além da proteção da placa, é preciso considerar:',
     '["A projeção de cavaco quente e a barra longa que gira além da placa, que precisa de proteção e sinalização", "Somente o nível de óleo do cabeçote", "Somente a fixação da máquina no piso", "Somente a iluminação da bancada"]', 0, 74),

    ('Ao furar uma peça pequena na furadeira de coluna, o correto é:',
     '["Segurar firme com as mãos e com luva", "Fixar a peça na morsa ou em dispositivo, porque a broca ao prender faz a peça girar e cortar a mão", "Apoiar a peça no colo", "Reduzir a rotação e segurar com um pano"]', 1, 75),

    ('No moto-esmeril, a distância entre o apoio da peça e o rebolo deve ser:',
     '["Pequena e ajustada conforme o desgaste do rebolo, para a peça não ser puxada e prender entre o apoio e o rebolo", "Indiferente", "Fixa desde a instalação, sem ajuste", "A maior possível, para caber a peça"]', 0, 76),

    ('Antes de montar um rebolo, uma verificação clássica é:',
     '["Molhar o rebolo antes do uso", "Lixar as bordas para acertar o diâmetro", "Pintar a face para identificar", "Conferir se está íntegro e se a rotação máxima do rebolo é compatível com a rotação da máquina"]', 3, 77),

    ('Usar um disco de corte fino para desbaste na esmerilhadeira:',
     '["É indiferente, o disco é o mesmo", "É aceitável quando falta o disco correto", "É perigoso: o disco não foi feito para esforço lateral e pode estilhaçar, projetando fragmentos", "É aceitável em rotação baixa"]', 2, 78),

    ('Sobre a proteção de uma serra fita:',
     '["Toda a lâmina deve ser protegida, exceto a parte estritamente necessária ao corte, com ajuste conforme a altura da peça", "Basta uma placa de aviso", "Basta o operador usar luva", "A lâmina precisa ficar exposta para o operador enxergar o corte"]', 0, 79),

    ('O que é o recuo violento da peça, o chamado coice, em serras e tupias?',
     '["A vibração normal do equipamento", "Um defeito elétrico da máquina", "O lançamento da peça na direção do operador quando ela prende na ferramenta, evitado com cutelo divisor, coifa e dispositivos de alimentação", "O ruído produzido no fim do corte"]', 2, 80),

    ('Na serra circular de bancada, o cutelo divisor tem a função de:',
     '["Manter aberto o corte para a peça não fechar sobre o disco e ser lançada de volta contra o operador", "Reduzir o ruído do corte", "Guiar o operador visualmente", "Segurar a peça na mesa"]', 0, 81),

    ('Sobre transportadores helicoidais, as roscas transportadoras:',
     '["Podem funcionar com a tampa aberta se ninguém chegar perto", "Devem operar com tampas fechadas e intertravadas, pois o contato com a rosca em movimento amputa membros", "Precisam apenas de sinalização", "Não oferecem risco por girarem devagar"]', 1, 82),

    ('Numa masseira ou amassadeira de padaria, a proteção esperada é:',
     '["Aviso para não colocar a mão", "Grade ou tampa com intertravamento, que impeça o acesso ao braço misturador em movimento", "Apenas um pedal de parada", "Apenas o uso de luva de malha"]', 1, 83),

    ('No moedor de carne, a alimentação do produto deve ser feita:',
     '["Com um cabo de vassoura qualquer", "Com a máquina em rotação reduzida", "Empurrando com a mão para não perder tempo", "Somente com o socador ou dispositivo apropriado, com a boca de alimentação protegida"]', 3, 84),

    ('Numa serra fita de açougue, o risco maior está associado a:',
     '["Corte das mãos junto à lâmina, exigindo proteção da lâmina, dispositivo de empurrar a peça e treinamento específico", "Vibração do piso", "Temperatura da câmara fria", "Ruído do motor"]', 0, 85),

    ('Sobre a altura e a disposição dos comandos no posto de operação:',
     '["Devem ficar longe, para o operador se afastar", "Devem ficar sempre no piso, acionados por pedal", "Devem ser instalados onde couber no painel", "Devem ficar em posição que permita acionamento confortável e seguro, sem exigir postura forçada ou aproximação da zona de perigo"]', 3, 86),

    ('Quando a operação da máquina pode ser feita sentado, a norma espera:',
     '["Assento adequado, com apoio para os pés quando necessário, e o posto ajustado à tarefa", "Que a operação seja sempre em pé", "Que o operador escolha por conta própria", "Que o trabalhador use um caixote"]', 0, 87),

    ('Trabalho repetitivo e em ritmo intenso na máquina exige atenção porque:',
     '["Diminui a qualidade da peça apenas", "Reduz a vida útil da máquina", "Aumenta o consumo de energia", "A fadiga e a lesão por esforço repetitivo aparecem, e o cansaço aumenta a chance de erro e de acidente"]', 3, 88),

    ('Sobre as cores e a identificação dos comandos da máquina:',
     '["A identificação pode ser feita a lápis", "Podem ser de qualquer cor, desde que o operador saiba", "Devem seguir a padronização, com o vermelho reservado à parada e à emergência, e estar identificados de forma legível", "Devem ser todos da cor da máquina"]', 2, 89),

    ('Os manuais e as instruções de operação e manutenção da máquina precisam:',
     '["Ficar arquivados no fornecedor", "Estar disponíveis aos trabalhadores, em língua portuguesa, com as informações de segurança", "Ficar apenas com o engenheiro", "Ser dispensados em máquina antiga"]', 1, 90),

    ('Para que serve a verificação feita pelo operador na máquina antes de iniciar o turno?',
     '["Registrar o horário de entrada do trabalhador", "Contar as peças produzidas no turno anterior", "Conferir proteções, comandos, dispositivos de segurança e condições gerais, encontrando o problema antes de a máquina entrar em produção", "Substituir a manutenção preventiva programada"]', 2, 91),

    ('A empresa alterou uma máquina, acrescentando um dispositivo de alimentação. O que é exigido?',
     '["Nada, se a máquina continuar funcionando", "Nova análise dos riscos introduzidos pela alteração, com as adequações necessárias e responsabilidade técnica quando couber", "Apenas anotação no diário de manutenção", "Apenas aviso ao operador"]', 1, 92),

    ('Uma máquina importada chegou sem as proteções exigidas no Brasil. O correto é:',
     '["Operar com atenção redobrada", "Operar apenas com o operador mais experiente", "Operar assim, já que veio de fábrica", "Adequar antes de colocar em operação, pois a máquina precisa atender aos requisitos de segurança aqui exigidos"]', 3, 93),

    ('Uma empresa quer vender ou alugar máquina sem os dispositivos de segurança. Isso:',
     '["É permitido para máquina usada", "É permitido, o problema passa a ser do comprador", "Não é permitido: a exigência acompanha a máquina na venda, na locação e na cessão", "É permitido se constar em contrato"]', 2, 94),

    ('O registro do treinamento do operador de máquina deve:',
     '["Constar do prontuário do trabalhador, com conteúdo, carga horária, data e identificação de quem ministrou", "Ser anotado apenas no crachá", "Ser dispensado para máquina simples", "Ser guardado apenas pelo instrutor"]', 0, 95),

    ('Novo treinamento ou reciclagem para operação de máquina é exigido quando:',
     '["A máquina muda de setor", "A cada dez anos, sempre", "Há mudança de máquina ou de procedimento, retorno de afastamento prolongado, mudança de função ou após acidente ou incidente relevante", "O trabalhador pede"]', 2, 96),

    ('Trabalhador terceirizado vai operar máquina do cliente. O que é necessário?',
     '["Somente a autorização da portaria", "Capacitação para aquela máquina, conhecimento dos procedimentos do local e as informações de risco fornecidas pela contratante", "Somente experiência anterior em máquina parecida", "Somente o certificado de outro equipamento"]', 1, 97),

    ('Cabelo comprido solto, crachá de cordão e roupa larga perto de partes rotativas:',
     '["Não oferecem risco se o operador for cuidadoso", "Podem ser agarrados pela parte em movimento e arrastar o trabalhador, e por isso precisam ser contidos ou retirados", "Só são problema em máquinas grandes", "São problema apenas de padronização do uniforme"]', 1, 98),

    ('Uso de anel, pulseira e relógio na operação de máquinas:',
     '["Deve ser evitado: prendem em partes móveis e agravam muito a lesão da mão", "Só é proibido em solda", "É permitido sob a luva", "É permitido se forem finos"]', 0, 99),

    ('Vibração transmitida por máquina portátil, como lixadeira e martelete, exige:',
     '["Controle da exposição, com equipamento adequado, manutenção, pausas e acompanhamento de saúde do trabalhador", "Apenas luva de raspa", "Apenas troca de ferramenta por modelo mais leve", "Nada, é próprio do serviço"]', 0, 100),

    ('Piso escorregadio por óleo ao redor da máquina representa risco porque:',
     '["Aumenta o consumo de óleo", "Danifica o piso apenas", "Suja o calçado do operador", "O escorregão junto a uma máquina em funcionamento pode terminar com a mão ou o corpo dentro da zona de perigo"]', 3, 101),

    ('Um vazamento em mangueira hidráulica sob alta pressão é perigoso porque:',
     '["Aumenta o ruído", "Suja a máquina e o piso", "O jato fino pode perfurar a pele e injetar óleo no corpo, causando lesão grave mesmo sem ferimento aparente", "Reduz a força da máquina apenas"]', 2, 102),

    ('A conduta correta ao procurar um vazamento hidráulico é:',
     '["Aumentar a pressão para ver melhor o ponto", "Passar a mão para sentir onde sai o óleo", "Despressurizar o sistema e localizar com meio indireto, como papelão, nunca com a mão", "Aproximar o rosto para enxergar melhor"]', 2, 103),

    ('Sobre engates rápidos de mangueira de ar comprimido:',
     '["Precisam estar em bom estado e travados, pois a mangueira solta sob pressão chicoteia e atinge quem estiver perto", "Podem ser amarrados com arame", "Não oferecem risco por ser apenas ar", "Podem ser conectados com a linha pressurizada e soltos a qualquer momento"]', 0, 104),

    ('Máquinas instaladas em local com risco de atmosfera explosiva exigem:',
     '["Apenas ventilação forçada", "Apenas sinalização de proibido fumar", "As mesmas condições de qualquer setor", "Equipamentos apropriados para a área classificada e controle das fontes de ignição, além dos requisitos usuais de proteção"]', 3, 105),

    ('Uma máquina apresentou defeito e foi interditada. Quem pode liberá-la para voltar a operar?',
     '["O operador que a interditou, no fim do turno", "Qualquer operador, quando ela parecer funcionando", "Somente após a manutenção concluída e a liberação formal por quem tem competência para isso, com registro", "O encarregado da produção, se a demanda for urgente"]', 2, 106),

    ('A sinalização de máquina interditada, com etiqueta e bloqueio, existe para:',
     '["Facilitar o inventário do patrimônio", "Identificar o setor responsável pelo custo", "Impedir que alguém, sem saber do defeito, ligue a máquina e se acidente", "Marcar o tempo de parada para o indicador"]', 2, 107),

    ('Um membro ficou preso na máquina. A primeira ação da equipe é:',
     '["Puxar a pessoa com força para libertar", "Parar e bloquear a máquina, acionar o socorro e só então avaliar a liberação com segurança, sem agravar a lesão", "Ligar a máquina em sentido contrário na hora", "Aguardar a chegada do socorro sem parar a máquina"]', 1, 108),

    ('Em caso de amputação, além do atendimento à vítima, o correto quanto à parte amputada é:',
     '["Envolver em pano limpo e úmido, acondicionar em saco plástico e manter resfriada, sem contato direto com o gelo, encaminhando junto com a vítima", "Colocar direto no gelo", "Lavar com álcool e guardar em água", "Descartar, pois não serve mais"]', 0, 109),

    ('Um quase acidente com máquina, sem lesão, deve ser:',
     '["Esquecido, porque ninguém se machucou", "Comunicado e analisado, porque revela uma falha que na próxima vez pode causar lesão grave", "Anotado apenas se houver testemunha", "Registrado somente no relatório anual"]', 1, 110),

    ('Sobre a limpeza de máquinas em funcionamento com pano ou pincel:',
     '["É aceitável se a rotação for baixa", "É prática comum e aceitável em máquina pequena", "É proibida na zona de perigo: o pano prende na parte móvel e leva a mão junto", "É aceitável se o operador usar luva"]', 2, 111),

    ('Numa máquina com esteira transportadora, a proteção dos pontos de agarramento entre correia e tambor existe porque:',
     '["A proteção reduz o ruído", "A proteção evita perda de material", "A correia desalinha sem a proteção", "É ali que a mão é puxada e esmagada, num movimento que ninguém consegue interromper com força"]', 3, 112),

    ('Sobre destravar material atolado num transportador em movimento:',
     '["Pode ser feito se outro trabalhador vigiar o comando", "Pode ser feito com barra de ferro", "Só pode ser feito com o equipamento parado e bloqueado, pois o desatolamento libera energia acumulada de repente", "Pode ser feito com a mão se o transportador for lento"]', 2, 113),

    ('Um sensor de segurança apresentou falha intermitente e a máquina para sozinha às vezes. O correto é:',
     '["Contornar o sensor até a manutenção resolver", "Parar a máquina e corrigir, pois falha intermitente em dispositivo de segurança é motivo de interdição, não de improviso", "Diminuir a produção e continuar", "Trocar o sensor por um modelo comum"]', 1, 114),

    ('Sobre o uso de máquinas por trabalhador que não recebeu treinamento naquele equipamento:',
     '["Não pode: a capacitação específica e a autorização precedem a operação", "Pode, em máquinas de pequeno porte", "Pode, se o manual estiver disponível", "Pode, se acompanhado por colega experiente por alguns dias"]', 0, 115),

    ('Uma máquina foi fabricada pela própria manutenção da empresa. Sobre a documentação:',
     '["Basta anotar no diário de bordo", "Basta ter a nota fiscal dos materiais", "Não é necessária, pois não houve compra", "É necessária, com projeto, avaliação dos riscos, medidas de proteção e responsabilidade técnica"]', 3, 116),

    ('Quando duas máquinas são interligadas numa linha, a análise de segurança deve considerar:',
     '["Somente a máquina de maior porte", "Somente a máquina que tiver painel elétrico", "Cada máquina isoladamente", "O conjunto, incluindo as zonas criadas na junção, o sincronismo das paradas e o acesso entre elas"]', 3, 117),

    ('Sobre o espaço de circulação entre máquinas e a estocagem de material no setor:',
     '["O importante é caber a empilhadeira", "Qualquer sobra de espaço serve para material", "As vias precisam permanecer livres e demarcadas, garantindo circulação, manutenção e saída em emergência", "O material pode ficar encostado na máquina"]', 2, 118),

    ('Por que a máquina precisa ficar estável e, quando necessário, fixada ao piso?',
     '["Para facilitar a limpeza embaixo", "Para o piso não trincar", "Porque o deslocamento ou tombamento durante a operação atinge quem está próximo e desalinha as proteções", "Para reduzir o consumo elétrico"]', 2, 119),

    ('A empresa quer reduzir custo usando proteção de acrílico improvisada em máquina com projeção de peças. A avaliação correta:',
     '["Serve se for grossa", "Serve enquanto a definitiva não chega, sem outras medidas", "Serve, é transparente e permite ver a operação", "A proteção precisa resistir ao impacto previsto e ser fixada adequadamente, e material improvisado costuma estilhaçar ou soltar"]', 3, 120),

    ('Sobre proteções que precisam ser removidas com ferramenta para abrir:',
     '["É justamente a característica esperada de uma proteção fixa: não pode ser removida sem ferramenta, para não ser aberta por impulso", "Devem ter maçaneta para agilizar", "Devem ser presas com fita para facilitar", "São inconvenientes e devem ser trocadas por porta simples"]', 0, 121),

    ('Uma proteção móvel foi aberta e a máquina continuou funcionando. Isso indica que:',
     '["A porta é apenas para conter respingo", "O sensor precisa apenas de limpeza, sem parar a produção", "A máquina é moderna e não precisa parar", "O intertravamento falhou ou foi burlado, e a máquina deve ser parada e bloqueada até a correção"]', 3, 122),

    ('Sobre o comando bimanual, um cuidado importante é:',
     '["Que os botões fiquem próximos, para o operador alcançar rápido", "Que a distância e o sincronismo impeçam o acionamento com uma mão só ou com objeto, garantindo que as duas mãos estejam fora da zona de perigo", "Que fique acessível também ao ajudante", "Que possa ser travado em uma posição"]', 1, 123),

    ('Um operador amarrou um dos botões do bimanual para operar com uma mão só. Isso:',
     '["Aumenta a produtividade sem risco", "Anula a proteção e deixa a outra mão livre para entrar na zona de perigo, sendo violação grave", "É aceitável em peças leves", "É problema apenas se ocorrer acidente"]', 1, 124),

    ('Alterar o programa do controlador da máquina para contornar um dispositivo de segurança é:',
     '["Violação grave: a lógica de segurança faz parte da proteção, e mexer nela expõe todos que operam aquela máquina", "Aceitável quando feito por técnico habilitado em programação", "Aceitável em caráter provisório, até a peça de reposição chegar", "Assunto de programação, sem relação com segurança do trabalho"]', 0, 125),

    ('A manutenção preventiva das máquinas serve principalmente para:',
     '["Reduzir o consumo de peças", "Cumprir exigência do fabricante", "Encontrar desgaste e falha antes que provoquem parada de produção e acidente, incluindo os dispositivos de segurança", "Aumentar o valor de revenda"]', 2, 126),

    ('Os dispositivos de segurança devem ser verificados:',
     '["Periodicamente, conforme o procedimento, e a verificação precisa ficar registrada", "Somente na compra da máquina", "Somente durante auditoria", "Somente quando falham"]', 0, 127),

    ('Uma empilhadeira circula dentro do setor onde há máquinas. O cuidado esperado é:',
     '["Somente buzinar nos cruzamentos", "Separação entre a circulação de pedestres e de equipamentos, com vias demarcadas, limites de velocidade e visibilidade nos cruzamentos", "Somente reduzir a velocidade", "Somente pintar o piso de amarelo"]', 1, 128),

    ('Sobre subir na máquina para alcançar um ponto alto durante a limpeza:',
     '["É aceitável se a máquina estiver desligada", "Não deve ser feito: se há necessidade de acesso em altura, é preciso meio de acesso apropriado, além do bloqueio da máquina", "É aceitável se houver um colega segurando", "É aceitável em máquina de até 2 metros"]', 1, 129),

    ('Superfícies aquecidas de máquinas, como resistências e moldes, exigem:',
     '["Somente ventilação do setor", "Somente aviso verbal ao operador", "Isolamento, barreira ou sinalização que impeçam o contato acidental, além de EPI adequado quando o contato for inevitável", "Somente luva de algodão"]', 2, 130),

    ('Ruído elevado gerado por uma máquina deve ser tratado, prioritariamente:',
     '["Com medidas na fonte e na trajetória, como enclausuramento, manutenção e amortecimento, ficando o protetor como complemento", "Com redução da jornada", "Com rodízio de operadores apenas", "Com fornecimento de protetor auricular"]', 0, 131),

    ('Uma tampa ou porta de proteção pesada fica levantada durante a manutenção. O cuidado necessário é:',
     '["Pedir a um colega que segure enquanto durar o serviço", "Usar o dispositivo de retenção previsto, como amortecedor ou escora, para que ela não caia sobre o trabalhador", "Apoiar a tampa em um pedaço de madeira encontrado no setor", "Trabalhar rápido para reduzir o tempo de exposição"]', 1, 132),

    ('O que se espera da empresa quando um trabalhador comunica uma condição insegura em máquina?',
     '["Que anote e responda no fim do ano", "Que avalie de imediato, adote medida provisória se necessário, corrija e retorne ao trabalhador o que foi feito", "Que oriente o trabalhador a ter mais cuidado", "Que transfira o trabalhador de setor"]', 1, 133),

    ('Um operador foi orientado a produzir com a proteção removida enquanto a peça de reposição não chega. O correto é:',
     '["Não operar a máquina nessa condição, comunicando o responsável, pois a produção não justifica exposição direta à zona de perigo", "Produzir apenas metade do turno", "Produzir usando luva reforçada", "Produzir com atenção redobrada"]', 0, 134),

    ('Sobre a participação dos trabalhadores na análise de riscos das máquinas:',
     '["É restrita aos membros da comissão interna", "Ocorre apenas após acidente", "É desnecessária, é assunto técnico", "É importante: quem opera conhece os improvisos, as dificuldades e os pontos onde o procedimento não funciona na prática"]', 3, 135),

    ('Máquinas móveis autopropelidas usadas dentro da planta exigem:',
     '["Somente carteira de habilitação comum", "Capacitação específica do operador, dispositivos de segurança e sinalização sonora e visual conforme a norma", "Somente sinalização no piso", "Somente inspeção anual"]', 1, 136),

    ('Sobre a proteção de eixos, polias e correias de transmissão:',
     '["Podem ficar expostos se estiverem acima da altura da cabeça", "Devem ser enclausurados, pois o contato com a transmissão em movimento causa amputação e enrolamento", "Basta pintar de amarelo", "Basta sinalizar com placa"]', 1, 137),

    ('Uma correia de transmissão precisa ser ajustada. O procedimento correto é:',
     '["Ajustar com uma barra, sem parar a máquina", "Ajustar com a máquina girando devagar", "Parar, bloquear as energias e só então abrir a proteção e ajustar", "Ajustar com a proteção parcialmente aberta"]', 2, 138),

    ('Sobre a partida de máquina após queda de energia:',
     '["A máquina não deve religar sozinha quando a energia voltar, exigindo comando intencional para reiniciar", "Deve depender apenas do disjuntor", "Deve reiniciar do ponto em que parou, automaticamente", "Deve ser automática, para não atrasar a produção"]', 0, 139),

    ('Numa máquina operada por duas pessoas em pontos diferentes, o sistema precisa garantir que:',
     '["O acionamento só ocorra com a garantia de que ambas estão fora da zona de perigo, com dispositivos que impeçam a partida por um só operador", "As duas conversem antes de acionar", "A mais experiente decida quando ligar", "Uma delas assuma o comando principal"]', 0, 140),

    ('Ferramentas de troca rápida em máquina, como moldes e matrizes, exigem cuidado com:',
     '["Somente o peso da peça", "O manuseio e o içamento seguros, a fixação correta e o bloqueio da máquina durante a troca", "Somente a limpeza da superfície", "Somente o tempo de parada"]', 1, 141),

    ('Sobre a área embaixo e atrás da máquina, usada para passagem de cabos e mangueiras:',
     '["Não faz parte da avaliação de riscos", "Pode ficar desorganizada, já que ninguém circula", "Precisa ser mantida organizada e protegida, pois é onde ocorre tropeço, dano a cabos e contato com partes móveis durante manutenção", "Serve para guardar ferramentas"]', 2, 142),

    ('Ao operar uma máquina pela primeira vez após a manutenção, espera-se:',
     '["Produzir e observar durante o turno", "Aguardar a próxima inspeção periódica", "Iniciar direto a produção em ritmo normal", "Verificar o funcionamento dos dispositivos de segurança antes de retomar a produção"]', 3, 143),

    ('Se um dispositivo de segurança atrapalha a operação e o operador vive tentando burlá-lo, isso indica que:',
     '["A produção deve ser reduzida permanentemente", "O operador é indisciplinado e deve ser advertido", "Além de tratar a violação, é preciso rever o projeto e o método de trabalho, porque proteção que inviabiliza a tarefa acaba sendo contornada", "O dispositivo deve ser removido"]', 2, 144),

    ('O que a hierarquia de medidas indica para o risco de máquina?',
     '["Começar sempre pelo EPI, que é mais barato", "Primeiro eliminar ou reduzir o risco no projeto, depois usar proteções e dispositivos, e só então medidas administrativas e EPI", "Aplicar todas as medidas ao mesmo tempo, sempre", "Escolher a medida conforme o custo"]', 1, 145),

    ('Sobre o operador que percebe algo diferente na máquina, como ruído, folga ou cheiro:',
     '["Deve tentar consertar por conta própria", "Deve anotar e informar no fim do mês", "Deve seguir produzindo até quebrar", "É a primeira linha de detecção e deve comunicar de imediato, pois a percepção de quem opera todos os dias antecipa falha"]', 3, 146),

    ('A empresa quer manter registro de tudo o que envolve segurança de máquinas. O que deve compor esse conjunto?',
     '["Somente as notas fiscais de compra", "Inventário, apreciação de riscos, procedimentos, manuais, registros de manutenção e de treinamento e o plano de adequação", "Somente as fichas de EPI", "Somente as ordens de produção"]', 1, 147),

    ('Sobre operar máquina sob efeito de álcool, medicamento sedativo ou privação de sono:',
     '["É problema apenas do trabalhador", "Compromete a atenção e o tempo de reação e a situação precisa ser comunicada e tratada antes de a pessoa assumir a máquina", "É aceitável em turno de baixa produção", "É aceitável se o colega ficar por perto"]', 1, 148),

    ('Se uma proteção precisa ser removida para uma tarefa específica e não há outra forma, a empresa deve:',
     '["Remover a proteção definitivamente", "Delegar a decisão ao operador", "Liberar a tarefa informalmente", "Estabelecer procedimento específico, com medidas alternativas de proteção, autorização e pessoal capacitado, restringindo a exposição ao mínimo"]', 3, 149),

    ('Qual é a ideia central que a norma de máquinas procura fixar?',
     '["Que o EPI resolve o risco mecânico", "Que máquina antiga não pode ser adequada", "Que a atenção do operador é a principal proteção", "Que a segurança precisa estar na máquina e no procedimento, e não depender de o trabalhador acertar todas as vezes"]', 3, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-12';


-- =====================================================================
--  NR-18 — Segurança e saúde no trabalho na indústria da construção
--  (questões 41 a 150)
--  As 40 primeiras percorreram o canteiro por cima: periferia, andaime,
--  escada, elétrica provisória, escavação. Estas entram no detalhe do
--  serviço: içamento e amarração, concretagem, demolição, produto
--  químico, trânsito interno, documentação e a convivência da obra com
--  as outras normas.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-18')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Sobre o transporte de trabalhadores dentro do canteiro ou até a frente de serviço:',
     '["Deve ser feito em veículo apropriado, com assento e cinto, sendo proibido transportar pessoas na caçamba ou sobre a carga", "Pode ser feito na caçamba do caminhão, quando o percurso é curto", "Pode ser feito sobre o material transportado, se houver quem segure", "Pode ser feito na concha da retroescavadeira em trajetos dentro da obra"]', 0, 41),

    ('O que a obra precisa oferecer quanto à água para consumo dos trabalhadores?',
     '["Água potável e fresca, em quantidade suficiente, em local próximo às frentes de serviço e com copo individual ou bebedouro apropriado", "Somente água na área de vivência, uma vez por turno", "Água de qualquer torneira da obra", "Um balde com caneca coletiva"]', 0, 42),

    ('Sobre as instalações sanitárias no canteiro:',
     '["Podem ficar em qualquer distância da frente de serviço", "Precisam ser mantidas limpas, em número suficiente e a distância que permita uso durante a jornada, sem obrigar longos deslocamentos", "Podem ser substituídas por banheiro do vizinho", "Só são exigidas em obras grandes"]', 1, 43),

    ('Sobre o vestiário do canteiro:',
     '["É dispensável se os trabalhadores vierem de uniforme de casa", "Deve ter armário individual e condições para a troca de roupa, evitando que o trabalhador leve sujeira e contaminante para casa", "Pode ser o mesmo espaço do refeitório, ao mesmo tempo", "Pode funcionar ao ar livre"]', 1, 44),

    ('Fazer a refeição sentado sobre material da obra, na própria frente de serviço:',
     '["Não é aceitável: a refeição deve ocorrer em local próprio, protegido e limpo, longe de poeira, produto químico e circulação de equipamentos", "É aceitável se o trabalhador levar marmita", "É aceitável em obras pequenas", "É aceitável quando o refeitório está longe"]', 0, 45),

    ('Uma rampa provisória de circulação da obra precisa:',
     '["Apenas ter largura suficiente para uma pessoa", "Ter inclinação adequada, superfície antiderrapante, travessões quando necessário e proteção lateral onde houver risco de queda", "Ser feita com a chapa de fôrma que sobrar", "Ser dispensada se houver escada"]', 1, 46),

    ('A passarela sobre uma vala aberta no canteiro deve:',
     '["Ser sinalizada apenas com fita", "Ser uma prancha simples atravessada", "Ter largura, resistência, fixação e guarda-corpo compatíveis com a passagem de pessoas e materiais", "Ser dispensada se a vala tiver menos de 2 metros"]', 2, 47),

    ('Um guarda-corpo improvisado com ripas finas e pregos foi montado na borda da laje. A avaliação correta é:',
     '["Serve se houver fita zebrada junto", "Serve enquanto o definitivo não chega", "Serve, porque marca a borda", "Não serve: o guarda-corpo precisa ter resistência para conter uma pessoa que se apoia ou tropeça, e não apenas indicar o limite"]', 3, 48),

    ('Na hierarquia de proteção da obra, a prioridade é:',
     '["Aumentar a supervisão", "Aumentar o número de placas de advertência", "Fornecer EPI de boa qualidade", "Adotar proteção coletiva, como guarda-corpo, fechamento e plataforma, usando a proteção individual quando aquela não for viável ou como complemento"]', 3, 49),

    ('Um guarda-corpo foi retirado para permitir a entrada de material pela fachada. O correto é:',
     '["Colocar um trabalhador para avisar quem passa", "Deixar retirado até o fim daquela etapa", "Adotar proteção alternativa durante a operação e recolocar o guarda-corpo assim que a movimentação terminar", "Substituir por corda amarrada nos pilares em definitivo"]', 2, 50),

    ('O andaime fachadeiro precisa ser apoiado:',
     '["Sobre pranchas de madeira soltas", "Direto no solo, onde houver espaço", "Sobre base firme e nivelada, com sapatas apropriadas, e ancorado à estrutura conforme o projeto", "Sobre blocos e tijolos empilhados"]', 2, 51),

    ('A plataforma de trabalho do andaime deve:',
     '["Ser completa, com piso inteiriço, fixado, antiderrapante e com guarda-corpo e rodapé nas laterais expostas", "Ser montada com a madeira disponível na obra", "Ser dispensada em andaime de um lance", "Ter ao menos uma tábua para o trabalhador pisar"]', 0, 52),

    ('Sobre pendurar talha ou guincho na estrutura de um andaime comum:',
     '["É prático e aceitável", "Não é aceitável: o andaime não foi dimensionado para essa carga, e o içamento deve usar equipamento próprio", "É aceitável se a carga for leve", "É aceitável se dois trabalhadores segurarem"]', 1, 53),

    ('Quando a plataforma de proteção da fachada, a bandeja, pode ser retirada?',
     '["No fim de cada semana", "Quando o encarregado precisar do material", "Assim que a estrutura passar do andar dela", "Somente quando não houver mais serviço nem risco de queda de material acima dela, conforme o planejamento da obra"]', 3, 54),

    ('Uma escada extensível é usada na obra. O cuidado específico dela é:',
     '["Estender ao máximo para alcançar mais", "Respeitar a sobreposição mínima entre os lances e travar corretamente antes do uso", "Amarrar os lances com arame", "Usar sem os pés de borracha se o piso for áspero"]', 1, 55),

    ('Um trabalhador montou um cavalete com tambores e pranchas para alcançar a altura de serviço. Isso é:',
     '["Improviso proibido: o acesso e a plataforma de trabalho precisam ser adequados e estáveis, com proteção contra queda", "Aceitável se o trabalhador for leve", "Aceitável se outro colega segurar", "Solução criativa, aceitável em serviço rápido"]', 0, 56),

    ('No içamento com grua ou guindaste, o papel do sinaleiro é:',
     '["Ajudar a amarrar a carga apenas", "Orientar a manobra com sinais padronizados, sendo a referência única para o operador durante a movimentação", "Substituir o operador quando ele cansar", "Conferir a nota fiscal do material"]', 1, 57),

    ('Sobre a comunicação entre operador de grua e sinaleiro:',
     '["Qualquer trabalhador pode dar sinais durante a manobra", "Os sinais precisam ser padronizados e o operador deve obedecer a um único sinaleiro, além do sinal de parada, que qualquer um pode dar", "A comunicação é dispensável se o operador enxergar a carga", "Basta gritar do chão"]', 1, 58),

    ('Ao fim do expediente ou com vento forte, a grua deve:',
     '["Ser desligada com a carga apoiada na laje", "Ficar travada com a carga suspensa", "Ser colocada na condição prevista pelo fabricante, com a lança liberada para girar conforme o vento e sem carga suspensa", "Ficar com a lança apontada para a rua"]', 2, 59),

    ('Um cabo de aço de içamento apresenta fios rompidos e amassamento. A conduta correta é:',
     '["Usar apenas para cargas leves", "Usar até acabar o serviço em andamento", "Retirar de uso e substituir, pois os critérios de descarte existem justamente para antecipar a ruptura", "Passar graxa e continuar usando"]', 2, 60),

    ('Ao usar cinta têxtil para içar peça com quinas vivas:',
     '["É preciso proteger a cinta na quina, que corta a fita sob carga", "É preciso molhar a cinta antes", "Basta dobrar a cinta em duas voltas", "Basta apertar bem a cinta"]', 0, 61),

    ('Para que serve a corda-guia amarrada na carga durante o içamento?',
     '["Permitir orientar a carga do solo, sem que o trabalhador precise encostar as mãos nela enquanto está suspensa", "Servir de amarração de segurança da carga", "Marcar a altura de içamento", "Ajudar a levantar a carga"]', 0, 62),

    ('Sobre passar carga suspensa por cima de trabalhadores:',
     '["É aceitável se o sinaleiro avisar antes", "É aceitável se a carga estiver bem amarrada", "Não é aceitável: a rota de içamento precisa evitar pessoas, com a área isolada durante a movimentação", "É aceitável se a altura for grande"]', 2, 63),

    ('O elevador de material da obra:',
     '["Pode transportar pessoas em subidas curtas", "Pode transportar pessoas com autorização do encarregado", "Pode transportar pessoas quando o de passageiros está ocupado", "Não pode transportar pessoas, e a proibição precisa estar sinalizada"]', 3, 64),

    ('Nas portas de acesso ao elevador de obra em cada pavimento:',
     '["Basta uma fita atravessada", "É necessário fechamento com dispositivo que impeça a abertura quando a cabine não estiver no pavimento", "Basta uma placa de aviso", "Basta manter a porta encostada"]', 1, 65),

    ('Ao concretar uma laje com bomba de concreto, um risco típico é:',
     '["Somente o ruído da bomba", "Somente o respingo no uniforme", "Somente o peso do concreto", "O chicoteamento do mangote quando ocorre entupimento e liberação súbita da pressão, exigindo procedimento e afastamento das pessoas"]', 3, 66),

    ('O vibrador de imersão usado na concretagem exige atenção a:',
     '["Riscos elétricos em ambiente úmido, com aterramento e proteção adequados, além da vibração transmitida às mãos", "Somente à limpeza da agulha", "Somente ao peso do equipamento", "Somente ao alcance do cabo"]', 0, 67),

    ('Na plataforma usada para concretagem de pilares e vigas em altura:',
     '["É preciso plataforma de trabalho com guarda-corpo e acesso seguro, além do sistema de proteção contra queda quando exigido", "Basta o trabalhador ter experiência", "Basta amarrar a fôrma com arame", "Basta pisar na fôrma"]', 0, 68),

    ('Na bancada de corte e dobra de vergalhões, os cuidados incluem:',
     '["Somente usar avental", "Somente usar luva", "Bancada estável, proteção da máquina de corte, óculos de proteção, organização do material e cuidado com as pontas do aço", "Somente afastar os curiosos"]', 2, 69),

    ('O transporte manual de sacos de cimento e blocos deve considerar:',
     '["Peso, distância, frequência e postura, com uso de meios mecânicos e organização do trabalho para reduzir o esforço", "Somente a altura da pilha", "Somente o número de trabalhadores disponíveis", "Somente a força do trabalhador"]', 0, 70),

    ('Ao levantar uma carga do chão, a técnica que reduz a lesão na coluna é:',
     '["Aproximar a carga do corpo, flexionar os joelhos, manter a coluna alinhada e evitar torcer o tronco durante o movimento", "Levantar em movimento rápido", "Levantar de costas para a carga", "Curvar as costas e puxar com os braços"]', 0, 71),

    ('No corte de peças cerâmicas e concreto, a poeira de sílica é controlada, prioritariamente:',
     '["Com ventilador apontado para o operador", "Molhando o piso ao redor", "Com máscara descartável comum", "Com corte úmido ou captação de poeira na fonte, complementado por proteção respiratória adequada"]', 3, 72),

    ('Para o respirador contra poeira funcionar como esperado, é preciso:',
     '["Apenas que tenha Certificado de Aprovação", "Que seja do tipo adequado, esteja bem vedado ao rosto e seja trocado conforme a saturação e as condições de uso", "Que seja usado por cima da barba", "Que seja lavado e reutilizado indefinidamente"]', 1, 73),

    ('Trabalho de impermeabilização com asfalto quente exige:',
     '["Somente luva de raspa", "Proteção contra queimadura, com vestimenta, luva e calçado adequados, controle da fonte de calor e cuidado com vapores e risco de incêndio", "Somente óculos de proteção", "Somente trabalhar nas horas mais frescas"]', 1, 74),

    ('Antes de iniciar serviço a quente na obra, como solda ou corte, é preciso:',
     '["Somente usar máscara de solda", "Somente trabalhar em dia sem vento", "Somente avisar quem estiver perto", "Verificar e afastar material combustível, providenciar extintor, isolar a área e cuidar da projeção de fagulhas para pavimentos inferiores"]', 3, 75),

    ('Sobre o armazenamento de cilindros de oxigênio e gás combustível no canteiro:',
     '["Ficam em pé, presos, em local ventilado, protegidos do sol e com separação entre oxigênio e combustível", "Podem ficar dentro do almoxarifado fechado", "Podem ficar no elevador de material", "Podem ficar juntos, deitados em qualquer canto"]', 0, 76),

    ('Ao transportar cilindros de gás no canteiro:',
     '["Rolando deitados pelo piso", "Em carrinho apropriado, com o capacete de proteção da válvula colocado e o cilindro preso", "Carregado no ombro por dois trabalhadores", "Amarrado na caçamba do elevador de material"]', 1, 77),

    ('Produtos químicos usados na obra, como desmoldante, aditivo e solvente, exigem:',
     '["Somente uso de luva de látex", "Somente aviso verbal", "Conhecimento da ficha de segurança, rotulagem, armazenamento adequado, EPI compatível e informação aos trabalhadores", "Somente armazenamento trancado"]', 2, 78),

    ('O quadro elétrico provisório da obra deve:',
     '["Ser dispensado em obra pequena", "Ficar aberto para agilizar as ligações", "Ficar trancado, protegido das intempéries, com dispositivo diferencial residual e circuitos identificados, sendo manuseado apenas por pessoal autorizado", "Ficar acessível a qualquer trabalhador"]', 2, 79),

    ('Cabos de alimentação espalhados pelo piso da obra:',
     '["Devem ser suspensos ou protegidos, evitando dano ao cabo, tropeço e contato com água acumulada", "Podem ficar no chão se forem cobertos com areia", "São problema apenas na época de chuva", "São inevitáveis e não representam risco"]', 0, 80),

    ('A iluminação das frentes de serviço e das vias de circulação da obra:',
     '["Pode ser suprida pela lanterna do celular", "É responsabilidade de cada trabalhador", "Só é necessária em trabalho noturno", "Precisa ser adequada à tarefa e ao trânsito de pessoas, incluindo áreas internas sem luz natural, como poços e subsolos"]', 3, 81),

    ('Sobre a sinalização de segurança do canteiro:',
     '["Serve apenas para a fiscalização", "É dispensável para quem já conhece a obra", "Basta a placa na entrada da obra", "Deve identificar acessos, áreas de risco, uso obrigatório de EPI, movimentação de equipamentos e locais de circulação, sendo mantida legível"]', 3, 82),

    ('Na manobra de ré do caminhão dentro do canteiro:',
     '["Basta o alarme sonoro do veículo", "É necessário sinaleiro orientando a manobra e a área liberada, pois o alarme sozinho não garante que ninguém esteja no ponto cego", "Basta o motorista buzinar antes", "Basta reduzir a velocidade"]', 1, 83),

    ('O material retirado de uma escavação deve ser depositado:',
     '["Na borda, para facilitar o reaterro", "Afastado da borda, pois o peso próximo à parede aumenta o risco de desmoronamento", "Dentro da própria vala, em um dos lados", "Sobre a passarela de travessia"]', 1, 84),

    ('Sobre a saída de emergência de uma vala profunda:',
     '["Precisa haver meio de acesso e saída suficientemente próximo do ponto de trabalho, permitindo saída rápida em caso de infiltração ou desmoronamento", "Basta a corda amarrada na borda", "Basta o operador da retroescavadeira ajudar", "Basta a escada na extremidade"]', 0, 85),

    ('Uma escavação profunda e fechada pode se tornar espaço confinado. Isso significa que:',
     '["Nada muda, é escavação e ponto", "Também se aplicam as exigências de espaço confinado, como avaliação da atmosfera, vigia e permissão", "Basta ventilar naturalmente", "Só vale para galerias de esgoto"]', 1, 86),

    ('Antes de escavar, o levantamento de interferências serve para:',
     '["Definir o tipo de escoramento apenas", "Calcular o prazo do serviço", "Estimar o volume de terra", "Identificar redes de energia, água, gás e telecomunicação enterradas, evitando rompimento, choque e explosão"]', 3, 87),

    ('Numa demolição, antes de iniciar o serviço é preciso:',
     '["Desligar e remover instalações de energia, água e gás, retirar vidros e materiais soltos, isolar a área e seguir o plano de demolição", "Apenas isolar a calçada", "Apenas avisar os vizinhos", "Começar pelo pavimento térreo para agilizar"]', 0, 88),

    ('Suspeita de material com amianto em reforma ou demolição exige:',
     '["Remoção rápida com marreta e vassoura", "Procedimento específico, com controle da geração de poeira, EPI adequado e destinação apropriada do resíduo, feito por equipe orientada", "Somente umedecer o material", "Somente uso de máscara descartável comum"]', 1, 89),

    ('Umedecer entulho e vias não pavimentadas do canteiro serve para:',
     '["Reduzir a poeira em suspensão, que agride as vias respiratórias e prejudica a visibilidade", "Facilitar a compactação do solo", "Reduzir o consumo de água", "Melhorar a aparência da obra"]', 0, 90),

    ('Sobre o protetor auricular em serviços ruidosos da obra:',
     '["A escolha considera a atenuação necessária para o ruído do serviço, e o uso precisa ser contínuo durante a exposição, com higiene e substituição", "Basta usar algodão no ouvido", "Só é necessário para quem opera a máquina", "Qualquer modelo protege igual"]', 0, 91),

    ('Sobre a entrega de EPI ao trabalhador da obra:',
     '["É feita apenas na admissão", "Basta deixar disponível no almoxarifado", "Deve ser registrada, com orientação de uso, guarda, higienização e substituição quando danificado ou vencido, sem custo para o trabalhador", "O trabalhador compra e a empresa reembolsa"]', 2, 92),

    ('A escolha do calçado de segurança na obra deve considerar:',
     '["Apenas a preferência do trabalhador", "Apenas o número do pé", "O risco da tarefa, incluindo perfuração por prego, impacto, umidade e escorregamento", "Apenas o preço"]', 2, 93),

    ('Sobre o uso de óculos de proteção em serviços de corte, perfuração e demolição:',
     '["É dispensável para quem usa óculos de grau", "É necessário, com modelo compatível e, quando o trabalhador usa óculos de grau, com sobreposição adequada ou lente de grau apropriada", "É necessário apenas em corte de metal", "Pode ser substituído por boné com aba"]', 1, 94),

    ('Como a obra deve acionar o socorro em caso de acidente grave?',
     '["Chamar somente o técnico de segurança", "Levar a vítima no carro de quem estiver disponível", "Seguir o procedimento previsto, acionando o serviço de emergência, informando local, tipo de acidente, número de vítimas e estado delas, e mantendo alguém para receber o socorro", "Aguardar o encarregado decidir"]', 2, 95),

    ('Após um acidente grave no canteiro, quanto ao local do acidente:',
     '["Deve ser fotografado apenas se houver morte", "Deve ser liberado assim que a vítima for removida", "Deve ser limpo imediatamente para retomar o serviço", "Deve ser preservado, na medida do possível, para permitir a análise do que ocorreu"]', 3, 96),

    ('Sobre o serviço de altura na obra e a norma de trabalho em altura:',
     '["As duas se aplicam: além dos requisitos da obra, valem a capacitação, a autorização, a análise de risco e o sistema de proteção contra queda", "A de altura só vale em indústria", "Basta cumprir uma das duas", "A norma da construção substitui a de altura"]', 0, 97),

    ('Um trabalhador chegou à obra visivelmente alcoolizado. A conduta correta é:',
     '["Mandar embora sem registro", "Deixar trabalhar acompanhado por um colega", "Colocar em serviço leve e observar", "Impedir o início da atividade, afastar da área de risco e encaminhar conforme o procedimento da empresa"]', 3, 98),

    ('Serviços críticos da obra, como içamento especial, escavação profunda e trabalho a quente em área de risco, costumam exigir:',
     '["Apenas o aviso no diálogo diário de segurança", "Permissão de trabalho, com análise prévia, medidas definidas e liberação formal antes do início", "Apenas a presença do encarregado", "Apenas o registro no diário de obra"]', 1, 99),

    ('A inspeção diária das frentes de serviço, feita antes do início dos trabalhos, serve para:',
     '["Conferir a produção do dia anterior", "Verificar as condições de segurança, o que mudou e o que precisa ser corrigido antes de a equipe começar", "Contar os trabalhadores presentes", "Registrar as horas trabalhadas"]', 1, 100),

    ('Sobre o operador de retroescavadeira ou manipulador telescópico e o raio de giro do equipamento:',
     '["Basta manter dois metros de distância", "A área de giro é segura se o operador enxergar", "A área precisa ser isolada, pois o contrapeso e a lança prensam quem estiver na trajetória, mesmo dentro do campo de visão", "Basta sinalização sonora"]', 2, 101),

    ('Durante a cravação de estacas, os riscos que merecem atenção incluem:',
     '["Somente a poeira", "Somente o consumo de combustível", "Somente o ruído", "Queda de componentes, projeção, ruído elevado, vibração e a área sob a carga suspensa, exigindo isolamento e procedimento"]', 3, 102),

    ('Uma reforma em prédio ocupado exige, além dos requisitos usuais:',
     '["Somente trabalhar em horário comercial", "Somente sinalizar o elevador", "Somente aviso à administração", "Separação e isolamento entre a área de obra e a área ocupada, controle de acesso, proteção contra queda de material e comunicação aos usuários"]', 3, 103),

    ('Obra que interfere na via pública, como içamento sobre a calçada, exige:',
     '["Somente executar de madrugada", "Somente um trabalhador orientando os pedestres", "Sinalização e desvio conforme as regras de trânsito e a autorização do órgão competente, com proteção efetiva de quem passa", "Somente cone e fita zebrada"]', 2, 104),

    ('Sobre a aplicação da norma em obra pequena ou reforma residencial:',
     '["Aplica-se somente a partir de dez trabalhadores", "Aplica-se somente a construtoras registradas", "Não se aplica, é obra pequena", "Aplica-se, ajustada ao porte e às atividades: a queda de laje e o choque elétrico não distinguem tamanho de obra"]', 3, 105),

    ('Sobre a estocagem de material próximo à borda da laje:',
     '["É prática comum e sem risco", "Deve ser evitada: sobrecarrega a estrutura e favorece a queda de material sobre quem está abaixo", "É aceitável se o material for leve", "É aceitável se houver guarda-corpo"]', 1, 106),

    ('Ao empilhar blocos, sacos e tubos no canteiro, é preciso:',
     '["Encostar tudo nas paredes da obra", "Cobrir com lona apenas", "Empilhar o mais alto possível para ganhar espaço", "Respeitar altura e estabilidade da pilha, com base firme, travamento e afastamento das vias de circulação"]', 3, 107),

    ('Sobre o uso de carrinho de mão em pranchas e rampas da obra:',
     '["Deve ser carregado ao máximo, para reduzir o número de viagens", "Pode ser descido em rampa íngreme, com o trabalhador correndo atrás", "A carga precisa ser compatível com o percurso, a prancha firme e larga e a rampa com inclinação que permita controlar o carrinho", "Pode circular sobre fôrma ainda não escorada"]', 2, 108),

    ('Sobre o uso da policorte e do disco abrasivo no canteiro:',
     '["O disco pode ser usado mesmo trincado, quando o corte é pequeno", "O disco precisa estar íntegro, compatível com o material e com a rotação do equipamento, com a proteção instalada e a peça bem fixada", "A proteção pode ser retirada para o operador enxergar melhor o corte", "A peça pode ser segurada com a mão durante o corte"]', 1, 109),

    ('Sobre a energia elétrica das ferramentas usadas em área molhada da obra:',
     '["Basta secar o piso antes", "Basta o cabo estar íntegro", "É necessário proteção adicional, com dispositivo diferencial residual e, quando indicado, ferramentas alimentadas em tensão de segurança", "Basta usar bota de borracha"]', 2, 110),

    ('A montagem e a desmontagem de fôrmas e escoramentos exigem:',
     '["Seguir o projeto, respeitar a sequência e os prazos de retirada e manter a área isolada durante a operação", "Retirar tudo assim que o concreto endurecer na superfície", "Somente cuidado com os pregos", "Improvisação conforme a peça"]', 0, 111),

    ('Pregos expostos em tábuas retiradas das fôrmas devem ser:',
     '["Deixados para retirar depois, junto com o entulho", "Retirados ou rebatidos imediatamente, pois perfuram o pé mesmo com calçado inadequado e causam ferimentos", "Sinalizados com fita", "Cobertos com serragem"]', 1, 112),

    ('Sobre a proteção contra queda de material na fachada durante o serviço:',
     '["Basta trabalhar com cuidado", "Basta avisar os pedestres", "Basta uma placa avisando", "É necessário fechamento com tela ou proteção equivalente e isolamento da área abaixo, além da organização do material no pavimento"]', 3, 113),

    ('Ao trabalhar em serviços de pintura de fachada com equipamento suspenso:',
     '["Basta amarrar a corda no barrilete", "Basta o trabalhador ter experiência", "Além dos requisitos do equipamento, valem a capacitação em altura, a análise de risco, a ancoragem projetada e o plano de resgate", "Basta o cinto de posicionamento"]', 2, 114),

    ('Sobre a formação de poças e áreas alagadas no canteiro:',
     '["Só são problema em época de chuva", "Devem ser cobertas com terra", "São normais e não exigem ação", "Devem ser drenadas: além do risco elétrico e de escorregamento, favorecem a proliferação de vetores de doença"]', 3, 115),

    ('O trabalho na obra em dias de tempestade com raios exige:',
     '["Interromper serviços expostos, especialmente em altura, com estrutura metálica e com equipamentos de grande porte, recolhendo a equipe a local seguro", "Continuar com botas de borracha", "Continuar se a chuva for fraca", "Continuar em áreas cobertas apenas"]', 0, 116),

    ('Sobre o uso de escada de mão como plataforma de trabalho para serviços demorados:',
     '["É aceitável se a escada for de alumínio", "É aceitável com dois colegas segurando", "É aceitável quando o serviço é simples", "Deve ser evitado: para serviço com permanência, o correto é andaime ou plataforma, pois a escada é meio de acesso"]', 3, 117),

    ('Um trabalhador foi contratado para função diferente da que exercia. Antes de iniciar:',
     '["Basta o aviso do encarregado", "Basta assinar o novo contrato", "Basta a experiência anterior na obra", "Precisa receber treinamento e informação sobre os riscos da nova função e das novas tarefas"]', 3, 118),

    ('Sobre o treinamento de segurança na obra e seu registro:',
     '["Deve ficar documentado, com conteúdo, carga horária, data e identificação do responsável pelo treinamento", "Basta anotar no diário de obra", "É dispensado para trabalhador com experiência", "Basta a lista de presença guardada com o encarregado"]', 0, 119),

    ('Empresas subcontratadas atuando no mesmo canteiro exigem:',
     '["Coordenação entre as empresas, com informação mútua dos riscos e compatibilização dos serviços, pois o risco de uma alcança o trabalhador da outra", "Que a contratante se afaste da segurança das contratadas", "Que cada uma tenha o seu próprio canteiro", "Que cada uma cuide apenas do seu pessoal, sem interação"]', 0, 120),

    ('Sobre o trabalhador que se recusa a executar tarefa em condição de risco grave e iminente na obra:',
     '["Precisa de autorização prévia por escrito", "Só pode recusar se houver testemunha", "Comete falta grave", "Está agindo corretamente, devendo comunicar imediatamente o superior para que a situação seja corrigida"]', 3, 121),

    ('O que se espera do encarregado ao receber a comunicação de uma condição insegura?',
     '["Anotar e resolver quando sobrar tempo", "Avaliar de imediato, interromper o serviço se necessário, providenciar a correção e retornar ao trabalhador o que foi feito", "Encaminhar para a próxima reunião mensal", "Orientar o trabalhador a se afastar do local"]', 1, 122),

    ('Sobre a movimentação de trabalhadores em piso ainda sem proteção definitiva:',
     '["As rotas precisam ser definidas, protegidas e sinalizadas, e o acesso a áreas sem proteção deve ser impedido", "Basta avisar no diálogo diário de segurança", "Basta manter iluminação", "Podem circular normalmente, se conhecerem a obra"]', 0, 123),

    ('Um poço de elevador ou vão interno sem proteção representa:',
     '["Risco apenas no pavimento térreo", "Risco apenas na fase de acabamento", "Risco somente para quem trabalha ali dentro", "Risco de queda de pessoas e de materiais em todos os pavimentos, exigindo fechamento resistente e sinalização em cada nível"]', 3, 124),

    ('O contato prolongado com produtos alcalinos e cimentícios pode causar:',
     '["Somente manchas na roupa", "Somente ressecamento da pele", "Queimadura química e dermatite, exigindo luva adequada, higiene e cuidado com a roupa contaminada", "Somente alergia respiratória"]', 2, 125),

    ('Sobre lavar as mãos e trocar a roupa contaminada antes da refeição e ao fim da jornada:',
     '["É responsabilidade exclusiva do trabalhador", "É recomendação de higiene sem relação com segurança", "É medida de saúde: evita a ingestão de contaminante e a exposição prolongada da pele, além de não levar o risco para casa", "Só é necessário quando se usa produto químico"]', 2, 126),

    ('Uma equipe vai trabalhar próximo a rede elétrica aérea usando andaime metálico. É preciso:',
     '["Avaliar a distância de aproximação e solicitar o desligamento, o isolamento ou o afastamento da rede antes da montagem", "Somente aterrar o andaime", "Somente montar em dia seco", "Somente pedir atenção ao pessoal"]', 0, 127),

    ('Sobre o gerador a combustão usado na obra:',
     '["Pode ficar em ambiente fechado, se houver janela", "Precisa ficar em local ventilado, com o escapamento afastado de áreas ocupadas, pois o monóxido de carbono mata sem cheiro nem aviso", "Pode ficar dentro do subsolo, se o motor for novo", "Pode ficar em qualquer lugar, se tiver aterramento"]', 1, 128),

    ('Sobre o abastecimento de combustível de equipamentos no canteiro:',
     '["Deve ser feito com o motor desligado, em área ventilada e sem fontes de ignição, com controle de derramamento", "Pode ser feito perto do local de solda", "Pode ser feito com o equipamento aquecido, sem cuidados", "Pode ser feito com o motor ligado, para agilizar"]', 0, 129),

    ('Extintores no canteiro devem:',
     '["Ser dispensados se não houver solda", "Ficar guardados no almoxarifado, protegidos", "Estar em locais sinalizados, desobstruídos e próximos às áreas de risco, com carga válida e pessoal orientado a usá-los", "Ficar apenas na área de vivência"]', 2, 130),

    ('Sobre a formação de brigada ou de trabalhadores treinados para emergência na obra:',
     '["É dispensável, já que existe o corpo de bombeiros", "É necessária: os primeiros minutos dependem de quem está no local, tanto no combate a princípio de incêndio quanto nos primeiros socorros", "É atribuição do vigia noturno", "É exigida somente em obras acima de dez andares"]', 1, 131),

    ('Um trabalhador foi atingido por objeto que caiu de um pavimento superior e está consciente, com dor forte. A conduta correta é:',
     '["Dar analgésico e mandar descansar", "Aguardar melhorar antes de acionar socorro", "Levantar e levar caminhando até o portão", "Manter a vítima imóvel, acionar o socorro e evitar movimentar suspeita de lesão na coluna ou fratura"]', 3, 132),

    ('Qual é o papel dos representantes dos trabalhadores na comissão de prevenção de acidentes da obra?',
     '["Fiscalizar a produção das equipes e cobrar prazo", "Substituir o técnico de segurança nas inspeções do canteiro", "Levar os problemas percebidos no dia a dia, participar da identificação dos riscos e acompanhar as ações, aproximando quem executa de quem decide", "Aplicar advertências a quem descumpre norma"]', 2, 133),

    ('Sobre a participação dos trabalhadores nas questões de segurança da obra:',
     '["Ocorre somente após acidente", "É desnecessária, pois é assunto técnico", "É essencial: quem executa conhece as dificuldades reais do serviço e os improvisos que se tornaram rotina", "Ocorre somente por meio de caixa de sugestões"]', 2, 134),

    ('Se uma medida de segurança atrasa o serviço e o encarregado pede para pular a etapa, o correto é:',
     '["Pular, pois a chefia assume a responsabilidade", "Não executar dessa forma e buscar solução com o responsável, pois nenhuma meta justifica exposição a risco grave", "Pular apenas naquele dia", "Pedir para outro colega fazer"]', 1, 135),

    ('Sobre o uso do capacete durante todo o tempo em que se circula pelo canteiro:',
     '["Só é exigido para quem trabalha em altura", "Pode ser retirado em áreas onde não há serviço acima", "É exigido nas áreas de risco de queda de material, e a definição de onde ele é obrigatório deve estar clara e sinalizada", "Pode ser substituído por boné em dias quentes"]', 2, 136),

    ('Vestimenta de trabalho na obra deve:',
     '["Ser adequada ao serviço e ao clima, cobrindo o corpo conforme o risco, e ser substituída quando danificada", "Ser sempre a mais leve possível", "Ser usada até o fim da obra, sem substituição", "Ficar a critério de cada trabalhador"]', 0, 137),

    ('Sobre a exposição ao sol durante longos períodos na obra:',
     '["Exige apenas boné", "Exige apenas iniciar a jornada mais cedo", "É inevitável e não exige medidas", "Exige organização do trabalho, sombra, hidratação, pausas e proteção da pele, pois o calor e a radiação causam adoecimento"]', 3, 138),

    ('Um trabalhador apresenta tontura, pele quente e confusão em dia de calor forte. A conduta é:',
     '["Retirar do sol, resfriar, oferecer líquido se estiver consciente e acionar atendimento, pois pode ser insolação ou exaustão pelo calor", "Deixar sentado no sol até melhorar", "Encaminhar para casa sozinho", "Dar água e mandar continuar em serviço leve"]', 0, 139),

    ('Sobre trabalhar próximo a operação de bate-estaca ou rompedor, com ruído de impacto:',
     '["Só quem opera precisa se proteger", "Basta afastar-se alguns metros", "É preciso controlar a exposição de quem opera e de quem está próximo, com organização das áreas, isolamento e proteção auditiva adequada", "Basta usar protetor de inserção"]', 2, 140),

    ('Um trabalhador é orientado a subir na caçamba do caminhão para acomodar carga durante a movimentação:',
     '["É aceitável se ele se segurar bem", "Não é aceitável: ninguém deve permanecer sobre a carga ou na caçamba durante a movimentação do veículo", "É aceitável em velocidade baixa", "É aceitável dentro do canteiro"]', 1, 141),

    ('Sobre o uso de rodapé no guarda-corpo da periferia:',
     '["É exigido apenas em andaime", "É detalhe estético", "Impede que ferramentas e materiais caiam pela borda e atinjam quem está abaixo", "Serve para apoiar o pé do trabalhador"]', 2, 142),

    ('Sobre o armazenamento de resíduos e o descarte na obra:',
     '["Pode ser feito em qualquer canto do terreno", "Deve haver local definido e segregação adequada, com destinação apropriada, evitando acúmulo que gere risco de incêndio, queda e proliferação de vetores", "Deve ser queimado no próprio canteiro", "Deve ser enterrado no terreno"]', 1, 143),

    ('A organização e a limpeza do canteiro têm relação com segurança porque:',
     '["Reduzem o custo do transporte de entulho", "Facilitam a medição do serviço", "Melhoram a imagem da empresa", "A maioria das quedas, tropeços, perfurações e princípios de incêndio na obra tem origem em desordem e acúmulo de material"]', 3, 144),

    ('Sobre a inspeção de cabos, ganchos, cintas e acessórios de içamento:',
     '["É feita somente quando ocorre acidente", "É responsabilidade exclusiva do operador da grua", "Basta a inspeção do fornecedor na entrega", "É feita periodicamente e antes do uso, com registro, retirando de serviço o que estiver fora dos critérios"]', 3, 145),

    ('Um serviço vai ser executado à noite no canteiro. Além da iluminação, é preciso considerar:',
     '["Somente o pagamento do adicional noturno", "Fadiga, menor visibilidade do entorno, dificuldade de comunicação e disponibilidade reduzida de socorro, ajustando o planejamento", "Somente o ruído para a vizinhança", "Somente a segurança patrimonial"]', 1, 146),

    ('Sobre o trabalhador que executa serviço sozinho em área isolada da obra:',
     '["É aceitável se o serviço durar pouco", "É aceitável, se ele tiver experiência", "Deve haver meio de comunicação e verificação periódica, pois em caso de acidente ninguém perceberia a tempo", "É aceitável em serviços de acabamento"]', 2, 147),

    ('Quando a obra muda de fase, por exemplo da estrutura para o acabamento, os riscos:',
     '["Só mudam se entrar equipamento novo", "Permanecem os mesmos", "Mudam, e as medidas de proteção, a sinalização e as informações aos trabalhadores precisam ser revistas para a nova realidade", "Diminuem sempre"]', 2, 148),

    ('Sobre o registro e a comunicação de acidente de trabalho ocorrido na obra:',
     '["É feito apenas pela empresa contratante", "É feito somente ao fim da obra", "Só é feito quando há afastamento", "Deve ser comunicado conforme a legislação e analisado internamente, mesmo quando o afastamento é curto ou não ocorre"]', 3, 149),

    ('Qual é a ideia central que a segurança na construção procura fixar?',
     '["Que a obra muda todo dia, e por isso a proteção precisa ser planejada, instalada, conferida e recolocada sempre que a etapa avança", "Que o EPI resolve os riscos do canteiro", "Que os acidentes de obra são inevitáveis", "Que o trabalhador experiente reconhece o risco e se protege sozinho"]', 0, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-18';
