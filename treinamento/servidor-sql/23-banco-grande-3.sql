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

-- Confira quantas perguntas cada curso tem depois de rodar.
-- O esperado é 150 em cada um, de 1 a 150, sem buraco no meio:
select c.codigo, c.titulo, count(q.id) as perguntas,
       min(q.ordem) as primeira, max(q.ordem) as ultima,
       count(distinct q.ordem) as ordens_distintas
  from public.trein_curso c
  left join public.trein_questao q on q.curso_id = c.id
 where c.codigo in ('NR-06', 'NR-17', 'NR-26', 'LOTO', 'NR-34.5')
 group by c.id order by c.codigo;

-- E confira se a resposta certa está bem espalhada pelos quatro índices.
-- Se algum índice ficar muito acima dos outros, o aluno acerta chutando:
select c.codigo, q.correta, count(*) as quantas
  from public.trein_curso c
  join public.trein_questao q on q.curso_id = c.id
 where c.codigo in ('NR-06', 'NR-17', 'NR-26', 'LOTO', 'NR-34.5')
   and q.ordem between 41 and 150
 group by c.codigo, q.correta
 order by c.codigo, q.correta;
