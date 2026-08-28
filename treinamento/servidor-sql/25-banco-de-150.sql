-- =====================================================================
--  BANCO DE 150 QUESTOES POR CURSO — a ampliacao
--
--  Cole no SQL Editor do Supabase e rode UMA vez. Demora alguns segundos:
--  sao centenas de questoes.
--
--  E SEGURO RODAR MESMO QUE PARTE JA TENHA SIDO FEITA. Cada bloco apaga a
--  propria faixa antes de inserir, entao nao duplica nada. Se voce ja
--  rodou algum destes arquivos separado, ele simplesmente refaz o mesmo
--  trabalho.
--
--  ATENCAO: AS PERGUNTAS PRECISAM DA CONFERIDA DO RESPONSAVEL TECNICO
--  ANTES DE VALEREM PARA CERTIFICADO. Prova errada reprova quem sabe e
--  aprova quem nao sabe, e o certificado e assinado por quem responde
--  tecnicamente pelo curso.
--
--  No fim ha uma conferencia que diz, em uma tela, se deu tudo certo.
-- =====================================================================



-- #####################################################################
-- ##  Banco GRANDE 1 (NR-10, NR-33, NR-35-REC, NR-12, NR-18)
-- ##  (de 21-banco-grande-1.sql)
-- #####################################################################

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

-- #####################################################################
-- ##  Banco GRANDE 2 (NR-20, BRIG, NR-11, NR-05, NR-10-SEP)
-- ##  (de 22-banco-grande-2.sql)
-- #####################################################################

-- =====================================================================
--  Banco de questões — grupo grande 2
--  NR-20, BRIG, NR-11, NR-05 e NR-10-SEP
--  110 questões novas por curso, ordem 41 a 150. São 550 no total.
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
--  A prova sorteia 10 questões do banco do curso. Com 40 cadastradas, duas
--  provas seguidas já saem diferentes; com 150, o aluno que decorar o
--  gabarito de um colega não leva quase nada de vantagem. O banco só
--  cumpre esse papel enquanto as perguntas forem realmente diferentes
--  umas das outras.
--
--  AS 40 PRIMEIRAS CONTINUAM VALENDO
--  As questões de ordem 1 a 40 vieram dos arquivos 10, 12, 15, 16, 17 e 18
--  e NÃO são apagadas aqui: o delete de cada bloco tem
--  `ordem between 41 and 150`. Rodar este arquivo depois daqueles deixa o
--  curso com 150 questões, não com 110.
--
--  NENHUMA QUESTÃO REPETE AS 40 QUE JÁ EXISTIAM
--  Nem o mesmo fato escrito com outras palavras. Repetição disfarçada é
--  pior que banco pequeno: além de não sortear coisa nova, duas versões da
--  mesma pergunta com gabaritos diferentes reprovam quem acertou. Para
--  chegar a 110 sem repetir, o que muda é o ângulo — situação de campo,
--  responsabilidade, documento, equipamento, emergência, erro comum e
--  interação com as outras normas — e não o vocabulário.
--
--  A COLUNA `correta` É O ÍNDICE, COMEÇANDO EM ZERO
--  Se a resposta certa é a primeira alternativa, `correta` é 0. A posição
--  foi distribuída pelos quatro índices, sem padrão que se possa decorar:
--  aluno que decora sequência de gabarito não aprende norma nenhuma.
--
--  CADA ARRAY FICA NUMA LINHA SÓ, de propósito: o Postgres recusa JSON com
--  quebra de linha dentro do texto ("Character with value 0x0d must be
--  escaped"). Foi o erro que derrubou a primeira versão do arquivo do
--  NR-20 e não custa nada evitar de novo.
--
--  As alternativas erradas são erros que se ouve na obra, no chão de
--  fábrica e no poste, não absurdo. Alternativa ridícula não mede nada: o
--  aluno elimina por eliminação e passa sem ter entendido o risco.
-- =====================================================================

-- =====================================================================
--  NR-20 — Inflamáveis e combustíveis (questões 41 a 150)
--  As 40 primeiras já cobrem fogo, área classificada e trabalho a quente.
--  Aqui o peso vai para o que cerca a tarefa: documento, produto novo,
--  equipamento certificado, emergência e o que se faz depois do susto.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-20')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Onde o trabalhador encontra os riscos, os cuidados e o que fazer em caso de derrame de um produto químico?',
     '["Na nota fiscal que acompanha a carga", "No manual do equipamento onde o produto é usado", "Na Ficha de Informações de Segurança de Produto Químico, a FISPQ, que fica disponível no setor", "No contrato de compra do produto"]', 2, 41),

    ('O rótulo do produto traz um losango vermelho com o desenho de uma chama. Isso indica:',
     '["Que o produto é inflamável e não pode chegar perto de fonte de ignição", "Que o produto é quente ao toque", "Que o produto só pode ser usado com fogo por perto", "Que o produto perde a validade com o calor"]', 0, 42),

    ('Um colega passou solvente do tambor para uma garrafa sem identificação. Qual o problema?',
     '["Nenhum, desde que o recipiente seja de plástico resistente", "Só o desperdício de produto", "Nenhum, porque quem transferiu sabe o que é", "Recipiente sem rótulo esconde o risco: outro trabalhador pode usar, guardar ou descartar errado, ou até beber"]', 3, 43),

    ('O que é o ponto de fulgor de um líquido?',
     '["A temperatura máxima que o tanque suporta", "A menor temperatura em que ele libera vapor suficiente para inflamar na presença de uma fonte de ignição", "A temperatura em que o líquido começa a ferver", "A temperatura em que o líquido congela dentro do tanque"]', 1, 44),

    ('O que é a temperatura de autoignição de um produto?',
     '["A temperatura em que ele pega fogo sozinho, sem faísca nem chama", "A temperatura em que ele evapora por completo", "A temperatura em que o extintor deixa de funcionar", "A temperatura do ambiente onde ele deve ser guardado"]', 0, 45),

    ('Houve derrame de solvente e o fogo começou longe da poça, em outro ponto do galpão. Como isso é possível?',
     '["O produto virou gás e subiu direto para o telhado", "Houve outro derrame no mesmo momento", "O produto explodiu por diferença de pressão", "O vapor caminhou pelo piso até encontrar uma fonte de ignição e a chama voltou pelo caminho do vapor"]', 3, 46),

    ('O nível de capacitação exigido do trabalhador na NR-20 depende de quê?',
     '["Da vontade do próprio trabalhador", "Da classificação da instalação e do tipo de atividade que ele executa com o inflamável", "Do tempo de casa do trabalhador", "Do salário e da função registrada em carteira"]', 1, 47),

    ('Com que frequência o treinamento de inflamáveis precisa ser refeito?',
     '["Não existe: o curso vale para sempre", "Só é feita se a fiscalização exigir", "É periódica e também acontece quando muda o processo, o produto ou depois de acidente ou afastamento longo", "Só é feita quando o trabalhador troca de empresa"]', 2, 48),

    ('Um trabalhador do almoxarifado foi transferido para a área de tancagem. O que a empresa precisa fazer?',
     '["Nada, porque ele já é empregado da casa", "Somente entregar os EPIs da nova área", "Esperar a próxima turma anual de treinamento", "Capacitar no nível exigido pela nova atividade antes de ele começar a trabalhar sozinho na área"]', 3, 49),

    ('O trabalhador percebe risco grave e iminente na tarefa que lhe foi passada. O que a norma garante a ele?',
     '["Continuar até o supervisor aparecer na área", "Interromper a atividade e comunicar imediatamente ao superior, sem sofrer punição por isso", "Executar assim mesmo e reclamar depois na reunião", "Trocar de tarefa com outro colega por conta própria"]', 1, 50),

    ('O plano de resposta a emergências da instalação serve para:',
     '["Substituir a brigada de emergência", "Atender exigência do seguro da empresa", "Definir antes quem faz o quê, quais recursos existem e como se dá o alarme, o abandono e o combate", "Registrar os acidentes já ocorridos na unidade"]', 2, 51),

    ('A empresa vai mudar a bomba, o produto e a pressão de uma linha de transferência. O que precisa acontecer antes?',
     '["Avaliar os riscos da mudança, atualizar procedimento e documentação e informar quem opera", "Fazer a mudança e avaliar depois, com o sistema rodando", "Nada, porque é manutenção de rotina", "Somente comunicar a mudança ao setor de compras"]', 0, 52),

    ('Um trabalhador quase foi atingido por um jato de produto, mas ninguém se feriu. O que fazer?',
     '["Comunicar só se acontecer uma segunda vez", "Comunicar o quase-acidente para que a causa seja investigada antes que aconteça de novo com ferido", "Nada, porque não houve lesão", "Anotar no caderno pessoal e seguir o serviço"]', 1, 53),

    ('Qual é o objetivo de investigar um acidente na área de inflamáveis?',
     '["Cumprir formalidade para o setor de pessoal", "Justificar o atraso da produção naquele dia", "Encontrar as causas e corrigir o que falhou, para que o acidente não se repita", "Apontar o culpado para aplicar advertência"]', 2, 54),

    ('Antes de abrir um equipamento para manutenção, o que garante que ele não vai ser acionado ou receber produto?',
     '["O bloqueio físico das fontes de energia e das linhas, com cadeado e etiqueta identificando quem bloqueou", "Um aviso verbal ao operador do painel", "Desligar o botão do painel e deixar um bilhete", "Combinar o horário com o pessoal do turno seguinte"]', 0, 55),

    ('Para que serve o flange cego, ou raquete, colocado na linha durante a manutenção?',
     '["Para aumentar a vazão depois da manutenção", "Para medir a pressão da linha", "Para filtrar a sujeira do produto", "Para separar fisicamente o equipamento da linha, garantindo que produto nenhum chegue nele"]', 3, 56),

    ('Um equipamento foi purgado com nitrogênio antes da manutenção. Qual risco isso cria para quem entra depois?',
     '["Queimadura química na pele", "Corrosão das ferramentas", "Asfixia, porque o nitrogênio expulsa o oxigênio e não tem cheiro nem cor", "Nenhum, porque nitrogênio não é inflamável"]', 2, 57),

    ('O serviço do dia é soldar um tanque que já armazenou inflamável. Sem o quê a solda não pode começar?',
     '["Apenas esvaziar o tanque e esperar secar", "Apenas manter a boca do tanque aberta durante a solda", "Apenas usar eletrodo de baixa temperatura", "Limpar, ventilar ou inertizar o tanque e comprovar por medição que não há atmosfera inflamável"]', 3, 58),

    ('A válvula de segurança de um vaso vive abrindo e o operador quer bloqueá-la para parar o barulho. Isso é:',
     '["Proibido: ela é a última proteção contra o rompimento do vaso, e o certo é investigar a causa da abertura", "Aceitável, desde que ele avise o supervisor", "Aceitável durante o turno da noite", "Aceitável se a pressão estiver estável no manômetro"]', 0, 59),

    ('Qual é a função do corta-chamas montado no respiro do tanque?',
     '["Medir a pressão interna do tanque", "Impedir que uma chama externa entre pelo respiro e alcance o vapor de dentro do tanque", "Filtrar a poeira do ar que entra no tanque", "Reduzir a evaporação do produto"]', 1, 60),

    ('Por que se drena a água acumulada no fundo do tanque de combustível?',
     '["Porque a água decantada favorece corrosão e contaminação, e a drenagem é feita com cuidado por sair produto junto", "Porque a água aumenta a pressão do tanque", "Porque a água apaga o inflamável", "Porque a água estraga o corta-chamas"]', 0, 61),

    ('Durante a coleta de amostra pelo topo do tanque, qual cuidado é essencial?',
     '["Coletar com a boca do tanque totalmente aberta", "Usar corda e frasco condutivos e aterrados, porque o atrito da coleta gera carga estática", "Coletar rapidamente, para diminuir a exposição", "Coletar sempre com o tanque em enchimento"]', 1, 62),

    ('Um galão plástico será abastecido com combustível. O correto é:',
     '["Abastecer com o galão dentro da caçamba, que é mais rápido", "Abastecer com o galão sobre o banco do veículo", "Abastecer com o galão suspenso pela alça", "Colocar o galão no chão, fora da caçamba ou do porta-malas, e manter o bico encostado nele durante o enchimento"]', 3, 63),

    ('Por que se exige calçado condutivo ou antiestático em algumas áreas com inflamáveis?',
     '["Para proteger o pé contra respingo quente", "Para o trabalhador ser identificado pela cor da sola", "Para escoar a carga estática do corpo para o piso, evitando faísca na hora de tocar em equipamento", "Para melhorar o conforto em piso irregular"]', 2, 64),

    ('Um equipamento elétrico será instalado em área classificada. O que se exige dele?',
     '["Ser novo e estar dentro da garantia", "Ter grau de proteção contra chuva", "Ter etiqueta de eficiência energética", "Ser certificado para a área e a zona onde vai operar, com instalação e manutenção conforme essa certificação"]', 3, 65),

    ('Na manutenção de um motor à prova de explosão, faltou uma peça original e o mecânico quer improvisar. Isso é:',
     '["Aceitável, se o motor for testado antes", "Aceitável, se o supervisor autorizar por escrito", "Inaceitável: peça fora de especificação anula a proteção do equipamento e ele deixa de ser seguro para a área", "Aceitável, se a peça for do mesmo tamanho"]', 2, 66),

    ('Para que servem o chuveiro de emergência e o lava-olhos na área de produtos químicos?',
     '["Para limpar o piso em caso de derrame", "Para lavar imediatamente e por vários minutos a pele e os olhos atingidos, antes de qualquer outro atendimento", "Para o trabalhador se refrescar no calor", "Para lavar ferramentas contaminadas"]', 1, 67),

    ('O lava-olhos do setor está atrás de caixas empilhadas e a água sai suja. O que fazer?',
     '["Liberar o acesso, comunicar a manutenção e exigir o teste periódico, porque em emergência não há tempo de improviso", "Usar assim mesmo, porque água suja é melhor que nada", "Anotar para tratar na próxima reunião mensal", "Retirar o lava-olhos até a manutenção resolver"]', 0, 68),

    ('Por que a espuma é o agente indicado em incêndio de líquido inflamável em tanque ou bacia?',
     '["Porque afunda e apaga o fogo pelo fundo", "Porque forma uma manta que cobre a superfície, abafa o fogo e impede a saída de vapor", "Porque resfria mais rápido que a água", "Porque dissolve o combustível"]', 1, 69),

    ('O sistema fixo de combate por chuveiros automáticos está com bicos encostados na pilha de caixas. Qual o problema?',
     '["A pilha atrapalha a distribuição da água e o sistema deixa de cobrir a área que deveria proteger", "Nenhum, porque o sistema tem pressão suficiente", "As caixas podem molhar quando o sistema abrir", "O sistema pode disparar sozinho por contato"]', 0, 70),

    ('O detector fixo de gás da área disparou o alarme. A conduta é:',
     '["Procurar o vazamento sozinho para ganhar tempo", "Desligar o alarme para não assustar os outros setores", "Interromper o serviço, sair pela rota prevista e não voltar até a liberação, mesmo sem sentir cheiro nenhum", "Continuar o serviço até o supervisor confirmar"]', 2, 71),

    ('Para que serve o kit de contenção de derrame que fica na área?',
     '["Para lavar o piso após o derrame", "Para transportar o produto até o depósito", "Para guardar o EPI usado no atendimento", "Para conter o produto derramado com barreiras e absorventes, impedindo que ele alcance drenos e outras áreas"]', 3, 72),

    ('Depois de conter um derrame, o material absorvente usado deve:',
     '["Ser lavado e reutilizado no próximo derrame", "Ser queimado no pátio da empresa", "Ser tratado como resíduo perigoso, guardado em recipiente identificado e destinado conforme o procedimento", "Ir para o lixo comum do setor"]', 2, 73),

    ('O que acompanha obrigatoriamente o transporte rodoviário de um produto perigoso?',
     '["A ficha de emergência e o envelope do produto, além da sinalização com painel de segurança e rótulo de risco", "Apenas a nota fiscal e o romaneio", "Apenas o certificado do motorista", "Apenas a apólice de seguro da carga"]', 0, 74),

    ('O painel laranja do caminhão traz números. Para que servem?',
     '["Indicam o peso da carga transportada", "Indicam o número da placa do veículo", "Indicam a rota autorizada para o caminhão", "Identificam o produto e o tipo de risco, permitindo que o socorro saiba o que está enfrentando"]', 3, 75),

    ('Durante a descarga do caminhão-tanque, sobre a presença de pessoas:',
     '["Ninguém precisa acompanhar, porque a bomba é automática", "A operação é acompanhada por trabalhador treinado, com a área isolada e ninguém circulando por perto", "Basta o motorista, que conhece o veículo", "Qualquer empregado pode acompanhar, para agilizar"]', 1, 76),

    ('Antes de iniciar a descarga em um tanque, o que se confere?',
     '["Se o produto é o mesmo do tanque, se há espaço suficiente e se as válvulas e conexões estão certas", "Somente o horário previsto na programação", "Somente se o motorista tem crachá de visitante", "Somente se a bomba está energizada"]', 0, 77),

    ('Por que se evita o enchimento em queda livre pelo topo do tanque?',
     '["Porque suja a parede interna do tanque", "Porque demora mais que o enchimento pelo fundo", "Porque estraga a boia de nível", "Porque o jato caindo no vazio gera carga estática e névoa inflamável dentro do tanque"]', 3, 78),

    ('Sobre o filtro químico do respirador:',
     '["Só é trocado quando quebra a rosca", "Tem validade e vida útil de uso, é escolhido conforme o contaminante e deve ser trocado no prazo ou ao sentir cheiro", "Vale enquanto o trabalhador não sentir falta de ar", "Serve para qualquer produto químico"]', 1, 79),

    ('Um trabalhador de barba cerrada precisa usar respirador com vedação facial. Qual o problema?',
     '["Nenhum, se o filtro for de maior capacidade", "Somente desconforto no uso prolongado", "A barba impede a vedação e o ar contaminado entra pelas bordas, mesmo com o filtro novo", "Nenhum, se ele apertar bem os tirantes"]', 2, 80),

    ('Antes de entrar na área com o respirador, o trabalhador deve:',
     '["Molhar a borracha para melhorar o contato", "Apenas conferir se o filtro está dentro do prazo", "Apenas apertar todos os tirantes ao máximo", "Fazer o teste de vedação, cobrindo a entrada de ar e sentindo se a máscara adere ao rosto"]', 3, 81),

    ('Como se escolhe a luva para manuseio de um produto químico?',
     '["Pela luva mais confortável para o serviço", "Pelo material indicado na FISPQ para aquele produto, porque cada borracha resiste a substâncias diferentes", "Pela luva que estiver disponível no almoxarifado", "Pela luva mais grossa, que sempre protege mais"]', 1, 82),

    ('O que o número de Certificado de Aprovação impresso no EPI comprova?',
     '["Garante a durabilidade do produto por cinco anos", "Autoriza o trabalhador a executar o serviço", "Comprova que aquele modelo foi ensaiado e aprovado para o risco a que se destina", "Comprova a data de compra do equipamento"]', 2, 83),

    ('Terminado o turno, o que se faz com o EPI que teve contato com o produto?',
     '["O EPI é higienizado e guardado em local próprio, longe do produto e da área de refeição", "Fica no chão do setor, para estar sempre à mão", "Vai para casa junto com o uniforme sujo", "É guardado dentro do armário de produtos químicos"]', 0, 84),

    ('O trabalhador percebe que a luva está furada no meio do serviço. O correto é:',
     '["Colocar a segunda luva por cima da furada", "Parar, substituir a luva e só depois retomar, porque EPI danificado não protege", "Terminar o serviço e trocar no fim do turno", "Virar a luva do avesso e continuar"]', 1, 85),

    ('Para que serve a ordem de serviço entregue ao trabalhador?',
     '["Definir o valor do adicional de periculosidade", "Substituir o treinamento admissional", "Informar por escrito os riscos da função, as medidas de prevenção e o que a empresa exige dele", "Registrar o horário de entrada e saída"]', 2, 86),

    ('O procedimento escrito de partida e parada da unidade serve para:',
     '["Garantir que a sequência seja sempre a mesma, na ordem segura, mesmo trocando o operador", "Registrar o consumo de energia da unidade", "Servir de consulta apenas para a manutenção", "Cumprir exigência do cliente"]', 0, 87),

    ('Na passagem de turno em uma unidade com inflamáveis, o que precisa ser informado?',
     '["Apenas a produção do turno", "Apenas os equipamentos que quebraram", "Apenas o que o supervisor perguntar", "O que está em andamento, o que está bloqueado, os alarmes ocorridos e as pendências de segurança"]', 3, 88),

    ('Um trabalhador recém-admitido já capacitado vai atuar na área. O que ainda é necessário?',
     '["Somente entregar o crachá de acesso à área", "Somente informar o número do ramal da emergência", "Acompanhamento por trabalhador experiente até que ele domine o procedimento da instalação", "Nada, porque o certificado dele é válido"]', 2, 89),

    ('A Permissão de Trabalho venceu e o serviço não terminou. O que fazer?',
     '["Continuar até acabar, porque a análise já foi feita", "Anotar o novo horário na própria permissão", "Pedir ao colega que assine a prorrogação", "Parar o serviço e providenciar a renovação, com nova avaliação das condições da área"]', 3, 90),

    ('A condição do serviço mudou no meio da tarefa: apareceu vazamento próximo e o vento virou. E a análise de risco?',
     '["Precisa ser revista com a equipe antes de continuar, porque foi feita para outra condição", "Continua valendo, porque a tarefa é a mesma", "Só é revista no dia seguinte", "Só é revista se o supervisor pedir"]', 0, 91),

    ('Durante uma entrada em espaço confinado na área de inflamáveis, o vigia:',
     '["Só é necessário se o espaço for muito profundo", "Fica do lado de fora o tempo todo, em contato com quem entrou, sem executar outra tarefa", "Entra junto para ajudar no serviço", "Pode se ausentar para buscar ferramenta"]', 1, 92),

    ('O colega desmaiou dentro do espaço confinado. Qual a conduta do vigia?',
     '["Acionar o resgate e não entrar: entrada sem equipamento e sem treinamento transforma um acidente em dois", "Entrar rápido, porque cada segundo conta", "Entrar prendendo a respiração", "Jogar água para reanimar o colega"]', 0, 93),

    ('O serviço será feito no topo do tanque, a mais de dois metros. O que se aplica além da NR-20?',
     '["Apenas a autorização do supervisor da área", "As exigências de trabalho em altura, com análise de risco, ponto de ancoragem definido e plano de resgate", "Nada, porque o risco principal é o inflamável", "Apenas o uso de capacete com jugular"]', 1, 94),

    ('Sobre a linha de vida instalada no topo do tanque:',
     '["Pode ser improvisada com corda de içamento", "Serve também para amarrar ferramenta e material", "Só é necessária quando o tanque está cheio", "Precisa ser dimensionada por profissional habilitado e inspecionada antes do uso"]', 3, 95),

    ('Em uma emergência com nuvem de vapor, para onde o trabalhador deve se deslocar?',
     '["Para o ponto mais baixo do terreno", "Para dentro do prédio mais próximo", "Contra o vento, subindo para o ponto de encontro previsto, longe da direção para onde o vapor caminha", "Na mesma direção do vento, para sair mais rápido"]', 2, 96),

    ('Como a empresa sabe que todos saíram da área durante o abandono?',
     '["Pelo aviso do rádio do supervisor", "Pela contagem dos carros no estacionamento", "Pela leitura do relógio de ponto", "Pela contagem no ponto de encontro, comparada com a lista de quem estava na área"]', 3, 97),

    ('O incêndio cresceu e passou do princípio. O que a equipe da área faz?',
     '["Espera o fogo diminuir para reiniciar o combate", "Tenta retirar os tambores de perto do fogo", "Abandona, aciona a brigada e o corpo de bombeiros e atua só no que foi treinada e com recurso adequado", "Continua o combate com extintores até acabar a carga"]', 2, 98),

    ('Quando a área pode ser reocupada após a emergência?',
     '["Quando o pessoal do turno seguinte chegar", "Somente após a liberação de quem coordena a emergência, com medição da atmosfera e conferência da área", "Assim que o fogo apagar", "Assim que o alarme parar de tocar"]', 1, 99),

    ('O que é essencial informar ao corpo de bombeiros ao acionar o socorro?',
     '["Qual produto está envolvido, a quantidade, o local exato e se há vítimas", "Somente o endereço da empresa", "Somente o nome do responsável pela área", "Somente o horário em que o fogo começou"]', 0, 100),

    ('Um colega inalou vapores e está confuso, no meio da área. A conduta é:',
     '["Jogar água no rosto dele de longe", "Garantir a própria segurança, retirar a vítima para local ventilado com o recurso adequado e acionar socorro", "Entrar correndo e carregar a vítima sem proteção", "Esperar que ele saia sozinho"]', 1, 101),

    ('Um trabalhador engoliu produto ao sifonar com a boca. O que NÃO se deve fazer?',
     '["Provocar vômito, porque o produto pode voltar e chegar ao pulmão", "Acionar o socorro imediatamente", "Levar a FISPQ do produto junto com a vítima", "Manter a vítima em repouso e observada"]', 0, 102),

    ('Respingo de produto químico na pele. A primeira medida é:',
     '["Neutralizar com outro produto químico", "Esfregar com pano seco para remover o excesso", "Retirar a roupa contaminada e lavar a região com água corrente por vários minutos", "Passar pomada e cobrir com gaze"]', 2, 103),

    ('O uniforme do trabalhador ficou encharcado de solvente. O correto é:',
     '["Continuar o serviço até secar naturalmente", "Secar a roupa perto de uma fonte de calor", "Passar pano para retirar o excesso e seguir", "Afastar-se da área, retirar a roupa em local seguro e ventilado e lavar o corpo, porque a roupa ficou uma fonte de vapor"]', 3, 104),

    ('Limpar a roupa ou o corpo com jato de ar comprimido é:',
     '["Permitido, se for feito longe do tanque", "Permitido, se o colega ajudar a segurar a roupa", "Proibido: o ar comprimido pode injetar sujeira e produto na pele e gerar eletricidade estática", "Permitido, se a pressão for baixa"]', 2, 105),

    ('Uma linha cheia de produto ficou bloqueada nos dois lados e o sol bateu nela o dia todo. Qual o risco?',
     '["O líquido dilata, a pressão sobe e a linha ou a conexão pode romper", "O produto perde as características e vira água", "A linha esfria e trinca", "Nenhum, porque a linha é fechada"]', 0, 106),

    ('Para que serve a identificação das tubulações por cor, nome do produto e seta de sentido?',
     '["Para facilitar a pintura da manutenção", "Para diferenciar as tubulações por setor de custo", "Para atender exigência do cliente da unidade", "Para que qualquer trabalhador saiba o que passa ali e para onde vai, antes de mexer na linha"]', 3, 107),

    ('Antes de abrir uma válvula na área, o correto é:',
     '["Confiar na memória de quem já fez a manobra", "Conferir a linha e a identificação no local, confirmando com o procedimento e com quem coordena a manobra", "Abrir devagar e observar o que sai", "Abrir e fechar rápido para testar"]', 1, 108),

    ('Na solda dentro da área, onde se prende a garra de retorno da máquina?',
     '["O mais próximo possível do ponto soldado, na própria peça, para a corrente não procurar caminho por tubulação e gerar faísca", "Em qualquer estrutura metálica do galpão", "Na tubulação de produto mais próxima", "No corrimão da plataforma"]', 0, 109),

    ('O carro de solda e o cilindro precisam ficar dentro da área classificada durante o serviço?',
     '["Sim, para reduzir o comprimento do cabo", "Sim, para o soldador não precisar se deslocar", "Tanto faz, desde que haja permissão de trabalho", "Não: fica fora da área sempre que possível, com a mangueira e o cabo estendidos até o ponto"]', 3, 110),

    ('Será preciso posicionar um gerador a diesel para atender um serviço na unidade. Como isso é tratado?',
     '["Apenas operar em velocidade reduzida", "Posicionar fora da área classificada, na direção contra o vento, com avaliação de risco e autorização", "Nada, porque o motor é fechado", "Apenas manter o extintor ao lado"]', 1, 111),

    ('Uma empilhadeira comum vai entrar na área de armazenamento de inflamáveis. Isso é:',
     '["Permitido se o operador for treinado em NR-20", "Permitido se o serviço durar poucos minutos", "Permitido apenas se ela for adequada para a área classificada ou se a área for previamente liberada e avaliada", "Permitido sempre, porque ela é elétrica"]', 2, 112),

    ('Por que inflamáveis e produtos oxidantes não podem ser guardados juntos?',
     '["Porque um estraga o rótulo do outro", "Porque ocupam muito espaço no mesmo corredor", "Porque o oxidante enferruja o tambor do inflamável", "Porque o oxidante alimenta a combustão e, em contato ou em caso de vazamento, o conjunto pode incendiar violentamente"]', 3, 113),

    ('Sobre a distância entre as pilhas de tambores e as paredes, portas e saídas do depósito:',
     '["Basta manter livre o corredor central", "Precisa existir espaço para circulação, inspeção e combate, e as saídas e equipamentos ficam sempre livres", "Encostar na parede economiza espaço e é permitido", "A distância só vale para produtos tóxicos"]', 1, 114),

    ('Um tambor está vazio, mas cheirando a solvente. Ele é perigoso?',
     '["Não, se ficar com a tampa aberta", "Só se ficar exposto ao sol", "Sim: o tambor vazio contém vapor, que é justamente a parte que explode", "Não, porque não tem mais líquido dentro"]', 2, 115),

    ('Cortar ou soldar um tambor que continha inflamável é:',
     '["Proibido sem limpeza, inertização e comprovação por medição de que não há atmosfera inflamável", "Permitido se o tambor for lavado com água", "Permitido se o corte for feito com serra manual", "Permitido se o tambor estiver aberto há dias"]', 0, 116),

    ('Durante o abastecimento de um veículo na empresa, o motor deve:',
     '["Ficar ligado somente se o tanque estiver quase vazio", "Ficar desligado, com o veículo travado e sem ninguém fumando ou usando aparelho não adequado por perto", "Ficar ligado, para não descarregar a bateria", "Ficar ligado em marcha lenta, para o combustível assentar"]', 1, 117),

    ('Como se procura um vazamento em conexão de GLP?',
     '["Pelo cheiro, encostando o rosto na conexão", "Apertando todas as conexões com a chave", "Com espuma de água e sabão aplicada na conexão, observando a formação de bolhas", "Com a chama de um isqueiro, aproximando devagar"]', 2, 118),

    ('Como devem ficar os cilindros de gás guardados na área?',
     '["Na vertical, presos por corrente ou cinta, com capacete de proteção da válvula e longe de fonte de calor", "Deitados no chão, para não tombarem", "Empilhados uns sobre os outros", "Encostados na parede, sem prender"]', 0, 119),

    ('Por que não se pode usar graxa ou óleo em válvulas e conexões de oxigênio?',
     '["Porque a graxa entope o regulador", "Porque a graxa contamina a solda", "Porque o óleo deixa a conexão escorregadia", "Porque a gordura em contato com oxigênio sob pressão pode inflamar violentamente"]', 3, 120),

    ('Para que serve a válvula corta-chamas do maçarico oxiacetilênico?',
     '["Facilitar o acendimento do maçarico", "Reduzir o consumo de gás", "Impedir o retrocesso da chama pela mangueira até o cilindro", "Regular a pressão do gás no bico"]', 2, 121),

    ('Sobre as mangueiras do maçarico e do conjunto de solda:',
     '["Podem ser emendadas com fita isolante se estiverem furadas", "Podem passar por cima de qualquer piso da área", "Só precisam ser trocadas quando param de passar gás", "São inspecionadas antes do uso, sem remendo, com abraçadeira própria e protegidas de passagem de veículo"]', 3, 122),

    ('Sobre o registro do treinamento de NR-20 do trabalhador:',
     '["A empresa mantém o registro com conteúdo, carga horária, data e instrutor, à disposição da fiscalização", "Basta o trabalhador guardar o certificado em casa", "O registro só é necessário para o pessoal da manutenção", "O registro é substituído pela lista de presença da integração"]', 0, 123),

    ('Por que o treinamento inclui parte prática, com equipamento e simulação?',
     '["Porque a prática é exigida apenas para brigadistas", "Porque em emergência o trabalhador repete o que já fez com as mãos, não o que só ouviu na sala", "Porque a parte prática substitui a prova teórica", "Porque a carga horária precisa ser preenchida"]', 1, 124),

    ('Um trabalhador não conseguiu acompanhar o treinamento e não domina o procedimento. O correto é:',
     '["Reforçar a capacitação e não liberá-lo para a atividade até que ele demonstre que sabe executar", "Liberar assim mesmo, com acompanhamento do colega de turno", "Liberar apenas nas tarefas do turno da noite", "Registrar a presença e seguir com a programação"]', 0, 125),

    ('O trabalhador não entendeu um passo do procedimento no meio da tarefa. O que fazer?',
     '["Perguntar ao final do serviço", "Parar e perguntar antes de continuar, porque tentativa e erro em área com inflamável não tem segunda chance", "Fazer do jeito que achar mais lógico", "Pular o passo e seguir para o próximo"]', 1, 126),

    ('Para que serve a sinalização de proibição de fontes de ignição na entrada da área?',
     '["Indicar o horário de funcionamento da área", "Marcar a área de responsabilidade da manutenção", "Cumprir exigência da seguradora", "Avisar todos, inclusive quem não trabalha ali, de que não se entra com chama, faísca ou equipamento não adequado"]', 3, 127),

    ('Por que a empresa exige que isqueiros e fósforos fiquem na portaria?',
     '["Porque atrapalha o uso do EPI", "Porque o plástico do isqueiro derrete no calor", "Porque basta uma fonte de ignição para uma atmosfera inflamável se tornar incêndio ou explosão", "Porque isqueiro é objeto de valor e pode ser furtado"]', 2, 128),

    ('Quem pode entrar na área de armazenamento e processo de inflamáveis?',
     '["Entra qualquer empregado da empresa", "Entra quem estiver acompanhado de um colega", "Entra quem tiver crachá, sem outra exigência", "Só entra quem está autorizado, capacitado e com o EPI da área, e o acesso é registrado"]', 3, 129),

    ('Um visitante precisa entrar na unidade. O correto é:',
     '["Entrar apenas com colete de identificação", "Entrar e assinar o livro de visitas na saída", "Receber orientação sobre os riscos, as regras e a rota de fuga, com EPI e acompanhamento o tempo todo", "Entrar sozinho, se ficar longe dos tanques"]', 2, 130),

    ('Uma empresa contratada vai executar serviço na unidade. Sobre a capacitação da equipe dela:',
     '["Basta a equipe usar o uniforme da contratante", "A contratante verifica se os trabalhadores são capacitados no nível exigido antes de liberar o serviço", "A contratada resolve isso por conta própria, sem verificação", "Basta a contratada apresentar o contrato de prestação de serviço"]', 1, 131),

    ('Para que serve a inspeção periódica das áreas e dos equipamentos com inflamáveis?',
     '["Encontrar desvio, corrosão, vazamento e improviso antes que virem acidente, com prazo e responsável pela correção", "Avaliar o desempenho dos operadores do setor", "Levantar o inventário de produtos para compras", "Cumprir exigência interna do setor de qualidade"]', 0, 132),

    ('O que é um incêndio em nuvem de vapor, o chamado flash fire?',
     '["Um curto-circuito em painel elétrico", "A queima rápida da nuvem formada por um vazamento, que atinge quem estiver no caminho dela", "Um fogo lento na superfície do líquido", "A queima do isolamento térmico da tubulação"]', 1, 133),

    ('O que é o fenômeno conhecido como BLEVE?',
     '["O rompimento violento de um vaso com líquido sob pressão aquecido pelo fogo, com bola de fogo e projeção de estilhaços", "O apagamento súbito da chama por falta de oxigênio", "O acúmulo de vapor no piso do galpão", "A formação de gelo na saída da válvula"]', 0, 134),

    ('Um vazamento formou uma poça em chamas. O que agrava a situação?',
     '["A poça estar longe da parede", "A temperatura ambiente estar baixa", "A poça continuar crescendo porque o vazamento não foi cortado e não há contenção", "O piso ser de concreto"]', 2, 135),

    ('Por que a explosão de vapor é mais destrutiva dentro de um prédio fechado do que em área aberta?',
     '["Porque em ambiente fechado há mais oxigênio", "Porque em área aberta o vapor não queima", "Porque o vapor esfria mais rápido lá fora", "Porque a pressão fica confinada e arrebenta a estrutura, em vez de se dissipar no ambiente"]', 3, 136),

    ('Ao combater fogo em vazamento de gás, por que não se deve apagar a chama antes de cortar o fornecimento?',
     '["Porque a chama protege o operador do calor", "Porque a chama consome o oxigênio da área", "Porque o gás continua saindo e forma uma nuvem que pode explodir ao encontrar outra fonte de ignição", "Porque o extintor não funciona em gás"]', 2, 137),

    ('Qual é a finalidade do acionamento de parada de emergência da unidade?',
     '["Interromper rapidamente o processo e as bombas de forma segura, a partir de local acessível", "Desligar somente a iluminação da área", "Reiniciar o sistema após uma falha", "Testar o alarme sonoro da unidade"]', 0, 138),

    ('Para que servem as válvulas de bloqueio acionadas à distância?',
     '["Facilitar a manutenção programada", "Reduzir a perda de carga da linha", "Permitir a operação com menos gente no turno", "Cortar o fluxo do produto sem que alguém precise entrar na área tomada pelo vazamento ou pelo fogo"]', 3, 139),

    ('Para que serve a iluminação de emergência nas rotas de fuga da unidade?',
     '["Sinalizar o local dos extintores durante o dia", "Permitir o abandono seguro quando a energia cai, que é justamente o que acontece em muitas emergências", "Economizar energia no turno da noite", "Iluminar o pátio para a vigilância"]', 1, 140),

    ('O alarme sonoro e visual do detector portátil dispara. A conduta imediata é:',
     '["Interromper o serviço e sair do local no sentido contrário ao vapor, comunicando a equipe", "Continuar até terminar o passo em andamento", "Silenciar o alarme e observar o valor da leitura", "Aproximar o detector do ponto para confirmar"]', 0, 141),

    ('Ao medir a atmosfera de um espaço confinado antes da entrada, a medição é feita:',
     '["Só na boca do espaço, que é onde se entra", "Só no fundo, onde tudo se acumula", "Em um ponto qualquer, desde que o aparelho esteja calibrado", "Em várias alturas, porque gases e vapores se distribuem de forma diferente conforme a densidade"]', 3, 142),

    ('Em que sequência os gases são medidos antes de a equipe entrar no espaço confinado?',
     '["A ordem não importa, desde que os três sejam medidos", "Oxigênio, depois gases e vapores inflamáveis e depois os tóxicos", "Tóxicos, inflamáveis e por último oxigênio", "Inflamáveis, oxigênio e por último tóxicos"]', 1, 143),

    ('A leitura de gases inflamáveis subiu acima do limite estabelecido no procedimento. O que se faz?',
     '["Aumenta o número de medições e continua", "Troca o detector por outro aparelho e continua", "Interrompe o serviço, retira a equipe e só retorna após ventilar e comprovar a atmosfera segura", "Reduz o ritmo do serviço e continua"]', 2, 144),

    ('Por que a medição pontual antes da entrada não substitui o monitoramento contínuo?',
     '["Porque o aparelho pode ter erro de leitura na primeira medição", "Porque a norma exige duas medições por escrito", "Porque a primeira medição não conta como registro", "Porque a atmosfera pode mudar durante o serviço, com o próprio trabalho gerando vapor ou consumindo oxigênio"]', 3, 145),

    ('Sobre a calibração e o ajuste do detector de gases:',
     '["Não são necessários em aparelhos novos", "São feitos por pessoa capacitada, com periodicidade definida e registro, além da verificação antes do uso", "Só são necessários quando o aparelho apresenta defeito", "São feitos pelo próprio usuário no início do turno, sem registro"]', 1, 146),

    ('Por que o rádio comunicador usado na área precisa ser de modelo específico?',
     '["Porque a bateria dura mais tempo", "Porque ele resiste melhor à chuva", "Porque só o equipamento certificado para área classificada não gera faísca capaz de iniciar a ignição", "Porque só ele alcança toda a unidade"]', 2, 147),

    ('Uma furadeira comum será usada em um ponto dentro da área classificada. O correto é:',
     '["Não usar: só entra ferramenta adequada à área ou, se não houver, a área é liberada e avaliada antes", "Usar com extensão longa, ligada fora da área", "Usar por pouco tempo e com o extintor ao lado", "Usar com o operador de luva isolante"]', 0, 148),

    ('Terminado o serviço na área, o que precisa ser feito antes de liberar o local?',
     '["Apenas anotar o horário de término na permissão", "Retirar ferramentas, resíduos e sobra de produto, restabelecer as proteções e comunicar a liberação a quem opera", "Apenas avisar o supervisor por rádio", "Apenas recolher os EPIs da equipe"]', 1, 149),

    ('Um trabalhador enxerga um jeito mais rápido de fazer a tarefa, diferente do procedimento. O correto é:',
     '["Fazer do jeito novo apenas quando estiver sozinho", "Fazer do jeito novo se o colega concordar", "Propor a mudança pelo caminho previsto, para ser avaliada, e continuar executando conforme o procedimento", "Fazer do jeito novo e mostrar o resultado depois"]', 2, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-20';


-- =====================================================================
--  BRIG — Brigada de incêndio e primeiros socorros (questões 41 a 150)
--  As 40 primeiras cobrem o básico do fogo e do socorro. Aqui entram o
--  hidrante, os sistemas fixos, a organização da brigada e a parte do
--  atendimento que o brigadista faz enquanto o socorro não chega.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'BRIG')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O que caracteriza o fogo de classe A?',
     '["Queima líquidos que evaporam sem deixar resíduo", "Envolve equipamento elétrico energizado", "Envolve metais que reagem com água", "Queima materiais sólidos comuns, como madeira, papel e tecido, deixando resíduo e queimando em profundidade"]', 3, 41),

    ('O que muda quando o fogo é de classe C?',
     '["O combate só pode ser feito pelo bombeiro", "Há equipamento energizado envolvido, e o agente precisa ser não condutor até a energia ser cortada", "O fogo queima mais devagar que nos outros casos", "A água passa a ser o agente mais indicado"]', 1, 42),

    ('Por que o brigadista nunca ataca um foco sem ter uma rota de saída às suas costas?',
     '["Porque o fogo pode crescer ou mudar de direção, e sem caminho livre para recuar ele fica preso", "Porque a saída precisa ficar livre para a chegada do corpo de bombeiros", "Porque o extintor perde pressão quando o operador se movimenta", "Porque a rota de saída marca a distância correta de ataque"]', 0, 43),

    ('Para que serve a sinalização de classes impressa no corpo do extintor?',
     '["Indicar o peso do extintor cheio", "Indicar o mês da última recarga", "Mostrar em que tipo de fogo aquele extintor pode ser usado, evitando o agente errado na hora do aperto", "Indicar o fabricante do equipamento"]', 2, 44),

    ('Qual cuidado o extintor de CO2 exige durante o uso?',
     '["Usar somente com o cilindro deitado", "Segurar pelo punho e não pelo difusor, que fica muito frio e pode causar queimadura por congelamento", "Sacudir o cilindro antes de acionar", "Aproximar o difusor até encostar na chama"]', 1, 45),

    ('Qual é a diferença prática entre o extintor de pó ABC e o de pó BC?',
     '["O ABC também atua em materiais sólidos, porque o pó forma uma crosta que abafa a brasa", "O ABC tem maior alcance de jato", "O BC pode ser usado em equipamento energizado e o ABC não", "O BC dura mais tempo de descarga"]', 0, 46),

    ('Por que a água é o agente mais indicado em fogo de material sólido?',
     '["Porque separa o material do oxigênio de forma permanente", "Porque interrompe a reação química da chama", "Porque resfria o material abaixo da temperatura de queima e alcança a brasa em profundidade", "Porque abafa o fogo cobrindo a superfície"]', 2, 47),

    ('O que o brigadista precisa saber sobre o tempo de descarga de um extintor portátil?',
     '["Que dura vários minutos, permitindo pausas durante o combate", "Que depende apenas do tamanho do fogo", "Que pode ser interrompido e retomado sem perda de pressão", "Que é curto, de poucos segundos, e por isso ele só se aproxima quando estiver pronto para atacar"]', 3, 48),

    ('Ao se aproximar de um princípio de incêndio em área aberta, o brigadista deve se posicionar:',
     '["A favor do vento, com o vento nas costas, para não receber calor, fumaça e o próprio agente de volta", "Contra o vento, para o agente chegar mais rápido", "De lado, com o vento cruzando o rosto", "Onde houver mais espaço para recuar, sem considerar o vento"]', 0, 49),

    ('Dois brigadistas vão atacar o mesmo foco com extintores. O correto é:',
     '["Um ataca e o outro guarda o extintor de reserva sem se posicionar", "Cada um escolhe o lado que achar melhor no momento", "Atacar juntos e pelo mesmo lado, de forma coordenada, sem ficar um de frente para o outro", "Atacar por lados opostos, para cercar o fogo"]', 2, 50),

    ('Antes de chegar perto do fogo com o extintor, o brigadista deve:',
     '["Acionar por completo para verificar o alcance", "Sacudir o extintor para soltar o pó", "Retirar o lacre somente ao encostar no fogo", "Retirar o pino e dar um breve acionamento de teste, a uma distância segura, para confirmar que o equipamento funciona"]', 3, 51),

    ('Qual é a distância correta para atacar um princípio de incêndio com extintor portátil?',
     '["Sempre exatos dez metros, qualquer que seja o extintor", "A menor distância em que o agente alcança a base do fogo com segurança, avançando conforme o fogo cede", "O mais longe possível, para não sentir calor", "Encostado no foco, para o agente não se dispersar"]', 1, 52),

    ('Para montar a linha de mangueira do hidrante, o brigadista precisa:',
     '["Engatar somente o esguicho e deixar a outra ponta livre", "Estender a mangueira dobrada, para desenrolar com a pressão", "Estender a mangueira sem dobras, engatar corretamente na saída e no esguicho e só então abrir o registro", "Abrir o registro primeiro, para ganhar tempo"]', 2, 53),

    ('Por que a linha de hidrante costuma exigir mais de uma pessoa?',
     '["Porque a mangueira é pesada demais para uma pessoa carregar", "Porque um precisa ficar contando o tempo de uso", "Porque a norma proíbe trabalho isolado em qualquer situação", "Porque a reação do esguicho empurra quem segura, e outro brigadista dá apoio e controla a mangueira"]', 3, 54),

    ('Por que o registro do hidrante só é aberto depois que a linha está montada?',
     '["Porque a pressão da rede demora a estabilizar", "Porque a mangueira pressurizada se torna difícil de manejar e a ponta solta chicoteia", "Porque a água suja a área antes da hora", "Porque o registro pode travar se for aberto antes"]', 1, 55),

    ('Uma dobra fechada na mangueira durante o combate causa:',
     '["Estrangulamento do fluxo, queda de vazão no esguicho e risco de rompimento da mangueira", "Aumento da pressão no esguicho, o que ajuda no alcance", "Nenhum efeito, porque a água contorna a dobra", "Apenas desconforto para quem segura"]', 0, 56),

    ('Depois de usar a mangueira do hidrante, o correto é:',
     '["Enrolar molhada e devolver ao abrigo", "Deixar estendida no pátio até a próxima manutenção", "Descartar, porque mangueira usada não serve mais", "Lavar, secar e recolher conforme o padrão do abrigo, e comunicar para que ela seja recolocada em condição de uso"]', 3, 57),

    ('Para que serve o ensaio periódico das mangueiras de incêndio?',
     '["Verificar se elas suportam a pressão de trabalho sem vazar ou romper, retirando de serviço as reprovadas", "Medir o comprimento exato de cada lance", "Conferir a cor e a identificação do lote", "Substituir a inspeção visual do abrigo"]', 0, 58),

    ('O abrigo de hidrante está trancado e a chave fica na sala do supervisor. Isso é:',
     '["Aceitável durante o horário administrativo", "Inaceitável: o equipamento de emergência precisa estar acessível de imediato a quem for usá-lo", "Aceitável, porque evita furto do material", "Aceitável, se a sala do supervisor for próxima"]', 1, 59),

    ('Quando o brigadista usa o esguicho em neblina em vez de jato compacto?',
     '["Quando o fogo é em equipamento energizado, sempre", "Quando quer economizar água na rede", "Quando precisa de proteção contra o calor, resfriar ambiente ou abater fumaça, porque a neblina cobre mais área", "Quando precisa alcançar um foco distante"]', 2, 60),

    ('Para que serve o acionador manual de alarme instalado nos corredores?',
     '["Abrir as portas de emergência automaticamente", "Permitir que qualquer pessoa que perceba o incêndio avise todo o prédio de imediato", "Chamar diretamente o corpo de bombeiros", "Desligar a energia elétrica do pavimento"]', 1, 61),

    ('O detector de fumaça disparou e ninguém vê fogo. A conduta da brigada é:',
     '["Desligar o detector para parar o barulho", "Aguardar um segundo disparo para agir", "Verificar o local indicado pela central antes de considerar alarme falso, porque o detector pode ter visto o começo", "Ignorar, porque não há fumaça visível no corredor"]', 2, 62),

    ('Uma pilha de caixas ficou encostada nos bicos do sistema de chuveiros automáticos. Qual o problema?',
     '["A água não se espalha como projetada e a área fica sem a proteção com que todos contam", "As caixas podem molhar quando o sistema abrir", "O sistema pode disparar por peso sobre o bico", "Nenhum, se as caixas forem de material não combustível"]', 0, 63),

    ('A porta corta-fogo do corredor vive calçada aberta para facilitar a circulação. Isso é:',
     '["Aceitável durante o expediente", "Aceitável, se houver extintor por perto", "Aceitável, desde que o calço seja retirado à noite", "Errado: aberta, ela deixa de conter fumaça e fogo e a escada de fuga é justamente o que ela protege"]', 3, 64),

    ('Durante um incêndio, o elevador:',
     '["Não deve ser usado, porque pode parar no pavimento em chamas ou ficar preso com a queda de energia", "Pode ser usado, se for mais rápido que a escada", "Pode ser usado para levar o material da brigada", "Pode ser usado por quem tem dificuldade de locomoção, em qualquer situação"]', 0, 65),

    ('Como o abandono deve acontecer na escada?',
     '["Correndo, para ganhar tempo", "Ocupando toda a largura, para sair mais gente por vez", "Em silêncio absoluto, sem contato com o corrimão", "Em fila, sem correr, mantendo-se de um lado e com a mão no corrimão, para não haver queda em massa"]', 3, 66),

    ('Para que serve a iluminação de emergência junto com a sinalização das rotas?',
     '["Indicar onde ficam os extintores durante o dia", "Reduzir o consumo de energia da edificação", "Permitir enxergar o caminho e as saídas quando a energia cai ou a fumaça reduz a visibilidade", "Iluminar o prédio fora do expediente"]', 2, 67),

    ('A saída de emergência do setor vive trancada por causa de furtos. Como resolver?',
     '["Trancando somente fora do horário de expediente", "Com dispositivo que permita a abertura por dentro a qualquer momento, sem chave, mantendo o controle pelo lado de fora", "Deixando a chave pendurada ao lado da porta", "Mantendo trancada e treinando todos a usarem outra saída"]', 1, 68),

    ('Como a brigada de emergência costuma ser organizada?',
     '["Com um único responsável, que decide tudo sozinho no local", "Por sorteio entre os presentes no momento da ocorrência", "Com uma estrutura de comando definida, com chefe, líderes e brigadistas, e atribuições conhecidas por todos", "Sem hierarquia: na emergência cada um faz o que puder"]', 2, 69),

    ('Quem decide o abandono da edificação?',
     '["O setor de recursos humanos", "Quem coordena a emergência conforme o plano, e a ordem é transmitida a todos por meio previamente definido", "O primeiro brigadista que chegar ao local", "Cada setor decide por conta própria"]', 1, 70),

    ('Fora das emergências, o que o brigadista faz?',
     '["Nada, porque a função só existe durante a emergência", "Apenas comparece à reunião mensal", "Apenas guarda o crachá de brigadista", "Participa das inspeções, verifica equipamentos e rotas, treina e ajuda a corrigir o que estiver irregular"]', 3, 71),

    ('Sobre a reciclagem do treinamento de brigada:',
     '["É periódica, com prática, porque técnica de socorro e combate se perde rápido quando não se treina", "Só é necessária se houver mudança na edificação", "Só é necessária para quem nunca atendeu uma ocorrência", "Não existe: o certificado de brigadista não vence"]', 0, 72),

    ('Como um trabalhador se torna brigadista?',
     '["Por determinação do encarregado, sem consulta", "Por ser o mais antigo do setor", "Por ter feito curso de primeiros socorros fora da empresa", "Por indicação e aceite voluntário, com avaliação de saúde e condições para a função, além do treinamento"]', 3, 73),

    ('O que o plano de emergência da edificação precisa deixar claro?',
     '["Somente a lista dos brigadistas por turno", "Quem faz o quê, como se dá o alarme, por onde se abandona, onde é o ponto de encontro e quais recursos existem", "Somente o telefone do corpo de bombeiros", "Somente a planta do prédio com os extintores"]', 1, 74),

    ('Depois de um simulado de abandono, o que precisa acontecer?',
     '["Avaliação do que funcionou e do que falhou, com registro e correção antes do próximo simulado", "Apenas o registro da presença dos participantes", "Apenas o aviso de que o prédio foi liberado", "Nada, porque o simulado é um exercício isolado"]', 0, 75),

    ('Em que situação se faz um abandono parcial em vez de total?',
     '["Quando o incêndio é em horário administrativo", "Quando a saída principal está muito cheia", "Quando o plano prevê que apenas a área atingida e as vizinhas saem, sem expor as demais a um deslocamento desnecessário", "Quando o número de brigadistas é pequeno"]', 2, 76),

    ('Como o plano trata as pessoas com dificuldade de locomoção durante o abandono?',
     '["Determina que saiam por último, sem acompanhamento", "Define antes quem acompanha cada uma, por qual rota e onde aguardam com segurança até a retirada", "Improvisa no momento, com quem estiver por perto", "Deixa que usem o elevador em qualquer situação"]', 1, 77),

    ('Como se trata a segurança de visitantes e prestadores durante uma emergência?',
     '["Eles recebem orientação na entrada e são conduzidos pelo pessoal do setor que os recebeu até o ponto de encontro", "Eles se viram sozinhos, porque não conhecem o prédio", "Eles ficam no local até alguém buscá-los", "Eles saem apenas se estiverem acompanhados de brigadista"]', 0, 78),

    ('Ao chegar o corpo de bombeiros, quem informa se falta alguém no prédio?',
     '["Cada setor, quando for perguntado", "O setor de pessoal, no dia seguinte", "A brigada, com base na conferência feita no ponto de encontro, informando quem falta e onde a pessoa estava", "A portaria, pela lista de crachás recolhidos"]', 2, 79),

    ('Qual é o papel da brigada na chegada do corpo de bombeiros?',
     '["Assumir o comando da operação junto com eles", "Continuar o combate por dentro enquanto eles se preparam", "Aguardar no ponto de encontro sem contato", "Receber, indicar o acesso, informar o que já foi feito, o que está em chamas e onde estão os riscos e recursos"]', 3, 80),

    ('Quando o corpo de bombeiros assume a ocorrência, a brigada:',
     '["Passa as informações e fica à disposição, atuando em apoio conforme for orientada", "Encerra suas funções e libera os brigadistas", "Continua o combate de forma independente", "Assume o isolamento externo sem comunicar nada"]', 0, 81),

    ('O que é o rescaldo depois de um incêndio?',
     '["O relatório final da ocorrência", "A recarga dos extintores utilizados", "A verificação e o resfriamento do que restou, para eliminar focos escondidos que podem reacender", "A limpeza e a retirada dos escombros da área"]', 2, 82),

    ('Por que a área da ocorrência é isolada e preservada depois do incêndio?',
     '["Para permitir a limpeza sem interrupção", "Para evitar o furto de material", "Para o setor de manutenção trabalhar sem gente por perto", "Porque a estrutura pode estar comprometida e porque o local guarda as informações para a investigação da causa"]', 3, 83),

    ('Quando as pessoas podem voltar ao prédio depois de uma emergência?',
     '["Quando o horário de trabalho recomeçar", "Somente após a liberação formal de quem coordena a emergência ou do corpo de bombeiros", "Quando parar a fumaça visível", "Quando o alarme for desligado"]', 1, 84),

    ('Como deve ser a comunicação por rádio durante a emergência?',
     '["Restrita ao chefe da brigada, sem retorno das equipes", "Substituída pelo celular pessoal de cada brigadista", "Curta, objetiva e apenas com o necessário, para o canal não ficar tomado e a informação chegar a quem coordena", "Livre, com todos relatando o que veem ao mesmo tempo"]', 2, 85),

    ('O que significa a ideia de cadeia de sobrevivência no atendimento à parada cardíaca?',
     '["Aguardar o socorro especializado antes de qualquer manobra", "Atender apenas quando houver dois socorristas", "Fazer somente ventilações até o socorro chegar", "Reconhecer rápido, chamar socorro, iniciar as compressões e usar o desfibrilador o quanto antes, sem quebrar os elos"]', 3, 86),

    ('Como devem ser as compressões torácicas em um adulto?',
     '["Com pausa longa a cada cinco compressões", "Rápidas e fortes, no centro do peito, permitindo o retorno do tórax entre uma e outra", "Lentas e superficiais, para não machucar a vítima", "Apenas no lado esquerdo do peito"]', 1, 87),

    ('Um socorrista leigo não se sente seguro para fazer ventilações. O que ele faz?',
     '["Realiza somente as compressões, sem interrupção, até chegar ajuda ou o desfibrilador", "Não inicia a reanimação e aguarda o socorro", "Faz apenas ventilações, que são mais fáceis", "Sacode a vítima até ela reagir"]', 0, 88),

    ('Por que dois socorristas devem se revezar durante a reanimação?',
     '["Porque cada um precisa descansar dez minutos", "Porque só um pode tocar na vítima por vez", "Porque a troca ajuda a acalmar quem está por perto", "Porque a qualidade das compressões cai rápido com o cansaço, e a troca é feita em poucos segundos"]', 3, 89),

    ('Quando o socorrista interrompe a reanimação?',
     '["Quando a vítima reage, quando o socorro especializado assume ou quando ele não tem mais condições físicas de continuar", "Depois de cinco minutos de tentativa", "Quando a família pedir para parar", "Quando o desfibrilador for conectado, em definitivo"]', 0, 90),

    ('Para abrir as vias aéreas de uma vítima inconsciente sem suspeita de trauma, o socorrista:',
     '["Comprime o peito para forçar a saída do ar", "Inclina a cabeça para trás e eleva o queixo, porque a língua costuma ser o que obstrui a passagem do ar", "Vira a cabeça para o lado e puxa a língua com os dedos", "Levanta o tronco da vítima e senta ela"]', 1, 91),

    ('Para que serve a máscara de bolso com válvula usada na ventilação?',
     '["Substituir as compressões torácicas", "Medir a quantidade de oxigênio da vítima", "Permitir a ventilação com barreira de proteção entre o socorrista e a vítima", "Aumentar a pressão do ar nos pulmões da vítima"]', 2, 92),

    ('Onde as pás do desfibrilador externo automático são colocadas?',
     '["Uma em cada braço da vítima", "Uma abaixo da clavícula direita e outra na lateral esquerda do tórax, sobre a pele seca e limpa", "As duas juntas sobre o centro do peito", "Uma nas costas e outra na barriga"]', 1, 93),

    ('Logo depois que o desfibrilador aplica o choque, o socorrista deve:',
     '["Verificar o pulso durante um minuto antes de qualquer coisa", "Retirar as pás e virar a vítima de lado", "Retomar as compressões imediatamente, sem esperar a vítima reagir, seguindo os comandos do aparelho", "Aguardar dois minutos parado para o aparelho reavaliar"]', 2, 94),

    ('A vítima está deitada em uma poça de água. Antes de usar o desfibrilador:',
     '["Retirar a vítima da água, secar o tórax e só então colocar as pás", "Aplicar as pás assim mesmo, porque o tempo é curto", "Aguardar a água escoar sozinha", "Trocar as pás por outras de maior tamanho"]', 0, 95),

    ('A vítima tem um adesivo de medicamento colado no peito, no local da pá. O correto é:',
     '["Colar a pá por cima do adesivo", "Desistir do uso do desfibrilador nesse caso", "Colocar as duas pás nas costas da vítima", "Retirar o adesivo, limpar a pele e posicionar a pá, evitando também colocá-la sobre um marcapasso implantado"]', 3, 96),

    ('O que muda na reanimação de uma criança?',
     '["A profundidade das compressões é menor, proporcional ao tamanho do tórax, e pode ser feita com uma das mãos", "Não se fazem compressões, apenas ventilações", "A frequência das compressões é muito mais lenta", "O desfibrilador não pode ser usado em criança"]', 0, 97),

    ('Um bebê engasgou e não consegue chorar nem tossir. O correto é:',
     '["Aplicar a manobra de compressão abdominal como em adulto", "Sacudir o bebê de cabeça para baixo", "Introduzir o dedo na boca para procurar o objeto", "Alternar golpes nas costas e compressões no peito, com o bebê apoiado no antebraço e a cabeça mais baixa"]', 3, 98),

    ('Como se atende ao engasgo de uma gestante ou de uma pessoa muito obesa?',
     '["Apenas com golpes nas costas, sem compressões", "Deitando a pessoa no chão de barriga para baixo", "Com compressões na altura do peito, e não no abdome", "Com compressões abdominais mais fortes que o normal"]', 2, 99),

    ('A vítima engasgada perdeu a consciência. O que o socorrista faz?',
     '["Sopra ar com força na boca da vítima", "Deita a vítima, aciona o socorro e inicia as compressões torácicas, verificando a boca a cada abertura das vias aéreas", "Continua as compressões abdominais com a vítima no chão", "Espera a vítima recobrar a consciência"]', 1, 100),

    ('A pessoa engasgou, mas está tossindo com força e conseguindo falar. O correto é:',
     '["Dar tapas nas costas com força", "Oferecer água para empurrar o objeto", "Incentivar a tosse e ficar ao lado, pronto para agir se a obstrução piorar", "Aplicar imediatamente compressões abdominais"]', 2, 101),

    ('Quais sinais fazem suspeitar de acidente vascular cerebral?',
     '["Tremor generalizado com rigidez", "Boca torta, fraqueza de um lado do corpo e fala embolada, com horário de início importante para o socorro", "Dor no peito que irradia para o braço esquerdo", "Falta de ar com chiado no peito"]', 1, 102),

    ('Um colega sente dor forte no peito, sua frio e fica pálido. A conduta é:',
     '["Levá-la caminhando até a enfermaria", "Oferecer água gelada e deixá-la descansar sozinha", "Pedir que ela respire fundo e volte ao trabalho", "Acionar o socorro, manter a pessoa em repouso e sem esforço, observando se ela para de responder"]', 3, 103),

    ('Um trabalhador com asma está com falta de ar e chiado. A conduta é:',
     '["Levar para local arejado, manter sentado e inclinado para a frente e ajudar com o medicamento que ele já usa, acionando socorro se não melhorar", "Deitar a pessoa no chão de barriga para cima", "Oferecer o medicamento de outro colega asmático", "Fazer a pessoa respirar dentro de um saco"]', 0, 104),

    ('Um diabético ficou confuso, trêmulo e suando frio, mas está consciente e consegue engolir. O correto é:',
     '["Não oferecer nada e apenas aguardar", "Aplicar o medicamento injetável de outro colega", "Deitar a pessoa e provocar vômito", "Oferecer algo doce e acionar o socorro se não houver melhora rápida"]', 3, 105),

    ('Um trabalhador exposto ao calor está com pele quente, confuso e parou de suar. A conduta é:',
     '["Cobrir com pano para evitar o vento", "Tratar como emergência: retirar do calor, resfriar o corpo e acionar o socorro imediatamente", "Oferecer água gelada e mandar continuar em ritmo mais lento", "Deixar descansar à sombra por alguns minutos e liberar"]', 1, 106),

    ('Por que a extensão da queimadura importa tanto no atendimento?',
     '["Porque quanto maior a área queimada, maior a perda de líquido e o risco de choque, o que muda a urgência do socorro", "Porque a área queimada define a cor do curativo", "Porque a extensão indica quem vai atender a vítima", "Porque só queimaduras extensas doem"]', 0, 107),

    ('A área queimada formou bolhas. O correto é:',
     '["Passar pasta de dente ou manteiga sobre a área", "Esfregar gelo diretamente sobre as bolhas", "Deixar as bolhas intactas, cobrir com material limpo e não passar produto nenhum", "Furar as bolhas para aliviar a dor"]', 2, 108),

    ('A roupa ficou grudada na pele queimada. O que fazer?',
     '["Esperar secar e retirar depois", "Não puxar: recortar em volta, deixar o que está aderido e cobrir com material limpo", "Puxar rápido para não prolongar a dor", "Molhar com óleo para descolar"]', 1, 109),

    ('O que caracteriza a queimadura por corrente elétrica?',
     '["Pode haver ponto de entrada e de saída, com lesão interna grave mesmo quando a marca externa é pequena", "Ela sempre é superficial e cicatriza sozinha", "Ela só aparece nas mãos", "Ela nunca precisa de atendimento médico"]', 0, 110),

    ('Respingo de produto químico nos olhos. A conduta é:',
     '["Pingar colírio e observar", "Esfregar o olho com pano limpo", "Lavar com água corrente por vários minutos, com a pálpebra aberta, e encaminhar ao atendimento com a informação do produto", "Fechar o olho e cobrir com gaze seca"]', 2, 111),

    ('Houve amputação de um dedo em um acidente com máquina. Sobre a parte amputada:',
     '["Colocar direto no gelo, para conservar melhor", "Deixar no local do acidente para o socorro recolher", "Mergulhar em álcool ou em água oxigenada", "Envolver em pano limpo e úmido, colocar em saco fechado e este dentro de outro com gelo, sem contato direto do gelo com a parte"]', 3, 112),

    ('Quando o torniquete é considerado?',
     '["Em hemorragia grave de membro que não para com compressão direta, com registro do horário de aplicação", "Em qualquer sangramento de braço ou perna", "Em ferimento no tronco ou no pescoço", "Sempre que a vítima estiver muito assustada"]', 0, 113),

    ('Diante de uma hemorragia nasal, o correto é:',
     '["Introduzir algodão profundamente na narina", "Deitar a pessoa de barriga para cima", "Inclinar a cabeça um pouco para a frente e comprimir a parte mole do nariz por alguns minutos", "Inclinar a cabeça para trás para o sangue não escorrer"]', 2, 114),

    ('Quais sinais podem indicar hemorragia interna após um trauma?',
     '["Apenas dor no local do impacto", "Sangramento pelo nariz e pela boca, sempre", "Aumento de temperatura e vermelhidão", "Palidez, pele fria e úmida, pulso acelerado, sede e piora do estado sem sangramento visível"]', 3, 115),

    ('Como se atende a vítima em estado de choque?',
     '["Aplicar compressa fria no rosto e liberar", "Deitar, manter aquecida, não oferecer nada por via oral, tratar a causa quando possível e acionar o socorro", "Sentar a vítima e oferecer água com açúcar", "Fazer a vítima caminhar para ativar a circulação"]', 1, 116),

    ('Diante de uma entorse de tornozelo, a conduta inicial é:',
     '["Puxar o pé para recolocar no lugar", "Aplicar calor local imediatamente", "Repouso, aplicação de frio, imobilização e elevação do membro, encaminhando para avaliação", "Massagear com pomada e mandar caminhar"]', 2, 117),

    ('Diante de uma fratura com osso exposto, o correto é:',
     '["Empurrar o osso de volta para dentro", "Lavar o osso exposto com água e sabão", "Amarrar firme sobre o osso para conter o sangramento", "Cobrir o ferimento com material limpo, controlar o sangramento sem pressionar o osso e imobilizar como está"]', 3, 118),

    ('Ao imobilizar um membro com material improvisado, o socorrista deve:',
     '["Retirar a tala se a vítima reclamar de desconforto", "Imobilizar incluindo as articulações acima e abaixo da lesão, sem apertar a ponto de prejudicar a circulação", "Amarrar bem apertado, para não soltar", "Imobilizar apenas o ponto exato da dor"]', 1, 119),

    ('Um motociclista acidentado está inconsciente com o capacete. O correto é:',
     '["Manter o capacete e a cabeça estabilizados, retirando apenas se for indispensável para a respiração e, de preferência, por duas pessoas", "Retirar o capacete imediatamente, sempre", "Puxar o capacete pela parte de trás com força", "Cortar a jugular e sacudir para soltar"]', 0, 120),

    ('Quando o socorrista pode mover uma vítima de trauma antes do socorro chegar?',
     '["Sempre que a vítima reclamar de desconforto", "Para levá-la até um lugar mais reservado", "Assim que ela recobrar a consciência", "Quando o local oferece risco de morte, como fogo, desabamento ou vazamento, ou quando é preciso reanimar"]', 3, 121),

    ('Para que serve a técnica de rolamento em bloco?',
     '["Virar a vítima mantendo cabeça, pescoço e tronco alinhados, evitando agravar uma lesão de coluna", "Aquecer a vítima mudando de posição", "Facilitar a retirada da roupa da vítima", "Verificar se há sangramento nas costas, sem cuidado especial"]', 0, 122),

    ('Enquanto o socorro não chega, a cabeça da vítima com suspeita de lesão na coluna deve:',
     '["Ser movimentada devagar para testar a sensibilidade", "Ser mantida estabilizada com as mãos do socorrista, alinhada ao tronco, sem tração nem movimentos", "Ser apoiada em travesseiro alto", "Ser virada para o lado para facilitar a respiração"]', 1, 123),

    ('Como se avalia se a vítima está consciente?',
     '["Jogando água no rosto", "Beliscando a pele com força", "Chamando em voz alta e tocando os ombros, observando se há resposta", "Sacudindo a vítima pelos braços"]', 2, 124),

    ('De que forma o socorrista confirma que a vítima está respirando?',
     '["Perguntando se ela está respirando bem", "Observando se o peito se movimenta, por até cerca de dez segundos, com as vias aéreas abertas", "Colocando um espelho na frente da boca por um minuto", "Apertando o abdome para sentir a saída de ar"]', 1, 125),

    ('Uma vítima consciente sente dor no peito e falta de ar. A melhor posição costuma ser:',
     '["De pé, caminhando devagar", "Deitada com as pernas elevadas acima da cabeça", "Sentada ou semissentada, em repouso, no local mais tranquilo possível", "Deitada de barriga para baixo"]', 2, 126),

    ('O que o material de primeiros socorros da empresa deve conter?',
     '["Itens para curativos e imobilização, guardados limpos, conferidos e repostos, adequados aos riscos do local", "Medicamentos variados para dor e febre", "Apenas álcool e algodão", "Materiais de uso hospitalar, de uso restrito ao médico"]', 0, 127),

    ('Um colega pede um analgésico da caixa de primeiros socorros. O correto é:',
     '["Dar o remédio, se for de venda livre", "Dar meia dose, para reduzir o risco", "Dar o remédio se o colega já usou antes", "Não oferecer medicamento: o socorrista não medica, encaminha para avaliação"]', 3, 128),

    ('Por que não se oferece água ou comida a uma vítima que pode precisar de cirurgia ou que está sonolenta?',
     '["Porque ela pode engasgar e aspirar, e porque isso atrapalha o atendimento médico posterior", "Porque a água aumenta o sangramento", "Porque o socorrista pode ser responsabilizado por gasto de material", "Porque a comida altera o resultado dos exames de sangue"]', 0, 129),

    ('Depois de um atendimento, o registro do que aconteceu serve para:',
     '["Justificar o tempo em que o brigadista ficou fora do posto", "Comprovar a competência do socorrista", "Cumprir uma exigência do plano de saúde", "Informar quem vai continuar o atendimento e permitir que a empresa investigue e corrija a causa"]', 3, 130),

    ('Uma vítima consciente recusa o atendimento. O socorrista deve:',
     '["Ir embora e considerar o caso encerrado", "Pedir que ela assine um documento antes de qualquer coisa", "Respeitar a recusa, insistir com calma, acionar o socorro e permanecer por perto observando", "Atender à força, porque a vítima não sabe o que é melhor"]', 2, 131),

    ('Sobre a obrigação de socorrer:',
     '["A obrigação vale apenas dentro da empresa", "Deixar de prestar socorro possível, ou de acionar quem pode fazê-lo, é conduta prevista em lei como omissão", "Só o profissional de saúde tem obrigação de agir", "Ninguém é obrigado a nada em caso de acidente"]', 1, 132),

    ('O que fazer com luvas, gazes e material sujo de sangue após o atendimento?',
     '["Lavar e reaproveitar em outro atendimento", "Guardar na caixa de primeiros socorros até a coleta", "Descartar em recipiente próprio para material contaminado, sem misturar ao lixo comum", "Jogar na lixeira mais próxima"]', 2, 133),

    ('Um trabalhador foi picado por cobra na perna. A conduta é:',
     '["Aplicar gelo e álcool sobre a picada", "Manter a vítima em repouso, com o membro em posição neutra, lavar o local e levar ao atendimento o quanto antes", "Fazer torniquete acima da picada", "Cortar o local e sugar o veneno"]', 1, 134),

    ('Após uma picada de inseto, o colega apresenta inchaço no rosto e dificuldade para respirar. Isso indica:',
     '["Reação normal, que passa com compressa fria", "Insolação por trabalho ao sol", "Crise de ansiedade sem gravidade", "Reação alérgica grave, que exige acionamento imediato do socorro"]', 3, 135),

    ('Um colega ingeriu produto químico por engano. O correto é:',
     '["Acionar o socorro, não provocar vômito e levar junto a informação do produto ingerido", "Provocar vômito imediatamente", "Oferecer leite em grande quantidade", "Oferecer outro produto para neutralizar"]', 0, 136),

    ('Há uma vítima desacordada dentro de uma sala com vazamento de gás. O brigadista deve:',
     '["Entrar prendendo a respiração e arrastar a vítima", "Entrar com pano molhado no rosto", "Abrir a porta e esperar o gás sair sozinho", "Não entrar sem proteção respiratória adequada e acionar quem tem o equipamento e o treinamento para a retirada"]', 3, 137),

    ('Caiu poeira ou fragmento pequeno no olho de um colega. A conduta é:',
     '["Pingar colírio e mandar continuar o serviço", "Lavar com água corrente ou soro e não esfregar, encaminhando se não sair ou se o incômodo persistir", "Retirar com a ponta de um pano", "Assoprar o olho para deslocar a partícula"]', 1, 138),

    ('Um objeto ficou encravado no olho da vítima. O correto é:',
     '["Não retirar, estabilizar o objeto, cobrir os dois olhos e encaminhar imediatamente", "Retirar com cuidado e cobrir com gaze", "Lavar o olho com água em jato forte", "Cobrir apenas o olho atingido e liberar a vítima"]', 0, 139),

    ('Um colega foi mordido por um animal no pátio da empresa. O correto é:',
     '["Fechar bem o ferimento com esparadrapo", "Aguardar para ver se inflama", "Lavar bem com água e sabão, cobrir e encaminhar para avaliação, informando o animal envolvido", "Apenas passar antisséptico e continuar o serviço"]', 2, 140),

    ('Um colega começou a convulsionar perto de uma máquina em movimento. A prioridade é:',
     '["Levantar a vítima e sentá-la em uma cadeira", "Afastar o risco, parando a máquina e protegendo a pessoa do que está em volta, sem segurar os movimentos", "Segurar os braços e as pernas dele com firmeza", "Colocar um objeto na boca da vítima"]', 1, 141),

    ('Como o socorrista diferencia um desmaio de uma parada cardíaca?',
     '["No desmaio a pessoa respira e responde em pouco tempo; na parada não há resposta nem respiração normal", "No desmaio a pessoa fica com a pele vermelha", "Na parada a pessoa se debate no chão", "No desmaio a pessoa sempre se lembra do que aconteceu"]', 0, 142),

    ('Uma vítima de choque elétrico está consciente e diz que passou bem. O correto é:',
     '["Apenas oferecer água e observar por cinco minutos", "Aplicar compressa fria no ponto de contato e liberar", "Encaminhar para avaliação mesmo assim, porque alterações no coração podem aparecer depois", "Liberar para o trabalho, se ela caminhar normalmente"]', 2, 143),

    ('Alguém caiu em um tanque de água na área industrial. O brigadista deve:',
     '["Pular imediatamente para buscar a vítima", "Aguardar a vítima subir sozinha", "Esvaziar o tanque antes de qualquer ação", "Tentar o resgate sem entrar na água, com material de alcance ou flutuação, e acionar o socorro"]', 3, 144),

    ('Um trabalhador está preso em uma máquina. A primeira providência é:',
     '["Garantir que a máquina esteja parada e bloqueada antes de qualquer tentativa de liberação da vítima", "Puxar a vítima com força para soltar", "Ligar a máquina no sentido inverso", "Cobrir a vítima e aguardar o socorro sem mexer na máquina"]', 0, 145),

    ('Em um acidente com várias vítimas, o socorrista começa por:',
     '["Quem estiver mais perto da entrada", "Quem for colega mais próximo do socorrista", "Avaliar o conjunto e priorizar quem corre risco imediato de morte, como quem não respira ou sangra muito", "Quem estiver gritando mais alto"]', 2, 146),

    ('Quando se aciona o SAMU e quando se aciona o corpo de bombeiros?',
     '["Sempre o 193, porque ele repassa os casos", "Sempre o 192, porque toda vítima é clínica", "Nenhum dos dois, se a empresa tiver ambulância própria", "O 192 atende a emergência clínica e o 193 atende incêndio e resgate, e na dúvida se aciona e se descreve a situação"]', 3, 147),

    ('O que a brigada faz enquanto aguarda a ambulância?',
     '["Retira todos os curativos aplicados", "Mantém o atendimento iniciado, deixa o acesso livre e alguém para receber e conduzir a equipe até a vítima", "Move a vítima para a portaria, para agilizar", "Encerra o atendimento e aguarda no ponto de encontro"]', 1, 148),

    ('Uma pessoa se recusa a sair durante o abandono, dizendo que vai terminar o serviço. O brigadista deve:',
     '["Retirar a pessoa à força na mesma hora", "Ficar com ela no setor até ela terminar", "Insistir com firmeza, explicar o risco e comunicar imediatamente a quem coordena a emergência", "Deixar a pessoa e seguir com o abandono sem comentar"]', 2, 149),

    ('Encerrada a ocorrência, o relatório da brigada deve registrar:',
     '["Apenas o nome de quem esteve presente", "Apenas o prejuízo material estimado", "Apenas a hora de chegada do corpo de bombeiros", "O que aconteceu, o horário, o que foi feito, os recursos usados e o que falhou, para gerar correção"]', 3, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'BRIG';


-- =====================================================================
--  NR-11 — Transporte, movimentação, armazenagem e manuseio (41 a 150)
--  As 40 primeiras já cobrem a empilhadeira no dia a dia. Aqui entram os
--  acessórios de içamento, a doca, o porta-pallets, o transporte manual
--  e a papelada que separa a operação autorizada da improvisada.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-11')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Por que o operador precisa usar o cinto de segurança da empilhadeira?',
     '["Porque em um tombamento o cinto mantém o operador dentro da proteção do equipamento, que é o que salva a vida", "Porque melhora a postura durante o turno", "Porque evita que ele caia ao fazer curva", "Porque a empilhadeira não liga sem o cinto"]', 0, 41),

    ('Para que serve a estrutura de proteção sobre a cabeça do operador?',
     '["Servir de apoio para o operador se levantar", "Sustentar o farol e o giroflex", "Proteger contra a queda de material do alto da carga ou da estrutura de armazenagem", "Proteger o operador do sol e da chuva"]', 2, 42),

    ('Quando o operador deve acionar a buzina?',
     '["Somente ao dar ré com carga", "Ao se aproximar de cruzamentos, portas, saídas de corredor e sempre que houver risco de alguém não vê-lo", "Somente quando quiser que um pedestre saia da frente", "Somente na saída do galpão para o pátio"]', 1, 43),

    ('Para que serve o espelho convexo instalado nos cruzamentos do galpão?',
     '["Ajudar o operador a conferir a carga nos garfos", "Aumentar a iluminação da área", "Substituir a sinalização de piso do cruzamento", "Mostrar quem vem pelo outro corredor antes do encontro, mas sem substituir a redução de velocidade"]', 3, 44),

    ('Qual é o critério de velocidade dentro do galpão?',
     '["A velocidade que o operador conseguir manter sem derrubar a carga", "A velocidade necessária para cumprir a meta do turno", "A velocidade compatível com o piso, a carga, a visibilidade e a circulação de pessoas, respeitando o limite definido", "A velocidade máxima que o equipamento alcança"]', 2, 45),

    ('Para que serve o alarme sonoro de ré e a luz de advertência da empilhadeira?',
     '["Avisar que a bateria está no fim", "Avisar quem está por perto de que o equipamento está em movimento, sem dispensar o olhar do operador", "Substituir a buzina em qualquer situação", "Indicar que a carga está acima do peso"]', 1, 46),

    ('Um trabalhador circula pelo corredor com fone de ouvido. Qual o risco?',
     '["Ele fica mais lento e atrapalha a operação", "Ele pode danificar o fone se encostar na carga", "Nenhum, se a empilhadeira tiver giroflex", "Ele não escuta a buzina nem o alarme da empilhadeira e perde o principal aviso de aproximação"]', 3, 47),

    ('Para que serve a faixa de circulação de pedestres pintada no piso do galpão?',
     '["Separar o caminho das pessoas do caminho dos equipamentos, reduzindo o encontro entre os dois", "Indicar o local de armazenagem temporária", "Marcar onde as empilhadeiras podem estacionar", "Delimitar a área de limpeza do setor"]', 0, 48),

    ('A lâmpada de um trecho do corredor queimou e a área ficou escura. O que fazer?',
     '["Pedir a um colega para iluminar com lanterna", "Comunicar e não operar naquele trecho até a iluminação ser restabelecida, porque a visibilidade é parte da segurança", "Operar mais devagar com o farol do equipamento", "Operar somente durante o dia naquele trecho"]', 1, 49),

    ('Sobre a validade da capacitação do operador de empilhadeira:',
     '["Vale por toda a vida profissional do operador", "Vale enquanto ele permanecer na mesma empresa", "Só precisa ser refeita se ele ficar mais de um ano parado", "Precisa de reciclagem periódica e também quando muda o equipamento, a atividade ou após acidente"]', 3, 50),

    ('O que comprova que o operador está autorizado a operar aquele equipamento?',
     '["A autorização formal da empresa, com o registro do treinamento e a identificação do operador", "O fato de ele já operar há muitos anos", "A indicação verbal do encarregado do setor", "A carteira de habilitação de trânsito"]', 0, 51),

    ('Qual é a exigência de saúde para o operador de equipamento de movimentação?',
     '["Apenas ter feito exame admissional na contratação", "Nenhuma, porque a função não exige esforço físico", "Estar apto no exame médico ocupacional, considerando os requisitos da função", "Apenas não ter faltado ao trabalho por doença"]', 2, 52),

    ('O operador usa óculos de grau e esqueceu em casa. O correto é:',
     '["Operar devagar até o fim do turno", "Operar apenas nos corredores que ele conhece bem", "Pedir emprestado o óculos de um colega", "Não operar e comunicar, porque a condição de visão faz parte da aptidão para a função"]', 3, 53),

    ('Na troca de turno, o que o operador que assume precisa saber?',
     '["As pendências do equipamento, os defeitos detectados e as condições da área que mudaram no turno anterior", "Apenas o número de pallets movimentados", "Apenas o horário do intervalo", "Apenas se o equipamento está abastecido"]', 0, 54),

    ('Para que serve o registro do checklist diário do equipamento?',
     '["Substituir a manutenção preventiva", "Justificar a troca do equipamento por um novo", "Documentar o que foi verificado e o que foi encontrado, permitindo cobrar a correção e acompanhar o histórico", "Controlar a produtividade do operador"]', 2, 55),

    ('Qual é a diferença entre a manutenção preventiva e o conserto após a quebra?',
     '["Não há diferença prática entre as duas", "A preventiva é programada e evita a falha; o conserto acontece depois que a falha já criou risco", "A preventiva é feita pelo operador e o conserto pelo mecânico", "A preventiva só é feita em equipamento novo"]', 1, 56),

    ('Ao descer da empilhadeira para resolver alguma coisa, o operador deve:',
     '["Baixar os garfos, aplicar o freio, desligar e retirar a chave, mesmo que seja por pouco tempo", "Deixar ligada, se for demorar menos de cinco minutos", "Deixar a chave para outro operador aproveitar o equipamento", "Deixar os garfos elevados para não sujar no chão"]', 0, 57),

    ('Durante o abastecimento de combustível do equipamento, o correto é:',
     '["Abastecer com o operador sentado no equipamento", "Motor desligado, em local ventilado e sinalizado, sem fonte de ignição por perto", "Motor ligado em marcha lenta, para não descarregar a bateria", "Abastecer dentro do galpão, perto do ponto de operação"]', 1, 58),

    ('Antes de conectar a empilhadeira elétrica ao carregador, o correto é:',
     '["Conectar rapidamente para não perder tempo", "Conectar somente depois que a bateria estiver totalmente vazia", "Desligar o equipamento e seguir a sequência prevista, porque a conexão sob carga gera arco e faísca", "Conectar com o equipamento ligado, para checar a carga"]', 2, 59),

    ('Ao manusear a bateria da empilhadeira elétrica, o trabalhador precisa:',
     '["Usar apenas luva de raspa", "Usar somente óculos de sol contra o reflexo", "Nenhum EPI, porque a bateria é selada", "Usar os EPIs contra respingo de ácido, com lava-olhos e chuveiro disponíveis na área"]', 3, 60),

    ('Sobre completar o nível da bateria da empilhadeira:',
     '["Completa-se com ácido de bateria nova", "Não se completa: a bateria é trocada quando o nível cai", "Usa-se somente água adequada ao serviço, conforme o manual, e nunca ácido, com os EPIs indicados", "Usa-se qualquer água disponível na área"]', 2, 61),

    ('Descer uma rampa com transpaleteira manual carregada exige:',
     '["Que o operador fique à frente puxando a carga", "Que a carga desça sozinha e o operador acompanhe ao lado", "Que a velocidade seja a maior possível, para vencer a rampa", "Que o operador fique na parte de cima, controlando a descida, e nunca à frente da carga"]', 3, 62),

    ('Ao operar uma transpaleteira elétrica com timão, o operador deve:',
     '["Andar de costas para o sentido de deslocamento", "Manter-se em posição segura, com o corpo fora da linha de deslocamento da carga e das rodas", "Ficar sempre à frente da carga", "Apoiar-se no equipamento e se deixar puxar"]', 1, 63),

    ('A carga sobre a transpaleteira está instável e balançando. O correto é:',
     '["Parar, baixar e refazer o arranjo da carga antes de continuar", "Deslocar devagar até o destino", "Segurar a carga com a mão durante o percurso", "Pedir a um colega para caminhar ao lado segurando"]', 0, 64),

    ('Para que serve o fim de curso da ponte rolante?',
     '["Alinhar a ponte com o trilho", "Limitar o movimento e evitar que o carro ou o gancho ultrapasse o ponto seguro, e não deve ser usado como parada de rotina", "Frear a carga durante a descida", "Indicar o peso máximo da carga"]', 1, 65),

    ('Durante o içamento, a carga pode passar por cima de pessoas?',
     '["Não: o percurso é planejado para evitar pessoas embaixo, e a área é isolada quando necessário", "Sim, se a carga estiver bem amarrada", "Sim, se a velocidade for reduzida", "Sim, se as pessoas forem avisadas antes"]', 0, 66),

    ('Enquanto a carga está suspensa, o correto é:',
     '["Manter um trabalhador embaixo para orientar", "Manter a carga suspensa durante o intervalo, para adiantar", "Apoiar a carga em uma pessoa enquanto se posiciona", "Ninguém permanecer sob a carga nem na linha de possível queda, e a carga não fica suspensa sem necessidade"]', 3, 67),

    ('O que acontece com o esforço nas cintas quando o ângulo entre elas aumenta?',
     '["O esforço não muda, porque o peso é o mesmo", "O esforço só muda se a carga girar", "A força em cada perna cresce, e uma cinta que serviria na vertical pode romper com o ângulo aberto", "O esforço diminui, porque a carga se divide entre mais pontos"]', 2, 68),

    ('O que caracteriza o laço em estrangulamento na amarração da carga?',
     '["É o modo de uso que aumenta a capacidade da cinta", "É o uso com dois ganchos em pontos opostos", "É a amarração em que a cinta trabalha sem contato com a carga", "A cinta abraça a carga e passa por si mesma, prendendo melhor, mas reduzindo a capacidade em relação ao uso direto"]', 3, 69),

    ('Para que serve a cantoneira colocada entre a cinta e a quina da carga?',
     '["Facilitar o deslizamento da cinta durante o içamento", "Identificar a capacidade da cinta", "Proteger a cinta do corte na aresta viva, que é uma das causas mais comuns de rompimento", "Aumentar a altura da carga para o garfo entrar"]', 2, 70),

    ('Sobre a manilha usada no içamento:',
     '["O pino é rosqueado até o fim e a manilha trabalha alinhada, nunca com carga de lado, e precisa ter a capacidade identificada", "O pino pode ficar folgado, porque a carga aperta durante o içamento", "Qualquer parafuso serve como pino, se tiver a mesma bitola", "A manilha pode ser usada com a carga puxando de lado"]', 0, 71),

    ('Um olhal de içamento está sendo puxado de lado, e não na direção do eixo. Qual o problema?',
     '["Apenas a dificuldade de encaixar o gancho", "A carga lateral reduz muito a capacidade do olhal e pode arrancá-lo", "Nenhum, se o olhal for de aço", "Apenas o desgaste da pintura do olhal"]', 1, 72),

    ('Para que serve o balancim, ou viga de içamento?',
     '["Manter as pernas do conjunto verticais e distribuir os pontos de apoio em cargas longas ou frágeis", "Aumentar a capacidade de carga do guindaste", "Substituir as cintas e os cabos do conjunto", "Permitir o içamento sem operador qualificado"]', 0, 73),

    ('Por que cada cinta, corrente e acessório de içamento precisa ter a identificação da capacidade?',
     '["Porque a etiqueta protege a cinta do desgaste", "Porque a identificação define quem pode usar o acessório", "Porque sem ela ninguém sabe o limite daquele acessório e a escolha vira chute", "Porque a identificação indica o fabricante para garantia"]', 2, 74),

    ('Uma cinta apresenta corte nas bordas, fios rompidos e a etiqueta ilegível. O correto é:',
     '["Usar somente com carga bem abaixo do limite", "Retirar de uso imediatamente e inutilizar, para que ninguém a pegue de novo por engano", "Guardar separada para uso em cargas leves", "Costurar a parte danificada e continuar usando"]', 1, 75),

    ('Como as cintas de içamento devem ser guardadas?',
     '["Enroladas no chão, ao lado do equipamento", "Dentro da caixa de ferramentas, junto com o material", "Amarradas na estrutura, para não sumirem", "Penduradas em local próprio, limpas, secas, longe do sol, de calor, de produto químico e de arestas cortantes"]', 3, 76),

    ('Por que os sinais de mão para içamento precisam ser padronizados?',
     '["Porque a padronização acelera a operação", "Porque o operador não pode falar durante o içamento", "Porque quem opera precisa entender de imediato e sempre da mesma forma, mesmo trocando o sinaleiro", "Porque a norma exige uma linguagem específica de gestos"]', 2, 77),

    ('Por que a carga é levantada poucos centímetros e o movimento é interrompido antes de subir de vez?',
     '["Para confirmar o peso indicado na nota da carga", "Para conferir a estabilidade, o equilíbrio e a amarração ainda perto do chão, quando a correção é possível", "Para aquecer o sistema hidráulico do equipamento", "Para dar tempo de a equipe se afastar do trajeto"]', 1, 78),

    ('Um içamento vai ser feito com dois equipamentos ao mesmo tempo. Isso exige:',
     '["Apenas experiência dos dois operadores", "Apenas que os dois equipamentos sejam do mesmo modelo", "Apenas que a carga seja leve para os dois", "Planejamento específico, com plano de içamento, comando único e acompanhamento de quem responde tecnicamente"]', 3, 79),

    ('O vento aumentou durante um içamento em área externa. O correto é:',
     '["Interromper quando o vento passa do limite previsto, porque a carga vira uma vela e pode girar ou bater", "Continuar com a carga mais baixa", "Continuar com dois sinaleiros orientando", "Continuar, porque o guindaste é pesado o suficiente"]', 0, 80),

    ('Antes de operar o munck, o motorista precisa:',
     '["Apenas verificar se a carga está dentro do peso", "Estender as patolas em piso firme e nivelado, com calços quando necessário, e conferir a estabilidade", "Apenas puxar o freio de mão do caminhão", "Apenas manter o caminhão ligado durante a operação"]', 1, 81),

    ('Um içamento vai ser feito perto de uma rede elétrica aérea. O correto é:',
     '["Operar devagar e com atenção do operador", "Usar cinta de nylon, que não conduz eletricidade", "Cobrir a lança do equipamento com lona", "Manter a distância mínima de segurança e, quando não for possível, solicitar o desligamento ou o isolamento da rede"]', 3, 82),

    ('Elevar um trabalhador com uma gaiola acoplada aos garfos da empilhadeira é:',
     '["Aceito somente em situação prevista e avaliada, com dispositivo apropriado e fixado, equipamento adequado e trabalhador protegido contra queda", "Proibido em qualquer hipótese, sem exceção", "Permitido sempre, desde que o operador fique no equipamento", "Permitido se o serviço for rápido"]', 0, 83),

    ('Içar uma pessoa com talha ou guincho projetado para carga é:',
     '["Permitido, se a altura for pequena", "Permitido, se houver duas pessoas comandando", "Proibido: esses equipamentos não têm os dispositivos de segurança exigidos para elevação de pessoas", "Permitido, se a pessoa usar cinto de segurança"]', 2, 84),

    ('Uma carga solta na caçamba do caminhão vai ser transportada dentro da empresa. O correto é:',
     '["Transportar devagar, sem amarrar", "Colocar um trabalhador na caçamba segurando a carga", "Transportar somente em piso plano, sem amarração", "Amarrar ou travar a carga antes de qualquer deslocamento, porque a frenagem projeta o material"]', 3, 85),

    ('Por que o caminhão encostado na doca precisa de calço nas rodas?',
     '["Para impedir que ele se desloque enquanto a empilhadeira entra e sai, o que derrubaria o equipamento no vão", "Para nivelar o piso da carreta com a doca", "Para proteger os pneus do desgaste", "Para facilitar a saída do caminhão depois"]', 0, 86),

    ('Uma carreta será desengatada do cavalo mecânico e permanecerá na doca. O correto é:',
     '["Deixar com a traseira encostada na doca, sem outra medida", "Colocar um pallet embaixo da frente da carreta", "Apoiar em cavalete adequado e travar, porque o peso da empilhadeira pode fazer a carreta tombar para a frente", "Deixar apoiada apenas nos pés de apoio, sem reforço"]', 2, 87),

    ('Como o peso deve ser distribuído dentro do baú do caminhão durante o carregamento?',
     '["Livremente, porque a amarração final resolve o desequilíbrio", "De forma equilibrada entre os eixos e a largura, com o material mais pesado embaixo e travado contra o deslocamento", "Todo concentrado na traseira, para facilitar a descarga", "Todo concentrado na dianteira, sobre o eixo do cavalo"]', 1, 88),

    ('Por que ninguém deve permanecer no vão entre a traseira do caminhão e a plataforma da doca?',
     '["Porque qualquer movimento do veículo esmaga quem estiver ali, e o espaço não tem para onde escapar", "Porque a poeira do escapamento se concentra nesse ponto", "Porque a iluminação daquele trecho costuma ser fraca", "Porque o piso do vão é sempre escorregadio"]', 0, 89),

    ('Como devem ser transportados tambores com produto?',
     '["Rolando pelo piso até o local de destino", "Na posição definida pelo procedimento, presos ou com dispositivo próprio, sem rolar nem empilhar de forma instável", "Deitados e empilhados livremente sobre o pallet", "Equilibrados sobre os garfos, sem pallet"]', 1, 90),

    ('Cilindros de gás são movimentados com:',
     '["As mãos, rolando pela base", "Cintas amarradas no corpo do cilindro, içados soltos", "Carrinho ou dispositivo próprio, na vertical, presos e com o capacete de proteção da válvula colocado", "Os garfos da empilhadeira, apoiados diretamente"]', 2, 91),

    ('Qual é o critério para a altura máxima de uma pilha de material?',
     '["A altura que o equipamento alcança", "A altura do pé-direito do galpão", "A altura que o operador considerar estável", "A resistência do piso e da embalagem, a estabilidade da pilha e a altura definida no procedimento, mantendo a pilha travada e alinhada"]', 3, 92),

    ('Uma pilha foi montada encostando nas luminárias e nos bicos de chuveiro automático do teto. Isso é:',
     '["Aceitável, se a pilha for retirada em poucos dias", "Aceitável, se as luminárias estiverem desligadas", "Errado: prejudica o sistema de combate, o calor pode iniciar fogo na pilha e a manutenção fica sem acesso", "Aceitável, se o material não for inflamável"]', 2, 93),

    ('Para que serve a sinalização de piso que delimita as áreas de armazenagem?',
     '["Diferenciar os produtos por cliente", "Marcar a área de responsabilidade de cada operador", "Indicar onde o piso foi reformado", "Manter os corredores, os acessos e a frente dos equipamentos de emergência livres, com lugar definido para cada coisa"]', 3, 94),

    ('Para que serve a placa de capacidade fixada na estrutura porta-pallets?',
     '["Informar a data da última pintura", "Informar quanto cada nível e cada vão suportam, para que ninguém carregue além do previsto", "Indicar o fabricante da estrutura", "Indicar o número de níveis da estrutura"]', 1, 95),

    ('Para que servem os travamentos das longarinas do porta-pallets?',
     '["Impedir que a longarina se solte da coluna quando o garfo bate nela por baixo, o que derrubaria o nível inteiro", "Facilitar a regulagem da altura do nível", "Segurar a rede de proteção da estrutura", "Nivelar a estrutura no piso"]', 0, 96),

    ('Para que servem os protetores de coluna instalados na base do porta-pallets?',
     '["Facilitar a limpeza da base da estrutura", "Absorver o impacto da empilhadeira e evitar que a batida amasse a coluna e comprometa a estrutura", "Marcar o endereço de cada posição do estoque", "Servir de apoio para o pallet"]', 1, 97),

    ('Uma coluna do porta-pallets foi amassada por uma batida. O que fazer?',
     '["Isolar, esvaziar a área afetada e providenciar a avaliação, porque a estrutura amassada perde muito da capacidade", "Continuar usando, se a estrutura ainda estiver em pé", "Reduzir apenas a carga daquele nível", "Endireitar a coluna com marreta e seguir"]', 0, 98),

    ('Sobre a inspeção da estrutura de armazenagem:',
     '["É feita apenas quando ocorre um acidente", "É feita apenas quando a estrutura é montada", "É responsabilidade exclusiva do fornecedor da estrutura", "É periódica, com registro, feita por pessoa capacitada, e o operador comunica avarias assim que percebe"]', 3, 99),

    ('O que precisa ser observado no uso de um mezanino de armazenagem?',
     '["Apenas a iluminação do piso superior", "Apenas o acesso pela escada mais próxima", "A capacidade de carga definida, o guarda-corpo, a sinalização e a forma segura de subir e descer material", "Apenas a altura livre para a passagem de pessoas"]', 2, 100),

    ('Por que o empilhamento de sacaria é feito com as camadas cruzadas?',
     '["Porque facilita a contagem dos sacos", "Porque diminui o peso sobre o pallet", "Porque protege os sacos da umidade", "Porque o cruzamento trava a pilha e reduz o risco de desmoronamento lateral"]', 3, 101),

    ('Caixas de papelão molhadas foram empilhadas no depósito. Qual o risco?',
     '["Apenas a dificuldade de leitura do rótulo", "Nenhum, se a pilha for baixa", "O papelão úmido perde resistência e a pilha pode ceder e desabar", "Apenas a perda do produto por contaminação"]', 2, 102),

    ('Quando o transporte manual de um volume deixa de ser aceitável?',
     '["Quando o peso, o formato ou a distância exigem esforço capaz de comprometer a saúde, caso em que se usa meio mecânico ou ajuda", "Somente quando o volume passa de cem quilos", "Somente quando o trabalhador reclama de dor", "Somente quando não há empilhadeira disponível"]', 0, 103),

    ('Qual é a forma correta de levantar um volume do chão?',
     '["Levantar torcendo o tronco para já girar no sentido do destino", "Aproximar-se da carga, dobrar os joelhos, manter as costas retas e levantar com a força das pernas, sem torcer o tronco", "Manter as pernas retas e curvar as costas", "Levantar em movimento rápido, aproveitando o impulso"]', 1, 104),

    ('Entre empurrar e puxar um carrinho carregado, o preferível costuma ser:',
     '["Empurrar, porque permite usar o peso do corpo e mantém a coluna em posição melhor", "Puxar, porque o trabalhador enxerga o caminho", "Tanto faz, porque o esforço é o mesmo", "Puxar, porque exige menos força nos braços"]', 0, 105),

    ('Um trabalhador passa o turno inteiro carregando volumes no mesmo ritmo. O que a empresa deve avaliar?',
     '["Apenas se ele está usando luvas", "Apenas se ele reclama de cansaço", "A organização do trabalho, com pausas, revezamento e meios mecânicos, porque a repetição e o esforço adoecem", "Apenas a produtividade individual do trabalhador"]', 2, 106),

    ('Duas pessoas vão carregar um volume pesado juntas. O correto é:',
     '["Levantar sem combinar, porque o peso se divide sozinho", "Combinar antes quem comanda, o momento de levantar, o percurso e o momento de baixar", "Cada uma levantar quando estiver pronta", "A mais forte levantar primeiro para a outra acompanhar"]', 1, 107),

    ('Começou a chover e o pátio ficou molhado e escorregadio. O que muda na operação?',
     '["Nada, porque o equipamento tem pneus com ranhura", "Aumenta-se a velocidade para diminuir o tempo na chuva", "Suspende-se apenas a movimentação de material de papelão", "Reduz-se a velocidade, aumenta-se a distância de frenagem prevista e reavalia-se a movimentação de cargas mais críticas"]', 3, 108),

    ('Há um buraco e um desnível no trajeto da empilhadeira. O correto é:',
     '["Passar com a carga mais alta, para não bater", "Encher o buraco com pallets quebrados", "Comunicar, sinalizar e desviar o trajeto até o reparo, porque o desnível pode desestabilizar a carga e o equipamento", "Passar devagar por cima"]', 2, 109),

    ('Por que existe limite de carga para o piso de algumas áreas do galpão?',
     '["Porque o piso perde a pintura de sinalização", "Porque a estrutura tem capacidade definida em projeto, e o peso do equipamento somado ao da carga pode ultrapassá-la", "Porque o piso pode manchar com o peso", "Porque o limite serve apenas para veículos de rua"]', 1, 110),

    ('Que EPIs costumam ser exigidos de quem trabalha na área de movimentação?',
     '["Apenas luvas de raspa", "Apenas o uniforme da empresa", "Apenas óculos de proteção", "Calçado de segurança e o que a avaliação de risco indicar, como colete de alta visibilidade, capacete e protetor auditivo"]', 3, 111),

    ('Para que serve o colete de alta visibilidade na área de circulação de equipamentos?',
     '["Fazer o trabalhador ser enxergado pelo operador a tempo, principalmente em local com pouca luz ou muita movimentação", "Identificar o setor a que o trabalhador pertence", "Proteger o uniforme da sujeira", "Indicar quem é o responsável pela área"]', 0, 112),

    ('O uso de protetor auditivo dificulta a comunicação na área. Como resolver?',
     '["Usando apenas um dos protetores no ouvido", "Mantendo o protetor e adotando comunicação visual combinada, sinalização e redução do ruído na fonte quando possível", "Retirando o protetor durante as manobras", "Aumentando o volume da voz"]', 1, 113),

    ('Um equipamento de movimentação está com uma proteção retirada para facilitar a manutenção. O correto é:',
     '["Operar sem a proteção e recolocar na próxima parada", "Operar com a proteção apoiada, sem fixar", "Retirar também as demais, para padronizar", "Recolocar a proteção antes de liberar o equipamento, porque sem ela o risco volta para quem opera"]', 3, 114),

    ('O que impede que a empilhadeira se movimente com o operador fora do assento?',
     '["O dispositivo de presença do operador, que precisa estar funcionando e nunca deve ser burlado", "O freio de mão puxado", "O peso do equipamento parado", "O sistema de partida elétrica"]', 0, 115),

    ('Um colega não autorizado pede a empilhadeira emprestada por um minuto. A resposta correta é:',
     '["Emprestar, se o operador ficar ao lado", "Emprestar, se o percurso for curto", "Não emprestar: só opera quem é capacitado e autorizado, mesmo por pouco tempo", "Emprestar, se ele já operou antes"]', 2, 116),

    ('Brincadeiras e manobras de exibição com o equipamento:',
     '["São aceitáveis fora do horário de pico", "São aceitáveis se o operador tiver experiência", "São aceitáveis em área sem pedestres", "São proibidas, porque o equipamento tem inércia e centro de gravidade que não perdoam improviso"]', 3, 117),

    ('Um colega quer pegar carona em pé no contrapeso da empilhadeira. Isso é:',
     '["Proibido: a empilhadeira transporta apenas o operador, no assento, e qualquer carona pode ser esmagada em uma manobra", "Permitido em trajeto curto", "Permitido se ele se segurar firme", "Permitido dentro do galpão, em baixa velocidade"]', 0, 118),

    ('Usar a ponta do garfo para abrir ou rasgar uma embalagem é:',
     '["Aceitável, se não houver estilete disponível", "Aceitável, se a carga estiver no chão", "Errado: o garfo não é ferramenta, e o movimento pode desestabilizar a carga e atingir quem estiver por perto", "Aceitável, se for a embalagem plástica externa"]', 2, 119),

    ('Estacionar o equipamento em frente ao extintor ou à porta de emergência é:',
     '["Aceitável fora do horário de expediente", "Errado: em uma emergência, segundos perdidos procurando a chave do equipamento custam caro", "Aceitável, se for por pouco tempo", "Aceitável, se a chave ficar no equipamento"]', 1, 120),

    ('A empilhadeira precisa se deslocar entre dois galpões passando por via pública. O correto é:',
     '["Não circular em via pública sem atender às exigências legais de trânsito, providenciando transporte adequado do equipamento", "Circular devagar com o giroflex ligado", "Circular acompanhada por um trabalhador a pé", "Circular apenas em horário de pouco movimento"]', 0, 121),

    ('Um serviço de manutenção vai ocupar parte do corredor de circulação. O correto é:',
     '["Colocar um trabalhador orientando sem sinalização", "Isolar e sinalizar a área, definir desvio e comunicar a todos que circulam ali", "Avisar apenas os operadores do turno", "Manter a circulação normal, com atenção redobrada"]', 1, 122),

    ('O portão automático do setor abre para a passagem de equipamentos e pessoas. O cuidado necessário é:',
     '["Segurar o sensor para o portão ficar aberto", "Passar por baixo do portão em movimento", "Aguardar a abertura completa, não passar junto com o equipamento e respeitar a sinalização do local", "Passar rente ao equipamento, para aproveitar a abertura"]', 2, 123),

    ('O motorista saiu com o caminhão enquanto a empilhadeira ainda estava carregando. Como isso é evitado?',
     '["Pedindo ao motorista que fique atento", "Deixando um trabalhador ao lado do caminhão", "Carregando mais rápido, para reduzir o tempo", "Com trava do veículo, comunicação combinada e sinalização de que a operação está em curso, além da retirada da chave do caminhão conforme o procedimento"]', 3, 124),

    ('Antes de iniciar o carregamento, o operador precisa combinar com o motorista:',
     '["Apenas a nota fiscal do produto", "Apenas o número de pallets a carregar", "Onde ele vai aguardar, como será a comunicação e que o veículo não sai antes da liberação", "Apenas o horário de saída da carga"]', 2, 125),

    ('Uma carga a ser movimentada ultrapassa a capacidade indicada na placa do equipamento. O operador deve:',
     '["Movimentar devagar e com cuidado", "Movimentar com a carga bem baixa", "Movimentar com um colega em cima do contrapeso para equilibrar", "Recusar a movimentação e comunicar, buscando o equipamento adequado para aquela carga"]', 3, 126),

    ('Por que frear bruscamente com a carga elevada é perigoso?',
     '["Porque o operador pode bater no volante", "Porque com o centro de gravidade alto o equipamento tende a tombar para a frente com a inércia da carga", "Porque a carga pode escorregar dos garfos apenas", "Porque o freio esquenta e perde eficiência"]', 1, 127),

    ('Como se sobe e se desce da empilhadeira?',
     '["Mantendo três pontos de apoio, de frente para o equipamento, usando o degrau e a alça, com as mãos livres", "Saltando para o chão, o que é mais rápido", "De costas para o equipamento, olhando o corredor", "Segurando o volante como apoio para descer"]', 0, 128),

    ('Um operador tem o costume de saltar da empilhadeira ao descer. O problema é:',
     '["Nenhum, se ele for jovem e saudável", "Salto repetido causa lesão em joelho, tornozelo e coluna, e escorregar no piso oleoso vira queda grave", "O equipamento pode se mover com o impulso", "Apenas o desgaste do calçado de segurança"]', 1, 129),

    ('O que se verifica nos pneus da empilhadeira durante a inspeção?',
     '["Desgaste, cortes, pedaços faltando e objetos encravados, porque o pneu ruim altera a estabilidade e a frenagem", "Apenas a marca e o modelo", "Apenas a cor da borracha", "Apenas se o pneu está limpo"]', 0, 130),

    ('Há vazamento de óleo do equipamento pingando no piso do corredor. O que fazer?',
     '["Espalhar serragem e continuar operando", "Continuar operando e limpar no fim do turno", "Passar por cima em velocidade para secar o piso", "Sinalizar e conter o vazamento, limpar o piso e encaminhar o equipamento para manutenção"]', 3, 131),

    ('O operador percebeu uma avaria no meio do serviço. O correto é:',
     '["Continuar até o fim do turno com mais cuidado", "Comunicar e continuar, se o defeito parecer pequeno", "Parar o equipamento em local seguro, comunicar e não voltar a usar até a liberação da manutenção", "Terminar a tarefa em andamento e depois comunicar"]', 2, 132),

    ('Para que serve a etiqueta de bloqueio colocada em um equipamento com defeito?',
     '["Registrar a data da última manutenção", "Indicar o setor responsável pelo equipamento", "Marcar o equipamento para descarte", "Avisar de forma visível que ele não pode ser usado e identificar quem bloqueou e por quê"]', 3, 133),

    ('Quem libera o equipamento para voltar a operar após o conserto?',
     '["O supervisor do turno, por avaliação visual", "Qualquer operador que precise do equipamento", "A manutenção, com o registro de que o serviço foi feito e o equipamento testado", "O próprio operador, ao perceber que voltou a funcionar"]', 2, 134),

    ('Por que os quase-acidentes com o equipamento devem ser comunicados?',
     '["Porque a mesma causa que quase provocou o acidente continua ali, e a correção precisa vir antes da próxima vez", "Porque a comunicação isenta o operador de responsabilidade", "Porque o número de comunicações melhora o indicador do setor", "Porque a norma exige um comunicado por mês"]', 0, 135),

    ('Uma carga caiu durante a movimentação, sem ferir ninguém. O que precisa acontecer?',
     '["Trocar o operador da tarefa", "Investigar a causa, corrigir e informar a equipe, porque a próxima queda pode ter alguém embaixo", "Recolher o material e seguir o serviço", "Registrar apenas a perda do produto"]', 1, 136),

    ('O operador vai movimentar um produto perigoso pela primeira vez. O que ele precisa antes?',
     '["Conhecer os riscos do produto, os cuidados de manuseio e o que fazer em caso de derrame ou avaria da embalagem", "Apenas o endereço de armazenagem do produto", "Apenas a autorização verbal do supervisor", "Apenas o EPI que já usa normalmente"]', 0, 137),

    ('Onde o operador encontra as informações de risco do produto químico que vai movimentar?',
     '["No endereço do estoque no sistema", "No manual da empilhadeira", "Na ficha de segurança do produto e no rótulo da embalagem, disponíveis para consulta", "Na nota fiscal da carga"]', 2, 138),

    ('Cargas de produtos incompatíveis chegaram para armazenagem no mesmo local. O correto é:',
     '["Armazenar juntos em pilhas baixas", "Separar conforme a compatibilidade e o procedimento, porque produtos incompatíveis juntos podem reagir em caso de vazamento", "Armazenar juntos, se as embalagens estiverem fechadas", "Armazenar juntos e sinalizar a pilha"]', 1, 139),

    ('Um serviço será feito embaixo do trajeto de içamento, no mesmo horário. O correto é:',
     '["Executar com os dois grupos atentos", "Executar com um sinaleiro avisando cada passagem", "Executar com o pessoal de baixo usando capacete", "Não executar os dois ao mesmo tempo, ou isolar completamente a área embaixo da carga"]', 3, 140),

    ('O que se verifica no gancho de içamento antes do uso?',
     '["Apenas se ele gira livremente", "Apenas se o cabo está enrolado corretamente", "Se a trava de segurança funciona, se não há deformação, trinca ou abertura da garganta e se a identificação está legível", "Apenas se ele está limpo e pintado"]', 2, 141),

    ('Antes de elevar a carga, o operador precisa:',
     '["Apenas conferir se a torre está limpa", "Aplicar o freio de estacionamento, confirmar que o equipamento está estável e que ninguém está na área de risco", "Apenas confirmar o peso da carga no sistema", "Apenas avisar pelo rádio que vai elevar"]', 1, 142),

    ('A empilhadeira elétrica está com a carga da bateria no fim durante a operação. O correto é:',
     '["Continuar operando até a bateria acabar", "Continuar apenas com cargas leves", "Recarregar por poucos minutos e retomar", "Encerrar a tarefa em local seguro, com a carga baixada, e recarregar, porque a queda de força pode ocorrer com a carga no alto"]', 3, 143),

    ('O que muda ao operar dentro de uma câmara fria?',
     '["Piso escorregadio, condensação, visibilidade reduzida ao entrar e sair, além do risco do frio para o operador", "Nada, porque o equipamento é o mesmo", "Apenas a necessidade de operar mais rápido", "Apenas a duração da bateria"]', 0, 144),

    ('Deixar a empilhadeira a combustão ligada e parada dentro do galpão é:',
     '["Aceitável, para manter o motor aquecido", "Errado: consome combustível à toa e concentra gases do escapamento no ambiente fechado", "Aceitável, se for por poucos minutos", "Aceitável, se o portão estiver aberto"]', 1, 145),

    ('Ao encerrar o turno, o operador deve:',
     '["Deixar o equipamento no ponto onde parou a última tarefa", "Deixar o equipamento carregando com a carga nos garfos", "Entregar a chave ao primeiro colega que aparecer", "Estacionar no local definido, com garfos baixados, freio aplicado, equipamento desligado, chave retirada e registro das pendências"]', 3, 146),

    ('Sobre a limpeza do equipamento e do posto de trabalho:',
     '["Faz parte da operação: piso e equipamento limpos reduzem escorregão, incêndio e falha, e revelam vazamentos", "É atribuição exclusiva do pessoal da limpeza", "Só é feita na parada mensal de manutenção", "Só é feita quando a fiscalização visita a empresa"]', 0, 147),

    ('Qual é a responsabilidade do supervisor na movimentação de cargas?',
     '["Apenas assinar o checklist no fim do mês", "Apenas escalar os operadores de cada turno", "Garantir que só operem trabalhadores autorizados, com equipamento em condição de uso, e providenciar a correção dos desvios comunicados", "Apenas cobrar a produtividade do setor"]', 2, 148),

    ('Um operador reclama repetidamente do mesmo defeito e nada é corrigido. O que ele deve fazer?',
     '["Aceitar e operar com mais cuidado", "Resolver o problema por conta própria", "Trocar de equipamento sem comunicar", "Registrar formalmente, comunicar ao superior e à CIPA ou ao SESMT e não operar se houver risco grave"]', 3, 149),

    ('Qual é a diferença entre o pallet padrão do estoque e um pallet improvisado com madeira reaproveitada?',
     '["O padrão tem dimensões e resistência conhecidas; o improvisado não tem capacidade definida e pode ceder com a carga no alto", "Apenas o custo de cada um", "Apenas a cor da madeira", "Nenhuma, se o improvisado parecer firme"]', 0, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-11';


-- =====================================================================
--  NR-05 — CIPA (questões 41 a 150)
--  As 40 primeiras cobrem a comissão por dentro. Aqui o peso vai para o
--  trabalho de campo do cipeiro: inventário de risco, investigação de
--  acidente, CAT, inspeção, eleição passo a passo e prevenção ao assédio.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-05')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Qual é o papel da CIPA em relação ao Programa de Gerenciamento de Riscos da empresa?',
     '["Nenhum, porque o programa é assunto exclusivo do empregador", "Acompanhar o programa, participar da identificação dos riscos e cobrar as ações previstas no plano", "Elaborar o programa sozinha, sem o SESMT", "Aprovar tecnicamente o programa antes da fiscalização"]', 1, 41),

    ('O que é o inventário de riscos da empresa?',
     '["A lista de equipamentos de proteção comprados no ano", "O registro dos acidentes ocorridos no estabelecimento", "O inventário dos produtos químicos em estoque", "O levantamento dos perigos e riscos existentes, com a avaliação de cada um, que orienta as medidas de prevenção"]', 3, 42),

    ('Para que serve o plano de ação ligado ao gerenciamento de riscos?',
     '["Registrar os treinamentos realizados no ano", "Substituir o mapa de riscos do setor", "Definir o que será feito, por quem e até quando para eliminar ou reduzir cada risco identificado", "Listar os riscos sem definir prazo"]', 2, 43),

    ('Como a CIPA acompanha o plano de ação?',
     '["Verificando nas reuniões o que foi cumprido, o que atrasou e por quê, e registrando em ata a cobrança", "Aguardando o relatório anual da empresa", "Verificando apenas quando ocorre acidente", "Deixando o acompanhamento por conta do SESMT"]', 0, 44),

    ('A CAT, Comunicação de Acidente de Trabalho, é emitida:',
     '["Somente pelo médico que atendeu o trabalhador", "Somente quando o afastamento passa de quinze dias", "Somente pelo sindicato da categoria", "Pela empresa, no prazo legal, mesmo quando não há afastamento, e o trabalhador ou o sindicato podem emitir se a empresa não fizer"]', 3, 45),

    ('Um trabalhador se acidentou no caminho de casa para a empresa. Isso é:',
     '["Acidente comum, que só interessa ao plano de saúde", "Acidente de trabalho apenas se ele usava veículo da empresa", "Acidente de trajeto, que também é comunicado conforme as regras aplicáveis", "Assunto particular do trabalhador, sem relação com a empresa"]', 2, 46),

    ('O que caracteriza uma doença ocupacional?',
     '["O adoecimento causado ou agravado pelas condições em que o trabalho é executado", "Qualquer doença que apareça durante o contrato de trabalho", "Somente doenças que causam afastamento superior a um mês", "Somente doenças respiratórias em ambiente industrial"]', 0, 47),

    ('Um trabalhador se cortou, foi atendido no ambulatório e voltou ao serviço no mesmo dia. Isso é:',
     '["Acidente apenas se houver pontos no ferimento", "Acidente de trabalho, que deve ser registrado, comunicado e investigado como qualquer outro", "Apenas um incidente sem importância", "Um caso de assistência médica, não de segurança"]', 1, 48),

    ('Quando um acidente acontece no setor, a CIPA deve ser:',
     '["Informada apenas na reunião ordinária seguinte", "Informada apenas se o acidentado for cipeiro", "Informada para acompanhar e participar da análise das causas e das medidas de correção", "Informada apenas se houver afastamento"]', 2, 49),

    ('Qual deve ser a postura na investigação de um acidente?',
     '["Buscar as causas que permitiram o acidente, incluindo organização do trabalho e falhas de controle, sem parar na culpa do acidentado", "Identificar o responsável e aplicar a advertência cabível", "Encerrar o caso quando o trabalhador admite o erro", "Concluir sempre por descuido do trabalhador"]', 0, 50),

    ('O que o cipeiro tem a acrescentar quando participa da investigação de um acidente?',
     '["Cuidar do atendimento médico do acidentado", "Trazer o conhecimento de quem convive com a tarefa, ouvir os colegas e ajudar a enxergar o que a análise técnica não vê", "Assinar o relatório final elaborado pelo SESMT", "Informar o histórico disciplinar do acidentado"]', 1, 51),

    ('O relatório de investigação de acidente precisa conter:',
     '["Apenas a descrição do que aconteceu", "Apenas o custo do afastamento para a empresa", "Apenas o nome das testemunhas do acidente", "As causas identificadas e as ações corretivas com responsável e prazo definidos"]', 3, 52),

    ('Depois que a ação corretiva foi implantada, o que a CIPA ainda precisa fazer?',
     '["Verificar se ela realmente funcionou na prática e se o risco deixou de existir", "Encerrar o caso e arquivar o relatório", "Aguardar um novo acidente para reavaliar", "Repassar o acompanhamento para o setor de qualidade"]', 0, 53),

    ('Por que a CIPA se interessa por quase-acidentes?',
     '["Porque a norma exige um registro por trabalhador", "Porque eles mostram de graça onde o próximo acidente vai acontecer, sem que ninguém tenha se ferido", "Porque o número de quase-acidentes reduz o seguro da empresa", "Porque quase-acidente conta como acidente para a estatística oficial"]', 1, 54),

    ('Para que servem as taxas de frequência e de gravidade de acidentes?',
     '["Definir o valor do adicional de insalubridade", "Classificar os trabalhadores mais acidentados", "Calcular o número de cipeiros do estabelecimento", "Comparar a evolução dos acidentes no tempo e orientar onde a prevenção precisa ser reforçada"]', 3, 55),

    ('O que a CIPA observa quando acompanha os dias de afastamento por acidente?',
     '["O custo do plano de saúde da empresa", "A necessidade de contratação de novos empregados", "A gravidade e o impacto real dos acidentes, e não apenas quantos aconteceram", "O desempenho individual dos acidentados"]', 2, 56),

    ('O que é um indicador proativo de segurança?',
     '["A quantidade de CAT emitidas", "A medida do que se faz para prevenir, como inspeções realizadas e ações concluídas, e não apenas o número de acidentes", "O número de acidentes com afastamento do mês", "O total de dias perdidos no ano"]', 1, 57),

    ('Para que serve um roteiro ou checklist na inspeção de segurança?',
     '["Substituir a visita ao setor", "Avaliar o desempenho dos trabalhadores do setor", "Garantir que os mesmos pontos sejam verificados sempre, sem depender da memória de quem inspeciona", "Registrar a presença dos cipeiros na inspeção"]', 2, 58),

    ('Com que frequência a CIPA deve inspecionar os setores?',
     '["Somente uma vez por mandato", "Somente quando houver denúncia", "Somente na semana da SIPAT", "De forma planejada e regular, conforme o calendário definido, e sempre que houver situação que justifique"]', 3, 59),

    ('Durante a inspeção, a CIPA encontra vários EPIs danificados no setor. O correto é:',
     '["Registrar, comunicar e cobrar a substituição imediata, verificando também por que os EPIs chegaram a esse estado", "Orientar os trabalhadores a usarem com cuidado", "Anotar para tratar no fim do mandato", "Recolher os EPIs e guardar na sala da CIPA"]', 0, 60),

    ('Ao verificar os extintores durante a inspeção, a CIPA observa:',
     '["Apenas se a quantidade confere com a planta", "Apenas o peso de cada extintor", "Apenas a data de fabricação do cilindro", "Se estão no lugar, sinalizados, desobstruídos, dentro da validade e com o lacre íntegro, comunicando o que estiver irregular"]', 3, 61),

    ('O que é a ordem de serviço sobre segurança e saúde no trabalho?',
     '["O documento em que a empresa informa por escrito ao trabalhador os riscos, as medidas de prevenção e o que se exige dele", "O documento que autoriza o início de uma tarefa perigosa", "O registro da entrega do EPI", "O comunicado interno de mudança de setor"]', 0, 62),

    ('Qual é o papel da CIPA na integração dos trabalhadores recém-admitidos?',
     '["Definir sozinha o conteúdo da integração", "Nenhum, porque a integração é atribuição do RH", "Participar da orientação sobre riscos e prevenção e se apresentar como canal para os novos trabalhadores", "Aplicar a prova de admissão do novo empregado"]', 2, 63),

    ('Para que serve o diálogo diário de segurança antes do início do serviço?',
     '["Distribuir as tarefas do dia", "Alinhar os riscos do dia e os cuidados da tarefa, e abrir espaço para o trabalhador falar do que está diferente", "Registrar a presença dos trabalhadores no turno", "Substituir o treinamento formal da função"]', 1, 64),

    ('Depois da SIPAT, o que a CIPA precisa fazer?',
     '["Divulgar apenas as fotos do evento", "Arquivar o material sem avaliação", "Avaliar o que funcionou, registrar os resultados e transformar o que se discutiu em ações concretas no ano", "Encerrar as atividades até a próxima SIPAT"]', 2, 65),

    ('A sinalização de segurança de um setor está apagada e ilegível. Para a CIPA, isso é:',
     '["Aceitável enquanto os trabalhadores conhecerem o setor", "Um desvio a ser registrado e corrigido, porque sinalização que não se lê não avisa ninguém", "Um problema estético, de menor importância", "Assunto exclusivo da manutenção predial"]', 1, 66),

    ('Trabalhadores reclamam de um posto de trabalho que obriga a postura forçada. A CIPA deve:',
     '["Registrar, encaminhar para avaliação ergonômica e acompanhar a implantação das melhorias", "Orientar os trabalhadores a se alongarem mais", "Sugerir revezamento sem outra providência", "Encaminhar cada trabalhador ao médico individualmente"]', 0, 67),

    ('Ao inspecionar uma atividade em altura, o que a CIPA verifica?',
     '["Apenas se todos usam capacete", "Apenas a altura da plataforma", "Apenas a presença do supervisor no local", "Se há análise de risco e autorização, se os trabalhadores são capacitados, se os equipamentos estão íntegros e se há plano de resgate"]', 3, 68),

    ('Sobre a entrada em espaço confinado, o papel da CIPA é:',
     '["Acompanhar se o procedimento está sendo cumprido, com permissão, medição, vigia e resgate previstos", "Autorizar a entrada da equipe", "Executar a medição da atmosfera", "Substituir o supervisor de entrada quando ele faltar"]', 0, 69),

    ('Ao encontrar um produto químico sem identificação no setor, a CIPA deve:',
     '["Recolher o recipiente e descartar", "Anotar e tratar no próximo mandato", "Orientar os trabalhadores a não mexerem no produto", "Comunicar e exigir a identificação e a ficha de segurança disponível, porque ninguém se protege do que não sabe o que é"]', 3, 70),

    ('Em um setor barulhento, o que precisa ser verificado além do uso do protetor?',
     '["Apenas a existência de placas de advertência", "Se há medidas de redução na fonte, se o programa de conservação auditiva funciona e se os protetores são adequados e usados", "Apenas se os trabalhadores usam protetor auditivo", "Apenas o número de trabalhadores expostos"]', 1, 71),

    ('Qual é a relação entre a CIPA e o programa de controle médico da empresa?',
     '["A CIPA tem acesso aos prontuários individuais", "A CIPA não tem relação com a área de saúde", "A CIPA acompanha e ajuda a divulgar, e usa as informações coletivas de saúde para orientar suas ações de prevenção", "A CIPA marca os exames de cada trabalhador"]', 2, 72),

    ('Um trabalhador está com o exame periódico vencido. A CIPA deve:',
     '["Aguardar a próxima campanha de exames", "Comunicar à empresa para regularizar, porque o exame é parte do acompanhamento da saúde de quem se expõe ao risco", "Afastar o trabalhador do serviço", "Marcar o exame diretamente com a clínica"]', 1, 73),

    ('Sobre o fornecimento de EPI ao trabalhador:',
     '["É descontado do salário quando há extravio, sem exceção", "É responsabilidade do trabalhador comprar o seu", "É obrigatório apenas para quem trabalha em altura", "É gratuito, adequado ao risco, com orientação de uso e substituição quando danificado ou extraviado"]', 3, 74),

    ('Um trabalhador se recusa a usar o EPI dizendo que atrapalha. A conduta correta é:',
     '["Aceitar a recusa, porque o uso é opcional", "Trocar o trabalhador de setor sem avaliar", "Entender o motivo, verificar se o EPI é adequado e confortável, orientar sobre o risco e, se necessário, buscar alternativa técnica", "Aplicar advertência imediata sem conversar"]', 2, 75),

    ('O uso do EPI fornecido pela empresa é:',
     '["Obrigação do trabalhador, que também deve conservá-lo e comunicar qualquer alteração que o torne impróprio", "Facultativo, se o trabalhador assinar termo de responsabilidade", "Obrigatório apenas na presença da fiscalização", "Obrigatório apenas para os trabalhadores mais novos"]', 0, 76),

    ('O que pode acontecer quando a fiscalização do trabalho encontra risco grave e iminente?',
     '["Apenas a aplicação de multa administrativa", "Apenas a notificação com prazo de um ano", "Apenas a recomendação à CIPA", "A interdição do local ou o embargo da obra, com a paralisação até que o risco seja eliminado"]', 3, 77),

    ('Qual é a participação do sindicato no processo eleitoral da CIPA?',
     '["Ele preside a comissão eleitoral", "Ele apura os votos no lugar da empresa", "Ele é comunicado do processo e pode acompanhar a eleição, conforme as regras aplicáveis", "Ele indica os candidatos dos trabalhadores"]', 2, 78),

    ('Por que existe exigência de participação mínima dos empregados na votação?',
     '["Para que os eleitos representem de fato os trabalhadores, e não apenas um pequeno grupo", "Para reduzir o tempo de apuração", "Para garantir vaga a todos os candidatos", "Para dispensar a realização de nova eleição"]', 0, 79),

    ('Como deve ser a votação para a CIPA?',
     '["Por indicação dos encarregados de cada área", "Secreta, em urna, em horário que permita a participação de todos os turnos", "Aberta, com registro do voto de cada empregado", "Por aclamação em reunião de setor"]', 1, 80),

    ('O que se faz com as cédulas e a documentação após a apuração?',
     '["São entregues aos candidatos eleitos", "São enviadas ao sindicato para arquivo", "São guardadas pelo período previsto, junto com a ata da eleição, para permitir conferência", "São descartadas logo após a contagem"]', 2, 81),

    ('Dois candidatos empataram em número de votos. Como se resolve?',
     '["Pelo critério de desempate previsto no processo eleitoral, definido e divulgado antes da votação", "Por sorteio feito na hora, sem critério anterior", "Pela escolha do presidente da CIPA anterior", "Por nova eleição geral no estabelecimento"]', 0, 82),

    ('Como se define quem é titular e quem é suplente na eleição da CIPA?',
     '["Por ordem alfabética dos candidatos", "Pela ordem decrescente de votos recebidos, respeitando o número de vagas de cada condição", "Por escolha dos próprios eleitos após a apuração", "Por indicação da empresa entre os eleitos"]', 1, 83),

    ('Para que serve o edital de convocação da eleição da CIPA?',
     '["Informar apenas o dia da votação", "Divulgar o nome dos candidatos escolhidos pela empresa", "Cumprir formalidade sem efeito prático", "Dar publicidade ao processo, com prazos e regras, para que todos possam se inscrever e votar"]', 3, 84),

    ('Sobre a inscrição de candidatos à CIPA:',
     '["É individual, feita no prazo do edital, com comprovante de inscrição entregue ao candidato", "Depende de aprovação prévia da chefia", "É feita por indicação dos colegas do setor", "É automática para todos os empregados"]', 0, 85),

    ('Um trabalhador percebe irregularidade no processo eleitoral. O que ele pode fazer?',
     '["Deixar para reclamar no mandato seguinte", "Registrar a impugnação pelo caminho e no prazo previstos, para que a irregularidade seja avaliada", "Nada, porque a eleição é ato da empresa", "Pedir a anulação diretamente ao presidente eleito"]', 1, 86),

    ('Quando os eleitos assumem a CIPA?',
     '["Assim que o resultado da eleição é divulgado", "Somente após a conclusão do treinamento, em qualquer data", "Somente após a homologação do sindicato", "Na posse, no primeiro dia do novo mandato, em continuidade ao mandato anterior"]', 3, 87),

    ('O que acontece na primeira reunião do novo mandato da CIPA?',
     '["A eleição do presidente pelos membros", "A entrega dos certificados de treinamento", "Define-se o secretário, o calendário e o plano de trabalho, com registro em ata", "Apenas a apresentação dos membros eleitos"]', 2, 88),

    ('Para que serve o calendário anual de reuniões da CIPA?',
     '["Substituir a convocação de cada reunião", "Garantir a regularidade das reuniões e permitir que todos se programem para participar", "Cumprir exigência do setor de pessoal", "Definir as datas das inspeções apenas"]', 1, 89),

    ('Por que os assuntos a discutir são enviados aos membros com antecedência?',
     '["Substituir a ata da reunião anterior", "Definir quem vai falar em cada assunto", "Permitir que os membros cheguem preparados e que os assuntos importantes não fiquem de fora", "Registrar a presença antecipada dos membros"]', 2, 90),

    ('O que fazer quando não há número suficiente de membros presentes na reunião?',
     '["Realizar a reunião assim mesmo e decidir por um único membro", "Cancelar sem registro e remarcar informalmente", "Substituir os ausentes por trabalhadores do setor", "Registrar a ocorrência, verificar o motivo das ausências e adotar as providências previstas para garantir a regularidade"]', 3, 91),

    ('Como as decisões da CIPA devem ser tomadas?',
     '["Em reunião, com a participação dos representantes das duas partes, e registradas em ata", "Pelo presidente, que decide e informa os demais", "Por votação apenas entre os representantes dos empregados", "Informalmente, entre os membros que estiverem disponíveis"]', 0, 92),

    ('Terminada a reunião, qual é o destino da ata?',
     '["É guardada em sigilo pelo secretário", "É enviada apenas à diretoria da empresa", "É lida na reunião seguinte e depois descartada", "É assinada pelos presentes, arquivada e disponibilizada aos trabalhadores e à empresa"]', 3, 93),

    ('Por que os documentos da CIPA precisam ficar organizados e acessíveis?',
     '["Porque comprovam o funcionamento da comissão e podem ser exigidos pela fiscalização a qualquer momento", "Porque servem de material para a SIPAT", "Porque são usados no cálculo do adicional de risco", "Porque substituem o programa de gerenciamento de riscos"]', 0, 94),

    ('A empresa vai mudar o layout e o processo de um setor. Qual é a hora certa de a comissão entrar no assunto?',
     '["Somente se a mudança provocar algum acidente", "Somente na inspeção seguinte à conclusão da obra", "Antes da mudança, para que os riscos novos sejam avaliados enquanto ainda dá para alterar o projeto", "Depois da mudança, quando os trabalhadores começarem a reclamar"]', 2, 95),

    ('Uma empresa tem três unidades em cidades diferentes. Sobre a CIPA:',
     '["A CIPA é constituída por região, não por unidade", "A obrigação é avaliada por estabelecimento, conforme o número de empregados e o grau de risco de cada um", "Uma única CIPA na matriz atende todas as unidades", "Somente a maior unidade precisa de CIPA"]', 1, 96),

    ('O dimensionamento da CIPA depende de:',
     '["Do número de setores existentes", "Da quantidade de acidentes do ano anterior", "Número de empregados do estabelecimento e do grau de risco da atividade, conforme os quadros da norma", "Do faturamento anual da empresa"]', 2, 97),

    ('Em um canteiro de obras, a organização da comissão de prevenção segue:',
     '["Nenhuma regra específica, por ser atividade temporária", "As regras específicas aplicáveis à construção, além do que a norma da CIPA estabelece", "Somente a norma da CIPA, sem particularidades", "As regras definidas pelo contratante da obra"]', 1, 98),

    ('Na atividade rural, a comissão de prevenção:',
     '["Segue as regras específicas do trabalho rural, com a mesma finalidade de prevenir acidentes e doenças", "Não é exigida em nenhuma hipótese", "Segue integralmente as regras da indústria", "É substituída pelo sindicato rural"]', 0, 99),

    ('O suplente eleito da CIPA tem estabilidade no emprego?',
     '["Não, apenas os titulares têm garantia", "Somente quando substitui um titular", "Somente no último ano do mandato", "Sim: a garantia alcança titulares e suplentes eleitos pelos empregados"]', 3, 100),

    ('A empresa encerrou as atividades do estabelecimento onde havia comissão. E a garantia de emprego dos eleitos?',
     '["Não subsiste, porque a extinção do estabelecimento faz cessar a atividade que a garantia protegia", "Continua valendo por mais cinco anos em qualquer unidade da empresa", "Obriga a empresa a manter as reuniões funcionando sem trabalhadores", "Transfere automaticamente os eleitos para outro estabelecimento"]', 0, 101),

    ('A estabilidade do cipeiro impede a dispensa por justa causa?',
     '["Sim, o cipeiro não pode ser dispensado em nenhuma hipótese", "Sim, enquanto durar o mandato", "Não, porque a estabilidade não existe na prática", "Não: a garantia protege contra a dispensa arbitrária, mas não afasta a dispensa por falta grave apurada"]', 3, 102),

    ('A empresa quer transferir um cipeiro para outro turno. Isso:',
     '["Extingue automaticamente o mandato dele", "Não pode prejudicar o exercício do mandato nem servir para afastá-lo da função de representação", "É livre, porque a organização do turno é da empresa", "Só é possível com autorização do sindicato"]', 1, 103),

    ('Um cipeiro pode se candidatar novamente ao final do mandato?',
     '["Sim, sem qualquer limite de mandatos seguidos", "Somente se mudar de setor", "Sim, observados os limites de reeleição previstos na norma", "Não, cada trabalhador só participa uma vez"]', 2, 104),

    ('Um cipeiro quer renunciar ao mandato por motivo pessoal. O que acontece?',
     '["O mandato inteiro da CIPA é encerrado", "A renúncia é formalizada, registrada em ata e a vaga é preenchida conforme a ordem prevista", "A vaga fica aberta até a próxima eleição", "A empresa indica um substituto de sua escolha"]', 1, 105),

    ('Um cipeiro eleito foi promovido a um cargo de chefia. O que a CIPA precisa observar?',
     '["Nada, porque a promoção é assunto da empresa", "Excluir o cipeiro imediatamente, sem registro", "Transformar o cipeiro em representante da empresa por decisão própria", "Verificar se a nova condição compromete a representação dos empregados e adotar o procedimento previsto para a situação"]', 3, 106),

    ('O titular faltará à próxima reunião. O que se faz?',
     '["A vaga fica vazia na reunião", "Outro titular vota duas vezes", "Convoca-se o suplente, que participa com os mesmos direitos naquela reunião", "A reunião é adiada até o titular poder comparecer"]', 2, 107),

    ('Sobre o treinamento dos membros da CIPA:',
     '["Tem carga horária e conteúdo definidos e é realizado no prazo previsto em relação ao início do mandato", "É opcional para quem já participou de outro mandato", "É feito somente para o presidente e o vice", "Tem duração livre, definida pela empresa"]', 0, 108),

    ('O que o treinamento da CIPA precisa abordar?',
     '["Somente as atribuições formais da comissão", "Somente noções de primeiros socorros", "Somente legislação trabalhista geral", "Riscos do estabelecimento, prevenção de acidentes e doenças, funcionamento da comissão, investigação de acidentes e prevenção ao assédio"]', 3, 109),

    ('Qual é a diferença entre o representante eleito e o representante indicado pela empresa?',
     '["O indicado tem mais poder de decisão nas reuniões", "O eleito participa apenas das reuniões, e o indicado das inspeções", "O eleito é escolhido pelos empregados em votação e tem garantia de emprego; o indicado é escolhido pela empresa, que pode substituí-lo", "Não há diferença: ambos são escolhidos pelos trabalhadores"]', 2, 110),

    ('Passado o primeiro ano, o conteúdo aprendido no curso ainda basta?',
     '["Atualização periódica, para acompanhar mudanças de processo, de risco e de norma", "Nada mais, porque o conteúdo não muda", "Somente novo treinamento em caso de reeleição", "Somente treinamento quando muda a empresa"]', 0, 111),

    ('O treinamento da CIPA acontece durante o expediente. Como fica a remuneração?',
     '["O trabalhador tira o tempo do banco de horas", "O tempo é considerado de trabalho efetivo, sem prejuízo ao trabalhador", "O trabalhador compensa as horas depois", "O trabalhador participa fora do expediente, sem pagamento"]', 1, 112),

    ('Um trabalhador terceirizado sofreu um acidente no estabelecimento. A CIPA da contratante:',
     '["Apenas registra o fato em ata", "Encaminha o assunto exclusivamente ao contrato comercial", "Participa da análise e das medidas, porque o risco está no ambiente que ela acompanha", "Não se envolve, porque o trabalhador é de outra empresa"]', 2, 113),

    ('Um risco apontado exige investimento alto e obra demorada. O que fazer enquanto a solução definitiva não chega?',
     '["Cobrar medidas provisórias que reduzam o risco e um cronograma com prazo e responsável para a solução final", "Aguardar a conclusão da obra sem outra providência", "Retirar o assunto da pauta até haver orçamento", "Considerar o risco aceito pela empresa"]', 0, 114),

    ('Sobre o trabalho do jovem aprendiz e do menor de dezoito anos:',
     '["A restrição é apenas de horário, não de tarefa", "Há atividades vedadas a eles por serem perigosas ou insalubres, e a CIPA deve ficar atenta a essa alocação", "Eles podem executar qualquer tarefa, com supervisão", "Eles só não podem trabalhar em altura"]', 1, 115),

    ('O que a CIPA verifica em relação a um trabalhador com deficiência no setor?',
     '["Apenas se ele recebe o mesmo EPI dos demais", "Apenas se ele consegue cumprir a produção", "Nada, porque a questão é do setor de pessoal", "Se o posto, a comunicação de emergência e a rota de fuga atendem à condição dele, além das adaptações necessárias"]', 3, 116),

    ('Um trabalhador retorna após afastamento longo por acidente. A CIPA deve:',
     '["Acompanhar o retorno, verificar se o risco que causou o acidente foi eliminado e se a função é compatível com a condição atual", "Apenas registrar o retorno em ata", "Aguardar o trabalhador reclamar de algum problema", "Encaminhar o caso somente ao setor de pessoal"]', 0, 117),

    ('Um trabalhador foi readaptado em outra função. O que precisa ser verificado?',
     '["Nada, porque readaptação é assunto individual", "Se a nova função respeita as restrições, se o trabalhador foi treinado para ela e se não há novo risco criado", "Apenas a mudança de salário do trabalhador", "Apenas o parecer do médico assistente"]', 1, 118),

    ('Como a CIPA e o SESMT se relacionam?',
     '["A CIPA fiscaliza o trabalho do SESMT", "O SESMT decide e a CIPA apenas registra", "São áreas independentes, sem contato", "Atuam juntos: o SESMT traz o conhecimento técnico e a CIPA a vivência dos setores, com objetivos comuns"]', 3, 119),

    ('Um profissional de segurança participa da reunião da CIPA. Ele:',
     '["Vota nas decisões no lugar dos membros", "Não pode participar da reunião", "Contribui tecnicamente com as discussões e ajuda a viabilizar as ações, conforme a organização da empresa", "Substitui o presidente na condução da reunião"]', 2, 120),

    ('A CIPA quer convidar um trabalhador do setor para explicar um problema na reunião. Isso:',
     '["Só é permitido em reunião extraordinária", "É possível e desejável, porque quem executa a tarefa conhece detalhes que ninguém mais vê", "Não é permitido: só membros participam", "Só é permitido com autorização do sindicato"]', 1, 121),

    ('Há um desentendimento entre membros da CIPA sobre a prioridade das ações. O caminho é:',
     '["Levar a discussão para fora da comissão", "Suspender a reunião até o acordo entre os membros", "Discutir na reunião, registrar as posições e decidir com base no risco, não na preferência pessoal", "Deixar o presidente decidir sozinho"]', 2, 122),

    ('A CIPA pode determinar a parada de uma atividade?',
     '["Sim, a CIPA emite ordem de parada em qualquer situação", "Não, a CIPA nem sequer pode recomendar", "Somente com autorização prévia do sindicato", "Ela comunica o risco e recomenda a paralisação, e diante de risco grave e iminente a atividade deve ser interrompida pela empresa"]', 3, 123),

    ('A CIPA identificou um risco grave. Como isso deve ser comunicado à empresa?',
     '["Por escrito, com registro em ata e prazo para resposta, para que fique documentado o que foi solicitado", "Verbalmente ao encarregado do setor", "Por mensagem informal ao supervisor", "Somente na reunião ordinária seguinte"]', 0, 124),

    ('Registrar fotografias e observações durante a inspeção serve para:',
     '["Identificar os trabalhadores responsáveis pelo desvio", "Divulgar nas redes sociais da empresa", "Substituir o relatório de inspeção", "Documentar a situação encontrada e permitir a comparação depois da correção"]', 3, 125),

    ('O que distingue o assédio sexual do assédio moral no trabalho?',
     '["O assédio sexual envolve conduta de conotação sexual não desejada, e pode configurar-se mesmo em um único episódio", "O assédio sexual só existe entre chefe e subordinado", "O assédio sexual só se configura com repetição por vários meses", "Não há distinção: os dois são tratados como a mesma conduta"]', 0, 126),

    ('De quem é a responsabilidade por adotar as medidas contra o assédio na empresa?',
     '["Do setor de recursos humanos, sem participação da comissão", "De cada gestor, conforme o entendimento dele", "Do empregador, que as define e implanta, cabendo à comissão acompanhar, apoiar e cobrar", "Da comissão, que responde sozinha pelo tema"]', 2, 127),

    ('Qual é a diferença entre assédio moral e uma cobrança normal de trabalho?',
     '["A diferença é o cargo de quem cobra", "O assédio é uma conduta repetida que humilha, isola ou expõe a pessoa; a cobrança legítima trata do serviço, sem atacar o trabalhador", "Não há diferença: toda cobrança é assédio", "A diferença é apenas o tom de voz usado"]', 1, 128),

    ('Um trabalhador presenciou o assédio sofrido por um colega. O que ele pode fazer?',
     '["Comentar com os demais colegas do setor para criar pressão", "Aguardar que a vítima procure a empresa sozinha", "Registrar o que viu pelo canal previsto e apoiar o colega, porque a testemunha também é protegida contra retaliação", "Nada, porque o assunto é entre as duas pessoas envolvidas"]', 2, 129),

    ('Concluída a apuração de um caso de assédio, o que se espera da empresa?',
     '["Transferir de setor quem denunciou, para evitar novo conflito", "Dar retorno a quem denunciou, adotar as medidas cabíveis e garantir que não haja retaliação contra ninguém", "Encerrar o caso sem informar as partes", "Divulgar o resultado para todo o estabelecimento"]', 1, 130),

    ('No mapa de riscos, o que indica o tamanho do círculo desenhado?',
     '["A intensidade do risco naquele ponto, conforme a avaliação feita", "O número de trabalhadores do setor", "A distância entre os postos de trabalho", "O tempo de exposição em horas"]', 0, 131),

    ('Onde o mapa de riscos deve ficar?',
     '["Arquivado na sala da CIPA", "Guardado com o SESMT para consulta", "Anexado ao contrato de cada trabalhador", "Afixado no próprio setor, em local visível, para que quem trabalha e quem entra ali enxerguem os riscos"]', 3, 132),

    ('Quais são os grupos de risco usados na elaboração do mapa?',
     '["Físicos, químicos, biológicos, ergonômicos e de acidente", "Leves, moderados e graves", "Internos e externos", "Previsíveis e imprevisíveis"]', 0, 133),

    ('Um trabalhador da limpeza de banheiros e coleta de resíduos está exposto principalmente a qual grupo de risco?',
     '["Físico, pelo esforço da tarefa", "Químico, pelo uso de vassoura e pano", "Ergonômico apenas, pela repetição de movimentos", "Biológico, pelo contato com material contaminado"]', 3, 134),

    ('Piso escorregadio, máquina sem proteção e material empilhado de forma instável são exemplos de:',
     '["Risco ergonômico", "Risco de acidente", "Risco físico", "Risco químico"]', 1, 135),

    ('Por que a proteção coletiva vem antes do EPI?',
     '["Porque o EPI não tem eficácia comprovada", "Porque a norma proíbe o uso de EPI quando há proteção coletiva", "Porque ela protege todos que estão na área, sem depender do uso correto por cada um", "Porque é mais barata em qualquer situação"]', 2, 136),

    ('Qual é a ordem correta na hierarquia das medidas de controle?',
     '["Adotar medidas administrativas antes de qualquer avaliação", "Eliminar o risco, reduzir na fonte, adotar proteção coletiva, medidas administrativas e, por fim, o EPI", "Fornecer o EPI, treinar e depois avaliar a eliminação", "Sinalizar, treinar e depois adotar proteção coletiva"]', 1, 137),

    ('O que significa eliminar o risco na fonte?',
     '["Isolar o trabalhador do local de risco", "Reduzir o tempo de exposição do trabalhador", "Fornecer EPI de melhor qualidade", "Atuar sobre o que gera o risco, trocando o processo, o produto ou o equipamento, e não apenas proteger quem se expõe"]', 3, 138),

    ('Colocar uma placa de advertência no lugar de corrigir o problema é:',
     '["Suficiente, se todos forem treinados sobre a placa", "Suficiente enquanto não houver acidente", "Insuficiente: a sinalização avisa, mas não elimina nem reduz o risco", "Suficiente, se a placa for bem visível"]', 2, 139),

    ('O que a CIPA verifica sobre os primeiros socorros no estabelecimento?',
     '["Se há material adequado aos riscos, guardado em local apropriado, e pessoas treinadas para usá-lo", "Apenas se existe uma caixa de primeiros socorros", "Apenas se há convênio médico para os trabalhadores", "Apenas o telefone do serviço de emergência afixado"]', 0, 140),

    ('Durante a inspeção, a CIPA encontra a rota de fuga bloqueada por caixas. A conduta é:',
     '["Registrar para tratar na reunião do mês", "Orientar o setor a usar outra saída", "Fotografar e aguardar a manutenção", "Providenciar a liberação imediata e registrar, porque em emergência não há tempo de remover obstáculo"]', 3, 141),

    ('Por que a organização e a limpeza do setor interessam à prevenção?',
     '["Porque reduzem o custo de material do setor", "Porque facilitam o trabalho da equipe de limpeza", "Porque desordem gera queda, choque, incêndio e dificulta a saída em emergência, além de esconder outros riscos", "Porque melhoram a imagem da empresa perante o cliente"]', 2, 142),

    ('As condições de higiene, o fornecimento de água potável e as áreas de vivência:',
     '["Também são acompanhadas pela CIPA, porque fazem parte das condições de trabalho", "Não são assunto da CIPA, que trata apenas de acidentes", "São assunto exclusivo do setor administrativo", "Só interessam quando há reclamação formal"]', 0, 143),

    ('Trabalhadores reclamam que os banheiros e vestiários estão sem condições de uso. A CIPA deve:',
     '["Aguardar a próxima inspeção da fiscalização", "Verificar no local, registrar e cobrar a regularização, acompanhando o prazo", "Encaminhar cada reclamação individualmente ao RH", "Considerar assunto de menor importância"]', 1, 144),

    ('Qual é a participação da CIPA nas campanhas de saúde da empresa?',
     '["Definir o calendário de exames de cada trabalhador", "Nenhuma, porque saúde não é assunto da CIPA", "Propor, divulgar e apoiar campanhas de prevenção, inclusive de doenças e de saúde mental, conforme as atribuições da comissão", "Executar os atendimentos de saúde"]', 2, 145),

    ('Um trabalhador se acidentou e pede para não comunicar, com medo de perder o emprego. O correto é:',
     '["Explicar que a comunicação protege os direitos dele e permite corrigir o risco, e providenciar o registro conforme a norma", "Atender ao pedido e não registrar", "Registrar apenas como incidente sem vítima", "Comunicar somente se houver afastamento"]', 0, 146),

    ('Uma empresa contratada trabalha no estabelecimento sem informar seus riscos. A CIPA deve:',
     '["Registrar em ata sem outra providência", "Cobrar a troca de informações e a integração das medidas, porque o risco de um alcança o outro", "Ignorar, porque a responsabilidade é da contratada", "Impedir a entrada dos trabalhadores da contratada"]', 1, 147),

    ('Ao final do ano, o que a CIPA avalia sobre o próprio trabalho?',
     '["Apenas o número de reuniões realizadas", "Apenas o desempenho individual de cada membro", "Nada, porque a avaliação cabe à empresa", "O que foi planejado e realizado, o que não avançou e por quê, para orientar o plano do período seguinte"]', 3, 148),

    ('O que a CIPA que termina o mandato entrega à seguinte?',
     '["As atas, o plano de trabalho, as pendências em aberto e o histórico das ações, para que nada recomece do zero", "Apenas a chave da sala da comissão", "Apenas o calendário do ano anterior", "Nada, porque cada mandato é independente"]', 0, 149),

    ('Terminado o mandato, o ex-cipeiro:',
     '["Passa a responder pela CIPA seguinte", "Continua contribuindo com a prevenção no seu setor, comunicando riscos e apoiando a nova comissão", "Deixa de ter qualquer responsabilidade com segurança", "Fica impedido de tratar de segurança até nova eleição"]', 1, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-05';


-- =====================================================================
--  NR-10-SEP — Complementar para Sistema Elétrico de Potência (41 a 150)
--  Curso de 40 horas, para quem já passou pelo básico da NR-10. Nada de
--  conceito de choque e de zona: aqui é manobra, aterramento, ensaio de
--  EPI, indução, geração do cliente e resgate no poste.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-10-SEP')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Um trabalhador no solo encostou a mão na carcaça de um equipamento com defeito de isolamento e levou choque. O que explica isso?',
     '["O equipamento acumulou carga estática durante a operação", "A carcaça estava aquecida e provocou a sensação de choque", "O trabalhador estava usando calçado condutivo demais", "Surgiu diferença de potencial entre a mão que tocou e os pés apoiados, e a corrente atravessou o corpo por esse caminho"]', 3, 41),

    ('Para que serve equipotencializar o local de trabalho na rede?',
     '["Substituir o uso das luvas isolantes", "Fazer com que tudo o que o trabalhador possa tocar fique no mesmo potencial, reduzindo a diferença que provoca o choque", "Reduzir a corrente de curto-circuito da rede", "Melhorar a qualidade da energia entregue ao cliente"]', 1, 42),

    ('Por que o caminhão com cesto aéreo é aterrado no local do serviço?',
     '["Para escoar corrente em caso de contato acidental e reduzir a diferença de potencial entre o veículo e o solo", "Para descarregar a bateria do caminhão", "Para evitar o acúmulo de poeira no equipamento", "Para permitir o funcionamento do sistema hidráulico"]', 0, 43),

    ('O que se verifica no conjunto de aterramento temporário antes do uso?',
     '["Apenas a cor do isolamento do cabo", "Apenas se o conjunto está limpo", "A integridade dos condutores, o estado dos grampos e conectores, a bitola compatível e a ausência de emendas improvisadas", "Apenas o comprimento dos cabos"]', 2, 44),

    ('O grampo do aterramento foi apenas encostado no condutor, sem apertar. Qual o problema?',
     '["Apenas a dificuldade de retirar o conjunto depois", "Sem contato firme, o aterramento não conduz a corrente de um curto e o trabalhador continua exposto", "Nenhum, porque o contato metálico já é suficiente", "Apenas a possibilidade de o grampo cair"]', 1, 45),

    ('Antes e depois de verificar a ausência de tensão no ponto de trabalho, o detector deve:',
     '["Ser testado em uma fonte de tensão conhecida, para comprovar que o aparelho está funcionando", "Ser calibrado no próprio ponto de trabalho", "Ser desligado para poupar bateria", "Ser trocado por outro modelo de maior alcance"]', 0, 46),

    ('Como se verifica a ausência de tensão em um circuito trifásico?',
     '["Testando apenas o neutro do circuito", "Confiando na indicação do centro de operação", "Testando todas as fases, em todos os condutores do ponto de trabalho, e não apenas uma delas", "Testando apenas a fase mais próxima"]', 2, 47),

    ('Sobre o bastão de manobra usado na rede:',
     '["Pode ser usado molhado, porque o material é isolante", "Serve também para apoiar ferramentas durante o serviço", "Dispensa inspeção quando é novo", "É inspecionado e mantido limpo e seco, sem trincas nem riscos, e passa por ensaio elétrico periódico"]', 3, 48),

    ('Por que os equipamentos de proteção isolantes passam por ensaio elétrico periódico?',
     '["Porque o material perde a capacidade isolante com o uso, o tempo e a exposição, sem que isso apareça a olho nu", "Porque o ensaio limpa o material e prolonga a vida útil", "Porque o ensaio é exigido apenas para equipamentos importados", "Porque só assim o fabricante mantém a garantia"]', 0, 49),

    ('Como se escolhe a classe da luva isolante para um serviço?',
     '["Pela luva mais confortável para a atividade", "Pelo tamanho da mão do trabalhador apenas", "Pela tensão do circuito em que se vai trabalhar, respeitando a classe indicada para aquela faixa", "Pela luva que estiver disponível no veículo"]', 2, 50),

    ('Para que serve a luva de cobertura de couro usada sobre a luva isolante?',
     '["Aumentar a classe de isolamento do conjunto", "Melhorar a aderência para segurar ferramentas", "Proteger o trabalhador do frio no serviço noturno", "Proteger a borracha contra corte, perfuração e abrasão, que são as causas mais comuns de perda do isolamento"]', 3, 51),

    ('Como as luvas isolantes devem ser guardadas?',
     '["Dentro do bolso do uniforme, para estarem à mão", "Em estojo próprio, sem dobras, longe de calor, óleo, sol e objetos cortantes", "Enroladas dentro da caixa de ferramentas", "Penduradas no cesto do caminhão"]', 1, 52),

    ('Quando a manga isolante é necessária?',
     '["Somente em rede de baixa tensão", "Somente quando o trabalhador não usa cesto aéreo", "Quando o braço pode aproximar-se de partes energizadas, porque a luva protege apenas a mão e o punho", "Somente em serviço noturno"]', 2, 53),

    ('Para que serve o tapete isolante na frente do painel da subestação?',
     '["Evitar que ele escorregue no piso", "Proteger o piso contra o desgaste da manobra", "Amortecer o ruído do disjuntor ao operar", "Isolar o trabalhador do solo durante a manobra, reduzindo o caminho da corrente pelo corpo"]', 3, 54),

    ('Quando o protetor facial contra arco elétrico é exigido?',
     '["Somente durante a manutenção de transformadores", "Nas atividades em que a análise de risco indica possibilidade de arco, junto com a vestimenta adequada", "Somente em serviço em alta tensão em subestação", "Somente quando não há luva isolante disponível"]', 1, 55),

    ('O que significa o valor de proteção térmica indicado na vestimenta contra arco?',
     '["A energia térmica que a roupa suporta antes de deixar passar calor suficiente para causar queimadura grave", "A temperatura máxima do ambiente em que ela pode ser usada", "O número de lavagens que ela suporta", "A tensão máxima do circuito em que ela pode ser usada"]', 0, 56),

    ('Por que não se usa camiseta de material sintético por baixo do uniforme antichama?',
     '["Porque ele absorve mais suor e desconforta", "Porque ele conduz eletricidade estática", "Porque ele reduz a durabilidade do uniforme", "Porque o sintético derrete com o calor do arco e gruda na pele, agravando muito a queimadura"]', 3, 57),

    ('Sobre a higienização da vestimenta antichama:',
     '["Segue a orientação do fabricante, porque produto e processo errados retiram a proteção do tecido", "Pode ser lavada com qualquer produto, desde que sem amaciante", "Não pode ser lavada, apenas escovada", "Pode ser lavada junto com roupas comuns, sem restrição"]', 0, 58),

    ('Para que serve a análise do risco de arco elétrico antes da atividade?',
     '["Determinar a bitola do condutor a ser instalado", "Estimar a energia envolvida e definir a distância segura e a vestimenta adequada para aquele ponto", "Calcular o tempo de duração do serviço", "Definir o número de trabalhadores da equipe"]', 1, 59),

    ('Como o local de trabalho na subestação é delimitado?',
     '["Apenas com a marcação no piso já existente", "Não é delimitado, porque o acesso já é restrito", "Com barreiras, cordas e sinalização que definem por onde se circula e o que permanece energizado", "Apenas com a orientação verbal do supervisor"]', 2, 60),

    ('Para que serve a sinalização colocada no dispositivo bloqueado?',
     '["Substituir o cadeado quando ele não está disponível", "Informar quem bloqueou, por que e desde quando, evitando que alguém religue por engano", "Registrar a data da última manutenção", "Indicar o número do circuito para o centro de operação"]', 1, 61),

    ('Quem pode retirar o bloqueio de um dispositivo?',
     '["O operador do centro de operação, a qualquer momento", "O supervisor do turno seguinte, sem formalidade", "Quem o instalou, ou quem for formalmente designado pelo procedimento em caso de impedimento", "Qualquer trabalhador da equipe"]', 2, 62),

    ('Por que a chave ou o dispositivo de bloqueio fica em poder da equipe que trabalha no ponto?',
     '["Porque quem está exposto é quem precisa ter certeza de que ninguém vai reenergizar o circuito", "Porque a chave é patrimônio da equipe", "Porque assim se evita perder a chave no almoxarifado", "Porque o procedimento não define outro responsável"]', 0, 63),

    ('Como se garante que a instalação não será reenergizada durante o serviço?',
     '["Com o aviso verbal ao operador do centro", "Com a presença de um trabalhador ao lado da chave", "Com o desligamento do disjuntor, apenas", "Com o impedimento de reenergização: bloqueio físico, sinalização, retirada do comando e comunicação formal ao centro de operação"]', 3, 64),

    ('Qual é a sequência correta para deixar uma instalação em condição desenergizada?',
     '["Seccionar, impedir a reenergização, verificar a ausência de tensão, aterrar e equipotencializar, proteger os elementos energizados próximos e sinalizar", "Verificar a ausência de tensão, seccionar, aterrar e sinalizar", "Aterrar, seccionar, sinalizar e verificar a ausência de tensão", "Seccionar, aterrar, verificar a ausência de tensão e liberar o serviço"]', 0, 65),

    ('E para reenergizar a instalação, a sequência é:',
     '["Religar primeiro e depois retirar os aterramentos", "Retirar o aterramento, religar e depois recolher o material", "Comunicar o centro e religar, recolhendo o material depois", "Retirar ferramentas e materiais, retirar a sinalização e as proteções, remover o aterramento, remover o impedimento e destravar, e só então religar"]', 3, 66),

    ('Dizer que a instalação está desligada é o mesmo que dizer que ela está desenergizada?',
     '["A desenergizada é a que está sem carga, com tensão presente", "A desligada é a que teve o aterramento instalado", "A desligada apenas teve o circuito aberto; a desenergizada passou por todas as etapas, incluindo verificação e aterramento, e só nela se trabalha como tal", "Não há diferença: os termos são equivalentes"]', 2, 67),

    ('Por que o aterramento temporário é instalado dos dois lados do ponto de trabalho?',
     '["Porque assim se equilibram as fases da rede", "Porque a energia pode voltar por qualquer um dos lados, inclusive por outra fonte ou por indução", "Porque a norma exige dois conjuntos por equipe", "Porque um conjunto pode falhar por defeito"]', 1, 68),

    ('O que formaliza que o serviço pode começar no ponto desenergizado?',
     '["A chegada do veículo ao local", "A abertura da chave pelo centro de operação", "A liberação por quem tem essa atribuição, registrada conforme o procedimento, após a conferência das etapas", "A confirmação verbal do eletricista mais experiente da equipe"]', 2, 69),

    ('Para que servem a ordem de serviço e a autorização de trabalho no SEP?',
     '["Autorizar o pagamento de horas extras da equipe", "Definir o que será feito, onde, por quem, com quais condições e limites, e registrar a liberação", "Controlar o horário de trabalho da equipe", "Substituir a análise de risco no local"]', 1, 70),

    ('Qual é a atribuição de quem supervisiona a equipe no serviço?',
     '["Apenas registrar o horário de início e fim", "Apenas transmitir as ordens do centro de operação", "Apenas conferir a papelada ao final do serviço", "Garantir que o procedimento seja cumprido, acompanhar a execução e interromper o serviço quando a condição muda"]', 3, 71),

    ('Antes de autorizar a energização, o responsável precisa confirmar:',
     '["Que todos foram retirados do ponto, que os aterramentos foram removidos e que ferramentas e materiais foram recolhidos", "Apenas que o serviço foi concluído", "Apenas que o centro de operação está disponível", "Apenas que o horário previsto se encerrou"]', 0, 72),

    ('Por que se prefere o seccionamento com abertura visível dos contatos?',
     '["Porque a abertura visível interrompe a corrente mais rápido", "Porque reduz o desgaste dos contatos do equipamento", "Porque dispensa a verificação de ausência de tensão", "Porque permite enxergar a separação física do circuito, sem depender apenas da indicação de um comando que pode falhar"]', 3, 73),

    ('Por que a nomenclatura dos equipamentos precisa ser padronizada?',
     '["Porque reduz o tempo das manobras programadas", "Porque manobrar o equipamento errado por confusão de nome coloca gente energizada no meio do serviço", "Porque facilita o inventário do patrimônio", "Porque o sistema informatizado exige nomes iguais"]', 1, 74),

    ('Ao trabalhar em um cubículo com disjuntor extraível, o cuidado essencial é:',
     '["Extrair o disjuntor e garantir o bloqueio e a sinalização, confirmando a separação física dos contatos", "Apenas abrir o disjuntor pelo comando", "Apenas desligar o comando de proteção", "Apenas comunicar o centro de operação"]', 0, 75),

    ('Abrir uma chave seccionadora com carga é:',
     '["Permitido, com bastão de manobra", "Permitido, se a manobra for rápida", "Manobra inadequada: a seccionadora não é feita para interromper corrente, e o arco resultante pode ferir gravemente o operador", "Permitido, se a corrente for baixa"]', 2, 76),

    ('Por que o secundário de um transformador de corrente nunca pode ficar aberto com o primário energizado?',
     '["Porque a proteção deixa de atuar apenas", "Porque surgem tensões muito elevadas nos terminais abertos, com risco de choque e de danos ao equipamento", "Porque a medição fica imprecisa", "Porque o transformador para de funcionar"]', 1, 77),

    ('Qual cuidado o circuito de medição de tensão exige durante a manutenção?',
     '["Tratar o secundário como energizado e seguir o procedimento, porque ele reproduz a tensão do circuito principal em escala", "Nenhum, porque a tensão do secundário é baixa", "Apenas desconectar o medidor do painel", "Apenas identificar os cabos com etiqueta"]', 0, 78),

    ('Por que o sistema de proteção precisa ser considerado no planejamento do serviço?',
     '["Porque o relé precisa ser desligado em qualquer serviço", "Porque a proteção substitui o aterramento temporário", "Porque a atuação ou a inibição de uma proteção muda o comportamento do circuito e o risco a que a equipe se expõe", "Porque a proteção define o horário do serviço"]', 2, 79),

    ('Qual é a função do para-raios instalado na rede?',
     '["Impedir que o raio caia na região", "Interromper o circuito em caso de curto", "Medir a tensão da rede em tempo real", "Escoar para a terra as sobretensões, protegendo os equipamentos, sem tornar a rede segura para toque"]', 3, 80),

    ('Sobre o elo fusível da chave da rede de distribuição:',
     '["É dimensionado para o circuito e não pode ser substituído por outro de valor diferente ou por improviso metálico", "Qualquer elo serve, desde que caiba na chave", "Pode ser substituído por fio de cobre em emergência", "Não precisa de dimensionamento em rede de baixa tensão"]', 0, 81),

    ('A manobra de uma chave fusível com carga elevada pede o quê?',
     '["Apenas abrir e fechar duas vezes seguidas", "Apenas aguardar o horário de menor consumo", "Seguir o procedimento previsto, com o equipamento adequado para interrupção sob carga e a proteção definida", "Apenas usar o bastão de manobra e agir rápido"]', 2, 82),

    ('Antes de subir em um poste, além da inspeção do próprio poste, o trabalhador verifica:',
     '["Apenas a altura do poste", "Apenas a existência de placa de identificação", "Apenas a distância da rede secundária", "As condições do solo e da base, a existência de escavação por perto, a carga dos cabos e a presença de terceiros ou animais"]', 3, 83),

    ('Qual é a diferença entre o cinturão de posicionamento e o cinturão paraquedista?',
     '["O de posicionamento retém a queda com maior conforto", "O de posicionamento mantém o trabalhador apoiado para trabalhar; o paraquedista é o que retém a queda, e o serviço exige a proteção adequada ao risco", "Não há diferença prática entre os dois", "O paraquedista é usado apenas em subestação"]', 1, 84),

    ('Durante o deslocamento no poste, a proteção contra queda:',
     '["É dispensada quando o trabalhador usa esporas", "É necessária apenas acima de cinco metros", "Precisa ser mantida o tempo todo, com sistema que permita a mudança de ponto sem ficar desconectado", "Pode ser desconectada por instantes na passagem de obstáculo"]', 2, 85),

    ('Como as ferramentas sobem e descem do poste?',
     '["Nos bolsos do uniforme, para agilizar", "Jogadas pelo colega quando solicitado", "Presas ao cinturão, sem bolsa", "Por corda de serviço, em bolsa apropriada, nunca jogadas nem carregadas na mão durante a subida"]', 3, 86),

    ('Por que a área embaixo do ponto de trabalho no poste é isolada?',
     '["Porque a rede pode cair sobre a via", "Porque qualquer objeto que caia dessa altura pode matar quem estiver embaixo, inclusive pedestres", "Para evitar o acúmulo de curiosos no local", "Para facilitar o estacionamento do veículo da equipe"]', 1, 87),

    ('A sinalização de trânsito no local do serviço serve para:',
     '["Alertar e desviar veículos e pedestres com antecedência, protegendo a equipe e quem passa", "Reservar a vaga para o veículo da empresa", "Indicar o horário de duração do serviço", "Atender apenas exigência da prefeitura"]', 0, 88),

    ('Em serviço junto a uma rodovia de tráfego rápido, o que muda?',
     '["Nada muda em relação a uma rua comum", "Basta o giroflex do veículo ligado", "O serviço só pode ser feito à noite", "A sinalização precisa começar bem antes do ponto, com maior distância e recursos compatíveis com a velocidade da via"]', 3, 89),

    ('Antes de acionar o cesto aéreo, quanto às patolas do caminhão:',
     '["Devem ser estendidas em solo firme e nivelado, com calços quando necessário, e a estabilidade conferida", "Podem ficar recolhidas se o serviço for rápido", "Só são necessárias em terreno inclinado", "Devem ser estendidas apenas de um lado, para não invadir a via"]', 0, 90),

    ('O vento aumentou durante o trabalho no cesto aéreo. O correto é:',
     '["Continuar segurando-se firme na borda do cesto", "Interromper e descer quando o vento ultrapassa o limite do equipamento, porque o cesto e o material perdem estabilidade", "Continuar com o cesto mais baixo", "Continuar, porque o cesto é preso ao caminhão"]', 1, 91),

    ('Sobre a carga máxima do cesto aéreo:',
     '["Pode ser ultrapassada em pequena margem", "Vale apenas quando o braço está totalmente estendido", "Considera o peso das pessoas, das ferramentas e do material, e não pode ser ultrapassada", "Considera apenas o peso das pessoas"]', 2, 92),

    ('Qual é a razão de o cesto aéreo ser ensaiado de tempos em tempos, e não só inspecionado a olho?',
     '["Porque o ensaio define o valor do seguro", "Porque ele é isolante e estrutural ao mesmo tempo, e a perda dessas características não aparece na inspeção visual diária", "Porque a inspeção substitui a manutenção preventiva", "Porque o fabricante exige para manter o contrato"]', 1, 93),

    ('Uma máquina de construção vai operar próxima a uma rede energizada. O correto é:',
     '["Operar somente com a lança abaixada", "Colocar um trabalhador orientando o operador", "Manter a distância mínima de segurança e, quando não for possível, providenciar o desligamento, o isolamento ou o remanejamento da rede", "Operar com o motorista atento à rede"]', 2, 94),

    ('Antes de uma escavação em via pública, o que se verifica em relação à rede subterrânea?',
     '["O cadastro e a localização das redes existentes no trecho, com sondagem e sinalização antes de escavar", "Apenas a profundidade prevista para a vala", "Apenas a autorização da prefeitura", "Apenas o tipo de solo do trecho"]', 0, 95),

    ('A entrada em uma câmara subterrânea de rede elétrica exige:',
     '["Apenas os cuidados elétricos habituais", "Apenas a abertura da tampa por alguns minutos", "Apenas o uso de lanterna e luvas isolantes", "Tratamento como espaço confinado, com permissão, medição da atmosfera, ventilação, vigia e plano de resgate, além dos cuidados elétricos"]', 3, 96),

    ('Por que pode haver atmosfera perigosa dentro de uma caixa subterrânea?',
     '["Porque gases podem se acumular por infiltração, decomposição ou vazamento, e o oxigênio pode estar reduzido", "Porque o cabo elétrico consome o oxigênio do local", "Porque a umidade impede a respiração", "Porque a tampa metálica bloqueia o ar sempre"]', 0, 97),

    ('Um cabo isolado da rede apresenta dano na capa. Como deve ser tratado?',
     '["Como cabo seguro, porque o condutor continua interno", "Com uma volta de fita isolante para seguir o serviço", "Com a redução da carga do circuito", "Como condutor exposto: o isolamento danificado não protege, e o trecho precisa ser isolado e reparado"]', 3, 98),

    ('Para que serve a inspeção termográfica em conexões e equipamentos?',
     '["Substituir o ensaio de isolamento dos equipamentos", "Verificar a corrente de curto-circuito do circuito", "Identificar aquecimento anormal por mau contato ou sobrecarga antes que a falha aconteça, sem desligar a instalação", "Medir a tensão dos condutores à distância"]', 2, 99),

    ('Antes de energizar uma rede recém-construída, o que precisa acontecer?',
     '["Apenas a retirada dos veículos da equipe", "Verificação e ensaios de comissionamento, conferência da montagem e confirmação de que ninguém permanece na instalação", "Apenas a comunicação ao centro de operação", "Apenas a inspeção visual do trecho"]', 1, 100),

    ('Uma linha desenergizada corre paralela a outra energizada. Qual o risco?',
     '["Apenas interferência na comunicação da equipe", "Apenas aquecimento dos condutores", "Tensão induzida na linha desligada, capaz de provocar choque mesmo sem alimentação própria", "Nenhum, porque ela está desligada"]', 2, 101),

    ('Como se protege a equipe da tensão induzida em uma linha desenergizada?',
     '["Com o afastamento da linha energizada vizinha", "Com aterramento adequado nos pontos previstos, mantido durante todo o serviço, e equipotencialização do local de trabalho", "Com o uso apenas de luvas isolantes", "Com a redução do tempo de exposição"]', 1, 102),

    ('O cabo de topo da linha tem fibra óptica embutida. O que a equipe precisa considerar?',
     '["Que ele é isolado por causa da fibra e pode ser manuseado livremente", "Que ele só transporta dados e não oferece risco elétrico", "Que ele dispensa aterramento por não conduzir corrente", "Que ele continua sendo elemento da instalação, sujeito a indução e a potencial elevado, e não pode ser tratado como cabo de telecomunicação comum"]', 3, 103),

    ('Em uma travessia de linha sobre rodovia ou rio, o cuidado adicional é:',
     '["Planejar o lançamento com sinalização, bloqueio ou acompanhamento do tráfego e limites que impeçam a queda do cabo sobre a passagem", "Executar mais rápido, para reduzir a exposição", "Executar apenas com dois trabalhadores", "Executar sem aterramento, por ser trecho isolado"]', 0, 104),

    ('Um consumidor tem gerador próprio ligado à instalação. Qual o risco para a equipe?',
     '["Apenas o ruído do gerador durante o serviço", "Apenas a variação de tensão no medidor", "Nenhum, porque o gerador é independente da rede", "O gerador pode alimentar a rede pelo lado do cliente e energizar o trecho que a equipe considera desligado"]', 3, 105),

    ('Um cliente tem geração solar conectada à rede. O que a equipe precisa considerar?',
     '["Que o inversor impede qualquer risco para a equipe", "Que o sistema pode continuar produzindo e injetar energia no trecho, exigindo desconexão comprovada e aterramento antes do serviço", "Que a geração solar cessa automaticamente ao anoitecer, o que basta", "Que o sistema é isolado da rede por natureza"]', 1, 106),

    ('Antes de trabalhar no ramal de um cliente com geração própria, o correto é:',
     '["Garantir a desconexão da geração, comprovar a ausência de tensão e aterrar, sem confiar apenas no desligamento do disjuntor da rede", "Desligar apenas o disjuntor geral da entrada", "Comunicar o cliente e iniciar o serviço", "Trabalhar apenas durante a noite"]', 0, 107),

    ('Uma linha longa foi desligada e desconectada. Por que ainda pode haver tensão nela?',
     '["Porque o condutor guarda calor do serviço anterior", "Porque o para-raios devolve energia à linha", "Por carga capacitiva residual e por indução, o que exige aterramento antes de qualquer contato", "Porque o disjuntor demora para abrir por completo"]', 2, 108),

    ('Qual é o motivo de se aterrar a linha logo depois de comprovar a ausência de tensão?',
     '["Porque o aterramento melhora a qualidade da energia", "Porque o aterramento escoa a carga residual e garante caminho para a corrente caso a linha seja reenergizada por engano", "Porque o aterramento indica ao centro que o serviço começou", "Porque assim se evita a corrosão dos condutores"]', 1, 109),

    ('O que caracteriza o método de trabalho ao contato em linha energizada?',
     '["O trabalhador atua diretamente sobre o condutor energizado protegido por luvas e coberturas isolantes, mantendo-se no potencial de terra", "O trabalhador fica no mesmo potencial do condutor, isolado do solo", "O trabalhador atua apenas com bastões, a distância do condutor", "O trabalhador atua com a linha desligada e aterrada"]', 0, 110),

    ('O que precisa estar disponível na equipe para o resgate em altura na rede?',
     '["Apenas o telefone do corpo de bombeiros", "Apenas o cinturão reserva da equipe", "Equipamento de descida controlada, cordas e acessórios adequados, com equipe treinada para usá-los", "Apenas a escada do veículo"]', 2, 111),

    ('Sobre o treinamento de resgate da equipe do SEP:',
     '["Basta a explicação teórica no curso inicial", "É necessário apenas para o supervisor da equipe", "É dispensado quando há socorro externo próximo", "É praticado periodicamente em simulado, porque a manobra precisa sair certa na primeira tentativa e sob pressão"]', 3, 112),

    ('Após a descida da vítima de choque que não responde e não respira, a equipe deve:',
     '["Iniciar imediatamente a reanimação e usar o desfibrilador assim que disponível, mantendo o socorro acionado", "Aguardar o socorro externo antes de qualquer manobra", "Aplicar compressa fria nas queimaduras primeiro", "Transportar a vítima no veículo da equipe sem manobras"]', 0, 113),

    ('Por que o desfibrilador é importante no atendimento ao acidente elétrico?',
     '["Porque ele substitui as compressões torácicas", "Porque ele elimina a queimadura interna", "Porque a corrente pode provocar arritmia grave, e o choque do aparelho é o que pode reverter esse quadro", "Porque ele mede a intensidade do choque recebido"]', 2, 114),

    ('Uma vítima de arco elétrico apresenta queimaduras. A conduta é:',
     '["Passar pomada e liberar a vítima", "Resfriar com gelo diretamente sobre as lesões", "Retirar as roupas aderidas à pele queimada", "Avaliar respiração e circulação primeiro, cobrir as lesões com material limpo, sem furar bolhas nem passar produto, e acionar socorro"]', 3, 115),

    ('Ao acionar o socorro em um acidente elétrico, é importante informar:',
     '["Apenas o horário do acidente", "Que houve contato com energia elétrica, a tensão envolvida e se a vítima está em local elevado ou confinado", "Apenas o endereço do local", "Apenas o nome da vítima e o setor"]', 1, 116),

    ('Depois de um acidente com a rede, o local deve:',
     '["Ser limpo pela equipe antes da chegada da chefia", "Ser desmontado para retirada do material danificado", "Ser preservado sempre que possível para a análise, com registro das condições, evitando alterar o que não for necessário ao socorro", "Ser liberado imediatamente para restabelecer a energia"]', 2, 117),

    ('Passado o atendimento, por que o acidente elétrico ainda precisa ser analisado?',
     '["Definir a punição do trabalhador envolvido", "Justificar o tempo de interrupção do fornecimento", "Cumprir formalidade junto ao setor de pessoal", "Descobrir o que falhou no procedimento, no equipamento ou na organização e corrigir antes que se repita"]', 3, 118),

    ('Por que o diagrama unifilar precisa estar atualizado?',
     '["Porque ele define a bitola dos condutores", "Porque a manobra é planejada a partir dele, e um diagrama desatualizado leva a equipe a manobrar o circuito errado", "Porque ele é exigido pelo cliente da instalação", "Porque ele substitui a inspeção no local"]', 1, 119),

    ('O que mais deve constar na documentação técnica da instalação, além dos diagramas?',
     '["Os procedimentos de trabalho, as especificações dos equipamentos, os registros de inspeção e os certificados aplicáveis", "Apenas a relação de trabalhadores autorizados", "Apenas as notas fiscais dos equipamentos", "Apenas o contrato de manutenção"]', 0, 120),

    ('Como se comprova que um trabalhador está autorizado a intervir no SEP?',
     '["Pelo tempo de serviço na função", "Pela indicação do encarregado no dia do serviço", "Pela posse do crachá da empresa", "Pelo registro formal da empresa, com a capacitação exigida, o acompanhamento previsto e a aptidão em dia"]', 3, 121),

    ('Um trabalhador em processo de capacitação vai a campo. Como ele atua?',
     '["Sob supervisão e responsabilidade de profissional autorizado, sem executar tarefa por conta própria", "Executando as tarefas mais simples sozinho", "Somente observando, sem qualquer participação", "Como qualquer outro membro da equipe"]', 0, 122),

    ('Um eletricista vem de outra empresa com curso válido. O que a nova empresa precisa fazer?',
     '["Liberar após um período de observação informal", "Verificar a capacitação, complementar o que for necessário para a sua realidade e formalizar a autorização", "Aceitar o certificado e liberar imediatamente para o serviço", "Exigir um novo curso completo em qualquer caso"]', 1, 123),

    ('Um trabalhador passou a usar medicamento que causa sonolência. O que deve acontecer?',
     '["Ele deve apenas reduzir o ritmo do trabalho", "Ele deve trabalhar somente no turno da manhã", "Comunicar e ser avaliado, porque a condição afeta a aptidão para trabalho em altura e com energia", "Nada, porque é assunto particular"]', 2, 124),

    ('Um trabalhador chega ao serviço com sinais de ter consumido álcool. A conduta é:',
     '["Registrar e permitir o serviço com acompanhamento", "Afastá-lo da atividade e conduzir a situação conforme o procedimento da empresa, porque ele não tem condição de intervir na rede", "Deixá-lo em tarefas de apoio no solo", "Aguardar a melhora e liberar em seguida"]', 1, 125),

    ('Em uma emergência que se prolonga por muitas horas, o que precisa ser gerenciado?',
     '["Apenas a comunicação com a imprensa", "Apenas o horário de encerramento previsto", "A fadiga da equipe, com revezamento, descanso e alimentação, porque cansaço aumenta o erro em manobra", "Apenas o abastecimento dos veículos"]', 2, 126),

    ('Em atendimento emergencial, o que não pode ser dispensado?',
     '["A análise de risco no local, a desenergização quando aplicável, os equipamentos de proteção e a comunicação com o centro de operação", "Apenas a comunicação com o centro pode ser dispensada", "A análise de risco, porque a urgência não permite", "O aterramento, quando o serviço é rápido"]', 0, 127),

    ('Como a equipe avalia a proximidade de uma tempestade com descargas atmosféricas?',
     '["Somente quando começa a chover forte no local", "Somente quando um raio cai a menos de cem metros", "Pela sensação de arrepio na pele do trabalhador", "Pelo tempo entre o relâmpago e o trovão e pelas informações disponíveis, interrompendo antes de a tempestade chegar ao local"]', 3, 128),

    ('Como a chuva e a umidade afetam os equipamentos de proteção isolantes?',
     '["Reduzem a capacidade de isolamento e podem inviabilizar a atividade, exigindo equipamento e condição adequados", "Não afetam, porque a borracha é impermeável", "Melhoram o desempenho, por resfriar o material", "Afetam apenas a durabilidade, não a proteção"]', 0, 129),

    ('O trabalho ao sol forte durante horas exige atenção a:',
     '["Apenas ao uso de boné sob o capacete", "Apenas ao horário de almoço da equipe", "Apenas à cor do uniforme utilizado", "Hidratação, pausas e proteção, porque o calor e a desidratação reduzem a atenção e aumentam o erro em altura"]', 3, 130),

    ('A equipe encontrou um ninho de marimbondos junto à cruzeta onde vai trabalhar. O correto é:',
     '["Aplicar inseticida e iniciar o serviço imediatamente", "Subir usando protetor facial e prosseguir", "Não subir, avaliar e resolver a situação antes, porque uma reação em cima do poste vira queda ou contato acidental", "Subir rápido e trabalhar do outro lado da cruzeta"]', 2, 131),

    ('O poste tem várias ligações clandestinas e cabos de terceiros. Como isso muda o serviço?',
     '["Basta trabalhar do lado oposto do poste", "Aumenta o risco de contato acidental e de sobrecarga na estrutura, exigindo avaliação antes de qualquer intervenção", "Não muda nada, porque não é rede da concessionária", "Basta afastar os cabos com a mão enluvada"]', 1, 132),

    ('Como se avalia se um poste está em condições de receber o trabalhador?',
     '["Pelo tempo de instalação registrado no cadastro", "Empurrando o poste com as mãos e observando", "Verificando a base, a inclinação, trincas, apodrecimento e a estabilidade, com o teste previsto no procedimento antes da subida", "Pela aparência da pintura do poste"]', 2, 133),

    ('Um poste está inclinado e com risco de queda. Antes de qualquer serviço nele, o correto é:',
     '["Amarrar o poste no veículo e subir", "Escorar ou estabilizar a estrutura conforme o procedimento e isolar a área, sem subir enquanto o risco existir", "Subir com cuidado e trabalhar rapidamente", "Aliviar o peso retirando os cabos por cima"]', 1, 134),

    ('Uma cruzeta apresenta rachadura e apodrecimento. O correto é:',
     '["Trabalhar apoiando o peso do outro lado", "Reforçar com arame e continuar", "Trabalhar somente com equipamento leve sobre ela", "Não apoiar carga nem o corpo nela, isolar a situação e providenciar a substituição antes do serviço"]', 3, 135),

    ('Um isolador está quebrado em uma estrutura energizada. Qual o risco?',
     '["O isolamento pode ter sido comprometido, aproximando o potencial da fase da estrutura", "Apenas o desgaste estético da rede", "Apenas a perda de eficiência do circuito", "Nenhum, porque o isolador é apenas mecânico"]', 0, 136),

    ('Antes de conectar ou desconectar um transformador de distribuição, é preciso:',
     '["Apenas abrir as chaves fusíveis do primário", "Apenas desligar a rede secundária do transformador", "Apenas comunicar os clientes atendidos", "Seguir a sequência de manobra prevista, considerando carga, proteção e aterramento, com autorização do centro de operação"]', 3, 137),

    ('Qual cuidado o óleo isolante de transformadores exige?',
     '["Apenas usar luvas de raspa ao manusear", "Evitar o contato e a contaminação do ambiente, e tratar o resíduo conforme o procedimento, considerando a possibilidade de contaminantes", "Nenhum, porque é óleo mineral comum", "Apenas evitar o desperdício do produto"]', 1, 138),

    ('O gás isolante usado em alguns disjuntores exige cuidado porque:',
     '["Seus subprodutos após arco elétrico são tóxicos e o gás pode deslocar o oxigênio em ambiente fechado", "Ele é inflamável em contato com o ar", "Ele corrói as partes metálicas do equipamento", "Ele não apresenta risco algum ao trabalhador"]', 0, 139),

    ('Sobre o acesso a uma subestação:',
     '["É liberado a quem estiver de uniforme", "É controlado apenas fora do horário comercial", "É restrito a pessoas autorizadas, com controle de entrada, e visitantes só entram acompanhados e orientados", "É livre para qualquer empregado da empresa"]', 2, 140),

    ('Qual é a função da malha de terra de uma subestação?',
     '["Impedir a entrada de água no solo da subestação", "Escoar as correntes de falta e controlar as tensões de passo e de toque na área", "Sustentar mecanicamente as estruturas", "Reduzir o consumo de energia da instalação"]', 1, 141),

    ('Por que a malha de terra é medida periodicamente?',
     '["Porque a corrosão e as alterações no solo mudam o valor da resistência, e a proteção depende disso", "Porque a medição é exigida para o seguro da instalação", "Porque assim se calcula o consumo do circuito", "Porque a malha precisa ser trocada a cada medição"]', 0, 142),

    ('Um quadro geral de baixa tensão será aberto para serviço com o circuito energizado. Qual o risco principal?',
     '["Somente o aquecimento dos condutores", "Nenhum, porque baixa tensão não gera arco significativo", "O arco elétrico, que em baixa tensão pode ser tão grave quanto em alta por causa da corrente de curto disponível", "Somente o choque pelo contato direto"]', 2, 143),

    ('Um painel elétrico ficou com a porta aberta e sem sinalização durante o serviço. Isso é:',
     '["Aceitável, se houver um trabalhador por perto", "Aceitável durante o horário de expediente", "Aceitável, se o painel for de baixa tensão", "Inaceitável: qualquer pessoa pode encostar em parte energizada, e a área precisa ser delimitada e sinalizada"]', 3, 144),

    ('Antes de pegar uma ferramenta isolada, o que o trabalhador observa nela?',
     '["Se o isolamento está íntegro, sem trincas, cortes, marcas de queima ou perda de aderência ao corpo da ferramenta", "Apenas se a ferramenta está limpa", "Apenas se o cabo é do mesmo fabricante", "Apenas se a ferramenta é nova"]', 0, 145),

    ('Por que anéis, relógios, correntes e pulseiras não são usados no serviço elétrico?',
     '["Apenas porque atrapalham a colocação das luvas", "Apenas porque não combinam com o uniforme", "Porque conduzem, podem fechar circuito, aquecer e causar queimadura grave, além de prenderem em partes móveis", "Apenas porque podem se perder durante o serviço"]', 2, 146),

    ('Uma equipe usa um procedimento diferente do previsto porque acha mais prático. Isso é:',
     '["Aceitável, se o resultado for o mesmo", "Aceitável, se toda a equipe concordar", "Aceitável, se o supervisor não estiver no local", "Inaceitável: a mudança precisa ser avaliada e formalizada, porque o procedimento é construído a partir dos riscos conhecidos"]', 3, 147),

    ('Uma condição diferente do previsto aparece no meio do serviço. O correto é:',
     '["Continuar apenas com o trabalhador mais experiente", "Interromper, reavaliar o risco com a equipe e só retomar quando a nova condição estiver tratada", "Continuar, porque a análise já foi assinada", "Continuar e registrar a diferença ao final"]', 1, 148),

    ('Ao encerrar o serviço, antes de liberar a instalação, a equipe confere:',
     '["Apenas o horário para comunicar ao centro", "Apenas se o veículo está pronto para sair", "Se todo o material e todas as ferramentas foram recolhidos, se os aterramentos foram removidos e se todos estão fora da área", "Apenas se o serviço ficou visualmente concluído"]', 2, 149),

    ('Depois de restabelecer o fornecimento, o que ainda precisa ser feito?',
     '["Nada, porque o serviço terminou com a energização", "Apenas informar o cliente atendido", "Apenas recolher a sinalização de trânsito", "Confirmar o restabelecimento, registrar o serviço executado, as ocorrências e as pendências, e comunicar formalmente o encerramento"]', 3, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-10-SEP';

-- #####################################################################
-- ##  Banco GRANDE 3 (NR-06, NR-17, NR-26, LOTO, NR-34.5)
-- ##  (de 23-banco-grande-3.sql)
-- #####################################################################

-- =====================================================================
--  Banco grande 3 — os módulos curtos: NR-06, NR-17, NR-26, LOTO e NR-34.5
--  110 questões novas por curso (ordem 41 a 150), 550 no total.
--
--  Rode no SQL Editor. Pode rodar quantas vezes quiser: cada bloco apaga
--  SÓ a faixa 41..150 do seu curso antes de inserir. As 40 primeiras
--  questões, vindas dos arquivos 12, 15, 16, 17 e 18, ficam intactas.
--  Depois deste arquivo cada um dos cinco cursos passa a ter 150
--  questões, e o sorteio da prova para de devolver sempre as mesmas.
--
--  ATENÇÃO: ESTAS PERGUNTAS PRECISAM DA CONFERIDA DO RESPONSÁVEL TÉCNICO
--  ANTES DE VALEREM PARA CERTIFICADO.
--  Foram escritas a partir do conteúdo usual de cada norma e do que se
--  cobra em campo. São coerentes com as normas e com a prática, mas quem
--  responde pela prova é o responsável técnico — prova errada reprova
--  quem sabe e aprova quem não sabe, e é a assinatura dele que está no
--  certificado. Aqui há questões de detalhe técnico (cor de tubulação,
--  classe de filtro, tipo de dispositivo de bloqueio, fumo metálico) que
--  merecem uma segunda leitura antes de valerem nota.
--
--  ESTE É O ARQUIVO DE MAIOR RISCO DE REPETIÇÃO DE TODO O PROJETO.
--  São os módulos de 4 horas: uso de EPI, ergonomia, sinalização e
--  bloqueio. Nenhum deles tem 150 fatos distintos na superfície do
--  conteúdo. Em vez de reescrever a mesma pergunta com outras palavras,
--  o escopo foi aberto para o que é legitimamente cobrável no tema:
--
--    NR-06   — cada família de EPI em detalhe, e não só a obrigação de
--              usar: respiratória por classe de filtro, auditiva por
--              atenuação, ocular, facial, mãos, pés, cabeça, queda e
--              vestimenta. Mais CA, ficha de entrega, higienização,
--              guarda, substituição, responsabilidades e as escolhas
--              erradas que se vê em campo.
--    NR-17   — postura e levantamento, mobiliário, tela e iluminação,
--              ruído e temperatura no conforto, ritmo, pausas, turno,
--              teleatendimento, riscos psicossociais, AET, DORT com
--              nome e sinal, e a adaptação do posto para quem tem
--              deficiência ou restrição.
--    NR-26   — as cores que faltaram, a cor na tubulação, a forma da
--              placa, os nove pictogramas do GHS, o rótulo, a FDS por
--              seção, a sinalização de emergência, a de obra e a
--              delimitação de área. E o limite: o que a cor sozinha
--              nunca resolve.
--    LOTO    — cada tipo de energia com o seu jeito de guardar força,
--              a sequência inteira, os dispositivos um a um, os papéis,
--              o turno, o terceiro, a remoção de bloqueio alheio e a
--              retomada. E trinta equipamentos reais, porque cada
--              máquina esconde a energia em um lugar diferente.
--    NR-34.5 — trabalho a quente onde ele é mais perigoso: dentro de
--              navio. Permissão, vigia de fogo, atmosfera, proteção de
--              terceiros, equipamento, espaço confinado e altura, mais
--              o fumo metálico de cada revestimento.
--
--  NENHUMA QUESTÃO DAQUI REPETE AS 40 QUE JÁ EXISTEM em cada curso.
--  Foi rodada uma conferência automática de similaridade contra as 40
--  antigas antes de o arquivo ser fechado. Duas versões da mesma
--  pergunta com gabaritos diferentes reprovam justamente quem estudou.
--
--  A COLUNA `correta` É O ÍNDICE, COMEÇANDO EM ZERO
--  Se a resposta certa é a primeira alternativa, `correta` é 0. A posição
--  da resposta certa foi espalhada pelos quatro índices sem padrão: aluno
--  que decora sequência de gabarito não aprende segurança nenhuma.
--
--  CADA ARRAY FICA NUMA LINHA SÓ, de propósito: o Postgres recusa JSON
--  com quebra de linha dentro do texto ("Character with value 0x0d must
--  be escaped"). Já derrubou um arquivo deste projeto uma vez e não custa
--  nada evitar de novo. Também não existe apóstrofo em nenhum enunciado
--  nem em nenhuma alternativa, pelo mesmo motivo: apóstrofo fecha o
--  literal e quebra o insert inteiro.
--
--  O CÓDIGO DO CURSO DE TRABALHO A QUENTE TEM PONTO NO MEIO: NR-34.5.
--  Não é erro de digitação e não pode ser trocado por NR-34-5.
--
--  As alternativas erradas são erros que se ouve na obra, no chão de
--  fábrica e no estaleiro. Alternativa absurda não mede nada: o aluno
--  acerta por eliminação sem ter entendido o risco.
-- =====================================================================


-- =====================================================================
--  NR-06 — Uso de EPI (questões 41 a 150)
--  As 40 antigas ficaram no CA, na obrigação de fornecer e usar, na
--  guarda, na ficha de entrega e nas responsabilidades. Estas 110 descem
--  para o equipamento em si, uma família de cada vez: qual respirador
--  para qual contaminante, quanta atenuação o ouvido precisa, por que a
--  luva certa também tem prazo de contato, o que a biqueira de aço faz
--  em serviço elétrico e o que acontece com o capacete guardado no
--  painel do carro. Termina nas escolhas erradas que se vê em campo, que
--  é onde o trabalhador se machuca usando EPI.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-06')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Qual é a diferença entre os respiradores descartáveis PFF1, PFF2 e PFF3?',
     '["Muda a eficiência de filtragem de partículas, que cresce do PFF1 para o PFF3, e a escolha depende do contaminante e da concentração", "Muda apenas a quantidade de elásticos e o clipe nasal", "Muda apenas o formato da peça e a marca do fabricante", "Muda apenas o preço, porque a filtragem é a mesma"]', 0, 41),

    ('O trabalhador começou a sentir cheiro do solvente dentro da máscara com filtro químico. O que isso significa?',
     '["Que o filtro já deixou passar o contaminante: é preciso sair da área imediatamente e trocar o filtro", "Que o filtro está começando a funcionar", "Que o cheiro vem da roupa e pode continuar o serviço", "Que basta apertar mais as tiras da máscara"]', 0, 42),

    ('Qual é a vantagem do respirador de peça facial inteira sobre o semifacial?',
     '["Ele dispensa a troca de filtro", "Ele pode ser usado por qualquer pessoa sem ajuste", "Ele filtra gases que o semifacial não filtra", "Ele veda melhor, oferece fator de proteção maior e ainda protege os olhos e o rosto do contaminante"]', 3, 43),

    ('Em que situação nenhum respirador com filtro serve e é preciso equipamento com suprimento de ar?',
     '["Quando o serviço passa de duas horas", "Quando falta oxigênio no ambiente ou a concentração do contaminante é imediatamente perigosa à vida e à saúde", "Quando o trabalhador tem rinite", "Quando o ambiente tem poeira e vapor ao mesmo tempo"]', 1, 44),

    ('Para que serve o ensaio de vedação, o chamado teste de ajuste, feito antes de liberar o respirador para o trabalhador?',
     '["Para medir a resistência do filtro", "Para conferir se o CA está vigente", "Para verificar se aquele modelo e tamanho realmente vedam no rosto daquela pessoa, já que rosto de cada um é diferente", "Para treinar o trabalhador a respirar mais devagar"]', 2, 45),

    ('Quem define qual respirador e qual filtro usar em cada atividade?',
     '["A empresa, com base no contaminante identificado, na concentração medida e na orientação de profissional habilitado", "O próprio trabalhador, pelo modelo mais confortável", "O almoxarifado, pelo que tem em estoque", "O fornecedor, pelo modelo que estiver em promoção"]', 0, 46),

    ('Terminado o serviço, o respirador reutilizável fica em que condição e em que lugar?',
     '["Pendurado no gancho ao lado da máquina", "Dentro da caixa de ferramentas, junto com as chaves", "No bolso do macacão, para estar sempre à mão", "Limpo, seco e dentro de embalagem fechada, protegido de poeira, sol, calor e produto químico"]', 3, 47),

    ('Como se faz a higienização da peça facial de um respirador reutilizável?',
     '["Mergulhando o conjunto inteiro, com filtros, em água quente", "Retirando os filtros, lavando a peça facial com água e sabão neutro, enxaguando e secando à sombra antes de guardar", "Passando álcool 70 sobre o filtro para desinfetar", "Limpando apenas por fora com pano seco, porque a parte interna não suja"]', 1, 48),

    ('Na pintura com pistola usando tinta com solvente, qual é a proteção respiratória adequada?',
     '["Um PFF2 comum, porque a tinta é névoa e não gás", "Um respirador com filtro apenas mecânico", "Um respirador com filtro combinado, que retém o vapor orgânico e também a névoa de tinta, ou equipamento com ar mandado", "Um lenço úmido amarrado no rosto"]', 2, 49),

    ('O trabalhador usa óculos de grau e precisa de respirador de peça facial inteira. Como resolver?',
     '["Usar o adaptador interno de lentes de grau previsto pelo fabricante da máscara", "Usar o óculos de grau normalmente por baixo da máscara", "Fazer um corte na borracha para as hastes passarem", "Trabalhar sem o óculos de grau, mesmo enxergando pouco"]', 0, 50),

    ('A válvula de exalação do respirador está rachada e suja de tinta. O que fazer?',
     '["Retirar a válvula e usar a máscara sem ela", "Lavar com solvente para soltar a tinta", "Usar assim mesmo, porque a válvula só serve para o ar sair", "Substituir a válvula antes de usar, porque válvula danificada deixa o ar contaminado entrar direto"]', 3, 51),

    ('O trabalhador colocou dois PFF2 sobrepostos achando que dobraria a proteção. Isso é:',
     '["Correto, porque a filtragem soma", "Errado: a sobreposição não soma proteção, atrapalha a vedação e aumenta muito o esforço para respirar", "Correto quando a poeira está muito densa", "Correto se os dois forem da mesma marca"]', 1, 52),

    ('No jateamento abrasivo, a nuvem densa de poeira e abrasivo exige que tipo de equipamento respiratório?',
     '["Um PFF3 com clipe nasal bem ajustado", "Um respirador semifacial com filtro P3", "Capuz ou capacete com suprimento de ar respirável, porque a nuvem de abrasivo e poeira é densa demais para filtro", "Uma máscara de solda com filtro escuro"]', 2, 53),

    ('Por que os filtros químicos têm letras e cores diferentes?',
     '["Porque cada classe retém um grupo de contaminantes: um filtro para vapor orgânico não retém amônia nem gás ácido", "Porque a cor indica o tamanho da rosca", "Porque a letra indica o fabricante", "Porque a cor indica o prazo de validade do filtro"]', 0, 54),

    ('O trabalhador desce o respirador para o pescoço enquanto conversa dentro da área contaminada. Isso é:',
     '["Aceitável, porque a conversa é curta", "Aceitável se ele prender a respiração", "Aceitável se estiver longe da fonte", "Errado: dentro da área a proteção é contínua, e a parte interna da máscara ainda fica contaminada ao encostar no peito"]', 3, 55),

    ('O filtro químico ficou aberto no armário e foi usado poucas horas em um mês. Ele continua bom?',
     '["Sim, porque só conta o tempo de uso", "Não necessariamente: o filtro absorve contaminante do próprio ambiente mesmo fora de uso, e precisa seguir o critério de troca definido no programa", "Sim, até a data impressa na caixa", "Sim, desde que não tenha cheiro"]', 1, 56),

    ('O que a atenuação declarada no protetor auricular, o NRRsf, informa?',
     '["O tempo máximo de uso do protetor", "O tamanho do canal auditivo para o qual ele foi feito", "Quanto de ruído aquele protetor reduz, e é isso que se compara com o nível medido no posto para saber se a proteção é suficiente", "O nível de ruído que a máquina emite"]', 2, 57),

    ('Como se escolhe entre protetor tipo plug de inserção e tipo concha?',
     '["Pela atenuação necessária, pelo tempo de uso, pelo calor e pela sujeira do ambiente e pela compatibilidade com os outros EPI da cabeça", "Sempre pelo mais barato", "Sempre pelo tipo concha, que é mais visível para a fiscalização", "Pelo gosto do trabalhador, sem outro critério"]', 0, 58),

    ('Em que caso se aplica proteção auditiva dupla no mesmo trabalhador?',
     '["Nunca, porque um anula o outro", "Sempre que o trabalhador reclamar de incômodo", "Somente em atividade ao ar livre", "Quando o ruído é tão alto que nenhum dos dois sozinho atinge a atenuação necessária, e a combinação é indicada na avaliação"]', 3, 59),

    ('A haste do óculos de segurança passa entre a almofada do protetor tipo concha e a cabeça. Qual é o problema?',
     '["Nenhum, o óculos é fino", "A almofada deixa de vedar e a atenuação real cai bastante, então é preciso escolher um conjunto compatível ou trocar por protetor de inserção", "O óculos é que perde a proteção", "O problema é apenas estético"]', 1, 60),

    ('O protetor auricular moldado sob medida, feito a partir do molde do canal do trabalhador:',
     '["Serve para qualquer nível de ruído, sem avaliação", "Pode ser emprestado, porque o material é lavável", "É individual e intransferível, exige higienização e conferência periódica do encaixe, porque o canal muda com o tempo", "Dispensa a audiometria periódica"]', 2, 61),

    ('O trabalhador está com dor e secreção no ouvido e o setor é ruidoso. O correto é:',
     '["Encaminhar ao serviço médico e, enquanto isso, avaliar o uso de protetor tipo concha, que não entra no canal", "Continuar com o plug de inserção normalmente", "Deixar de usar protetor até melhorar", "Colocar algodão no lugar do protetor"]', 0, 62),

    ('O protetor auricular resolve sozinho o problema do ruído na empresa?',
     '["Sim, se a atenuação for alta", "Sim, desde que usado o tempo todo", "Sim, quando todo mundo recebe o equipamento", "Não: ele é a última barreira, e a empresa continua obrigada a reduzir o ruído na fonte e a manter o controle médico com audiometria"]', 3, 63),

    ('Para trabalho com risco de respingo de produto químico nos olhos, o óculos adequado é:',
     '["O óculos de segurança comum, com proteção lateral vazada", "O óculos de ampla visão, do tipo que veda todo o contorno dos olhos", "O óculos escuro de policarbonato", "Qualquer óculos com CA"]', 1, 64),

    ('O grau do filtro da máscara de solda deve ser escolhido:',
     '["Sempre o mais escuro disponível", "Sempre o mais claro, para enxergar melhor", "Conforme o processo e a corrente de soldagem, porque filtro claro demais deixa passar radiação e escuro demais faz o soldador aproximar o rosto", "Conforme a preferência do soldador"]', 2, 65),

    ('Quem trabalha em frente a forno, fundição ou metal incandescente precisa de:',
     '["Óculos ou protetor facial com filtro para radiação infravermelha, além da proteção contra respingo e calor", "Óculos escuro comum de sol", "Somente o protetor facial de acetato transparente", "Somente o capacete com aba"]', 0, 66),

    ('Lentes de grau de uso pessoal, com armação comprada em ótica comum, substituem o óculos de segurança?',
     '["Sim, porque tem lente de policarbonato", "Sim, se tiver armação de metal", "Sim, quando o serviço é leve", "Não: ou se usa óculos de segurança por cima, ou se fornece óculos de segurança com lente de grau e CA"]', 3, 67),

    ('A lente do óculos de segurança está embaçando o tempo todo. Qual é a solução correta?',
     '["Passar detergente, cera ou saliva na lente", "Usar lente com tratamento antiembaçante ou modelo com ventilação indireta, e verificar se o problema é o calor do posto ou o vazamento de ar do respirador", "Fazer furos na armação", "Trabalhar com o óculos apoiado na testa"]', 1, 68),

    ('Qual é a diferença entre o protetor facial de acetato e o de policarbonato?',
     '["O acetato resiste melhor ao respingo químico e o policarbonato resiste melhor ao impacto de partícula, e a escolha segue o risco da tarefa", "O acetato é mais resistente ao impacto", "Não há diferença, muda só a espessura", "O policarbonato só serve para solda"]', 0, 69),

    ('Sobre o óculos de proteção para trabalho com laser:',
     '["Precisa ser específico para o comprimento de onda e a potência daquele laser, porque óculos escuro comum não protege a retina", "Qualquer óculos escuro serve, desde que seja bem escuro", "Basta não olhar diretamente para o feixe", "Serve o mesmo filtro usado na solda"]', 0, 70),

    ('Onde guardar o óculos de segurança no fim do turno?',
     '["Solto na gaveta com as ferramentas", "Pendurado na gola da camisa", "No bolso da calça, junto com a chave", "Em estojo ou local próprio, limpo e sem contato com metal, para a lente não riscar"]', 3, 71),

    ('O rosto e a cabeça de quem executa manobra com risco de arco elétrico ficam protegidos por:',
     '["Máscara de solda comum", "Protetor facial e balaclava classificados para arco elétrico, compatíveis com a energia incidente calculada para aquele ponto", "Óculos de segurança com proteção lateral", "Protetor facial de acetato transparente"]', 1, 72),

    ('O que significa o tempo de permeação informado para uma luva de proteção química?',
     '["O tempo que a luva leva para secar depois de lavada", "A validade da luva no estoque", "O tempo que o produto leva para atravessar o material da luva, ou seja, o limite de contato antes de trocar de luva", "O tempo máximo de uso por dia"]', 2, 73),

    ('O trabalhador vai transferir um produto químico e pegou a luva de raspa de couro. Isso está correto?',
     '["Não: a raspa absorve o produto e mantém o líquido em contato com a pele; o correto é a luva do material indicado na ficha de segurança", "Sim, porque a raspa é grossa e resistente", "Sim, se ele lavar a luva depois", "Sim, se o contato for rápido"]', 0, 74),

    ('Para trabalho com faca, lâmina ou chapa de aresta cortante, a luva adequada é:',
     '["Luva de látex, que dá sensibilidade", "Luva de algodão pigmentada", "Luva de raspa comum", "Luva com resistência ao corte no nível indicado para a tarefa, testada e classificada para isso"]', 3, 75),

    ('Como se usa corretamente a luva isolante de borracha em serviço elétrico?',
     '["Sozinha, para não perder a sensibilidade", "Com a luva de cobertura de couro por cima, para proteger a borracha de furo e rasgo, e dentro do prazo de ensaio elétrico", "Por cima da luva de raspa, para dar volume", "Com fita isolante reforçando o punho"]', 1, 76),

    ('De que maneira a luva isolante de borracha viaja e fica armazenada entre um serviço e outro?',
     '["Enrolada no bolso da calça", "Dobrada dentro da caixa de ferramentas", "Esticada, sem dobras e sem peso em cima, dentro da bolsa própria e longe de calor, óleo e sol", "Pendurada pelo dedo em um prego na oficina"]', 2, 77),

    ('Qual é o teste que o eletricista faz na luva isolante antes de cada uso?',
     '["A inspeção visual e o teste de ar: enrola o punho, pressiona e observa se escapa ar por algum furo", "Encosta na fase para ver se dá choque", "Molha a luva e observa se passa água", "Basta conferir a data do último ensaio"]', 0, 78),

    ('Um trabalhador desenvolveu alergia com a luva de látex natural. O que fazer?',
     '["Insistir no uso até o corpo se acostumar", "Passar creme por baixo da luva e continuar", "Usar a luva por cima de uma meia fina", "Encaminhar ao serviço médico e fornecer luva de outro material adequado ao risco, como nitrila, registrando o caso"]', 3, 79),

    ('A luva entregue ficou folgada e sobra na ponta dos dedos. Qual é o risco?',
     '["Nenhum, desde que ela não caia da mão", "A sobra engancha em peça, ferramenta e parte móvel, e a falta de firmeza faz o trabalhador apertar mais e cansar antes", "Somente o desconforto", "Apenas o desgaste mais rápido da luva"]', 1, 80),

    ('Durante o manuseio de um produto químico o trabalhador percebe um furo na luva. O correto é:',
     '["Cobrir o furo com fita e terminar a tarefa", "Virar a luva do avesso e continuar", "Interromper, retirar a luva, lavar as mãos e trocar por uma luva íntegra antes de voltar ao serviço", "Terminar a tarefa e trocar no fim do turno"]', 2, 81),

    ('A luva descartável usada no manuseio de produto ou material biológico pode ser reutilizada?',
     '["Não: ela é de uso único, e lavar ou reutilizar compromete o material e espalha a contaminação", "Sim, se for lavada com água e sabão", "Sim, se for do mesmo trabalhador", "Sim, se for guardada seca em saco fechado"]', 0, 82),

    ('O produto está respingando acima do punho da luva e molhando o antebraço. O correto é:',
     '["Levantar a manga da camisa para ela não encharcar", "Usar luva de cano mais curto para o produto escorrer", "Apertar o punho da luva com fita crepe", "Usar luva de cano longo ou mangote, de modo que a proteção cubra todo o trecho exposto e o punho fique por dentro do avental"]', 3, 83),

    ('Para retirar peça quente de forno ou estufa, a luva correta é:',
     '["Luva de raspa comum, que já resiste um pouco ao calor", "Luva com proteção térmica adequada à temperatura e ao tempo de contato, com cano suficiente para proteger o punho", "Luva de nitrila, que não pega fogo", "Duas luvas de algodão sobrepostas"]', 1, 84),

    ('A luva de couro do eletricista está úmida de suor e chuva. Qual é o risco?',
     '["Nenhum, porque o couro não conduz", "Apenas o mau cheiro", "A umidade reduz muito a isolação e a luva molhada deixa de proteger contra choque, por isso não se usa e se substitui por outra seca", "Apenas o desconforto no manuseio"]', 2, 85),

    ('Para que serve a palmilha de aço ou material antiperfurante no calçado de segurança?',
     '["Impedir que prego, estilhaço ou vergalhão perfure a sola e atinja o pé, risco comum em canteiro de obra", "Melhorar o conforto e a postura", "Aumentar a vida útil do solado", "Isolar o pé do frio do piso"]', 0, 86),

    ('Por que em serviço de solda e fundição se recomenda calçado sem cadarço, com elástico e fechamento rápido?',
     '["Porque o cadarço desamarra com facilidade", "Porque o calçado sem cadarço é mais barato", "Porque o cadarço deixa o pé mais apertado", "Porque a fagulha e o respingo entram pela abertura do cadarço, e o fechamento rápido permite tirar a bota na hora em que o metal entra"]', 3, 87),

    ('Em área lavada com produto químico e com poça no piso, o calçado indicado é:',
     '["Botina de couro com solado de borracha", "Bota impermeável de cano longo, de material resistente ao produto manipulado, conforme a ficha de segurança", "Tênis de segurança leve", "Sapato social fechado"]', 1, 88),

    ('Sobre o uso de calçado com biqueira de aço em serviço com risco elétrico:',
     '["Não faz diferença, porque a biqueira fica na ponta do pé", "É recomendado, porque o aço aterra o trabalhador", "Deve ser evitado: onde o risco é elétrico, usa-se calçado com isolamento e biqueira de material não condutor, quando a proteção contra impacto for necessária", "É indiferente, desde que o solado seja de borracha"]', 2, 89),

    ('Quem opera roçadeira ou motosserra precisa de qual proteção nas pernas?',
     '["Calça de brim reforçada com joelheira", "Perneira comum de couro", "Bota de cano longo apenas", "Perneira ou calça com proteção específica contra corte por corrente ou lâmina, além do conjunto de face, ouvido e mãos"]', 3, 90),

    ('Em piso permanentemente oleoso e molhado, o critério principal do calçado é:',
     '["O peso do calçado", "A cor, para identificar o setor", "A altura do cano", "O solado antiderrapante ensaiado para aquele tipo de piso, porque queda no mesmo nível é uma das maiores causas de afastamento"]', 3, 91),

    ('Botina com solado liso e costura abrindo: o que fazer com ela?',
     '["Solicitar a substituição: calçado com solado gasto perde a aderência e a proteção, mesmo que a biqueira esteja boa", "Colar o solado e usar até o fim do mês", "Usar somente em áreas secas", "Passar cola de sapateiro e continuar"]', 0, 92),

    ('Em área com risco de faísca por eletricidade estática, como em manuseio de solvente e pó, o calçado indicado é:',
     '["O calçado isolante, que não deixa passar corrente", "O calçado condutivo ou antiestático, que escoa a carga do corpo para o piso e evita a centelha", "Qualquer calçado com biqueira", "O calçado de solado grosso de borracha"]', 1, 93),

    ('O que separa o capacete classe A do capacete classe B?',
     '["A classe A é para obra e a classe B é para indústria", "A classe A tem aba total e a B tem só pala", "O classe B tem proteção elétrica para tensões mais altas, indicado para atividades com risco de contato elétrico, enquanto o classe A atende ao risco geral de impacto", "A classe B é mais leve"]', 2, 94),

    ('Quando a jugular do capacete é obrigatória?',
     '["Somente em dias de vento forte", "Somente para quem tem cabelo curto", "Somente em trabalho noturno", "Sempre que houver risco de o capacete cair da cabeça, como em trabalho em altura, ao se inclinar sobre a borda e em atividade com movimentação intensa"]', 3, 95),

    ('Como se sabe que um capacete chegou ao fim da vida útil?',
     '["Só quando trinca visivelmente", "Pela data de fabricação marcada no casco, pelo prazo indicado pelo fabricante e pelos sinais de envelhecimento, como perda de brilho, aspecto esbranquiçado e rigidez do plástico", "Quando o adesivo da empresa descola", "Quando o trabalhador troca de função"]', 1, 96),

    ('Para que serve a suspensão interna do capacete, o conjunto de tiras que encosta na cabeça?',
     '["Apenas para ajustar o tamanho", "Apenas para o capacete não escorregar no suor", "Para manter um espaço entre o casco e o crânio e absorver o impacto, e por isso ela também é inspecionada e substituída quando ressecada ou rompida", "Apenas para prender a lanterna"]', 2, 97),

    ('Usar boné comum por baixo do capacete:',
     '["Não deve ser feito: a aba e o tecido afastam a suspensão da cabeça, alteram o ajuste e reduzem a absorção do impacto; o correto é a touca própria compatível", "Pode, se o boné for fino", "Pode, para proteger do sol", "Pode, desde que a jugular esteja presa"]', 0, 98),

    ('O capacete fica guardado no painel do carro, exposto ao sol, entre um dia e outro. Qual é o problema?',
     '["Nenhum, o plástico é resistente", "Apenas o capacete esquenta e fica desconfortável", "Apenas desbota a cor", "A radiação e o calor degradam o material do casco, que perde resistência sem apresentar trinca visível, e o capacete deixa de proteger na hora do impacto"]', 3, 99),

    ('Sobre o capacete usado por mais de um trabalhador ao longo dos turnos:',
     '["Não há restrição, o capacete é um só", "O ideal é o uso individual e identificado; quando o uso é compartilhado, é preciso higienizar a suspensão e conferir o ajuste a cada troca", "Basta trocar a suspensão uma vez por ano", "Basta passar álcool no casco"]', 1, 100),

    ('Talabarte com absorvedor e trava-quedas retrátil funcionam de que modo distinto?',
     '["O talabarte tem comprimento fixo e depende do absorvedor para limitar o impacto, e o trava-quedas retrátil recolhe a fita e trava no momento da queda, reduzindo a distância percorrida", "O talabarte é para altura e o retrátil é para posicionamento", "Não há diferença, muda só o nome comercial", "O retrátil dispensa o ponto de ancoragem"]', 0, 101),

    ('Por que o mosquetão usado no conjunto de proteção contra queda precisa ter dupla trava?',
     '["Porque a dupla trava aumenta a resistência do metal", "Porque a norma exige duas peças de metal", "Porque a dupla trava permite abrir com uma mão só", "Porque um mosquetão de trava simples pode abrir sozinho ao encostar em estrutura ou girar, e soltar o trabalhador no meio da queda"]', 3, 102),

    ('O cinturão de segurança tipo abdominal, de posicionamento, pode ser usado para reter uma queda?',
     '["Sim, se o talabarte for curto", "Não: ele serve apenas para posicionar o trabalhador no local de trabalho, e em uma queda concentra toda a força no abdome, com lesão grave", "Sim, em quedas de pouca altura", "Sim, se for usado junto com uma corda"]', 1, 103),

    ('O cinturão e seus componentes, além do exame feito antes de cada uso, passam por quê?',
     '["Apenas a limpeza mensal", "Apenas a conferência do CA", "Inspeção periódica registrada, feita por pessoa capacitada, com identificação individual do equipamento e histórico de uso e ocorrências", "Apenas a troca a cada cinco anos"]', 2, 104),

    ('Quem define o ponto de ancoragem e a linha de vida em que o cinto será conectado?',
     '["Profissional legalmente habilitado, que dimensiona a estrutura para a carga prevista, e não o trabalhador no momento do serviço", "O encarregado, no dia do serviço", "O próprio trabalhador, escolhendo o que parecer firme", "O fornecedor do cinto"]', 0, 105),

    ('Qual avental usar no manuseio de ácido e qual usar na solda?',
     '["O mesmo avental de raspa serve para os dois", "Avental impermeável de material resistente ao produto para o ácido, e avental de raspa de couro para a solda, porque respingo de metal fundido derrete o plástico e ácido atravessa o couro", "Avental de plástico para os dois, por ser mais leve", "Avental de brim para os dois, por ser de algodão"]', 1, 106),

    ('Quem passa a jornada dentro de câmara fria precisa de qual conjunto de proteção?',
     '["Duas camisas de manga comprida por baixo do uniforme", "Apenas jaqueta de tecido comum e touca", "Conjunto térmico apropriado, com proteção de mãos, pés e cabeça, além do controle do tempo de permanência e das pausas de recuperação térmica", "Somente luva e touca, porque o tronco esquenta com o movimento"]', 2, 107),

    ('O trabalhador usa uma camiseta sintética por baixo da vestimenta antichama. Qual é o problema?',
     '["Nenhum, porque a camada de fora é que protege", "Apenas o desconforto com o calor", "Apenas a camiseta ficar manchada", "Se o calor atravessar, o sintético derrete e gruda na pele, agravando muito a queimadura; por baixo da antichama usa-se algodão ou tecido também antichama"]', 3, 108),

    ('Para que serve o macacão descartável tipo tyvek em serviços de pintura, limpeza química ou remoção de poeira perigosa?',
     '["Para identificar a equipe visualmente", "Para proteger do frio dentro do galpão", "Para evitar que o contaminante fique na roupa e na pele e seja levado para outras áreas e para casa, sendo descartado ao fim da tarefa", "Para substituir o respirador em serviços rápidos"]', 2, 109),

    ('A roupa do trabalhador ficou contaminada com produto químico durante o serviço. O correto é:',
     '["Trocar no local, colocar a roupa contaminada em recipiente próprio identificado e deixar que a empresa faça a higienização, sem levar para casa", "Levar para casa e lavar com o resto da roupa da família", "Deixar secar e usar de novo no dia seguinte", "Lavar na pia do vestiário e vestir de novo"]', 0, 110),

    ('Como se confere se o CA de um equipamento é verdadeiro e está vigente?',
     '["Basta confiar no número impresso no equipamento", "Basta a nota fiscal do fornecedor", "Basta a etiqueta da caixa estar lacrada", "Consultando o número do CA na base oficial do órgão do trabalho, onde constam o fabricante, o tipo de equipamento e a validade"]', 3, 111),

    ('Estagiário, jovem aprendiz e trabalhador temporário que entram na área de risco:',
     '["Entram sem EPI, porque não são empregados efetivos", "Recebem o EPI adequado ao risco, com treinamento e registro de entrega, exatamente como qualquer outro trabalhador", "Usam o EPI de quem estiver de folga", "Só recebem EPI depois de trinta dias"]', 1, 112),

    ('O fornecimento de EPI adequado pode eliminar o adicional de insalubridade?',
     '["Não em nenhuma hipótese", "Sim, sempre que o EPI for entregue", "Pode, quando o equipamento neutraliza comprovadamente a exposição do trabalhador ao agente, com avaliação técnica que demonstre a neutralização e comprovação do uso efetivo", "Sim, quando o trabalhador assina a ficha"]', 2, 113),

    ('O que acontece com o EPI quando o trabalhador muda de função ou é desligado?',
     '["Ele devolve o equipamento, que é registrado na ficha e avaliado antes de qualquer reaproveitamento ou descarte", "Ele fica com o equipamento, que já foi usado", "O equipamento é jogado fora sem registro", "O equipamento vai direto para outro trabalhador, sem conferência"]', 0, 114),

    ('O treinamento sobre EPI acontece:',
     '["Apenas na admissão", "Apenas quando a fiscalização visita a empresa", "Apenas quando o trabalhador pede", "Na admissão, na mudança de equipamento ou de risco, quando a inspeção mostra uso incorreto e sempre que houver necessidade, com registro"]', 3, 115),

    ('Um EPI de uso compartilhado por posto, como um protetor facial que fica na bancada, exige:',
     '["Nada além de estar no local", "Higienização entre um usuário e outro, conferência do ajuste e um responsável pela inspeção e guarda, porque equipamento de todo mundo acaba sem dono", "Que cada trabalhador leve o seu para casa", "Uso apenas pelo primeiro turno"]', 1, 116),

    ('Por que a compatibilidade entre os EPI de um mesmo conjunto precisa ser avaliada?',
     '["Porque a norma exige que todos sejam do mesmo fabricante", "Porque o conjunto fica mais bonito", "Porque um equipamento pode anular o outro: capacete que afasta a concha, óculos que abre a vedação do respirador e protetor facial que impede a máscara de solda de fechar", "Porque o custo do conjunto fica menor"]', 2, 117),

    ('O trabalhador é canhoto e o EPI e a ferramenta do posto foram pensados para destros. O correto é:',
     '["Fornecer o equipamento e a ferramenta adequados ao lado dominante, ou ajustar o posto, porque forçar o uso com a mão não dominante aumenta o esforço e o risco de acidente", "Pedir que ele se adapte com o tempo", "Trocar o trabalhador de setor", "Não fazer nada, porque o EPI é igual para os dois lados"]', 0, 118),

    ('Pano amarrado no rosto, óculos de sol e luva de casa em serviço industrial são:',
     '["Aceitáveis quando o equipamento certo está em falta", "Aceitáveis em serviço rápido", "Aceitáveis se o trabalhador preferir", "Improvisos sem certificação, que não protegem e ainda dão falsa sensação de segurança; sem o equipamento correto a atividade não começa"]', 3, 119),

    ('Um pintor vai aplicar tinta a pistola em ambiente fechado usando um PFF2. Qual é o erro?',
     '["Nenhum, o PFF2 filtra a névoa da tinta", "O PFF2 retém partícula, mas não retém o vapor do solvente, que é o principal risco naquele serviço", "O PFF2 é grande demais para o rosto dele", "O erro é não usar dois PFF2"]', 1, 120),

    ('Um trabalhador vai descarregar bombonas de ácido usando luva de raspa, botina de couro e óculos comum. O que está errado?',
     '["Apenas o óculos", "Apenas a botina", "Praticamente todo o conjunto: para ácido são necessários luva e bota resistentes ao produto, óculos de ampla visão ou protetor facial e avental impermeável, conforme a ficha de segurança", "Nada, o conjunto está adequado"]', 2, 121),

    ('Um trabalhador se inclina sobre a borda da laje para conferir um serviço, com o capacete sem jugular. O que acontece?',
     '["O capacete cai, e além de deixar a cabeça dele desprotegida vira um objeto em queda sobre quem está embaixo", "Nada, o capacete fica na cabeça pelo próprio peso", "O capacete protege melhor solto", "Só há problema se houver vento"]', 0, 122),

    ('Um colega coloca algodão ou papel no ouvido dizendo que atenua o ruído. Isso é:',
     '["Aceitável quando o protetor incomoda", "Aceitável se o ruído for intermitente", "Aceitável no fim do turno", "Sem qualquer efeito comprovado de atenuação, não é EPI, não tem CA e ainda pode ficar retido no canal auditivo"]', 3, 123),

    ('Proteção coletiva e proteção individual: o que separa uma da outra?',
     '["Não há diferença, os dois protegem o trabalhador", "O EPC protege todo mundo que está na área ao mesmo tempo, como guarda-corpo, exaustor e proteção de máquina, e o EPI protege uma pessoa por vez, e a coletiva vem antes na hierarquia", "O EPI é fornecido pela empresa e o EPC pelo trabalhador", "O EPC só existe em obra"]', 1, 124),

    ('O trabalhador alega que o EPI atrapalha e faz ele produzir menos. O que a empresa deve fazer?',
     '["Verificar se o equipamento é o adequado, se o tamanho e o ajuste estão certos e se há alternativa mais confortável com a mesma proteção, e manter a exigência do uso, porque produção não negocia com risco", "Descontar a diferença de produção", "Liberar o uso apenas nos momentos de maior risco", "Aceitar e registrar a recusa"]', 0, 125),

    ('Por que a empresa precisa manter estoque de reposição dos equipamentos usados na área?',
     '["Porque equipamento que se danifica no meio do turno precisa ser trocado na hora, e sem reposição imediata o trabalhador segue o serviço desprotegido ou improvisa", "Porque a compra em quantidade sai mais barata", "Porque o estoque comprova o cumprimento da norma em uma fiscalização", "Porque assim o almoxarifado atende apenas uma vez por semana"]', 0, 126),

    ('Um equipamento foi danificado por mau uso intencional. Como a empresa trata o caso?',
     '["Deixar ele sem equipamento até o fim do mês", "Descontar o valor sem qualquer procedimento", "Ignorar, porque o EPI é obrigação da empresa", "Substituir o equipamento de imediato, porque ninguém trabalha sem proteção, e tratar o dano pelo procedimento disciplinar da empresa, separadamente"]', 3, 127),

    ('A lente de reposição do protetor facial acabou e existe uma de outra marca no almoxarifado. Pode usar?',
     '["Pode, se encaixar no suporte", "Só se a peça de reposição for prevista pelo fabricante para aquele equipamento e mantiver a certificação do conjunto, porque peça de outro fabricante invalida o CA", "Pode, se a espessura for parecida", "Pode, se for aparafusada com firmeza"]', 1, 128),

    ('A almofada de vedação do protetor auricular tipo concha está ressecada e rachada. O correto é:',
     '["Passar vaselina para amaciar", "Usar assim mesmo, porque a concha continua inteira", "Substituir a almofada ou o protetor, porque a vedação rachada derruba a atenuação real para muito abaixo do valor declarado", "Colar com adesivo e continuar"]', 2, 129),

    ('O casco da máscara de solda está rachado e a luz entra por uma fresta. O que fazer?',
     '["Retirar de uso e substituir, porque a fresta deixa passar radiação e respingo direto no rosto do soldador", "Vedar com fita crepe", "Usar de costas para a fresta", "Usar somente em soldas de baixa corrente"]', 0, 130),

    ('Em trabalho com materiais que contêm amianto, o conjunto de proteção envolve:',
     '["Apenas o PFF2 e a luva de raspa", "Apenas o macacão descartável", "Apenas a umidificação do material", "Proteção respiratória adequada à concentração, vestimenta descartável, controle de acesso, umidificação, descontaminação na saída e destinação correta da roupa e do resíduo"]', 3, 131),

    ('Quem manuseia nitrogênio líquido ou outro produto criogênico precisa de:',
     '["Luva térmica comum de forno", "Luva própria para criogenia, protetor facial e vestimenta que não permita retenção do líquido, com atenção também ao risco de asfixia pelo deslocamento do oxigênio no ambiente", "Apenas luva de nitrila", "Apenas óculos de segurança"]', 1, 132),

    ('Quem manuseia material biológico e perfurocortante precisa de:',
     '["Somente a luva de procedimento", "Somente o jaleco", "Luva adequada, proteção de olhos e face contra respingo, jaleco ou avental e, principalmente, o recipiente rígido para descarte do perfurocortante, que é o que evita o acidente mais comum", "Somente o óculos e a máscara cirúrgica"]', 2, 133),

    ('Na aplicação de agrotóxico, o conjunto correto inclui:',
     '["Vestimenta hidrorrepelente com CA para essa finalidade, luva, bota, touca árabe, viseira facial e proteção respiratória conforme o produto e o modo de aplicação", "Somente a máscara e a luva", "Camisa de manga comprida e boné", "Somente a bota e o óculos"]', 0, 134),

    ('Na poda de árvore com risco de queda de galho, o capacete adequado é:',
     '["O capacete comum de obra, sem mais nada", "Boné rígido tipo casquete", "Capacete de bicicleta, que é mais leve", "Capacete com jugular, protetor auricular e viseira ou tela de proteção facial acopladas, formando um conjunto próprio para a atividade"]', 3, 135),

    ('Por que o uso de EPI em ambiente quente exige atenção redobrada com o calor?',
     '["Porque o equipamento esfria o corpo demais", "Porque a vestimenta e a máscara dificultam a troca de calor e a evaporação do suor, aumentando a sobrecarga térmica, o que exige pausas, hidratação e revezamento", "Porque o equipamento fica pesado com o suor", "Porque o CA vale menos em ambiente quente"]', 1, 136),

    ('O trabalhador reclama de dor de cabeça e marca funda na testa por causa do capacete. O correto é:',
     '["Mandar usar assim mesmo, porque é questão de costume", "Afrouxar a jugular e deixar o capacete solto", "Ajustar ou substituir a suspensão e o tamanho, avaliar o peso do conjunto usado na cabeça e encaminhar ao serviço médico se a queixa continuar", "Autorizar o uso sem capacete no calor"]', 2, 137),

    ('O serviço na área de risco vai durar dois minutos. O EPI é necessário?',
     '["Não, se o trabalhador for experiente", "Não, se ninguém mais estiver na área", "Não, se for só para olhar", "Sim: o risco não diminui com o tempo de exposição, e boa parte dos acidentes acontece na entrada rápida que ninguém achou que precisasse de equipamento"]', 3, 138),

    ('O modelo com CA está em falta e o fornecedor ofereceu um equipamento parecido, sem certificação. A empresa pode comprar?',
     '["Pode, se o preço for melhor", "Pode, enquanto o certificado é providenciado", "Pode, se o trabalhador aceitar", "Não pode: sem CA o produto não é EPI, não pode ser fornecido nem usado, e a atividade fica suspensa até haver equipamento certificado"]', 3, 139),

    ('Para que serve a inspeção periódica registrada dos EPI em uso?',
     '["Para controlar apenas o estoque", "Para identificar desgaste, dano e uso incorreto antes que o equipamento falhe, e gerar a troca no momento certo em vez de depois do acidente", "Para justificar a compra do ano seguinte", "Para conferir se o trabalhador não perdeu o equipamento"]', 1, 140),

    ('O encarregado encontra um trabalhador de empresa contratada na área sem o EPI exigido. O que a contratante faz?',
     '["Ignora, porque o trabalhador é de outra empresa", "Empresta um equipamento qualquer para resolver na hora", "Interrompe a atividade, comunica formalmente a contratada e só libera o serviço com o trabalhador protegido, porque quem controla a área responde por quem está nela", "Anota no relatório mensal"]', 2, 141),

    ('O que é uma máscara de fuga ou autorresgatador?',
     '["Equipamento de uso contínuo em área com gás", "Substituto do respirador com filtro no trabalho diário", "Equipamento para o vigia usar no resgate", "Equipamento de uso exclusivo em emergência, para o trabalhador sair da área contaminada, com tempo de autonomia limitado e sem servir para executar tarefa"]', 3, 142),

    ('A placa redonda azul com o desenho de um capacete na entrada do setor significa:',
     '["Que ali existe risco de queda de material", "Que o uso do capacete é obrigatório para entrar e permanecer naquele local", "Que o capacete pode ser retirado a partir dali", "Que ali fica guardado o estoque de capacetes"]', 1, 143),

    ('O que muda na proteção do soldador quando o serviço é dentro de espaço confinado?',
     '["Nada, o conjunto do soldador é sempre o mesmo", "Somam-se as exigências de proteção respiratória com suprimento de ar ou exaustão eficaz, o monitoramento da atmosfera e o conjunto de resgate, além de todo o EPI de solda", "Basta usar um filtro P3 no lugar do PFF2", "Basta reduzir o tempo de serviço pela metade"]', 1, 144),

    ('O trabalhador usa moto para tarefas a serviço da empresa. Sobre o equipamento de proteção:',
     '["Basta o capacete de motociclista fechado", "Basta o colete refletivo", "A empresa avalia o risco da atividade e fornece o conjunto adequado, que inclui capacete certificado, vestimenta de alta visibilidade e proteção das mãos, com treinamento e manutenção do veículo", "A responsabilidade é toda do trabalhador, porque a moto é dele"]', 2, 145),

    ('Em serviço com jato de água de alta pressão, a proteção necessária inclui:',
     '["Somente capa de chuva e bota", "Somente óculos de segurança", "Somente luva impermeável", "Vestimenta e perneira resistentes ao jato, protetor facial, luva, bota e proteção auditiva, porque o jato corta a pele e injeta contaminação no tecido"]', 3, 146),

    ('O cinto porta-ferramenta usado em altura precisa de qual cuidado?',
     '["Nenhum, porque não é equipamento de proteção", "Ser preso ao cinto de segurança para dar apoio", "Manter as ferramentas presas por cordinha ou dispositivo de retenção, porque ferramenta que cai de altura mata quem está embaixo mesmo sendo leve", "Ser usado sempre por cima do cinturão paraquedista"]', 2, 147),

    ('Não existe no mercado um EPI que proteja contra o risco daquela atividade. O que fazer?',
     '["Fornecer o mais parecido que houver e liberar o serviço", "Voltar na hierarquia de controle e eliminar ou reduzir o risco por medida de engenharia ou mudança do processo, porque não se libera atividade sem proteção", "Executar com o trabalhador mais experiente", "Reduzir o tempo de exposição pela metade e executar"]', 1, 148),

    ('O trabalhador não pode raspar a barba por motivo religioso e a atividade exige proteção respiratória. A solução correta é:',
     '["Liberar o uso do PFF2 com as tiras bem apertadas", "Manter o trabalhador na atividade sem proteção", "Fornecer equipamento que não dependa da vedação no rosto, como capuz ou capacete com suprimento de ar, ou realocar o trabalhador para atividade sem esse risco", "Usar duas máscaras sobrepostas"]', 2, 149),

    ('Como a empresa sabe se o programa de EPI está funcionando de verdade?',
     '["Olhando o uso efetivo em campo, o resultado das inspeções, as queixas de desconforto e os índices de acidente e de doença, e não apenas as fichas de entrega assinadas", "Pelo número de equipamentos comprados no ano", "Pela quantidade de fichas assinadas no arquivo", "Pelo valor gasto com o fornecedor"]', 0, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-06';


-- =====================================================================
--  NR-17 — Ergonomia (questões 41 a 150)
--  As 40 antigas cobriram o levantamento, o mobiliário básico, a tela, o
--  teleatendimento, o caixa, o turno e a meta. Estas 110 abrem o resto do
--  que a norma alcança e que quase ninguém associa a ergonomia: a torção
--  do tronco que a coluna não perdoa, a iluminância da tarefa, o frio da
--  câmara e o calor do galpão, a vibração de corpo inteiro, os riscos
--  psicossociais, as etapas da avaliação ergonômica, o DORT com nome e
--  sinal, a adaptação do posto para quem tem deficiência, e vinte
--  profissões reais, porque a ergonomia da costureira não é a do
--  soldador nem a da camareira.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-17')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O trabalhador pega uma caixa em uma bancada e a coloca em outra, atrás dele. Qual é a forma correta?',
     '["Mover os pés e girar o corpo inteiro, mantendo a carga de frente e perto do tronco", "Girar o tronco com os pés parados, para ser mais rápido", "Jogar a caixa por cima do ombro", "Segurar com um braço só e virar o quadril"]', 0, 41),

    ('Para pegar um objeto no fundo de uma prateleira baixa, o correto é:',
     '["Agachar apoiando um joelho, aproximar o corpo do objeto e só então levantar com as pernas", "Ajoelhar em cima da carga da frente", "Curvar o tronco e esticar o braço até alcançar", "Puxar o objeto com um gancho improvisado"]', 0, 42),

    ('Carregar sempre a carga apoiada no mesmo ombro traz qual problema?',
     '["Nenhum, desde que o peso seja moderado", "Apenas desgaste do uniforme", "Apenas cansaço no fim do dia", "Sobrecarga assimétrica da coluna e do ombro, que com o tempo gera dor e lesão, e por isso se alterna o lado ou se usa meio mecânico"]', 3, 43),

    ('Por que a distância entre a carga e o corpo muda tanto o esforço da coluna?',
     '["Porque a carga fica mais pesada quando esfria", "Porque quanto mais longe do tronco, maior o braço de alavanca e maior a força que a musculatura da coluna precisa fazer para o mesmo peso", "Porque o braço esticado dá mais força", "Porque o equilíbrio melhora com a carga longe"]', 1, 44),

    ('Levantar uma carga do chão diretamente até uma prateleira acima dos ombros, em um único movimento:',
     '["É a forma mais eficiente, porque economiza tempo", "Não tem problema se o trabalhador for alto", "Deve ser evitado: o correto é fracionar o movimento apoiando em nível intermediário, ou usar meio mecânico, porque o trecho acima dos ombros é o de maior risco", "Só é problema se a carga passar de 30 quilos"]', 2, 45),

    ('Por que a existência de alças ou pegadores na embalagem importa na avaliação do levantamento?',
     '["Porque melhora a aparência do produto", "Porque reduz o custo da embalagem", "Porque facilita o empilhamento", "Porque pegada ruim obriga a apertar mais com os dedos e a afastar a carga do corpo, aumentando o esforço mesmo com o peso igual"]', 3, 46),

    ('Uma bombona pela metade, com o líquido balançando dentro, é mais difícil de carregar porque:',
     '["O peso é maior do que o da bombona cheia", "O centro de gravidade muda durante o movimento e o trabalhador faz correções bruscas para não perder o equilíbrio", "O plástico fica mais escorregadio", "A altura da bombona atrapalha a visão"]', 1, 47),

    ('Qual é a relação entre o piso, o calçado e o levantamento de carga?',
     '["Não há relação, o levantamento depende só da técnica", "Piso e calçado só importam para o risco de queda", "Apoio instável, piso irregular ou solado gasto obrigam o corpo a compensar durante o esforço e aumentam o risco de lesão na coluna", "O calçado pesado ajuda a fixar o corpo"]', 2, 48),

    ('Para descarregar caixas de um caminhão até o piso do galpão, a melhor solução ergonômica é:',
     '["Formar corrente humana passando as caixas de mão em mão", "Jogar as caixas para o colega embaixo", "Cada trabalhador descer com uma caixa pela escada", "Usar plataforma niveladora, rampa, esteira ou empilhadeira, mantendo o trabalho na faixa de altura entre o quadril e os ombros"]', 3, 49),

    ('Serviço executado de joelhos ou de cócoras durante boa parte da jornada pede quais medidas?',
     '["Que o trabalhador aguente, porque a tarefa é assim", "Joelheira, banqueta baixa ou carrinho de apoio, alternância de postura e pausas, além de estudar a mudança da altura da tarefa", "Apenas alongamento no fim do dia", "Apenas uso de calçado macio"]', 1, 50),

    ('Trabalho deitado embaixo de veículo ou máquina, por tempo prolongado, deve contar com:',
     '["Carro-maca ou elevador que traga a tarefa para uma altura de trabalho adequada, iluminação apropriada e revezamento, porque a postura deitada com braços elevados sobrecarrega ombros e pescoço", "Apenas iluminação de emergência", "Apenas um papelão no chão", "Apenas revezamento a cada quatro horas"]', 0, 51),

    ('O trabalhador passa o dia com o pescoço fletido para baixo, olhando documento ou tela apoiada na mesa. Qual é a correção?',
     '["Alongar o pescoço no fim do expediente", "Usar colar cervical durante a jornada", "Fortalecer o pescoço com exercício", "Elevar o documento ou a tela para perto da linha dos olhos, com suporte, para reduzir a flexão mantida do pescoço"]', 3, 52),

    ('O antebraço apoiado o dia inteiro sobre a borda viva da bancada produz o quê?',
     '["Comprime nervos e vasos do antebraço e provoca formigamento e dor, e a correção é arredondar ou acolchoar a borda e rever a altura da bancada", "Não traz consequência, porque a pele se acostuma", "Melhora a estabilidade da mão", "Só incomoda quem tem o braço fino"]', 0, 53),

    ('Qual é a vantagem do posto que permite trabalhar alternando entre sentado e em pé?',
     '["Permite atender mais clientes por hora", "Reduz a manutenção do mobiliário", "Permite mudar de postura ao longo do dia, o que alivia coluna, pernas e circulação, já que o problema não é ficar sentado nem em pé, e sim ficar parado na mesma posição", "Elimina a necessidade de pausas"]', 2, 54),

    ('Subir escada carregando volume nas duas mãos:',
     '["Deve ser evitado: sem uma das mãos livre para o corrimão, qualquer tropeço vira queda, e o correto é usar carrinho, elevador de carga ou fracionar a carga", "Não é problema se o volume for leve", "É aceitável se o trabalhador subir devagar", "É aceitável se houver alguém acompanhando"]', 0, 55),

    ('Qual é o efeito de um assento com profundidade grande demais para a perna do trabalhador?',
     '["Melhora o apoio da coxa", "Nenhum, porque o encosto compensa", "A borda do assento comprime a parte de trás do joelho e prejudica a circulação, ou o trabalhador senta na ponta e perde o apoio lombar", "Apenas dificulta levantar da cadeira"]', 2, 56),

    ('A borda dianteira do assento da cadeira de trabalho deve ser:',
     '["Reta e rígida, para dar firmeza", "Arredondada e levemente acolchoada, para não comprimir a região atrás do joelho", "Elevada, para segurar o trabalhador na cadeira", "Recuada, deixando a coxa sem apoio"]', 1, 57),

    ('Sobre o apoio de braço da cadeira de escritório:',
     '["Deve ser sempre fixo e alto", "Deve ser retirado em todos os postos", "Deve ser regulável e permitir que o trabalhador aproxime a cadeira da mesa; apoio alto demais eleva o ombro e apoio que bate na mesa afasta o corpo da tarefa", "Deve ser mais largo que a mesa"]', 2, 58),

    ('A cadeira do posto não tem regulagem de altura e o estofado está afundado. O que isso provoca?',
     '["Apenas desconforto momentâneo", "O trabalhador se adapta com o tempo", "Apenas o desgaste mais rápido do tecido", "O trabalhador passa a compensar com a coluna, os ombros e os punhos para alcançar a tarefa, e a queixa aparece depois como dor crônica"]', 3, 59),

    ('O notebook usado o dia inteiro apoiado direto na mesa é um problema porque:',
     '["A bateria esquenta a mesa", "Tela e teclado ficam presos na mesma altura: ou o pescoço abaixa para ver a tela, ou os punhos sobem para o teclado, e a solução é o suporte com teclado e mouse externos", "O notebook é pequeno demais para o trabalho", "O trabalhador precisa de mais espaço na mesa"]', 1, 60),

    ('Quando o posto tem dois monitores, a regra de posicionamento é:',
     '["Se um é usado a maior parte do tempo, ele fica à frente do trabalhador e o segundo ao lado; se os dois são usados igualmente, ficam centralizados e juntos, sem obrigar torção do pescoço", "Colocar um monitor bem mais alto que o outro", "Colocar os dois bem afastados um do outro", "Colocar o segundo monitor atrás do primeiro"]', 0, 61),

    ('Para quem digita a partir de documento em papel, o suporte de documento serve para:',
     '["Organizar a mesa", "Evitar que o papel se perca", "Aumentar o espaço da mesa", "Manter o documento na mesma altura e distância da tela, evitando o movimento repetido de abaixar e girar o pescoço centenas de vezes por dia"]', 3, 62),

    ('Segurar o telefone entre o ombro e a orelha para escrever ao mesmo tempo:',
     '["É uma postura forçada do pescoço e do ombro, e a correção é fornecer fone com microfone", "É aceitável em ligações curtas", "Melhora com o alongamento diário", "Não tem relação com ergonomia"]', 0, 63),

    ('Na troca de turno, quem assume o posto encontra o mobiliário na regulagem do colega anterior. O que fazer?',
     '["Fixar a regulagem na média das três pessoas", "Cada trabalhador reajustar cadeira, monitor, apoio e altura no início do seu turno, e o mobiliário precisa permitir esse ajuste rápido", "Escolher a regulagem do trabalhador mais antigo", "Deixar cada um se adaptar como conseguir"]', 1, 64),

    ('Espaço apertado em volta do posto: por que isso vira assunto de ergonomia?',
     '["Porque melhora a aparência do setor", "Porque facilita a limpeza", "Porque espaço apertado obriga o trabalhador a torcer o corpo, passar de lado com carga e trabalhar em postura forçada, além de dificultar a saída em emergência", "Porque a norma define metragem por trabalhador"]', 2, 65),

    ('Para quem trabalha em pé o dia inteiro sobre piso duro, o tapete antifadiga:',
     '["Substitui a pausa e o assento", "Serve apenas para isolar do frio", "É desnecessário se o calçado for bom", "Ajuda a reduzir o desconforto nas pernas e na lombar, mas não substitui a alternância de postura, as pausas e o assento disponível"]', 3, 66),

    ('Como se define se a iluminação do posto é adequada?',
     '["Perguntando se o trabalhador está enxergando", "Pelo número de lâmpadas do setor", "Medindo a iluminância no plano da tarefa e comparando com o valor recomendado pela norma técnica para aquele tipo de trabalho", "Pela potência total instalada no galpão"]', 2, 67),

    ('Qual é a diferença entre iluminação geral e iluminação de tarefa?',
     '["Não há diferença prática", "A geral ilumina o ambiente e a de tarefa é a luminária dirigida ao ponto de trabalho, usada quando a tarefa exige mais luz que o restante do setor", "A de tarefa é usada apenas à noite", "A geral só existe em escritório"]', 1, 68),

    ('O trabalhador faz sombra com a própria mão sobre a peça que está montando. O problema é:',
     '["A altura da bancada", "A cor da peça", "A luz vem de trás ou de cima do lado errado, e a correção é reposicionar a luminária para que a luz chegue pelo lado oposto à mão dominante", "A potência da lâmpada, que precisa dobrar"]', 2, 69),

    ('Em tarefa de inspeção visual de peça, além da quantidade de luz, importa:',
     '["Apenas a cor da parede do setor", "Apenas o tempo de inspeção", "Apenas o tamanho da peça", "O contraste entre a peça e o fundo, a direção da luz e a ausência de ofuscamento, porque defeito pequeno só aparece com contraste adequado"]', 3, 70),

    ('Lâmpada piscando ou com cintilação no posto de trabalho:',
     '["Provoca fadiga visual e dor de cabeça e deve ser substituída, e não apenas tolerada até a manutenção programada", "Só incomoda quem já tem problema de vista", "É irrelevante se a iluminância medida estiver correta", "Melhora quando se aumenta o brilho da tela"]', 0, 71),

    ('O trabalho em câmara fria exige, do ponto de vista da ergonomia:',
     '["Controle do tempo de permanência, pausas de recuperação térmica em ambiente aquecido e organização da tarefa para reduzir a exposição, além da vestimenta adequada", "Apenas o fornecimento do conjunto térmico", "Apenas o revezamento por turno", "Apenas bebida quente no intervalo"]', 0, 72),

    ('Em atividade com sobrecarga térmica por calor, o controle correto envolve:',
     '["Regime de trabalho e descanso conforme a intensidade do esforço e do calor, água disponível ao lado do posto, sombra ou área climatizada para a pausa e aclimatização do trabalhador novo", "Distribuir sal e continuar o serviço", "Aumentar o ritmo para sair mais cedo da área", "Trocar o uniforme por camiseta regata"]', 0, 73),

    ('Ar-condicionado soprando direto no trabalhador e ambiente muito seco causam:',
     '["Apenas sensação de frio", "Somente economia de energia", "Nada, porque a temperatura média está correta", "Desconforto localizado, ressecamento dos olhos e das vias aéreas e dores musculares, e por isso a norma trata de corrente de ar, temperatura e umidade em conjunto"]', 3, 74),

    ('O que é vibração de corpo inteiro e quem está exposto a ela?',
     '["A vibração da ferramenta que passa pela mão do operador", "A vibração transmitida pelo assento ou pelo piso ao corpo, comum em operadores de empilhadeira, trator, caminhão e ponte rolante, associada a dor lombar", "Apenas o tremor do piso perto de prensas", "Um efeito sem relação com a saúde"]', 1, 75),

    ('Como se reduz a vibração de corpo inteiro do operador de máquina móvel?',
     '["Aumentando a velocidade para reduzir o tempo de exposição", "Colocando uma almofada comum no banco", "Com assento amortecido e regulado para o peso do operador, manutenção da máquina e do pneu, correção do piso da rota e limite de tempo de operação contínua", "Apenas com cinto abdominal"]', 2, 76),

    ('Em ambiente ruidoso onde o trabalhador precisa falar o dia inteiro, o risco adicional é:',
     '["O ruído deixar o trabalho mais lento apenas", "Nenhum, se ele usar protetor auricular", "Somente o desgaste do protetor", "O esforço vocal para se fazer ouvir, que leva a rouquidão e distúrbio da voz, e por isso se reduz o ruído de fundo e se fornece amplificação quando necessário"]', 3, 77),

    ('O que são riscos psicossociais no trabalho?',
     '["Somente conflitos pessoais entre colegas", "Aspectos da organização do trabalho, como ritmo, jornada, pressão, falta de autonomia, assédio e insegurança, que afetam a saúde mental e física e precisam constar no inventário de riscos", "Problemas trazidos de casa pelo trabalhador", "Apenas o estresse do fim do mês"]', 1, 78),

    ('Qual é a relação entre assédio moral e ergonomia?',
     '["Nenhuma, assédio é assunto exclusivo do setor de pessoal", "Assédio é apenas questão jurídica", "O assédio é um fator psicossocial do ambiente de trabalho, adoece e por isso entra na análise das condições de trabalho e nas medidas de prevenção da empresa", "Assédio só importa quando há agressão física"]', 2, 79),

    ('Hora extra habitual e jornada prolongada, do ponto de vista ergonômico:',
     '["Não interferem, porque o trabalhador é remunerado por isso", "Melhoram o desempenho, porque a pessoa entra no ritmo", "Só interferem em trabalho braçal", "Reduzem o tempo de recuperação do corpo entre as jornadas, acumulam fadiga e aumentam erro e acidente, e por isso a jornada faz parte da análise"]', 3, 80),

    ('Monitoramento eletrônico do desempenho minuto a minuto, com aviso ao trabalhador que ficar atrás:',
     '["É recomendado, porque dá retorno imediato", "É um fator psicossocial de pressão que precisa ser avaliado, porque leva o trabalhador a abrir mão de pausa, de posturas seguras e até de ir ao banheiro para não perder o indicador", "Não tem efeito sobre a saúde", "É aceitável se o trabalhador for informado"]', 1, 81),

    ('Por que a falta de autonomia sobre o método e o ritmo do trabalho é considerada um risco?',
     '["Porque atrasa a produção", "Porque desmotiva a equipe apenas", "Porque quem não pode ajustar o próprio ritmo nem a sequência da tarefa perde a margem para se recuperar durante a jornada, e o esforço se acumula", "Porque impede o trabalhador de crescer na carreira"]', 2, 82),

    ('O trabalho executado isoladamente, sem contato com colegas durante a jornada:',
     '["Não interfere na saúde, desde que a tarefa seja leve", "É sempre preferível, porque evita distração", "É mais produtivo e por isso recomendado", "É um fator de risco psicossocial e também de segurança, porque falta apoio na dificuldade e ninguém percebe uma emergência, e exige meio de comunicação e contato periódico"]', 3, 83),

    ('Ordens contraditórias de chefias diferentes e falta de clareza sobre o que é responsabilidade de quem:',
     '["São fatores psicossociais reconhecidos, geram tensão e erro, e se corrigem definindo papéis, prioridades e canal único de decisão", "São normais em qualquer empresa e não precisam de tratamento", "Só afetam cargos de liderança", "Resolvem-se com treinamento comportamental do trabalhador"]', 0, 84),

    ('O apoio da chefia e dos colegas, no estudo dos fatores psicossociais:',
     '["Não é medido, por ser subjetivo", "É um fator de proteção: onde existe suporte, a mesma exigência de trabalho adoece menos, e por isso ele entra na avaliação junto com as exigências", "É irrelevante diante do salário", "Só importa em trabalho de escritório"]', 1, 85),

    ('A pausa prevista para recuperação durante a jornada:',
     '["É diferente do intervalo de refeição e do descanso semanal: serve para interromper a exigência antes que a fadiga se instale, e por isso é distribuída ao longo da jornada", "Pode ser acumulada para sair mais cedo", "É o próprio intervalo de refeição", "É facultativa quando o trabalhador não se cansa"]', 0, 86),

    ('O rodízio de tarefas só reduz o risco de lesão quando:',
     '["As tarefas do rodízio exigem grupos musculares e posturas diferentes; trocar de posto e continuar usando o mesmo punho não alivia nada", "O rodízio acontece a cada duas horas", "Todos os trabalhadores concordam com a escala", "O rodízio inclui pelo menos quatro postos"]', 0, 87),

    ('Quando o ritmo é imposto pela velocidade da esteira ou da máquina:',
     '["A velocidade precisa ser compatível com a possibilidade real de execução da tarefa com postura segura, e ser ajustável, porque ritmo imposto elimina a pausa natural do trabalho", "O trabalhador precisa acompanhar, porque a máquina define a produção", "Basta aumentar o número de trabalhadores na linha", "Basta oferecer ginástica laboral no início do turno"]', 0, 88),

    ('Em turno noturno, a pausa para descanso:',
     '["Não é necessária, porque o movimento é menor à noite", "Deve ser menor que a do turno diurno", "É ainda mais importante, porque o organismo trabalha contra o próprio relógio biológico e a queda de atenção na madrugada é maior", "Deve ser substituída por café à vontade"]', 2, 89),

    ('O trabalhador voltou de um afastamento longo por doença. Do ponto de vista ergonômico, o correto é:',
     '["Retomar a mesma tarefa e o mesmo ritmo do primeiro dia", "Trocá-lo de setor sem avaliar a nova tarefa", "Deixá-lo escolher o que quer fazer", "Avaliar o posto e a tarefa, seguir as restrições médicas e prever retorno gradual, porque voltar ao mesmo posto sem mudança costuma reproduzir a lesão"]', 3, 90),

    ('Trabalhador treinado na tarefa faz menos esforço físico? Por quê?',
     '["Não há relação: o esforço depende só do peso", "O trabalhador treinado usa a técnica e a sequência que exigem menos esforço, enquanto o não treinado compensa com força e postura ruim", "Treinamento só serve para reduzir erro de qualidade", "O treinamento aumenta o ritmo e por isso aumenta o esforço"]', 1, 91),

    ('O trabalhador recém-admitido em posto de esforço repetitivo:',
     '["Deve começar com o mesmo ritmo dos demais para não atrasar a linha", "Deve trabalhar sozinho para aprender mais rápido", "Precisa de período de adaptação com aumento gradual do ritmo e acompanhamento, porque o corpo ainda não está adaptado à exigência e é nesse período que aparecem muitas lesões", "Só precisa assistir ao treinamento no primeiro dia"]', 2, 92),

    ('Painel visível com a produção individual de cada trabalhador em tempo real:',
     '["É um bom recurso de gestão sem qualquer efeito sobre a saúde", "Só afeta quem produz menos", "Melhora o clima da equipe", "Pode funcionar como pressão coletiva e estímulo ao ritmo excessivo, e por isso o uso desse tipo de mecanismo é avaliado dentro dos fatores psicossociais"]', 3, 93),

    ('Absenteísmo alto, muita rotatividade e queixas repetidas em um mesmo setor:',
     '["São indicadores que apontam problema na organização e nas condições de trabalho daquele setor e devem alimentar a avaliação ergonômica", "São problema exclusivo do setor de pessoal", "Indicam apenas falta de comprometimento da equipe", "Só importam quando há atestado médico"]', 0, 94),

    ('Um trabalhador relata desconforto no ombro que ainda não atrapalha o serviço. O que a empresa faz com essa informação?',
     '["Aguarda o quadro piorar para agir", "Registra e trata como sinal precoce: avalia o posto, ajusta a tarefa e encaminha ao acompanhamento médico, porque queixa precoce é a chance de evitar a lesão instalada", "Anota apenas se houver atestado", "Encaminha somente para o setor de pessoal"]', 1, 95),

    ('O que a etapa preliminar do estudo ergonômico busca identificar?',
     '["O laudo final entregue à fiscalização", "O questionário respondido pelos trabalhadores", "O levantamento inicial das situações de trabalho para identificar onde há indício de risco ergonômico; quando ela mostra que o problema exige aprofundamento, parte-se para a análise ergonômica do trabalho", "O exame médico periódico"]', 2, 96),

    ('Quando a Análise Ergonômica do Trabalho, a AET, se torna necessária?',
     '["Sempre, em todos os postos da empresa", "Somente quando a fiscalização exige", "Somente quando há processo trabalhista", "Quando a avaliação preliminar não é suficiente para concluir, quando há casos de adoecimento relacionados ao posto ou quando as medidas adotadas não resolveram o problema"]', 3, 97),

    ('Quais são as etapas de uma análise ergonômica do trabalho bem conduzida?',
     '["Apenas medir a altura da bancada e da cadeira", "Análise da demanda, análise da tarefa, observação da atividade real, diagnóstico e recomendações com plano de ação e acompanhamento", "Aplicar um questionário e emitir o laudo", "Fotografar o posto e arquivar o relatório"]', 1, 98),

    ('Qual é a diferença entre tarefa prescrita e atividade real?',
     '["A tarefa prescrita é o que a empresa determina que seja feito; a atividade real é o que o trabalhador de fato faz para dar conta, com as adaptações e improvisos que a análise precisa enxergar", "A tarefa prescrita é a do turno da manhã e a atividade real a do turno da noite", "Não há diferença quando o procedimento está escrito", "A atividade real é o que consta no procedimento"]', 0, 99),

    ('Que qualificação deve ter o profissional contratado para o estudo ergonômico?',
     '["Qualquer integrante da CIPA", "O encarregado do setor, que conhece a tarefa", "O próprio trabalhador do posto", "Profissional com formação e capacitação para isso, que conduza a análise com a participação dos trabalhadores e da equipe de segurança"]', 3, 100),

    ('As recomendações de uma análise ergonômica devem vir acompanhadas de:',
     '["Plano de ação com responsáveis, prazos e prioridade, porque recomendação sem prazo e sem dono não sai do papel", "Apenas a lista de problemas encontrados", "Apenas a assinatura do profissional", "Apenas a estimativa de custo"]', 0, 101),

    ('Depois de implantar as melhorias recomendadas, o que ainda falta?',
     '["Nada, o processo se encerra com a implantação", "Apenas arquivar o relatório", "Verificar se a melhoria realmente resolveu, ouvindo quem trabalha no posto e acompanhando os indicadores, porque solução no papel às vezes cria um problema novo", "Refazer toda a análise do zero a cada seis meses"]', 2, 102),

    ('Qual é a diferença entre ergonomia de concepção e ergonomia de correção?',
     '["Não há diferença, muda apenas o nome do relatório", "A de concepção é feita por engenheiro e a de correção por médico", "A de correção é sempre mais barata", "A de concepção entra no projeto do posto, da máquina e do layout, quando mudar ainda é barato; a de correção conserta o que já está instalado e custa mais e resolve menos"]', 3, 103),

    ('Ao comprar uma máquina ou o mobiliário de um setor novo, o critério ergonômico:',
     '["Entra depois, se aparecer queixa", "Deve estar na especificação da compra, com altura de trabalho, alcance, regulagens, esforço nos comandos, ruído e vibração definidos antes do pedido", "Depende do fornecedor escolhido", "Só se aplica a mobiliário de escritório"]', 1, 104),

    ('Qual é o papel da CIPA e do serviço de segurança na ergonomia?',
     '["Nenhum, o assunto é exclusivo do profissional que faz a análise", "Apenas assinar o relatório final", "Levantar queixas, participar do mapeamento das situações de risco, acompanhar a implantação das melhorias e cobrar os prazos do plano de ação", "Apenas divulgar a ginástica laboral"]', 2, 105),

    ('Onde os riscos ergonômicos identificados precisam ficar registrados?',
     '["Apenas no relatório da análise ergonômica", "Apenas na ata da CIPA", "Apenas no prontuário médico", "No inventário de riscos e no plano de ação do programa de gerenciamento de riscos da empresa, junto com os demais riscos ocupacionais"]', 3, 106),

    ('Ao projetar um posto para uma população de trabalhadores, o correto é:',
     '["Usar a estatura média das pessoas, porque atende a maioria", "Considerar a faixa de variação das medidas do corpo da população que vai usar o posto, prevendo regulagem, porque quase ninguém tem exatamente a medida média", "Usar as medidas do trabalhador mais alto", "Usar as medidas do trabalhador mais antigo do setor"]', 1, 107),

    ('O que significa dizer que o DORT é de origem multifatorial?',
     '["Que ele tem várias formas de tratamento", "Que ele atinge vários trabalhadores ao mesmo tempo", "Que ele resulta da combinação de força, repetição, postura, tempo de exposição, falta de pausa, frio, vibração e fatores da organização do trabalho, e não de uma causa isolada", "Que a causa é sempre alguma atividade fora do trabalho"]', 2, 108),

    ('Formigamento e dormência nos três primeiros dedos da mão, que pioram à noite, sugerem:',
     '["Apenas cansaço da jornada", "Problema de circulação sem relação com o trabalho", "Alergia à luva utilizada", "Comprometimento do nervo no punho, quadro compatível com síndrome do túnel do carpo, que exige avaliação médica e revisão da tarefa"]', 3, 109),

    ('Dor no ombro que piora ao elevar o braço acima da cabeça, em trabalhador que executa essa elevação o dia inteiro, sugere:',
     '["Quadro de tendinite do ombro relacionado à tarefa, que exige avaliação médica e mudança da altura de trabalho", "Problema exclusivamente postural do sono", "Falta de alongamento matinal apenas", "Quadro sem relação com o trabalho"]', 0, 110),

    ('Dor na parte externa do cotovelo em quem usa chave, alicate ou parafusadeira o dia inteiro sugere:',
     '["Fratura por esforço", "Epicondilite, ligada ao esforço repetido de preensão e rotação do antebraço, o que leva a revisar ferramenta, força necessária e pausas", "Problema no punho apenas", "Efeito colateral do uso de luva"]', 1, 111),

    ('A dor lombar do trabalhador pode ter origem na atividade que ele executa?',
     '["Levantamento e transporte de carga, postura sentada ou em pé prolongada sem alternância, vibração de corpo inteiro e torção do tronco são fatores que aumentam a ocorrência de dor lombar relacionada ao trabalho", "A relação existe apenas quando há levantamento de mais de 30 quilos", "A dor lombar nunca tem relação com o trabalho", "A lombalgia só aparece depois dos 50 anos"]', 0, 112),

    ('Quando uma doença é reconhecida como relacionada ao trabalho, a empresa deve:',
     '["Aguardar decisão judicial para agir", "Apenas afastar o trabalhador", "Apenas registrar no prontuário", "Emitir a comunicação de acidente de trabalho, investigar as causas no posto, corrigir a situação que gerou o quadro e acompanhar os demais trabalhadores expostos"]', 3, 113),

    ('Por que o diagnóstico precoce muda o resultado no caso das lesões relacionadas ao trabalho?',
     '["Porque reduz o valor do afastamento", "Porque na fase inicial o quadro costuma ser reversível com mudança da tarefa e tratamento, enquanto a lesão instalada pode deixar limitação permanente", "Porque evita a emissão da comunicação de acidente", "Porque diminui o número de exames necessários"]', 1, 114),

    ('No retorno de um trabalhador com restrição médica permanente, a readaptação correta é:',
     '["Colocar o trabalhador em uma função sem tarefa definida", "Manter a mesma função e pedir que ele evite os movimentos proibidos", "Analisar as tarefas disponíveis, escolher e adaptar aquela compatível com a restrição e acompanhar o resultado, com participação do serviço médico", "Aguardar a aposentadoria por invalidez"]', 2, 115),

    ('O trabalhador toma anti-inflamatório por conta própria para conseguir terminar a jornada. Isso significa que:',
     '["Ele está resolvendo o problema de forma prática", "A dor deixou de existir", "O problema é apenas individual", "O sintoma está sendo mascarado enquanto a causa continua atuando no posto, e a situação precisa ser levada ao serviço médico e à avaliação do posto"]', 3, 116),

    ('Idade, condicionamento físico e histórico de saúde do trabalhador:',
     '["Fazem parte da análise para adequar a tarefa à pessoa, mas não transferem a ele a responsabilidade pela condição de trabalho inadequada", "Explicam sozinhos o aparecimento das lesões", "Não devem ser considerados em nenhuma hipótese", "Servem para selecionar quem pode ocupar cada posto"]', 0, 117),

    ('Como o controle médico ocupacional e a ergonomia se alimentam um do outro?',
     '["O programa médico define o exame conforme os riscos levantados, e os achados clínicos e as queixas realimentam a avaliação ergonômica e o plano de ação", "Nenhuma, são programas independentes", "O programa médico substitui a análise ergonômica", "A ergonomia só entra depois do afastamento"]', 0, 118),

    ('Qual é a diferença entre fadiga muscular e lesão instalada?',
     '["Não há diferença prática", "A fadiga só aparece em trabalho pesado", "A fadiga é reversível com descanso adequado, enquanto a lesão persiste mesmo em repouso, dói fora do trabalho e exige tratamento; ignorar a fadiga repetida é o caminho para a lesão", "A lesão é sempre visível externamente"]', 2, 119),

    ('Para adaptar um posto de trabalho a um trabalhador cadeirante, é preciso:',
     '["Apenas retirar a cadeira do posto", "Apenas instalar uma rampa na entrada do setor", "Apenas rebaixar a mesa", "Prever altura livre e espaço para as pernas sob a bancada, altura de trabalho e alcance compatíveis com a posição sentada, área de manobra da cadeira e rota acessível até o posto, o banheiro e a saída de emergência"]', 3, 120),

    ('Para o trabalhador com baixa visão, a adaptação do posto envolve:',
     '["Apenas aumentar a fonte do computador", "Iluminação reforçada e sem ofuscamento, aumento de contraste, ampliação de textos e etiquetas, recursos de ampliação de tela e organização fixa dos materiais", "Transferir o trabalhador para função sem leitura", "Apenas trocar o monitor por um maior"]', 1, 121),

    ('Em um setor que emprega trabalhador surdo, o alarme de emergência precisa:',
     '["Ser mais alto que o normal", "Ser substituído por aviso no fim do turno", "Ter sinalização visual, como sinaleiro luminoso, além do sinal sonoro, e a comunicação de rotina precisa contar com recursos visuais e com quem saiba se comunicar com ele", "Ser acionado apenas pelo supervisor do setor"]', 2, 122),

    ('No plano de emergência, o trabalhador com mobilidade reduzida:',
     '["Sai por último, sem qualquer preparação", "Deve ser realocado para o térreo obrigatoriamente", "Não precisa de tratamento específico", "Precisa ter rota, apoio e responsáveis definidos previamente, com treinamento de quem vai auxiliar, porque improviso em evacuação custa vidas"]', 3, 123),

    ('Recursos como leitor de tela, teclado adaptado, mouse alternativo e software de ampliação são:',
     '["Itens de conforto opcionais", "Tecnologia assistiva que a empresa providencia como parte da adaptação razoável do posto de trabalho", "Despesa do próprio trabalhador", "Recursos que substituem a análise do posto"]', 1, 124),

    ('A rota de circulação até o posto de trabalho, do ponto de vista da acessibilidade, deve:',
     '["Estar livre de obstáculos e desníveis não sinalizados, com largura suficiente, piso regular e sinalização adequada, porque o posto acessível não resolve se o caminho até ele não for", "Ser adaptada apenas quando houver trabalhador cadeirante contratado", "Ser considerada apenas na entrada do prédio", "Ser demarcada apenas com fita no piso"]', 0, 125),

    ('Banheiros e vestiários acessíveis são assunto de ergonomia porque:',
     '["Não são: fazem parte apenas das condições sanitárias", "Só importam em prédio público", "São exigidos apenas em empresas grandes", "Fazem parte das condições de trabalho que permitem ao trabalhador com deficiência exercer a atividade em igualdade de condições, junto com o posto e a rota"]', 3, 126),

    ('Quem custeia a adaptação do posto e os recursos necessários ao trabalhador com deficiência?',
     '["A empresa, como parte da sua obrigação de adaptar as condições de trabalho às características das pessoas", "O próprio trabalhador", "O plano de saúde", "O sindicato da categoria"]', 0, 127),

    ('Na costura industrial, os pontos críticos da ergonomia são:',
     '["Apenas a iluminação da mesa", "A altura e a inclinação da mesa, o alcance do material, o acionamento do pedal, a postura do pescoço sobre a costura e a repetição do movimento das mãos e do ombro", "Apenas o modelo da cadeira", "Apenas o peso do tecido"]', 1, 128),

    ('No atendimento em guichê ou balcão, o problema ergonômico mais comum é:',
     '["A cor do balcão", "O tamanho da sala de espera", "O balcão projetado para o cliente em pé e o atendente sentado, o que obriga elevação dos ombros, flexão do pescoço e alcance forçado ao longo de toda a jornada", "A quantidade de documentos manuseados"]', 2, 129),

    ('Para o motorista profissional, além da postura, a avaliação precisa considerar:',
     '["Apenas o modelo do veículo", "Apenas o tempo de direção", "Apenas a altura do banco", "A regulagem do banco para o peso e a estatura, a vibração de corpo inteiro, o tempo em posição sentada sem pausa, o esforço no embarque e desembarque da carga e a jornada com espera"]', 3, 130),

    ('Na limpeza predial, o que costuma gerar mais sobrecarga?',
     '["Cabo de rodo e vassoura curto demais, que obriga a curvar a coluna, além do peso do balde, da torção ao esfregar e do trabalho com os braços acima dos ombros ao limpar vidros", "Apenas o produto de limpeza utilizado", "Apenas o uniforme fornecido", "Apenas o horário do serviço"]', 0, 131),

    ('Que aspectos pesam na ergonomia de uma cozinha industrial?',
     '["Apenas o calor do fogão", "Altura das bancadas e do fogão, peso de panelas e caldeirões, alcance nas prateleiras, tempo em pé sobre piso duro e molhado, e o esforço de abrir e transportar embalagens grandes", "Apenas a quantidade de refeições por dia", "Apenas o tipo de faca utilizada"]', 1, 132),

    ('Na enfermagem, a transferência de paciente entre cama e maca é crítica porque:',
     '["A carga é leve mas repetitiva apenas", "O problema é somente o horário do plantão", "É uma carga pesada, instável e imprevisível, longe do corpo e em altura ruim, o que exige equipamento de transferência, trabalho em equipe e regulagem da altura da cama", "O problema é apenas o piso escorregadio"]', 2, 133),

    ('No almoxarifado, guardar itens pesados na prateleira mais alta:',
     '["É correto, porque libera espaço embaixo", "É indiferente, desde que haja escada", "É melhor para a organização visual", "Cria risco de queda de material e obriga o levantamento acima dos ombros sobre escada, e por isso o peso maior fica na faixa entre o quadril e o ombro"]', 3, 134),

    ('Como reduzir a sobrecarga do ombro e do pescoço de quem solda com os braços acima da cabeça?',
     '["Dispositivo que permita girar ou posicionar a peça, plataforma que aproxime a tarefa, revezamento e pausas, porque a postura sobrecabeça sustentada é uma das mais lesivas para o ombro e o pescoço", "Apenas máscara mais leve", "Apenas alongamento no início do turno", "Apenas mudar o tipo de eletrodo"]', 0, 135),

    ('Trabalho com notebook e tablet em campo, fora do escritório:',
     '["Não precisa de cuidado, porque o uso é eventual", "Basta trabalhar sentado no veículo", "Exige planejamento do apoio, do tempo de uso contínuo e do local de trabalho, porque o improviso sobre o colo, o capô ou uma caixa mantém o pescoço fletido e os braços sem apoio", "Basta reduzir o brilho da tela"]', 2, 136),

    ('Na recepção, o posto costuma falhar quando:',
     '["A sala é pequena demais", "Falta um segundo telefone", "O ambiente é climatizado", "O balcão é alto, a tela fica fora da linha dos olhos, não há espaço para as pernas sob o tampo e o trabalhador precisa alternar entre atender de pé e digitar sentado sem regulagem"]', 3, 137),

    ('No trabalho do professor, os fatores ergonômicos incluem:',
     '["Apenas o número de alunos por turma", "Permanência prolongada em pé, uso intenso da voz com ruído de fundo, escrita em quadro com braço elevado e a organização da jornada com aulas seguidas sem pausa", "Apenas a altura da mesa da sala dos professores", "Apenas o material didático utilizado"]', 1, 138),

    ('Para quem faz coleta ou carregamento com deslocamento contínuo, a avaliação considera:',
     '["O peso por volume, a frequência, a distância percorrida com a carga, a altura de pega e de depósito, o piso do percurso e o total acumulado ao longo da jornada", "Apenas o número de horas trabalhadas", "Apenas o peso de cada volume", "Apenas a temperatura do dia"]', 0, 139),

    ('Manutenção com ferramenta pesada acionada acima da cabeça exige:',
     '["Apenas trabalhador mais forte na equipe", "Apenas luva antivibração", "Apenas troca de ferramenta a cada hora", "Balancim, braço articulado ou suporte que sustente o peso da ferramenta, plataforma que aproxime a tarefa e revezamento, porque somam-se peso, vibração e postura sobrecabeça"]', 3, 140),

    ('Em atividade de digitação intensa, a avaliação precisa considerar:',
     '["Apenas o modelo do teclado", "A quantidade de toques ao longo da jornada, o tempo de digitação contínua, a distribuição das pausas, o apoio dos antebraços e a possibilidade de alternar com outras tarefas", "Apenas a velocidade média do digitador", "Apenas o tamanho da tela"]', 1, 141),

    ('Trabalho com lupa, microscópio ou inspeção de peça pequena provoca:',
     '["Apenas cansaço visual, sem outra consequência", "Nenhum problema, porque o esforço físico é baixo", "Postura estática do pescoço e do tronco por longos períodos somada à fadiga visual, e por isso o equipamento precisa ser regulável e o trabalho intercalado com outras tarefas e pausas", "Problema apenas para quem usa óculos"]', 2, 142),

    ('Em linha de montagem com bancada de altura fixa para toda a equipe:',
     '["O problema não existe, porque todos executam a mesma tarefa", "Basta escolher a altura pela pessoa mais alta", "Basta oferecer uma cadeira para quem preferir", "As pessoas mais baixas trabalham com os ombros elevados e as mais altas curvadas, e a correção é bancada regulável ou estrado individual ajustável na altura"]', 3, 143),

    ('Em sala de controle com monitoramento de telas por longos períodos:',
     '["Basta manter a sala climatizada", "A avaliação envolve iluminação sem reflexo nas telas, mobiliário regulável, alternância de tarefas, distribuição das pausas e a organização do turno, porque a exigência é de atenção sustentada com pouco movimento", "O único ponto de atenção é o tamanho das telas", "Não há risco ergonômico, porque o esforço físico é mínimo"]', 1, 144),

    ('Um teleatendente acabou de encerrar uma ligação com agressão verbal do cliente. O correto é:',
     '["Passar imediatamente para a próxima ligação, para não formar fila", "Descontar o tempo perdido no intervalo", "Permitir pausa para recuperação após o atendimento, ter um canal para registro e acolhimento do episódio e considerar essa exposição na organização do trabalho", "Registrar apenas no indicador de qualidade"]', 2, 145),

    ('No trabalho de cuidador de pessoa idosa ou com mobilidade reduzida, a prevenção passa por:',
     '["Apenas orientar a técnica de levantamento", "Apenas contratar profissional mais forte", "Apenas oferecer cinta abdominal", "Equipamento de transferência e apoio, altura regulável da cama e do banho, trabalho em dupla quando necessário e organização da jornada, além do reconhecimento da carga emocional da atividade"]', 3, 146),

    ('Na colheita e em outras atividades agrícolas executadas agachado ou curvado:',
     '["A postura é inerente à tarefa e não há o que fazer", "As medidas possíveis incluem banqueta ou carrinho baixo, ferramenta de cabo longo, rodízio entre tarefas, pausas programadas e sombra e água no local, além de rever a organização do ritmo por produção", "Basta oferecer alongamento antes do início", "Basta reduzir o número de horas por dia"]', 1, 147),

    ('Na arrumação de quartos em hotel, os pontos críticos são:',
     '["Apenas o número de quartos por dia", "Apenas o peso do carrinho de roupas", "A postura curvada para arrumar a cama, o esforço para mover colchão e móveis, a repetição do movimento e a meta de quartos por jornada, que define o ritmo e a possibilidade de pausa", "Apenas o produto de limpeza usado"]', 2, 148),

    ('No trabalho remoto permanente, a empresa deve:',
     '["Considerar o assunto encerrado ao entregar o notebook", "Cobrar apenas o resultado, sem se envolver com o posto", "Exigir que o trabalhador monte o posto por conta própria", "Orientar sobre a montagem do posto, fornecer ou custear os itens necessários conforme o acordado, tratar da jornada e do direito à desconexão e manter canal para queixas de desconforto"]', 3, 149),

    ('Como saber se uma melhoria ergonômica implantada realmente funcionou?',
     '["Verificando se as queixas do posto diminuíram, se os indicadores de afastamento e de erro melhoraram e se quem trabalha ali confirma que a tarefa ficou mais fácil, e não apenas se o item foi comprado e instalado", "Pelo valor investido na melhoria", "Pela quantidade de itens trocados no setor", "Pela assinatura do relatório de conclusão"]', 0, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-17';


-- =====================================================================
--  NR-26 — Sinalização de segurança (questões 41 a 150)
--  As 40 antigas fecharam as cores principais, a forma das placas e boa
--  parte dos pictogramas. Estas 110 vão para o que sobra e é cobrado em
--  campo: as cores que ninguém decora, a identificação de tubulação
--  produto por produto, os nove pictogramas do sistema globalmente
--  harmonizado, o rótulo e a ficha de segurança seção por seção, a
--  sinalização de emergência, a de obra e a delimitação de área. E o
--  limite da coisa toda: sinalização avisa, não protege, e cor sozinha
--  não serve para quem não distingue cor.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-26')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Que uso o padrão de cores de segurança reserva ao preto?',
     '["Identificar coletores de resíduos e, em conjunto com o amarelo, formar a faixa de advertência", "Identificar equipamentos de combate a incêndio", "Sinalizar rotas de fuga", "Identificar tubulação de vapor"]', 0, 41),

    ('Em que situação a norma prevê o emprego da cor púrpura?',
     '["Áreas de armazenamento de inflamáveis", "Perigos decorrentes de radiações ionizantes, como portas de salas de irradiação e recipientes de material radioativo", "Piso escorregadio", "Equipamentos em manutenção"]', 1, 42),

    ('Que produto circula, em geral, por uma tubulação identificada em lilás?',
     '["Álcalis", "Vapor de baixa pressão", "Água potável", "Ar comprimido"]', 0, 43),

    ('Uma linha pintada em alumínio, na identificação de tubulação, costuma corresponder a:',
     '["Vapor e gases liquefeitos inflamáveis, conforme a identificação adotada pela empresa", "Ácidos", "Gases inertes", "Água de combate a incêndio"]', 0, 44),

    ('Onde se emprega a cor cinza dentro do padrão de cores de segurança?',
     '["Coletores de resíduos recicláveis", "Identificar eletrodutos e, em tonalidades distintas, canalizações em vácuo ou equipamentos fora de uso", "Rota de fuga", "Chuveiro de emergência"]', 1, 45),

    ('Que família de produtos costuma circular por uma linha marrom?',
     '["Óleos e materiais minerais combustíveis", "Água potável", "Gás inerte", "Ar comprimido"]', 0, 46),

    ('Em uma indústria, a tubulação pintada de vermelho está associada a qual finalidade?',
     '["Água quente do processo", "Esgoto industrial", "Água ou agente de combate a incêndio", "Produto corrosivo"]', 2, 47),

    ('O que circula, normalmente, por uma linha industrial identificada em verde?',
     '["Gases inflamáveis", "Vapor superaquecido", "Ácidos concentrados", "Água que não é destinada ao combate a incêndio"]', 3, 48),

    ('A tubulação de ar comprimido costuma ser identificada pela cor:',
     '["Azul", "Verde", "Laranja", "Marrom"]', 0, 49),

    ('Que cor identifica, na tubulação industrial, os gases não liquefeitos?',
     '["Branca", "Amarela", "Verde", "Lilás"]', 1, 50),

    ('Encontrando uma linha pintada de laranja na planta, o operador deve esperar qual produto?',
     '["Água potável", "Vapor", "Ácidos", "Ar comprimido"]', 2, 51),

    ('Uma área foi repintada e a cor das tubulações não corresponde mais ao produto que elas conduzem. O correto é:',
     '["Considerar o problema apenas estético e seguir pela memória da equipe", "Anotar a divergência e resolver na próxima parada", "Marcar as linhas com fita crepe e o nome escrito à mão", "Tratar como risco imediato: identificar as linhas com o responsável pela área, refazer a identificação conforme o padrão e restringir manobras até a correção, porque cor errada orienta o operador a abrir a válvula errada"]', 3, 52),

    ('Em que pontos da tubulação a faixa de identificação precisa aparecer?',
     '["Junto às válvulas, nas entradas e saídas de equipamentos, nas mudanças de direção, nas travessias de parede e em intervalos regulares ao longo do trecho", "Somente onde a tubulação sai do chão", "Somente na entrada do galpão", "Somente na sala de controle"]', 0, 53),

    ('A identificação por cor pode ser o único meio de indicar um risco?',
     '["Sim, porque a cor é reconhecida de longe", "Sim, quando todos os trabalhadores foram treinados nas cores", "Sim, desde que a cor esteja no procedimento escrito", "Não: a cor é complementar e precisa vir acompanhada de rótulo, legenda, símbolo ou aviso escrito, até porque parte da população não distingue determinadas cores"]', 3, 54),

    ('O que costuma estar identificado por uma placa de fundo vermelho com desenho branco?',
     '["Rota de fuga", "Equipamento de combate a incêndio, como extintor, hidrante ou acionador de alarme", "Uso obrigatório de EPI", "Advertência de perigo"]', 1, 55),

    ('Em que locais a proibição de fumar tem de estar afixada?',
     '["Somente na portaria da empresa", "Somente no refeitório", "Nos locais onde há risco de incêndio ou explosão, como áreas de armazenamento e manuseio de inflamáveis, abastecimento e carregamento de bateria, além dos ambientes fechados de uso coletivo", "Somente onde houver reclamação de trabalhadores"]', 2, 56),

    ('O símbolo do raio dentro do triângulo amarelo aparece em quais equipamentos e avisa o quê?',
     '["Local com bateria descarregada", "Ponto de aterramento", "Estação de recarga de equipamento", "Risco de choque elétrico, usada em quadros, painéis, transformadores e cabines"]', 3, 57),

    ('A placa de uso obrigatório de EPI colocada na entrada do setor serve para:',
     '["Informar quem entra sobre qual proteção é exigida naquela área, antes de a pessoa se expor ao risco", "Registrar quais equipamentos o setor já recebeu", "Substituir o treinamento sobre EPI", "Indicar onde os EPI ficam guardados"]', 0, 58),

    ('Por que a placa de segurança traz símbolo e texto juntos?',
     '["Para preencher melhor o espaço da placa", "Porque nem todo mundo interpreta o símbolo sem apoio, e nem todo mundo lê com facilidade; a combinação aumenta a chance de a mensagem ser compreendida", "Porque a norma obriga duas informações por placa", "Porque o texto substitui o treinamento"]', 1, 59),

    ('O tamanho de uma placa de sinalização deve ser definido por:',
     '["Espaço disponível na parede", "Padrão único para toda a empresa", "Distância a partir da qual ela precisa ser lida e compreendida, porque placa pequena a dez metros não sinaliza nada", "Custo do material"]', 2, 60),

    ('Por que a sinalização da rota de fuga costuma ser fotoluminescente?',
     '["Para ficar mais bonita no corredor", "Para durar mais tempo sem desbotar", "Para reduzir o consumo de energia do prédio", "Para continuar visível quando falta energia ou quando a fumaça reduz a iluminação, que é justamente quando ela é necessária"]', 3, 61),

    ('A placa que informa a carga máxima de um mezanino, de uma prateleira ou de um elevador de carga:',
     '["É sinalização de segurança e precisa ficar visível no ponto de carregamento, porque quem carrega não tem como calcular o limite na hora", "Só é exigida em estruturas metálicas", "É apenas informativa e pode ser ignorada quando a carga parece leve", "Só vale para o setor de logística"]', 0, 62),

    ('A sinalização de altura livre ou gabarito na entrada de um galpão serve para:',
     '["Indicar a altura do prédio para o corpo de bombeiros", "Avisar o motorista sobre o limite de altura do veículo ou da carga, evitando colisão com viga, portão, tubulação ou rede elétrica", "Indicar a altura das prateleiras internas", "Marcar o nível do piso"]', 1, 63),

    ('Degraus isolados, rampas e desníveis no piso devem ser:',
     '["Deixados como estão, porque a pessoa enxerga", "Marcados apenas no primeiro dia de uso da área", "Sinalizados com contraste visual na borda, iluminação adequada e, quando possível, corrimão, porque desnível não percebido é uma das causas mais comuns de queda no mesmo nível", "Sinalizados apenas em ambientes externos"]', 2, 64),

    ('No losango de perigo, a chama desenhada acima de um círculo aponta para qual característica do produto?',
     '["É oxidante, ou seja, pode provocar ou intensificar o fogo em outros materiais", "É explosivo", "É corrosivo para a pele", "É inflamável por contato com a água"]', 0, 65),

    ('O pictograma que mostra uma bomba explodindo indica:',
     '["Produto explosivo ou substância autorreativa capaz de explodir", "Produto sob pressão", "Produto que reage com metais", "Produto com risco de incêndio apenas"]', 0, 66),

    ('Que perigos o ponto de exclamação dentro do losango reúne?',
     '["Risco de morte imediata por ingestão", "Perigos como irritação da pele e dos olhos, toxicidade aguda de menor gravidade, sensibilização da pele ou efeito narcótico", "Perigo exclusivo ao meio ambiente", "Produto radioativo"]', 1, 67),

    ('Qual é a forma e a cor dos pictogramas de perigo do sistema globalmente harmonizado?',
     '["Círculo azul com símbolo branco", "Triângulo amarelo com borda preta", "Losango com borda vermelha, fundo branco e símbolo preto", "Retângulo verde com símbolo branco"]', 2, 68),

    ('O que são as frases de perigo, as chamadas frases H, presentes no rótulo?',
     '["O nome comercial e o número do lote", "As instruções de descarte da embalagem", "A lista dos componentes do produto", "Frases padronizadas que descrevem a natureza do perigo do produto, como provoca queimadura severa à pele ou nocivo se inalado"]', 3, 69),

    ('E as frases de precaução, as chamadas frases P?',
     '["Indicam o que fazer para prevenir, como responder em caso de acidente, como armazenar e como descartar o produto", "Indicam o preço e o prazo de validade", "Indicam a fórmula química do produto", "Indicam apenas o telefone do fabricante"]', 0, 70),

    ('Quais palavras de advertência existem na rotulagem preventiva do sistema globalmente harmonizado?',
     '["Cuidado e Alerta", "Perigo e Atenção, sendo Perigo usada para as categorias mais graves", "Risco e Aviso", "Grave, Moderado e Leve"]', 1, 71),

    ('Além dos perigos, o rótulo do produto químico precisa trazer:',
     '["A identificação do fornecedor, com nome, endereço e telefone, para que se possa buscar informação em uma emergência", "Apenas o pictograma", "Apenas o nome do produto", "Apenas a data de fabricação"]', 0, 72),

    ('Um frasco pequeno de laboratório não comporta o rótulo completo. Como proceder?',
     '["Deixar sem rótulo, já que fica no laboratório", "Escrever só a fórmula química", "Usar apenas o pictograma", "Usar rótulo reduzido com as informações essenciais de identificação e perigo, mantendo a informação completa acessível no local, como a ficha de segurança"]', 3, 73),

    ('Qual é a diferença entre o rótulo e a ficha com dados de segurança?',
     '["Não há diferença, um é resumo do outro sem consequência prática", "O rótulo acompanha a embalagem e traz a informação imediata do perigo; a ficha é o documento completo, com propriedades, medidas de controle, primeiros socorros e conduta em emergência", "A ficha vai na embalagem e o rótulo fica arquivado", "O rótulo é do fabricante e a ficha é do transportador"]', 1, 74),

    ('Em uma emergência com produto químico, quais informações da ficha de segurança são consultadas primeiro?',
     '["A composição e as propriedades físicas", "Os dados de transporte e as informações regulamentares", "As medidas de primeiros socorros, de combate a incêndio e de controle de derramamento", "A estabilidade e a reatividade"]', 2, 75),

    ('FDS e FISPQ são a mesma coisa?',
     '["Não, a FISPQ é resumida e a FDS é completa", "Não, uma é do fabricante e a outra do usuário", "Não, a FISPQ vale apenas para transporte", "Sim: é o mesmo documento, e o nome ficha com dados de segurança passou a ser adotado com a atualização da norma técnica que padroniza o formato"]', 3, 76),

    ('Que informação a seção da ficha de segurança sobre controle de exposição e proteção individual traz?',
     '["Os limites de exposição do produto e o equipamento de proteção indicado para cada tipo de manuseio, além das medidas de controle de engenharia", "O preço e as condições de fornecimento", "O histórico de acidentes com o produto", "A lista dos clientes do fabricante"]', 0, 77),

    ('Chegou um produto químico e o fornecedor não mandou a ficha de segurança. O que fazer?',
     '["Usar o produto e cobrar a ficha depois", "Não liberar o produto para uso e exigir a ficha do fornecedor, porque sem ela não há como definir o EPI, o armazenamento e a conduta em emergência", "Buscar na internet uma ficha de produto parecido", "Escrever uma ficha própria com base no rótulo"]', 1, 78),

    ('A ficha de segurança arquivada no setor é de uma versão antiga do produto. O que fazer?',
     '["Manter, porque produto químico não muda", "Rasgar e trabalhar sem ficha", "Solicitar ao fornecedor a versão atualizada e substituir a que está em uso, conferindo se a classificação ou as recomendações mudaram", "Anotar as mudanças à mão na ficha antiga"]', 2, 79),

    ('O recipiente que recebe resíduo perigoso, como solvente usado, borra de tinta ou embalagem contaminada, precisa de:',
     '["Apenas uma tampa", "Apenas a palavra lixo escrita", "Apenas a cor do coletor", "Identificação do resíduo, do perigo associado e da destinação, além de ficar em área controlada e com contenção, porque o resíduo mantém o perigo do produto original"]', 3, 80),

    ('O extintor fica identificado de que forma no setor?',
     '["Apenas a placa na parede", "A placa acima do equipamento, visível de longe, e a demarcação no piso que mantém a área de acesso livre", "Apenas a demarcação no piso", "Apenas a numeração de patrimônio do extintor"]', 1, 81),

    ('Por que a placa de identificação do extintor é colocada acima do equipamento, em posição elevada?',
     '["Para continuar visível quando há material empilhado, pessoas na frente ou fumaça na parte baixa do ambiente", "Porque a norma define uma altura fixa por estética", "Para não sujar com o manuseio", "Para permitir a leitura do número do patrimônio"]', 0, 82),

    ('Como se sinaliza o abrigo de hidrante e de mangueira dentro da planta?',
     '["Ser feita apenas na planta do prédio", "Ser colocada apenas na parede interna do abrigo", "Ser refeita anualmente", "Identificar o abrigo de forma visível, com a área de acesso desobstruída e demarcada, porque hidrante bloqueado por material é hidrante inexistente"]', 3, 83),

    ('O acionador manual de alarme de incêndio precisa de:',
     '["Sinalização visível, acesso desobstruído e instalação em ponto do caminho de saída, para que qualquer pessoa consiga acionar ao evacuar", "Sinalização apenas na sala de segurança", "Instalação exclusivamente na portaria", "Chave de acesso controlada pelo supervisor"]', 0, 84),

    ('Qual é a relação entre a iluminação de emergência e a sinalização de rota de fuga?',
     '["Nenhuma, são sistemas independentes", "A iluminação de emergência garante que a rota e a sinalização continuem visíveis quando falta energia, e por isso as duas são projetadas em conjunto e testadas periodicamente", "A iluminação substitui as placas de rota", "As placas substituem a iluminação quando são fotoluminescentes"]', 1, 85),

    ('Onde e como o ponto de encontro fica indicado?',
     '["Ser instalada apenas dentro do prédio", "Ser trocada a cada simulado", "Estar visível na área externa escolhida, em local seguro e afastado da edificação, e ser conhecida por todos os trabalhadores e visitantes", "Ficar apenas no plano de emergência arquivado"]', 2, 86),

    ('O chuveiro de emergência e o lava-olhos exigem, além da placa de identificação:',
     '["Apenas a verificação anual da tubulação", "Apenas o registro em planta", "Apenas a limpeza mensal", "Caminho livre e sinalizado até o equipamento, demarcação da área de acesso e teste periódico, porque quem foi atingido por produto químico chega ali com a visão comprometida"]', 3, 87),

    ('A porta corta-fogo com a placa que orienta mantê-la fechada:',
     '["Pode ficar aberta durante o expediente para facilitar a circulação", "Pode ser escorada com um calço quando o fluxo é grande", "Precisa permanecer fechada e desobstruída, porque aberta ela deixa de conter fumaça e fogo, e a placa não vale nada se a prática for outra", "Só precisa ficar fechada à noite"]', 2, 88),

    ('Uma placa de saída de emergência aponta para uma porta que está trancada por fora. Isso é:',
     '["Uma situação grave: a sinalização direciona pessoas para uma saída inexistente, e a porta da rota de fuga precisa abrir sempre pelo lado de dentro sem chave", "Aceitável fora do horário de expediente", "Aceitável se houver outra saída no prédio", "Aceitável, porque a chave fica na portaria"]', 0, 89),

    ('Na escada de emergência de prédio com vários pavimentos, a sinalização deve indicar:',
     '["O pavimento em que a pessoa está, o sentido de saída e o pavimento de descarga, porque quem desce sob estresse perde a referência", "Apenas o número de degraus", "Apenas a direção da descida", "Apenas a capacidade máxima da escada"]', 0, 90),

    ('Quando se usa fita zebrada e quando se usa barreira física para isolar uma área?',
     '["A fita serve para qualquer situação, porque delimita visualmente", "A fita sinaliza e adverte em situações temporárias e de baixa gravidade; quando há risco de queda, de projeção ou de atropelamento, é preciso barreira física, grade ou tapume, porque fita não segura ninguém", "A barreira física só é exigida em obra pública", "Fita e barreira são equivalentes se houver placa junto"]', 1, 91),

    ('Uma área abaixo de um serviço com risco de queda de material precisa de:',
     '["Apenas uma placa de aviso na entrada", "Apenas orientação verbal aos trabalhadores do setor", "Isolamento físico da projeção da área, sinalização e, quando necessário, proteção superior tipo bandeja ou tela, com alguém controlando o acesso", "Apenas fita zebrada em dois pontos"]', 2, 92),

    ('Cones e cavaletes usados em via interna da empresa servem para:',
     '["Decorar a área de manobra", "Marcar o local de estacionamento dos veículos da diretoria", "Substituir a demarcação permanente do piso", "Canalizar a circulação e advertir sobre obstáculo, obra ou desvio temporário, e devem ser retirados assim que a situação se encerra"]', 3, 93),

    ('Obra que segue depois do anoitecer: o que muda na sinalização?',
     '["Apenas as mesmas placas usadas de dia", "Dispositivos refletivos e luz de advertência intermitente, porque à noite a placa comum sem iluminação simplesmente não é vista", "Apenas iluminação geral do canteiro", "Apenas um vigia com lanterna"]', 1, 94),

    ('Quando uma obra ocupa a calçada, a sinalização precisa:',
     '["Apenas avisar que há obra no local", "Apenas colocar fita nas duas pontas do trecho", "Indicar e garantir um desvio seguro para o pedestre, protegido do trânsito de veículos e da queda de material, com piso regular e acessível", "Orientar o pedestre a atravessar a rua por conta própria"]', 2, 95),

    ('O tapume da obra tem função de:',
     '["Apenas divulgar a marca da construtora", "Apenas evitar o furto de material", "Apenas delimitar o terreno para efeito de medição", "Isolar fisicamente a obra da via e das áreas vizinhas, protegendo terceiros da projeção de material, e por isso precisa de altura, fixação e sinalização adequadas"]', 3, 96),

    ('O trabalhador que orienta a manobra de um veículo ou equipamento, o chamado sinaleiro, precisa:',
     '["Apenas segurar uma bandeira vermelha", "Ser capacitado, usar vestimenta de alta visibilidade, adotar sinais combinados previamente com o operador e permanecer sempre no campo de visão dele, fora da rota da manobra", "Ficar atrás do veículo, para enxergar melhor o obstáculo", "Ser qualquer trabalhador que estiver livre no momento"]', 1, 97),

    ('Escavação e vala aberta em área de circulação exigem:',
     '["Apenas terra empilhada na borda como aviso", "Apenas uma placa de aviso na entrada da obra", "Isolamento físico em todo o perímetro, sinalização visível de dia e de noite, e passagem sinalizada com guarda-corpo quando houver travessia", "Apenas cobrir com tábuas soltas no fim do dia"]', 2, 98),

    ('A área abaixo de um andaime em uso precisa ser:',
     '["Liberada para circulação, desde que os trabalhadores usem capacete", "Sinalizada apenas quando o serviço envolve solda", "Isolada apenas no primeiro dia de montagem", "Isolada e sinalizada durante a montagem, o uso e a desmontagem, porque ferramenta e material caem e o capacete de quem passa não resolve o impacto de qualquer peça"]', 3, 99),

    ('Durante o içamento de carga, a sinalização do local deve:',
     '["Delimitar e isolar toda a área de projeção da carga e da lança, com controle de acesso, porque ninguém pode permanecer ou circular sob carga suspensa", "Ser feita apenas pelo operador com a buzina", "Se limitar a um aviso por rádio", "Cobrir apenas o ponto de partida da carga"]', 0, 100),

    ('Uma chapa de piso foi removida para manutenção e deixou um vão aberto. A sinalização correta é:',
     '["Uma placa de aviso na porta do setor", "Marcar com giz o contorno do vão", "Uma fita amarrada em dois pontos próximos", "Fechamento provisório resistente e fixado ou guarda-corpo em todo o contorno, com sinalização, porque abertura de piso não se resolve com aviso"]', 3, 101),

    ('Serviço executado em via pública, como manutenção de rede ou de tubulação, exige:',
     '["Apenas o cone na frente do veículo", "Sinalização de aproximação com antecedência suficiente para a velocidade da via, canalização do trânsito com cones e dispositivos, sinalização noturna e vestimenta de alta visibilidade para a equipe", "Apenas o pisca-alerta do veículo ligado", "Apenas a comunicação prévia ao órgão de trânsito"]', 1, 102),

    ('Por que a sinalização não pode depender apenas da cor para transmitir a informação de segurança?',
     '["Porque a tinta desbota com o tempo", "Porque a cor encarece a placa", "Porque parte da população não distingue determinadas cores e porque em baixa iluminação ou com fumaça a cor se perde, e por isso se usa também forma, símbolo e texto", "Porque as cores variam de país para país"]', 2, 103),

    ('Colocar uma placa de advertência sobre um risco que poderia ser eliminado:',
     '["Resolve a situação, porque o trabalhador foi avisado", "Transfere a responsabilidade para o trabalhador", "É a medida mais econômica e por isso a preferida", "Não substitui a obrigação de eliminar ou controlar o risco: a sinalização é medida complementar, e placa em cima de risco evitável é problema adiado"]', 3, 104),

    ('Uma sinalização provisória foi instalada há oito meses e continua no lugar. Isso indica que:',
     '["A sinalização provisória virou permanente sem que a situação tenha sido resolvida, e é preciso rever a causa e adotar a solução definitiva", "A sinalização está cumprindo bem a sua função", "Basta trocar a placa por uma de material mais durável", "Não há problema, desde que a placa esteja legível"]', 0, 105),

    ('Uma máquina passou por manutenção e está em teste, com movimento eventual. A sinalização adequada é:',
     '["Nenhuma, porque a máquina está sob controle da manutenção", "Apenas a etiqueta de bloqueio antiga que já estava lá", "Sinalização e isolamento indicando equipamento em teste, com aviso de que pode entrar em movimento sem aviso prévio e controle de quem pode se aproximar", "Apenas comunicar verbalmente o operador do turno"]', 2, 106),

    ('A etiqueta que identifica um equipamento como impedido de operar precisa informar:',
     '["Quem colocou, quando, por qual motivo e como localizar essa pessoa, porque etiqueta anônima ninguém sabe se pode retirar", "Apenas a data", "Apenas o nome do setor", "Apenas a palavra bloqueado"]', 0, 107),

    ('Amostras e frascos de uso interno em laboratório ou controle de qualidade:',
     '["Não precisam de identificação, porque circulam pouco", "Precisam ser identificados com o conteúdo e o perigo, mesmo em uso interno, porque frasco sem identificação é a origem clássica de intoxicação e de mistura acidental", "Podem ser identificados apenas com um número de controle", "Podem ficar sem tampa se o uso for imediato"]', 1, 108),

    ('A área de armazenamento de inflamáveis precisa de sinalização que:',
     '["Indique a proibição de fonte de ignição, o perigo do material armazenado, a proibição de fumar e a localização dos equipamentos de combate a incêndio e de contenção", "Informe apenas a quantidade armazenada", "Informe apenas o nome do responsável", "Indique apenas o horário de acesso"]', 0, 109),

    ('No almoxarifado de produtos químicos, a sinalização precisa considerar:',
     '["Apenas a ordem alfabética dos produtos", "Apenas a data de entrada de cada lote", "Apenas o volume de cada embalagem", "A incompatibilidade entre produtos, sinalizando e separando fisicamente o que não pode ser armazenado junto, como oxidante com inflamável e ácido com base"]', 3, 110),

    ('A carga máxima de uma prateleira ou porta-palete precisa estar sinalizada porque:',
     '["Facilita o inventário do estoque", "Quem carrega não tem como estimar o limite estrutural, e a sobrecarga leva ao colapso da estrutura sobre quem estiver por perto", "É exigência apenas do fornecedor da estante", "Ajuda no cálculo do seguro"]', 1, 111),

    ('A identificação das válvulas de uma linha de processo deve informar:',
     '["Apenas o número de patrimônio", "Apenas o produto que passa pela linha", "O produto, a função da válvula e, quando aplicável, a posição normal de operação, porque manobrar a válvula errada é um dos erros mais frequentes e mais graves em planta industrial", "Apenas a data da última manutenção"]', 2, 112),

    ('O quadro elétrico precisa de qual sinalização?',
     '["Apenas o adesivo de risco de choque", "Apenas o nome do setor atendido", "Apenas a identificação do responsável pela manutenção", "Advertência de risco elétrico, identificação da tensão, identificação de cada circuito e disjuntor e a proibição de obstruir o acesso, com a área em frente demarcada e livre"]', 3, 113),

    ('A entrada de um espaço confinado precisa de sinalização que:',
     '["Informe apenas a profundidade do espaço", "Identifique o local como espaço confinado, advirta sobre o risco de morte e proíba a entrada de pessoas não autorizadas, permanecendo mesmo quando o espaço está fechado e sem serviço", "Seja instalada apenas durante a execução do serviço", "Informe apenas o nome do supervisor de entrada"]', 1, 114),

    ('A área de solda precisa de qual sinalização e proteção?',
     '["Apenas uma placa de uso obrigatório de máscara", "Apenas a demarcação do piso", "Biombos ou cortinas que barrem a radiação do arco, mais sinalização de advertência e delimitação da área, protegendo quem passa e quem trabalha por perto", "Apenas o aviso verbal aos colegas antes de abrir o arco"]', 2, 115),

    ('A sinalização de área com nível de ruído elevado deve:',
     '["Ser instalada apenas dentro da sala das máquinas", "Ser substituída pela entrega do protetor auricular", "Indicar apenas o nível medido em decibéis", "Delimitar a área, indicar a obrigatoriedade do protetor auricular e ficar na entrada, para que a pessoa coloque a proteção antes de entrar e não depois de já ter se exposto"]', 3, 116),

    ('Equipamentos que emitem radiação não ionizante, como fornos de micro-ondas industriais e antenas de radiofrequência, exigem:',
     '["Sinalização de advertência, delimitação da zona de exposição e controle de acesso enquanto o equipamento opera", "Apenas manutenção anual", "Nenhuma sinalização, porque a radiação não é ionizante", "Apenas o aviso no manual do equipamento"]', 0, 117),

    ('A sala ou o equipamento com laser de potência precisa de:',
     '["Apenas óculos disponíveis na entrada", "Sinalização de advertência na porta e no equipamento, indicando a classe do laser, controle de acesso durante a operação e a exigência de proteção ocular específica", "Apenas a orientação verbal ao operador", "Apenas cortina escura na janela"]', 1, 118),

    ('Cilindros de gás armazenados precisam ter sinalizado:',
     '["Apenas a data da última recarga", "Apenas o nome do fornecedor", "O gás contido e a condição de cheio ou vazio, com separação por tipo de gás e sinalização da área, porque trocar um cilindro pelo outro em serviço a quente é acidente grave", "Apenas o peso do cilindro"]', 2, 119),

    ('Um veículo ou empilhadeira parado para manutenção na área operacional deve receber:',
     '["Apenas a chave retirada do contato", "Apenas o aviso ao encarregado do turno", "Apenas um cone na frente", "Sinalização visível de equipamento impedido de operar, com identificação de quem o retirou de serviço, além do isolamento da área ao redor"]', 3, 120),

    ('O treinamento admissional precisa incluir a sinalização da empresa porque:',
     '["A norma exige uma carga horária mínima sobre cores", "Placa que a pessoa não sabe interpretar não sinaliza nada, e o trabalhador novo precisa reconhecer as cores, os símbolos e o significado das placas da área em que vai trabalhar", "É uma forma de ocupar o tempo da integração", "Serve para avaliar a memória do candidato"]', 1, 121),

    ('A sinalização instalada precisa ser inspecionada periodicamente para verificar:',
     '["Apenas se as placas continuam limpas", "Apenas a quantidade instalada por setor", "Se continua legível, visível, desobstruída, adequada ao risco atual e coerente com o layout, porque risco muda, layout muda e a placa fica onde estava", "Apenas se o fornecedor mantém o mesmo modelo"]', 2, 122),

    ('De quem é a responsabilidade pela sinalização de segurança no estabelecimento?',
     '["De cada trabalhador, que instala a placa onde achar necessário", "Da CIPA, que executa a instalação", "Do fornecedor das placas", "Do empregador, que precisa adotar, manter e fazer cumprir a sinalização adequada aos riscos existentes, com o apoio do serviço de segurança e da CIPA"]', 3, 123),

    ('Uma empresa contratada instala um equipamento dentro da área da contratante. Quem sinaliza a área do serviço?',
     '["A contratada sinaliza e mantém a sinalização do seu serviço, e a contratante informa os riscos da área e harmoniza as medidas, de modo que a área fique sinalizada para todos que circulam ali", "Apenas a contratante, porque a área é dela", "Apenas a contratada, sem envolvimento da contratante", "Nenhuma das duas, porque o serviço é temporário"]', 0, 124),

    ('Em uma equipe com trabalhadores estrangeiros que ainda não dominam o português:',
     '["Basta manter a sinalização em português, porque é o idioma oficial", "A sinalização segue em português e a empresa reforça a compreensão com símbolos padronizados, treinamento na língua compreendida pelo trabalhador e verificação de que a mensagem foi entendida", "A sinalização deve ser trocada pelo idioma da maioria estrangeira", "Basta designar um colega para traduzir quando houver dúvida"]', 1, 125),

    ('Para o trabalhador com deficiência visual, a informação de segurança precisa chegar por:',
     '["Recursos complementares como alarme sonoro, sinalização tátil no piso, informação em braile onde couber e orientação individual sobre a área e a rota de fuga", "Nenhum recurso adicional, porque o colega avisa", "Placas maiores e mais coloridas apenas", "Aviso escrito entregue na admissão"]', 0, 126),

    ('Nos coletores de resíduo com separação por cor, o azul e o vermelho identificam, respectivamente:',
     '["Vidro e metal", "Metal e orgânico", "Orgânico e vidro", "Papel e plástico"]', 3, 127),

    ('O resíduo de serviço de saúde com risco biológico deve ser descartado em:',
     '["Coletor comum, desde que fechado", "Coletor identificado para resíduo infectante, com o símbolo de risco biológico e saco na cor padronizada, mantido em local de acesso controlado", "Coletor de recicláveis", "Coletor de resíduo perigoso químico"]', 1, 128),

    ('Agulhas, lâminas e demais perfurocortantes precisam ser descartados:',
     '["Em saco plástico reforçado", "No coletor de resíduo comum, com aviso escrito", "Em recipiente rígido, resistente à perfuração, identificado com o símbolo de risco biológico, respeitando o limite de preenchimento", "Em qualquer recipiente com tampa"]', 2, 129),

    ('Lâmpadas fluorescentes, pilhas e baterias descartadas devem:',
     '["Ser armazenadas em local identificado como resíduo perigoso, com contenção e destinação específica, porque contêm metais que contaminam solo e água", "Ser guardadas soltas no almoxarifado", "Ir para o lixo comum quando forem poucas unidades", "Ir para o coletor de vidro, no caso das lâmpadas"]', 0, 130),

    ('E quando a placa de saída não mostra para que lado seguir?',
     '["Cumpre a função, porque todo mundo sabe onde é a saída", "É suficiente se estiver iluminada", "É meia sinalização: em corredor com ramificação, a placa precisa indicar o sentido, senão a pessoa hesita ou toma o caminho errado sob estresse", "Só é problema em prédios com mais de dez andares"]', 2, 131),

    ('Qual é a diferença entre uma placa que diz não opere e a etiqueta pessoal de bloqueio de um trabalhador?',
     '["Não há diferença prática", "A placa é um aviso genérico da área, enquanto a etiqueta identifica a pessoa que impediu a operação e não pode ser removida por outro trabalhador", "A etiqueta é apenas decorativa", "A placa tem valor legal e a etiqueta não"]', 1, 132),

    ('Uma área que permanece molhada por natureza do processo, como a lavagem de peças:',
     '["Precisa de sinalização permanente do risco, além de solução para o piso, como revestimento antiderrapante, drenagem e calçado adequado, porque cavalete móvel é para situação eventual", "Precisa de placa nova a cada turno", "Precisa apenas do cavalete de piso molhado nos dias de lavagem", "Não precisa de sinalização, porque todos sabem que ali é molhado"]', 0, 133),

    ('Além do guarda-corpo, uma borda com risco de queda de altura precisa de:',
     '["Nada, o guarda-corpo já resolve", "Apenas iluminação reforçada", "Apenas uma corrente delimitando", "Sinalização de advertência do risco de queda e, quando a proteção precisar ser removida para um serviço, isolamento e sinalização provisórios enquanto durar a abertura"]', 3, 134),

    ('Portas e painéis de vidro em área de circulação exigem:',
     '["Apenas película escura", "Faixa ou marcação em contraste na altura dos olhos, para que a superfície transparente seja percebida e ninguém colida com ela", "Apenas um adesivo com o nome da empresa", "Nenhuma sinalização, porque o vidro é visível"]', 1, 135),

    ('A fita de advertência colocada acima de uma tubulação enterrada serve para:',
     '["Marcar a profundidade exata da tubulação", "Facilitar a identificação do material da tubulação", "Avisar quem escava, antes de a ferramenta atingir a tubulação, que existe uma linha logo abaixo, indicando o produto que ela conduz", "Proteger a tubulação do peso do solo"]', 2, 136),

    ('Antes de qualquer escavação, quanto a cabos e tubulações enterrados, é preciso:',
     '["Escavar devagar e observar o solo", "Confiar na memória dos trabalhadores mais antigos", "Escavar apenas com equipamento leve", "Consultar o cadastro das interferências, localizar e sinalizar na superfície o traçado dos cabos e tubulações e liberar a escavação por escrito, porque cabo energizado enterrado mata quem escava"]', 3, 137),

    ('Nas vias internas de circulação da empresa, a sinalização precisa incluir:',
     '["Apenas a demarcação do estacionamento", "Limite de velocidade, sentido de circulação, faixas de pedestre, pontos de travessia, cruzamentos e áreas de manobra, com a mesma lógica da via pública", "Apenas placas de pare nos portões", "Apenas as vagas identificadas por setor"]', 1, 138),

    ('O acesso ao telhado, à laje ou à cobertura precisa de:',
     '["Apenas uma escada removível", "Apenas um aviso no chaveiro", "Restrição física de acesso e sinalização informando o risco de queda e de material frágil na cobertura, além da exigência de autorização e de proteção contra queda para subir", "Apenas sinalização na base da escada"]', 2, 139),

    ('A escada fixa tipo marinheiro precisa ter sinalizado:',
     '["Apenas a data de instalação", "Apenas a altura total", "Apenas o setor a que pertence", "A restrição de uso a pessoal autorizado, a exigência de proteção contra queda e o cuidado com o acesso, além de gaiola ou sistema de proteção conforme a altura"]', 3, 140),

    ('O espelho convexo instalado em cruzamento cego dentro do galpão:',
     '["É um recurso complementar de visibilidade e não dispensa a sinalização do cruzamento, a redução de velocidade e a preferência ao pedestre", "Serve apenas para o operador de empilhadeira", "Substitui a redução de velocidade no cruzamento", "Elimina a necessidade de buzina no cruzamento"]', 0, 141),

    ('Onde há rede elétrica aérea sobre a área de manobra ou de içamento, a sinalização deve:',
     '["Apenas indicar a tensão da rede", "Advertir sobre a presença da rede, indicar a altura livre segura e delimitar a distância de aproximação, porque contato de lança, caçamba ou carga com a rede é acidente fatal", "Ser instalada apenas no poste da rede", "Ser dispensada quando a rede é isolada"]', 1, 142),

    ('Que avisos a área de descarga de produto químico a granel exibe durante a operação?',
     '["Informe apenas o horário de recebimento", "Informe apenas o nome do transportador", "Identifique o produto, o perigo, a proibição de fonte de ignição quando aplicável, a localização do kit de emergência e do chuveiro lava-olhos e a delimitação da área durante a operação", "Identifique apenas o tanque de destino"]', 2, 143),

    ('O kit de emergência para derramamento precisa ser:',
     '["Guardado na sala de segurança, para não sumir", "Identificado apenas na planta do prédio", "Distribuído entre os armários do setor", "Sinalizado, de acesso livre, próximo às áreas de manuseio e armazenamento e com o conteúdo conferido periodicamente, porque em derramamento não há tempo de procurar"]', 3, 144),

    ('O ponto de recolhimento de EPI usado ou contaminado deve ser:',
     '["Um coletor comum no vestiário", "Identificado, com recipiente adequado e destinação definida, para que equipamento contaminado não volte ao uso nem vá para o lixo comum", "Uma caixa no almoxarifado sem identificação", "O mesmo coletor de resíduo reciclável"]', 1, 145),

    ('E na própria máquina, o que tem de estar sinalizado?',
     '["Apenas a placa de identificação do fabricante", "Apenas o número de patrimônio", "Sinalização dos pontos de risco na zona de perigo, identificação dos comandos e as advertências e pictogramas previstos pelo fabricante, em português e legíveis", "Apenas a data da última manutenção"]', 2, 146),

    ('A identificação dos botões e comandos de uma máquina precisa:',
     '["Ficar apenas no manual do equipamento", "Ser feita a lápis pelo próprio operador", "Ser dispensada quando o operador conhece a máquina", "Indicar claramente a função de cada comando, com o botão de parada de emergência em vermelho sobre fundo amarelo e destacado dos demais, porque em emergência ninguém procura o botão certo"]', 3, 147),

    ('Superfícies quentes de equipamentos, tubulações e fornos exigem:',
     '["Apenas a orientação verbal ao operador", "Isolamento térmico ou barreira física onde houver contato possível e sinalização de advertência de superfície quente, porque metal quente não muda de aparência", "Apenas a placa na entrada do setor", "Apenas o uso de luva pelos trabalhadores da área"]', 1, 148),

    ('Que avisos a sala de carregamento de baterias de empilhadeira tem de exibir?',
     '["Apenas a proibição de entrada de pessoas não autorizadas", "Apenas a identificação do equipamento carregado", "Proibição de fonte de ignição e de fumar, advertência de risco de explosão pelo hidrogênio liberado na carga, risco químico do eletrólito e localização do lava-olhos e do material de contenção", "Apenas o horário permitido de carregamento"]', 2, 149),

    ('Quando o layout de um setor muda, a sinalização:',
     '["Pode ser mantida como está, porque as placas são as mesmas", "Deve ser refeita apenas se houver acidente", "Deve ser refeita apenas na inspeção anual", "Precisa ser revista junto com a mudança: rotas, demarcação de piso, placas e rota de fuga deixam de corresponder à realidade e passam a orientar errado, o que é pior do que não ter sinalização"]', 3, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-26';


-- =====================================================================
--  LOTO — Bloqueio e etiquetagem de energias perigosas (questões 41 a 150)
--  As 40 antigas cobriram o conceito, o cadeado individual, a etiqueta, o
--  lock box, a chave, o turno, o terceiro, o teste de partida e a
--  liberação. Estas 110 vão para onde a energia se esconde: a inércia do
--  rotor que gira depois de desligado, a mola comprimida, o acumulador
--  hidráulico, o painel solar que continua gerando com o sol, o
--  transformador energizado pelo secundário. Depois a sequência inteira,
--  etapa por etapa, os dispositivos um a um, os papéis de cada pessoa e
--  trinta equipamentos reais, porque cada máquina guarda a força em um
--  lugar diferente e é sempre a que a equipe esqueceu que mata.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'LOTO')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('A energia foi cortada, mas o rotor da máquina continua girando por um tempo. O que isso significa para o bloqueio?',
     '["Que o serviço só pode começar depois da parada completa do movimento, confirmada visualmente, porque a inércia é energia armazenada e mão em rotor girando não tem retorno", "Que o bloqueio foi feito errado", "Que basta frear o rotor com uma barra", "Que o serviço pode começar assim que a rotação diminuir"]', 0, 41),

    ('Na intervenção em um sistema de transporte de pó ou de transferência de solvente, além do bloqueio das fontes, é preciso tratar de:',
     '["A eletricidade estática acumulada no material e nas partes do sistema, que precisa ser escoada por aterramento e equipotencialização antes da abertura, porque a centelha estática inflama pó e vapor", "Apenas o ruído do soprador", "Apenas o peso do material retido na tubulação", "Apenas a temperatura do material transportado"]', 0, 42),

    ('Um carro de ponte rolante está com uma carga suspensa no gancho e a manutenção precisa ser feita. O correto é:',
     '["Bloquear apenas a alimentação elétrica da ponte", "Bloquear a alimentação e trabalhar embaixo com atenção", "Baixar a carga ao piso ou apoiá-la em suporte adequado, e só então bloquear as energias e executar o serviço, porque carga suspensa é energia gravitacional armazenada", "Amarrar a carga em outro ponto e prosseguir"]', 2, 43),

    ('No bloqueio de uma linha de vapor, além de fechar e bloquear a válvula, é preciso:',
     '["Aguardar o turno seguinte para começar", "Drenar o condensado, aliviar a pressão do trecho e aguardar o resfriamento, com verificação de que a linha está fria e sem pressão antes de abrir", "Apenas medir a temperatura externa da tubulação", "Apenas isolar a área com fita"]', 1, 44),

    ('Um equipamento é inertizado com nitrogênio antes da manutenção. Qual é o risco adicional?',
     '["Explosão pelo nitrogênio", "Corrosão acelerada do equipamento", "Asfixia: o nitrogênio desloca o oxigênio e mata sem cheiro e sem aviso, o que exige bloqueio da linha de inerte, ventilação e medição da atmosfera antes da entrada", "Choque elétrico pela tubulação"]', 2, 45),

    ('Em um reator onde ainda há produto capaz de reagir e liberar calor ou pressão, o bloqueio precisa:',
     '["Considerar apenas a energia elétrica do agitador", "Considerar a energia química do processo: esvaziar, lavar, neutralizar e confirmar a condição segura antes de abrir, além de bloquear todas as linhas de alimentação", "Ser feito com o reator ainda cheio, para não perder o lote", "Ser feito apenas com a etiqueta na porta do reator"]', 1, 46),

    ('Manutenção em sistema de refrigeração com amônia exige atenção a qual energia?',
     '["À energia térmica de baixa temperatura e à energia química do fluido: linha bloqueada, trecho esvaziado e despressurizado, com EPI e plano de emergência, porque amônia sob pressão queima e intoxica", "Apenas ao ruído do equipamento", "Apenas ao peso das tubulações", "Apenas à elétrica do compressor"]', 0, 47),

    ('Alguns medidores de nível e de densidade usam fonte radioativa selada. Na manutenção do equipamento:',
     '["É preciso acionar o responsável pela fonte para colocá-la na posição fechada e bloqueada, com sinalização e controle de acesso, porque a fonte não desliga com o disjuntor", "Basta afastar as pessoas por alguns minutos", "Basta desligar a alimentação elétrica do medidor", "Basta usar avental de chumbo"]', 0, 48),

    ('Uma linha pressurizada será aberta para a troca de um trecho. O que garante que a pressão chegou a zero?',
     '["Basta abrir devagar e observar", "Basta usar óculos de proteção", "Basta esperar dez minutos", "É preciso aliviar a pressão pelo ponto de dreno ou respiro previsto e confirmar pressão zero no manômetro do trecho, porque jato sob pressão corta e projeta a flange"]', 3, 49),

    ('O que é retroalimentação em uma instalação elétrica bloqueada?',
     '["O retorno de tensão por outra fonte, como gerador do próprio cliente, alimentação alternativa ou transformador energizado pelo lado secundário, que reenergiza um trecho que se acreditava morto", "A energia que volta pelo aterramento", "O aumento de tensão quando a carga é retirada", "A corrente residual dos capacitores"]', 0, 50),

    ('Manutenção em um sistema com painéis fotovoltaicos. O que é preciso considerar?',
     '["Que os painéis param de gerar assim que o inversor é desligado", "Que basta desligar o disjuntor do quadro geral", "Que o painel gera tensão sempre que houver luz, e o lado de corrente contínua permanece energizado mesmo com o inversor desligado, exigindo bloqueio, seccionamento próprio e cobertura ou procedimento específico", "Que a geração cessa em dias nublados"]', 2, 51),

    ('Um transformador teve o lado de alta bloqueado. Ele pode continuar energizado por qual caminho?',
     '["Por indução do próprio núcleo, indefinidamente", "Pela umidade do óleo isolante", "Pelo aquecimento do enrolamento", "Pelo lado secundário, se houver outra fonte ligada àquele barramento, o que exige bloqueio dos dois lados e constatação de ausência de tensão antes de qualquer contato"]', 3, 52),

    ('Banco de capacitores de correção de fator de potência em um painel bloqueado:',
     '["Descarrega instantaneamente ao abrir a chave", "Mantém carga por um tempo após o desligamento, e é preciso respeitar o tempo de descarga, verificar a ausência de tensão e, quando previsto, aterrar antes de tocar nos componentes", "Não oferece risco porque a tensão é baixa", "Só oferece risco quando o painel está em operação"]', 1, 53),

    ('Um sistema hidráulico tem acumulador com bexiga de nitrogênio. O que ele muda no bloqueio?',
     '["Nada, porque o acumulador é apenas um reservatório", "Ele descarrega sozinho ao desligar a bomba", "Ele mantém óleo sob alta pressão mesmo com a bomba desligada, e é preciso descarregá-lo pelo ponto previsto e confirmar pressão zero antes de abrir qualquer conexão", "Ele apenas reduz o ruído do sistema"]', 2, 54),

    ('Equipamento que opera sob vácuo, como um filtro ou uma câmara, exige no bloqueio:',
     '["Apenas bloquear a bomba de vácuo", "Apenas aguardar a parada da bomba", "Apenas sinalizar a área", "Quebrar o vácuo pelo ponto previsto e confirmar a equalização com a pressão atmosférica, porque a sucção mantém tampas e visores presos e pode arrastar a mão na abertura"]', 3, 55),

    ('Uma correia ou corrente tensionada em um transportador, no momento do bloqueio:',
     '["Não representa risco, porque não há energia elétrica", "Guarda energia mecânica que pode liberar de repente ao soltar um esticador ou um parafuso, e por isso a tensão precisa ser aliviada de forma controlada e prevista no procedimento", "Só é perigosa se estiver rompida", "Deve ser cortada para liberar a tensão"]', 1, 56),

    ('Ao despressurizar o ar comprimido de uma máquina, um cilindro vertical desce sozinho. O que fazer?',
     '["Prever no procedimento o apoio ou o travamento mecânico da parte que desce por gravidade, antes de aliviar a pressão, porque a despressurização é justamente o momento do movimento inesperado", "Segurar o cilindro com a mão durante a despressurização", "Despressurizar rápido para o movimento ser curto", "Manter a pressão até o fim do serviço"]', 0, 57),

    ('Uma máquina acionada por motor a combustão precisa de qual bloqueio?',
     '["Apenas retirar a chave de ignição", "Apenas fechar a torneira de combustível", "Apenas desligar o motor e deixar esfriar", "Desconectar e bloquear a bateria e o sistema de partida, bloquear o combustível, considerar partida remota ou automática e travar as partes que podem se mover, além de aguardar o resfriamento"]', 3, 58),

    ('Qual é a primeira etapa de um bloqueio bem feito?',
     '["Colocar o cadeado no primeiro ponto encontrado", "Identificar o equipamento e todas as suas fontes de energia, consultando o procedimento específico e conferindo em campo, porque a fonte esquecida é a que causa o acidente", "Comunicar a manutenção depois de bloquear", "Preencher a etiqueta e afixar na máquina"]', 1, 59),

    ('A notificação dos trabalhadores afetados precisa acontecer:',
     '["Somente depois que o serviço terminar", "Somente se o serviço passar de um turno", "Antes do bloqueio, para que a operação pare de forma ordenada, e novamente antes da liberação, para que ninguém seja surpreendido pela máquina voltando a operar", "Somente para os operadores do turno da manhã"]', 2, 60),

    ('Na preparação do bloqueio, por que interessa saber se ainda há material ou produto retido dentro do equipamento?',
     '["Porque o material retido atrapalha a leitura dos instrumentos", "Porque isso define quanto tempo a manutenção vai durar", "Porque material retido escoa, desaba, escorre quente ou libera pressão e vapor no instante da abertura, e a forma de esvaziar e de abrir precisa estar definida antes de começar", "Porque o material retido precisa ser pesado para o controle de estoque"]', 2, 61),

    ('Qual é a diferença entre desligar pelo disjuntor e seccionar a energia?',
     '["O disjuntor é dispositivo de proteção e pode fechar por comando ou falha; o seccionamento é a abertura do dispositivo previsto para separar fisicamente o circuito, com indicação confiável da posição aberta e possibilidade de bloqueio", "Não há diferença, os dois cortam a energia", "O seccionamento só existe em alta tensão", "O disjuntor separa fisicamente e o seccionador apenas sinaliza"]', 0, 62),

    ('Quando um ponto de bloqueio recebe cadeado de vários trabalhadores, o correto é:',
     '["Aplicar o dispositivo tipo garra ou a caixa de bloqueio, de modo que cada pessoa coloque o seu próprio cadeado e a liberação só ocorra quando o último for retirado", "Todos usarem o mesmo cadeado com cópias da chave", "Escolher o cadeado do trabalhador mais graduado", "Colocar um cadeado e anotar os nomes na etiqueta"]', 0, 63),

    ('Depois de aplicar o bloqueio, dissipar a energia significa:',
     '["Desligar todos os equipamentos do setor", "Esperar trinta minutos por precaução", "Aguardar o resfriamento apenas", "Aliviar, drenar, purgar, descarregar, aterrar ou travar cada energia residual identificada, até que o equipamento fique em condição de energia zero"]', 3, 64),

    ('A verificação da energia zero deve ser feita:',
     '["Pelo encarregado, por telefone", "Pelo próprio trabalhador que executará o serviço, usando os instrumentos e os meios previstos no procedimento para cada tipo de energia, antes de qualquer intervenção", "Pelo operador da máquina, verbalmente", "Apenas na primeira intervenção do dia"]', 1, 65),

    ('Ao testar a partida da máquina para confirmar que ela não liga, o que não pode ser esquecido?',
     '["Avisar a produção do teste", "Anotar o horário do teste", "Devolver o comando à posição desligada logo após o teste, porque comando deixado na posição de partida faz a máquina arrancar no instante em que a energia voltar", "Repetir o teste três vezes"]', 2, 66),

    ('Enquanto o serviço corre, por quanto tempo cada cadeado permanece aplicado no ponto?',
     '["Pode ser retirado quando o trabalhador sai para o almoço", "Pode ser transferido para o cadeado do encarregado", "Pode ser reduzido a um único cadeado quando a equipe diminui", "Permanece aplicado enquanto houver alguém exposto, e cada pessoa mantém o seu cadeado até sair definitivamente da zona de risco"]', 3, 67),

    ('Antes de retirar os bloqueios, a inspeção final precisa confirmar:',
     '["Apenas que o serviço foi concluído", "Que todas as ferramentas e materiais foram retirados, que as proteções foram recolocadas, que os componentes estão montados e que não há ninguém na zona de risco", "Apenas que o operador está disponível", "Apenas que o horário do turno permite a liberação"]', 1, 68),

    ('A remoção dos dispositivos de bloqueio segue qual lógica?',
     '["Qualquer ordem, desde que todos sejam retirados", "Começando pelo ponto mais distante", "A ordem inversa da aplicação e definida no procedimento, cada trabalhador retirando o seu, para que o restabelecimento aconteça de forma controlada", "Começando pelo cadeado do supervisor"]', 2, 69),

    ('Os cadeados já foram retirados e o equipamento voltou a operar. O que ainda cabe à equipe?',
     '["Nada mais, o serviço está encerrado", "Apenas assinar a ordem de serviço", "Apenas guardar os cadeados", "Comunicar a liberação aos afetados, acompanhar a partida e o funcionamento inicial a distância segura e registrar a conclusão do bloqueio"]', 3, 70),

    ('Para bloquear um disjuntor em quadro, usa-se:',
     '["Uma fita amarrada na alavanca", "O dispositivo de travamento apropriado ao modelo do disjuntor, que impede o rearme e permite a colocação do cadeado", "Uma tampa de acrílico parafusada no quadro", "Um pedaço de madeira travando a alavanca"]', 1, 71),

    ('Quando o equipamento é alimentado por tomada e o plugue pode ser retirado, o correto é:',
     '["Retirar o plugue e aplicar o dispositivo de bloqueio do plugue, com cadeado, ou manter o plugue sob controle exclusivo e permanente de quem executa o serviço", "Colocar a etiqueta na tomada", "Retirar o plugue e deixar ao lado da tomada", "Desligar o interruptor da parede"]', 0, 72),

    ('Válvula gaveta e válvula esfera exigem dispositivos de bloqueio diferentes porque:',
     '["O formato do acionamento é diferente: uma tem volante e a outra alavanca, e cada uma tem o dispositivo próprio que impede o movimento e recebe o cadeado", "Uma é usada em água e a outra em vapor", "Uma tem rosca e a outra não", "Uma é de aço e a outra de bronze"]', 0, 73),

    ('Em que situação se usa o cabo de bloqueio, aquele que passa por vários pontos e é apertado por uma trava?',
     '["Para passar por várias alavancas, volantes ou pontos de acionamento e travá-los juntos, com o cadeado no dispositivo de aperto do cabo", "Para amarrar a etiqueta na máquina", "Para substituir a corrente do cilindro de gás", "Para prender o operador ao ponto de trabalho"]', 0, 74),

    ('Botoeiras e chaves seletoras de painel podem ser bloqueadas com dispositivo próprio. Isso substitui o bloqueio do seccionamento?',
     '["Sim, se o painel for exclusivo da máquina", "Sim, quando o serviço é rápido", "Não: o bloqueio do comando é medida complementar, e o bloqueio principal continua sendo no dispositivo de seccionamento da fonte de energia", "Sim, se o cadeado for de uso exclusivo"]', 2, 75),

    ('Uma chave seccionadora tipo faca, em cabine, exige:',
     '["Apenas a abertura da chave", "Apenas a etiqueta na porta da cabine", "Apenas o desligamento do disjuntor a montante", "Abertura da chave, confirmação visual da separação dos contatos, aplicação do dispositivo de bloqueio previsto e cadeado, além da constatação de ausência de tensão e do aterramento quando aplicável"]', 3, 76),

    ('Válvulas de grande diâmetro, cujo volante não aceita o dispositivo comum, podem ser bloqueadas com:',
     '["Uma corda amarrada no volante", "Dispositivo tipo cinta ou corrente com trava e cadeado, previsto para essa finalidade, ou pela retirada do volante com o eixo travado, conforme o procedimento", "Uma placa colada no corpo da válvula", "Um cadeado passado direto no volante, de qualquer maneira"]', 1, 77),

    ('Parada geral com dezenas de pessoas intervindo no mesmo equipamento: como se organiza a guarda das chaves?',
     '["Cada um colocar o cadeado direto no ponto de bloqueio, mesmo que não haja espaço", "Um cadeado por equipe, com o líder respondendo por todos", "A caixa de bloqueio coletiva, onde ficam as chaves dos bloqueios de campo e na qual cada trabalhador coloca o próprio cadeado", "Uma lista assinada substituindo os cadeados"]', 2, 78),

    ('A etiqueta usada em ambiente com calor, umidade, óleo ou produto químico precisa:',
     '["Ser trocada todos os dias", "Ser protegida com saco plástico comum", "Ser escrita a lápis para não borrar", "Ser de material resistente àquelas condições, com escrita que não apague, porque etiqueta ilegível deixa de informar quem bloqueou e por quê"]', 3, 79),

    ('Por que o cadeado de bloqueio não pode ser abrangido por chave-mestra?',
     '["Porque a chave-mestra desgasta o segredo do cadeado", "Porque a proteção do trabalhador depende de ele ser a única pessoa capaz de abrir o próprio cadeado; chave-mestra devolve a terceiros o poder de liberar a máquina com alguém exposto", "Porque a chave-mestra encarece o sistema", "Porque a norma proíbe cadeados iguais"]', 1, 80),

    ('Padronizar a cor dos cadeados por equipe, turno ou função serve para:',
     '["Identificar rapidamente de qual equipe é cada bloqueio em um ponto com muitos cadeados, agilizando a comunicação sem substituir a identificação individual", "Permitir que qualquer um da mesma cor abra o cadeado", "Deixar o painel mais organizado visualmente", "Definir quem retira primeiro"]', 0, 81),

    ('Um trabalhador precisa bloquear cinco pontos de energia diferentes. Quantos cadeados ele usa?',
     '["Um cadeado, revezando entre os pontos", "Um cadeado, no ponto principal", "Um cadeado por dia de serviço", "Um cadeado em cada ponto de bloqueio, ou os dispositivos previstos para agrupar os pontos, de modo que nenhuma fonte fique sem bloqueio"]', 3, 82),

    ('A estação de bloqueio instalada na área serve para:',
     '["Guardar as ferramentas da manutenção", "Manter cadeados, garras, dispositivos e etiquetas organizados, identificados e disponíveis no local do serviço, com controle do que está em uso", "Guardar as chaves de todos os cadeados da fábrica", "Servir de ponto de encontro da equipe"]', 1, 83),

    ('Quando o serviço exige abrir uma tubulação, o bloqueio da válvula pode não ser suficiente. A garantia física é:',
     '["Fechar duas válvulas em série e confiar nelas", "Colocar dois cadeados na mesma válvula", "Instalar flange cego, raquete ou figura oito no ponto de separação, porque válvula pode ter passagem interna e ninguém enxerga isso pelo lado de fora", "Aumentar a pressão do lado oposto"]', 2, 84),

    ('Quem é o trabalhador que apenas circula ou trabalha nas proximidades da área bloqueada?',
     '["É considerado trabalhador autorizado", "É o supervisor de liberação", "Não tem qualquer classificação no procedimento", "É a pessoa que não executa nem opera, mas está na área: precisa saber reconhecer o bloqueio, respeitar a sinalização e nunca tentar acionar o equipamento nem remover dispositivo"]', 3, 85),

    ('Qual é o papel do responsável pela liberação do equipamento?',
     '["Conferir se o procedimento foi seguido, se todas as fontes foram bloqueadas e verificadas, e autorizar formalmente o início do serviço e depois a devolução do equipamento à operação", "Colocar o primeiro cadeado e sair", "Guardar as chaves dos cadeados da equipe", "Substituir o trabalhador ausente na retirada do cadeado"]', 0, 86),

    ('Qual é o papel do operador da máquina no procedimento de bloqueio?',
     '["Colocar o cadeado no lugar do mecânico", "Retirar o cadeado quando precisar produzir", "Fazer a parada ordenada, informar as condições reais do equipamento, confirmar que não há material ou produto retido e não tentar acionar a máquina enquanto o bloqueio estiver aplicado", "Assinar a etiqueta em nome da equipe"]', 2, 87),

    ('O serviço de segurança do trabalho, no procedimento de bloqueio, atua:',
     '["Executando os bloqueios em campo", "Guardando as chaves dos cadeados", "Autorizando cada intervenção individualmente", "Elaborando e revisando o procedimento com a manutenção e a operação, treinando, auditando a prática em campo e investigando as falhas"]', 3, 88),

    ('O treinamento em bloqueio e etiquetagem precisa:',
     '["Acontecer apenas na admissão", "Ser inicial e periódico, e ser refeito quando o procedimento muda, quando entra equipamento novo e quando a auditoria mostra desvio na prática", "Ser feito apenas pelo pessoal da manutenção elétrica", "Ser feito uma vez a cada cinco anos"]', 1, 89),

    ('Para que serve a auditoria periódica do procedimento de bloqueio?',
     '["Para verificar em campo se o procedimento escrito corresponde ao que realmente é feito, se todas as fontes estão mapeadas e se os trabalhadores sabem executar, corrigindo o que estiver diferente", "Para avaliar o desempenho individual dos trabalhadores", "Para conferir o estoque de cadeados", "Para renovar o certificado dos participantes"]', 0, 90),

    ('Uma máquina recebeu um sistema auxiliar novo, com alimentação própria. O que precisa acontecer?',
     '["Nada, porque o procedimento antigo já cobre a máquina", "O eletricista avisa a equipe verbalmente", "Aguardar a próxima revisão anual do procedimento", "Revisar o procedimento de bloqueio, mapear e identificar o novo ponto e treinar quem intervém, porque fonte nova não mapeada é o caminho direto para o acidente"]', 3, 91),

    ('Identificar de forma permanente os pontos de bloqueio na própria máquina serve para:',
     '["Facilitar o inventário do patrimônio", "Evitar que alguém procure o ponto na hora do serviço, garantir que todos bloqueiem os mesmos pontos e permitir conferir rapidamente se algum ficou sem bloqueio", "Cumprir exigência do fabricante", "Indicar onde ficam os fusíveis"]', 1, 92),

    ('Fotos e desenhos dos pontos de bloqueio dentro do procedimento:',
     '["São desnecessários quando o texto está bem escrito", "Servem apenas para treinamento em sala", "Ajudam quem não conhece aquela máquina a localizar e conferir cada ponto, reduzindo o erro de bloquear o equipamento ao lado ou esquecer uma fonte", "Devem ser evitados porque a máquina muda de aparência"]', 2, 93),

    ('Uma boa forma de acompanhar se o procedimento está sendo cumprido é:',
     '["Contar quantos cadeados foram comprados no ano", "Perguntar à equipe se ela usa o procedimento", "Verificar se houve reclamação da produção", "Comparar o número de intervenções em máquinas com o número de bloqueios registrados e inspecionar em campo durante os serviços, porque diferença grande entre um e outro mostra serviço feito sem bloqueio"]', 3, 94),

    ('Aconteceu uma partida inesperada durante uma manutenção, sem lesão. O que fazer?',
     '["Registrar como quase-acidente e investigar a fundo: qual fonte não foi bloqueada, se o procedimento está correto e se houve pressa ou falha de comunicação, corrigindo antes que se repita", "Considerar o assunto encerrado, já que ninguém se feriu", "Advertir o trabalhador e seguir o serviço", "Anotar no relatório mensal sem investigar"]', 0, 95),

    ('O procedimento de bloqueio da máquina está desatualizado e não corresponde ao que existe em campo. O correto é:',
     '["Seguir o procedimento como está escrito", "Improvisar o bloqueio conforme o bom senso da equipe", "Interromper e acionar o responsável para atualizar o procedimento antes de executar, porque procedimento errado orienta a equipe a deixar uma fonte energizada", "Executar e comunicar a divergência depois"]', 2, 96),

    ('A produção pressiona para liberar a máquina antes da conferência final. O correto é:',
     '["Liberar e conferir depois, com a máquina rodando", "Liberar mantendo um cadeado no ponto principal", "Retirar as pessoas e liberar sem recolocar as proteções", "Concluir a inspeção final e a retirada dos bloqueios conforme o procedimento, porque pressa na liberação é quando alguém fica dentro da máquina"]', 3, 97),

    ('O trabalhador percebe que não é possível bloquear com segurança aquela fonte de energia. Ele deve:',
     '["Executar com atenção redobrada", "Interromper e comunicar, porque enquanto não houver meio de bloquear e verificar a energia zero a atividade não pode ser executada, e cabe à empresa providenciar a solução técnica", "Pedir a um colega para vigiar o painel", "Executar apenas a parte menos arriscada do serviço"]', 1, 98),

    ('Na manutenção de uma prensa, além do bloqueio elétrico e pneumático, é necessário:',
     '["Instalar o dispositivo mecânico de travamento do martelo ou apoiar o cabeçote em bloco de segurança, porque o peso do martelo desce sozinho quando a pressão é aliviada", "Apenas colocar a prensa em ciclo lento", "Apenas manter o comando bimanual liberado", "Apenas manter alguém observando o painel"]', 0, 99),

    ('Na intervenção em uma injetora de plástico, as energias a considerar incluem:',
     '["A elétrica, a hidráulica com pressão residual, a mecânica do fechamento do molde, a térmica do canhão e das resistências e o material pressurizado dentro do cilindro", "Apenas a hidráulica do sistema", "Apenas a mecânica do molde", "Apenas a elétrica do motor"]', 0, 100),

    ('Na manutenção de uma extrusora, o cuidado adicional é:',
     '["Com a temperatura das resistências e do material fundido, que continua quente e sob pressão dentro do canhão por bastante tempo depois do desligamento, além do acionamento da rosca", "Apenas com o ruído do equipamento", "Apenas com o peso do cabeçote", "Apenas com a energia elétrica do painel"]', 0, 101),

    ('Para abrir a tampa de um misturador ou amassadeira, o correto é:',
     '["Confiar no intertravamento da tampa", "Abrir com a máquina em rotação mínima", "Bloquear e etiquetar as fontes de energia, confirmar a parada completa das pás e a energia zero, e só então abrir, porque o intertravamento é proteção de operação e não substitui bloqueio para manutenção", "Abrir com a mão protegida por luva"]', 2, 102),

    ('Em moinhos e trituradores, o risco mais subestimado no bloqueio é:',
     '["A poeira gerada no processo", "O ruído do equipamento", "O peso das tampas de inspeção", "A inércia do rotor, que gira por vários minutos após o desligamento, e o material acumulado que pode desabar ou girar ao ser liberado"]', 3, 103),

    ('Antes de abrir uma centrífuga:',
     '["Basta desligar o painel e abrir a tampa", "É preciso bloquear, aguardar a parada completa confirmada, sem frear com objetos, e verificar a ausência de produto sob pressão ou de atmosfera perigosa dentro do cesto", "Basta acionar o freio de emergência", "Basta reduzir a rotação pela metade"]', 1, 104),

    ('Na limpeza de um transportador helicoidal, o transportador de rosca, o correto é:',
     '["Retirar o material pela tampa com a rosca em movimento lento", "Usar uma barra comprida para desatolar com o equipamento ligado", "Bloquear e etiquetar todas as fontes, confirmar a parada e a energia zero e só então abrir a tampa de inspeção, porque a rosca puxa o braço inteiro em uma fração de segundo", "Pedir a um colega para segurar o botão de parada"]', 2, 105),

    ('O elevador de canecas guarda qual força para o momento em que o freio é liberado?',
     '["Apenas o pó acumulado", "Apenas o ruído da corrente", "Apenas a altura do equipamento", "O peso da coluna de material e das canecas, que faz o conjunto girar no sentido inverso quando o freio é liberado, exigindo travamento mecânico previsto no procedimento"]', 3, 106),

    ('Para manutenção em ponte rolante, o bloqueio precisa incluir:',
     '["Apenas o painel de comando da ponte", "A alimentação da ponte, o carro e as talhas, com sinalização e isolamento da área abaixo no piso, e o impedimento de outras pontes do mesmo caminho de rolamento se aproximarem do trecho em manutenção", "Apenas o botão de emergência do controle", "Apenas a retirada do controle do operador"]', 1, 107),

    ('Para trabalhar em uma talha elétrica, o que precede o serviço?',
     '["É preciso retirar a carga do gancho ou apoiá-la, bloquear a alimentação e travar o movimento, porque carga no gancho é energia armazenada e o freio pode ceder", "Basta manter a carga suspensa e trabalhar por baixo", "Basta cortar a alimentação da talha", "Basta baixar a carga até meia altura"]', 0, 108),

    ('Na manutenção de elevador de carga ou monta-cargas, é indispensável:',
     '["Apenas travar a porta do pavimento", "Apenas desligar o quadro do elevador", "Apenas colocar a cabine no pavimento térreo", "Bloquear a alimentação, apoiar mecanicamente a cabine ou o contrapeso conforme o procedimento e impedir o acesso às portas de todos os pavimentos, porque a queda da cabine e o movimento do contrapeso são os riscos principais"]', 3, 109),

    ('Ao intervir em escada rolante ou esteira de transporte de pessoas:',
     '["Basta parar pelo botão de emergência e sinalizar o acesso", "É preciso bloquear a energia no seccionamento, travar o acionamento, isolar e sinalizar os dois acessos e considerar a energia armazenada no conjunto de degraus e no freio", "Basta isolar apenas o acesso de cima", "Basta desligar a iluminação do equipamento"]', 1, 110),

    ('Portões e barreiras automáticas em manutenção exigem:',
     '["Apenas retirar o controle remoto de circulação", "Apenas desligar o sensor de presença", "Bloqueio da alimentação, desativação do comando remoto e do sensor de acionamento e travamento mecânico da folha ou da barreira, que pode se mover pelo peso ou pela mola do sistema", "Apenas fixar o portão com uma corda"]', 2, 111),

    ('Antes de entrar na área de trabalho de um robô industrial:',
     '["Basta colocar o robô no modo manual de ensino", "Basta abrir o portão da cerca de proteção", "Basta desligar a energia da esteira alimentadora", "É preciso aplicar o bloqueio das fontes conforme o procedimento, porque o modo de ensino e o intertravamento da cerca são recursos de operação e o robô pode se mover por comando, falha ou energia armazenada nos eixos"]', 3, 112),

    ('Caldeira parada para manutenção: o que precisa estar isolado antes de abrir ou entrar?',
     '["Vapor, água quente sob pressão, combustível, energia elétrica dos comandos e auxiliares e a energia térmica acumulada, com resfriamento, despressurização e isolamento físico das linhas antes da entrada ou da abertura", "Apenas o queimador", "Apenas a linha de vapor de saída", "Apenas a alimentação elétrica do painel"]', 0, 113),

    ('Antes de abrir um compressor de ar ou o seu reservatório:',
     '["Basta desligar o compressor pelo painel", "Basta fechar a válvula de saída de ar", "É preciso bloquear a alimentação elétrica, isolar a linha, despressurizar completamente o reservatório pelo dreno e confirmar pressão zero no manômetro, porque o vaso permanece pressurizado após o desligamento", "Basta aguardar o compressor esfriar"]', 2, 114),

    ('Em uma bomba centrífuga com linha pressurizada, a válvula de retenção:',
     '["Serve como ponto de bloqueio, porque impede o retorno", "Dispensa o bloqueio da válvula de sucção", "Substitui o dreno da linha", "Não é dispositivo de bloqueio: ela impede o fluxo em um sentido, mas não isola a linha nem pode ser travada, e por isso o bloqueio é feito nas válvulas previstas, com alívio e dreno do trecho"]', 3, 115),

    ('A entrada em um tanque com agitador exige:',
     '["Apenas o bloqueio elétrico do motor do agitador", "Apenas a permissão de entrada em espaço confinado", "Apenas a lavagem do tanque", "O bloqueio de todas as fontes do agitador e das linhas que chegam ao tanque, a verificação da energia zero, a permissão de entrada em espaço confinado com medição da atmosfera e o vigia externo, tudo em conjunto"]', 3, 116),

    ('Na intervenção em silo de armazenamento, o risco específico é:',
     '["Apenas a poeira em suspensão", "O material que forma ponte ou abóbada e desaba de repente sobre quem está dentro, além do sistema de descarga que pode ser acionado, o que exige bloqueio de todas as fontes, procedimento de entrada e proteção contra soterramento", "Apenas o ruído da descarga", "Apenas a altura do equipamento"]', 1, 117),

    ('No bloqueio de um forno industrial a gás, além da energia térmica acumulada:',
     '["É preciso bloquear e isolar fisicamente a linha de combustível, purgar o trecho, bloquear os sistemas de ar e de exaustão e confirmar a ausência de gás na câmara antes da entrada", "Basta desligar o painel de comando", "Basta fechar o registro do gás na entrada", "Basta aguardar o resfriamento natural"]', 0, 118),

    ('Antes de entrar em uma estufa ou secador para manutenção:',
     '["Basta abrir a porta e aguardar a ventilação natural", "Basta desligar as resistências", "Basta o uso de luva térmica", "É preciso bloquear a energia das resistências, dos ventiladores e dos transportadores internos, aguardar e confirmar o resfriamento e ventilar o interior, tratando a entrada conforme o procedimento de espaço confinado quando aplicável"]', 3, 119),

    ('Na manutenção de cabine de pintura, além da elétrica:',
     '["Basta desligar o exaustor", "É preciso bloquear a alimentação de tinta e de ar comprimido, aliviar a pressão das linhas e das pistolas, manter a exaustão até a eliminação dos vapores e observar a proibição de fonte de ignição na área", "Basta aguardar a secagem da tinta", "Basta o uso de máscara com filtro químico"]', 1, 120),

    ('Em torno, fresa ou furadeira de bancada, um risco frequente na manutenção é:',
     '["A queda da ferramenta de corte", "O peso do cabeçote apenas", "O acionamento por pedal ou por comando remanescente e a inércia da placa ou do eixo, o que exige bloqueio no seccionamento e não apenas o desligamento pela chave da máquina", "O ruído durante o ajuste"]', 2, 121),

    ('Ao trocar a lâmina de uma serra fita ou o disco de uma serra industrial:',
     '["Basta parar o equipamento e aguardar a lâmina esfriar", "Basta usar luva anticorte", "Basta acionar o freio da máquina", "É preciso bloquear e etiquetar a energia, confirmar a parada completa, aliviar a tensão da lâmina de forma controlada e proteger o corte durante o manuseio, porque a lâmina guarda tensão e continua cortando parada"]', 3, 122),

    ('Uma empilhadeira será reparada dentro da área operacional. O bloqueio inclui:',
     '["Apenas retirar a chave do contato", "Retirar a chave, desconectar e bloquear a bateria ou o sistema de partida, apoiar os garfos no piso ou travar mecanicamente a torre e a estrutura levantada, calçar as rodas e sinalizar o equipamento como impedido de operar", "Apenas puxar o freio de estacionamento", "Apenas sinalizar o equipamento com um cone"]', 1, 123),

    ('Um veículo foi levantado por macaco para manutenção embaixo. O correto é:',
     '["Trabalhar com o veículo apoiado apenas no macaco hidráulico", "Calçar apenas as rodas traseiras", "Apoiar o veículo em cavaletes apropriados, calçar as rodas que permanecem no piso, bloquear a partida e conferir a estabilidade antes de qualquer pessoa passar por baixo, porque o macaco é dispositivo de elevação e não de sustentação", "Manter o motor ligado para acionar o sistema hidráulico"]', 2, 124),

    ('Betoneira e bomba de concreto guardam qual energia mesmo depois de o motor ser desligado?',
     '["A pressão residual da linha de concreto, que projeta material ao ser aberta, além do acionamento do tambor e da rosca, exigindo bloqueio de todas as fontes e alívio da pressão pelo ponto previsto", "Apenas o peso do equipamento", "Apenas o ruído do motor", "Apenas a limpeza da cuba"]', 0, 125),

    ('Em manutenção de grua ou guindaste:',
     '["É preciso bloquear a alimentação, considerar o vento e a movimentação da lança, retirar ou apoiar a carga, travar os movimentos conforme o manual e isolar a área de projeção, com autorização do responsável técnico do equipamento", "Basta desligar o painel na base", "Basta recolher a lança até o menor raio", "Basta comunicar o operador que o equipamento está parado"]', 0, 126),

    ('Em uma esteira longa, com vários pontos de partida ao longo do percurso:',
     '["É preciso bloquear todos os comandos capazes de dar partida, considerar a sirene e a partida automática programada, isolar e sinalizar todo o percurso e confirmar que ninguém está sobre a esteira antes de qualquer liberação", "Basta desligar as botoeiras locais", "Basta bloquear o painel do acionamento principal", "Basta posicionar um vigia no acionamento"]', 0, 127),

    ('Serviço de dois dias em equipamento ligado por tomada industrial. Como fica o controle da alimentação?',
     '["Retirar o plugue e deixá-lo pendurado", "Colocar apenas a etiqueta na tomada", "Pedir para o eletricista desligar o circuito no quadro", "Retirar o plugue, aplicar o dispositivo de bloqueio do plugue com cadeado e etiqueta, ou bloquear o circuito no quadro, porque plugue solto por dois dias volta para a tomada por qualquer pessoa"]', 3, 128),

    ('Quando o simples desconectar da tomada pode ser aceito como controle de energia?',
     '["Sempre, para qualquer equipamento portátil", "Somente em equipamento portátil ou de pequeno porte, com fonte única, quando o plugue permanece o tempo todo sob o controle exclusivo e visual de quem executa o serviço, e ainda assim quando o procedimento da empresa admite essa condição", "Nunca, em qualquer situação", "Sempre que o serviço durar menos de trinta minutos"]', 1, 129),

    ('Antes de entrar em uma área protegida por sistema fixo de extinção por gás:',
     '["Basta avisar a portaria", "Basta desligar o alarme sonoro", "É preciso bloquear e sinalizar o acionamento do sistema conforme o procedimento, porque a descarga do agente extintor dentro do ambiente com pessoas causa asfixia, lesão auditiva e pânico", "Basta manter a porta aberta durante o serviço"]', 2, 130),

    ('O bloqueio de energias e a entrada em espaço confinado se relacionam assim:',
     '["São procedimentos independentes que nunca se cruzam", "A permissão de entrada substitui o bloqueio", "O bloqueio substitui a permissão de entrada", "O bloqueio de todas as linhas e acionamentos que alcançam o espaço é pré-requisito da entrada, e a permissão de entrada só é emitida depois que o isolamento está feito e verificado"]', 3, 131),

    ('Quando um trabalho a quente será executado em uma linha ou equipamento de processo:',
     '["Basta a permissão de trabalho a quente", "O bloqueio e o isolamento físico das linhas, com drenagem, purga e confirmação da ausência de produto e de pressão, precisam estar concluídos e verificados antes da emissão da liberação para o serviço a quente", "Basta fechar a válvula mais próxima do ponto de solda", "Basta manter o vigia de fogo no local"]', 1, 132),

    ('Como a desenergização prevista para instalações elétricas se relaciona com o bloqueio?',
     '["São procedimentos concorrentes, e a empresa escolhe um deles", "O bloqueio elétrico dispensa a constatação de ausência de tensão", "A desenergização é a aplicação da mesma lógica ao risco elétrico: seccionar, impedir a reenergização com bloqueio, constatar a ausência de tensão, aterrar, proteger elementos energizados próximos e sinalizar", "A desenergização vale apenas para alta tensão"]', 2, 133),

    ('Algumas máquinas têm modo de manutenção com movimento limitado e velocidade reduzida. Isso substitui o bloqueio?',
     '["Sim, porque a velocidade reduzida elimina o risco", "Sim, quando há duas pessoas acompanhando", "Sim, se o modo for protegido por senha", "Não substitui o bloqueio para os serviços em que é possível parar a máquina; é um recurso previsto apenas para ajustes que exigem movimento, com medidas de proteção específicas e autorização"]', 3, 134),

    ('Quando o serviço com bloqueio também é em altura:',
     '["O bloqueio pode ser simplificado para reduzir o tempo em altura", "Somam-se as exigências: bloqueio completo das energias e todo o conjunto de proteção contra queda, com análise de risco, permissão quando aplicável e plano de resgate, porque uma exigência não dispensa a outra", "Basta o cinto de segurança, porque a máquina está parada", "O trabalho em altura dispensa o teste de energia zero"]', 1, 135),

    ('A equipe de limpeza terceirizada vai lavar a área interna de um equipamento. Isso exige bloqueio?',
     '["Sim: sempre que alguém precisa entrar na zona de risco ou colocar parte do corpo em local que a máquina alcança, o bloqueio é obrigatório, e a equipe precisa ser treinada e colocar os próprios cadeados", "Somente se a limpeza durar mais de uma hora", "Não, porque limpeza não é manutenção", "Somente se houver produto químico envolvido"]', 0, 136),

    ('Uma empreiteira fará uma reforma que mexe na instalação elétrica dentro da fábrica em operação. O correto é:',
     '["A empreiteira desliga o que precisar e comunica depois", "A fábrica desliga tudo durante a obra", "A empreiteira trabalha apenas fora do expediente, sem bloqueio", "Definir previamente o escopo, mapear e bloquear os circuitos envolvidos com procedimento conjunto, comunicar os setores afetados e manter o controle de quem bloqueia o quê, com cadeados das duas empresas"]', 3, 137),

    ('Inspeções e medições que exigem a máquina em funcionamento, como análise de vibração:',
     '["São proibidas em qualquer situação", "Só podem ser feitas com a máquina bloqueada", "São admitidas quando não é possível executá-las com o equipamento parado, com procedimento específico, proteções instaladas, distância segura e autorização, e nunca com proteção removida ou intertravamento burlado", "Podem ser feitas livremente, porque não há intervenção"]', 2, 138),

    ('Quando o serviço realmente não pode ser executado com o equipamento parado:',
     '["É preciso análise de risco específica, procedimento escrito, autorização formal, medidas alternativas de proteção e a menor exposição possível, e a decisão não cabe ao trabalhador sozinho no momento do serviço", "Executa-se do mesmo jeito, com atenção redobrada", "Basta a autorização verbal do supervisor", "Basta a presença de duas pessoas"]', 0, 139),

    ('Uma linha de produção tem várias máquinas interligadas e só uma será mantida. O bloqueio deve:',
     '["Se limitar à máquina em manutenção", "Parar toda a fábrica por precaução", "Considerar as interfaces: material que chega de outro equipamento, acionamentos comandados por outra máquina e o transportador que alimenta o trecho, bloqueando também esses pontos conforme o procedimento", "Ser feito apenas no painel geral da linha"]', 2, 140),

    ('Em sistemas com redundância, como duas bombas ou dois compressores em paralelo:',
     '["Basta bloquear o equipamento em manutenção", "Basta desligar o comando automático de revezamento", "Basta avisar a sala de controle", "É preciso bloquear o equipamento em manutenção e isolar a linha comum, impedindo que o equipamento reserva entre em operação e pressurize o trecho onde a equipe está trabalhando"]', 3, 141),

    ('Quando apenas um trecho da planta é bloqueado e o restante continua operando:',
     '["Não há cuidado adicional, porque o trecho está isolado", "É preciso demarcar claramente o limite do bloqueio, sinalizar a fronteira, comunicar os operadores das áreas vizinhas e garantir que ninguém opere válvula ou comando que alcance o trecho bloqueado", "O restante da planta deve ser parado também", "Basta manter um vigia no limite da área"]', 1, 142),

    ('A sinalização de não operar colocada em um painel de sala elétrica:',
     '["É medida complementar: informa e adverte, mas o impedimento efetivo continua sendo o dispositivo de bloqueio aplicado no ponto de seccionamento", "Vale apenas para os eletricistas", "Substitui o cadeado quando a sala é trancada", "Só é necessária em painéis de alta tensão"]', 0, 143),

    ('Manter a sala elétrica trancada e a chave sob controle serve como bloqueio?',
     '["Sim, porque ninguém entra sem a chave", "Sim, se apenas uma pessoa tiver a chave", "Sim, quando a sala é exclusiva daquele equipamento", "É um controle de acesso complementar, mas não substitui o bloqueio no dispositivo de seccionamento com cadeado e etiqueta individuais de quem está exposto"]', 3, 144),

    ('Um equipamento ficará bloqueado por vários meses, aguardando peça. O procedimento deve prever:',
     '["Retirar os cadeados e deixar apenas a etiqueta", "Manter o bloqueio com registro formal do responsável, revisão periódica da condição, sinalização reforçada e, quando aplicável, isolamento físico definitivo do equipamento, sem depender do cadeado individual de alguém que pode se ausentar", "Retirar todo o bloqueio até a peça chegar", "Deixar a máquina energizada, já que ninguém vai operá-la"]', 1, 145),

    ('Na retomada depois de uma parada geral, com várias equipes e vários bloqueios:',
     '["Cada equipe retira o que encontrar pela frente", "O supervisor retira todos os cadeados de uma vez", "É preciso um controle central de todas as liberações, com conferência equipamento por equipamento, retirada dos bloqueios por seus próprios donos e partida por etapas, comunicada e acompanhada", "A retomada é feita simultaneamente para ganhar tempo"]', 2, 146),

    ('Um incêndio ou vazamento obriga a evacuação enquanto o equipamento está bloqueado. O correto é:',
     '["Retirar os bloqueios antes de sair, para liberar a máquina", "Voltar depois para retirar o cadeado, sem comunicar", "Deixar tudo como está e ir embora", "Sair pela rota de fuga deixando os bloqueios aplicados, comunicar a situação ao responsável e ao comando da emergência e só retomar o serviço com nova verificação de todas as condições"]', 3, 147),

    ('Faltou energia da concessionária no meio do serviço. Isso substitui o bloqueio?',
     '["Sim, porque não há energia disponível", "Não: a energia pode voltar a qualquer instante, e a falta de energia da rede não é bloqueio nem dispensa a verificação da energia zero e o cadeado no ponto de seccionamento", "Sim, enquanto durar a interrupção", "Sim, se o gerador estiver desligado"]', 1, 148),

    ('Registrar em foto os pontos bloqueados na abertura do serviço serve para:',
     '["Cumprir exigência do fornecedor de cadeados", "Comprovar horário de início para efeito de produtividade", "Documentar quais pontos foram efetivamente bloqueados, facilitar a conferência por quem chega depois e a passagem de turno e servir de evidência na auditoria e na investigação de qualquer ocorrência", "Substituir a etiqueta de identificação"]', 2, 149),

    ('O que caracteriza um bloqueio apenas aparente, que dá falsa segurança à equipe?',
     '["O cadeado ser de cor diferente do padrão", "A etiqueta estar escrita à mão", "O serviço durar menos de uma hora", "O cadeado estar colocado sem que todas as fontes tenham sido identificadas, sem dissipação da energia residual e sem a verificação da energia zero: a máquina parece bloqueada e continua capaz de se mover"]', 3, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'LOTO';


-- =====================================================================
--  NR-34.5 — Trabalho a quente (questões 41 a 150)
--  As 40 antigas cuidaram da permissão, do vigia, do combustível, do
--  cilindro, do fumo, do arco e do encerramento do serviço. Estas 110
--  levam o curso para onde ele nasceu: a construção e a reparação naval.
--  Compartimento fechado com uma saída só, antepara que conduz o calor
--  para o outro lado sem ninguém ver, tanque que já teve combustível,
--  gás inerte que asfixia sem cheiro, revestimento que vira fumo tóxico
--  quando aquece, e o serviço em altura sobre dique seco. Cada
--  revestimento tem o seu veneno e cada compartimento tem a sua vítima.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-34.5')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('A que atividades a norma de construção e reparação naval se aplica?',
     '["Às atividades de construção, reparação, manutenção, conversão e desmonte de embarcações e estruturas navais, e às instalações de apoio dessas atividades", "Somente ao trabalho realizado em dique seco", "Somente à construção de navios novos", "Somente à soldagem de casco"]', 0, 41),

    ('Uma condição de segurança prevista na liberação deixou de existir no meio do serviço a quente. Quem pode parar a atividade?',
     '["Somente quem emitiu o documento de liberação", "Somente o encarregado da equipe", "Qualquer trabalhador envolvido pode e deve interromper de imediato e comunicar, porque a liberação vale enquanto as condições verificadas se mantiverem", "Somente o inspetor de segurança do estaleiro"]', 2, 42),

    ('Serviços diferentes vão ocorrer ao mesmo tempo no mesmo compartimento: solda, pintura e limpeza com solvente. O correto é:',
     '["Compatibilizar previamente as permissões de trabalho e, quando os riscos forem incompatíveis, sequenciar os serviços, porque vapor de solvente e tinta fresca com trabalho a quente é combinação explosiva", "Executar todos com o compartimento ventilado", "Executar todos juntos para ganhar tempo", "Deixar cada equipe se organizar no local"]', 0, 43),

    ('Para que serve a análise preliminar de risco antes do serviço a quente?',
     '["Para identificar, com a equipe que vai executar, os perigos daquele local e daquela tarefa e definir as medidas de controle antes do começo, e não depois que algo acontece", "Para calcular o consumo de eletrodo", "Para atender a exigência do cliente", "Para registrar o horário de início e o efetivo da equipe"]', 0, 44),

    ('O diálogo de segurança antes do turno, no estaleiro, deve tratar de:',
     '["O serviço previsto, os riscos do local, os serviços simultâneos nas proximidades, as rotas de fuga e o ponto de encontro, e as condições que exigem interromper o trabalho", "Apenas as metas de produção do dia", "Apenas a escala de refeição", "Apenas o resultado do dia anterior"]', 0, 45),

    ('Até onde vai o isolamento da área quando o serviço a quente é executado no convés?',
     '["Ser feito apenas quando há vento", "Ser dispensado quando o serviço é no costado externo", "Delimitar toda a área alcançada por respingo, escória e faísca, inclusive os níveis abaixo, com sinalização e controle de acesso, e não apenas o entorno imediato do soldador", "Se limitar a um cone e um aviso verbal"]', 2, 46),

    ('Serviços executados simultaneamente em níveis diferentes, um sobre o outro:',
     '["São normais e não exigem cuidado especial", "Podem ocorrer se todos usarem capacete", "Podem ocorrer se as equipes se comunicarem por rádio", "Devem ser evitados; quando forem inevitáveis, exigem planejamento, proteção física entre os níveis, isolamento e liberação conjunta, porque respingo, escória e ferramenta caem"]', 3, 47),

    ('A comunicação por rádio durante o serviço em compartimento interno serve para:',
     '["Coordenar apenas o ritmo da produção", "Manter contato permanente entre quem está dentro, o vigia e a equipe externa, com canal definido para emergência e confirmação periódica, porque dentro do compartimento ninguém escuta o que acontece fora", "Apenas registrar o horário do serviço", "Apenas chamar o almoxarifado"]', 1, 48),

    ('O plano de emergência do estaleiro precisa estar conhecido pela equipe antes do serviço porque:',
     '["É exigência apenas do cliente", "Faz parte do relatório mensal", "Em uma emergência dentro da embarcação não há tempo para descobrir por onde sair, quem acionar e onde é o ponto de encontro, e o percurso muda conforme a obra avança", "Serve para definir a escala de trabalho"]', 2, 49),

    ('Sobre o acesso à embarcação por portaló, escada ou passarela:',
     '["Pode ser improvisado com tábua quando o acesso oficial está ocupado", "Basta que exista um corrimão de um lado", "Pode ser usado sem proteção quando o desnível é pequeno", "Precisa ser dimensionado, fixado, com guarda-corpo, piso antiderrapante, iluminação e limite de carga respeitado, além de rede ou proteção contra queda na água quando aplicável"]', 3, 50),

    ('A iluminação dentro de compartimentos da embarcação deve ser:',
     '["A luz natural que entra pelas escotilhas", "Feita com luminárias apropriadas para o ambiente, alimentadas em tensão reduzida de segurança quando o local é úmido ou confinado, com cabos íntegros e proteção contra impacto", "Feita com refletor comum ligado por extensão improvisada", "Feita apenas com a lanterna de cada trabalhador"]', 1, 51),

    ('Mangueiras, cabos de solda e extensões dentro do compartimento:',
     '["Devem ser organizados e suspensos ou fixados fora da rota de passagem, protegidos de respingo e de esmagamento, porque no escuro e na fumaça eles são a primeira causa de tropeço e de queda", "Podem ficar apoiados sobre a estrutura quente", "Podem ficar soltos no piso, porque o espaço é pequeno", "Devem ser cortados no comprimento exato do serviço"]', 0, 52),

    ('Tanque de carga, tanque de lastro, duplo fundo, coferdame e praça de máquinas são:',
     '["Espaços que se enquadram como confinados ou de acesso restrito e que exigem avaliação da atmosfera, permissão de entrada, vigia e todo o controle previsto antes de qualquer serviço a quente", "Áreas classificadas apenas quanto ao risco elétrico", "Locais que exigem apenas ventilação", "Compartimentos comuns, sem exigência especial"]', 0, 53),

    ('Quem avalia e libera a atmosfera de um compartimento para trabalho a quente no estaleiro?',
     '["O próprio soldador, com o olfato", "Profissional capacitado e designado para a medição e a liberação da atmosfera, que registra os valores encontrados e emite a certificação com validade definida", "O encarregado da equipe, verbalmente", "O vigia de fogo, ao entrar"]', 1, 54),

    ('O que precisa ser medido antes de liberar trabalho a quente em um compartimento?',
     '["Apenas a temperatura interna", "Apenas a umidade", "O teor de oxigênio, a concentração de gases e vapores inflamáveis em relação ao limite inferior de inflamabilidade e a presença de gases tóxicos como monóxido de carbono e gás sulfídrico", "Apenas a presença de fumaça"]', 2, 55),

    ('Que margem em relação ao limite inferior de inflamabilidade se exige para autorizar o serviço?',
     '["Qualquer valor abaixo do limite libera o serviço", "Basta que o valor esteja caindo durante a medição", "O limite não se aplica a serviços rápidos", "A liberação exige valor muito abaixo do limite, conforme o critério do procedimento, porque a mistura precisa estar longe da faixa de inflamabilidade e não apenas fora dela por pouco"]', 3, 56),

    ('A medição da atmosfera feita antes da entrada:',
     '["Vale para o dia inteiro", "Vale enquanto a equipe não sair do compartimento", "Precisa ser repetida periodicamente e, sempre que possível, mantida em monitoramento contínuo, com nova medição após qualquer interrupção do serviço ou mudança de condição", "Vale até o fim da permissão emitida"]', 2, 57),

    ('O compartimento foi liberado e, no meio do serviço, a leitura do detector piora. O que explica isso?',
     '["Porque o soldador consome oxigênio ao respirar apenas", "Porque o calor da solda aquece resíduos em frestas, chapas e revestimentos e libera vapores inflamáveis ou tóxicos que não existiam na medição inicial, além dos gases gerados pelo próprio processo", "Porque a pressão externa varia com a maré", "Porque a chapa esfria e condensa umidade"]', 1, 58),

    ('Como se ventila um compartimento enquanto o serviço a quente acontece lá dentro?',
     '["Combinar insuflação de ar limpo e exaustão dos gases, com os dutos posicionados de modo a alcançar o fundo e os cantos, mantida durante todo o serviço e monitorada", "Ser desligada quando incomoda o soldador", "Ser feita apenas por insuflação de ar", "Ser feita apenas abrindo escotilhas"]', 0, 59),

    ('O ventilador que insufla ar no compartimento parou no meio do serviço. O que a equipe faz?',
     '["Continuar até o fim do cordão e depois religar o ventilador", "Abrir mais uma escotilha e prosseguir", "Reduzir a corrente da máquina para gerar menos fumo", "Interromper o serviço, deixar o equipamento em condição segura, sair do compartimento e só retornar depois de restabelecida a ventilação e refeita a medição da atmosfera"]', 3, 60),

    ('Tanques inertizados com gás inerte apresentam qual risco principal?',
     '["Explosão pelo gás inerte", "Asfixia, porque o gás desloca o oxigênio e não tem cheiro nem cor, matando antes que a pessoa perceba, o que exige medição, ventilação e liberação formal antes da entrada", "Corrosão da estrutura", "Aumento da temperatura interna"]', 1, 61),

    ('Resíduos acumulados em sentinas, porões e cantos do compartimento, antes do trabalho a quente:',
     '["Podem permanecer se estiverem molhados", "Só interessam se forem visíveis da escotilha", "Precisam ser removidos e o local limpo e verificado, porque borra, óleo e restos de carga liberam vapores inflamáveis ao serem aquecidos e pegam fogo por faísca que caiu horas antes", "Podem ser cobertos com areia"]', 2, 62),

    ('Um compartimento adjacente ao local da solda contém produto inflamável. Isso significa que:',
     '["Não há problema, porque a antepara separa os ambientes", "Basta ventilar o compartimento onde ocorre a solda", "Basta sinalizar o compartimento vizinho", "O calor atravessa a chapa por condução e pode inflamar o produto do outro lado; é preciso avaliar e liberar também o compartimento adjacente, esvaziar ou inertizar quando necessário e manter vigia do outro lado"]', 3, 63),

    ('O certificado de compartimento livre de gás, emitido antes do serviço, atesta que:',
     '["A embarcação está limpa para inspeção do cliente", "Naquele momento e naquelas condições a atmosfera do espaço foi avaliada e está dentro dos parâmetros para a atividade autorizada, com validade limitada e sujeita a nova avaliação se algo mudar", "O compartimento está permanentemente seguro", "A ventilação pode ser desligada"]', 1, 64),

    ('O controle de entrada e saída do compartimento serve para:',
     '["Registrar a produtividade da equipe", "Controlar o uso do rádio", "Saber exatamente quem está dentro a cada instante, porque em uma emergência é essa lista que define quantas pessoas precisam ser resgatadas e onde procurar", "Definir a ordem de refeição"]', 2, 65),

    ('O equipamento de resgate para trabalho em compartimento confinado deve:',
     '["Estar montado e posicionado na entrada, com a equipe treinada para usá-lo, porque a maioria das mortes em espaço confinado é de quem entrou para socorrer sem equipamento", "Ser buscado quando a emergência acontecer", "Ser improvisado com corda e talha do local", "Ficar guardado no almoxarifado do estaleiro"]', 0, 66),

    ('Cilindros de gás podem ser levados para dentro do compartimento confinado?',
     '["Podem, se forem presos por corrente", "Não: os cilindros permanecem fora, em local ventilado e seguro, e apenas as mangueiras e o maçarico entram, porque vazamento de gás dentro do compartimento forma atmosfera explosiva em minutos", "Podem, se o serviço durar pouco", "Podem, se houver ventilação forçada"]', 1, 67),

    ('Nas pausas e ao fim do turno, o maçarico e as mangueiras devem:',
     '["Ser retirados do compartimento, com as válvulas dos cilindros fechadas e as mangueiras aliviadas, porque vazamento em ambiente fechado e sem ninguém por perto acumula gás até a próxima faísca", "Ser deixados pendurados na estrutura", "Ficar no local do serviço, para agilizar a retomada", "Ser cobertos com lona"]', 0, 68),

    ('Quando o trabalho a quente ocorre em mais de um nível ou compartimento ao mesmo tempo:',
     '["Um vigia é suficiente, desde que circule entre os locais", "O soldador pode acumular a função de vigia", "O vigia pode ficar apenas no nível superior", "É preciso vigia em cada local onde a faísca pode alcançar, inclusive nos níveis inferiores e do outro lado das anteparas, porque um vigia não observa dois ambientes ao mesmo tempo"]', 3, 69),

    ('Depois que o serviço a quente termina, o vigia de fogo:',
     '["Pode sair junto com o soldador", "Permanece observando a área e as áreas adjacentes pelo período definido no procedimento, com nova ronda antes do encerramento, porque o foco iniciado por uma faísca leva tempo para se manifestar", "Só permanece se houver material combustível visível", "Permanece apenas até o soldador guardar o equipamento"]', 1, 70),

    ('O soldador saiu para o intervalo de refeição e o serviço a quente ainda não terminou. O vigia de fogo:',
     '["Sai junto, porque não há mais chama sendo produzida", "Permanece observando a área pelo período previsto após a última faísca, porque é justamente com a área vazia que o foco iniciado cresce sem ninguém ver", "Aproveita para executar outra tarefa nas proximidades", "Fica dispensado assim que os equipamentos são desligados"]', 1, 71),

    ('Por que é necessário vigia do outro lado da antepara ou da chapa onde se está soldando?',
     '["Para conferir a qualidade do cordão", "Para segurar a peça durante a solda", "Para medir a temperatura da chapa", "Porque o calor atravessa o metal e pode inflamar tinta, isolamento térmico, cabo elétrico ou material estivado do outro lado, sem que o soldador tenha qualquer visão daquilo"]', 3, 72),

    ('Quando há serviço a quente em nível superior, o vigia posicionado no nível inferior:',
     '["É desnecessário se houver piso de aço", "É necessário porque respingo e escória atravessam frestas, aberturas de piso, passagens de cabo e dutos e iniciam fogo em local que ninguém está observando", "Só é necessário à noite", "Substitui o vigia do nível superior"]', 1, 73),

    ('A ronda de verificação após o serviço a quente deve incluir:',
     '["Apenas o ponto exato da solda", "Apenas a área isolada", "O ponto do serviço, o entorno, os níveis inferiores, os compartimentos adjacentes e todos os locais alcançados por faísca ou pelo calor conduzido, procurando fumaça, cheiro de queimado e aquecimento", "Apenas o local onde ficou a escória"]', 2, 74),

    ('Colegas de outras equipes passam a poucos metros do ponto de solda. Como protegê-los?',
     '["Basta avisá-las verbalmente", "Basta que usem capacete", "Basta que passem rapidamente", "É preciso isolar e sinalizar a área, instalar barreiras e biombos e controlar o acesso, porque quem passa não está com proteção ocular e não sabe que ali existe respingo, radiação e escória"]', 3, 75),

    ('Existe equipe no nível de baixo. Como protegê-la do que cai do serviço a quente?',
     '["Bandeja, tela, manta ou anteparo resistente ao fogo instalado entre os níveis, além do isolamento e do vigia, e não apenas com aviso", "Aviso por rádio antes de cada abertura de arco", "Capacete e óculos para todos", "Redução da corrente de soldagem"]', 0, 76),

    ('Material e equipamento de outras equipes deixados na área do serviço a quente:',
     '["Podem permanecer se estiverem cobertos com lona plástica", "Podem permanecer se forem metálicos", "Precisam ser retirados da área ou protegidos com material resistente ao fogo, e isso inclui mangueiras, cabos, garrafas, estopa, embalagens e cilindros de outras equipes", "Podem permanecer se a equipe for avisada"]', 2, 77),

    ('Um trabalhador reclama de dor nos olhos horas depois de ter passado perto de uma solda sem proteção. Isso indica:',
     '["Queimadura da superfície do olho pela radiação ultravioleta do arco, que dói horas depois da exposição, e mostra que a barreira e o isolamento da área falharam", "Reação alérgica ao fumo de solda", "Efeito da poeira do esmerilhamento", "Cansaço visual comum do fim do turno"]', 0, 78),

    ('Trabalho a quente próximo a área de vivência, refeitório ou vestiário do estaleiro:',
     '["Pode ser executado normalmente, porque são áreas administrativas", "Exige avaliação específica, isolamento reforçado, controle do horário e proteção contra fumo, radiação e propagação de fogo, porque ali circulam pessoas sem qualquer proteção e sem saber do serviço", "É proibido em qualquer circunstância", "Basta comunicar o encarregado da cozinha"]', 1, 79),

    ('Não é possível proteger adequadamente as pessoas e o material em torno do serviço a quente. O correto é:',
     '["Não iniciar o serviço: interditar e reorganizar a área, remanejar as demais equipes ou reprogramar a atividade, porque não existe trabalho a quente com terceiros expostos", "Executar com corrente reduzida", "Executar o serviço mais rápido para reduzir a exposição", "Executar durante o intervalo de refeição"]', 0, 80),

    ('O equipamento de soldagem instalado a bordo precisa atender a quê?',
     '["Apenas estar ligada a um quadro qualquer", "Apenas ter o cabo do eletrodo íntegro", "Apenas estar protegida da chuva", "Ser alimentada por circuito adequado e protegido, ter carcaça aterrada, ficar em local seco e ventilado e ser inspecionada, porque a máquina é a origem de boa parte dos choques em serviço de solda"]', 3, 81),

    ('Cabos de solda com emenda improvisada e isolamento rompido:',
     '["Podem ser usados se a emenda estiver enrolada com fita", "São causa de choque, de aquecimento e de arco acidental sobre a estrutura, e precisam ser substituídos ou emendados apenas com conectores apropriados e isolados", "São aceitáveis em serviços de baixa corrente", "Só oferecem risco em ambiente molhado"]', 1, 82),

    ('Sobre o cabo de retorno da máquina de solda quando o casco está molhado ou o trabalhador está sobre estrutura metálica úmida:',
     '["Não há diferença em relação ao serviço em ambiente seco", "Basta usar luva de raspa seca", "O risco de choque aumenta muito: o cabo de retorno precisa ser fixado diretamente na peça e o mais próximo possível do ponto de trabalho, e o local deve ser seco, com estrado isolante e roupa seca", "Basta reduzir a corrente da máquina"]', 2, 83),

    ('Em local úmido, confinado ou de circulação restrita, a máquina de solda a arco deve:',
     '["Trabalhar com a maior corrente possível para reduzir o tempo de serviço", "Ser substituída por maçarico", "Ser ligada em corrente alternada sempre", "Dispor de dispositivo redutor da tensão em vazio ou equipamento apropriado para essas condições, porque a tensão em vazio da máquina já é suficiente para causar choque grave em ambiente úmido"]', 3, 84),

    ('Quais são os riscos específicos do corte com plasma?',
     '["Apenas o ruído do equipamento", "Ruído elevado, radiação ultravioleta intensa, fumo metálico abundante, projeção de metal fundido e risco elétrico, exigindo exaustão, proteção ocular e auditiva e isolamento reforçado da área", "Apenas a projeção de faíscas", "Apenas o consumo elevado de energia"]', 1, 85),

    ('A goivagem a arco-ar apresenta como risco adicional:',
     '["Apenas o consumo de eletrodo de carvão", "Apenas a irregularidade do corte", "Ruído muito elevado somado à projeção de grande quantidade de metal fundido a distância, além de fumo intenso, o que exige proteção auditiva, isolamento ampliado da área e exaustão eficiente", "Apenas o aquecimento do porta-eletrodo"]', 2, 86),

    ('Na soldagem com gás de proteção dentro de compartimento fechado, o cuidado adicional é:',
     '["Apenas com o consumo do gás", "Apenas com a limpeza do bico", "Apenas com o comprimento do cabo", "O gás de proteção desloca o oxigênio do ambiente e pode gerar atmosfera asfixiante em local confinado, o que exige ventilação e monitoramento contínuo da atmosfera durante todo o serviço"]', 3, 87),

    ('O lixamento e o apontamento do eletrodo de tungstênio usado na soldagem TIG:',
     '["Não apresenta risco, porque o tungstênio é inerte", "Deve ser feito com exaustão ou proteção respiratória adequada, porque alguns eletrodos contêm tório, que é radioativo, e o pó gerado pode ser inalado", "Deve ser feito com a máquina ligada", "Só apresenta risco quando o eletrodo é novo"]', 1, 88),

    ('Na soldagem por arco submerso, além do fumo, deve-se atentar para:',
     '["O manuseio e a recuperação do fluxo, que gera poeira e pode estar quente, e o ruído do sistema de recuperação, além do risco de queimadura pelo fluxo aquecido", "Apenas a velocidade de avanço", "Apenas a cor do cordão", "Apenas o consumo do arame"]', 0, 89),

    ('O aquecimento de chapas com maçarico, para conformação ou pré-aquecimento:',
     '["É trabalho a quente para todos os efeitos, exige permissão, vigia e controle da área, e ainda aquece revestimentos e o outro lado da chapa, gerando vapores e risco de fogo a distância", "Dispensa a permissão de trabalho por não gerar respingo", "Só exige cuidado com o consumo de gás", "Não é trabalho a quente, porque não há solda"]', 0, 90),

    ('Na brasagem com varetas que contêm cádmio, o risco é:',
     '["Apenas a queimadura pelo maçarico", "A inalação do fumo de cádmio, altamente tóxico mesmo em curta exposição, que exige exaustão localizada, proteção respiratória adequada e preferência por varetas sem cádmio", "Apenas a má qualidade da junta", "Apenas o custo elevado da vareta"]', 1, 91),

    ('Cortar ou soldar chapa pintada, sem remover a tinta da região do corte:',
     '["Não muda nada, porque a tinta queima rapidamente", "Melhora a proteção da chapa", "Gera fumos e gases tóxicos a partir da decomposição da tinta e do primer, e por isso o revestimento é removido da área de trabalho e se mantém exaustão e proteção respiratória adequadas", "Só é problema em tinta de cor escura"]', 2, 92),

    ('Soldar ou cortar material galvanizado pode provocar:',
     '["Apenas mau cheiro", "Apenas manchas no cordão de solda", "Apenas irritação nos olhos", "A chamada febre dos fumos metálicos, causada pela inalação do óxido de zinco, com febre, calafrios e dores horas depois da exposição, o que exige remoção do revestimento, exaustão e proteção respiratória"]', 3, 93),

    ('A soldagem de aço inoxidável apresenta como risco de saúde específico:',
     '["Nenhum risco diferente do aço carbono", "A geração de compostos de cromo hexavalente no fumo, reconhecidos como cancerígenos, o que exige exaustão localizada eficiente e proteção respiratória adequada", "Apenas o brilho maior do arco", "Apenas a maior temperatura da poça de fusão"]', 1, 94),

    ('A exposição prolongada ao manganês presente no fumo de solda está associada a:',
     '["Problemas de pele apenas", "Perda auditiva", "Efeitos neurológicos, com sintomas semelhantes aos da doença de Parkinson, o que reforça a necessidade de controle da exposição ao fumo ao longo da carreira do soldador", "Redução da capacidade visual apenas"]', 2, 95),

    ('Cortar ou soldar estrutura antiga revestida com tinta que contém chumbo:',
     '["Não apresenta risco se a tinta estiver seca", "Basta usar máscara de tecido", "Basta molhar a superfície", "Libera fumo de chumbo, com efeito tóxico cumulativo no organismo, e exige remoção controlada do revestimento, contenção, exaustão, proteção respiratória adequada, higiene rigorosa e controle médico"]', 3, 96),

    ('Solvente clorado usado na limpeza de peças, próximo a um arco elétrico:',
     '["Não apresenta interação com o arco", "Pode se decompor sob a radiação ultravioleta do arco e formar gases altamente tóxicos, e por isso a limpeza com esse tipo de solvente é mantida afastada e a peça precisa estar seca antes da solda", "Melhora a qualidade do cordão", "Apenas aumenta o cheiro no ambiente"]', 1, 97),

    ('O ozônio e os óxidos de nitrogênio gerados pelo arco elétrico:',
     '["Irritam as vias respiratórias e, em ambiente pouco ventilado, causam efeito agudo nos pulmões, o que reforça a exigência de ventilação e exaustão durante o serviço", "Apenas causam mau cheiro", "Não têm efeito sobre a saúde", "São neutralizados pelo gás de proteção"]', 0, 98),

    ('O jateamento executado antes da solda, na preparação da superfície:',
     '["Não interfere no trabalho a quente", "Só exige proteção auditiva", "Só exige o controle do consumo de abrasivo", "Gera grande quantidade de poeira e pode deixar resíduo abrasivo e revestimento removido acumulado no compartimento, o que exige limpeza, ventilação, nova avaliação da atmosfera e liberação antes de iniciar o serviço a quente"]', 3, 99),

    ('A limpeza mecânica da região a ser soldada, com escova ou esmerilhadeira:',
     '["É apenas um requisito de qualidade do cordão", "É também medida de segurança, porque remove tinta, óleo, ferrugem e revestimento que se transformariam em fumo tóxico e em fonte de ignição durante o aquecimento", "Deve ser feita depois da solda", "Pode ser dispensada quando a chapa é nova"]', 1, 100),

    ('A manta usada para cobrir equipamento e material próximo ao ponto de solda precisa:',
     '["Apenas cobrir o material, sem outro requisito", "Ser de lona plástica, que é leve e fácil de manusear", "Ser de material resistente ao fogo, estar íntegra e sem furos, cobrir com sobreposição e ficar fixada para não abrir com o vento ou com o movimento da equipe, além de ser inspecionada antes do uso", "Ser molhada antes de cada serviço"]', 2, 101),

    ('A mangueira de hidrante ou a linha de água pressurizada disponível no local do serviço a quente:',
     '["Quando prevista, deve estar desenrolada, conectada e pressurizada até o ponto de uso, com o operador definido, porque desenrolar mangueira durante o incêndio custa o tempo que decide o resultado", "Deve ficar enrolada no abrigo até que se precise dela", "Só é exigida em serviços de longa duração", "É desnecessária se houver extintor"]', 0, 102),

    ('Durante o reparo, os sistemas fixos de detecção e de combate a incêndio do próprio navio:',
     '["Continuam operando normalmente sem qualquer providência", "Podem estar desativados ou parcialmente fora de operação, e isso precisa ser identificado, registrado na permissão e compensado com medidas alternativas de detecção, combate e vigilância", "Podem ser desativados livremente pela equipe de obra", "Substituem o vigia de fogo"]', 1, 103),

    ('Um compartimento em obra tem apenas uma saída. Isso exige:',
     '["Manter a rota totalmente desobstruída e iluminada durante todo o serviço, controlar rigorosamente o material combustível no interior, posicionar o serviço a quente de modo a nunca ficar entre o fogo e a saída e prever meio de resgate", "Apenas um vigia externo", "Nada de especial, desde que haja iluminação", "Apenas rádio para o pessoal de dentro"]', 0, 104),

    ('A iluminação de emergência e a lanterna individual no serviço em compartimento interno:',
     '["São dispensáveis quando há iluminação provisória instalada", "Servem apenas para inspeção de qualidade", "Só são necessárias em serviço noturno", "São indispensáveis, porque a fumaça e a queda da iluminação provisória deixam o compartimento totalmente escuro e a saída deixa de ser encontrada por quem conhece o local"]', 3, 105),

    ('Surge fumaça dentro do compartimento em que a equipe está trabalhando. Qual a primeira atitude?',
     '["Continuar o serviço e observar se a fumaça aumenta", "Abrir todas as escotilhas para ventilar antes de qualquer coisa", "Interromper imediatamente, deixar o equipamento em condição segura, evacuar o compartimento pela rota prevista, acionar o alarme e a brigada e só retornar após a liberação, porque em ambiente fechado a fumaça incapacita em poucos minutos", "Procurar a origem da fumaça antes de sair"]', 2, 106),

    ('O combate a um princípio de incêndio dentro de um compartimento fechado:',
     '["Deve ser feito até apagar, custe o que custar", "Só é iniciado com a rota de saída livre atrás de quem combate, com apoio externo avisado e recuo imediato se o fogo crescer, se a fumaça aumentar ou se o extintor se esgotar", "Deve ser feito por uma pessoa sozinha para não expor a equipe", "Deve aguardar sempre a chegada do corpo de bombeiros externo"]', 1, 107),

    ('Uma vítima ficou inconsciente dentro de um compartimento durante o serviço. O correto é:',
     '["Entrar imediatamente para retirá-la, prendendo a respiração", "Aguardar do lado de fora até ela reagir", "Acionar o alarme e a equipe de resgate, informar a localização exata e o número de pessoas, e não entrar sem equipamento de proteção respiratória adequado e sem estar treinado e autorizado, porque a segunda vítima costuma ser quem foi socorrer", "Jogar água no rosto da vítima pela escotilha"]', 2, 108),

    ('A comunicação com a brigada do estaleiro em uma emergência precisa informar:',
     '["Apenas o nome da embarcação", "Apenas o número da permissão de trabalho", "Apenas o nome do encarregado", "A embarcação, o compartimento e o nível exatos, o que está queimando ou vazando, quantas pessoas estão envolvidas e o acesso disponível, mantendo alguém no ponto de acesso para orientar a equipe que chega"]', 3, 109),

    ('Os exercícios simulados de emergência no estaleiro servem para:',
     '["Testar na prática o alarme, a rota, o tempo de evacuação de dentro das embarcações, a conferência das pessoas e o acionamento do resgate, revelando as falhas enquanto ainda não há fogo de verdade", "Cumprir uma formalidade do sistema de gestão", "Interromper a produção periodicamente", "Avaliar individualmente cada trabalhador"]', 0, 110),

    ('Detectado vazamento de gás combustível no convés durante o serviço a quente, a conduta é:',
     '["Interromper todo o trabalho a quente da área e das áreas vizinhas, fechar as válvulas dos cilindros se for possível fazê-lo com segurança, afastar as pessoas, eliminar fontes de ignição e acionar a emergência", "Ventilar com oxigênio para dispersar o gás", "Apagar apenas o maçarico e continuar o restante do serviço", "Procurar o ponto de vazamento com a chama do maçarico"]', 0, 111),

    ('O transporte de cilindros no estaleiro deve ser feito:',
     '["Rolando o cilindro pela base até o local", "Carregando nos ombros quando a distância é curta", "Arrastando pelo capacete de proteção da válvula", "Em carrinho apropriado, com o cilindro preso e o capacete de proteção da válvula colocado, sem rolar, arrastar ou deixar tombar"]', 3, 112),

    ('Para içar cilindros de gás até o convés, o correto é:',
     '["Amarrar uma corda no capacete de proteção da válvula", "Usar cesta ou dispositivo apropriado, com os cilindros presos e na posição vertical, nunca içando por eletroímã, corda amarrada no corpo ou pelo capacete da válvula", "Usar eletroímã, porque o cilindro é metálico", "Içar dois cilindros amarrados um ao outro"]', 1, 113),

    ('No armazenamento de cilindros de oxigênio e de gases combustíveis:',
     '["Podem ficar juntos, se estiverem em pé", "Podem ficar juntos, se estiverem com as válvulas fechadas", "Precisam ficar separados por distância adequada ou por barreira resistente ao fogo, em área ventilada, protegida do sol e do calor, com os cilindros presos e identificados", "Podem ficar em qualquer lugar, desde que sinalizados"]', 2, 114),

    ('Cilindros vazios no estaleiro devem:',
     '["Ser identificados como vazios, mantidos com a válvula fechada e o capacete de proteção colocado e armazenados separados dos cheios, em pé e presos", "Ser devolvidos sem qualquer identificação", "Ser armazenados junto com os cheios para facilitar a logística", "Ser deixados deitados para diferenciar dos cheios"]', 0, 115),

    ('A válvula contra retrocesso de chama e o corta-chama no conjunto de oxicorte:',
     '["São acessórios opcionais de conforto", "Devem ser instalados conforme a especificação, no maçarico e no regulador, e inspecionados periodicamente, porque são eles que impedem que a chama volte pela mangueira até o cilindro", "Substituem a inspeção das mangueiras", "Só são exigidos em serviço confinado"]', 1, 116),

    ('Usar o regulador de pressão de um gás em cilindro de outro gás:',
     '["É aceitável se as roscas encaixarem", "É aceitável em serviço rápido", "É proibido: cada gás tem regulador específico, com material, rosca e faixa de pressão próprios, e a troca pode causar vazamento, ignição e explosão", "É aceitável se a pressão for reduzida"]', 2, 117),

    ('Mangueiras que passam por vãos de porta, escotilhas ou passagens:',
     '["Podem ficar por qualquer caminho, se estiverem íntegras", "Podem ser presas na estrutura com arame", "Podem passar por cima de peças quentes se estiverem novas", "Devem ser protegidas contra esmagamento, corte e calor, com passagem definida e sinalizada, porque porta que fecha sobre a mangueira gera vazamento sem ninguém perceber"]', 3, 118),

    ('Mangueiras pressurizadas deixadas dentro do compartimento durante uma interrupção do serviço:',
     '["Podem permanecer, se as válvulas do maçarico estiverem fechadas", "São risco de acúmulo de gás em ambiente fechado e sem vigilância, e por isso as válvulas dos cilindros são fechadas, a linha é aliviada e o conjunto é retirado do compartimento", "Podem permanecer, se houver ventilação", "Podem permanecer, se a interrupção for curta"]', 1, 119),

    ('Ao abrir a válvula de um cilindro de gás, o trabalhador deve:',
     '["Abrir devagar, posicionado ao lado e nunca à frente do regulador nem na linha de saída da válvula, porque uma falha do regulador projeta peças com violência", "Abrir com a ajuda de uma chave improvisada", "Abrir rapidamente até o fim para garantir a vazão", "Abrir com o maçarico já aceso"]', 0, 120),

    ('Cilindros deixados no convés sob sol forte ou perto de fonte de calor:',
     '["Não apresentam risco, porque são de aço", "Apenas dificultam o manuseio pelo aquecimento da superfície", "Devem apenas ser molhados periodicamente", "Sofrem aumento da pressão interna e podem chegar à abertura do dispositivo de alívio ou ao rompimento, e por isso são armazenados em local protegido, ventilado e afastado de fontes de calor"]', 3, 121),

    ('Que exigências o andaime empregado em serviço a quente a bordo tem de cumprir?',
     '["Apenas ter piso completo", "Ter piso completo e travado, ser montado e liberado por pessoal capacitado, ter as tábuas e componentes protegidos contra respingo e escória, e contar com sistema de proteção contra queda", "Ser montado apenas com material metálico", "Ser dispensado quando o serviço é rápido"]', 1, 122),

    ('A ancoragem do sistema de proteção contra queda em estrutura naval em construção:',
     '["Pode ser feita em qualquer parte da estrutura", "Pode ser feita em tubulação ou eletroduto próximo", "Precisa ser definida por profissional habilitado e feita em elemento estrutural já consolidado e capaz de suportar a carga, porque estrutura em montagem pode não ter a resistência final", "Pode ser feita no próprio guarda-corpo do andaime"]', 2, 123),

    ('O trabalho executado em dique seco apresenta como risco adicional:',
     '["Apenas a umidade do piso", "Apenas o acesso mais longo", "Apenas o ruído do bombeamento", "Quedas de grande altura a partir do costado e do convés, circulação em área com desnível acentuado, movimentação de equipamentos no fundo do dique e alagamento programado, o que exige proteção contra queda, controle de acesso e comunicação com a operação do dique"]', 3, 124),

    ('Serviço a quente executado no costado a partir de plataforma elevatória:',
     '["Dispensa a proteção contra queda, porque a plataforma tem guarda-corpo", "Exige proteção contra queda conectada ao ponto previsto pelo fabricante, operador capacitado, avaliação do vento e proteção dos componentes da plataforma contra respingo e escória", "Dispensa o vigia de fogo, porque o serviço é externo", "Pode ser executado com duas pessoas acima da capacidade nominal se o serviço for rápido"]', 1, 125),

    ('A linha de vida instalada no convés para o trabalho a quente:',
     '["Pode ser improvisada com cabo de aço amarrado em dois pontos", "Pode ser usada por quantas pessoas forem necessárias", "Precisa ser projetada e instalada conforme especificação, com número de usuários definido, e protegida do respingo de solda, porque respingo em cabo ou fita compromete a resistência do conjunto", "Só é exigida quando não há guarda-corpo"]', 2, 126),

    ('Sobre a escada de mão empregada no acesso interno durante o reparo:',
     '["Precisa ser adequada, fixada, com apoio estável, ultrapassando o ponto de apoio superior, sem uso dos últimos degraus, e não serve como posto de trabalho para serviço a quente", "Pode ser usada como plataforma para soldar", "Pode ser posicionada sobre material empilhado", "Pode ser apoiada em qualquer superfície disponível"]', 0, 127),

    ('Para evitar a queda de ferramentas durante o serviço a quente em altura:',
     '["Basta avisar quem está embaixo", "Usa-se cordinha de retenção nas ferramentas, bolsa ou recipiente fechado para transporte e componentes, além do isolamento do nível inferior, porque ferramenta leve em queda de altura mata", "Basta trabalhar com poucas ferramentas", "Basta manter as ferramentas no piso da plataforma"]', 1, 128),

    ('Antes de subir para o serviço a quente em altura, o que já precisa estar resolvido quanto ao resgate?',
     '["Estar definido antes do início do serviço, com equipe, equipamento e meio de acesso disponíveis no local, porque o trabalhador suspenso pelo cinto tem poucos minutos antes de o quadro se agravar", "Se limitar ao acionamento do corpo de bombeiros", "Ser acionado apenas quando o acidente acontecer", "Ser o mesmo utilizado para emergências médicas comuns"]', 0, 129),

    ('O controle médico ocupacional do soldador considera:',
     '["Apenas o exame clínico anual", "Apenas a acuidade visual", "Apenas o exame admissional", "Os agentes a que ele fica exposto, com avaliação respiratória, auditiva, oftalmológica e o que mais o risco exigir, além do acompanhamento ao longo do tempo, porque grande parte dos efeitos é cumulativa"]', 3, 130),

    ('O uso de respirador motorizado com filtro sob a máscara de solda serve para:',
     '["Refrigerar o rosto do soldador", "Fornecer ar filtrado dentro da máscara, reduzindo a inalação do fumo em serviços prolongados ou em local onde a exaustão localizada não é suficiente", "Substituir a exaustão localizada em qualquer situação", "Melhorar a visão do cordão de solda"]', 1, 131),

    ('Na goivagem e no esmerilhamento, além da proteção respiratória e ocular:',
     '["Basta a luva de raspa", "Basta o avental de couro", "É indispensável a proteção auditiva adequada ao nível de ruído, porque esses processos estão entre os mais ruidosos do estaleiro e a perda auditiva é irreversível", "Basta reduzir a rotação do equipamento"]', 2, 132),

    ('A vestimenta do soldador que trabalha em área com risco de arco elétrico ou de fogo repentino:',
     '["Pode ser apenas a de raspa de couro, que já resiste ao respingo", "Pode ser qualquer uniforme de brim", "Pode incluir camiseta sintética por baixo, se a peça externa for de couro", "Precisa formar um conjunto compatível: peça de raspa contra o respingo sobre vestimenta que não propague a chama nem derreta, sem tecido sintético em contato com a pele"]', 3, 133),

    ('Roupa impregnada de óleo ou graxa em serviço a quente:',
     '["Não apresenta risco depois de seca", "Deve ser trocada antes do serviço, porque tecido impregnado inflama com facilidade a partir de uma única fagulha e mantém a chama junto ao corpo", "Pode ser usada se estiver por baixo do avental", "Só é problema em serviço com maçarico"]', 1, 134),

    ('A proteção da cabeça, do pescoço e das orelhas no serviço a quente exige:',
     '["Apenas o capacete", "Apenas a máscara de solda", "Touca ou balaclava resistente à chama sob o capacete e a máscara, porque fagulha e respingo entram pela gola, alojam-se no pavilhão da orelha e causam queimadura profunda", "Apenas o protetor auricular tipo concha"]', 2, 135),

    ('O trabalho a quente dentro de compartimento fechado, do ponto de vista do calor:',
     '["Não difere do trabalho a céu aberto", "Melhora com o uso de vestimenta mais leve", "Exige apenas um ventilador voltado para o trabalhador", "Soma calor do processo, calor do ambiente e vestimenta pesada, e exige regime de trabalho e descanso, hidratação disponível, revezamento e atenção aos sinais de sobrecarga térmica"]', 3, 136),

    ('Em soldagem executada em posição forçada, sobrecabeça ou dentro de espaço apertado:',
     '["A pausa deve ser reduzida para diminuir o tempo total de exposição", "É preciso prever revezamento, pausas e, quando possível, dispositivo que permita reposicionar a peça, porque a postura sustentada com carga é lesiva e o cansaço aumenta o erro em serviço com fogo", "Basta escolher soldadores mais experientes", "Basta reduzir a corrente da máquina"]', 1, 137),

    ('Queimaduras em pescoço, punhos e tornozelos do soldador indicam geralmente:',
     '["Que há pele exposta nas junções da vestimenta, e a correção é ajustar o conjunto para que gola, punho e barra fiquem fechados e sobrepostos, além de rever a posição de trabalho", "Que o EPI está vencido", "Que o serviço foi executado com corrente alta demais", "Que o trabalhador é alérgico ao fumo"]', 0, 138),

    ('A exposição ao ruído no estaleiro deve ser avaliada:',
     '["Considerando o conjunto da jornada e todos os processos a que o trabalhador fica exposto, inclusive o ruído das equipes vizinhas, porque a dose se acumula ao longo do dia e não por atividade isolada", "Apenas durante a goivagem", "Apenas quando o trabalhador reclama", "Apenas no setor de caldeiraria"]', 0, 139),

    ('Um soldador foi designado para executar serviço sozinho dentro de um compartimento. Isso é:',
     '["Aceitável se o serviço for curto", "Aceitável se ele levar rádio", "Inaceitável: o serviço em compartimento exige vigia externo permanente, comunicação e meio de resgate, e ninguém executa trabalho a quente confinado sem acompanhamento", "Aceitável se ele for experiente"]', 2, 140),

    ('O supervisor autorizou o início do serviço a quente por rádio, sem a permissão emitida. O soldador deve:',
     '["Iniciar, porque a autorização veio de quem manda", "Iniciar e regularizar a permissão depois", "Iniciar apenas a preparação do equipamento e depois soldar", "Não iniciar: a permissão é o documento que registra que as condições foram verificadas em campo, e autorização verbal não substitui a medição da atmosfera, o isolamento e o vigia"]', 3, 141),

    ('O vigia de fogo foi chamado para ajudar em outra tarefa no meio do serviço. O correto é:',
     '["Interromper o trabalho a quente até que haja vigia dedicado no local, porque serviço a quente sem vigia observando não pode continuar", "Continuar, já que o vigia volta em seguida", "Continuar com o próprio soldador observando a área", "Continuar com um trabalhador de outra equipe olhando de longe"]', 0, 142),

    ('O extintor da área do serviço foi utilizado em um princípio de fogo e o serviço vai continuar. O correto é:',
     '["Continuar, porque o fogo foi apagado", "Interromper o serviço até que o extintor seja substituído por outro com carga plena e adequado ao risco, porque extintor usado não é recurso disponível", "Continuar e providenciar a recarga no fim do turno", "Continuar com o extintor do setor vizinho no lugar, sem conferir o tipo"]', 1, 143),

    ('O detector de gás usado na liberação do compartimento está com a calibração vencida. Isso significa que:',
     '["A leitura continua confiável se o aparelho ligar normalmente", "Basta comparar com outro aparelho no local", "A medição não é confiável e não pode fundamentar a liberação: o serviço não é liberado até que haja instrumento calibrado, com verificação funcional antes do uso", "Basta usar o aparelho com margem de segurança maior"]', 2, 144),

    ('Trabalho a quente sobre ou junto a tanque que contém combustível:',
     '["Pode ser executado se o tanque estiver com a tampa fechada", "Pode ser executado se a chapa for grossa", "Pode ser executado com resfriamento por água", "Não é liberado nessa condição: é preciso esvaziar, limpar, desgaseificar e, quando previsto, inertizar o tanque, com medição e liberação formal, porque o vapor acima do produto é o que explode"]', 3, 145),

    ('Antes de soldar em tubulação de óleo lubrificante ou de combustível da embarcação:',
     '["É preciso isolar e bloquear a linha, drenar, limpar e desgaseificar o trecho, confirmar a ausência de produto e de vapores com medição e liberar por escrito, porque resíduo dentro do tubo explode com o calor", "Basta drenar o trecho visível da linha", "Basta fechar a válvula mais próxima", "Basta soldar com corrente reduzida"]', 0, 146),

    ('No desmonte de estrutura, antes de cortar um elemento que sustenta carga:',
     '["Basta cortar de cima para baixo", "É preciso definir a sequência de corte, escorar ou sustentar previamente a parte a ser liberada e isolar a área de queda, porque o corte de um elemento estrutural provoca movimento repentino de toda a peça", "Basta manter as pessoas afastadas dois metros", "Basta cortar com corrente reduzida"]', 1, 147),

    ('Uma fagulha caiu em uma pilha de estopa a alguns metros do soldador e o fogo começou minutos depois. Isso mostra que:',
     '["A fagulha foi excepcionalmente grande", "O extintor estava mal posicionado", "O material combustível não foi removido nem protegido, o alcance da faísca foi subestimado e a área não estava sob observação de vigia, que são justamente as três medidas que evitam esse incêndio", "O soldador deveria estar usando outro processo de solda"]', 2, 148),

    ('Ao encerrar o turno com serviço a quente ainda em andamento, a passagem para o turno seguinte precisa incluir:',
     '["Apenas a informação sobre o andamento da produção", "Apenas a entrega das ferramentas", "Apenas o preenchimento do relatório diário", "O que foi executado, o estado das áreas aquecidas e das adjacências, a situação da permissão, os pontos que ainda exigem observação e a confirmação de que a ronda pós-serviço foi feita, com registro"]', 3, 149),

    ('Qual é a diferença prática entre a permissão de trabalho emitida e as condições encontradas no local?',
     '["Não pode haver diferença, porque a permissão descreve a realidade", "A permissão prevalece sobre o que se encontra no local", "A permissão autoriza a atividade nas condições verificadas na emissão; se a equipe encontra a área diferente, com outra equipe trabalhando, material novo, ventilação parada ou proteção removida, o serviço não começa e a liberação precisa ser refeita", "A diferença só importa se for percebida pelo supervisor"]', 2, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-34.5';


-- a aprovação continua em 70% para todo mundo
update public.trein_curso set nota_minima = 70;

-- #####################################################################
-- ##  Banco GRANDE 4 (NR-01-INT4, NR-01-INT8, DD, DD-REC)
-- ##  (de 24-banco-grande-4.sql)
-- #####################################################################

-- =====================================================================
--  Banco grande 4 — Integração (4h e 8h) e Direção defensiva (normal e
--  reciclagem). Faixa 41 a 150: 110 questões novas por curso, 440 no total.
--
--  ATENÇÃO: ESTAS PERGUNTAS PRECISAM DA CONFERIDA DO RESPONSÁVEL TÉCNICO
--  ANTES DE VALER PARA CERTIFICADO.
--  Foram escritas a partir do conteúdo usual de cada curso e do que se
--  cobra em campo. São coerentes com as normas, mas quem responde pela
--  prova é o responsável técnico — prova errada reprova quem sabe e
--  aprova quem não sabe, e é o certificado dele que está em jogo.
--
--  O DELETE SÓ APAGA A FAIXA 41-150. As questões 1 a 40, escritas nos
--  arquivos 12, 15, 16, 17 e 18, ficam de pé. Pode rodar este arquivo
--  quantas vezes quiser, e em qualquer ordem em relação aos outros.
--
--  A COLUNA `correta` É O ÍNDICE, COMEÇANDO EM ZERO
--  Se a resposta certa é a primeira alternativa, `correta` é 0. A posição
--  foi espalhada de propósito pelos quatro índices: aluno que decora
--  padrão de gabarito não aprende norma nenhuma.
--
--  CADA ARRAY FICA NUMA LINHA SÓ, de propósito: o Postgres recusa JSON
--  com quebra de linha dentro do texto ("Character with value 0x0d must
--  be escaped"). Foi o erro que derrubou a primeira versão do arquivo do
--  NR-20 e não custa nada evitar de novo.
--
--  OS QUATRO CURSOS DESTE ARQUIVO ANDAM EM DOIS PARES, e as perguntas
--  foram escritas para não se atropelarem dentro do par:
--    NR-01-INT4  fala com quem chegou ontem: o que ele decide sozinho na
--                primeira semana para não se machucar.
--    NR-01-INT8  fala com quem participa da gestão: inventário de riscos,
--                plano de ação, hierarquia de controle e documentação.
--    DD          é a condução segura do dia a dia: veículo, via, regra e
--                convivência no trânsito.
--    DD-REC      é a reciclagem, e cobra o que derruba motorista rodado:
--                fadiga, noite, chuva, carga, comportamento de risco e os
--                primeiros minutos depois de um acidente.
--
--  Nenhum enunciado repete o das 40 questões antigas do mesmo curso nem
--  o do curso irmão. Onde o tema é o mesmo, o ângulo é outro: situação
--  concreta, responsabilidade, documento, erro de campo e o que fazer
--  quando o procedimento e a pressa se chocam.
-- =====================================================================


-- =====================================================================
--  NR-01-INT4 — Integração de segurança do trabalho, 4 horas
--  Prova de admissão. Quase toda questão põe o aluno diante de uma cena
--  do primeiro dia e pergunta o que ele faz. Nada de gerenciamento de
--  risco: isso é a prova de 8 horas.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-01-INT4')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Você recebeu o crachá de identificação no primeiro dia. Qual é o uso correto dele?',
     '["Usar em local visível durante toda a permanência na empresa e não emprestar para ninguém", "Guardar no bolso e mostrar só quando alguém pedir", "Deixar com o porteiro na entrada e pegar na saída", "Emprestar ao colega que esqueceu o dele, para ele não perder o dia"]', 0, 41),

    ('Por que roupa larga, camisa por fora e bermuda são proibidas perto de máquinas?',
     '["Porque prejudicam a apresentação da empresa diante do cliente", "Porque a peça solta pode ser agarrada por parte em movimento e arrastar o corpo", "Porque esquentam mais e aumentam o cansaço", "Porque dificultam a identificação do setor pelo uniforme"]', 1, 42),

    ('Trabalhador de cabelo comprido vai operar equipamento com eixo girando. O correto é:',
     '["Deixar solto, porque cabelo não conduz nada", "Usar boné com a aba para trás", "Amarrar em rabo de cavalo, que já resolve", "Prender totalmente o cabelo e usar touca ou rede sob o capacete"]', 3, 43),

    ('O calçado de segurança fornecido apertou e o trabalhador prefere usar o tênis dele. Isso pode?',
     '["Pode, se o tênis for fechado e novo", "Pode, enquanto ele se acostuma com o calçado novo", "Pode, se ele não circular pela área de produção", "Não: ele deve pedir a troca por número adequado, e usar o calçado de segurança até lá"]', 3, 44),

    ('Anel, aliança, corrente e relógio de pulso na área operacional:',
     '["Podem ficar, desde que sejam de material fino", "Só são proibidos para quem trabalha com solda", "Podem ficar se forem cobertos pela luva", "Devem ser retirados: prendem em partes móveis, conduzem eletricidade e agravam a lesão da mão"]', 3, 45),

    ('Você encontrou um símbolo com um círculo cortado por uma faixa diagonal vermelha. O que ele comunica?',
     '["Que existe um perigo naquele ponto e é preciso atenção", "Que ali fica um equipamento de combate a incêndio", "Que aquele é o caminho até a saída do prédio", "Que a conduta representada está proibida naquele local"]', 3, 46),

    ('Uma placa amarela em forma de triângulo, com desenho preto, indica:',
     '["Indicação de saída de emergência", "Obrigação de usar um equipamento de proteção", "Advertência: existe um perigo naquele local e é preciso atenção", "Local de coleta de resíduo reciclável"]', 2, 47),

    ('As placas verdes com desenho branco, como a de saída e a do chuveiro lava-olhos, servem para:',
     '["Indicar o setor da qualidade", "Indicar onde é proibido circular", "Marcar as áreas já vistoriadas pela CIPA", "Indicar condição de segurança: saída, primeiros socorros e equipamento de salvamento"]', 3, 48),

    ('As faixas pintadas de amarelo e preto no piso e nos degraus servem para:',
     '["Enfeitar e padronizar a área", "Marcar o limite de responsabilidade de cada setor", "Chamar atenção para um risco físico, como desnível, quina ou obstáculo", "Indicar por onde passa a fiação elétrica"]', 2, 49),

    ('Um palete foi deixado dentro do corredor demarcado para circulação de pessoas. O que fazer?',
     '["Retirar ou providenciar a retirada e comunicar o responsável pela área", "Deixar como está, se o corredor for pouco usado", "Passar por fora do corredor, contornando o palete", "Marcar com fita zebrada e seguir"]', 0, 50),

    ('Ao subir e descer escada fixa dentro da empresa, o correto é:',
     '["Descer pulando degraus quando estiver com pressa", "Usar o corrimão, olhar os degraus e evitar carregar volume que ocupe as duas mãos", "Descer olhando o celular, desde que devagar", "Segurar volume grande com os dois braços para não deixar cair"]', 1, 51),

    ('A lâmpada do setor queimou e a área ficou mal iluminada. O que o trabalhador deve fazer?',
     '["Trocar a lâmpada ele mesmo, subindo em uma bancada", "Usar a lanterna do celular durante o turno", "Comunicar a chefia ou a manutenção, porque má iluminação causa erro, queda e lesão", "Continuar e comentar no fim do mês"]', 2, 52),

    ('Você derrubou óleo no piso durante o serviço. A conduta correta é:',
     '["Espalhar com o pé para secar mais rápido", "Isolar e sinalizar o ponto, limpar com material absorvente e só liberar depois de seco", "Jogar água para diluir", "Cobrir com papelão até alguém da limpeza chegar"]', 1, 53),

    ('A caixa que você precisa levar está muito pesada para uma pessoa só. O correto é:',
     '["Levantar rápido, para o esforço durar menos", "Arrastar pelo chão até o destino", "Dividir em duas viagens carregando de lado", "Pedir ajuda de outro trabalhador ou usar carrinho, paleteira ou outro meio mecânico"]', 3, 54),

    ('Para movimentar um carrinho carregado, o esforço é menor e mais seguro quando o trabalhador:',
     '["Puxa de costas, para enxergar a carga", "Empurra, mantendo o carrinho à frente e a visão livre do caminho", "Empurra com um pé, para poupar os braços", "Puxa com uma mão só, para ter a outra livre"]', 1, 55),

    ('Usar chave de fenda como talhadeira, ou alicate como martelo, é:',
     '["Aceitável, se a ferramenta certa estiver em uso por outro colega", "Aceitável em serviço rápido", "Improvisação proibida: quebra a ferramenta, lança estilhaço e causa lesão em olho e mão", "Aceitável se o trabalhador tiver experiência com a ferramenta"]', 2, 56),

    ('Uma furadeira elétrica está com o cabo emendado com fita isolante. O que fazer?',
     '["Usar segurando pela parte plástica", "Usar somente em local seco", "Reforçar a fita e continuar", "Retirar de uso, identificar o defeito e encaminhar para a manutenção"]', 3, 57),

    ('Limpar a roupa e o corpo com jato de ar comprimido é:',
     '["Permitido, se a pressão for baixa", "Permitido, desde que com óculos de proteção", "Permitido no fim do turno, fora da área de produção", "Proibido: o ar pode penetrar na pele, lançar partícula no olho e provocar lesão grave"]', 3, 58),

    ('Lavar as mãos com solvente, thinner ou gasolina para tirar graxa:',
     '["Pode, se enxaguar com água depois", "Pode, porque o solvente evapora e não deixa resíduo", "Não deve ser feito: resseca, causa dermatite e o produto entra pela pele", "Pode, se usar pouca quantidade"]', 2, 59),

    ('O que o rótulo de um produto químico precisa informar ao trabalhador?',
     '["Apenas o nome comercial e o fabricante", "O nome do produto, os perigos, os cuidados de uso e a indicação de consultar a ficha de segurança", "Apenas o setor que vai usar o produto", "Apenas a data de fabricação"]', 1, 60),

    ('Você vai usar um produto químico que nunca usou. Onde estão as informações sobre risco e primeiros socorros?',
     '["No manual da máquina que usa o produto", "No catálogo de compras do almoxarifado", "Na nota fiscal do fornecedor", "Na ficha com dados de segurança do produto, a FDS, que deve estar disponível no local de uso"]', 3, 61),

    ('Respingou produto químico no olho de um colega. Qual é a primeira providência?',
     '["Passar colírio e levar ao ambulatório", "Vendar o olho e chamar o transporte", "Esfregar o olho com pano limpo para retirar o produto", "Lavar imediatamente no lava-olhos por tempo prolongado e acionar o atendimento"]', 3, 62),

    ('Sobre a escolha da luva de proteção:',
     '["A luva precisa ser adequada ao risco: a de corte não protege de produto químico e a de látex não protege de faca", "Qualquer luva serve, desde que tenha CA", "A luva de raspa serve para tudo", "A luva mais grossa é sempre a mais segura"]', 0, 63),

    ('O protetor auricular tipo plug está sendo usado da forma correta quando:',
     '["Fica só encostado na entrada do ouvido, para não incomodar", "É inserido no canal auditivo até vedar, com as mãos limpas, e retirado só fora da área ruidosa", "Fica pendurado no pescoço e é colocado quando a máquina liga", "É cortado ao meio para caber melhor"]', 1, 64),

    ('Em um setor onde é preciso gritar para conversar a um metro de distância, isso indica que:',
     '["A acústica do prédio é ruim", "O trabalhador está com problema de audição", "O ruído está alto o bastante para exigir proteção auditiva e avaliação do setor", "As máquinas precisam de lubrificação"]', 2, 65),

    ('Trabalho em ambiente quente, perto de forno ou sob o sol, exige:',
     '["Tomar bastante água só no horário das refeições", "Beber água com frequência, respeitar as pausas e comunicar tontura, cãibra ou náusea", "Evitar beber líquido para não suar", "Tomar bebida gelada com açúcar para repor energia"]', 1, 66),

    ('Qual é a forma correta de limpar poeira acumulada no setor?',
     '["Aspirar ou umedecer antes, para a poeira não voltar a ser respirada", "Soprar com ar comprimido para chegar aos cantos", "Deixar acumular e limpar na parada mensal", "Varrer a seco, que é mais rápido"]', 0, 67),

    ('Trabalhador que passa a jornada exposto ao sol deve:',
     '["Contar apenas com a camisa de manga longa", "Evitar líquido para não precisar interromper o serviço", "Usar chapéu ou aba no capacete, protetor solar, camisa de manga longa e aproveitar as pausas na sombra", "Trabalhar sem camisa nos dias mais quentes"]', 2, 68),

    ('Você encontrou uma agulha ou lâmina descartada no lixo comum. O que fazer?',
     '["Recolher com a mão, com cuidado, e jogar fora", "Não manusear, isolar o ponto e chamar o responsável para o descarte no recipiente próprio", "Empurrar para o fundo do saco", "Enrolar em papel e descartar no mesmo lixo"]', 1, 69),

    ('Material perfurocortante usado, como lâmina de estilete e agulha, deve ser descartado:',
     '["No saco de lixo reciclável", "Em recipiente rígido, identificado e próprio para perfurocortante", "Na caçamba de entulho da obra", "No lixo comum, se estiver dentro de uma caixa de papelão"]', 1, 70),

    ('Uma embalagem vazia de produto químico pode ser reaproveitada para guardar água ou comida?',
     '["Pode, se for lavada com água e sabão", "Pode, se o rótulo antigo for arrancado", "Pode, se ficar guardada fora da área de produção", "Não: sempre resta resíduo, e já houve intoxicação e morte por causa disso"]', 3, 71),

    ('Uma extensão elétrica atravessa o corredor por onde todo mundo passa. Isso é problema porque:',
     '["Provoca tropeço, danifica o cabo e pode gerar choque e curto-circuito", "Atrapalha a limpeza do piso", "Aumenta a conta de energia", "Deixa a área com aparência desorganizada"]', 0, 72),

    ('Ligar vários equipamentos em um adaptador de tomadas, o chamado benjamim:',
     '["Sobrecarrega o circuito, aquece a fiação e é uma das causas comuns de incêndio", "Pode, se a tomada for nova", "Pode, se os equipamentos forem pequenos", "Pode, desde que não fique ligado à noite"]', 0, 73),

    ('O quadro elétrico do setor está com caixas empilhadas na frente e a porta aberta. O correto é:',
     '["Só retirar o material se houver risco de chuva", "Deixar assim, porque facilita o desligamento rápido", "Retirar o material, manter o acesso livre, a porta fechada e comunicar o responsável", "Fechar a porta e manter o material, que não atrapalha"]', 2, 74),

    ('Quem pode abrir um painel elétrico e mexer na fiação?',
     '["Qualquer trabalhador com luva de borracha", "Apenas o profissional qualificado e autorizado pela empresa para serviço elétrico", "O encarregado do setor, por ser o responsável", "Quem tiver a chave do painel"]', 1, 75),

    ('Você encontrou um cadeado e uma etiqueta de outro trabalhador em uma chave de máquina que precisa ligar. O que fazer?',
     '["Cortar o cadeado, se a produção estiver parada por causa disso", "Não retirar o bloqueio e procurar quem o colocou: só ele pode remover", "Retirar e recolocar depois de ligar a máquina", "Pedir ao encarregado que retire por você"]', 1, 76),

    ('Você chegou ao posto e a proteção da máquina está retirada. O que fazer?',
     '["Operar com atenção redobrada", "Operar em velocidade menor até a proteção voltar", "Improvisar uma proteção com papelão", "Não operar, comunicar a chefia e só voltar depois que a proteção estiver recolocada"]', 3, 77),

    ('Uma carga está suspensa por talha ou guindaste no caminho que você faria. O correto é:',
     '["Passar rápido por baixo, se a carga estiver parada", "Passar por baixo se o operador autorizar", "Passar por baixo usando capacete", "Contornar a área isolada e nunca permanecer ou circular sob carga suspensa"]', 3, 78),

    ('Uma fita zebrada isolando um trecho da área significa que:',
     '["A área está reservada para uma reunião", "A limpeza está em andamento naquele ponto", "Existe risco e o acesso está restrito: só entra quem foi autorizado pelo responsável", "O piso foi pintado recentemente"]', 2, 79),

    ('Ao empilhar caixas ou sacos no almoxarifado, o correto é:',
     '["Empilhar o mais alto possível para ganhar espaço", "Respeitar a altura máxima, manter a pilha estável, o material mais pesado embaixo e distância das luminárias e dos extintores", "Encostar a pilha na parede para dar firmeza", "Empilhar sobre o palete quebrado, se ainda estiver inteiro de um lado"]', 1, 80),

    ('Para guardar material em prateleira, a regra é:',
     '["Peso maior nas prateleiras de baixo e material leve no alto", "Peso maior no alto, para liberar o chão", "Distribuir sem critério, desde que caiba", "Deixar o material mais usado sempre na prateleira mais alta"]', 0, 81),

    ('Um cilindro de gás precisa ser levado até o outro lado do setor. O correto é:',
     '["Rolar deitado pelo piso", "Carregar no ombro, com ajuda de um colega", "Transportar em carrinho apropriado, preso e com o capacete de proteção da válvula colocado", "Arrastar segurando pela válvula"]', 2, 82),

    ('Cilindros de gás devem ser armazenados:',
     '["Em pé, presos por corrente ou cinta, em local ventilado e longe de calor e de material inflamável", "Deitados no chão, para não tombarem", "Em qualquer canto, desde que fora do corredor", "Dentro do vestiário, protegidos da chuva"]', 0, 83),

    ('Um colega está soldando perto do seu posto. Qual é o cuidado?',
     '["Não olhar o arco, respeitar o biombo de proteção e sair da região de fagulha e fumo metálico", "Basta virar o rosto quando a solda começar", "Usar óculos escuros comuns", "Olhar o arco só de relance não faz mal"]', 0, 84),

    ('Serviço com solda, maçarico ou esmerilhadeira em área que não é oficina exige:',
     '["Permissão de trabalho a quente, retirada do material combustível, extintor no local e observação da área depois do serviço", "Apenas a autorização verbal do encarregado", "Apenas o extintor por perto", "Apenas a proteção facial do executante"]', 0, 85),

    ('Diante de um princípio de incêndio pequeno e do extintor certo à mão, o trabalhador treinado deve:',
     '["Esperar a brigada chegar, sem fazer nada", "Tentar apagar sozinho até acabar o extintor", "Abrir as janelas para a fumaça sair", "Acionar o alarme, avisar alguém e combater o foco enquanto for seguro, sem se colocar entre o fogo e a saída"]', 3, 86),

    ('Depois de sair do prédio em uma emergência, o trabalhador deve:',
     '["Ir embora para casa, se o expediente estiver no fim", "Permanecer no ponto de encontro para a conferência de pessoas e aguardar liberação", "Voltar para conferir se ficou alguém", "Ficar próximo da porta para ajudar quem sai"]', 1, 87),

    ('Qual é a atitude correta durante um simulado de abandono de área?',
     '["Participar como se fosse real, porque é ali que se descobre o que não funciona", "Continuar o serviço, já que é apenas um treino", "Sair só quando o setor terminar o lote", "Aguardar o aviso individual do supervisor"]', 0, 88),

    ('A porta corta-fogo da escada vive presa aberta com uma cunha, para facilitar a passagem. Isso é:',
     '["Aceitável durante o expediente", "Aceitável se houver alguém por perto para fechar em caso de incêndio", "Aceitável, porque a porta abre no sentido da saída", "Errado: a porta fechada é o que impede a fumaça de tomar a escada, que é a rota de fuga"]', 3, 89),

    ('Para que serve a iluminação de emergência dos corredores e escadas?',
     '["Economizar energia durante a noite", "Iluminar a rota de fuga quando falta energia, que é justamente quando a saída fica mais difícil", "Sinalizar o horário de fechamento do prédio", "Facilitar o trabalho da segurança patrimonial"]', 1, 90),

    ('Um visitante ou motorista de entrega se acidentou dentro da empresa. O que fazer?',
     '["Nada, porque ele não é empregado", "Orientar que procure atendimento por conta própria", "Pedir para ele sair da área e resolver fora", "Acionar o atendimento, comunicar a chefia e o setor de segurança e registrar a ocorrência"]', 3, 91),

    ('Um visitante chegou ao setor sem EPI e sem acompanhante. O correto é:',
     '["Não permitir a circulação e encaminhar ao responsável pela recepção de visitantes", "Emprestar o seu capacete e continuar o serviço", "Deixar circular, desde que ele fique parado em um ponto", "Deixar passar se ele for cliente"]', 0, 92),

    ('Um serviço precisa ser feito sozinho, fora do horário, em área isolada. O correto é:',
     '["Fazer normalmente, porque o serviço é simples", "Comunicar previamente a chefia, combinar a forma de contato e o horário de retorno, e seguir o procedimento da empresa", "Avisar a família por telefone", "Deixar um bilhete na portaria"]', 1, 93),

    ('O trabalhador está no fim de uma jornada longa, com hora extra, e sente cansaço forte. O correto é:',
     '["Comunicar a chefia: cansaço aumenta erro e acidente, e a tarefa de risco não deve ser feita nesse estado", "Tomar café e seguir até o fim do serviço", "Continuar, porque o pagamento da hora extra já foi combinado", "Fazer as tarefas mais perigosas primeiro, para se livrar delas"]', 0, 94),

    ('Para que servem as pausas e a ginástica laboral durante a jornada?',
     '["Para preencher o tempo ocioso entre lotes", "Para cumprir exigência do plano de saúde", "Para recuperar a musculatura e a atenção, reduzindo lesão por esforço repetitivo e erro por fadiga", "Para substituir o intervalo de refeição"]', 2, 95),

    ('No trabalho em computador, o antebraço e o punho devem ficar:',
     '["Suspensos no ar, para dar liberdade de movimento", "Apoiados e alinhados, com o teclado na altura dos cotovelos e sem dobrar o punho para cima", "Apoiados na quina da mesa", "Bem abaixo da mesa, com o punho dobrado"]', 1, 96),

    ('Você foi convocado para o exame médico periódico. Comparecer é:',
     '["Opcional, se o trabalhador se sentir bem", "Obrigação do trabalhador, e o exame é feito no horário de trabalho e sem custo para ele", "Obrigatório apenas para quem trabalha com produto químico", "Necessário somente na admissão e na demissão"]', 1, 97),

    ('O ASO trouxe uma restrição, por exemplo não levantar peso acima de determinado limite. O que acontece?',
     '["A restrição vale só até o trabalhador se sentir melhor", "A empresa e o trabalhador precisam respeitar a restrição, e a tarefa deve ser adequada", "A restrição é uma sugestão do médico", "A restrição impede o trabalhador de continuar na empresa"]', 1, 98),

    ('A trabalhadora descobriu que está grávida. O que ela deve fazer?',
     '["Não comunicar, para evitar mudança de função", "Comunicar a empresa e o serviço médico, para avaliação e afastamento das atividades incompatíveis com a gestação", "Comunicar apenas no fim da gravidez", "Comunicar somente ao setor de pessoal, para a licença"]', 1, 99),

    ('O trabalhador começou a tomar um remédio que dá sono e tontura. O correto é:',
     '["Informar o serviço médico e a chefia, porque isso muda quais tarefas ele pode executar com segurança", "Tomar meia dose para reduzir o efeito", "Não comentar, porque é assunto particular", "Trabalhar só na parte da tarde"]', 0, 100),

    ('O trabalhador usa óculos de grau e precisa de proteção ocular. A solução correta é:',
     '["Usar só os óculos de grau, que já são de vidro resistente", "Usar óculos de proteção sobreposto ao de grau, ou óculos de proteção com lente de grau", "Trabalhar sem os óculos de grau durante a tarefa", "Usar protetor facial no lugar dos óculos de grau"]', 1, 101),

    ('O trabalhador tem diabetes, epilepsia ou outra condição que pode causar mal súbito. O que fazer?',
     '["Guardar a informação, porque não interessa à empresa", "Contar apenas para o colega de posto mais próximo", "Informar o serviço médico da empresa, que orienta os cuidados e a conduta em caso de emergência", "Levar a medicação no bolso e não comentar com ninguém"]', 2, 102),

    ('Uma pessoa desmaiada e inconsciente pede para tomar água quando começa a acordar. O correto é:',
     '["Dar água em pequenos goles", "Molhar os lábios com um pano", "Dar água com açúcar para recuperar as forças", "Não oferecer líquido nem alimento e aguardar o atendimento, porque há risco de engasgo"]', 3, 103),

    ('Um colega se cortou e o ferimento sangra bastante. A conduta correta é:',
     '["Lavar com álcool e amarrar um torniquete no braço", "Calçar luva, fazer compressão direta com pano limpo, elevar o membro se possível e acionar o atendimento", "Passar pó de café ou pomada para estancar", "Esperar parar de sangrar sozinho e depois lavar"]', 1, 104),

    ('Diante de uma queimadura pequena por calor, o correto é:',
     '["Passar manteiga, pasta de dente ou borra de café", "Estourar a bolha para não infeccionar", "Resfriar com água corrente em temperatura ambiente, cobrir com pano limpo e encaminhar ao atendimento", "Cobrir com algodão para proteger"]', 2, 105),

    ('Um colega recebeu choque e continua em contato com o equipamento energizado. A primeira atitude é:',
     '["Puxar pelo braço rapidamente", "Jogar água para interromper o contato", "Cortar a energia ou afastar o contato com material isolante, sem tocar na vítima", "Segurar pela roupa, que não conduz"]', 2, 106),

    ('Um colega passou mal com calor, está pálido, suando frio e com tontura. O correto é:',
     '["Dar um refrigerante gelado e deixar sentado sozinho", "Molhar o rosto com água gelada e mandar continuar", "Levar para local fresco e arejado, sentar ou deitar, afrouxar a roupa e acionar o atendimento", "Levar para o sol, para ele suar e melhorar"]', 2, 107),

    ('Antes de mexer em entulho, pilha de madeira ou material parado há tempo em obra, o cuidado é:',
     '["Chutar o material para ver se sai algum bicho", "Molhar o material antes de mexer", "Usar luva e calçado adequados, mover o material com ferramenta e observar antes de colocar a mão", "Mexer somente no fim da tarde, quando os animais estão parados"]', 2, 108),

    ('Diante de uma picada de cobra ou de escorpião no trabalho, o correto é:',
     '["Fazer torniquete e cortar o local para sangrar", "Chupar o local para retirar o veneno", "Manter a vítima calma, imobilizar e encaminhar imediatamente ao atendimento médico", "Aplicar gelo e esperar a dor passar"]', 2, 109),

    ('Pneus velhos, baldes e calhas com água parada na área são problema de segurança porque:',
     '["Aumentam o custo de descarte", "Deixam a área com aparência de abandono", "Prejudicam a drenagem do terreno", "Criam foco de mosquito transmissor de doença, além de atrair outros animais"]', 3, 110),

    ('Quanto à água potável e às instalações sanitárias no local de trabalho:',
     '["O trabalhador deve levar a própria água", "A empresa deve garantir água potável e banheiros em condições de uso e higiene, sem custo para o trabalhador", "A empresa pode cobrar pelo uso do vestiário", "Basta haver um bebedouro na portaria"]', 1, 111),

    ('Comer no posto de trabalho, em setor onde se manipula produto químico ou material contaminado:',
     '["Não deve acontecer: a refeição é feita no local próprio, porque o produto passa para o alimento e para a boca", "Pode, se a refeição estiver embalada", "Pode, se for apenas um lanche rápido", "Pode, desde que o trabalhador não tire a luva"]', 0, 112),

    ('Lavar bem as mãos antes das refeições e ao fim da jornada é importante porque:',
     '["Melhora a convivência no refeitório", "Poeira, óleo, chumbo e produtos químicos que ficam na pele acabam ingeridos e levados para casa", "É exigência do plano de saúde", "Evita que a luva fique suja no dia seguinte"]', 1, 113),

    ('Guardar marmita ou alimento dentro do armário junto com produto químico ou roupa suja de trabalho:',
     '["Pode, se o alimento estiver bem fechado", "Não deve ser feito: o alimento absorve resíduo e vapor, e o armário deve separar roupa limpa de roupa de trabalho", "Pode, se o produto químico estiver lacrado", "Pode, se o armário for exclusivo do trabalhador"]', 1, 114),

    ('O trabalhador quer fumar durante o expediente. O correto é:',
     '["Fumar somente no local designado pela empresa, fora das áreas com risco de incêndio e de produto inflamável", "Fumar no posto de trabalho, se estiver sozinho", "Fumar no vestiário, que é área fechada", "Fumar em qualquer área externa da empresa"]', 0, 115),

    ('Usar o celular durante o abastecimento de veículo no posto ou na bomba interna:',
     '["Não deve: a orientação é manter o aparelho desligado ou guardado durante o abastecimento, junto com o motor desligado", "Pode, se a ligação for curta", "Pode, se o telefone estiver em viva-voz", "Pode, se o trabalhador estiver dentro do veículo"]', 0, 116),

    ('O que caracteriza assédio moral no trabalho?',
     '["Conduta repetida que humilha, isola ou constrange o trabalhador, atingindo sua dignidade e sua saúde", "A avaliação de desempenho feita periodicamente", "Uma cobrança pontual de prazo por parte da chefia", "Qualquer conversa desagradável entre colegas"]', 0, 117),

    ('Um trabalhador sofreu cantada insistente e toque sem consentimento de um colega. O que ele deve fazer?',
     '["Ignorar e evitar o colega", "Resolver diretamente com quem cometeu", "Esperar acontecer de novo para ter prova", "Registrar e comunicar pelos canais que a empresa é obrigada a divulgar, com apuração e proteção contra retaliação"]', 3, 118),

    ('Piada sobre a cor, a religião, a idade ou a deficiência de um colega, dita para descontrair:',
     '["É aceitável se o colega não reclamar", "É aceitável entre pessoas do mesmo setor", "Não é aceitável: é discriminação, adoece e pode gerar responsabilização", "É aceitável fora do horário de trabalho"]', 2, 119),

    ('Em atendimento ao público, o trabalhador foi ameaçado por uma pessoa exaltada. O correto é:',
     '["Discutir para mostrar firmeza", "Chamar outro cliente para testemunhar", "Manter distância, não reagir à provocação, acionar o apoio previsto pela empresa e registrar o ocorrido", "Fechar o atendimento e ir embora sem avisar"]', 2, 120),

    ('Qual é a diferença entre recusar uma tarefa por risco grave e simplesmente descumprir uma ordem?',
     '["Não há diferença: recusar sempre é insubordinação", "A recusa é aceita apenas se o trabalhador for cipeiro", "A recusa por risco grave e iminente é legítima e deve ser comunicada ao superior, enquanto a recusa sem motivo de segurança é descumprimento de obrigação", "A recusa só vale se for por escrito e assinada por testemunha"]', 2, 121),

    ('A chefia mandou pular a etapa de bloqueio da máquina porque o serviço é rápido e a produção está atrasada. O correto é:',
     '["Cumprir a ordem, porque a responsabilidade passa a ser da chefia", "Não executar dessa forma, expor o risco à chefia e acionar a segurança do trabalho se a ordem for mantida", "Fazer metade do procedimento, para ganhar tempo", "Cumprir só se outro colega ficar olhando"]', 1, 122),

    ('Um colega mais antigo ensina um jeito mais rápido de fazer a tarefa, diferente do procedimento. O correto é:',
     '["Adotar o jeito dele, que tem mais experiência", "Adotar o jeito dele quando a chefia não estiver por perto", "Alternar entre os dois jeitos", "Seguir o procedimento e levar a sugestão à chefia ou à segurança para ser avaliada"]', 3, 123),

    ('Aprender a tarefa só olhando o colega trabalhar, sem treinamento formal, é suficiente?',
     '["Sim, se o colega for experiente", "Sim, se a tarefa for simples", "Não: o treinamento formal garante que o risco e o procedimento foram apresentados, e ele fica registrado", "Sim, desde que o colega assine a lista de presença junto"]', 2, 124),

    ('Você não entendeu por que determinado EPI é exigido em uma tarefa. O que fazer?',
     '["Usar sem entender e não perguntar", "Usar somente quando alguém cobrar", "Procurar na internet no intervalo", "Perguntar ao encarregado ou à segurança do trabalho: entender o risco é o que faz o EPI ser usado do jeito certo"]', 3, 125),

    ('Pediram para você assinar a lista de presença de um treinamento do qual você não participou. O correto é:',
     '["Assinar, porque o conteúdo você já conhece", "Não assinar: a lista é a prova de que a capacitação aconteceu, e assinar em falso prejudica você e a empresa", "Assinar somente se o instrutor autorizar", "Assinar e pedir o material depois"]', 1, 126),

    ('A ficha de entrega de EPI serve para:',
     '["Controlar o gasto do almoxarifado", "Registrar qual equipamento foi entregue, quando e para quem, comprovando o fornecimento e a troca", "Descontar do salário em caso de perda", "Justificar o pedido de compra do próximo ano"]', 1, 127),

    ('Um colega pediu emprestado seu protetor auricular porque esqueceu o dele. O correto é:',
     '["Não emprestar: o EPI é de uso individual, e ele deve solicitar o dele no almoxarifado", "Emprestar até ele conseguir outro", "Emprestar, se ele limpar antes", "Emprestar somente por um turno"]', 0, 128),

    ('O EPI se danificou durante o uso normal. Quem arca com a substituição?',
     '["A empresa, que deve substituir imediatamente e sem custo para o trabalhador", "O trabalhador, se o dano foi durante o trabalho dele", "O trabalhador, com desconto parcelado", "O sindicato da categoria"]', 0, 129),

    ('Uma máscara descartável tipo PFF2 usada durante o turno deve ser:',
     '["Descartada quando estiver suja, úmida, deformada ou com dificuldade de respiração, seguindo a orientação recebida", "Lavada com água e sabão e reutilizada", "Guardada no bolso da calça para o dia seguinte", "Compartilhada entre o pessoal do turno seguinte"]', 0, 130),

    ('Sobre o capacete de segurança com jugular, é correto afirmar que:',
     '["A jugular mantém o capacete na cabeça quando o trabalhador se inclina ou tropeça, que é quando ele mais cai", "A jugular incomoda e pode ficar solta", "A jugular serve para pendurar o capacete quando não estiver em uso", "A jugular só é necessária em trabalho em altura"]', 0, 131),

    ('Para que serve a biqueira de proteção do calçado de segurança?',
     '["Proteger os dedos contra queda e impacto de objeto, que é a lesão de pé mais comum", "Dar firmeza à pisada", "Evitar que o calçado desgaste na ponta", "Isolar o pé contra choque elétrico"]', 0, 132),

    ('Em serviço de roçada e capina com máquina costal, a proteção específica inclui:',
     '["Perneira, protetor facial, protetor auricular, luva e calçado adequado", "Apenas óculos de proteção", "Apenas luva e boné", "Apenas protetor auricular, pelo ruído do motor"]', 0, 133),

    ('Ao operar esmerilhadeira ou lixadeira, a proteção dos olhos e do rosto deve ser:',
     '["Óculos de sol escuro", "Somente óculos de proteção, se o serviço for curto", "Somente o protetor facial de acrílico", "Óculos de proteção mais protetor facial, porque o disco lança partícula e pode se romper"]', 3, 134),

    ('O disco de corte apresenta trinca ou pedaço lascado. O correto é:',
     '["Usar somente para cortes leves", "Lixar a borda para regularizar", "Usar em rotação mais baixa", "Descartar imediatamente: disco trincado se rompe em uso e o estilhaço atinge quem está por perto"]', 3, 135),

    ('Retirar a proteção do disco da esmerilhadeira para facilitar o corte é:',
     '["Aceitável quando a peça é grande", "Aceitável se o operador usar protetor facial", "Proibido: a proteção desvia a fagulha e retém o fragmento em caso de rompimento do disco", "Aceitável em serviço externo"]', 2, 136),

    ('Ao esmerilhar ou cortar, a direção da fagulha deve ser:',
     '["Direcionada para longe de pessoas, de material inflamável e de cilindros de gás", "Para cima, para não sujar o piso", "Para o próprio corpo, que está protegido pelo avental", "Para o lado de quem passa, para o operador enxergar o corte"]', 0, 137),

    ('Antes de cruzar a frente de uma empilhadeira ou de um trator, o pedestre deve:',
     '["Estabelecer contato visual com o operador e só atravessar depois que ele sinalizar que viu", "Passar rápido, para não atrapalhar a operação", "Bater na lateral do equipamento para avisar", "Passar por trás, que é mais seguro"]', 0, 138),

    ('Um caminhão está dando ré com o alarme sonoro ligado. O que o pedestre deve fazer?',
     '["Confiar no alarme e seguir o trajeto", "Passar rápido enquanto o veículo ainda está distante", "Ficar parado atrás, para o motorista ver pelo espelho", "Afastar-se da trajetória e da lateral: o alarme avisa, mas não garante que o motorista enxergue"]', 3, 139),

    ('Passar por baixo de um caminhão, de uma carreta ou entre vagões parados para encurtar caminho é:',
     '["Proibido: o veículo pode se mover a qualquer momento e ninguém enxerga quem está embaixo", "Aceitável em pátio fechado", "Aceitável se outro colega estiver observando", "Aceitável quando o veículo está com o motor desligado"]', 0, 140),

    ('Subir na carroceria de um caminhão para arrumar a carga exige:',
     '["Apenas agilidade e calçado com solado bom", "Apenas que o caminhão esteja em piso plano", "Apenas que outro trabalhador segure a escada", "Autorização, meio seguro de acesso e as medidas de proteção contra queda previstas pela empresa"]', 3, 141),

    ('Ao circular a pé por um canteiro de obras, um cuidado específico é:',
     '["Olhar apenas o piso, que é onde estão os obstáculos", "Atenção também ao que está acima: içamento, andaime e material na periferia da laje podem cair", "Andar sempre pelo meio da via de veículos, que é mais limpo", "Circular somente com colete, que já protege"]', 1, 142),

    ('Você percebeu que não sabe o que fazer se o alarme tocar enquanto estiver no setor novo. O correto é:',
     '["Aguardar o alarme tocar e seguir os colegas", "Deixar para descobrir no próximo simulado", "Procurar a planta do prédio na internet", "Perguntar à chefia ou à segurança qual é a rota de fuga e o ponto de encontro daquele setor"]', 3, 143),

    ('Sobre correr dentro da área de trabalho, mesmo em uma emergência:',
     '["Correr é o certo, porque ganha tempo", "Correr só é problema em piso molhado", "Deslocar-se com rapidez, mas sem correr: correr provoca queda, atropelamento e tumulto na saída", "Correr é permitido para quem conhece bem o caminho"]', 2, 144),

    ('Encontrar uma ferramenta ou peça caída perto de um equipamento em funcionamento exige:',
     '["Não recolher com a máquina operando: parar o equipamento ou acionar quem é responsável por ele", "Empurrar com o pé para fora da área", "Recolher com auxílio de gancho, com a máquina em movimento", "Recolher rapidamente com a mão"]', 0, 145),

    ('Ao final do turno, entregar o posto de trabalho organizado importa para a segurança porque:',
     '["Facilita a conferência do inventário", "Reduz o tempo de limpeza da empresa", "O turno seguinte encontra a área livre, as ferramentas no lugar e os riscos sinalizados, e não descobre o problema com o corpo", "Evita reclamação da chefia"]', 2, 146),

    ('Você presenciou um quase-acidente com outro colega, e ele pediu para não comentar nada. O correto é:',
     '["Respeitar o pedido, já que ninguém se feriu", "Comentar só com outro colega de confiança", "Comunicar mesmo assim: o registro serve para corrigir a causa, e não para punir quem se envolveu", "Comunicar apenas se acontecer uma segunda vez"]', 2, 147),

    ('O trabalhador terceirizado se acidentou dentro da empresa contratante. Quem deve ser comunicado?',
     '["Somente a empresa terceirizada, que é a empregadora", "Somente o cliente final do serviço", "Ninguém, porque o registro é feito depois do atendimento", "A chefia do local e o setor de segurança da contratante, além da empresa empregadora, que faz o registro do acidente"]', 3, 148),

    ('Sobre o direito do trabalhador de saber a que riscos ele está exposto:',
     '["A informação é dada somente na reunião anual da CIPA", "A informação é dada apenas para quem trabalha com produto químico", "Ele deve ser informado dos riscos da atividade, das medidas de controle e do que fazer em emergência, antes de começar", "A informação é reservada ao setor de segurança"]', 2, 149),

    ('Terminada a integração, o trabalhador entende que a segurança do dia a dia depende principalmente de:',
     '["Ter sorte e prestar atenção", "Confiar na experiência dos colegas mais antigos", "Seguir o procedimento, usar o EPI correto, comunicar risco e perguntar sempre que a situação fugir do combinado", "Cumprir a produção primeiro e resolver a segurança quando sobrar tempo"]', 2, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-01-INT4';



-- =====================================================================
--  NR-01-INT8 — Integração à NR-01, 8 horas
--  Aqui o aluno é quem ajuda a rodar o sistema: levantar perigo, avaliar,
--  escolher a medida, escrever o plano, provar que fez e revisar. As
--  questões cobram documento, prazo, responsabilidade e o erro de gestão
--  que transforma PGR em papel de gaveta.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-01-INT8')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Uma empresa afirma que cumpre o gerenciamento de riscos porque contratou a elaboração do PGR. O erro do raciocínio é que:',
     '["O gerenciamento só começa depois da primeira fiscalização", "O PGR só vale se for elaborado por empresa credenciada", "O gerenciamento de riscos é obrigação exclusiva do SESMT", "O documento sozinho não gerencia nada: gerenciar é identificar, avaliar, controlar, acompanhar e revisar, e o PGR é como isso fica documentado"]', 3, 41),

    ('Empresas de menor porte e grau de risco baixo podem ficar dispensadas do PGR quando:',
     '["Tiverem menos de dez empregados, em qualquer atividade", "Nunca: o PGR é exigido de toda empresa sem exceção", "Se enquadrarem nas hipóteses previstas na norma e declararem a inexistência de riscos, comprovando o enquadramento", "O sindicato da categoria autorizar por acordo coletivo"]', 2, 42),

    ('Para que serve o grau de risco associado ao CNAE da empresa?',
     '["Definir exigências como dimensionamento do SESMT e da CIPA e o enquadramento em obrigações da norma", "Escolher a cor do uniforme por setor", "Definir metas de produção do setor", "Definir o valor do vale-transporte"]', 0, 43),

    ('O inventário de riscos precisa registrar, no mínimo:',
     '["Somente a lista de máquinas do setor", "A caracterização dos processos, os perigos identificados, as fontes, os grupos expostos e as medidas já existentes", "Somente o número de acidentes do ano anterior", "Somente os exames médicos realizados"]', 1, 44),

    ('O que é o levantamento preliminar de perigos?',
     '["O relatório final da investigação de acidentes", "A conferência anual dos extintores", "A primeira etapa, feita antes do início da atividade ou de mudança, para identificar perigos e decidir se a avaliação precisa avançar", "A pesquisa de clima organizacional"]', 2, 45),

    ('Quando a avaliação quantitativa da exposição é necessária?',
     '["Sempre, para todo agente identificado", "Nunca: a avaliação qualitativa basta", "Quando for preciso comparar a exposição com limites, verificar a eficácia do controle ou subsidiar decisão que a avaliação qualitativa não resolve", "Somente quando a fiscalização exigir"]', 2, 46),

    ('O que significa nível de ação no gerenciamento de riscos?',
     '["O valor a partir do qual a exposição deve ser interditada", "O número mínimo de trabalhadores para formar CIPA", "O valor acima do qual já se adotam medidas preventivas, como monitoramento e controle médico, mesmo abaixo do limite de tolerância", "O prazo máximo para concluir uma ação do plano"]', 2, 47),

    ('Sobre o limite de tolerância de um agente, é correto afirmar que:',
     '["Abaixo dele não existe risco algum para ninguém", "Ele autoriza a empresa a não adotar medidas de controle", "Ele vale igualmente para qualquer jornada de trabalho", "É um parâmetro legal de referência, e não uma fronteira entre seguro e inseguro: há suscetibilidade individual e o controle deve continuar"]', 3, 48),

    ('Em uma matriz de risco, a classificação resulta da combinação de:',
     '["Custo da medida e prazo do plano de ação", "Número de empregados e faturamento da empresa", "Probabilidade de ocorrência e severidade das consequências", "Idade do equipamento e tempo de empresa do trabalhador"]', 2, 49),

    ('Depois de implantada a medida de controle, o risco que permanece é chamado de:',
     '["Risco tolerado, que sai do inventário", "Risco residual, que precisa ser reavaliado e registrado", "Risco eliminado, que não exige acompanhamento", "Risco transferido para o trabalhador"]', 1, 50),

    ('Qual é um exemplo de eliminação do perigo, o degrau mais alto da hierarquia?',
     '["Fornecer luva de proteção química ao operador", "Sinalizar a área com placa de advertência", "Reduzir o tempo de exposição por rodízio", "Retirar do processo a etapa que exigia entrada em espaço confinado"]', 3, 51),

    ('Substituir um solvente muito tóxico por outro de menor toxicidade, mantendo o processo, é exemplo de:',
     '["Medida administrativa", "Proteção individual", "Substituição do agente, medida que vem logo após a eliminação na hierarquia", "Sinalização de advertência"]', 2, 52),

    ('Sinalização, placas e advertências ocupam qual posição na hierarquia de controle?',
     '["A primeira, porque alcançam todos os trabalhadores", "Estão entre as medidas administrativas: avisam do risco, mas não o eliminam nem o reduzem na fonte", "Substituem a proteção coletiva quando esta é cara", "Estão fora da hierarquia, por serem exigência de outra norma"]', 1, 53),

    ('Manter o EPI como única medida de controle por tempo indeterminado é problema porque:',
     '["O risco continua existindo na fonte, e a proteção depende do uso correto e contínuo por cada trabalhador, todos os dias", "Dificulta a padronização do uniforme", "Aumenta o custo de almoxarifado", "O CA do equipamento tem validade curta demais"]', 0, 54),

    ('Duas medidas resolvem o mesmo risco: uma enclausura a fonte, outra dobra o número de pausas. A escolha correta é:',
     '["A que custar menos", "A que puder ser implantada mais rápido", "As duas ao mesmo tempo, sempre", "Priorizar o enclausuramento, que atua na fonte, e usar a medida administrativa como complemento ou solução provisória"]', 3, 55),

    ('Uma ação do plano venceu o prazo e não foi executada. O que o sistema de gestão exige?',
     '["Excluir a ação do plano, já que o prazo passou", "Aguardar a próxima revisão do PGR", "Registrar a justificativa, repactuar o prazo com responsável definido e avaliar se medidas provisórias são necessárias enquanto isso", "Transferir a ação para o plano do ano seguinte sem análise"]', 2, 56),

    ('Para que servem indicadores como taxa de frequência e taxa de gravidade?',
     '["Acompanhar o desempenho em SST ao longo do tempo e comparar períodos, orientando onde agir", "Definir o valor do adicional de insalubridade", "Medir a produtividade do setor de segurança", "Substituir a investigação de cada acidente"]', 0, 57),

    ('Uma investigação de acidente que conclui apenas falha do trabalhador costuma ser insuficiente porque:',
     '["Ofende o trabalhador envolvido", "Não gera indicador estatístico", "Atrasa a emissão da CAT", "Para na última pessoa da cadeia e não alcança as causas de projeto, de procedimento, de manutenção e de organização do trabalho"]', 3, 58),

    ('A separação entre ato inseguro e condição insegura é limitada porque:',
     '["O chamado ato inseguro quase sempre é consequência de condições, de pressões e de procedimentos que o tornaram possível ou provável", "Toda condição insegura vira ato inseguro com o tempo", "A norma proibiu esses termos", "Não existe forma de identificar a condição insegura"]', 0, 59),

    ('Quem deve participar da investigação de um acidente do trabalho?',
     '["A equipe de SST com a CIPA, ouvindo o acidentado quando possível e as testemunhas, com registro do que foi apurado", "Somente a chefia direta do acidentado", "Somente o setor jurídico", "Somente a consultoria externa contratada"]', 0, 60),

    ('Técnicas como os cinco porquês e a árvore de causas servem para:',
     '["Definir o valor da indenização", "Encadear os fatos e chegar às causas de fundo, em vez de parar na primeira explicação", "Escolher o EPI adequado ao risco", "Ordenar os acidentes por gravidade"]', 1, 61),

    ('Qual é o prazo para a comunicação do acidente do trabalho pela empresa?',
     '["Até o primeiro dia útil seguinte ao acidente, e de imediato em caso de óbito", "Até o final do mês em que ocorreu", "Somente quando houver afastamento superior a quinze dias", "No prazo que a empresa definir em procedimento interno"]', 0, 62),

    ('Um empregado de empresa contratada se acidenta prestando serviço na contratante. A emissão da CAT cabe:',
     '["À empresa empregadora do acidentado, sem prejuízo das obrigações da contratante quanto ao ambiente e à investigação", "À empresa contratante, dona do local", "Ao sindicato da categoria", "Ao próprio acidentado, obrigatoriamente"]', 0, 63),

    ('O nexo técnico epidemiológico serve para:',
     '["Definir a insalubridade do setor", "Relacionar estatisticamente a doença ao ramo de atividade da empresa, o que pode caracterizar o caso como ocupacional mesmo sem CAT emitida", "Substituir o exame médico periódico", "Calcular o número de integrantes da CIPA"]', 1, 64),

    ('Qual é a diferença entre acidente típico e doença ocupacional?',
     '["Nenhuma: os dois recebem o mesmo tratamento previdenciário", "O acidente típico ocorre fora da empresa e a doença dentro", "O acidente típico é um evento súbito ligado ao trabalho, e a doença ocupacional se instala pela exposição continuada ou pelas condições do trabalho", "A doença ocupacional só existe em atividade insalubre"]', 2, 65),

    ('O LTCAT e o PPP têm por finalidade:',
     '["Substituir o inventário de riscos", "Definir o valor do seguro de vida em grupo", "Documentar as condições de exposição do trabalhador, subsidiando a análise de aposentadoria especial pela Previdência", "Registrar o treinamento realizado pelo trabalhador"]', 2, 66),

    ('Os eventos de segurança e saúde do eSocial servem para:',
     '["Registrar a escala de férias do setor", "Calcular o imposto de renda do empregado", "Substituir a ficha de entrega de EPI", "Informar ao governo os exames ocupacionais, os afastamentos e as condições de exposição, integrando a informação de SST"]', 3, 67),

    ('Sobre o adicional de insalubridade e o gerenciamento de riscos:',
     '["Pagar o adicional dispensa a empresa de adotar medidas de controle", "O adicional substitui o fornecimento de EPI", "O adicional só é devido se o PGR indicar risco alto", "O adicional compensa financeiramente a exposição, mas não elimina a obrigação de eliminar ou reduzir o risco"]', 3, 68),

    ('Qual é a diferença essencial entre insalubridade e periculosidade?',
     '["A insalubridade se refere a agentes que agridem a saúde ao longo da exposição, e a periculosidade a condições de risco acentuado de acidente grave, como inflamáveis, explosivos e eletricidade", "A insalubridade é avaliada pelo SESMT e a periculosidade pela CIPA", "Nenhuma: são sinônimos na legislação", "A insalubridade é permanente e a periculosidade é temporária"]', 0, 69),

    ('Qual é o papel do SESMT na empresa?',
     '["Fiscalizar e punir o descumprimento pelos trabalhadores", "Aplicar os conhecimentos de engenharia e medicina do trabalho para tornar o ambiente compatível com a saúde, apoiando o gerenciamento de riscos", "Emitir os atestados médicos de afastamento", "Substituir a CIPA nas empresas de grande porte"]', 1, 70),

    ('Qual é a contribuição da CIPA para o gerenciamento de riscos?',
     '["Aprovar ou reprovar o PGR elaborado pela empresa", "Elaborar o inventário de riscos no lugar do SESMT", "Identificar riscos no dia a dia, participar da investigação de acidentes e levar ao PGR o que o trabalhador enxerga e o documento não capturou", "Definir o orçamento das medidas de controle"]', 2, 71),

    ('A Ordem de Serviço prevista na NR-01 cumpre qual função no sistema?',
     '["Registrar a jornada e o banco de horas", "Dar ciência formal ao trabalhador dos riscos da função, das medidas de prevenção e das obrigações, com registro", "Autorizar o trabalho extraordinário", "Substituir a capacitação obrigatória"]', 1, 72),

    ('Quanto a quem ministra a capacitação em segurança:',
     '["Qualquer empregado pode ministrar, desde que assine a lista", "A capacitação pode ser dispensada se houver procedimento escrito", "Somente engenheiro de segurança pode ministrar qualquer treinamento", "O instrutor precisa ter capacitação e experiência no tema, sob responsabilidade técnica de profissional legalmente habilitado quando a norma exigir"]', 3, 73),

    ('Sobre a modalidade de ensino a distância na capacitação em SST:',
     '["É proibida em qualquer hipótese", "Substitui integralmente a prática em todas as normas", "É admitida nas hipóteses e limites que a norma prevê, com controle de frequência, avaliação e a parte prática presencial onde ela for exigida", "É admitida apenas para trabalhadores de escritório"]', 2, 74),

    ('Um trabalhador chega de outra empresa com certificado válido do mesmo treinamento. O que a norma admite?',
     '["O aproveitamento do treinamento anterior nas condições previstas pela norma, complementado com o que for específico do novo posto e da nova empresa", "Aceitar sem qualquer verificação", "Considerar válido apenas se for da mesma cidade", "Ignorar o certificado e refazer tudo, sempre"]', 0, 75),

    ('O que pode antecipar a reciclagem de um treinamento, antes do prazo normal?',
     '["Mudança no procedimento, no equipamento ou no processo, ocorrência de acidente ou desempenho que mostre necessidade de reforço", "Apenas a troca de gerente da área", "Apenas o pedido do trabalhador", "Apenas a fiscalização do órgão competente"]', 0, 76),

    ('Um trabalhador foi transferido para um setor com riscos diferentes dos anteriores. O correto é:',
     '["Capacitar para os riscos e procedimentos do novo posto antes do início das atividades, com registro", "Considerar suficiente a integração de admissão", "Aguardar a próxima reciclagem programada", "Solicitar apenas nova Ordem de Serviço"]', 0, 77),

    ('Como a capacitação deve ser conduzida para trabalhador estrangeiro, com baixa escolaridade ou com deficiência?',
     '["Do mesmo jeito, porque o conteúdo é padronizado", "Com material e linguagem adaptados, recursos de acessibilidade e verificação de que o conteúdo foi de fato compreendido", "Somente com material escrito, para haver prova documental", "Delegando a explicação a um colega do mesmo setor"]', 1, 78),

    ('A presença de trabalhador com deficiência no setor deve refletir no gerenciamento de riscos porque:',
     '["As condições do posto, a rota de fuga e o plano de emergência precisam ser avaliados e adaptados à situação real da pessoa", "Reduz o grau de risco do estabelecimento", "Aumenta o número de integrantes da CIPA", "Obriga a criação de um PGR separado"]', 0, 79),

    ('Quando várias empresas atuam no mesmo estabelecimento, sobre o PGR é correto dizer:',
     '["Só a contratante precisa ter PGR", "Um único PGR coletivo substitui os demais", "Cada empresa responde pelo gerenciamento dos riscos de suas atividades, e as ações precisam ser harmonizadas no local, sob coordenação da contratante", "Cada empresa deve manter o seu PGR em sigilo das demais"]', 2, 80),

    ('A contratante identificou que a atividade de uma contratada expõe também os próprios empregados. O que deve fazer?',
     '["Nada, porque a atividade é da contratada", "Comunicar os riscos, harmonizar as medidas, ajustar a programação e acompanhar o cumprimento no local", "Suspender o contrato imediatamente", "Transferir os empregados próprios para outro turno, apenas"]', 1, 81),

    ('Diante de risco grave e iminente, o auditor fiscal do trabalho pode:',
     '["Somente lavrar auto de infração e notificar", "Demitir o responsável pela área", "Determinar interdição de estabelecimento, setor, máquina ou equipamento, ou embargo de obra, além de notificar e autuar", "Apenas recomendar a paralisação, sem efeito imediato"]', 2, 82),

    ('Durante uma paralisação por interdição ou embargo, os trabalhadores atingidos:',
     '["Ficam com o contrato suspenso e sem remuneração", "Recebem apenas metade da remuneração", "Continuam recebendo os salários como se estivessem em efetivo exercício", "Devem ser remanejados para outra empresa do grupo"]', 2, 83),

    ('Que garantia acompanha o direito de recusa por risco grave e iminente?',
     '["Nenhuma: o trabalhador assume o risco de ser punido", "A garantia depende de autorização prévia do sindicato", "A garantia vale somente para membros da CIPA", "O trabalhador não pode sofrer prejuízo por ter interrompido a atividade e comunicado o risco, e a empresa deve apurar a situação"]', 3, 84),

    ('A auditoria interna do PGR tem por finalidade:',
     '["Substituir a fiscalização do órgão competente", "Escolher os fornecedores de EPI", "Preparar a defesa em processos trabalhistas", "Verificar se o que está escrito é o que acontece no campo e se as medidas produziram o efeito esperado"]', 3, 85),

    ('A análise crítica do PGR pela direção da empresa serve para:',
     '["Cumprir formalidade de assinatura anual", "Aprovar a compra de equipamentos novos", "Definir o valor do prêmio por produtividade", "Avaliar o desempenho do sistema, decidir sobre recursos e definir prioridades, com base em indicadores e no andamento do plano de ação"]', 3, 86),

    ('Indicadores proativos, como inspeções realizadas e ações concluídas no prazo, são úteis porque:',
     '["Substituem a estatística de acidentes", "Mostram o esforço de prevenção antes de o acidente acontecer, enquanto os indicadores reativos só contam o que já deu errado", "São mais fáceis de coletar", "Reduzem o valor do seguro da empresa"]', 1, 87),

    ('Um programa de observação de comportamento é bem conduzido quando:',
     '["Registra o nome de quem errou para efeito disciplinar", "É aplicado apenas depois de acidentes", "Substitui a inspeção das instalações", "Serve para identificar por que o desvio é possível ou vantajoso e corrigir a condição, com diálogo e sem punição"]', 3, 88),

    ('Antes de mudar o layout, o turno ou o fornecedor de matéria-prima, o gerenciamento de riscos exige:',
     '["Aguardar a revisão programada do PGR", "Comunicar apenas o setor de compras", "Registrar a mudança somente se houver acidente depois", "Avaliar os riscos da mudança antes da implantação e atualizar inventário, procedimentos e capacitação"]', 3, 89),

    ('O plano de resposta a emergências precisa prever, no mínimo:',
     '["Os cenários possíveis, os recursos, as responsabilidades, os meios de alarme e comunicação, as rotas e o ponto de encontro, e a forma de acionar o socorro externo", "Apenas o telefone do corpo de bombeiros", "Apenas a lista de brigadistas", "Apenas a localização dos extintores"]', 0, 90),

    ('Sobre a realização de exercícios simulados de emergência:',
     '["Devem ser feitos sem aviso, sempre, em qualquer cenário", "Devem ser feitos apenas quando a seguradora exigir", "Devem ser feitos periodicamente, com registro e análise crítica do que falhou, para corrigir o plano", "São dispensáveis quando existe brigada treinada"]', 2, 91),

    ('Os recursos para atendimento de emergência dimensionados no PGR dependem principalmente:',
     '["Do faturamento da empresa", "Do número de encarregados", "Dos cenários identificados, do porte do estabelecimento, da distância do socorro externo e das características dos riscos presentes", "Do horário de funcionamento administrativo"]', 2, 92),

    ('São exemplos de agentes de risco físico:',
     '["Poeiras, névoas e vapores", "Bactérias, fungos e vírus", "Ruído, vibração, calor, frio, umidade e radiações", "Levantamento de peso e postura forçada"]', 2, 93),

    ('No caso dos agentes químicos, o gerenciamento precisa considerar:',
     '["Apenas a inalação, que é a via principal", "As vias de entrada possíveis, como inalação, contato com a pele e ingestão, além da quantidade, do tempo e da forma de uso", "Apenas o contato com a pele", "Apenas a quantidade armazenada no almoxarifado"]', 1, 94),

    ('Em atividades com risco biológico, uma medida de controle típica é:',
     '["Aumentar o número de pausas", "Vacinação disponibilizada pela empresa, barreiras de contenção, higienização e procedimento seguro para perfurocortantes", "Trocar o piso do setor", "Reduzir a iluminação do ambiente"]', 1, 95),

    ('A análise ergonômica do trabalho costuma ser exigida quando:',
     '["A avaliação dos riscos ergonômicos indica necessidade de aprofundamento, ou quando surgem queixas, afastamentos e agravos relacionados", "Todo posto, sem exceção, a cada seis meses", "Somente na admissão de novos empregados", "Apenas em atividades administrativas"]', 0, 96),

    ('Os chamados riscos de acidente ou mecânicos incluem:',
     '["Máquina sem proteção, arranjo físico inadequado, queda de nível, eletricidade e queda de material", "Fungos e bactérias", "Ruído e vibração", "Metas excessivas e assédio"]', 0, 97),

    ('Diante de agente reconhecidamente cancerígeno no processo, a prioridade é:',
     '["Fornecer proteção respiratória adequada", "Eliminar ou substituir o agente, e somente onde isso for tecnicamente inviável adotar controle rigoroso, com registro e monitoramento dos expostos", "Aumentar a frequência do exame médico", "Reduzir a jornada dos expostos"]', 1, 98),

    ('Agentes com norma específica, como benzeno e amianto, exigem:',
     '["O cumprimento adicional das exigências próprias, como programas específicos, monitoramento e controle médico direcionado", "Apenas o que o PGR determinar", "Somente o fornecimento de EPI", "Apenas comunicação ao sindicato"]', 0, 99),

    ('Ao gerenciar exposição a ruído, a ordem correta de atuação começa por:',
     '["Distribuir protetores auriculares a todos", "Atuar na fonte e na trajetória, com enclausuramento, manutenção, silenciador e tratamento acústico, antes de recorrer à proteção individual", "Reduzir a jornada dos expostos", "Afastar o trabalhador do setor"]', 1, 100),

    ('A exposição à vibração no trabalho é avaliada considerando:',
     '["Apenas o peso da ferramenta", "Apenas o tempo total da jornada", "A vibração de mãos e braços e a de corpo inteiro, com a intensidade, o tempo de exposição e a condição do equipamento e do assento", "Apenas a idade do equipamento"]', 2, 101),

    ('No controle da exposição ao calor, além da hidratação, as medidas incluem:',
     '["Regime de trabalho e descanso adequado, ventilação, isolamento da fonte, sombreamento e organização das tarefas nos horários mais frescos", "Somente o fornecimento de roupa leve", "Somente a redução do ritmo de trabalho", "Somente o aumento do número de trabalhadores"]', 0, 102),

    ('Em atividades com radiação ionizante, uma característica importante do gerenciamento é:',
     '["Que a exposição não precisa ser monitorada individualmente", "Que basta a sinalização da área", "Que exige controle de área, monitoração individual da dose, capacitação específica e atendimento a normas próprias além da NR-01", "Que o EPI comum resolve a proteção"]', 2, 103),

    ('Iluminação inadequada deve entrar no gerenciamento de riscos porque:',
     '["Aumenta o consumo de energia", "Provoca fadiga visual, postura forçada, erro operacional e acidente, e deve atender aos níveis previstos em norma técnica", "Só afeta o trabalho administrativo", "Interfere apenas no conforto visual"]', 1, 104),

    ('Um sistema de ventilação local exaustora só cumpre sua função se:',
     '["For inspecionado, mantido e verificado quanto à captação efetiva no ponto de geração, com registro", "Estiver instalado, independentemente do estado", "Funcionar apenas no turno da manhã", "Estiver ligado ao mesmo quadro do ar-condicionado"]', 0, 105),

    ('Quando a proteção respiratória é necessária, a empresa deve manter:',
     '["Um programa de proteção respiratória com seleção técnica do respirador, ensaio de vedação, treinamento, higienização, guarda e substituição", "Apenas o estoque de máscaras no almoxarifado", "Apenas a ficha de entrega assinada", "Apenas a verificação do CA na compra"]', 0, 106),

    ('Um programa de conservação auditiva envolve:',
     '["Somente a audiometria admissional", "Somente a distribuição de protetores", "Avaliação da exposição, controle na fonte, seleção e uso correto do protetor, audiometrias periódicas e análise dos resultados em conjunto", "Somente o afastamento de quem apresentar perda"]', 2, 107),

    ('A gestão de EPI dentro do PGR abrange:',
     '["Apenas a compra com CA válido", "Seleção adequada ao risco, treinamento de uso, higienização, guarda, inspeção, substituição e registro da entrega", "Apenas o registro na ficha individual", "Apenas a fiscalização do uso pelos encarregados"]', 1, 108),

    ('Para que serve agrupar trabalhadores em grupos homogêneos de exposição?',
     '["Organizar a escala de férias", "Permitir que a avaliação feita em uma amostra represente todos que compartilham o mesmo perfil de exposição, otimizando o diagnóstico", "Definir o valor do adicional por setor", "Distribuir o EPI por tamanho"]', 1, 109),

    ('Uma avaliação de exposição só é representativa quando:',
     '["É feita no dia de menor produção, para não atrapalhar", "É feita uma única vez, na implantação do PGR", "Cobre as condições reais e as variações da tarefa, incluindo picos, e é feita com método e equipamento adequados", "É feita apenas no turno da manhã"]', 2, 110),

    ('Dados de avaliação antigos, obtidos antes de uma mudança de processo:',
     '["Continuam válidos até o prazo formal do documento", "Perdem representatividade e precisam ser refeitos, porque não descrevem mais a exposição atual", "Podem ser usados se o número de trabalhadores não mudou", "Servem como referência definitiva para o PPP"]', 1, 111),

    ('Sobre a guarda dos documentos e registros de SST:',
     '["Podem ser descartados ao fim de cada ano", "Devem ser guardados apenas em papel", "Devem ser mantidos pelo prazo previsto na norma, que alcança décadas em registros ligados à exposição e à saúde, e ficar disponíveis para consulta", "Devem ser destruídos quando o trabalhador se desliga"]', 2, 112),

    ('Quanto ao acesso do trabalhador e dos seus representantes ao inventário de riscos:',
     '["O acesso é restrito ao SESMT e à direção", "O acesso depende de autorização judicial", "O acesso ocorre somente durante a fiscalização", "O trabalhador e seus representantes têm direito de acesso às informações sobre os riscos a que estão expostos e às medidas adotadas"]', 3, 113),

    ('As informações individuais de saúde do trabalhador, colhidas no controle médico:',
     '["São protegidas por sigilo, e à empresa se comunica apenas a aptidão e as restrições necessárias para o trabalho", "Podem ser afixadas no mural do setor", "Podem ser compartilhadas com a chefia direta a pedido dela", "Podem ser divulgadas ao setor de pessoal em detalhe"]', 0, 114),

    ('O relatório analítico do controle médico serve para:',
     '["Justificar demissões por baixo desempenho", "Definir a periodicidade das férias", "Substituir o inventário de riscos", "Consolidar os achados de saúde do coletivo e realimentar o gerenciamento de riscos, apontando onde o controle está falhando"]', 3, 115),

    ('Um trabalhador retornou com restrição médica definitiva para a função anterior. A empresa deve:',
     '["Manter na mesma função e acompanhar", "Encerrar o contrato por incapacidade", "Avaliar readaptação ou realocação compatível com a restrição, ajustando o posto e as tarefas", "Aguardar nova avaliação em um ano"]', 2, 116),

    ('O trabalhador que sofreu acidente do trabalho com afastamento e recebeu auxílio previdenciário tem:',
     '["Garantia apenas enquanto durar o tratamento", "Garantia de emprego por três meses", "Garantia de emprego por doze meses após a cessação do benefício", "Nenhuma garantia após o retorno"]', 2, 117),

    ('O desempenho da empresa em acidentes influencia o custo previdenciário porque:',
     '["O valor da folha é reduzido proporcionalmente", "O fator de acidentalidade aumenta ou reduz a alíquota conforme o histórico de acidentes e doenças, o que torna a prevenção também uma decisão econômica", "A alíquota é fixa para todos os ramos", "O custo depende apenas do número de empregados"]', 1, 118),

    ('Além do custo direto, um acidente gera custos indiretos como:',
     '["Apenas o valor do medicamento", "Parada de produção, retrabalho, substituição e treinamento, perda de prazo, processo, investigação e abalo na equipe", "Apenas a diária hospitalar", "Apenas o transporte da vítima"]', 1, 119),

    ('Sobre trabalhadores menores de dezoito anos:',
     '["Podem exercer qualquer função com autorização dos pais", "Podem trabalhar em altura se receberem treinamento", "Podem trabalhar com produtos químicos sob supervisão", "São proibidos de exercer atividades perigosas, insalubres e as previstas na lista de piores formas de trabalho infantil"]', 3, 120),

    ('Quanto à trabalhadora gestante ou lactante em atividade insalubre:',
     '["Deve ser afastada das atividades insalubres nas condições previstas em lei, com garantia de remuneração", "Pode permanecer se usar EPI adequado", "Deve ser afastada apenas no último trimestre", "A decisão cabe exclusivamente à empresa"]', 0, 121),

    ('O trabalho em turnos e o trabalho noturno entram no gerenciamento de riscos porque:',
     '["Aumentam o custo da folha de pagamento", "Reduzem a exposição a agentes químicos", "Exigem uniforme diferente", "Alteram o sono e o desempenho, elevam a probabilidade de erro e de acidente e exigem medidas de organização do trabalho"]', 3, 122),

    ('Jornadas longas, acúmulo de horas extras e falta de pausa devem ser tratados como:',
     '["Fatores que integram a organização do trabalho e influenciam risco de acidente e adoecimento, entrando na avaliação e no plano de ação", "Assunto exclusivo do setor de pessoal", "Tema restrito à negociação coletiva", "Indicador de comprometimento da equipe"]', 0, 123),

    ('No teletrabalho, as obrigações de segurança e saúde:',
     '["Deixam de existir, porque o local é a casa do trabalhador", "Ficam a cargo exclusivo do trabalhador", "Aplicam-se apenas a quem trabalha mais de seis horas", "Permanecem: a empresa deve orientar quanto às condições do posto, aos cuidados ergonômicos e à comunicação de agravos, com registro"]', 3, 124),

    ('Um profissional autônomo contratado presta serviço dentro do estabelecimento. Quanto aos riscos do local:',
     '["Ele deve se informar por conta própria", "A empresa deve informá-lo dos riscos, das medidas de proteção e das regras do local, e garantir condições seguras onde ele atua", "Ele fica dispensado das regras internas", "A empresa não tem obrigação, por não haver vínculo"]', 1, 125),

    ('Visitantes e clientes que circulam pela área produtiva devem ser considerados porque:',
     '["Aumentam o número de expostos para efeito de CIPA", "Fazem parte dos grupos homogêneos de exposição", "Precisam assinar Ordem de Serviço", "O gerenciamento de riscos alcança quem pode ser atingido pelas atividades, e o plano precisa prever acompanhamento, orientação e proteção para eles"]', 3, 126),

    ('Em obra de construção, a relação entre o PGR do canteiro e a NR-01 é:',
     '["A obra fica fora do gerenciamento de riscos", "A obra precisa apenas do PCMSO", "A obra usa somente o PGR da empresa sede", "A norma da construção traz exigências próprias para o gerenciamento no canteiro, que se somam aos princípios gerais da NR-01"]', 3, 127),

    ('Nas atividades rurais, o gerenciamento de riscos deve considerar particularidades como:',
     '["Agrotóxicos, máquinas e implementos, animais, calor, transporte de trabalhadores e alojamento, conforme a norma específica do setor", "Somente o uso de máquinas agrícolas", "Somente o transporte de trabalhadores", "Somente o alojamento e a alimentação"]', 0, 128),

    ('A apreciação de risco de uma máquina, feita conforme a norma de máquinas, deve:',
     '["Ficar arquivada com o fabricante", "Servir somente para o projeto de máquinas novas", "Ser refeita a cada seis meses, sempre", "Alimentar o inventário de riscos e o plano de ação, indicando as proteções e os procedimentos necessários"]', 3, 129),

    ('Atividades como espaço confinado, trabalho em altura e trabalho a quente exigem, além do PGR:',
     '["Somente o registro no livro de ocorrências", "Procedimentos específicos, análise de risco da tarefa, permissão de trabalho quando aplicável e capacitação própria", "Somente a autorização verbal do supervisor", "Somente o fornecimento de EPI adequado"]', 1, 130),

    ('Sobre o prontuário das instalações elétricas:',
     '["É documento do fabricante do quadro", "Reúne os documentos da instalação, os procedimentos, as certificações e os laudos, e é peça de consulta para o gerenciamento dos riscos elétricos", "É exigido apenas em alta tensão", "Substitui o inventário de riscos do setor"]', 1, 131),

    ('O inventário de produtos químicos da empresa é importante porque:',
     '["Facilita a negociação com fornecedores", "Reduz o custo de estoque", "Atende a exigência contábil", "Permite conhecer o que existe, os perigos de cada produto e as incompatibilidades, orientando armazenamento, uso, descarte e emergência"]', 3, 132),

    ('A rotulagem preventiva e a ficha com dados de segurança dos produtos químicos servem para:',
     '["Comunicar de forma padronizada os perigos, as precauções e as medidas de emergência a quem manuseia o produto", "Identificar o fornecedor em caso de devolução", "Controlar o estoque mínimo", "Definir o preço de venda"]', 0, 133),

    ('Armazenar produtos químicos incompatíveis lado a lado é problema porque:',
     '["Em caso de vazamento ou incêndio, a mistura pode gerar reação violenta, gás tóxico ou aumento do incêndio", "Aumenta o custo do seguro", "Dificulta a conferência do estoque", "Confunde a identificação dos rótulos"]', 0, 134),

    ('O plano de atendimento a vazamento de produto químico deve prever:',
     '["Apenas o telefone do fornecedor", "Kit de contenção compatível, equipe treinada, proteção respiratória adequada, isolamento, destinação do resíduo e comunicação", "Apenas o afastamento de todos do prédio", "Apenas a lavagem do piso com água"]', 1, 135),

    ('Contratar consultoria externa para elaborar o PGR significa que:',
     '["A responsabilidade pela implementação passa para a consultoria", "O documento dispensa a participação dos trabalhadores", "A empresa fica isenta de fiscalização", "A responsabilidade pela organização e implementação do gerenciamento permanece com a empresa, que precisa fornecer informação e executar as ações"]', 3, 136),

    ('Um cliente exigiu o PGR da sua empresa antes de liberar o serviço no estabelecimento dele. Isso ocorre porque:',
     '["É exigência do setor de compras do cliente", "O cliente precisa conhecer e harmonizar os riscos que a atividade contratada traz para o local, e responde pelas condições onde o serviço acontece", "É burocracia sem base normativa", "Somente empresas certificadas podem prestar serviço"]', 1, 137),

    ('Adotar um sistema de gestão reconhecido, como uma norma internacional de SST, em relação à NR-01:',
     '["Substitui as obrigações legais", "Dispensa o inventário de riscos", "Não substitui as obrigações legais: organiza e reforça o gerenciamento, que continua tendo de atender à norma nacional", "Dispensa a capacitação prevista nas normas"]', 2, 138),

    ('O ciclo de melhoria contínua aplicado ao PGR significa:',
     '["Refazer o documento do zero a cada revisão", "Planejar, executar, verificar o resultado e corrigir, mantendo o gerenciamento vivo em vez de congelado no papel", "Aumentar o número de treinamentos a cada ano", "Trocar a consultoria periodicamente"]', 1, 139),

    ('Uma meta agressiva de zero acidente, cobrada com premiação, pode gerar qual efeito indesejado?',
     '["Aumento do custo com prevenção", "Subnotificação: acidente e quase-acidente deixam de ser comunicados para não perder o prêmio, e o sistema perde a informação de que precisa", "Excesso de treinamentos", "Redução do número de inspeções"]', 1, 140),

    ('Um trabalhador propôs uma melhoria de segurança que exige investimento. O tratamento correto é:',
     '["Arquivar por falta de orçamento", "Registrar, analisar tecnicamente, dar retorno ao proponente e, se pertinente, incluir no plano de ação com prazo e responsável", "Encaminhar apenas se houver acidente relacionado", "Implantar de imediato, sem análise"]', 1, 141),

    ('Quando o resultado do monitoramento mostra que a medida implantada não reduziu a exposição, o correto é:',
     '["Manter a medida e aumentar a fiscalização do uso de EPI", "Aguardar o próximo ciclo de avaliação", "Reavaliar a causa, revisar a escolha da medida e retornar ao plano de ação com solução de nível hierárquico superior", "Reclassificar o risco como aceitável"]', 2, 142),

    ('A ficha de emergência e a sinalização de risco em veículo e em área de armazenagem são exigidas porque:',
     '["Facilitam a conferência da carga", "São exigência do seguro de transporte", "Identificam o produto para efeito fiscal", "Permitem que quem chega para atender a emergência saiba com o que está lidando antes de se aproximar"]', 3, 143),

    ('Ao terceirizar uma atividade de alto risco, a empresa contratante deve, no mínimo:',
     '["Exigir apenas o contrato assinado", "Confiar na experiência da contratada", "Exigir apenas a apólice de seguro", "Verificar a capacitação e a documentação da contratada, informar os riscos do local, harmonizar procedimentos e acompanhar a execução"]', 3, 144),

    ('Sobre a participação dos trabalhadores nas decisões de segurança, o gerenciamento maduro:',
     '["Consulta apenas a chefia, que conhece o processo", "Consulta os trabalhadores somente após a implantação", "Restringe a participação aos membros do SESMT", "Envolve quem executa a tarefa na identificação dos perigos e na escolha das medidas, porque é ele quem conhece o trabalho real"]', 3, 145),

    ('Quando um mesmo tipo de acidente se repete em setores diferentes, o sinal é de que:',
     '["Os trabalhadores precisam de mais atenção", "O indicador está mal calculado", "A causa é sistêmica, ligada a projeto, procedimento, manutenção ou organização, e a correção precisa alcançar o sistema, não só o setor", "O treinamento precisa ser mais longo"]', 2, 146),

    ('O procedimento escrito de uma tarefa foi elaborado no escritório e o campo faz diferente. A conduta correta é:',
     '["Ir ao campo entender por que o trabalho real difere, corrigir o procedimento ou as condições e capacitar sobre a versão válida", "Aceitar a prática do campo sem análise", "Cobrar o cumprimento do procedimento como está", "Registrar advertência para quem descumpriu"]', 0, 147),

    ('Depois de uma fiscalização com notificação, a resposta adequada da empresa é:',
     '["Corrigir apenas o item apontado, no prazo dado", "Contestar todos os itens administrativamente", "Aguardar nova fiscalização para confirmar a exigência", "Corrigir o item, verificar se a mesma falha existe em outros setores e incorporar a correção ao plano de ação"]', 3, 148),

    ('Quando a empresa encerra uma atividade ou fecha um setor, os registros de exposição dos trabalhadores:',
     '["Devem ser preservados pelo prazo legal e ficar acessíveis, porque doença ocupacional pode se manifestar muitos anos depois", "Podem ser descartados junto com o encerramento", "Devem ser entregues ao sindicato", "Devem ser mantidos apenas em resumo"]', 0, 149),

    ('Ao final, o que distingue um PGR que funciona de um PGR que só existe no papel é:',
     '["O inventário refletir o trabalho real, o plano de ação ter dono e prazo cumpridos, e a revisão acontecer sempre que a realidade muda", "A assinatura de profissional habilitado na capa", "A quantidade de páginas e de anexos técnicos", "A contratação de consultoria especializada"]', 0, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-01-INT8';



-- =====================================================================
--  DD — Direção defensiva, 8 horas
--  A condução segura do dia a dia: conferência do veículo, regra de
--  circulação, convivência com pedestre, moto e caminhão, e as decisões
--  do motorista que roda a serviço da empresa. Fadiga, chuva forte,
--  noite, carga e pós-acidente ficam na reciclagem, que é onde o tempo
--  de aula permite entrar fundo nesses temas.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'DD')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('A conferência diária do veículo reprovou um item de segurança. O correto é:',
     '["Registrar a ocorrência, comunicar o responsável pela frota e não sair até a correção", "Sair e resolver no primeiro posto do caminho", "Sair devagar até a oficina mais próxima", "Anotar no relatório e seguir a rota normalmente"]', 0, 41),

    ('O documento do veículo que deve estar disponível para apresentação é:',
     '["O certificado de registro e licenciamento do veículo, dentro da validade", "O comprovante de pagamento do seguro", "A nota fiscal de compra do veículo", "O contrato de locação da frota"]', 0, 42),

    ('Dirigir veículo de categoria diferente da que consta na habilitação é:',
     '["Permitido se o motorista já dirigiu esse tipo de veículo antes", "Infração e risco: a categoria existe porque o porte e o comportamento do veículo mudam a exigência de habilidade", "Permitido se houver autorização escrita do gestor", "Permitido em trajeto interno da empresa"]', 1, 43),

    ('O que significa a observação de exercício de atividade remunerada na habilitação?',
     '["Que o condutor está autorizado a exercer atividade remunerada ao volante, exigência para quem dirige a serviço", "Que o condutor tem prioridade em vias urbanas", "Que o condutor pode dirigir qualquer categoria", "Que o condutor está isento de exame periódico"]', 0, 44),

    ('O cinto de segurança está bem ajustado quando:',
     '["A faixa transversal passa sobre o pescoço", "A faixa passa sobre o meio do ombro e a faixa inferior fica baixa, sobre o quadril, sem folga e sem torção", "A faixa fica frouxa, para permitir movimento", "A faixa passa por baixo do braço"]', 1, 45),

    ('O apoio de cabeça do banco deve ficar:',
     '["No ponto mais baixo, para não atrapalhar a visão traseira", "Com a parte central na altura dos olhos e das orelhas e próximo à cabeça, para limitar o movimento do pescoço na colisão", "Bem afastado da cabeça, para dar conforto", "Retirado, quando incomoda"]', 1, 46),

    ('A regulagem correta do banco em relação aos pedais é aquela em que:',
     '["A perna fica totalmente esticada ao pisar no pedal", "O joelho toca o painel", "É possível pisar o pedal até o fim mantendo o joelho levemente flexionado, sem tirar as costas do encosto", "O banco fica no fim do curso para trás, sempre"]', 2, 47),

    ('A posição recomendada das mãos no volante é:',
     '["Nas posições correspondentes a nove e três horas, com os polegares por fora do aro", "Uma mão no alto do volante e a outra no câmbio", "Uma mão só, apoiada no centro", "Cruzadas, para facilitar as curvas"]', 0, 48),

    ('Os espelhos retrovisores externos estão bem regulados quando:',
     '["Mostram apenas uma pequena parte do próprio veículo e o máximo possível da faixa vizinha, reduzindo a região não visível", "Apontam para o chão, mostrando as rodas", "Mostram apenas a faixa em que o veículo está", "Mostram boa parte da lateral do próprio veículo"]', 0, 49),

    ('Os espelhos convexos, aqueles arredondados, exigem atenção porque:',
     '["Ampliam a imagem e aproximam os objetos", "Ampliam o campo de visão, mas fazem o veículo parecer mais distante do que está", "Distorcem apenas as cores", "Só funcionam com o veículo parado"]', 1, 50),

    ('A calibragem dos pneus deve ser verificada:',
     '["Com os pneus quentes, logo após rodar", "Somente quando o pneu parecer murcho", "Apenas na troca de óleo", "Com os pneus frios, periodicamente, seguindo a pressão indicada pelo fabricante do veículo"]', 3, 51),

    ('O indicador de desgaste da banda de rodagem mostra que o pneu chegou ao limite quando:',
     '["A borracha começa a ficar lisa nas bordas", "O pneu completa cinco anos de uso", "A profundidade do sulco atinge o mínimo legal, marcado pelo indicador no fundo do sulco", "O pneu apresenta desgaste irregular"]', 2, 52),

    ('Antes de iniciar a viagem, além do pneu de uso, é preciso conferir:',
     '["Apenas o nível do óleo", "O estepe calibrado e em condição de uso, o macaco, a chave de roda e o triângulo", "Apenas o extintor", "Apenas os documentos"]', 1, 53),

    ('O pneu furou na rodovia. Onde é seguro fazer a troca?',
     '["Na própria faixa, com o pisca-alerta ligado", "Encostado no canteiro central", "No acostamento, o mais afastado possível da pista, com sinalização e, se não houver espaço seguro, aguardando socorro fora do veículo e do fluxo", "Em qualquer ponto, desde que rápido"]', 2, 54),

    ('O triângulo de sinalização deve ser colocado:',
     '["Encostado no para-choque do veículo", "A cerca de dez metros do veículo", "A uma distância suficiente para dar tempo de reação a quem se aproxima, aumentando esse espaço em curvas, aclives e alta velocidade", "Apenas quando houver outro veículo parado junto"]', 2, 55),

    ('O pisca-alerta deve ser usado:',
     '["Durante toda a viagem em rodovia", "Na imobilização em emergência e para alertar sobre situação de risco à frente, como fila parada", "Para pedir passagem em congestionamento", "Para estacionar em fila dupla enquanto se resolve algo rápido"]', 1, 56),

    ('Veículos elétricos e híbridos exigem um cuidado adicional em manobras e em áreas de pedestre porque:',
     '["Aceleram mais devagar que os demais", "Exigem habilitação de categoria diferente", "Têm freios menos eficientes", "São quase silenciosos em baixa velocidade, e o pedestre que se guia pelo som não percebe a aproximação"]', 3, 57),

    ('O farol alto deve ser desligado:',
     '["Somente quando o outro veículo pisca para reclamar", "Somente em vias urbanas", "Apenas em trechos com neblina", "Ao aproximar-se de veículo em sentido contrário e ao seguir outro veículo, para não ofuscar o condutor"]', 3, 58),

    ('O uso do farol de neblina é indicado:',
     '["Sempre que estiver escuro", "Para aumentar o alcance em rodovia limpa", "Em condições de baixa visibilidade, como neblina, chuva forte e cerração, e desligado quando a visibilidade voltar", "Como substituto do farol baixo com defeito"]', 2, 59),

    ('A seta deve ser acionada:',
     '["No exato momento da manobra", "Depois de iniciar a manobra, para confirmar", "Com antecedência suficiente para que os outros condutores percebam a intenção e ajustem a condução", "Apenas quando houver veículo próximo"]', 2, 60),

    ('Uma placa octogonal vermelha, com a palavra PARE, obriga o condutor a:',
     '["Reduzir e passar se não houver ninguém", "Buzinar antes de cruzar", "Parar somente quando houver veículo se aproximando", "Parar totalmente antes da faixa de retenção e só prosseguir com a via livre"]', 3, 61),

    ('A placa triangular com a inscrição de dar preferência significa que:',
     '["O condutor deve reduzir, avaliar e ceder passagem ao fluxo da via preferencial, parando se necessário", "A parada é obrigatória em qualquer situação", "O condutor tem prioridade sobre o fluxo transversal", "A via à frente está bloqueada"]', 0, 62),

    ('Placas de advertência, amarelas em forma de losango, servem para:',
     '["Avisar sobre condição da via à frente, como curva, lombada, estreitamento ou passagem de pedestres", "Impor obrigação ao condutor", "Indicar serviços e pontos turísticos", "Indicar o limite de velocidade da via"]', 0, 63),

    ('A faixa de retenção pintada antes do cruzamento indica:',
     '["O ponto de embarque de passageiros", "O limite de estacionamento permitido", "A divisão entre as faixas de trânsito", "O ponto onde o veículo deve parar no sinal vermelho, sem invadir a faixa de pedestres"]', 3, 64),

    ('O semáforo passou para o amarelo quando você se aproxima. O correto é:',
     '["Parar, salvo quando já estiver tão próximo que a frenagem coloque em risco quem vem atrás", "Acelerar para cruzar antes do vermelho", "Parar bruscamente em qualquer situação", "Seguir, porque o amarelo é apenas um aviso"]', 0, 65),

    ('Um agente de trânsito está orientando o fluxo em um cruzamento com semáforo funcionando. Nesse caso:',
     '["A ordem do agente prevalece sobre o semáforo e sobre a sinalização", "Vale a placa fixa do cruzamento", "Vale o semáforo, que é automático", "O condutor escolhe qual seguir"]', 0, 66),

    ('Em um cruzamento sem sinalização, com dois veículos chegando ao mesmo tempo:',
     '["Passa quem chegou pela via mais larga", "Passa o veículo maior", "A preferência é de quem vem pela direita, e o condutor deve confirmar a intenção do outro antes de avançar", "Passa quem estiver em velocidade maior"]', 2, 67),

    ('Para converter à esquerda em via de mão dupla, o condutor deve:',
     '["Iniciar a conversão pela faixa da direita", "Aproximar-se do eixo da pista, sinalizar com antecedência, aguardar o fluxo contrário e converter sem cortar a trajetória", "Buzinar e avançar, porque quem converge tem preferência", "Parar sobre a faixa de pedestres para aguardar"]', 1, 68),

    ('O retorno deve ser feito:',
     '["Em qualquer ponto onde a pista permita a manobra", "Aproveitando uma abertura no canteiro, mesmo sem sinalização", "Em marcha à ré, quando o retorno for longe", "Somente em local sinalizado e permitido, com visibilidade e após ceder passagem ao fluxo"]', 3, 69),

    ('Trafegar pela faixa exclusiva de ônibus com o veículo da empresa é:',
     '["Permitido em horário de pico", "Permitido quando a faixa está vazia", "Permitido para veículo a serviço", "Infração: a faixa é reservada, e o uso indevido cria conflito com veículo de grande porte em movimento"]', 3, 70),

    ('Ao cruzar uma ciclofaixa para entrar em uma garagem, o condutor deve:',
     '["Parar antes, olhar nos dois sentidos e dar passagem ao ciclista, que é o mais frágil na situação", "Avançar devagar, porque a bicicleta desvia", "Buzinar para avisar", "Acelerar para liberar rápido a passagem"]', 0, 71),

    ('Estacionar em vaga reservada a pessoa com deficiência ou a idoso, sem a credencial:',
     '["É aceitável por poucos minutos", "É aceitável quando não houver outra vaga", "É infração e retira do usuário legítimo a única vaga que atende à necessidade dele", "É aceitável se o veículo estiver com o pisca-alerta"]', 2, 72),

    ('Parar o veículo em fila dupla para uma entrega rápida:',
     '["É infração e cria risco: estreita a via, obriga manobras inesperadas e esconde o pedestre que atravessa", "É aceitável se o motorista permanecer no veículo", "É aceitável fora do horário de pico", "É aceitável se durar menos de cinco minutos"]', 0, 73),

    ('Estacionar com as rodas sobre a calçada é problema porque:',
     '["Danifica a suspensão do veículo", "Empurra o pedestre para a pista, justamente quem não tem proteção nenhuma", "Dificulta a saída do veículo", "Prejudica a drenagem da via"]', 1, 74),

    ('Em uma via urbana sem sinalização de velocidade, o limite aplicável é:',
     '["O que o condutor julgar seguro", "O previsto na legislação conforme o tipo de via, e não a velocidade do fluxo", "Sempre oitenta quilômetros por hora", "O mesmo da via principal mais próxima"]', 1, 75),

    ('Trafegar muito abaixo da velocidade da via, sem necessidade:',
     '["É sempre a conduta mais segura", "É permitido na faixa da esquerda", "Também é problema: obstrui o fluxo, provoca ultrapassagens arriscadas e deve ser evitado, mantendo-se à direita quando necessário", "É indiferente para os demais"]', 2, 76),

    ('Ao se aproximar de um redutor de velocidade, o correto é:',
     '["Reduzir antes, passar em velocidade constante e voltar a acelerar depois", "Frear em cima do redutor", "Passar com uma roda fora do redutor", "Acelerar para reduzir o impacto"]', 0, 77),

    ('Em trecho de escola, no horário de entrada e saída, a conduta defensiva é:',
     '["Reduzir bem a velocidade, cobrir o freio e esperar movimento imprevisível, porque criança atravessa sem avaliar distância", "Buzinar ao se aproximar de grupos de crianças", "Manter a velocidade e observar as placas", "Passar rápido para liberar a via"]', 0, 78),

    ('Um ônibus escolar está parado com o sinal de embarque acionado. O condutor deve:',
     '["Parar e aguardar, porque crianças podem surgir na frente e atrás do ônibus", "Buzinar e passar devagar", "Ultrapassar pela direita, se houver espaço", "Ultrapassar pela esquerda com atenção"]', 0, 79),

    ('Ao passar por um ônibus urbano parado no ponto, o cuidado principal é:',
     '["Manter distância lateral e reduzir, porque passageiros podem cruzar a via pela frente do ônibus, fora do campo de visão", "Acelerar para sair rápido do lado dele", "Buzinar para avisar quem desce", "Passar pela direita, entre o ônibus e a calçada"]', 0, 80),

    ('Diante de um pedestre idoso atravessando lentamente fora da faixa:',
     '["Reduzir, parar se necessário e aguardar a travessia com segurança", "Buzinar para que ele apresse o passo", "Contornar pela frente dele", "Seguir, porque a travessia é irregular"]', 0, 81),

    ('O transporte de criança em veículo exige:',
     '["O dispositivo de retenção adequado à idade, ao peso e à altura, instalado conforme a orientação do fabricante", "Que ela use o cinto de três pontos, em qualquer idade", "Que ela vá sempre no colo de um adulto no banco traseiro", "Que ela vá no banco da frente, sob supervisão"]', 0, 82),

    ('Criança abaixo da idade prevista em lei no banco dianteiro:',
     '["Pode, se estiver com cinto", "Pode, se o airbag estiver desativado", "Pode, em trajeto curto", "Não deve viajar no banco dianteiro, entre outros motivos porque o airbag é projetado para adulto e pode lesionar a criança"]', 3, 83),

    ('Transportar animal solto dentro do veículo:',
     '["É permitido se o animal for pequeno", "Cria risco de distração e, em uma frenagem, o animal vira projétil, além de ser irregular: deve ser transportado em caixa ou contenção adequada", "É permitido no banco traseiro", "É permitido se houver outro passageiro segurando"]', 1, 84),

    ('Motociclistas circulando entre as faixas exigem do condutor:',
     '["Fechar o espaço para desencorajar a manobra", "Buzinar sempre que perceber uma moto se aproximando", "Olhar os espelhos e o ponto cego antes de qualquer mudança de faixa, sinalizar cedo e evitar movimentos bruscos", "Manter-se sempre na faixa da esquerda"]', 2, 85),

    ('Uma bicicleta sem refletivo circula à sua frente em via mal iluminada. A conduta correta é:',
     '["Ultrapassar rápido pela direita", "Buzinar para que o ciclista se afaste", "Manter o farol alto ligado para enxergar melhor", "Reduzir, aguardar oportunidade segura e ultrapassar com distância lateral, sem colar"]', 3, 86),

    ('Um caminhão longo faz uma curva fechada e abre para o lado oposto antes de virar. Isso acontece porque:',
     '["O motorista está com dificuldade de manobra", "A carreta precisa de raio maior e a traseira corta a curva por dentro, por isso não se deve ocupar o espaço ao lado dele", "Ele está sinalizando ultrapassagem", "O veículo está com problema na direção"]', 1, 87),

    ('Ao ultrapassar um veículo longo, o cuidado adicional é:',
     '["Considerar a distância bem maior necessária, sair da região não visível dele e concluir a manobra sem hesitar, com visibilidade garantida", "Ultrapassar em qualquer trecho, porque o caminhão anda devagar", "Ficar ao lado dele por mais tempo, para ser visto", "Buzinar durante toda a manobra"]', 0, 88),

    ('Ultrapassar em uma subida é mais arriscado porque:',
     '["O veículo perde estabilidade na subida", "O motor esquenta mais", "O pneu desgasta mais rápido", "A visibilidade do que vem em sentido contrário é reduzida e o veículo tem menos capacidade de aceleração para concluir a manobra"]', 3, 89),

    ('A ultrapassagem pela direita é admitida:',
     '["Sempre que a faixa da direita estiver livre", "Quando o veículo da frente estiver sinalizando conversão à esquerda ou em situações específicas previstas na legislação, como fluxo em filas", "Nunca, em nenhuma hipótese", "Sempre que o veículo da frente estiver abaixo do limite"]', 1, 90),

    ('Ao rodar em comboio com outros veículos da empresa, o correto é:',
     '["Manter os veículos bem próximos, para não perder o grupo", "Manter o pisca-alerta ligado durante todo o trajeto", "Ultrapassar em conjunto, para o comboio não se separar", "Manter distância normal entre os veículos e combinar previamente rota e pontos de parada, sem depender de seguir o carro da frente"]', 3, 91),

    ('Ao entrar em uma rodovia pela faixa de aceleração, o correto é:',
     '["Entrar em velocidade baixa e acelerar depois", "Parar no fim da faixa e aguardar espaço", "Entrar direto, porque quem está na rodovia deve ceder", "Usar a faixa para atingir velocidade compatível com o fluxo, sinalizar e entrar em brecha segura, sem obrigar o outro a frear"]', 3, 92),

    ('Ao sair de uma rodovia por um acesso à direita, o correto é:',
     '["Sinalizar com antecedência, posicionar-se à direita e reduzir dentro da faixa de desaceleração", "Frear na faixa de rolamento e depois entrar no acesso", "Cortar duas faixas de uma vez ao ver a placa", "Parar no acostamento antes do acesso"]', 0, 93),

    ('O uso do acostamento para trafegar e ganhar tempo:',
     '["É aceitável em congestionamento", "É proibido e perigoso: o acostamento é área de emergência, com veículos parados, pedestres e piso irregular", "É aceitável para veículos a serviço", "É aceitável em rodovia de pista dupla"]', 1, 94),

    ('Ao chegar a um trecho em obras com trabalhadores na pista, a conduta é:',
     '["Manter a velocidade e desviar dos cones", "Reduzir bem a velocidade, seguir a sinalização temporária e a orientação do bandeirinha, e não invadir a área isolada", "Passar pelo acostamento para liberar a faixa", "Buzinar para avisar da aproximação"]', 1, 95),

    ('Ao se aproximar de uma praça de pedágio, o condutor deve:',
     '["Manter a velocidade até a cabine", "Reduzir com antecedência, escolher a pista correta cedo e evitar mudança de fila em cima da praça", "Mudar de fila conforme o movimento diminuir", "Parar somente sobre a faixa de pagamento"]', 1, 96),

    ('Ao entrar em um túnel, o cuidado imediato é:',
     '["Aumentar a velocidade para sair rápido", "Ligar o pisca-alerta durante o trajeto", "Acender o farol baixo, retirar óculos escuros, manter distância e não parar nem fazer retorno dentro do túnel", "Manter o farol alto para melhorar a visão"]', 2, 97),

    ('Ao chegar a uma ponte estreita, com passagem para um veículo por vez:',
     '["Passar primeiro quem estiver mais próximo, sem sinalizar", "Buzinar e avançar", "Passar sempre o veículo mais pesado", "Observar a sinalização de prioridade, e na ausência dela ajustar a velocidade, sinalizar e só avançar com o outro parado ou distante"]', 3, 98),

    ('Em uma passagem de nível com linha férrea, a conduta correta é:',
     '["Acelerar para cruzar rápido", "Parar sobre os trilhos apenas se o fluxo à frente estiver parado", "Cruzar em marcha reduzida sem parar", "Reduzir, parar quando exigido, olhar nos dois sentidos e só cruzar com a saída livre do outro lado"]', 3, 99),

    ('Em estrada de terra, uma diferença importante em relação ao asfalto é:',
     '["A aderência é menor, a frenagem exige mais distância e a poeira ou o barro reduzem muito a visibilidade", "A frenagem é mais eficiente no piso solto", "A velocidade pode ser mantida se o piso estiver seco", "O desgaste do pneu diminui"]', 0, 100),

    ('Ao encontrar uma nuvem de poeira levantada por outro veículo em estrada de terra:',
     '["Acelerar para atravessar rapidamente", "Ligar o farol alto para enxergar melhor", "Manter a mesma velocidade seguindo a marca dos pneus", "Reduzir a velocidade, aumentar a distância, ligar o farol baixo e, se a visibilidade sumir, parar em local seguro fora do fluxo"]', 3, 101),

    ('Um buraco surge à frente e não há tempo de desviar com segurança. A conduta é:',
     '["Desviar bruscamente para a outra faixa", "Frear antes do buraco, soltar o freio ao passar e manter o volante firme, sem manobra brusca", "Acelerar para passar mais leve", "Frear com força em cima do buraco"]', 1, 102),

    ('Um objeto caiu na pista à sua frente, em rodovia movimentada. A ação mais segura é:',
     '["Desviar imediatamente para o acostamento", "Reduzir de forma progressiva, avaliar espelhos e faixas e desviar apenas se houver espaço, evitando manobra que jogue o veículo contra outro", "Frear bruscamente e parar sobre a faixa", "Passar por cima, em qualquer caso"]', 1, 103),

    ('Durante o abastecimento do veículo, o correto é:',
     '["Manter o motor ligado se for rápido", "Manter os faróis acesos para iluminar a área", "Deixar os passageiros dentro com o ar-condicionado ligado", "Desligar o motor, não fumar, não usar o celular e evitar embarque e desembarque de passageiros junto à bomba"]', 3, 104),

    ('Sentiu cheiro forte de combustível dentro ou em volta do veículo. O correto é:',
     '["Abrir os vidros e continuar até o destino", "Ligar o ar-condicionado para dispersar", "Parar em local seguro, desligar o motor, afastar-se de fontes de calor e chama e acionar a manutenção", "Verificar a origem com o motor ligado"]', 2, 105),

    ('O motor superaqueceu e a temperatura subiu ao máximo. O correto é:',
     '["Abrir a tampa do radiador para aliviar a pressão", "Jogar água fria no motor", "Parar em local seguro, desligar o motor e aguardar o resfriamento, sem abrir o sistema quente", "Continuar até o próximo posto com o aquecimento ligado"]', 2, 106),

    ('A luz de pressão do óleo acendeu no painel durante o trajeto. A conduta é:',
     '["Completar o óleo no próximo posto e seguir", "Ignorar, porque é apenas indicação de nível", "Reduzir a velocidade e continuar até o destino", "Parar em local seguro assim que possível e desligar o motor, porque rodar sem pressão de óleo destrói o motor em poucos minutos"]', 3, 107),

    ('Sair com o freio de estacionamento parcialmente acionado provoca:',
     '["Apenas aumento do consumo", "Melhor estabilidade em curvas", "Somente ruído no eixo traseiro", "Superaquecimento e perda de eficiência do freio, além de desgaste acelerado"]', 3, 108),

    ('Em veículo com câmbio automático, em uma descida longa, o correto é:',
     '["Manter em ponto morto para poupar combustível", "Manter o freio pressionado durante toda a descida", "Usar a posição ou o modo que segura a marcha reduzida, deixando o motor ajudar a frear, e usar o freio em aplicações espaçadas", "Desligar o motor na descida"]', 2, 109),

    ('Descer uma ladeira em ponto morto ou com a embreagem pisada é:',
     '["Aceitável em descidas curtas", "Recomendado para economizar combustível", "Aceitável se o freio for novo", "Perigoso e irregular: o veículo perde o efeito de retenção do motor e passa a depender só do freio, que superaquece"]', 3, 110),

    ('A condução suave, sem acelerações e frenagens bruscas, contribui para a segurança porque:',
     '["Mantém o veículo estável, preserva a aderência, dá previsibilidade a quem está em volta e amplia o tempo de reação", "Aumenta a vida útil do câmbio somente", "Reduz apenas o consumo de combustível", "Permite dirigir mais rápido com segurança"]', 0, 111),

    ('Cortar a curva ocupando parte da faixa contrária é problema porque:',
     '["Desgasta mais o pneu dianteiro", "Coloca o veículo na trajetória de quem vem em sentido contrário, exatamente onde a visibilidade é menor", "Prejudica o conforto dos passageiros", "Aumenta o consumo do veículo"]', 1, 112),

    ('Manter distância lateral adequada de outros veículos e de obstáculos serve para:',
     '["Evitar o desgaste dos pneus", "Reduzir o ruído dentro do veículo", "Facilitar a leitura das placas", "Preservar espaço de manobra e de escape caso alguém invada a sua faixa ou uma porta se abra"]', 3, 113),

    ('Uma boa varredura visual na condução significa:',
     '["Fixar o olhar no veículo imediatamente à frente", "Olhar somente o painel e os espelhos", "Olhar apenas para as faixas do piso", "Olhar longe, à frente do trânsito imediato, e alternar com espelhos e laterais em intervalos curtos e regulares"]', 3, 114),

    ('O conceito de rota de escape na direção defensiva significa:',
     '["Conhecer um caminho alternativo em caso de congestionamento", "Ter sempre onde parar para descansar", "Ter combustível suficiente para desviar da rota", "Manter, o tempo todo, um espaço livre em volta do veículo para onde seja possível se deslocar se algo der errado à frente"]', 3, 115),

    ('Comunicar-se no trânsito, na direção defensiva, significa principalmente:',
     '["Buzinar sempre que alguém errar", "Usar o farol alto para chamar atenção", "Tornar suas intenções previsíveis com seta, posicionamento e velocidade, e confirmar que o outro percebeu você", "Gesticular para orientar os outros condutores"]', 2, 116),

    ('Você parou para um pedestre atravessar em via com duas faixas no mesmo sentido. O cuidado adicional é:',
     '["Acenar de imediato para que ele atravesse", "Considerar que o condutor da faixa vizinha pode não ter visto o pedestre, e por isso não acenar para a travessia sem confirmar que ele também parou", "Buzinar para avisar o veículo da faixa ao lado", "Avançar um pouco para bloquear a outra faixa"]', 1, 117),

    ('Usar o farol alto em lampejos para pedir passagem à noite:',
     '["É a forma correta de sinalizar ultrapassagem", "É indiferente para o outro condutor", "Ofusca e desorienta quem está à frente, e não substitui a avaliação de espaço e visibilidade para a manobra", "Substitui o uso da seta"]', 2, 118),

    ('Um passageiro conversa em tom alto e insiste em mostrar coisas no celular durante a condução. O correto é:',
     '["Responder rapidamente para encerrar o assunto", "Pedir que aguarde, explicar que atrapalha a condução e, se necessário, parar em local seguro para conversar", "Continuar dirigindo e olhar de relance", "Desligar o rádio e seguir a conversa"]', 1, 119),

    ('Comer, beber ou manusear embalagem enquanto dirige:',
     '["É aceitável em trechos retos de rodovia", "É aceitável em velocidade baixa", "Retira a mão do volante e a atenção da via, e deve ser feito com o veículo parado em local seguro", "É aceitável se o alimento estiver preparado"]', 2, 120),

    ('Fumar dentro do veículo durante a condução:',
     '["Ocupa uma das mãos, distrai, e a brasa que cai provoca reação brusca, além do risco em veículo com combustível ou carga inflamável", "Só é problema em veículo com carga", "É permitido com o vidro aberto", "Não interfere na segurança"]', 0, 121),

    ('Ao entrar em um túnel ou em uma área sombreada usando óculos escuros:',
     '["Manter os óculos, porque a vista se adapta rápido", "Levantar os óculos para a testa depois de entrar", "Retirar os óculos antes de entrar, porque a adaptação da visão ao escuro leva tempo e a redução de luz é imediata", "Compensar aumentando a velocidade"]', 2, 122),

    ('Dirigir de chinelo, sandália frouxa ou pé descalço:',
     '["É permitido em trajeto curto", "É indiferente, porque o pedal é largo", "Compromete a firmeza no pedal, o calçado pode prender e o pé escorregar em uma frenagem de emergência", "É permitido em veículo automático"]', 2, 123),

    ('A distribuição da carga no porta-malas deve ser feita:',
     '["Com o peso maior na parte de cima, para facilitar o acesso", "Com todo o peso concentrado em um lado", "Com o peso maior embaixo e à frente, próximo ao encosto, e tudo acomodado para não se deslocar em uma frenagem", "Com o volume mais alto encostado no vidro traseiro"]', 2, 124),

    ('O veículo puxa para um lado sempre que o motorista freia. Isso indica:',
     '["Desgaste normal do sistema, que se corrige sozinho", "Problema no sistema de freios ou na suspensão, que exige avaliação da manutenção antes de seguir rodando", "Excesso de pressão em um dos pneus apenas", "Falta de alinhamento sem consequência para a frenagem"]', 1, 125),

    ('Ao tracionar um reboque ou uma carretinha, o condutor deve:',
     '["Manter a mesma velocidade e a mesma distância de sempre", "Frear com mais força, porque o peso ajuda a parar", "Reduzir a velocidade, ampliar a distância de seguimento, considerar o comprimento maior nas manobras e conferir engate, luzes e amarração", "Ignorar as luzes do reboque em trajeto diurno"]', 2, 126),

    ('Ao encontrar carroça, veículo de tração animal ou trator agrícola em via rural, a conduta correta é:',
     '["Buzinar para que saiam da pista", "Ultrapassar de imediato, porque estão muito lentos", "Confiar que o condutor vai perceber a aproximação pelo espelho", "Reduzir bem antes, manter distância e ultrapassar apenas com visibilidade e espaço amplos, porque esses veículos não sinalizam manobra e o animal pode se assustar"]', 3, 127),

    ('Planejar o trajeto antes de sair contribui para a segurança porque:',
     '["Reduz o consumo de combustível apenas", "Elimina a necessidade de conferir o veículo", "Permite prever paradas, distância, horário e condições, evitando decisões apressadas e improviso durante a condução", "Garante o cumprimento do prazo de entrega"]', 2, 128),

    ('O aplicativo de navegação indicou um trajeto por via inadequada ao porte do veículo. O correto é:',
     '["Não seguir cegamente: verificar restrição de altura, peso e circulação e escolher a rota compatível com o veículo", "Seguir e avaliar no local se dá para passar", "Seguir a indicação, porque o aplicativo é atualizado", "Desligar o aplicativo e seguir pela memória"]', 0, 129),

    ('Dirigir com uma das mãos apenas, com o braço apoiado na janela ou no encosto do banco ao lado:',
     '["É aceitável em trechos retos e vazios", "É indiferente, porque a direção é hidráulica", "Só é problema em veículos de grande porte", "Reduz o controle em uma manobra de emergência, quando é preciso girar o volante com firmeza e rapidez"]', 3, 130),

    ('Uma multa recebida com o veículo da empresa deve ser:',
     '["Ignorada, porque o veículo está no nome da empresa", "Comunicada de imediato ao gestor da frota, com identificação do condutor, para os procedimentos internos e a indicação legal do infrator", "Paga diretamente pelo motorista, sem informar", "Contestada sempre, automaticamente"]', 1, 131),

    ('O motorista está próximo do limite de pontos na habilitação. A conduta correta é:',
     '["Comunicar a empresa, acompanhar a situação e adotar as providências antes de uma suspensão surpreender no meio da rota", "Emprestar a habilitação de um colega em caso de fiscalização", "Continuar dirigindo e contestar as multas depois", "Reduzir a quilometragem diária apenas"]', 0, 132),

    ('O exame toxicológico exigido de condutores das categorias profissionais tem por finalidade:',
     '["Verificar a acuidade visual", "Substituir o exame médico periódico", "Comprovar o vínculo com a empresa", "Identificar o uso de substâncias que comprometem a atenção e o tempo de reação, condição incompatível com a condução profissional"]', 3, 133),

    ('Usar o veículo da empresa para fins particulares sem autorização:',
     '["É aceitável fora do horário de trabalho", "É aceitável em trajeto curto", "Descumpre a regra de uso da frota, cria problema de responsabilidade em caso de sinistro e deve ser tratado conforme a política da empresa", "É aceitável se o motorista abastecer por conta própria"]', 2, 134),

    ('Ocorreu um dano no veículo, mesmo sem terceiros envolvidos. O motorista deve:',
     '["Consertar por conta própria e não informar", "Comunicar a empresa, registrar o ocorrido com data, local e circunstâncias, e seguir o procedimento da frota", "Informar no fim do mês, junto do relatório", "Informar apenas se o dano for visível"]', 1, 135),

    ('Um terceiro envolvido em uma colisão propõe acordo imediato em dinheiro, sem registro. O motorista da empresa deve:',
     '["Aceitar, para resolver rápido", "Negociar um valor menor", "Aceitar e informar depois", "Recusar o acordo por conta própria e seguir o procedimento da empresa, com registro do ocorrido e comunicação ao gestor e ao seguro"]', 3, 136),

    ('Diante de um acidente com vítima, além de acionar o socorro, a lei impõe ao condutor envolvido:',
     '["Remover a vítima até o hospital mais próximo, sempre", "Retirar os veículos da via antes de qualquer providência", "Permanecer no local, prestar ou providenciar socorro e se identificar, porque evadir-se é crime", "Aguardar orientação da empresa antes de qualquer ação"]', 2, 137),

    ('O motorista está com dor forte, febre ou mal-estar no dia da rota. O correto é:',
     '["Tomar remédio e seguir a rota", "Dirigir devagar e fazer mais paradas", "Comunicar a chefia e não assumir a direção, porque dor e mal-estar reduzem atenção e tempo de reação", "Pedir a um colega sem habilitação adequada que assuma"]', 2, 138),

    ('A habilitação traz a restrição de uso de lentes corretivas. Isso significa que:',
     '["A restrição vale apenas para direção noturna", "O condutor só pode dirigir usando os óculos ou lentes, e dirigir sem eles é irregular e inseguro", "A restrição é uma recomendação médica sem efeito legal", "A restrição pode ser dispensada em trajeto curto"]', 1, 139),

    ('Um passageiro se recusa a usar o cinto de segurança no veículo da empresa. O motorista deve:',
     '["Seguir viagem, porque a responsabilidade é do passageiro", "Registrar a recusa e seguir", "Não iniciar o deslocamento até que todos estejam com o cinto afivelado, explicando a regra", "Reduzir a velocidade para compensar"]', 2, 140),

    ('No transporte de trabalhadores em van ou micro-ônibus da empresa, é obrigatório:',
     '["Apenas o número de assentos suficiente", "Respeitar a lotação, ter assentos com cinto, manutenção em dia, e condutor habilitado e autorizado para o transporte de pessoas", "Apenas a autorização do gestor da frota", "Apenas manter o extintor e o triângulo"]', 1, 141),

    ('Antes de dar partida com passageiros a bordo, o condutor deve conferir:',
     '["Apenas o funcionamento do ar-condicionado", "Se todos estão sentados e com cinto, se as portas estão fechadas e se não há objeto solto na cabine", "Apenas se todos entraram", "Apenas o nível de combustível"]', 1, 142),

    ('Um colega pede para você assumir a direção sem estar registrado como condutor autorizado daquele veículo. O correto é:',
     '["Assumir, se você tiver a habilitação da categoria", "Assumir apenas dentro do pátio", "Assumir e informar depois ao gestor", "Não assumir sem a autorização formal: em caso de sinistro, a irregularidade recai sobre você e sobre a empresa"]', 3, 143),

    ('Os pneus estão desgastando de forma irregular, mais nas bordas ou mais no centro. Isso indica:',
     '["Problema de calibragem, alinhamento, balanceamento ou suspensão, que reduz a aderência e precisa ser corrigido", "Que o pneu é de marca inferior", "Que o veículo roda muito em rodovia", "Que o rodízio de pneus foi feito recentemente"]', 0, 144),

    ('Sempre que possível, estacionar com a frente do veículo voltada para a saída é recomendado porque:',
     '["Facilita a leitura da placa pelo vigilante", "Reduz o desgaste do câmbio", "Evita a manobra de ré na saída, que é quando a visibilidade é pior e o pátio já está com movimento de pessoas", "Melhora a ventilação do motor"]', 2, 145),

    ('Circular em pátio de fábrica, obra ou centro de distribuição exige:',
     '["Velocidade normal, porque é área privada", "Respeito à sinalização interna, velocidade bem reduzida, atenção a empilhadeiras e pedestres e obediência às rotas definidas", "Apenas o uso do pisca-alerta", "Buzinar continuamente para avisar da presença"]', 1, 146),

    ('Objetos pendurados no retrovisor interno e adesivos no para-brisa:',
     '["Obstruem parte do campo visual e escondem exatamente o que aparece de repente, como pedestre e moto", "Ajudam a estimar distância", "Só atrapalham à noite", "Personalizam o veículo sem consequência"]', 0, 147),

    ('Ao encerrar a rota, o motorista deve:',
     '["Apenas estacionar e entregar a chave", "Estacionar em local seguro, desligar, travar, retirar objetos de valor e registrar quilometragem, abastecimento e qualquer avaria percebida", "Deixar o veículo abastecido apenas", "Deixar o registro para o dia seguinte"]', 1, 148),

    ('Uma avaria pequena, como retrovisor trincado ou lanterna com defeito, deve ser reportada porque:',
     '["Compromete a visibilidade e a comunicação com os outros condutores, e o defeito pequeno é o que se acumula até virar acidente", "Serve como justificativa de atraso", "Afeta a aparência da frota", "É exigência do seguro apenas"]', 0, 149),

    ('Em resumo, o que diferencia a direção defensiva da direção apenas correta é:',
     '["Antecipar o erro do outro e manter espaço, visibilidade e tempo suficientes para reagir quando ele acontecer", "Conhecer bem a legislação de trânsito", "Ter veículo em dia e documentação regular", "Dirigir sempre em velocidade baixa"]', 0, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'DD';



-- =====================================================================
--  DD-REC — Direção defensiva, reciclagem
--  O aluno já sabe dirigir e já fez o curso básico. O que derruba
--  motorista rodado é outra coisa: jornada e fadiga, escuro, chuva,
--  carga mal resolvida, o hábito que virou atalho e os primeiros minutos
--  depois da batida. É disso que a prova trata.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'DD-REC')
   and ordem between 41 and 150;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Na legislação do motorista profissional, após um período contínuo de direção é obrigatório:',
     '["Fazer um intervalo de descanso ao completar o tempo máximo de direção contínua previsto em lei, antes de retomar o volante", "Seguir até completar a jornada e descansar no fim", "Parar somente quando sentir sono", "Compensar o descanso no dia seguinte"]', 0, 41),

    ('O descanso entre duas jornadas de trabalho do motorista profissional existe para:',
     '["Permitir a manutenção do veículo", "Cumprir exigência do contrato de transporte", "Garantir sono suficiente para recuperar a atenção, porque a fadiga acumulada é o que provoca o erro no dia seguinte", "Reduzir o consumo de combustível"]', 2, 42),

    ('O tempo de espera para carga e descarga, na jornada do motorista:',
     '["Equivale a descanso, porque o veículo está parado", "Pode ser somado ao tempo de direção sem limite", "Não é descanso: parado esperando, sentado na cabine e sem sono reparador, o motorista continua acumulando desgaste", "Não precisa ser registrado"]', 2, 43),

    ('Para que serve o registro de jornada do motorista, seja em diário de bordo ou em sistema eletrônico?',
     '["Calcular o valor do frete", "Controlar o consumo de combustível", "Comprovar o cumprimento dos tempos de direção e descanso e permitir que desvios sejam corrigidos antes do acidente", "Registrar a quilometragem para revisão"]', 2, 44),

    ('Em viagem com dupla de motoristas, o descanso do que não está dirigindo:',
     '["É integral, porque ele está deitado", "É parcial: dormir com o veículo em movimento é sono de qualidade menor, e isso precisa ser considerado no planejamento", "Dispensa a parada obrigatória do veículo", "Permite dobrar o tempo total de viagem sem restrição"]', 1, 45),

    ('O relógio biológico influencia a segurança na direção porque:',
     '["Determina a hora ideal para abastecer", "Faz o organismo pedir sono com mais força na madrugada e no meio da tarde, independentemente da vontade do motorista", "Afeta apenas quem trabalha de dia", "Só interfere em motoristas acima de determinada idade"]', 1, 46),

    ('O que é a dívida de sono e por que ela importa?',
     '["É a sonolência que aparece depois do almoço", "É o sono perdido que se acumula noite após noite e cobra o preço em atenção e tempo de reação, mesmo que o motorista se sinta bem", "É o sono que se recupera integralmente com uma noite bem dormida", "É o tempo de sono que excede oito horas"]', 1, 47),

    ('O cochilo estratégico durante a viagem funciona melhor quando:',
     '["Dura duas ou três horas, para valer a pena", "É feito com o veículo parado no acostamento da rodovia", "Dura de quinze a vinte minutos, em local seguro, com o veículo desligado e travado", "É substituído por uma caminhada em volta do veículo"]', 2, 48),

    ('Logo depois de acordar de um cochilo, antes de voltar a dirigir, é preciso:',
     '["Aguardar alguns minutos até a sonolência residual passar, porque nos primeiros instantes o desempenho ainda está reduzido", "Tomar um energético e sair", "Partir imediatamente, para não perder o efeito", "Dirigir devagar nos primeiros quilômetros"]', 0, 49),

    ('Ronco alto, pausas na respiração durante o sono e sonolência de dia mesmo dormindo o suficiente sugerem:',
     '["Falta de condicionamento físico", "Excesso de trabalho apenas", "Efeito normal da idade", "Possível apneia do sono, condição que precisa de avaliação médica e que compromete de forma grave a condução"]', 3, 50),

    ('Um motorista relata sonolência durante a jornada no exame ocupacional. O encaminhamento correto é:',
     '["Registrar e liberar, porque todo motorista sente sono", "Recomendar apenas o uso de café", "Trocar o turno dele para a madrugada", "Avaliar as causas, investigar distúrbio do sono, revisar a escala e definir a conduta antes de manter o trabalhador em condução"]', 3, 51),

    ('Uma refeição pesada antes de retomar o volante:',
     '["Melhora a disposição pelo aporte de energia", "É indiferente para a atenção", "Só afeta motoristas com problema digestivo", "Aumenta a sonolência nas horas seguintes, e por isso a refeição principal deve ser mais leve antes de trechos longos"]', 3, 52),

    ('A desidratação leve durante a viagem afeta a condução porque:',
     '["Provoca apenas sede", "Reduz a atenção, aumenta o cansaço e a dor de cabeça, e piora o tempo de reação", "Afeta somente em dias muito quentes", "Interfere apenas na visão noturna"]', 1, 53),

    ('Antialérgicos, relaxantes musculares e alguns remédios para dor podem:',
     '["Ser usados livremente, por serem vendidos sem receita", "Ser usados em meia dose antes de dirigir", "Só afetar quem dirige à noite", "Causar sonolência e reduzir reflexo, e por isso exigem consulta ao serviço médico antes de assumir a direção"]', 3, 54),

    ('O motorista bebeu na noite anterior e dormiu poucas horas. No dia seguinte:',
     '["Está apto, porque o álcool já foi eliminado", "Pode ainda haver álcool no organismo e, mesmo eliminado, o sono ruim deixa o desempenho comprometido", "Pode dirigir em trechos urbanos apenas", "Pode dirigir se tomar café da manhã reforçado"]', 1, 55),

    ('Um motorista que muda de turno com frequência precisa considerar que:',
     '["A adaptação é imediata após o primeiro dia", "A troca de turno não afeta a condução", "O corpo leva dias para se ajustar, e os primeiros turnos após a troca são os de maior risco de erro por sono", "Basta dormir mais no dia da folga"]', 2, 56),

    ('Dormir na cabine do veículo entre jornadas exige, no mínimo:',
     '["Estacionar no acostamento com o motor ligado", "Local seguro e permitido, veículo desligado e travado, ventilação adequada e ambiente que permita sono reparador", "Manter o ar-condicionado ligado com o motor em funcionamento a noite toda", "Apenas cortina nas janelas"]', 1, 57),

    ('A monotonia de uma rodovia reta e vazia é perigosa porque:',
     '["Diminui os estímulos, leva à queda de atenção e ao estado em que o motorista percorre quilômetros sem lembrar do trajeto", "Reduz a aderência dos pneus", "Aumenta o consumo do veículo", "Provoca superaquecimento do motor"]', 0, 58),

    ('Um motorista faz outra atividade remunerada nas horas de folga. O efeito sobre a condução é que:',
     '["Nenhum, desde que ele cumpra o horário da empresa", "O efeito é positivo, porque mantém a pessoa ativa", "O descanso previsto deixa de existir na prática, e ele chega à jornada de direção já com déficit de recuperação", "Só há problema se a segunda atividade também for dirigir"]', 2, 59),

    ('A empresa pressiona para que o motorista siga viagem apesar do cansaço. A conduta correta é:',
     '["Seguir e compensar com paradas curtas", "Seguir até a metade do trajeto e reavaliar", "Aceitar e pedir um acompanhante na cabine", "Recusar dirigir naquele estado, comunicar formalmente a situação e registrar, porque dirigir com fadiga é risco grave para ele e para terceiros"]', 3, 60),

    ('A visão leva um tempo considerável para se adaptar ao escuro. Na prática, isso significa que:',
     '["Sair de um pátio bem iluminado direto para a estrada escura deixa o motorista com visão reduzida nos primeiros minutos", "A adaptação é instantânea ao entardecer", "Óculos escuros ajudam nessa transição", "A adaptação depende apenas da idade do condutor"]', 0, 61),

    ('À noite, a percepção de cores e a visão periférica:',
     '["Melhoram, porque o olho fica mais sensível", "Ficam reduzidas, e por isso obstáculos fora do feixe do farol são percebidos tarde demais", "Permanecem iguais às do dia", "Só se alteram com neblina"]', 1, 62),

    ('O painel e a iluminação interna muito claros durante a condução noturna:',
     '["Ajudam a manter a atenção", "Não interferem na visão do motorista", "Prejudicam a adaptação da vista ao escuro e reduzem o alcance visual sobre a pista", "São recomendados para leitura de documentos"]', 2, 63),

    ('Um veículo segue colado atrás do seu, com farol alto, e o brilho toma o retrovisor. O correto é:',
     '["Acionar o modo noturno do espelho interno ou desviá-lo, olhar para a borda direita da pista, reduzir e facilitar a ultrapassagem", "Acelerar para abrir distância", "Frear de leve para que ele se afaste", "Ligar o farol alto para retribuir"]', 0, 64),

    ('Animais na pista à noite são um risco específico porque:',
     '["Surgem da vegetação lateral fora do feixe do farol, e a frenagem brusca ou o desvio costumam causar acidente pior que a colisão", "São facilmente vistos pelo brilho dos olhos, a tempo de frear", "Sempre atravessam em grupo", "Só aparecem em rodovias sem asfalto"]', 0, 65),

    ('Pedestres e ciclistas sem material refletivo em via mal iluminada exigem que o motorista:',
     '["Confie no farol baixo, que os revela a tempo", "Buzine ao se aproximar de qualquer vulto", "Reduza a velocidade, amplie a varredura das bordas e considere que só vai enxergar quando já estiver perto", "Mantenha a velocidade e observe o acostamento"]', 2, 66),

    ('Por que a chuva à noite apaga as referências da pista, como faixas e bordas?',
     '["Porque a tinta das faixas absorve água e escurece", "Porque o farol perde potência com a umidade", "Porque o asfalto molhado espelha a luz em vez de refletir de volta, e a água no para-brisa espalha o brilho, fazendo o contorno da pista sumir", "Porque a chuva altera a percepção de cores apenas"]', 2, 67),

    ('Usar farol alto em neblina densa é errado porque:',
     '["Consome mais energia da bateria", "A luz reflete nas gotículas suspensas e volta para os olhos do motorista, criando uma parede branca que reduz ainda mais a visão", "Ofusca apenas quem vem em sentido contrário", "Aquece o conjunto óptico"]', 1, 68),

    ('Faixas pintadas, tampas metálicas e trilhos molhados exigem atenção porque:',
     '["Enferrujam com a chuva", "Aquecem mais que o asfalto", "Têm aderência bem menor que o asfalto molhado, e frear ou acelerar sobre eles em curva provoca perda de controle", "Só são escorregadios com óleo"]', 2, 69),

    ('Uma rajada de vento lateral ao sair de um corte de morro ou de um túnel exige do motorista:',
     '["Manter as mãos firmes no volante, reduzir antes e antecipar a correção, evitando movimento brusco quando o vento pegar", "Soltar o volante para o veículo se acomodar", "Acelerar para vencer o trecho", "Frear com força no momento da rajada"]', 0, 70),

    ('Diante de granizo durante a condução, o correto é:',
     '["Acelerar para sair da área de granizo", "Reduzir e buscar abrigo ou local seguro fora do fluxo, aguardando a passagem, porque o granizo destrói a visibilidade e danifica o para-brisa", "Parar imediatamente na faixa e ligar o pisca-alerta", "Seguir com o farol alto ligado"]', 1, 71),

    ('Um trecho da via está alagado e não é possível ver o fundo. O correto é:',
     '["Atravessar rápido para não morrer o motor", "Atravessar em marcha reduzida com aceleração constante", "Não atravessar: pode haver buraco, tampa de bueiro aberta e correnteza suficiente para arrastar o veículo", "Seguir a trilha de outro veículo que passou antes"]', 2, 72),

    ('Água corrente cruzando a pista, mesmo com pouca altura, é perigosa porque:',
     '["Molha os freios apenas", "Empurra o veículo lateralmente e pode arrastá-lo, e a força da correnteza é muito maior do que aparenta", "Danifica a pintura", "Só é problema para veículos leves"]', 1, 73),

    ('Em serra, depois de chuva forte, o risco adicional é:',
     '["Somente a neblina", "Somente o desgaste do freio", "Somente o congestionamento", "Queda de barreira e material sobre a pista, o que exige velocidade menor, atenção às encostas e distância que permita parar antes do obstáculo"]', 3, 74),

    ('Ao entrar em um trecho de serra com neblina, a referência mais segura para o motorista é:',
     '["A faixa central da pista", "A linha da borda direita da pista, mantendo velocidade bem reduzida e sem colar no veículo da frente", "O farol alto ligado o tempo todo", "As luzes do veículo da frente, seguindo de perto"]', 1, 75),

    ('Fumaça de queimada cruzando a rodovia exige a mesma conduta da neblina densa, com um agravante:',
     '["Ela pode surgir de repente em um único trecho, com veículos já parados dentro dela, e por isso é preciso reduzir antes de entrar e ligar o pisca-alerta", "A fumaça se dissipa rapidamente", "A fumaça é sempre mais rala que a neblina", "A fumaça não afeta o funcionamento do motor"]', 0, 76),

    ('O sol baixo no horizonte, no começo da manhã e no fim da tarde, é perigoso porque:',
     '["Aquece o painel e distrai", "Interfere apenas na leitura das placas", "Ofusca diretamente e apaga o contraste da pista, escondendo pedestre, moto e a traseira dos veículos parados", "Só afeta quem dirige para o leste"]', 2, 77),

    ('Uma frenagem sobre piso escorregadio, em veículo com sistema antitravamento, deve ser feita:',
     '["Bombeando o pedal repetidamente", "Pisando levemente para não travar", "Puxando o freio de estacionamento junto", "Pisando com firmeza e mantendo a pressão, sem soltar, e usando o volante para contornar o obstáculo enquanto o sistema atua"]', 3, 78),

    ('A traseira do veículo começou a escapar em uma curva molhada. A correção é:',
     '["Tirar o pé do acelerador sem frear bruscamente e esterçar suavemente no sentido da derrapagem, olhando para onde se quer ir", "Acelerar para tracionar", "Soltar o volante e deixar o veículo se acomodar", "Frear com força e segurar o volante reto"]', 0, 79),

    ('Entrar em uma curva molhada rápido demais costuma resultar em:',
     '["Maior aderência pelo peso transferido", "Apenas ruído dos pneus", "Melhor estabilidade na saída", "O veículo seguir em frente apesar do volante esterçado, porque a aderência acabou, o que exige reduzir a velocidade antes da curva"]', 3, 80),

    ('Pneu com sulco no limite e chuva formam uma combinação crítica porque:',
     '["O sulco é o que expulsa a água da área de contato, e sem ele o pneu perde aderência exatamente quando mais precisa", "A frenagem melhora com a água", "O pneu esquenta menos", "O consumo aumenta"]', 0, 81),

    ('Palhetas do limpador ressecadas, que deixam rastros no vidro:',
     '["Só atrapalham em chuva muito forte", "Melhoram com produto de limpeza aplicado no vidro", "Podem ser corrigidas aumentando a velocidade do limpador", "Devem ser trocadas antes do período de chuva, porque o rastro no vidro somado à luz de outro veículo cega o motorista"]', 3, 82),

    ('O para-brisa embaçou rapidamente durante a chuva. O procedimento mais eficaz é:',
     '["Passar pano no vidro enquanto dirige", "Abrir todos os vidros", "Acionar o desembaçador e o ar-condicionado, que retira a umidade do ar, ajustando a temperatura", "Aumentar a velocidade do limpador"]', 2, 83),

    ('Rodar longos trechos em rodovia quente com pressão de pneu abaixo da recomendada:',
     '["Melhora o conforto e a aderência", "É compensado pelo peso da carga", "Só afeta o consumo", "Aumenta a flexão da carcaça e o calor, e é uma das causas comuns de estouro em viagem"]', 3, 84),

    ('A distribuição da carga sobre os eixos importa porque:',
     '["Interfere apenas na fiscalização de peso", "Muda o comportamento do veículo na frenagem e na curva, e o excesso em um eixo compromete direção, freio e estabilidade", "Altera somente o consumo", "Afeta apenas a suspensão traseira"]', 1, 85),

    ('Carga alta e estreita, com centro de gravidade elevado, exige:',
     '["A mesma velocidade das demais cargas em curvas", "Redução acentuada de velocidade em curvas, rotatórias e alças, porque o tombamento acontece bem antes do limite de aderência dos pneus", "Apenas amarração reforçada", "Velocidade normal em rotatórias e alças de acesso"]', 1, 86),

    ('Transportar líquido em tanque parcialmente cheio é mais crítico porque:',
     '["O peso total é maior", "O líquido se movimenta dentro do tanque e empurra o veículo na frenagem e na curva, deslocando o centro de gravidade", "O líquido evapora e aumenta a pressão", "A carga fica mais leve na traseira"]', 1, 87),

    ('Sobre o número e o tipo de dispositivos de amarração da carga:',
     '["Uma cinta bem apertada é suficiente para qualquer carga", "A quantidade e o tipo devem ser compatíveis com o peso, o formato e o atrito da carga, seguindo a orientação técnica, e não com o que estiver à mão", "Corda de nylon comum substitui a cinta com catraca", "O tipo de amarração depende da distância a percorrer"]', 1, 88),

    ('Cintas de amarração passando sobre quinas vivas da carga exigem:',
     '["Apenas mais tensão na catraca", "Substituição da cinta por corrente sempre", "Proteção de quina, porque a aresta corta a cinta em movimento e a amarração se rompe sem aviso", "Nada, porque a cinta é resistente"]', 2, 89),

    ('Carga solta em carroceria aberta, mesmo leve, é problema porque:',
     '["Pode ser lançada na pista e atingir outro veículo, além de configurar irregularidade e responsabilidade do transportador", "Prejudica apenas a aerodinâmica", "Só é problema em rodovia de pista dupla", "Aumenta o consumo de combustível"]', 0, 90),

    ('Circular acima do peso permitido, além da autuação, provoca:',
     '["Somente desgaste de pneus", "Aumento da distância de frenagem, sobrecarga de freios em descidas e comprometimento da direção e da suspensão", "Somente aumento do consumo", "Somente danos ao pavimento"]', 1, 91),

    ('Descarregar em cliente, com o veículo em declive no pátio, exige:',
     '["Manter o motor ligado para a operação ser rápida", "Confiar no freio de estacionamento", "Freio de estacionamento acionado, marcha engatada, calços nas rodas e chave sob controle do motorista", "Apenas manter o pisca-alerta ligado"]', 2, 92),

    ('Antes de bascular ou erguer a carroceria em um pátio, o motorista deve verificar:',
     '["A existência de rede elétrica, estrutura ou cobertura acima, além do nivelamento do solo, porque o contato com a rede é fatal", "Apenas o nível do óleo hidráulico", "Apenas o peso da carga", "Apenas se há pessoas atrás do veículo"]', 0, 93),

    ('Ao se aproximar de um viaduto, marquise ou portão com altura limitada, o motorista deve:',
     '["Conhecer a altura total do veículo carregado e respeitar a sinalização de gabarito, buscando rota alternativa quando necessário", "Passar devagar observando pelo espelho", "Confiar na experiência de já ter passado antes", "Reduzir a pressão dos pneus para baixar o veículo"]', 0, 94),

    ('Ao manobrar um veículo longo para entrar em uma doca ou portão, o cuidado com a traseira é necessário porque:',
     '["A traseira segue exatamente a trajetória da cabine", "A traseira sobe ao esterçar", "A traseira descreve trajetória diferente da cabine e projeta-se para fora da curva, atingindo pessoas, postes e outros veículos", "A traseira fica mais leve na manobra"]', 2, 95),

    ('Carga que obstrui o retrovisor ou a visão traseira exige:',
     '["Apenas mais atenção do motorista", "Reduzir a velocidade para compensar", "Circular apenas com o pisca-alerta ligado", "Reposicionar a carga, ajustar o carregamento ou providenciar espelho e apoio adequados antes de sair"]', 3, 96),

    ('Depois de uma frenagem brusca ou de um trecho muito irregular, a amarração da carga deve ser:',
     '["Mantida como está até o destino", "Verificada apenas se houver ruído na carroceria", "Reapertada com o veículo em movimento pelo ajudante", "Reinspecionada em parada segura, porque o esforço pode ter afrouxado cintas e deslocado a carga"]', 3, 97),

    ('Um ajudante precisa subir na carroceria para acertar a carga. O correto é:',
     '["Subir pelo pneu, que é mais rápido", "Subir com o veículo ainda em manobra, para ganhar tempo", "Subir sem qualquer proteção, se a carroceria for baixa", "Veículo parado, freado e calçado, acesso seguro e as medidas de proteção contra queda definidas pela empresa"]', 3, 98),

    ('Transportar produto perigoso exige do motorista, além da habilitação:',
     '["Apenas o conhecimento do trajeto", "Apenas o extintor de maior capacidade", "Curso específico, documentação do produto, ficha de emergência acessível e a sinalização de risco correta no veículo", "Apenas autorização do embarcador"]', 2, 99),

    ('A ficha de emergência que acompanha o produto perigoso serve para:',
     '["Comprovar o valor da carga para o seguro", "Registrar a temperatura de transporte", "Substituir a nota fiscal em fiscalização", "Informar a quem atende a ocorrência o produto envolvido, os riscos e as medidas imediatas, antes de qualquer aproximação"]', 3, 100),

    ('Ao estacionar veículo carregado com produto perigoso, o motorista deve:',
     '["Usar somente os locais autorizados e adequados, respeitando as restrições de estacionamento previstas para esse transporte", "Estacionar próximo a áreas residenciais, para haver socorro perto", "Estacionar em qualquer pátio de posto", "Estacionar no acostamento da rodovia, com pisca-alerta"]', 0, 101),

    ('Um hábito perigoso que deu certo muitas vezes tende a se consolidar. Esse fenômeno significa que:',
     '["O hábito é seguro porque nunca causou acidente", "O motorista precisa apenas de mais atenção", "A ausência de consequência convence o motorista de que o risco não existe, até o dia em que todas as condições se somam", "O procedimento formal está errado"]', 2, 102),

    ('Usar o celular em viva-voz durante uma manobra em pátio ou em um cruzamento complexo:',
     '["É permitido, porque as mãos estão livres", "É indiferente, porque a manobra é lenta", "É aceitável se a conversa for de trabalho", "Continua ocupando a atenção justamente no momento que exige toda a capacidade de observação, e a conversa deve ser encerrada antes"]', 3, 103),

    ('Acelerar e buzinar para pressionar quem está à frente:',
     '["Aumenta o risco para todos, provoca reação em cadeia e elimina o espaço de manobra que a direção defensiva depende", "É aceitável quando o outro está muito devagar", "Só é problema se houver reação do outro condutor", "É uma forma de comunicação no trânsito"]', 0, 104),

    ('Sobre a velocidade acima do limite na condução profissional, o entendimento correto é:',
     '["É consequência inevitável do prazo de entrega", "É compensada pela experiência do motorista", "É segura quando a pista está livre e seca", "É uma escolha do condutor, que amplia a distância de parada, reduz o tempo de decisão e agrava a energia do impacto"]', 3, 105),

    ('A autoavaliação honesta do próprio estado antes de assumir o volante inclui:',
     '["Verificar apenas se está com dor", "Confiar na sensação de estar bem", "Considerar sono, alimentação, medicamentos, preocupações e desgaste dos dias anteriores, e comunicar quando algo comprometer a condução", "Consultar apenas o horário disponível para a rota"]', 2, 106),

    ('Você percebeu que um colega dirige de forma agressiva com o veículo da empresa. A conduta correta é:',
     '["Ignorar, porque não é sua responsabilidade", "Conversar com ele e comunicar a situação pelos canais da empresa, porque o comportamento coloca em risco terceiros e a própria equipe", "Comentar com os outros colegas", "Registrar em vídeo e divulgar"]', 1, 107),

    ('Sistemas de telemetria que registram frenagem, velocidade e aceleração são úteis quando:',
     '["Servem apenas para punir o motorista", "Substituem o treinamento periódico", "Registram somente as infrações de trânsito", "São usados como retorno objetivo sobre a condução, permitindo corrigir hábitos antes que virem acidente"]', 3, 108),

    ('Um programa de premiação por entrega rápida pode se tornar um risco porque:',
     '["Aumenta o custo com combustível", "Reduz o interesse pelo treinamento", "Estimula o motorista a comprimir paradas, exceder velocidade e dirigir cansado para alcançar a meta", "Provoca disputa entre setores"]', 2, 109),

    ('Depois da batida, uma pessoa envolvida quer se levantar e sair andando dizendo que está bem. O correto é:',
     '["Deixar que ela caminhe, já que está consciente", "Orientar que permaneça no lugar, protegida do fluxo, e aguarde a avaliação, porque lesão interna e efeito da adrenalina escondem a gravidade nos primeiros minutos", "Pedir que ela ajude a sinalizar a via", "Levá-la de carro até o hospital mais próximo"]', 1, 110),

    ('A sinalização do local do acidente em uma curva ou em uma subida deve ser feita:',
     '["Na mesma distância usada em pista reta", "Colada ao veículo acidentado", "Bem antes do ponto, onde o condutor que se aproxima consiga enxergar a tempo, considerando que a curva esconde a cena até o último instante", "Somente com o pisca-alerta do veículo"]', 2, 111),

    ('Ainda no local do acidente, quanto aos veículos envolvidos, o correto é:',
     '["Manter os motores ligados para não descarregar a bateria", "Desligar os motores e, quando possível e seguro, cortar a alimentação elétrica, reduzindo o risco de incêndio", "Ligar o ar-condicionado para as vítimas", "Empurrar os veículos imediatamente para fora da pista"]', 1, 112),

    ('Após o impacto, o airbag disparou e há pó e fumaça branca dentro do veículo. Isso significa que:',
     '["É o resíduo normal do acionamento do airbag, e a conduta é ventilar, evitar esfregar os olhos e verificar as pessoas, sem confundir com incêndio", "O veículo está pegando fogo e é preciso correr", "O sistema elétrico entrou em curto", "O extintor foi acionado automaticamente"]', 0, 113),

    ('Ao contar as vítimas de um acidente, é preciso lembrar que:',
     '["O número corresponde sempre aos ocupantes visíveis", "Somente quem pede ajuda precisa de atendimento", "Só é preciso considerar quem está dentro dos veículos", "Pode haver vítimas ejetadas ou que se afastaram em estado de choque, e a área ao redor precisa ser verificada"]', 3, 114),

    ('A primeira avaliação de uma vítima consiste em:',
     '["Procurar fraturas e ferimentos externos", "Verificar se responde ao chamado e se está respirando, e acionar o socorro informando essa condição", "Medir a pressão arterial", "Perguntar sobre alergias e medicamentos"]', 1, 115),

    ('Diante de um motociclista acidentado, quanto ao capacete:',
     '["Deve ser retirado imediatamente para facilitar a respiração", "Não deve ser retirado por quem não é treinado, exceto em risco imediato de morte, porque a manobra pode agravar lesão na coluna cervical", "Deve ser retirado para identificar a vítima", "Deve ser afrouxado e girado para o lado"]', 1, 116),

    ('Há várias pessoas atingidas e poucas mãos para ajudar. A prioridade de atenção recai sobre:',
     '["Quem grita e chama mais alto por socorro", "Quem está caído em silêncio, sem responder, e quem apresenta sangramento intenso, porque quem grita ao menos está respirando", "Quem tem os ferimentos mais visíveis", "Quem estava dirigindo o veículo"]', 1, 117),

    ('Diante de uma hemorragia abundante em uma vítima consciente, a conduta é:',
     '["Aplicar torniquete como primeira medida", "Lavar o ferimento com água corrente", "Aguardar o socorro sem intervir", "Fazer compressão direta sobre o ferimento com pano limpo, mantendo a pressão e acionando o socorro"]', 3, 118),

    ('Uma pessoa envolvida no acidente começa a tremer, fica pálida, com pele fria e respiração acelerada. Isso sugere:',
     '["Apenas nervosismo, que passa sozinho", "Reação ao frio do ambiente", "Sinais de choque, quadro grave que exige manter a pessoa em repouso, protegida da perda de calor, com observação contínua da respiração até o socorro chegar", "Efeito do susto sem consequência clínica"]', 2, 119),

    ('Diante de uma fratura exposta, a conduta é:',
     '["Recolocar o osso na posição original", "Não tentar recolocar nada, cobrir com pano limpo, imobilizar sem tracionar e aguardar o socorro", "Lavar a ferida com álcool", "Amarrar firmemente acima e abaixo do ferimento"]', 1, 120),

    ('Em uma queimadura provocada por combustível ou por incêndio no veículo:',
     '["Retirar a roupa que estiver aderida à pele", "Interromper a exposição, resfriar com água em temperatura ambiente, cobrir com pano limpo e não aplicar produto algum sobre a lesão", "Aplicar pomada ou óleo para aliviar a dor", "Estourar as bolhas antes de cobrir"]', 1, 121),

    ('Em uma ocorrência envolvendo produto perigoso, a equipe de emergência identifica o produto, à distância, por meio:',
     '["Do nome comercial impresso na embalagem, lido de perto", "Da nota fiscal que está com o motorista", "Dos números do painel de segurança e do rótulo de risco fixados no veículo, que dizem o produto e o tipo de perigo antes de qualquer aproximação", "Da cor da lona que cobre a carga"]', 2, 122),

    ('Depois de acionar o socorro público, o motorista da empresa também deve:',
     '["Aguardar o fim do atendimento para comunicar a empresa", "Comunicar somente no relatório do fim do dia", "Comunicar apenas se houver dano ao veículo", "Comunicar a empresa imediatamente, conforme o procedimento interno, para acionar apoio, seguro e as providências devidas"]', 3, 123),

    ('Em acidente com vítima fatal, quanto à preservação do local:',
     '["Os veículos devem ser removidos para liberar a pista o quanto antes", "O local deve ser preservado como está, sinalizado e isolado, até a liberação pela autoridade, salvo quando houver risco iminente que obrigue a intervir", "Os objetos devem ser recolhidos para não se perderem", "As vítimas devem ser cobertas e transportadas"]', 1, 124),

    ('Registrar fotos e anotar dados de testemunhas após um acidente serve para:',
     '["Documentar a cena, apoiar a investigação e a análise das causas e evitar que a versão dos fatos se perca", "Substituir o boletim de ocorrência", "Alimentar as redes sociais da empresa", "Provar a inocência do motorista"]', 0, 125),

    ('Um acidente de trânsito ocorrido durante a jornada de trabalho:',
     '["Não é acidente do trabalho, por ter ocorrido na via pública", "Só é acidente do trabalho se houver afastamento", "É acidente do trabalho e deve ser comunicado e registrado pela empresa, além das providências de trânsito", "Só é acidente do trabalho se ocorrer dentro do pátio da empresa"]', 2, 126),

    ('Discutir culpa com o outro condutor no local do acidente:',
     '["Ajuda a esclarecer os fatos", "Não é papel do motorista: a conduta é prestar socorro, sinalizar, identificar-se, registrar e deixar a apuração para quem é responsável por ela", "É necessário para o seguro", "É recomendável quando há testemunhas"]', 1, 127),

    ('Recusar-se ao teste de alcoolemia após um acidente:',
     '["Tem consequências previstas em lei, e a recusa é tratada de forma equivalente à constatação em termos de penalidade administrativa", "É recomendável enquanto não houver advogado", "Não altera a situação do condutor", "É um direito sem consequências"]', 0, 128),

    ('Um motorista se envolveu em acidente grave e retorna ao trabalho. O tratamento adequado inclui:',
     '["Avaliação de saúde, apoio psicológico quando necessário e retorno gradual, porque a reação ao evento afeta atenção e julgamento", "Retomar a rota imediatamente para superar o episódio", "Trocar o motorista de função definitivamente", "Evitar falar sobre o acidente com ele"]', 0, 129),

    ('A participação do motorista na investigação do acidente é importante porque:',
     '["Ele conhece as condições reais da rota, da carga e da programação, e essa informação é o que permite corrigir a causa", "É exigência da seguradora", "Serve para atribuir a responsabilidade a ele", "Reduz o valor da franquia"]', 0, 130),

    ('Diante de um atropelamento, mesmo com a vítima aparentemente sem ferimentos, o condutor deve:',
     '["Seguir viagem se a vítima disser que está bem", "Deixar seus dados e seguir", "Combinar um encontro posterior com a vítima", "Parar, prestar socorro, acionar atendimento e as autoridades e permanecer no local, porque lesão interna pode não aparecer de imediato"]', 3, 131),

    ('Diante de um princípio de incêndio no veículo, o limite de atuação é:',
     '["Usar o extintor apenas em foco pequeno e acessível, sem abrir o capô totalmente, e abandonar a tentativa e afastar-se assim que o fogo crescer", "Abrir totalmente o capô para atacar o foco", "Combater até esgotar o extintor, em qualquer situação", "Aguardar o socorro sem qualquer ação"]', 0, 132),

    ('Se o veículo cair na água, a orientação para a saída é:',
     '["Aguardar o veículo encher completamente para abrir a porta", "Sair pelo porta-malas", "Tentar abrir a porta com força enquanto o veículo afunda", "Soltar o cinto, abrir ou quebrar a janela lateral logo no início e sair, porque a pressão externa impede a abertura da porta"]', 3, 133),

    ('Após um capotamento, com o veículo parado sobre o teto, o ocupante consciente deve:',
     '["Soltar o cinto imediatamente e cair", "Sair pela porta com um chute rápido", "Permanecer preso ao cinto até o socorro chegar, em qualquer situação", "Apoiar-se com uma das mãos, soltar o cinto controlando a descida, avaliar riscos ao redor e sair por onde for possível, afastando-se do veículo"]', 3, 134),

    ('Uma colisão frontal é iminente e há espaço à direita. A escolha menos danosa costuma ser:',
     '["Frear com firmeza e desviar para a direita, buscando reduzir a energia do impacto e transformar a colisão frontal em algo menos grave", "Desviar para a esquerda, para a faixa do outro veículo", "Acelerar para reduzir a diferença de velocidade", "Frear e manter a trajetória, aguardando o impacto"]', 0, 135),

    ('Você percebe que o veículo de trás vai colidir na sua traseira e não há como se afastar. A medida útil é:',
     '["Frear com força para reduzir o impacto", "Soltar o cinto para amortecer o corpo", "Virar o corpo para trás para observar", "Encostar bem a cabeça no apoio de cabeça, olhar para frente e manter o pé no freio para não ser projetado contra o veículo à frente"]', 3, 136),

    ('Um pneu estourou à noite, em pista simples, e o veículo parou parcialmente na faixa. A prioridade é:',
     '["Trocar o pneu o mais rápido possível", "Sinalizar bem antes, com colete refletivo, e retirar todos de dentro do veículo para fora da pista, atrás da defensa, antes de qualquer outra providência", "Permanecer dentro do veículo com o pisca-alerta ligado", "Empurrar o veículo sozinho para fora da pista"]', 1, 137),

    ('Um congestionamento se formou de repente à sua frente em rodovia de velocidade alta. A conduta é:',
     '["Frear no último instante para não ser atingido", "Parar sobre o acostamento e aguardar", "Reduzir gradualmente, acionar o pisca-alerta cedo para alertar quem vem atrás e parar deixando espaço para manobra", "Mudar para a faixa da esquerda imediatamente"]', 2, 138),

    ('Ao passar por um acidente que já está sendo atendido pelas equipes, a conduta correta é:',
     '["Reduzir bastante e filmar para registrar", "Parar no acostamento para saber se precisam de ajuda", "Seguir em velocidade reduzida e atenção redobrada, sem parar e sem filmar, porque a curiosidade forma fila e provoca o segundo acidente", "Mudar para a faixa da esquerda e acelerar"]', 2, 139),

    ('Depois de um evento grave, a análise conduzida pela empresa deve resultar em:',
     '["Mudanças concretas na rota, na programação, na manutenção ou no treinamento, comunicadas a toda a equipe", "Advertência ao motorista envolvido", "Registro estatístico apenas", "Substituição do veículo envolvido"]', 0, 140),

    ('O motorista quase bateu, se assustou e seguiu viagem. O melhor uso dessa situação é:',
     '["Esquecer o episódio, já que nada aconteceu", "Contar como caso engraçado no fim do dia", "Reduzir a velocidade pelo resto do dia e não comentar", "Parar em local seguro, recuperar-se, entender o que levou àquilo e comunicar, porque o quase-acidente mostra de graça o que o acidente cobraria caro"]', 3, 141),

    ('Reciclar o treinamento periodicamente é necessário mesmo para quem nunca se acidentou porque:',
     '["É exigência do contrato de trabalho", "Procedimentos, veículos e vias mudam, hábitos se desviam com o tempo e a revisão é o que traz a condução de volta ao padrão", "Substitui o exame médico periódico", "Renova a habilitação do condutor"]', 1, 142),

    ('O cliente pede que o veículo entre em um pátio sem espaço de manobra, com pessoas circulando e sem sinalização. O correto é:',
     '["Entrar devagar, porque o cliente conhece o local", "Entrar de ré confiando na orientação de um funcionário do cliente", "Não entrar naquelas condições, comunicar a empresa e negociar outro ponto de carga ou a adequação do local", "Entrar e pedir que todos se afastem durante a manobra"]', 2, 143),

    ('O planejamento correto de uma rota longa considera:',
     '["Distância, tempo real com paradas obrigatórias, horários de maior risco, condições da via e do tempo e pontos seguros para descanso", "Apenas a distância e o combustível", "Apenas o horário de entrega combinado", "Apenas as condições do veículo"]', 0, 144),

    ('Chuva forte durante a noite combina dois fatores críticos, o que exige:',
     '["Reduzir bem a velocidade, ampliar a distância, usar farol baixo e avaliar a parada em local seguro se a visibilidade não permitir enxergar a pista", "Seguir de perto o veículo da frente para usar as luzes dele como referência", "Manter a velocidade da pista seca com farol alto", "Trafegar pelo acostamento, que é mais iluminado"]', 0, 145),

    ('Um motorista cansado, com carga alta, em pista molhada e à noite, está diante de:',
     '["Quatro fatores somados que se multiplicam entre si, e a decisão segura é interromper ou reduzir drasticamente a exposição", "Uma condição normal do trabalho noturno", "Uma situação que o veículo moderno compensa", "Um cenário que exige apenas atenção redobrada"]', 0, 146),

    ('Sobre o uso de tecnologia de assistência ao condutor, como alerta de faixa e frenagem automática:',
     '["Substituem a atenção do motorista", "Permitem dirigir cansado com segurança", "Dispensam a manutenção do sistema de freios", "São recursos de apoio que podem falhar ou não reconhecer a situação, e não transferem a responsabilidade da condução"]', 3, 147),

    ('Ao assumir um veículo que não é o seu de costume, o motorista experiente deve:',
     '["Ajustar banco, espelhos e volante, reconhecer os comandos, a altura, o comprimento e o comportamento de freio e direção antes de entrar no trânsito", "Sair normalmente, porque a condução é a mesma", "Ajustar tudo durante o primeiro trecho da rota", "Pedir que outro condutor faça o primeiro trecho"]', 0, 148),

    ('Comunicar uma condição insegura da rota, como cruzamento perigoso ou pátio de cliente sem sinalização, é importante porque:',
     '["Permite que a empresa negocie mudanças, altere a rota ou o horário e proteja toda a equipe que passa por ali", "Reduz a responsabilidade do motorista em caso de acidente", "Serve como justificativa em caso de atraso", "Cumpre exigência de registro do sistema de gestão"]', 0, 149),

    ('Ao final da reciclagem, o motorista experiente sai com qual entendimento central?',
     '["Que a experiência acumulada compensa o cansaço e as condições adversas", "Que a tecnologia do veículo cobre a maior parte das falhas humanas", "Que a maioria dos acidentes graves é imprevisível", "Que o acidente grave quase sempre é a soma de fatores conhecidos, e que a decisão de interromper, reduzir ou recusar continua sendo dele"]', 3, 150)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'DD-REC';

-- =====================================================================
--  CONFERENCIA FINAL — leia isto depois de rodar
-- =====================================================================

-- 1. Quem administra o treinamento agora.
--    Se vier VAZIO, ninguem consegue subir video: marque o modulo
--    Treinamentos em Usuarios, no SistemaCMH.
select u.usuario, u.nome, u.cargo,
       case when u.admin then 'administrador' else 'modulo marcado' end as porque
  from public.orc_usuarios u
 where u.ativo
   and (u.admin or 'treinamento' = any(u.modulos))
 order by u.admin desc, u.usuario;

-- 2. Curso SEM prova nenhuma. TEM DE VIR VAZIO.
--    O que aparecer aqui e curso que o aluno assiste inteiro e nao
--    consegue concluir.
select c.ordem, c.codigo, c.titulo, 'SEM PROVA' as alerta
  from public.trein_curso c
 where c.ativo
   and not exists (select 1 from public.trein_questao q where q.curso_id = c.id)
 order by c.ordem;

-- 3. O quadro geral: questoes, quantas a prova sorteia, e as aulas.
--    `folga` e quanto o banco tem alem do que a prova usa — quanto maior,
--    menos duas pessoas recebem a mesma prova.
--    A coluna `questoes` tem de vir 150 em todos os 19 cursos.
select c.ordem, c.codigo, c.titulo,
       c.carga_horaria                                    as horas,
       count(distinct q.id)                               as questoes,
       coalesce(c.questoes_por_prova, 10)                 as sorteia,
       count(distinct q.id) - coalesce(c.questoes_por_prova, 10) as folga,
       count(distinct a.id)                               as aulas
  from public.trein_curso c
  left join public.trein_questao q on q.curso_id = c.id
  left join public.trein_aula    a on a.curso_id = c.id
 where c.ativo
 group by c.id
 order by questoes, c.ordem;
