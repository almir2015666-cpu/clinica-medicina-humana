-- =====================================================================
--  As provas dos outros 18 cursos: 10 questoes cada, aprovacao com 70%
--
--  Rode no SQL Editor. Pode rodar mais de uma vez (cada bloco apaga as
--  questoes do seu curso antes de inserir, entao nao duplica).
--
--  ATENÇÃO: ESTAS PERGUNTAS PRECISAM DA CONFERIDA DO RESPONSÁVEL TÉCNICO
--  ANTES DE VALER PARA CERTIFICADO.
--  Foram escritas a partir do conteúdo usual de cada norma e do que se
--  cobra em campo. São coerentes com as normas, mas quem responde pela
--  prova é o responsável técnico — prova errada reprova quem sabe e
--  aprova quem não sabe, e é o certificado dele que está em jogo.
--
--  O NR-20 NÃO ESTÁ AQUI. Ele já tem prova no 10-prova-nr20.sql, e rodar
--  os dois arquivos não se atrapalha: cada um só mexe no curso que é seu.
--
--  O DELETE SÓ APAGA A FAIXA 1-10, que é a que este arquivo escreve.
--  Antes ele apagava TODAS as questões do curso. Como os arquivos 15 a 18
--  acrescentam a faixa 11-40, rodar este depois deles varreria as 570
--  questões novas sem avisar — e a prova voltaria a ser sempre a mesma.
--  Com a faixa, a ordem em que se roda deixa de importar.
----  A COLUNA `correta` É O ÍNDICE, COMEÇANDO EM ZERO
--  Se a resposta certa é a primeira alternativa, `correta` é 0. A posição
--  da resposta certa foi espalhada de propósito pelos quatro índices: aluno
--  que decora padrão de gabarito não aprende norma nenhuma.
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
--  NR-35 — Trabalho em altura
--  Peso maior em ancoragem e resgate. A queda em si costuma ser
--  interrompida pelo cinto; quem morre depois é o trabalhador que ficou
--  pendurado sem ninguém preparado para tirá-lo de lá.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-35-REC')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('A partir de que situação a NR-35 considera que existe trabalho em altura?',
     '["Qualquer serviço feito em cima de uma escada", "Somente serviços acima de 5 metros", "Acima de 2 metros do nível inferior, quando houver risco de queda", "Somente quando se usa andaime ou plataforma"]', 2, 1),

    ('Quem pode executar trabalho em altura na empresa?',
     '["Qualquer empregado, desde que use cinto", "Quem já tem experiência na função, mesmo sem curso", "Quem for indicado pelo encarregado no dia do serviço", "O trabalhador capacitado, autorizado pela empresa e com aptidão no exame médico"]', 3, 2),

    ('Qual cinto de segurança é o exigido para trabalho em altura?',
     '["Cinto tipo abdominal, por ser mais confortável", "Cinto tipo paraquedista, com talabarte e conexões apropriadas", "Qualquer cinto com Certificado de Aprovação", "Cinto de eletricista com cinturão de posicionamento"]', 1, 3),

    ('O que deve ser feito com o cinto e o talabarte antes de cada uso?',
     '["Inspeção visual em busca de cortes, fios soltos, ferrugem e costura rompida", "Nada, se a última inspeção mensal estiver em dia", "Apenas conferir a validade impressa na etiqueta", "Lavar com água e sabão para tirar o excesso de poeira"]', 0, 4),

    ('O que se espera de um ponto de ancoragem?',
     '["Qualquer tubulação ou eletroduto que pareça firme", "O corrimão do andaime, que é feito para isso", "Estrutura que suporte a carga, definida por profissional habilitado e, de preferência, acima da cintura", "Sempre o ponto mais próximo, para o talabarte não incomodar"]', 2, 5),

    ('Para que serve o talabarte com absorvedor de energia?',
     '["Para deixar o trabalhador andar mais longe", "Para prender dois pontos de ancoragem ao mesmo tempo", "Para servir de corda de içamento de ferramenta", "Para reduzir o impacto sobre o corpo no momento em que a queda é freada"]', 3, 6),

    ('Um trabalhador cai e fica suspenso pelo cinto. Qual o principal cuidado?',
     '["Deixar ele pendurado até a chegada do socorro externo", "Resgatar rápido: ficar suspenso parado compromete a circulação e pode matar em poucos minutos", "Balançar a corda para manter o sangue circulando", "Cortar o talabarte para que ele desça mais depressa"]', 1, 7),

    ('Sobre o uso de escada de mão, é correto afirmar:',
     '["Pode ser usada como passarela entre dois pontos", "Dois trabalhadores podem subir juntos se a escada for reforçada", "Deve ultrapassar em cerca de 1 metro o ponto de apoio, ficar amarrada e não se usa os últimos degraus", "Pode ser apoiada em qualquer superfície, desde que outro colega segure embaixo"]', 2, 8),

    ('Quando a Análise de Risco e a Permissão de Trabalho são exigidas em altura?',
     '["Somente em serviços com mais de 10 metros", "Somente quando a fiscalização estiver na empresa", "Nunca, se o trabalhador já fez o curso", "Nas atividades não rotineiras, e sempre que a análise de risco apontar necessidade"]', 3, 9),

    ('O trabalhador acordou com tontura e está tomando remédio que dá sono. O que fazer?',
     '["Subir mesmo assim, tomando mais cuidado", "Informar a chefia e não executar trabalho em altura naquele dia", "Trabalhar só na parte da manhã, que o efeito é menor", "Pedir para um colega ficar olhando de baixo"]', 1, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-35-REC';


-- =====================================================================
--  NR-33 — Espaços confinados
--  Três questões tratam de socorro improvisado. Não é excesso: a maior
--  parte das mortes em espaço confinado é de quem entrou para salvar.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-33')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O que caracteriza um espaço confinado?',
     '["Todo ambiente fechado e sem janela", "Área não projetada para ocupação contínua, com meios limitados de entrada e saída e ventilação insuficiente", "Qualquer local abaixo do nível do solo", "Ambiente onde é preciso usar lanterna para enxergar"]', 1, 1),

    ('O que é obrigatório antes de qualquer entrada em espaço confinado?',
     '["Avisar o encarregado por rádio", "Deixar a tampa aberta por meia hora", "Levar um colega de fora para acompanhar", "Medir a atmosfera (oxigênio, gases inflamáveis e tóxicos) e emitir a Permissão de Entrada e Trabalho"]', 3, 2),

    ('Qual é a faixa de oxigênio considerada segura para a entrada?',
     '["Entre 19,5% e 23%", "Entre 10% e 15%", "Acima de 30%, quanto mais melhor", "Qualquer valor, desde que não tenha cheiro forte"]', 0, 3),

    ('Qual é a função do vigia?',
     '["Entrar junto para ajudar no serviço", "Ficar por perto e conferir o horário de entrada e saída", "Permanecer o tempo todo do lado de fora, controlar quem entra e sai, manter contato e acionar o resgate", "Revezar com o trabalhador autorizado a cada meia hora"]', 2, 4),

    ('O vigia vê o trabalhador desmaiar lá dentro. O que ele faz?',
     '["Entra rápido, prende a respiração e puxa o colega", "Aciona o alarme e a equipe de resgate, e não entra sem equipamento e autorização", "Joga água para tentar reanimar", "Vai buscar ajuda e deixa o local sem vigia"]', 1, 5),

    ('Por que a maioria das mortes em espaço confinado envolve mais de uma vítima?',
     '["Porque os espaços costumam desabar", "Porque os trabalhadores entram sem crachá", "Porque falta iluminação adequada", "Porque colegas entram para socorrer sem equipamento e viram a segunda vítima"]', 3, 6),

    ('A Permissão de Entrada e Trabalho (PET) vale para quanto tempo?',
     '["Para a entrada e o turno a que se refere, assinada pelo supervisor, e é cancelada se as condições mudarem", "Para o mês inteiro, se o serviço for o mesmo", "Para a obra toda, enquanto durar o contrato", "Não tem prazo: vale até alguém rasgar"]', 0, 7),

    ('Sobre a ventilação do espaço confinado durante o serviço:',
     '["Basta ventilar antes de entrar", "Só é necessária se houver cheiro de gás", "A ventilação forçada deve ser mantida durante todo o trabalho e a atmosfera monitorada", "Deve ser desligada durante o serviço para não atrapalhar a comunicação"]', 2, 8),

    ('Em espaço confinado com deficiência de oxigênio, a proteção respiratória correta é:',
     '["Respirador PFF2 bem ajustado", "Equipamento com suprimento de ar (autônomo ou linha de ar), porque filtro não fabrica oxigênio", "Máscara com filtro para vapores orgânicos", "Pano úmido sobre o nariz e a boca"]', 1, 9),

    ('Quem pode assumir a função de supervisor de entrada?',
     '["O trabalhador mais antigo da equipe", "Qualquer encarregado da área", "O vigia, quando o serviço é rápido", "Trabalhador capacitado como supervisor, responsável por avaliar as condições e assinar a PET"]', 3, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-33';


-- =====================================================================
--  NR-10 — Segurança em eletricidade (básico)
--  A prova insiste na ordem das etapas de desenergização. É onde o
--  acidente fatal acontece: quase sempre alguém pulou a constatação de
--  ausência de tensão porque "tinha certeza" de que estava desligado.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-10')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Qual é a primeira medida de controle do risco elétrico?',
     '["Desenergizar a instalação e trabalhar sem tensão", "Usar luva isolante de boa qualidade", "Trabalhar sempre acompanhado", "Colocar tapete de borracha no piso"]', 0, 1),

    ('Qual é a sequência correta da desenergização?',
     '["Aterrar, seccionar, testar e depois sinalizar", "Sinalizar, seccionar e começar o serviço", "Seccionar, impedir a reenergização, constatar a ausência de tensão, aterrar, proteger os elementos energizados e sinalizar", "Desligar o disjuntor geral e avisar a equipe por rádio"]', 2, 2),

    ('Quando um circuito pode ser considerado desenergizado?',
     '["Quando o disjuntor está desligado", "Quando a ausência de tensão foi constatada com instrumento e o aterramento temporário foi instalado", "Quando a lâmpada da sala apagou", "Quando o eletricista responsável avisou que desligou"]', 1, 3),

    ('Como se usa corretamente o detector de tensão?',
     '["Basta encostar no condutor e observar", "Testar uma vez por semana já é suficiente", "Confiar na luz de teste da própria ferramenta", "Testar o aparelho em circuito energizado conhecido antes e depois de medir"]', 3, 4),

    ('Quem pode intervir em instalações elétricas?',
     '["Qualquer trabalhador com luva isolante", "Trabalhador qualificado, habilitado ou capacitado, e autorizado pela empresa", "O encarregado da obra, por ser o responsável", "Quem tiver a ferramenta certa na mão"]', 1, 5),

    ('Um colega está em contato com um cabo energizado. Qual a primeira atitude?',
     '["Puxar pelo braço para tirar do cabo", "Jogar água para resfriar o local", "Desligar a energia ou afastar o cabo com material isolante, sem tocar na vítima", "Chamar o socorro e esperar do lado de fora"]', 2, 6),

    ('Por que roupa sintética é proibida em atividade com risco de arco elétrico?',
     '["Porque derrete e gruda na pele, agravando a queimadura", "Porque conduz eletricidade melhor que o algodão", "Porque suja mais rápido", "Porque não permite colocar o crachá"]', 0, 7),

    ('O que fazer com anel, relógio, corrente e pulseira antes do serviço elétrico?',
     '["Podem ficar, se forem de material fino", "Basta cobrir com fita isolante", "Guardar no bolso da calça", "Retirar todos: são condutores e podem causar choque e queimadura grave"]', 3, 8),

    ('Para que serve o aterramento temporário?',
     '["Para melhorar a leitura dos instrumentos", "Para descarregar a bateria das ferramentas", "Para escoar energia residual e proteger a equipe caso o circuito seja reenergizado por engano", "Para diminuir o consumo enquanto o serviço acontece"]', 2, 9),

    ('Quem retira o bloqueio e a etiqueta colocados no disjuntor?',
     '["O eletricista que chegar primeiro no dia seguinte", "A mesma pessoa que colocou, depois de conferir que a equipe e as ferramentas saíram", "O encarregado, sempre que o serviço atrasar", "Qualquer um da equipe, se o serviço acabou"]', 1, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-10';


-- =====================================================================
--  NR-10-SEP — Complementar Sistema Elétrico de Potência
--  Aqui as perguntas assumem que o aluno já passou pelo básico. O foco é
--  o que é diferente na rede: tensão de retorno, indução, distância de
--  aproximação e a impossibilidade de simplesmente desligar tudo.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-10-SEP')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O que é o Sistema Elétrico de Potência (SEP)?',
     '["Toda instalação elétrica acima de 220 volts", "O conjunto de instalações de geração, transmissão e distribuição de energia elétrica", "O quadro geral de força das indústrias", "O sistema de energia de emergência dos hospitais"]', 1, 1),

    ('Qual é o pré-requisito para fazer o curso complementar SEP?',
     '["Ter concluído o curso básico da NR-10", "Ter mais de dois anos de empresa", "Ser eletricista formado em curso técnico", "Ter feito o NR-35 antes"]', 0, 2),

    ('Sobre trabalhar dentro da zona controlada de uma instalação energizada:',
     '["Pode, desde que o trabalhador use luva isolante", "Pode, se for serviço rápido", "Pode, se houver outro colega olhando", "Só com trabalhador autorizado, procedimento específico e as medidas de controle previstas"]', 3, 3),

    ('Quando se admite intervenção em instalação energizada no SEP?',
     '["Sempre que der mais trabalho desligar", "Quando o cliente reclamar da falta de energia", "Quando o desligamento comprometer a segurança ou a continuidade do serviço, com procedimento e autorização", "Nunca, em nenhuma hipótese"]', 2, 4),

    ('Uma rede desligada pode estar energizada por qual motivo?',
     '["Só por erro de manobra do centro de operação", "Por tensão induzida de circuitos vizinhos ou por retorno de gerador do consumidor", "Por acúmulo de umidade nos cabos", "Por descarga da bateria do transformador"]', 1, 5),

    ('O que deve ser feito antes de subir em um poste?',
     '["Inspecionar o poste: estado da base, trincas, inclinação e firmeza", "Testar o cinto de segurança no chão", "Conferir o número de patrimônio do poste", "Verificar se há trânsito na rua"]', 0, 6),

    ('Sobre trabalhar sozinho em serviço no SEP:',
     '["Pode, se o serviço for de baixa tensão", "Pode, se o trabalhador for experiente", "Pode, desde que avise por rádio a cada 30 minutos", "Não: o serviço é em equipe, com comunicação definida e alguém apto a socorrer"]', 3, 7),

    ('Antes de qualquer manobra na rede, o correto é:',
     '["Executar e depois registrar no relatório do dia", "Pedir autorização ao morador mais próximo", "Comunicar e obter liberação do centro de operação, seguindo a sequência prevista", "Avisar apenas o encarregado da equipe"]', 2, 8),

    ('Começou tempestade com descargas atmosféricas durante o serviço na rede. O que fazer?',
     '["Interromper a atividade e descer, aguardando condições seguras", "Continuar, porque o cinto é isolante", "Acelerar para terminar antes da chuva apertar", "Continuar somente os serviços em baixa tensão"]', 0, 9),

    ('Sobre as coberturas e mantas isolantes usadas na rede:',
     '["Servem também para proteger da chuva", "Podem ser improvisadas com lona plástica", "Precisam estar dentro da validade de ensaio, limpas, secas e inspecionadas antes do uso", "Só são exigidas em alta tensão"]', 2, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-10-SEP';


-- =====================================================================
--  NR-11 — Operação de empilhadeira
--  Nenhuma pergunta sobre modelo ou marca de equipamento: o que reprova
--  operador na prática é estabilidade da carga, rampa e pedestre.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-11')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Quem pode operar uma empilhadeira?',
     '["Qualquer funcionário com carteira de motorista", "Trabalhador treinado, considerado apto e autorizado por escrito pela empresa", "O ajudante, quando o operador está no almoço", "Quem for indicado pelo líder no dia"]', 1, 1),

    ('O que se faz antes de iniciar o turno com a empilhadeira?',
     '["A checagem diária: freios, direção, buzina, luzes, garfos, vazamentos e nível de carga ou combustível", "Apenas ligar e ver se o motor pega", "Lavar o equipamento", "Conferir a carga que será movimentada"]', 0, 2),

    ('Durante o deslocamento, como devem ficar os garfos?',
     '["Na altura do peito, para enxergar melhor a carga", "Encostados no chão, para não bater em nada", "Baixos, cerca de 15 a 20 cm do piso, e com a torre inclinada para trás", "Na altura em que a carga foi retirada da prateleira"]', 2, 3),

    ('Como se sobe e se desce uma rampa com carga?',
     '["Sempre de frente, subindo e descendo", "Sempre de ré, subindo e descendo", "De ré na subida e de frente na descida", "De frente na subida e de ré na descida, com a carga voltada para a parte alta"]', 3, 4),

    ('Pode transportar pessoa nos garfos da empilhadeira?',
     '["Pode, se a distância for curta", "Não: só com plataforma apropriada, fixada e prevista para essa finalidade", "Pode, se a pessoa se segurar na torre", "Pode, se o operador for devagar"]', 1, 5),

    ('O que a placa de capacidade da empilhadeira informa?',
     '["A carga máxima em função da altura de elevação e do centro de carga", "O peso do próprio equipamento", "O limite de velocidade permitido", "A quantidade de horas até a próxima manutenção"]', 0, 6),

    ('Ao estacionar a empilhadeira, o correto é:',
     '["Deixar os garfos elevados para não sujar", "Deixar ligada, se for voltar logo", "Deixar em rampa com a carga apoiada", "Baixar os garfos até o chão, acionar o freio de estacionamento, desligar e retirar a chave"]', 3, 7),

    ('A carga é alta e tapa a visão do operador. O que fazer?',
     '["Elevar mais a carga para enxergar por baixo", "Pedir para alguém ir na frente puxando", "Trafegar de ré, com atenção redobrada, ou usar um sinaleiro para orientar", "Inclinar a torre para frente e olhar pelo lado"]', 2, 8),

    ('Em caso de tombamento da empilhadeira, o operador deve:',
     '["Pular para o lado oposto ao tombamento", "Permanecer no assento, com o cinto afivelado, segurar firme e inclinar-se para o lado contrário", "Soltar o cinto e sair correndo", "Desligar o motor e depois sair pela porta"]', 1, 9),

    ('Sobre a circulação em áreas com pedestres:',
     '["O pedestre é que deve desviar do equipamento", "Basta ligar a luz de advertência e seguir", "Reduzir a velocidade, buzinar nos cruzamentos e nas saídas, e dar preferência ao pedestre", "Buzinar continuamente para avisar de longe"]', 2, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-11';


-- =====================================================================
--  NR-12 — Máquinas e equipamentos
--  Duas questões separam parada de emergência de bloqueio de energia.
--  Confundir as duas é o motivo mais comum de amputação em manutenção:
--  o botão vermelho para a máquina, não a desliga.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-12')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Uma proteção fixa foi retirada para a manutenção. O que precisa acontecer?',
     '["Pode ficar sem, se a máquina for operada devagar", "Pode ficar sem até a próxima parada programada", "Basta sinalizar a área com fita zebrada", "A proteção precisa ser recolocada antes de a máquina voltar a operar"]', 3, 1),

    ('Sobre o botão de parada de emergência:',
     '["Serve para desligar a máquina no fim do expediente", "Interrompe o movimento em situação de risco, e o religamento exige rearme manual e voluntário", "Corta toda a energia da máquina, inclusive a residual", "Pode ser substituído por uma chave geral comum"]', 1, 2),

    ('Para que serve o dispositivo de intertravamento da porta de proteção?',
     '["Para interromper o funcionamento assim que a proteção é aberta e impedir a partida com ela aberta", "Para trancar a porta com chave e evitar furto de peças", "Para avisar o operador com um sinal sonoro", "Para registrar quantas vezes a máquina foi aberta"]', 0, 3),

    ('Limpeza, ajuste ou desatolamento de máquina deve ser feito:',
     '["Com a máquina em velocidade reduzida", "Com a máquina em modo automático", "Com a máquina parada, bloqueada e com as energias dissipadas", "Com a máquina ligada, usando uma haste comprida"]', 2, 4),

    ('Por que existe o comando bimanual em algumas prensas?',
     '["Para dividir a responsabilidade entre dois operadores", "Para garantir que as duas mãos do operador estejam fora da zona de prensagem durante o ciclo", "Para acelerar o ciclo da máquina", "Para permitir que o operador trabalhe sentado"]', 1, 5),

    ('Por que não se usa luva perto de partes rotativas, como tornos e furadeiras?',
     '["Porque a luva atrapalha a sensibilidade das mãos", "Porque a luva suja a peça usinada", "Porque a luva esquenta demais", "Porque a luva pode ser agarrada pela peça em rotação e arrastar a mão"]', 3, 6),

    ('A máquina começa a fazer barulho estranho e a esquentar. O que fazer?',
     '["Parar a máquina e comunicar a manutenção e a chefia", "Reduzir a velocidade e terminar o lote", "Jogar mais lubrificante e continuar", "Anotar no relatório e deixar para o próximo turno"]', 0, 7),

    ('Quem pode operar máquinas e equipamentos com risco?',
     '["Qualquer trabalhador do setor", "Quem tiver mais tempo de casa", "Trabalhador capacitado para aquela máquina e autorizado pela empresa", "O aprendiz, desde que acompanhado à distância"]', 2, 8),

    ('Um colega colocou um pedaço de fita no sensor de segurança para a máquina não parar. Isso é:',
     '["Aceitável quando a produção está atrasada", "Proibido: burlar dispositivo de segurança é falta grave e coloca vidas em risco", "Permitido se o supervisor autorizar verbalmente", "Permitido enquanto a peça de reposição não chega"]', 1, 9),

    ('Sobre os procedimentos de trabalho e o manual da máquina:',
     '["Ficam guardados no escritório da engenharia", "São exigidos apenas para máquinas novas", "São dispensáveis quando o operador já sabe usar", "Devem estar disponíveis no posto de trabalho, em linguagem que o operador entenda"]', 3, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-12';


-- =====================================================================
--  NR-05 — CIPA
--  Inclui a parte de prevenção ao assédio, que entrou na norma e ainda é
--  o que mais gera dúvida em turma de cipeiro novo.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-05')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Qual é a finalidade da CIPA?',
     '["Fiscalizar o cumprimento das metas de produção", "Substituir o SESMT nas empresas menores", "Prevenir acidentes e doenças do trabalho e atuar na prevenção ao assédio e à violência no trabalho", "Julgar e punir quem descumpre as normas de segurança"]', 2, 1),

    ('Como a CIPA é composta?',
     '["Por representantes indicados pelo empregador e por representantes eleitos pelos empregados", "Somente por trabalhadores eleitos em votação secreta", "Pelos integrantes do SESMT da empresa", "Pelos encarregados de cada setor, por indicação da chefia"]', 0, 2),

    ('Qual é a duração do mandato do cipeiro?',
     '["Seis meses, sem direito a recondução", "Um ano, permitida uma reeleição", "Dois anos, com reeleições ilimitadas", "Enquanto durar o contrato de trabalho"]', 1, 3),

    ('O que é a estabilidade do cipeiro eleito?',
     '["Ele não pode ser transferido de setor", "Ele não pode ser demitido nunca mais", "Ele passa a ter salário garantido por dois anos", "Ele não pode ser dispensado sem justa causa desde o registro da candidatura até um ano após o fim do mandato"]', 3, 4),

    ('Como devem acontecer as reuniões ordinárias da CIPA?',
     '["Mensalmente, em horário normal de trabalho, com ata registrada", "Trimestralmente, fora do expediente", "Somente quando ocorrer um acidente", "Quando o presidente julgar necessário"]', 0, 5),

    ('Para que serve o mapa de riscos elaborado com a participação da CIPA?',
     '["Para mostrar o caminho da saída de emergência", "Para indicar a localização dos extintores", "Para representar os riscos de cada setor e orientar as medidas de prevenção", "Para registrar os acidentes ocorridos no ano"]', 2, 6),

    ('Sobre a presidência e a vice-presidência da CIPA:',
     '["Ambos são eleitos pelos trabalhadores", "O presidente é designado pelo empregador e o vice é escolhido entre os eleitos pelos empregados", "Ambos são indicados pelo SESMT", "O cargo é rotativo a cada reunião"]', 1, 7),

    ('O que é a SIPAT?',
     '["A reunião extraordinária após um acidente grave", "O relatório anual enviado ao sindicato", "O treinamento de admissão dos novos empregados", "A semana interna de prevenção de acidentes, realizada anualmente"]', 3, 8),

    ('Qual é o papel da CIPA quando acontece um acidente?',
     '["Participar da análise das causas e propor medidas para que não se repita", "Definir a punição do trabalhador envolvido", "Emitir a CAT no lugar da empresa", "Decidir se o caso é acidente de trabalho ou não"]', 0, 9),

    ('Entre as medidas de prevenção ao assédio previstas para a CIPA está:',
     '["Investigar a vida pessoal dos envolvidos", "Afastar imediatamente o acusado", "Divulgar os canais de denúncia e as regras de conduta, e promover capacitação sobre o tema", "Publicar a lista de denúncias no mural"]', 2, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-05';


-- =====================================================================
--  NR-06 — Uso de EPI
--  Curso curto, então as questões cobram o que o trabalhador realmente
--  decide sozinho: usar, guardar, conferir e avisar quando estragou.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-06')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O que significa o CA impresso no EPI?',
     '["Código de Aquisição do fornecedor", "Certificado de Aprovação: sem ele, o equipamento não pode ser vendido nem usado como EPI", "Classe de Aplicação do produto", "Controle de Almoxarifado da empresa"]', 1, 1),

    ('De quem é a obrigação de fornecer o EPI ao trabalhador?',
     '["Da empresa, gratuitamente e no tipo adequado ao risco", "Do trabalhador, que escolhe o modelo que preferir", "Do sindicato da categoria", "Do cliente, quando o serviço é em obra de terceiro"]', 0, 2),

    ('Qual das opções é obrigação do trabalhador quanto ao EPI?',
     '["Comprar o equipamento de reposição", "Emprestar o equipamento ao colega que esqueceu o dele", "Devolver o equipamento usado ao fim de cada dia", "Usar apenas para a finalidade prevista, guardar, conservar e avisar quando estiver danificado"]', 3, 3),

    ('O capacete trincou depois de uma queda de ferramenta. O que fazer?',
     '["Continuar usando, porque a trinca é pequena", "Colar a trinca com adesivo apropriado", "Retirar de uso e solicitar a substituição imediata", "Usar somente em áreas sem risco de queda de objeto"]', 2, 4),

    ('Qual é o lugar do EPI na hierarquia das medidas de controle?',
     '["É a primeira medida, por ser a mais barata", "Vem depois das medidas coletivas e administrativas, e é a principal só quando a proteção coletiva não é viável ou está em implantação", "Substitui a proteção coletiva quando o trabalhador prefere", "Tem o mesmo peso das demais medidas"]', 1, 5),

    ('Sobre o uso do protetor auricular em setor ruidoso:',
     '["Pode ser tirado nas pausas curtas dentro do setor", "Pode ser substituído por algodão nos ouvidos", "Só é obrigatório perto das máquinas mais barulhentas", "Deve ser usado durante toda a exposição: tirar por poucos minutos já reduz muito a proteção"]', 3, 6),

    ('Como o EPI deve ser guardado no fim do turno?',
     '["Limpo, seco e no local reservado para ele, longe de calor, sol e produtos químicos", "Dentro do armário junto com estopas e solventes", "No próprio posto de trabalho, para não esquecer", "Dentro do carro, para não perder"]', 0, 7),

    ('Os óculos de proteção estão riscados a ponto de atrapalhar a visão. O correto é:',
     '["Continuar usando, já que ainda protegem contra respingo", "Lixar levemente a lente para tirar os riscos", "Solicitar a troca: lente riscada compromete a visão e gera erro e acidente", "Usar somente em serviços rápidos"]', 2, 8),

    ('O trabalhador se recusa a usar o EPI fornecido pela empresa. Isso é:',
     '["Direito dele, se achar desconfortável", "Descumprimento de obrigação, e pode ser tratado como falta disciplinar", "Aceitável se ele assinar um termo de responsabilidade", "Permitido quando o serviço dura menos de uma hora"]', 1, 9),

    ('Por que barba comprida compromete o respirador tipo PFF2?',
     '["Porque acumula poeira e suja o filtro", "Porque impede a leitura do CA na máscara", "Porque aumenta o esforço para respirar", "Porque impede a vedação da máscara no rosto, e o ar contaminado entra pelas bordas"]', 3, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-06';


-- =====================================================================
--  NR-17 — Ergonomia
--  Duas questões sobre organização do trabalho, e não só sobre postura.
--  Ritmo e meta adoecem tanto quanto levantar peso errado, e é a parte
--  que o aluno costuma nem saber que faz parte da norma.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-17')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Qual é a forma correta de levantar uma carga do chão?',
     '["Curvar a coluna e levantar com as costas", "Levantar com um giro rápido do tronco", "Dobrar os joelhos, manter a coluna reta e a carga junto ao corpo", "Levantar com os braços esticados, longe do corpo"]', 2, 1),

    ('Em trabalho repetitivo, qual medida reduz o risco de lesão?',
     '["Pausas e revezamento de tarefas ao longo da jornada", "Aumentar o ritmo para terminar antes e descansar depois", "Usar munhequeira o tempo todo", "Trocar de mão a cada uma hora"]', 0, 2),

    ('Como deve ficar o monitor em um posto de trabalho com computador?',
     '["Bem abaixo da linha dos olhos, para relaxar o pescoço", "Com o topo da tela na altura dos olhos, a cerca de um braço de distância", "Encostado na parede, o mais longe possível", "Inclinado para cima, para diminuir o reflexo"]', 1, 3),

    ('Uma cadeira adequada para o trabalho sentado permite:',
     '["Girar livremente em qualquer direção", "Reclinar totalmente para descanso", "Ficar sem encosto, para dar liberdade de movimento", "Pés apoiados no chão ou em apoio, joelhos em torno de 90 graus e apoio para a região lombar"]', 3, 4),

    ('Para que serve a avaliação ergonômica do posto de trabalho?',
     '["Para identificar os problemas do posto e propor melhorias concretas", "Para justificar o pagamento de adicional de insalubridade", "Para escolher o modelo de cadeira mais barato", "Para medir a produtividade do trabalhador"]', 0, 5),

    ('O trabalhador sente dor e formigamento no braço há duas semanas. O que fazer?',
     '["Esperar passar, porque é cansaço normal", "Tomar analgésico e continuar", "Comunicar a chefia e procurar o serviço médico o quanto antes", "Trocar de posto por conta própria"]', 2, 6),

    ('Sobre o transporte manual de cargas:',
     '["Cada trabalhador carrega o que aguentar", "Deve-se usar meios mecânicos ou ajuda de outra pessoa sempre que a carga for pesada ou volumosa", "Levantar rápido reduz o esforço na coluna", "Carregar no ombro é sempre mais seguro"]', 1, 7),

    ('Iluminação inadequada no posto de trabalho pode causar:',
     '["Apenas desconforto estético", "Somente aumento da conta de energia", "Apenas dificuldade para ler documentos", "Fadiga visual, dor de cabeça, postura forçada e aumento de erros"]', 3, 8),

    ('O que a ergonomia entende por organização do trabalho?',
     '["Ritmo, metas, jornada, pausas e conteúdo das tarefas, que também adoecem quando mal dimensionados", "Somente a disposição dos móveis na sala", "A escala de férias do setor", "O organograma da empresa"]', 0, 9),

    ('Em trabalho realizado em pé por longos períodos, recomenda-se:',
     '["Manter os dois pés parados e juntos", "Travar os joelhos para cansar menos", "Oferecer assento para pausas e permitir alternância de postura e apoio dos pés", "Usar calçado com solado rígido e fino"]', 2, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-17';


-- =====================================================================
--  NR-18 — Construção civil
--  Escolhi os riscos que respondem pela maioria das mortes em canteiro:
--  queda de altura, choque em instalação provisória, desabamento de
--  escavação e carga suspensa.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-18')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O que a periferia da laje e as aberturas de fachada precisam ter?',
     '["Fita zebrada em toda a extensão", "Guarda-corpo com rodapé, dimensionado para resistir ao impacto de uma pessoa", "Placa de aviso de risco de queda", "Um vigia observando a área"]', 1, 1),

    ('Uma abertura no piso ficou sem proteção depois da concretagem. O que fazer?',
     '["Fechar com tampa fixada e sinalizada, ou proteger com guarda-corpo", "Colocar uma tábua solta em cima", "Marcar com cal para todos verem", "Avisar a equipe no diálogo de segurança do dia seguinte"]', 0, 2),

    ('Sobre o uso de andaime no canteiro:',
     '["Pode subir enquanto está sendo montado, se for rápido", "As tábuas podem ficar soltas, desde que apoiadas nos travessões", "Pode ser deslocado com trabalhador em cima, se todos segurarem firme", "Deve ter piso completo, travado e antiderrapante, ser montado sob supervisão e ficar travado contra deslocamento"]', 3, 3),

    ('Qual é o uso correto da escada de mão?',
     '["Apoiada em qualquer superfície, com um colega segurando embaixo", "Amarrada e usada até o último degrau, para alcançar mais alto", "Fixada, ultrapassando em cerca de 1 metro o ponto de apoio, sem usar os últimos degraus", "Usada como apoio para a prancha do andaime"]', 2, 4),

    ('O que a norma exige nas áreas de vivência do canteiro?',
     '["Somente banheiro e bebedouro", "Instalações sanitárias, vestiário, local para refeição e água potável", "Somente um local coberto para o almoço", "Apenas armário individual para cada trabalhador"]', 1, 5),

    ('Sobre o capacete no canteiro de obra:',
     '["É de uso obrigatório e deve ter jugular, para não cair quando o trabalhador se inclina", "Só é obrigatório sob a área de içamento", "Pode ser dispensado no verão, pelo calor", "Serve principalmente para identificar a função do trabalhador"]', 0, 6),

    ('A serra circular de bancada precisa ter:',
     '["Apenas um interruptor de emergência", "Apenas mesa estável e bem iluminada", "Apenas aterramento elétrico", "Coifa protetora do disco, cutelo divisor, proteção das transmissões e ser operada por trabalhador qualificado"]', 3, 7),

    ('Sobre a instalação elétrica provisória da obra:',
     '["Emendas com fita isolante são aceitáveis se estiverem no alto", "Cabos podem passar no chão, se não houver poça de água", "Deve ter quadro com proteção adequada, cabos sem emenda improvisada e fora de áreas de trânsito e umidade", "Só precisa de cuidado quando chove"]', 2, 8),

    ('Em escavação com risco de desabamento, o correto é:',
     '["Escavar rápido e sair logo", "Executar talude adequado ou escoramento, e manter o material retirado afastado da borda", "Manter uma escada por perto e trabalhar sozinho", "Depositar o material escavado na borda, para facilitar o reaterro"]', 1, 9),

    ('Durante o içamento de cargas com grua ou guincho:',
     '["Pode passar por baixo se a carga estiver amarrada", "Pode circular por baixo se o operador avisar", "Pode ficar embaixo para orientar o posicionamento", "É proibido circular ou permanecer sob a carga suspensa, e a área deve ser isolada"]', 3, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-18';


-- =====================================================================
--  DD — Direção defensiva
--  Trânsito não tem norma regulamentadora própria, então a prova segue o
--  que já é praxe de curso corporativo: distância, atenção e álcool.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'DD')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O que é dirigir de forma defensiva?',
     '["Dirigir prevendo o risco e agindo para evitar o acidente, mesmo quando o erro é do outro", "Dirigir sempre abaixo da velocidade da via", "Nunca ultrapassar outro veículo", "Dirigir apenas em faixas da direita"]', 0, 1),

    ('Como se mede uma distância de seguimento segura?',
     '["Pelo comprimento de dois carros", "Deixando espaço para o retrovisor enxergar o veículo inteiro", "Pela regra dos 2 segundos em pista seca, aumentando para 3 ou mais em chuva e à noite", "Mantendo sempre 10 metros, em qualquer velocidade"]', 2, 2),

    ('Em pista molhada, o que reduz o risco de aquaplanagem?',
     '["Acelerar para atravessar a poça mais rápido", "Reduzir a velocidade, evitar poças e manter os pneus calibrados e com sulco", "Frear com força ao sentir o carro leve", "Dirigir com o pé apoiado no freio"]', 1, 3),

    ('Sobre o uso do celular ao volante:',
     '["Pode, se for chamada rápida", "Pode, se o veículo estiver em velocidade baixa", "Pode, se for apenas ler uma mensagem no semáforo", "É proibido segurar o aparelho, e mesmo no viva-voz a atenção cai e o risco aumenta"]', 3, 4),

    ('O que é o ponto cego de um caminhão?',
     '["A área do painel que o motorista não enxerga", "O trecho da via encoberto pela neblina", "A região ao redor do veículo que o motorista não enxerga pelos espelhos, principalmente à direita", "O espaço morto entre o cavalo e a carreta"]', 2, 5),

    ('Qual é a orientação sobre bebida alcoólica para quem dirige a serviço da empresa?',
     '["Tolerância zero: quem bebeu não dirige, em nenhuma quantidade", "Pode até uma dose, se for cerveja", "Pode, se esperar uma hora depois", "Pode, se for fora do horário de trabalho e o trajeto for curto"]', 0, 6),

    ('O motorista está com sono durante a viagem. O que fazer?',
     '["Abrir o vidro e aumentar o som", "Parar em local seguro e descansar antes de seguir", "Tomar café e continuar dirigindo", "Reduzir a velocidade e seguir com mais atenção"]', 1, 7),

    ('Uma ultrapassagem segura exige:',
     '["Apenas piscar o farol para avisar", "Apenas usar a seta e acelerar", "Apenas que a via tenha duas faixas", "Visibilidade suficiente, local permitido, sinalização com seta e espaço para retornar à faixa"]', 3, 8),

    ('Sobre o cinto de segurança nos bancos traseiros:',
     '["É obrigatório para todos os ocupantes, em qualquer banco", "É obrigatório apenas em rodovia", "É dispensável em trajeto curto dentro da cidade", "É obrigatório apenas para crianças"]', 0, 9),

    ('Antes de sair com o veículo da empresa, o motorista deve:',
     '["Apenas conferir o combustível", "Apenas conferir a documentação", "Verificar pneus, freios, luzes, retrovisores, nível de óleo e a documentação", "Apenas ligar e escutar o motor"]', 2, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'DD';


-- =====================================================================
--  BRIG — Brigada de incêndio e primeiros socorros
--  Metade incêndio, metade socorro, porque é assim que o curso é vendido.
--  Nas questões de socorro, a resposta certa quase sempre é acionar ajuda
--  e não improvisar: brigadista que se acha paramédico agrava a vítima.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'BRIG')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Para que serve o extintor de água pressurizada?',
     '["Incêndio em materiais sólidos como papel, madeira e tecido", "Incêndio em líquidos inflamáveis", "Incêndio em equipamento elétrico energizado", "Incêndio em óleo de cozinha"]', 0, 1),

    ('Pegou fogo em um quadro elétrico energizado. Qual a conduta correta?',
     '["Jogar água em jato para resfriar", "Desligar a energia, se possível, e usar extintor de CO2 ou pó químico", "Usar extintor de espuma mecânica", "Abafar com um cobertor molhado"]', 1, 2),

    ('Ao usar o extintor, a névoa ou o jato deve ser dirigido:',
     '["Para o alto das chamas", "Para a fumaça, que é o que sufoca", "Para a base do fogo, em movimento de varredura, com o vento pelas costas", "Para as paredes ao redor, para isolar o fogo"]', 2, 3),

    ('Durante a evacuação do prédio, o correto é:',
     '["Voltar rápido para pegar documentos importantes", "Usar o elevador, que é mais rápido", "Correr para a saída mais próxima, sem esperar ninguém", "Sair pelas escadas, sem correr, e permanecer no ponto de encontro até a liberação"]', 3, 4),

    ('Qual é a relação de compressões e ventilações na RCP em adulto?',
     '["15 compressões para 1 ventilação", "30 compressões para 2 ventilações, com 100 a 120 compressões por minuto", "10 compressões para 2 ventilações", "Compressões contínuas sem qualquer ventilação, sempre"]', 1, 5),

    ('Você encontra uma pessoa caída, que não responde e não respira. O que fazer primeiro?',
     '["Acionar o socorro (192) e iniciar as compressões torácicas imediatamente", "Dar água para ela se recuperar", "Levantar as pernas dela e esperar", "Procurar identificação para avisar a família"]', 0, 6),

    ('Uma pessoa engasgou, não consegue falar nem tossir e leva as mãos ao pescoço. O que fazer?',
     '["Dar tapas nas costas com ela deitada", "Oferecer água para empurrar o alimento", "Aplicar a manobra de Heimlich, com compressões abdominais, e acionar o socorro", "Colocar o dedo na boca para procurar o objeto"]', 2, 7),

    ('Qual é a conduta correta diante de uma queimadura?',
     '["Passar manteiga ou pasta de dente para aliviar", "Estourar as bolhas para a pele secar", "Cobrir com algodão para proteger", "Resfriar com água corrente em temperatura ambiente e cobrir com pano limpo, sem furar bolhas"]', 3, 8),

    ('Em uma hemorragia externa intensa, o socorrista deve:',
     '["Fazer torniquete logo de início, sempre", "Fazer compressão direta sobre o ferimento com pano limpo, usando luvas, e acionar o socorro", "Lavar o ferimento com álcool", "Deixar sangrar um pouco para limpar a ferida"]', 1, 9),

    ('Diante de vítima de queda com suspeita de fratura na coluna, o correto é:',
     '["Sentar a vítima para ver se ela consegue se apoiar", "Levar a vítima no carro da empresa até o hospital", "Não movimentar a vítima, manter a cabeça alinhada e acionar o serviço de emergência", "Virar a vítima de lado para ela respirar melhor"]', 2, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'BRIG';


-- =====================================================================
--  NR-01-INT4 — Integração de 4 horas
--  Prova de admissão: o aluno acabou de chegar e ainda não conhece a
--  empresa. As questões cobram direitos, deveres e a quem recorrer,
--  não teoria de gerenciamento de risco — isso fica na versão de 8h.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-01-INT4')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Para que serve a Ordem de Serviço de segurança que o trabalhador assina?',
     '["Para autorizar descontos em folha", "Para informar os riscos da função e as obrigações de segurança, que passam a ser de cumprimento obrigatório", "Para registrar o horário de trabalho", "Para comprovar a entrega do uniforme"]', 1, 1),

    ('O trabalhador pode se recusar a executar uma tarefa?',
     '["Não, ordem de serviço é para ser cumprida", "Sim, sempre que não gostar do serviço", "Sim, se o serviço não estiver na descrição do cargo", "Sim, quando houver risco grave e iminente à sua saúde ou à de terceiros, comunicando o superior"]', 3, 2),

    ('O que é o PGR da empresa?',
     '["O programa que gerencia os riscos: identifica os perigos, avalia e define o plano de ação", "O programa de metas de produção", "O plano de cargos e salários", "O registro dos exames médicos dos empregados"]', 0, 3),

    ('O que é um quase-acidente e o que fazer com ele?',
     '["É o acidente sem afastamento, e só entra na estatística", "É acidente de trajeto, e não precisa de registro", "É o evento que quase causou lesão ou dano, e deve ser comunicado para corrigir a causa antes que aconteça de verdade", "É o acidente com dano só material, e é problema da manutenção"]', 2, 4),

    ('Aconteceu um acidente de trabalho, mesmo sem ferimento aparente. O que fazer?',
     '["Esperar para ver se aparece alguma dor nos próximos dias", "Comunicar imediatamente a chefia e o setor de segurança, para atendimento e registro", "Comunicar só no fim do turno, para não parar o serviço", "Comunicar apenas se houver afastamento"]', 1, 5),

    ('Qual das opções é responsabilidade do trabalhador?',
     '["Elaborar os procedimentos de segurança do setor", "Custear os equipamentos de proteção", "Fiscalizar o trabalho dos colegas", "Cumprir as normas, usar corretamente o EPI e colaborar com a empresa nas ações de prevenção"]', 3, 6),

    ('Você encontra uma área isolada com sinalização de acesso restrito. O que fazer?',
     '["Não entrar e procurar o responsável pela área para saber o motivo e a liberação", "Entrar com cuidado, se for rápido", "Entrar se estiver com o EPI completo", "Remover a sinalização se ela estiver atrapalhando a passagem"]', 0, 7),

    ('Por que ordem e limpeza são tratadas como item de segurança?',
     '["Porque melhoram a imagem da empresa perante o cliente", "Porque reduzem o custo com material de limpeza", "Porque piso obstruído e material fora do lugar causam quedas, choques, incêndio e dificultam a evacuação", "Porque facilitam o trabalho da equipe de limpeza"]', 2, 8),

    ('Qual é a obrigação da empresa em relação ao treinamento?',
     '["Treinar apenas os empregados efetivados", "Informar os riscos e fornecer capacitação, durante a jornada e sem custo para o trabalhador", "Cobrar do trabalhador o valor do curso se ele pedir demissão", "Treinar somente quando a fiscalização exigir"]', 1, 9),

    ('O procedimento não prevê a situação que apareceu no serviço. O que fazer?',
     '["Improvisar a solução mais rápida", "Fazer como o colega mais antigo costuma fazer", "Deixar o serviço para o próximo turno sem avisar", "Parar a atividade e consultar o superior ou o setor de segurança antes de continuar"]', 3, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-01-INT4';


-- =====================================================================
--  NR-01-INT8 — Integração de 8 horas
--  Mesma norma, público diferente: aqui cabe cobrar GRO, inventário,
--  plano de ação e hierarquia de controle. Nenhuma questão repete a
--  prova de 4 horas, para as duas turmas não se misturarem.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-01-INT8')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Do que trata a NR-01?',
     '["Apenas do uso de equipamentos de proteção individual", "Apenas da fiscalização do trabalho", "Das disposições gerais e do gerenciamento de riscos ocupacionais, valendo para todas as demais normas", "Apenas dos treinamentos de admissão"]', 2, 1),

    ('Quais são as etapas do gerenciamento de riscos ocupacionais?',
     '["Identificar os perigos, avaliar os riscos, classificar, implantar controles e acompanhar o resultado", "Contratar o SESMT, montar a CIPA e comprar EPI", "Medir o ruído, medir o calor e emitir o laudo", "Fazer exame admissional, periódico e demissional"]', 0, 2),

    ('Qual é a diferença entre inventário de riscos e plano de ação?',
     '["Não existe diferença: são nomes do mesmo documento", "O inventário registra os perigos e riscos levantados; o plano de ação define o que será feito, por quem e até quando", "O inventário é da empresa e o plano de ação é do trabalhador", "O inventário vale um ano e o plano de ação vale dois"]', 1, 3),

    ('Qual é a ordem correta da hierarquia de medidas de controle?',
     '["EPI, medidas administrativas e por último a engenharia", "Engenharia, EPI e por último a eliminação", "Tanto faz, desde que o risco diminua", "Eliminar o risco, substituir por algo menos perigoso, controles de engenharia e coletivos, medidas administrativas e por fim o EPI"]', 3, 4),

    ('Quando o PGR deve ser revisado?',
     '["Somente quando a fiscalização apontar", "Periodicamente e sempre que houver acidente, mudança de processo, novo risco ou inadequação identificada", "Somente na mudança de responsável técnico", "A cada cinco anos"]', 1, 5),

    ('Por que a empresa investiga o quase-acidente, se ninguém se feriu?',
     '["Porque ele mostra uma falha real que ainda não causou lesão, e corrigi-la evita o acidente", "Porque a norma exige o registro estatístico", "Para identificar quem errou e aplicar advertência", "Para justificar a compra de novos EPI"]', 0, 6),

    ('Em quais situações a capacitação em segurança precisa ser feita?',
     '["Apenas na admissão", "Apenas quando a norma específica exigir", "Inicial, periódica e eventual: na mudança de função, de procedimento, de equipamento ou após evento que revele necessidade", "Somente quando o trabalhador solicitar"]', 2, 7),

    ('Para que servem os registros de treinamento e as listas de presença?',
     '["Para controlar a frequência e descontar do salário", "Para uso interno do RH apenas", "Para calcular o custo do treinamento", "Para comprovar que o trabalhador foi capacitado, o que a empresa precisa demonstrar em fiscalização e em acidente"]', 3, 8),

    ('Ao identificar risco grave e iminente, o trabalhador deve:',
     '["Resolver por conta própria antes que alguém se machuque", "Registrar na próxima reunião da CIPA", "Interromper as atividades e comunicar imediatamente o superior hierárquico", "Continuar o serviço com atenção redobrada"]', 2, 9),

    ('Quando há empresas contratadas atuando no local, quem informa os riscos?',
     '["A contratante informa os riscos do seu estabelecimento, e as empresas harmonizam as medidas de prevenção entre si", "Cada empresa cuida apenas dos seus empregados, sem trocar informação", "Somente a contratada, que conhece o serviço", "O sindicato da categoria predominante"]', 0, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-01-INT8';


-- =====================================================================
--  NR-26 — Sinalização de segurança
--  Cores e rotulagem. As questões de rótulo pesam mais do que as de cor:
--  produto transferido para vasilhame sem identificação continua sendo
--  causa comum de intoxicação e de ingestão acidental.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-26')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Na segurança do trabalho, a cor vermelha identifica principalmente:',
     '["Áreas de circulação de pedestres", "Equipamentos e dispositivos de combate a incêndio e botões de parada de emergência", "Materiais em inspeção", "Tubulação de água potável"]', 1, 1),

    ('A cor amarela é usada para indicar:',
     '["Cuidado e atenção: partes baixas, quinas, corrimãos, faixas no piso e equipamentos que podem causar tropeço ou impacto", "Locais de primeiros socorros", "Tubulação de ar comprimido", "Áreas de armazenamento de inflamáveis"]', 0, 2),

    ('A cor verde é usada para identificar:',
     '["Equipamentos elétricos energizados", "Áreas de risco químico", "Segurança: chuveiro de emergência, maca, caixa de EPI e localização de saída", "Áreas em manutenção"]', 2, 3),

    ('A cor azul, na sinalização de segurança, indica:',
     '["Perigo de queda", "Piso escorregadio", "Presença de radiação", "Ação obrigatória ou advertência para não movimentar equipamento em manutenção"]', 3, 4),

    ('O que precisa constar no rótulo de um produto químico perigoso?',
     '["Somente o nome comercial e o fabricante", "Identificação do produto, pictogramas de perigo, palavra de advertência, frases de perigo e de precaução", "Somente o prazo de validade e o lote", "Somente o número do CA"]', 1, 5),

    ('Para que serve a Ficha com Dados de Segurança (FDS ou FISPQ) do produto?',
     '["Para comprovar a compra do produto", "Para registrar o consumo mensal", "Para informar os perigos, o EPI necessário, o que fazer em caso de derramamento, contato e incêndio", "Para orientar apenas o setor de compras"]', 2, 6),

    ('O pictograma da caveira sobre duas tíbias indica:',
     '["Toxicidade aguda: pode causar intoxicação grave ou morte", "Produto corrosivo para metais", "Risco de explosão", "Perigo ao meio ambiente aquático"]', 0, 7),

    ('Um produto químico foi transferido do galão original para outro recipiente. O que fazer?',
     '["Nada, se o uso for no mesmo dia", "Escrever o nome do produto com giz na lateral", "Deixar sem rótulo, mas guardar longe dos demais", "Identificar o novo recipiente com as mesmas informações de perigo do rótulo original"]', 3, 8),

    ('Por que não se pode usar garrafa de refrigerante para guardar produto químico?',
     '["Porque o plástico reage com qualquer produto", "Porque a embalagem induz alguém a beber o conteúdo, e já causou mortes", "Porque a garrafa não suporta o peso", "Porque a garrafa não tem tampa adequada"]', 1, 9),

    ('Sobre a identificação das tubulações na indústria:',
     '["Basta identificar as tubulações de vapor", "A identificação é opcional quando as tubulações estão aparentes", "Devem ser identificadas por cor e legenda, com indicação do produto e do sentido do fluxo", "A identificação é feita apenas nas válvulas"]', 2, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-26';


-- =====================================================================
--  NR-34.5 — Trabalho a quente
--  Tem sobreposição proposital com o NR-20 em permissão de trabalho e
--  vigia de fogo. Não é repetição preguiçosa: são cursos vendidos
--  separadamente, e quem faz só este precisa sair sabendo os dois.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-34.5')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O que é considerado trabalho a quente?',
     '["Toda atividade que gera chama, calor ou faísca, como solda, corte, esmerilhamento e aquecimento", "Somente a solda elétrica", "Apenas o trabalho realizado sob sol forte", "Somente o corte com maçarico"]', 0, 1),

    ('Sobre a Permissão de Trabalho para serviço a quente:',
     '["Vale para toda a obra, enquanto o contrato durar", "É emitida pelo próprio soldador antes de começar", "É emitida antes do início, tem validade definida, é assinada pelos responsáveis e cancelada se as condições mudarem", "Só é exigida em refinaria e indústria química"]', 2, 2),

    ('O que fazer com os materiais combustíveis próximos ao ponto de solda?',
     '["Molhar o piso ao redor e começar o serviço", "Afastar os combustíveis da área e, quando não for possível remover, proteger com manta ou anteparo resistente ao fogo", "Cobrir com lona plástica", "Manter afastados apenas os inflamáveis líquidos"]', 1, 3),

    ('Qual é a função do vigia de fogo?',
     '["Ajudar a segurar a peça durante a solda", "Anotar o horário de início e fim do serviço", "Controlar a entrada de pessoas na área", "Observar a área durante o serviço e continuar observando por um período após o término, pronto para agir"]', 3, 4),

    ('Sobre o extintor no local do trabalho a quente:',
     '["Deve estar ao alcance imediato, com carga válida e adequado ao material da área", "Basta que exista um extintor no corredor mais próximo", "Só é necessário em ambientes fechados", "Fica sob responsabilidade da brigada, que traz quando chamada"]', 0, 5),

    ('Como devem ser mantidos os cilindros de gás?',
     '["Deitados, para não tombarem", "Em pé, próximos ao ponto de solda para facilitar", "Em pé, presos por corrente, longe de fontes de calor, com capacete de proteção da válvula e válvula contra retrocesso de chama", "Em pé e sem fixação, desde que em piso plano"]', 2, 6),

    ('Como se verifica vazamento em mangueiras e conexões de gás?',
     '["Aproximando uma chama para ver se aumenta", "Com solução de água e sabão, observando a formação de bolhas", "Pelo cheiro do gás", "Apertando a mangueira com a mão"]', 1, 7),

    ('Antes de trabalho a quente em área onde pode haver gases ou vapores inflamáveis:',
     '["Basta abrir portas e janelas", "Basta usar máscara com filtro químico", "Basta avisar a equipe da área", "É preciso medir a atmosfera e liberar a área conforme os procedimentos, mantendo o monitoramento durante o serviço"]', 3, 8),

    ('Pode-se soldar em tambor ou tanque que já conteve produto inflamável?',
     '["Sim, se estiver vazio há bastante tempo", "Sim, se for lavado com água", "Somente após limpeza, remoção dos resíduos e vapores e liberação formal, porque o vapor residual explode", "Não, em nenhuma hipótese"]', 2, 9),

    ('Qual é o conjunto adequado de proteção para o soldador?',
     '["Máscara com filtro de grau adequado, avental, luva e mangote de raspa, perneira e calçado de segurança", "Óculos escuros comuns e luva de algodão", "Somente a máscara de solda", "Máscara de solda e camiseta de algodão"]', 0, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-34.5';


-- =====================================================================
--  LOTO — Bloqueio e etiquetagem
--  O curso é curto e o erro sempre é o mesmo: etiqueta sem cadeado, e
--  cadeado que outra pessoa retira. Metade das questões trata disso.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'LOTO')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O que é o procedimento LOTO?',
     '["Um checklist de manutenção preventiva", "O bloqueio físico das fontes de energia somado à etiquetagem que identifica quem bloqueou e por quê", "Um sistema de identificação de tubulações", "Uma etiqueta de inspeção de equipamentos"]', 1, 1),

    ('Quais energias precisam ser consideradas no bloqueio de uma máquina?',
     '["Apenas a elétrica", "Elétrica e pneumática", "Elétrica, pneumática e hidráulica", "Elétrica, hidráulica, pneumática, mecânica, térmica, química e a gravitacional de peças suspensas"]', 3, 2),

    ('Em um serviço com várias pessoas na mesma máquina, como funcionam os cadeados?',
     '["Cada trabalhador coloca o seu próprio cadeado no dispositivo, e a máquina só é liberada quando o último for retirado", "Um cadeado do encarregado vale para toda a equipe", "O cadeado é colocado pelo primeiro que chegar", "Usa-se apenas a etiqueta com o nome de todos"]', 0, 3),

    ('Quem pode retirar um cadeado de bloqueio?',
     '["O supervisor, no fim do turno", "Qualquer pessoa da manutenção", "Somente o trabalhador que o colocou", "O operador da máquina, quando precisar produzir"]', 2, 4),

    ('Qual é a limitação da etiqueta usada sozinha, sem cadeado?',
     '["Ela desbota com o tempo", "Ela informa e adverte, mas não impede fisicamente que alguém acione o equipamento", "Ela não pode ser usada em áreas externas", "Ela precisa ser assinada por duas pessoas"]', 1, 5),

    ('Depois de bloquear a energia, qual é o passo seguinte?',
     '["Iniciar o serviço, já que o bloqueio está feito", "Anotar o número do cadeado no relatório", "Comunicar o setor de produção", "Dissipar a energia residual e testar a partida do equipamento para confirmar que ele não liga"]', 3, 6),

    ('Você precisa usar uma máquina que está bloqueada e etiquetada por outra pessoa. O que fazer?',
     '["Não operar e procurar quem assinou a etiqueta para saber a situação", "Retirar o cadeado, já que o serviço aparentemente terminou", "Usar a máquina sem acionar a parte bloqueada", "Cortar o cadeado e colocar outro no lugar"]', 0, 7),

    ('O trabalhador foi embora e esqueceu o cadeado na máquina. Como proceder?',
     '["Cortar o cadeado e liberar a máquina", "Esperar o retorno dele no próximo turno, sem registrar nada", "Seguir o procedimento formal de remoção excepcional: tentar contato, confirmar que a área está livre e registrar com autorização do responsável", "Chamar a manutenção para trocar o dispositivo de bloqueio"]', 2, 8),

    ('O serviço não terminou e o turno vai virar. O que fazer com o bloqueio?',
     '["Retirar o bloqueio e refazer no dia seguinte", "Fazer a transferência de bloqueio: o trabalhador que sai só retira o cadeado depois que o do turno seguinte estiver colocado", "Deixar apenas a etiqueta durante a noite", "Deixar o cadeado do encarregado até o retorno da equipe"]', 1, 9),

    ('Antes de liberar o equipamento para operar novamente, é preciso:',
     '["Apenas retirar os cadeados", "Apenas avisar o operador", "Apenas religar o disjuntor", "Retirar ferramentas e materiais, recolocar as proteções, conferir que não há ninguém na zona de risco e só então retirar os bloqueios e avisar a equipe"]', 3, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'LOTO';


-- =====================================================================
--  DD-REC — Direção defensiva (reciclagem)
--  Nenhuma questão repete a prova do DD. Reciclagem que devolve a mesma
--  prova não mede nada: o aluno lembra do gabarito, não do conteúdo.
--  Aqui o foco é condição adversa, manutenção e conduta em ocorrência.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'DD-REC')
   and ordem between 1 and 10;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Quais são os elementos básicos da direção defensiva?',
     '["Velocidade, potência e habilidade", "Documentação, seguro e manutenção", "Conhecimento, atenção, previsão, habilidade e ação", "Pressa, reflexo e sorte"]', 2, 1),

    ('Em uma frenagem de emergência com freio ABS, o motorista deve:',
     '["Pisar firme no freio, manter a pressão e esterçar para desviar do obstáculo", "Bombear o freio várias vezes", "Frear e puxar o freio de mão junto", "Frear em pancadas curtas para não travar as rodas"]', 0, 2),

    ('Ao dirigir em neblina, o correto é:',
     '["Usar o farol alto para enxergar mais longe", "Usar o farol baixo e o de neblina, reduzir a velocidade e aumentar a distância do veículo da frente", "Acompanhar de perto a lanterna do veículo da frente", "Ligar o pisca-alerta e seguir na velocidade normal"]', 1, 3),

    ('Sobre a manutenção dos pneus:',
     '["A calibragem deve ser feita com os pneus quentes, após a viagem", "Pneu com sulco raso melhora a aderência em pista seca", "A calibragem só precisa ser conferida na revisão", "A calibragem deve ser feita com os pneus frios, e o pneu deve ser trocado ao atingir o indicador de desgaste"]', 3, 4),

    ('Na direção noturna, é correto:',
     '["Reduzir a velocidade, manter o para-brisa limpo e baixar o farol ao cruzar com outro veículo", "Manter o farol alto o tempo todo em rodovia", "Usar óculos escuros para reduzir o ofuscamento", "Acender a luz interna para enxergar o painel"]', 0, 5),

    ('O veículo apresentou pane na rodovia. Qual é a conduta?',
     '["Parar na faixa da direita e ficar dentro do veículo", "Sair do veículo pelo lado do motorista e caminhar pela pista", "Encostar o máximo possível no acostamento, ligar o pisca-alerta, vestir o colete, posicionar o triângulo a uma distância adequada e aguardar em local seguro fora da pista", "Deixar o veículo no local e ir buscar ajuda sem sinalizar"]', 2, 6),

    ('Sobre o transporte de carga no veículo da empresa:',
     '["Basta que a carga esteja dentro da caçamba", "A carga precisa estar amarrada e bem distribuída: carga solta desloca o centro de gravidade e pode causar tombamento", "Carga leve dispensa amarração", "A amarração só é necessária em viagens longas"]', 1, 7),

    ('Ao ultrapassar um ciclista ou motociclista, o motorista deve:',
     '["Buzinar para avisar e passar próximo", "Passar rápido para reduzir o tempo de exposição", "Manter a mesma distância usada para ultrapassar um carro", "Guardar distância lateral de segurança de pelo menos 1,5 metro, reduzindo a velocidade"]', 3, 8),

    ('O motorista está tomando um medicamento que causa sonolência. O que fazer?',
     '["Dirigir apenas trechos curtos", "Tomar o remédio só depois de dirigir", "Informar a chefia e não dirigir enquanto estiver sob efeito, consultando o serviço médico", "Compensar com café e parada a cada hora"]', 2, 9),

    ('Ao chegar em um acidente com vítimas, o primeiro cuidado é:',
     '["Retirar as vítimas dos veículos o mais rápido possível", "Sinalizar o local para evitar um segundo acidente e acionar o socorro, sem remover as vítimas", "Fotografar a cena para o seguro", "Afastar os veículos para liberar a pista"]', 1, 10)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'DD-REC';


-- a aprovação continua em 70% para todo mundo
update public.trein_curso set nota_minima = 70;

-- Confira quantas perguntas cada curso tem:
-- ANTES DA CONTAGEM: curso que ficou SEM prova nenhuma.
-- Se um codigo estiver escrito errado, o insert nao reclama — ele so nao
-- casa com linha nenhuma e sai com zero. Foi o que aconteceu com o
-- "NR-35", que na verdade se chama NR-35-REC. Esta consulta TEM DE VIR
-- VAZIA; o que aparecer aqui e curso que o aluno nao consegue concluir.
select codigo, titulo, 'SEM PROVA — o aluno assiste tudo e trava' as alerta
  from public.trein_curso c
 where ativo
   and not exists (select 1 from public.trein_questao q where q.curso_id = c.id)
 order by ordem;

select c.codigo, c.titulo, c.nota_minima, count(q.id) as perguntas
  from public.trein_curso c
  left join public.trein_questao q on q.curso_id = c.id
 group by c.id order by perguntas desc, c.ordem;
