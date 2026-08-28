-- =====================================================================
--  Banco de questões — grupo A
--  NR-01-INT4, NR-01-INT8, NR-05, NR-06 e NR-10
--  30 questões novas por curso, ordem 11 a 40. São 150 questões no total.
--
--  Rode no SQL Editor. Pode rodar mais de uma vez: cada bloco apaga só as
--  suas próprias questões (ordem 11 a 40) antes de inserir de novo.
--
--  ATENÇÃO: ESTAS PERGUNTAS PRECISAM DA CONFERIDA DO RESPONSÁVEL TÉCNICO
--  ANTES DE VALEREM PARA CERTIFICADO.
--  Foram escritas a partir do conteúdo usual de cada norma e do que se
--  cobra em campo. São coerentes com as normas, mas quem responde pela
--  prova é o responsável técnico — prova errada reprova quem sabe e
--  aprova quem não sabe, e é o certificado dele que está em jogo.
--
--  PARA QUE SERVE ESTE ARQUIVO
--  A prova sorteia 10 questões do banco do curso. Com 10 perguntas
--  cadastradas, todo aluno faz a mesma prova e o gabarito passa de boca em
--  boca em uma semana. Com 40, duas provas seguidas dificilmente saem
--  iguais e decorar deixa de ser atalho.
--
--  AS 10 PRIMEIRAS CONTINUAM VALENDO
--  As questões de ordem 1 a 10 vieram dos arquivos 10-prova-nr20.sql e
--  12-provas-demais-cursos.sql e NÃO são apagadas aqui: o delete de cada
--  bloco tem `ordem between 11 and 40`. Rodar este arquivo depois daqueles
--  deixa o curso com 40 questões, não com 30.
--
--  NENHUMA QUESTÃO REPETE AS 10 QUE JÁ EXISTIAM
--  Nem o mesmo assunto escrito com outras palavras. Banco grande com
--  pergunta repetida não sorteia coisa nova: só aumenta a chance de o
--  aluno ver duas vezes o mesmo item na mesma prova.
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
--  NR-01-INT4 — Integração de 4 horas (questões 11 a 40)
--  Continua sendo prova de quem acabou de chegar. Nada de teoria de
--  gerenciamento de risco: o que este trabalhador precisa saber é a quem
--  falar, o que não fazer sozinho e o que fazer quando o alarme toca.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-01-INT4')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O que é o ASO que o trabalhador recebe depois do exame médico?',
     '["A ficha de registro do empregado", "O comprovante de entrega do EPI", "O Atestado de Saúde Ocupacional, que informa se o trabalhador está apto ou inapto para aquela função", "O laudo de insalubridade do setor"]', 2, 11),

    ('O que é a CAT?',
     '["A Comunicação de Acidente de Trabalho, emitida quando ocorre acidente ou doença relacionada ao trabalho", "O Cadastro de Atividades do Trabalhador", "O Certificado de Aptidão Técnica da função", "A Carteira de Autorização de Tarefas"]', 0, 12),

    ('Você percebeu uma condição insegura no setor, como um fio descascado. O que fazer?',
     '["Resolver por conta própria com fita isolante", "Deixar como está e desviar do local", "Comentar com os colegas para ninguém encostar", "Comunicar de imediato a chefia e o setor de segurança e, se possível, isolar o local"]', 3, 13),

    ('Para que serve o Diálogo Diário de Segurança, o DDS?',
     '["Para registrar o ponto da equipe antes do serviço", "Para conversar rapidamente sobre os riscos do dia e os cuidados antes de começar o trabalho", "Para distribuir as tarefas de produção", "Para avaliar o desempenho de cada trabalhador"]', 1, 14),

    ('Qual é a diferença entre proteção coletiva e proteção individual?',
     '["A coletiva protege todos que estão na área, como guarda-corpo e exaustor, e a individual protege só quem usa, como capacete e luva", "A coletiva é comprada pela empresa e a individual pelo trabalhador", "A coletiva é usada na obra e a individual na fábrica", "Não existe diferença: os dois nomes querem dizer a mesma coisa"]', 0, 15),

    ('O trabalhador se acidentou no caminho de casa para o trabalho. Como isso deve ser tratado?',
     '["Não precisa comunicar, porque aconteceu fora da empresa", "Não precisa comunicar, porque ele ainda não tinha batido o ponto", "Só precisa comunicar se ele estivesse no transporte fornecido pela empresa", "Deve ser comunicado à empresa como qualquer outro acidente, para atendimento e registro"]', 3, 16),

    ('Brincadeiras, correria e empurrões dentro da área de trabalho:',
     '["São aceitáveis quando o ritmo do serviço está tranquilo", "São proibidos: distraem, provocam quedas e já causaram acidentes graves", "São permitidos fora do horário de produção", "Dependem da autorização do encarregado"]', 1, 17),

    ('A ferramenta que você pegou está com o cabo trincado. O que fazer?',
     '["Enrolar fita isolante no cabo e usar assim mesmo", "Usar com cuidado até terminar o serviço", "Retirar de uso, comunicar e pegar outra ferramenta em condições", "Deixar no lugar e avisar só no fim do turno"]', 2, 18),

    ('Tocou o alarme de emergência da empresa. O que fazer?',
     '["Terminar o serviço que está na mão e sair depois", "Ir até a portaria buscar informação", "Esperar o encarregado avisar pessoalmente", "Interromper a atividade, sair pela rota de fuga e permanecer no ponto de encontro até a liberação"]', 3, 19),

    ('Por que a rota de fuga e as saídas de emergência não podem ser obstruídas?',
     '["Porque em uma emergência, com fumaça e correria, qualquer obstáculo atrasa a saída e custa vidas", "Porque atrapalha a passagem das empilhadeiras", "Porque suja e desorganiza o corredor", "Porque a fiscalização multa por causa da aparência do local"]', 0, 20),

    ('Pediram para você operar uma máquina que você nunca usou e para a qual não foi treinado. O que fazer?',
     '["Operar devagar e pedir dicas ao colega do lado", "Operar, porque ordem de serviço não se discute", "Não operar e informar que ainda não recebeu treinamento nem autorização para aquela máquina", "Operar apenas a parte mais simples do serviço"]', 2, 21),

    ('Você não entendeu direito como o serviço deve ser feito. O correto é:',
     '["Fazer do jeito que parecer mais lógico", "Perguntar ao responsável antes de começar, mesmo que pareça uma dúvida boba", "Observar o colega de longe e imitar", "Começar e ir ajustando durante o serviço"]', 1, 22),

    ('Os riscos ambientais do trabalho costumam ser agrupados em:',
     '["Leves, moderados e graves", "Internos e externos", "Previsíveis e imprevisíveis", "Físicos, químicos, biológicos, ergonômicos e de acidente"]', 3, 23),

    ('Sobre a perda auditiva causada pelo ruído no trabalho:',
     '["Ela volta ao normal depois das férias", "Ela só acontece com quem já tem problema de ouvido", "Ela se instala aos poucos, sem dor, e não tem cura: por isso o protetor é usado desde o primeiro dia", "Ela só aparece em quem trabalha mais de vinte anos no setor"]', 2, 24),

    ('Você encontrou um galão sem rótulo com líquido dentro. O que fazer?',
     '["Não usar nem cheirar, isolar e comunicar o responsável para identificação ou descarte", "Cheirar de longe para tentar descobrir o produto", "Usar, se parecer com o produto que a equipe costuma usar", "Escrever um nome qualquer no galão para não esquecer"]', 0, 25),

    ('Sobre bebida alcoólica e drogas antes ou durante a jornada:',
     '["São aceitáveis em confraternizações dentro da empresa", "São proibidas: alteram os reflexos e o julgamento e colocam o trabalhador e a equipe em risco", "Dependem do tipo de serviço executado no dia", "São permitidas se o trabalhador se sentir bem"]', 1, 26),

    ('Fumar em área sinalizada como proibido fumar:',
     '["Pode, se o trabalhador ficar perto da janela", "Pode, se ninguém reclamar", "Pode, desde que apague o cigarro no chão", "É proibido: a sinalização existe por causa do risco de incêndio e explosão e da saúde das outras pessoas"]', 3, 27),

    ('O extintor do setor está atrás de caixas empilhadas. O que fazer?',
     '["Nada, porque as caixas saem no fim do dia", "Liberar o acesso na hora e comunicar: extintor obstruído não serve para nada na emergência", "Mudar o extintor de lugar por conta própria", "Anotar para tratar na próxima reunião"]', 1, 28),

    ('Um colega ofereceu carona nos garfos da empilhadeira até o outro lado do galpão. O que fazer?',
     '["Aceitar, porque a distância é curta", "Aceitar, se ele for devagar", "Recusar: só se transporta pessoa em equipamento e plataforma previstos para essa finalidade", "Aceitar, segurando firme na torre"]', 2, 29),

    ('Você não tem o curso de trabalho em altura e pediram para subir no andaime para uma tarefa rápida. O que fazer?',
     '["Não subir e informar que não é capacitado nem autorizado para trabalho em altura", "Subir, porque é rápido e o andaime tem guarda-corpo", "Subir usando o cinto emprestado de um colega", "Subir se alguém ficar segurando o andaime embaixo"]', 0, 30),

    ('Depois de lavar o piso ou derramar líquido no chão, o correto é:',
     '["Esperar secar sozinho", "Avisar os colegas de viva voz", "Deixar um balde no local para as pessoas notarem", "Sinalizar a área e secar o quanto antes: piso escorregadio é uma das maiores causas de queda no trabalho"]', 3, 31),

    ('O trabalhador de empresa terceirizada precisa cumprir as regras de segurança da empresa contratante?',
     '["Não, ele segue apenas as regras da empresa dele", "Sim: ele cumpre as regras do local onde está trabalhando, além das da própria empresa", "Somente quando o contrato for de longa duração", "Somente se estiver usando o uniforme da contratante"]', 1, 32),

    ('Usar o celular andando pela área industrial ou pelo canteiro de obra:',
     '["Deve ser evitado: a atenção sai do caminho e do entorno, e é assim que acontecem atropelamento, tropeço e queda", "Pode, se for uma mensagem rápida", "Pode, desde que o trabalhador ande devagar", "Pode, se o celular for da empresa"]', 0, 33),

    ('Estopa e panos sujos de óleo e solvente devem ser:',
     '["Jogados no lixo comum do setor", "Deixados na bancada para reutilizar no dia seguinte", "Descartados em recipiente próprio, fechado e identificado, porque podem entrar em combustão", "Queimados no pátio ao fim do turno"]', 2, 34),

    ('O que a empresa deve garantir quanto às condições básicas do local de trabalho?',
     '["Apenas banheiro e vestiário", "Água potável, instalações sanitárias, local adequado para as refeições e vestiário conforme a atividade", "Apenas bebedouro e refeitório", "Apenas armário individual para cada trabalhador"]', 1, 35),

    ('Você sofreu ou presenciou assédio no ambiente de trabalho. O que a empresa deve oferecer?',
     '["Somente a orientação de conversar diretamente com quem cometeu o assédio", "Somente o registro em boletim de ocorrência", "Somente o afastamento imediato de quem denunciou", "Canais de denúncia divulgados, apuração dos fatos e garantia de que a denúncia não gera retaliação"]', 3, 36),

    ('Você vê um colega executando um serviço sem a proteção adequada. O que fazer?',
     '["Orientar o colega e, se ele continuar, comunicar a chefia ou o setor de segurança", "Fingir que não viu, porque o serviço é dele", "Filmar para mostrar depois na reunião", "Fazer igual, já que o serviço parece dar certo assim"]', 0, 37),

    ('Uma placa redonda de fundo azul na área de trabalho indica:',
     '["Perigo iminente no local", "Proibição de acesso", "Ação obrigatória, como usar determinado equipamento de proteção", "Localização de equipamento de combate a incêndio"]', 2, 38),

    ('Um colega passou mal e caiu no setor. Qual é a primeira atitude?',
     '["Levantar o colega e levar até o bebedouro", "Dar água e algum remédio para ele melhorar", "Levar de carro até o hospital mais próximo", "Não movimentar sem necessidade, acionar o socorro e o serviço médico e afastar a aglomeração"]', 3, 39),

    ('Ao circular a pé por área onde trafegam empilhadeiras e caminhões, o correto é:',
     '["Andar rente às máquinas para o operador enxergar melhor", "Usar as faixas demarcadas para pedestre, olhar antes de cruzar e nunca passar por trás de equipamento em manobra", "Passar rápido atrás do equipamento, aproveitando o espaço", "Confiar que o operador sempre enxerga o pedestre"]', 1, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-01-INT4';


-- =====================================================================
--  NR-01-INT8 — Integração de 8 horas (questões 11 a 40)
--  Aqui cabe cobrar o raciocínio do gerenciamento de risco: perigo e
--  risco não são a mesma coisa, medida implantada não é medida eficaz e
--  documento na gaveta não protege ninguém.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-01-INT8')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Qual é a diferença entre perigo e risco?',
     '["Perigo é o que já aconteceu e risco é o que ainda pode acontecer", "Perigo é a fonte com potencial de causar dano, e risco é a combinação entre a chance de o dano ocorrer e a gravidade dele", "Perigo vale para a máquina e risco vale para a pessoa", "São a mesma coisa, com nomes diferentes"]', 1, 11),

    ('De quem é a responsabilidade pela implementação do PGR?',
     '["Do SESMT, que elabora e responde por ele", "Da CIPA, por ser paritária", "Do órgão de fiscalização do trabalho", "Da organização, ou seja, do empregador, que pode contar com apoio técnico interno ou externo"]', 3, 12),

    ('Como o risco é avaliado no gerenciamento de riscos ocupacionais?',
     '["Pela combinação entre a probabilidade de o dano ocorrer e a gravidade das consequências", "Pelo número de acidentes já ocorridos naquele setor", "Pelo custo da medida de controle necessária", "Pelo tempo que o trabalhador está na função"]', 0, 13),

    ('O PGR pode ser um documento genérico, comprado pronto e igual ao de outra empresa?',
     '["Pode, se as duas empresas forem do mesmo ramo", "Pode, desde que assinado por profissional habilitado", "Não: ele precisa refletir os perigos e as condições reais daquele estabelecimento", "Pode, quando a empresa é de pequeno porte"]', 2, 14),

    ('O que caracteriza uma medida de controle de engenharia?',
     '["Treinar o trabalhador para tomar mais cuidado na tarefa", "Fornecer protetor auricular e máscara adequados", "Fazer rodízio do trabalhador entre postos ao longo do dia", "Atuar na fonte ou na trajetória do risco, como enclausurar a máquina, instalar exaustão ou colocar proteção fixa"]', 3, 15),

    ('O que é uma medida administrativa de controle?',
     '["Comprar equipamento com tecnologia mais moderna", "Organizar o trabalho para reduzir a exposição: procedimento, rodízio, limitação do tempo, sinalização e treinamento", "Instalar barreira física entre o trabalhador e o risco", "Substituir o produto químico por outro menos perigoso"]', 1, 16),

    ('O plano de ação precisa conter, no mínimo:',
     '["A lista dos EPI comprados no ano", "A relação dos exames médicos previstos", "As medidas a implantar, o responsável por cada uma e o prazo, com acompanhamento da execução", "O organograma do setor de segurança"]', 2, 17),

    ('Depois que uma medida de controle é implantada, o que ainda precisa ser feito?',
     '["Verificar se ela realmente reduziu o risco e corrigir o que não funcionou", "Nada: o item pode ser encerrado no plano de ação", "Apenas arquivar a nota fiscal do investimento", "Apenas comunicar a CIPA na reunião seguinte"]', 0, 18),

    ('Quando uma máquina nova ou um processo novo vai entrar na empresa, o correto é:',
     '["Instalar primeiro e avaliar os riscos depois de algum tempo de uso", "Analisar os riscos antes da implantação e já prever as medidas de controle necessárias", "Esperar o primeiro incidente para conhecer os riscos reais", "Deixar a avaliação para a próxima revisão anual do PGR"]', 1, 19),

    ('Qual é o papel dos trabalhadores no gerenciamento de riscos?',
     '["Apenas cumprir o que foi definido pela empresa", "Elaborar o inventário de riscos do seu setor", "Aprovar formalmente o plano de ação", "Participar: informar perigos, colaborar na identificação dos riscos e ser consultado sobre as medidas, inclusive por meio da CIPA"]', 3, 20),

    ('Sobre o direito à informação do trabalhador:',
     '["Ele deve conhecer os riscos a que está exposto, as medidas de controle adotadas e os resultados das avaliações e dos seus exames", "Ele tem direito apenas ao resultado do exame admissional", "Ele tem direito apenas ao nome dos produtos que utiliza", "Ele tem direito apenas ao que estiver escrito na ordem de serviço"]', 0, 21),

    ('Onde ficam o inventário de riscos e o plano de ação?',
     '["Arquivados no setor de contabilidade", "Somente com o consultor que os elaborou", "Disponíveis aos trabalhadores, aos seus representantes e à fiscalização", "Guardados em sigilo, por conterem dados da empresa"]', 2, 22),

    ('Além dos riscos do dia a dia, o PGR precisa prever:',
     '["O plano de metas de produção do ano", "O plano de cargos e salários", "O cronograma de férias da equipe", "A preparação para emergências, com as ações a serem tomadas e os recursos necessários"]', 3, 23),

    ('Qual é o objetivo de investigar um acidente de trabalho?',
     '["Encontrar as causas, inclusive as falhas de organização e de gestão, para que o acidente não se repita", "Identificar o culpado e aplicar a punição adequada", "Cumprir a exigência da seguradora", "Definir o valor da indenização devida"]', 0, 24),

    ('Qual é a relação entre o PGR e o PCMSO?',
     '["São documentos independentes, cada um com a sua lógica", "O PCMSO substitui o PGR nas empresas de pequeno porte", "O PGR cuida da saúde e o PCMSO cuida da segurança", "O PCMSO é elaborado a partir dos riscos do inventário, e o que a saúde detecta realimenta o PGR"]', 3, 25),

    ('O exame periódico apontou alteração auditiva em vários trabalhadores do mesmo setor. O que isso significa para o PGR?',
     '["Que os exames precisam ser refeitos em outro laboratório", "Que o controle daquele risco não está sendo eficaz e o plano de ação precisa ser revisto", "Que o problema é individual e deve ser tratado caso a caso", "Que basta reforçar a entrega de protetor auricular"]', 1, 26),

    ('Quando o risco não pode ser eliminado nem suficientemente reduzido pelas medidas coletivas, o que se faz?',
     '["Aceita-se o risco e apenas registra-se no inventário", "Paralisa-se definitivamente a atividade", "Paga-se adicional ao trabalhador exposto", "Adotam-se medidas administrativas e EPI adequado, com treinamento e monitoramento da exposição"]', 3, 27),

    ('A avaliação dos riscos ergonômicos:',
     '["Só é necessária em trabalho de escritório", "Só é feita quando algum trabalhador adoece", "Faz parte do gerenciamento de riscos, com avaliação preliminar e, quando necessário, avaliação mais detalhada", "É substituída pela entrega de cadeira ajustável"]', 2, 28),

    ('Sobre fatores de risco psicossociais, como pressão excessiva por metas e jornada exaustiva:',
     '["Não têm relação com a segurança do trabalho", "Também precisam ser identificados e tratados no gerenciamento de riscos, porque adoecem e aumentam a chance de erro e de acidente", "São assunto exclusivo do setor de recursos humanos", "Só interessam quando já houve afastamento médico"]', 1, 29),

    ('Uma empresa com várias unidades ou frentes de obra deve ter o PGR:',
     '["Contemplando cada unidade ou frente de trabalho, com os perigos e as medidas que existem em cada uma", "Único e igual para todas, sem distinção", "Somente na sede administrativa", "Somente nas unidades com mais de cinquenta trabalhadores"]', 0, 30),

    ('Um trabalhador comunicou um risco e teme sofrer represália. O que se espera da empresa?',
     '["Que exija a comunicação por escrito e assinada para dar andamento", "Que trate o assunto apenas com o supervisor do setor", "Que garanta a comunicação sem retaliação, porque quem tem medo de falar deixa o risco crescer", "Que apure primeiro se a comunicação foi feita de boa-fé"]', 2, 31),

    ('Quais atividades exigem análise de risco específica antes da execução?',
     '["Todas as atividades, todos os dias, sem exceção", "As atividades não rotineiras e aquelas em que a avaliação aponta risco elevado, como serviços especiais e fora do padrão", "Somente as atividades executadas por empresas terceirizadas", "Somente as atividades executadas fora do horário comercial"]', 1, 32),

    ('Para que serve o monitoramento da exposição a agentes como ruído, poeira e produtos químicos?',
     '["Para calcular o adicional de insalubridade", "Para escolher a marca do EPI a comprar", "Para saber se a exposição está controlada e se as medidas continuam funcionando ao longo do tempo", "Para definir o valor do plano de saúde da empresa"]', 2, 33),

    ('Após um acidente grave, o que a empresa deve fazer com o local?',
     '["Liberar o quanto antes para não parar a produção", "Limpar tudo antes da chegada da fiscalização", "Reunir a equipe no local para explicar o ocorrido", "Preservar as condições até a conclusão da análise, salvo quando isso atrapalhar o socorro ou aumentar o risco"]', 3, 34),

    ('O que acontece com o inventário de riscos quando um novo perigo é identificado no setor?',
     '["Ele é atualizado, o risco é avaliado e as medidas entram no plano de ação", "Ele é atualizado somente na revisão anual seguinte", "Ele permanece como está, e o novo perigo é registrado à parte", "Ele é refeito integralmente por outro profissional"]', 0, 35),

    ('A empresa contratou uma consultoria, recebeu o PGR e guardou na gaveta. Isso basta?',
     '["Sim, o importante é ter o documento pronto em caso de fiscalização", "Não: o PGR só cumpre a função quando as medidas são implantadas, acompanhadas e conhecidas por quem trabalha", "Sim, desde que assinado por engenheiro de segurança", "Sim, se a empresa não tiver histórico de acidentes"]', 1, 36),

    ('Sobre as exigências do gerenciamento de riscos conforme o porte e o grau de risco da empresa:',
     '["Toda empresa precisa exatamente do mesmo conjunto de documentos", "As microempresas estão sempre dispensadas de qualquer gerenciamento de risco", "As exigências são graduadas conforme o porte e o grau de risco, mas nenhuma empresa fica livre de identificar e controlar os riscos que existem", "O gerenciamento só passa a ser obrigatório acima de cem empregados"]', 2, 37),

    ('O que fazer quando um trabalhador retorna de afastamento longo por acidente ou doença?',
     '["Recolocar direto na mesma função, porque ele já conhece o serviço", "Aguardar apenas a alta do INSS e nada mais", "Encaminhar automaticamente para outra função", "Realizar o exame de retorno ao trabalho e avaliar se a função e as condições precisam ser adequadas"]', 3, 38),

    ('O que caracteriza um risco classificado como aceitável?',
     '["Aquele em que as medidas já implantadas mantêm a exposição em nível tolerável, e que continua sendo monitorado", "Aquele que a empresa decide não tratar por questão de custo", "Aquele que nunca causou acidente na empresa", "Aquele que atinge um trabalhador só"]', 0, 39),

    ('O procedimento escrito de uma tarefa perigosa serve para:',
     '["Substituir o treinamento do trabalhador", "Definir o passo a passo seguro, os controles e as responsabilidades, e ser treinado e seguido por quem executa", "Cumprir uma formalidade exigida pelo cliente", "Registrar a produtividade esperada da tarefa"]', 1, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-01-INT8';


-- =====================================================================
--  NR-05 — CIPA (questões 11 a 40)
--  Peso maior no funcionamento da comissão: eleição, suplente, ata,
--  inspeção e o que fazer quando o risco apontado não é corrigido. É o
--  que o cipeiro novo mais erra, porque só decorou o mandato e a SIPAT.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-05')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Como acontece a escolha dos representantes dos empregados na CIPA?',
     '["Por indicação do setor de recursos humanos", "Por sorteio entre os interessados", "Por escolha dos encarregados de cada setor", "Por eleição com votação secreta, aberta a todos os empregados, inclusive os de outros turnos"]', 3, 11),

    ('Quem convoca e organiza o processo eleitoral da CIPA?',
     '["A CIPA que está encerrando o mandato", "O empregador, que convoca a eleição com antecedência e divulga o edital a todos os empregados", "O sindicato da categoria", "Uma comissão formada apenas pelos candidatos inscritos"]', 1, 12),

    ('Qualquer empregado pode se candidatar à CIPA?',
     '["Sim: a inscrição é livre, e a empresa não pode impedir nem constranger quem quer se candidatar", "Somente quem tem mais de dois anos de casa", "Somente quem já fez o curso de cipeiro antes", "Somente quem for indicado pela chefia do setor"]', 0, 13),

    ('Qual é o papel do suplente da CIPA?',
     '["Ficar de reserva e só aparecer se a empresa chamar", "Substituir o titular apenas em caso de demissão", "Participar das reuniões e assumir no lugar do titular quando ele falta ou deixa o mandato", "Cuidar apenas da organização da SIPAT"]', 2, 14),

    ('Quando acontece o treinamento dos membros eleitos e designados da CIPA?',
     '["Depois de um ano de mandato, para aproveitar a experiência adquirida", "Antes da posse ou no prazo previsto na norma, durante o expediente e sem custo para o trabalhador", "Somente para o presidente e o vice-presidente", "Apenas quando ocorre um acidente grave na empresa"]', 1, 15),

    ('Em que situação a CIPA se reúne extraordinariamente?',
     '["Sempre que houver troca de chefia no setor", "Quando dois membros faltarem à reunião ordinária", "No mês em que não houver pauta suficiente", "Quando ocorre acidente grave ou fatal, ou quando a situação exige providência imediata"]', 3, 16),

    ('A CIPA apontou um risco e a empresa não corrigiu. O que a comissão deve fazer?',
     '["Interditar o setor por conta própria", "Aguardar a próxima gestão resolver o assunto", "Registrar em ata, insistir junto ao empregador e, persistindo o risco, comunicar as instâncias superiores e o órgão competente", "Comunicar apenas verbalmente ao encarregado do setor"]', 2, 17),

    ('Diante de um risco grave e iminente identificado em inspeção da CIPA, o correto é:',
     '["Solicitar a interrupção imediata da atividade e comunicar o empregador e o SESMT", "Aguardar a reunião mensal para deliberar sobre o caso", "Registrar apenas em relatório fotográfico", "Orientar os trabalhadores a redobrar o cuidado e seguir o serviço"]', 0, 18),

    ('Qual é a diferença entre a CIPA e o SESMT?',
     '["Não existe diferença prática entre os dois", "A CIPA é obrigatória e o SESMT é opcional em qualquer empresa", "O SESMT é eleito pelos trabalhadores e a CIPA é indicada pelo empregador", "A CIPA é paritária, com membros eleitos e designados, e o SESMT é uma equipe técnica dimensionada pelo porte e pelo grau de risco"]', 3, 19),

    ('As reuniões e as atividades da CIPA acontecem:',
     '["Fora da jornada, com pagamento de hora extra", "Durante o horário normal de trabalho, contando como tempo de serviço e sem prejuízo do salário", "Aos sábados, para não parar a produção", "No horário de almoço dos participantes"]', 1, 20),

    ('Uma empresa dispensada de constituir CIPA por causa do porte deve:',
     '["Designar um responsável pelo cumprimento dos objetivos da CIPA e capacitá-lo", "Ficar sem nenhuma ação organizada de prevenção", "Contratar obrigatoriamente um engenheiro de segurança", "Encaminhar o assunto ao sindicato da categoria"]', 0, 21),

    ('Qual documento registra o que foi discutido e decidido em cada reunião da CIPA?',
     '["O relatório de produção do mês", "O calendário anual de treinamentos", "A ata da reunião, assinada pelos participantes e disponibilizada aos interessados", "A ficha de entrega de EPI do setor"]', 2, 22),

    ('Um cipeiro faltou a várias reuniões sem justificativa. O que acontece?',
     '["Nada, porque a participação é voluntária", "Ele pode perder o mandato, e o suplente assume a vaga", "A CIPA é dissolvida e uma nova eleição é convocada", "Ele é advertido e o mandato é prorrogado"]', 1, 23),

    ('Para que serve a inspeção periódica feita pela CIPA nos setores?',
     '["Para avaliar o desempenho dos trabalhadores", "Para conferir apenas a limpeza e a organização", "Para flagrar quem não usa EPI e aplicar advertência", "Para identificar situações de risco no ambiente e nas condições de trabalho e solicitar as correções"]', 3, 24),

    ('Como a CIPA deve tratar uma denúncia de assédio?',
     '["Com sigilo, acolhimento e encaminhamento pelos canais definidos, sem expor quem denunciou", "Divulgando o caso na reunião para todos opinarem", "Encaminhando ao setor de produção do envolvido", "Arquivando até que apareçam testemunhas"]', 0, 25),

    ('O que a CIPA acompanha em relação aos programas da empresa?',
     '["Apenas o pagamento do adicional de periculosidade", "Apenas as compras de material de segurança", "O cumprimento do PGR e do PCMSO, opinando sobre as medidas e cobrando o andamento do plano de ação", "Apenas a distribuição dos uniformes"]', 2, 26),

    ('Quem assume a condução da reunião quando o presidente da CIPA não pode comparecer?',
     '["O membro mais antigo da comissão", "Um representante do setor de recursos humanos", "O secretário da comissão", "O vice-presidente"]', 3, 27),

    ('Qual é a função do secretário da CIPA?',
     '["Presidir as reuniões em que houver empate", "Redigir as atas, organizar a documentação e cuidar da convocação das reuniões", "Representar a comissão perante a fiscalização", "Definir a pauta das reuniões sozinho"]', 1, 28),

    ('Um membro titular eleito pediu demissão da empresa. O que acontece com a vaga?',
     '["A vaga fica aberta até a próxima eleição", "A empresa indica um substituto de sua confiança", "O suplente é convocado para assumir a vaga", "A comissão passa a funcionar com um membro a menos, sem substituição"]', 2, 29),

    ('A CIPA acompanha as estatísticas de acidentes da empresa para:',
     '["Entender onde e por que os acidentes se repetem e priorizar as ações de prevenção", "Comparar o desempenho entre os setores e premiar o melhor", "Justificar a redução do quadro de pessoal", "Apenas preencher o relatório anual da comissão"]', 0, 30),

    ('A empresa cresceu e o número de empregados aumentou bastante. O que muda na CIPA?',
     '["Nada: a composição é sempre a mesma", "O mandato passa a ser de dois anos", "A CIPA é substituída pelo SESMT", "O dimensionamento é revisto, porque o número de membros depende do número de empregados e do grau de risco da atividade"]', 3, 31),

    ('Quando várias empresas atuam no mesmo estabelecimento, as CIPA devem:',
     '["Funcionar isoladamente, cada uma cuidando apenas dos seus empregados", "Implementar ações integradas de prevenção, sob coordenação da empresa contratante", "Formar uma comissão única, dispensando as demais", "Alternar as reuniões entre as empresas, sem pauta comum"]', 1, 32),

    ('Um cipeiro vê um colega executando o serviço sem a proteção adequada. O papel dele é:',
     '["Aplicar advertência disciplinar ao colega", "Retirar o colega da função na hora", "Orientar sobre o risco e, se a situação continuar, registrar e comunicar a chefia e a comissão", "Ignorar, porque cipeiro não manda em ninguém"]', 2, 33),

    ('O quadro de avisos da CIPA no setor serve para:',
     '["Divulgar atas, ações, canais de denúncia e orientações de prevenção a todos os trabalhadores", "Publicar a lista de quem foi advertido no mês", "Expor as metas de produção do setor", "Comunicar apenas as datas das reuniões da diretoria"]', 0, 34),

    ('A empresa pode substituir um representante que ela mesma designou para a CIPA?',
     '["Não, o designado tem a mesma garantia de permanência do eleito", "Sim: os representantes do empregador são designados por ele e podem ser substituídos, respeitada a composição da comissão", "Somente com autorização do sindicato", "Somente ao final do mandato"]', 1, 35),

    ('A participação na CIPA gera pagamento adicional ao trabalhador?',
     '["Sim, gera adicional de função", "Sim, gera adicional de periculosidade", "Sim, gera gratificação prevista na norma", "Não: a atuação acontece dentro da jornada, não gera remuneração extra e não pode causar prejuízo ao salário"]', 3, 36),

    ('O que a CIPA deve fazer com as sugestões e reclamações de segurança trazidas pelos trabalhadores?',
     '["Registrar, levar à reunião, encaminhar ao empregador e dar retorno a quem trouxe a sugestão", "Encaminhar apenas as que vierem por escrito e assinadas", "Guardar para a próxima gestão avaliar", "Repassar diretamente ao órgão de fiscalização"]', 0, 37),

    ('Um trabalhador relata à CIPA que vem sentindo dores relacionadas ao serviço. O encaminhamento correto é:',
     '["Orientar que ele procure médico particular por conta própria", "Deixar o caso apenas com o setor de recursos humanos", "Encaminhar ao serviço médico e pedir a avaliação das condições do posto, porque a queixa pode indicar risco no ambiente", "Solicitar a troca imediata de setor do trabalhador"]', 2, 38),

    ('Os documentos da CIPA, como atas, calendário de reuniões e registros de treinamento, devem ficar:',
     '["Arquivados na empresa, à disposição dos trabalhadores e da fiscalização", "Somente com o presidente da comissão", "Guardados em sigilo pelo setor jurídico", "Descartados ao fim de cada mandato"]', 0, 39),

    ('Qual destas NÃO é atribuição da CIPA?',
     '["Identificar situações de risco e propor medidas de correção", "Participar da análise dos acidentes e acompanhar as ações definidas", "Aplicar punição aos trabalhadores que descumprem as normas", "Divulgar informações de prevenção aos trabalhadores"]', 2, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-05';


-- =====================================================================
--  NR-06 — Uso de EPI (questões 11 a 40)
--  O curso é curto, mas o banco pode ser grande: dá para cobrar escolha
--  do equipamento certo para o risco, vedação, validade e conservação
--  sem repetir a prova antiga, que ficou na obrigação de usar e guardar.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-06')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O EPI foi danificado durante o serviço. Quem providencia a substituição e quando?',
     '["O trabalhador, que compra outro e apresenta a nota", "O almoxarifado, na próxima entrega programada", "A empresa, de imediato, sempre que o equipamento for danificado ou extraviado", "Ninguém: o equipamento é usado até o fim do lote de trabalho"]', 2, 11),

    ('De quem é a responsabilidade pela higienização e pela manutenção periódica do EPI?',
     '["Da empresa, que providencia e orienta como o trabalhador conserva o equipamento no dia a dia", "Do trabalhador, que arca com o custo da limpeza", "Do fabricante, durante o prazo de garantia", "Do setor de compras, uma vez por ano"]', 0, 12),

    ('Para que serve a ficha de entrega de EPI assinada pelo trabalhador?',
     '["Para descontar o valor em folha em caso de perda", "Para registrar qual equipamento foi entregue, quando e a quem, comprovando o fornecimento e as trocas", "Para controlar apenas o estoque do almoxarifado", "Para autorizar o trabalhador a entrar na área de risco"]', 1, 13),

    ('O CA do equipamento está vencido. O que fazer?',
     '["Usar até acabar o estoque, já que o equipamento é novo", "Usar apenas em serviços de curta duração", "Pedir a renovação ao fabricante e continuar usando enquanto isso", "Retirar de uso: equipamento com CA vencido não pode ser fornecido nem usado como EPI"]', 3, 14),

    ('Qual luva usar para manipular um produto químico?',
     '["Qualquer luva de borracha serve para produto químico", "A luva de raspa de couro, que é mais resistente", "A luva do material indicado para aquele produto, conforme a ficha de segurança e o CA correspondente", "A luva de algodão pigmentada, para não escorregar"]', 2, 15),

    ('Sobre o protetor auricular do tipo plug de inserção:',
     '["Precisa ser inserido corretamente no canal do ouvido e mantido limpo, porque mal colocado quase não atenua o ruído", "Basta apoiar na entrada do ouvido", "Pode ser cortado para ficar mais confortável", "Serve para qualquer nível de ruído, independentemente da atenuação"]', 0, 16),

    ('Em serviço de esmerilhamento, qual é a proteção correta para olhos e rosto?',
     '["Somente o protetor facial", "Somente os óculos de segurança", "Óculos escuros comuns e boné", "Óculos de segurança por baixo e protetor facial por cima, porque o protetor sozinho não veda contra partículas"]', 3, 17),

    ('Qual é a diferença entre um respirador para poeira e um para vapores químicos?',
     '["Não existe diferença: mudam apenas o formato e a marca", "Cada um tem o seu elemento filtrante: o filtro mecânico retém partículas e o químico retém gases e vapores, e um não substitui o outro", "O respirador para poeira serve para qualquer risco, se estiver bem vedado", "O respirador para vapores só é usado em ambiente fechado"]', 1, 18),

    ('Antes de entrar na área de risco com o respirador colocado, o trabalhador deve:',
     '["Fazer a checagem de vedação, cobrindo a peça e sentindo se o ar entra pelas bordas", "Molhar a máscara para melhorar o contato com a pele", "Apertar as tiras ao máximo, até marcar o rosto", "Respirar fundo três vezes fora da área para testar o filtro"]', 0, 19),

    ('Sobre a escolha do calçado de segurança:',
     '["Qualquer bota de borracha atende", "A biqueira é dispensável em serviços considerados leves", "Deve seguir o risco do local: biqueira contra impacto, solado antiderrapante, resistência a produto químico ou isolamento elétrico", "Basta que seja fechado e confortável"]', 2, 20),

    ('O creme protetor de pele fornecido pela empresa:',
     '["É um cosmético e não tem relação com segurança do trabalho", "Substitui a luva no contato com produtos químicos", "Pode ser trocado por hidratante comum", "É considerado EPI, tem CA e é indicado conforme o agente ao qual a pele fica exposta"]', 3, 21),

    ('Para o trabalhador que fica exposto ao sol o dia inteiro, o correto é:',
     '["Trabalhar sem camisa nos horários mais quentes para suportar melhor o calor", "Usar vestimenta que cubra a pele, proteção para cabeça e pescoço, protetor solar e pausas na sombra", "Usar apenas óculos escuros", "Acelerar o serviço para terminar antes de o sol esquentar"]', 1, 22),

    ('Em atividade com risco de arco elétrico, a vestimenta correta é:',
     '["A vestimenta antichama certificada, que não propaga a chama nem derrete sobre a pele", "O avental de raspa de couro usado na solda", "Calça e camisa de brim comum, que já são de algodão", "Qualquer vestimenta, desde que usada por baixo do avental"]', 0, 23),

    ('O cinturão de segurança tipo paraquedista:',
     '["Não é EPI, e sim equipamento de proteção coletiva", "Dispensa CA por ser considerado equipamento estrutural", "É EPI, precisa de CA, deve ser inspecionado antes de cada uso e retirado de uso depois de conter uma queda", "Pode voltar ao uso após uma queda, se não houver dano visível"]', 2, 24),

    ('Emprestar o seu EPI para um colega que esqueceu o dele:',
     '["Pode, se for do mesmo tamanho", "Não deve: cada trabalhador usa o seu, por higiene e porque o ajuste é individual", "Pode, se for por pouco tempo", "Pode, desde que o colega devolva no fim do turno"]', 1, 25),

    ('O trabalhador comprou um equipamento parecido em uma loja e quer usar no lugar do fornecido. Isso é correto?',
     '["Sim, se ele preferir o modelo que comprou", "Sim, se for da mesma marca do fornecido", "Sim, desde que avise o encarregado", "Não: o EPI é fornecido pela empresa, precisa ter CA e ser adequado ao risco daquela atividade"]', 3, 26),

    ('Um visitante ou prestador de serviço vai entrar na área de risco. Quem garante o EPI?',
     '["A empresa responsável pela área, que deve exigir e providenciar a proteção adequada para quem entra", "O visitante, que traz o próprio equipamento ou entra por sua conta e risco", "Ninguém, porque a permanência é curta", "O setor de recursos humanos, no momento do agendamento"]', 0, 27),

    ('O EPI entregue ficou grande demais e escorrega durante o serviço. O que fazer?',
     '["Improvisar um ajuste com fita ou barbante", "Continuar usando, porque o importante é estar com o equipamento", "Solicitar a troca pelo tamanho adequado, porque equipamento que não se ajusta não protege", "Usar somente nos momentos de maior risco"]', 2, 28),

    ('Furar o capacete para ventilar, pintar ou colar adesivos nele:',
     '["Pode, se os furos forem pequenos", "Não pode: qualquer alteração compromete a resistência do capacete e invalida a certificação", "Pode, desde que apenas na parte de trás", "Pode, se o capacete já estiver perto do fim da vida útil"]', 1, 29),

    ('Como se sabe se um EPI ainda pode ser usado?',
     '["Pela aparência externa apenas", "Pelo tempo que o trabalhador está com ele", "Pelo preço e pela marca do equipamento", "Pela validade indicada pelo fabricante, pela vigência do CA e pelo estado de conservação verificado na inspeção"]', 3, 30),

    ('Em setor ruidoso onde também é preciso ouvir alarmes e a comunicação da equipe:',
     '["Usa-se sempre o protetor de maior atenuação disponível", "Dispensa-se o protetor para não perder o alarme", "Escolhe-se o protetor com a atenuação adequada ao ruído do local, porque atenuar demais isola o trabalhador e cria outro risco", "Usa-se o protetor somente quando a máquina está ligada"]', 2, 31),

    ('O uniforme comum fornecido pela empresa é EPI?',
     '["Não: uniforme comum é vestimenta de trabalho, e só vira EPI quando é certificado para proteger de um risco específico", "Sim, todo uniforme é considerado EPI", "Sim, desde que tenha o nome da empresa", "Sim, quando é de manga comprida"]', 0, 32),

    ('A máscara descartável PFF2 ficou úmida, suja e amassada. O que fazer?',
     '["Lavar com sabão e usar no dia seguinte", "Secar ao sol e reutilizar", "Continuar usando até o fim da semana", "Descartar e pegar outra, porque máscara descartável úmida ou deformada perde a filtragem e a vedação"]', 3, 33),

    ('Além de fornecer o equipamento, a empresa precisa:',
     '["Apenas registrar a entrega no sistema", "Orientar e treinar sobre uso correto, guarda e conservação, e exigir o uso durante o trabalho", "Apenas repor quando o trabalhador solicitar", "Apenas conferir o CA no momento da compra"]', 1, 34),

    ('A empresa pode cobrar do trabalhador o valor do EPI?',
     '["Pode, quando o equipamento é mais caro", "Pode descontar em folha, mediante autorização assinada", "Não: o fornecimento do equipamento adequado ao risco é gratuito", "Pode, a partir da segunda troca no mesmo ano"]', 2, 35),

    ('Quem define qual EPI é o adequado para cada função?',
     '["A empresa, com base nos riscos identificados e na orientação do SESMT ou de profissional habilitado, ouvida a CIPA", "O próprio trabalhador, conforme o conforto que sentir", "O fornecedor do equipamento", "O encarregado do setor, no dia do serviço"]', 0, 36),

    ('A vestimenta de alta visibilidade, como o colete refletivo, é exigida principalmente:',
     '["Em qualquer atividade administrativa", "Onde há circulação de veículos e equipamentos, trabalho noturno ou serviço em via pública, para que o trabalhador seja visto", "Somente em serviços de solda", "Somente para o supervisor identificar a equipe de longe"]', 1, 37),

    ('A cinta abdominal que alguns trabalhadores usam para levantar peso:',
     '["É EPI e substitui a orientação sobre levantamento correto", "Aumenta a força da coluna e evita hérnia", "Deve ser fornecida pela empresa a todos que carregam carga", "Não é EPI e não protege a coluna: o que protege é reduzir e mecanizar a carga e usar a técnica correta"]', 3, 38),

    ('O trabalhador esqueceu o EPI em casa e o serviço do dia exige o equipamento. O correto é:',
     '["Executar o serviço com mais cuidado", "Pegar emprestado o equipamento do colega do outro turno", "Informar a chefia e não executar a atividade até receber o equipamento", "Executar apenas a metade menos arriscada da tarefa"]', 2, 39),

    ('O supervisor sabe que a equipe não está usando o EPI e não toma providência. Nessa situação:',
     '["Ele também descumpre a norma, porque exigir e fiscalizar o uso é obrigação da empresa e de quem chefia", "A responsabilidade é apenas do trabalhador que não usou", "Não há problema, porque cada um responde por si", "A responsabilidade passa a ser da CIPA"]', 0, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-06';


-- =====================================================================
--  NR-10 — Segurança em eletricidade, básico (questões 11 a 40)
--  A prova antiga cobriu desenergização e socorro. Este bloco vai para o
--  que sustenta aquilo: como a corrente mata, o que cada proteção faz,
--  quando o serviço energizado é admitido e o cuidado com ferramenta,
--  escada, capacitor e rede da concessionária.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-10')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O que a passagem da corrente elétrica pode provocar no corpo humano?',
     '["Somente queimadura de pele no ponto de contato", "Contração muscular que impede soltar o condutor, parada respiratória, fibrilação do coração e queimaduras internas", "Apenas um susto passageiro", "Somente formigamento nos braços"]', 1, 11),

    ('O que determina a gravidade de um choque elétrico?',
     '["Apenas a tensão da instalação", "Apenas a idade do trabalhador", "Apenas o tipo de calçado usado", "A intensidade da corrente, o caminho que ela percorre no corpo e o tempo de contato"]', 3, 12),

    ('O que é o arco elétrico?',
     '["A descarga violenta de energia através do ar, com calor intenso, luz ofuscante, projeção de material e onda de pressão", "O aquecimento normal dos cabos quando estão em carga", "O retorno de energia pelo condutor neutro", "A faísca comum que aparece ao ligar um equipamento"]', 0, 13),

    ('Para que serve o dispositivo diferencial residual, o DR?',
     '["Proteger o equipamento contra sobrecarga", "Estabilizar a tensão da instalação", "Desarmar o circuito quando há fuga de corrente, protegendo a pessoa contra o choque", "Substituir o aterramento da instalação"]', 2, 14),

    ('Qual é a função do aterramento da carcaça de motores, quadros e ferramentas?',
     '["Reduzir o consumo de energia do equipamento", "Escoar a corrente de falta para a terra e permitir que a proteção atue, evitando que a carcaça fique energizada", "Melhorar o rendimento do motor", "Diminuir o ruído elétrico do equipamento"]', 1, 15),

    ('Qual é a diferença entre curto-circuito e sobrecarga?',
     '["No curto-circuito a corrente dispara pelo contato direto entre condutores, e na sobrecarga ela passa do limite por excesso de carga ligada", "Curto-circuito ocorre só em alta tensão e sobrecarga só em baixa tensão", "São o mesmo fenômeno, com nomes diferentes", "Sobrecarga é o que acontece quando falta energia na rede"]', 0, 16),

    ('O que são as zonas de risco e controlada em torno de uma parte energizada?',
     '["Áreas demarcadas apenas para organizar o trânsito de pessoas", "Faixas que indicam a temperatura do equipamento", "Regiões definidas pela altura do painel", "Distâncias definidas em torno da parte energizada: a controlada exige trabalhador autorizado, e a de risco só admite intervenção com procedimento e medidas específicas"]', 3, 17),

    ('Antes de iniciar um serviço em painel elétrico situado em área de circulação, é preciso:',
     '["Apenas fechar a porta da sala", "Apenas avisar o setor pelo rádio", "Isolar e sinalizar a área, delimitando o acesso de quem não participa do serviço", "Apenas organizar as ferramentas no chão"]', 2, 18),

    ('Para que serve o prontuário das instalações elétricas?',
     '["Para registrar as horas trabalhadas pelos eletricistas", "Para reunir os documentos da instalação: esquemas, procedimentos, relação de trabalhadores autorizados, certificados de treinamento e resultados de inspeções", "Para arquivar as notas fiscais do material elétrico", "Para controlar o estoque de peças de reposição"]', 1, 19),

    ('Por que o diagrama unifilar precisa estar atualizado?',
     '["Para facilitar o cálculo da conta de energia", "Para atender a uma exigência do fabricante do quadro", "Para servir de referência apenas em obras novas", "Porque quem vai intervir precisa saber o que alimenta cada circuito, e diagrama desatualizado leva a desligar o circuito errado"]', 3, 20),

    ('Sobre as ferramentas isoladas usadas em serviço elétrico:',
     '["Devem ser próprias para a tensão de trabalho, inspecionadas antes do uso e retiradas se o isolamento estiver danificado", "Basta enrolar fita isolante no cabo da ferramenta comum", "Servem para qualquer tensão, desde que tenham cabo de plástico", "Só são exigidas em serviços de alta tensão"]', 0, 21),

    ('Que tipo de escada deve ser usado em serviços elétricos?',
     '["Qualquer escada firme, desde que apoiada corretamente", "A escada metálica, por ser mais resistente", "Escada isolante, de madeira ou fibra, porque a metálica conduz eletricidade", "A escada extensível, independentemente do material"]', 2, 22),

    ('Uma extensão está com emenda feita de fita isolante e com o pino de terra quebrado. O que fazer?',
     '["Usar apenas em ferramentas pequenas", "Reforçar a fita e continuar usando", "Usar somente em local seco", "Retirar de uso e providenciar a substituição ou o reparo por trabalhador autorizado"]', 3, 23),

    ('Trabalhar em instalação elétrica com as mãos molhadas ou em piso encharcado:',
     '["Não muda nada, se a luva estiver seca", "Aumenta muito o risco, porque a água reduz a resistência do corpo e facilita a passagem da corrente", "É seguro em tensões abaixo de 220 volts", "Só é problema em ambiente externo"]', 1, 24),

    ('De quanto em quanto tempo o treinamento da NR-10 deve ser reciclado?',
     '["A cada dois anos, e também na troca de função, na mudança das instalações ou no retorno de afastamento prolongado", "Uma única vez, sem necessidade de reciclagem", "A cada cinco anos", "Somente quando a empresa trocar de responsável técnico"]', 0, 25),

    ('O que significa ser trabalhador autorizado em serviços com eletricidade?',
     '["Ter concluído qualquer curso técnico da área", "Ter mais de cinco anos de experiência na função", "Ser qualificado, capacitado ou habilitado e ter autorização formal da empresa, com registro e treinamento válido", "Ter recebido a ferramenta e o EPI da empresa"]', 2, 26),

    ('Em que situação a norma admite o trabalho em instalação energizada?',
     '["Sempre que o desligamento causar prejuízo à produção", "Quando o desligamento for tecnicamente inviável ou trouxer risco maior, com procedimento específico, autorização e medidas de controle", "Quando o serviço for rápido e feito por eletricista experiente", "Quando o trabalhador estiver com luva isolante e tapete de borracha"]', 1, 27),

    ('Na instalação do aterramento temporário, a ordem correta é:',
     '["Conectar as fases e depois o cabo de terra", "Conectar tudo ao mesmo tempo, com o bastão isolante", "Conectar somente a fase mais próxima e testar as demais", "Conectar primeiro o cabo de terra e depois as fases, fazendo o caminho inverso na retirada"]', 3, 28),

    ('Por que capacitores e bancos de capacitores exigem cuidado especial mesmo depois de desligados?',
     '["Porque armazenam carga elétrica e precisam ser descarregados e aterrados antes de qualquer contato", "Porque continuam gerando energia por indução", "Porque esquentam sozinhos depois do desligamento", "Porque só podem ser desligados pelo centro de operação"]', 0, 29),

    ('Sobre as portas dos painéis e quadros elétricos:',
     '["Podem ficar abertas para facilitar a ventilação", "Podem ficar abertas quando o serviço é longo", "Devem permanecer fechadas, com acesso restrito a pessoas autorizadas e os circuitos identificados", "Devem ficar abertas para permitir a leitura dos instrumentos"]', 2, 30),

    ('A identificação dos circuitos no quadro elétrico serve para:',
     '["Apenas organizar visualmente o quadro", "Permitir desligar com segurança o circuito certo, sem tentativa e erro e sem desligar o que não precisa", "Facilitar a leitura do consumo de cada setor", "Cumprir uma exigência da companhia de energia"]', 1, 31),

    ('Antes de usar uma furadeira ou esmerilhadeira portátil, o trabalhador deve verificar:',
     '["Apenas se a ferramenta liga", "Apenas o estado do disco ou da broca", "Apenas se o cabo alcança a tomada", "O estado do cabo e do plugue, a existência de aterramento ou duplo isolamento e a integridade da carcaça e das proteções"]', 3, 32),

    ('Encontrou-se um cabo da rede caído na rua depois de um temporal. O que fazer?',
     '["Isolar a área, manter as pessoas afastadas e acionar a companhia de energia, sem tocar no cabo nem em nada encostado nele", "Afastar o cabo com um pedaço de madeira seca", "Verificar com as costas da mão se ele está energizado", "Cobrir o cabo com terra até a chegada da equipe"]', 0, 33),

    ('Depois de afastar com segurança a vítima de um choque elétrico, o que fazer?',
     '["Dar água e deixar a pessoa sentada até melhorar", "Passar pomada nas queimaduras e liberar", "Acionar o socorro, verificar a respiração, iniciar as compressões se necessário e encaminhar ao atendimento mesmo que ela pareça bem", "Levar a pessoa para casa descansar"]', 2, 34),

    ('Por que quem levou choque deve ser avaliado mesmo sem lesão aparente?',
     '["Porque a empresa precisa do registro para o seguro", "Porque a corrente pode ter causado lesão interna e alteração no coração, que aparece horas depois", "Porque a queimadura demora para começar a doer", "Porque ele precisa de atestado para justificar a falta"]', 1, 35),

    ('Serviços próximos a redes da concessionária, como pintura de fachada ou içamento com guindaste, exigem:',
     '["Avaliação prévia, respeito às distâncias de segurança e, quando necessário, desligamento ou isolação combinados com a concessionária", "Apenas atenção redobrada do operador do equipamento", "Apenas a presença de um vigia no solo", "Apenas o uso de luva isolante pelos trabalhadores"]', 0, 36),

    ('Quando o serviço elétrico envolve também altura, umidade ou espaço confinado, o que muda?',
     '["Nada: o risco elétrico é o principal e absorve os demais", "Aplica-se apenas a norma de eletricidade", "O trabalhador escolhe qual risco tratar primeiro", "Os riscos adicionais precisam ser avaliados e controlados junto, aplicando também as normas correspondentes"]', 3, 37),

    ('A análise de risco e a permissão de trabalho em serviço elétrico servem para:',
     '["Formalizar a entrega das ferramentas à equipe", "Registrar o horário de permanência da equipe no local", "Definir antes do início quais são os riscos, as medidas de controle, as responsabilidades e as condições para liberar o serviço", "Substituir o procedimento escrito da tarefa"]', 2, 38),

    ('A luva isolante de borracha usada em serviço elétrico:',
     '["Pode ser usada enquanto não apresentar furo visível", "Tem prazo de ensaio a cumprir, é inspecionada e testada com ar antes do uso e é protegida por sobreluva de couro", "Pode ser substituída por luva de raspa em serviços rápidos", "Dispensa cuidados de guarda, desde que fique limpa"]', 1, 39),

    ('Você encontra um quadro elétrico com partes energizadas expostas, sem a tampa. O que fazer?',
     '["Improvisar uma tampa de papelão para cobrir", "Sinalizar com fita e seguir trabalhando na área", "Trabalhar com atenção redobrada até a manutenção resolver", "Isolar e sinalizar de imediato, comunicar a manutenção e providenciar o fechamento por trabalhador autorizado"]', 3, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-10';


-- a aprovação continua em 70% para todo mundo
update public.trein_curso set nota_minima = 70;

-- Confira quantas perguntas cada curso ficou tendo:
select c.codigo, c.titulo, c.nota_minima, count(q.id) as perguntas
  from public.trein_curso c
  left join public.trein_questao q on q.curso_id = c.id
 group by c.id order by perguntas desc, c.ordem;

-- Confira se a ordem ficou completa de 1 a 40 nos cinco cursos deste arquivo:
select c.codigo, min(q.ordem) as primeira, max(q.ordem) as ultima,
       count(q.id) as total, count(distinct q.ordem) as ordens_distintas
  from public.trein_curso c
  join public.trein_questao q on q.curso_id = c.id
 where c.codigo in ('NR-01-INT4', 'NR-01-INT8', 'NR-05', 'NR-06', 'NR-10')
 group by c.codigo order by c.codigo;
