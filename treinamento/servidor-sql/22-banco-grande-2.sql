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
