-- =====================================================================
--  Banco de questões C: NR-20, NR-26, NR-33, NR-34.5 e NR-35-REC
--  30 questões NOVAS por curso, ordem 11 a 40 (150 no total)
--
--  Rode no SQL Editor. Pode rodar mais de uma vez (cada bloco apaga só a
--  faixa 11-40 do seu curso antes de inserir, então não duplica).
--
--  ATENÇÃO: ESTAS PERGUNTAS PRECISAM DA CONFERIDA DO RESPONSÁVEL TÉCNICO
--  ANTES DE VALEREM PARA CERTIFICADO.
--  Foram escritas a partir do conteúdo usual de cada norma e do que se
--  cobra em campo. São coerentes com as normas, mas quem responde pela
--  prova é o responsável técnico — prova errada reprova quem sabe e
--  aprova quem não sabe, e é o certificado dele que está em jogo.
--
--  POR QUE 40 QUESTÕES E NÃO 10
--  ----------------------------
--  A prova sorteia 10 de cada vez. Com dez perguntas cadastradas, todo
--  aluno faz a mesma prova e o gabarito circula na obra em uma semana.
--  Com quarenta, cada um recebe um recorte diferente e a prova volta a
--  medir alguma coisa.
--
--  AS DEZ PRIMEIRAS FICAM
--  ----------------------
--  O delete de cada bloco é limitado a `ordem between 11 and 40`. As
--  questões 1 a 10 continuam onde estavam: as do NR-20 no
--  10-prova-nr20.sql e as dos outros quatro no 12-provas-demais-cursos.sql.
--  Rodar este arquivo não desfaz nem depende daqueles dois.
--
--  NENHUMA REPETE AS DEZ ANTIGAS. Nem com outras palavras: um banco de
--  sorteio com pergunta repetida é um banco menor do que aparenta. Onde
--  o assunto encostava no que já existia, mudou o ângulo — o vigia de
--  fogo do NR-34.5, por exemplo, já tinha questão sobre o que ele faz
--  depois do serviço, então aqui ele aparece pelo que precisa saber
--  antes e pelo que faz quando o fogo começa.
--
--  ATENÇÃO AO CÓDIGO DA NR-35. O treinamento inicial saiu do EaD pela
--  Portaria MTE 1.259/2026 e o curso que está no catálogo é a
--  RECICLAGEM, cujo código na base é 'NR-35-REC'. Bloco escrito com
--  'NR-35' não dá erro: o where não casa com linha nenhuma e o insert
--  grava zero questão em silêncio. Por isso as questões da altura foram
--  escritas com cara de reciclagem — o aluno já fez o inicial
--  presencial — e por isso o arquivo termina com uma consulta que conta
--  as questões dos cinco cursos.
--
--  A COLUNA `correta` É O ÍNDICE, COMEÇANDO EM ZERO
--  Se a resposta certa é a primeira alternativa, `correta` é 0. A posição
--  foi espalhada de propósito pelos quatro índices, em torno de sete ou
--  oito vezes cada, dentro de cada curso.
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
--  NR-20 — Inflamáveis e combustíveis
--  As dez antigas cobriam o básico do fogo e da permissão de trabalho.
--  Estas trinta puxam para o que mata na prática: vapor que se acumula
--  onde ninguém olha, faísca de origem estática e a área classificada
--  onde o celular no bolso vira fonte de ignição.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-20')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O que é preciso para que um incêndio comece?',
     '["Apenas a presença de um líquido inflamável", "Apenas uma faísca, mesmo sem material que possa queimar", "Combustível, oxigênio e uma fonte de calor ao mesmo tempo", "Apenas temperatura ambiente elevada"]', 2, 11),

    ('O que diferencia um líquido combustível de um líquido inflamável?',
     '["O combustível tem ponto de fulgor acima de 60 graus Celsius, ou seja, precisa ser mais aquecido para liberar vapor que pega fogo", "O combustível não pega fogo em nenhuma condição", "O combustível é sempre mais denso que a água", "O combustível só queima quando está dentro de tanque fechado"]', 0, 12),

    ('Houve vazamento de GLP dentro de um galpão. Onde o gás tende a se acumular?',
     '["No teto, porque todo gás sobe", "Espalhado por igual em todo o ambiente", "Junto às janelas, por causa da corrente de ar", "Nas partes baixas, como valas, caixas de passagem e o piso, porque é mais pesado que o ar"]', 3, 13),

    ('O que significa dizer que a mistura de vapor e ar está dentro dos limites de inflamabilidade?',
     '["Que o vapor está diluído demais para queimar", "Que a concentração de vapor no ar está na faixa em que a mistura pega fogo ou explode se encontrar uma fonte de ignição", "Que o ambiente está com pouco oxigênio", "Que o produto perdeu a validade"]', 1, 14),

    ('Por que o caminhão-tanque é aterrado antes do carregamento e da descarga?',
     '["Para escoar a eletricidade estática gerada pelo movimento do produto, que pode gerar faísca e incendiar o vapor", "Para evitar que o veículo saia do lugar", "Para melhorar o funcionamento da bomba", "Para diminuir o desgaste dos pneus"]', 0, 15),

    ('Por que celular e lanterna comuns são proibidos em área classificada?',
     '["Porque atrapalham a comunicação por rádio", "Porque a bateria vaza com o calor", "Porque não são equipamentos protegidos, e a faísca interna pode dar ignição na mistura de vapor e ar", "Porque a tela do aparelho reflete e ofusca o operador"]', 2, 16),

    ('O que é uma área classificada?',
     '["A área onde só entra quem tem crachá especial", "O local onde pode haver mistura inflamável no ar, e onde só se admite equipamento elétrico próprio para esse risco", "A área com o piso pintado de amarelo", "O local reservado para o armazenamento de EPI"]', 1, 17),

    ('Para que serve a bacia de contenção em volta de um tanque de inflamável?',
     '["Para facilitar a lavagem do piso", "Para servir de apoio às escadas de acesso", "Para escoar a água da chuva mais rápido", "Para reter o produto em caso de vazamento e impedir que ele se espalhe pela área e pelo meio ambiente"]', 3, 18),

    ('Estopas e panos sujos de solvente e de óleo devem ser:',
     '["Deixados no chão para secar antes do descarte", "Guardados em uma caixa de papelão no canto da oficina", "Reaproveitados no dia seguinte, para economizar", "Descartados em recipiente metálico com tampa, porque podem se aquecer sozinhos e pegar fogo"]', 3, 19),

    ('O detector portátil de gases precisa de qual cuidado antes do uso?',
     '["Basta ligar e esperar apitar", "Estar com a calibração em dia, passar pelo teste de resposta com gás padrão e ter bateria carregada", "Ser guardado dentro do próprio tanque, para se ambientar", "Ser aquecido ao sol por alguns minutos"]', 1, 20),

    ('Ao perceber um pequeno vazamento de inflamável no piso, a primeira atitude é:',
     '["Interromper a atividade, eliminar as fontes de ignição, isolar a área e comunicar imediatamente", "Varrer o produto para o ralo mais próximo", "Ligar o exaustor e continuar o serviço", "Cobrir com serragem e deixar para o próximo turno"]', 0, 21),

    ('Por que não se usa ar comprimido para empurrar líquido inflamável de um recipiente para outro?',
     '["Porque o ar comprimido gasta muita energia", "Porque a mangueira estoura com facilidade", "Porque o ar pressurizado forma mistura de vapor com oxigênio dentro do recipiente e pode causar explosão", "Porque o produto perde qualidade"]', 2, 22),

    ('Soou o alarme de emergência da unidade. O que o trabalhador faz?',
     '["Termina o serviço em andamento e depois sai", "Interrompe a atividade, deixa o local pela rota de fuga e vai ao ponto de encontro para a conferência das pessoas", "Procura o encarregado antes de tomar qualquer decisão", "Vai até o portão principal buscar informação"]', 1, 23),

    ('Para que serve o simulado de emergência?',
     '["Para cumprir uma exigência de papel", "Para escolher os brigadistas do próximo ano", "Para testar apenas o alarme sonoro", "Para treinar as pessoas na resposta real, medir o tempo de abandono e corrigir as falhas do plano antes da emergência de verdade"]', 3, 24),

    ('Por que ferramentas antifaiscantes são usadas em áreas com inflamáveis?',
     '["Porque duram mais que as de aço", "Porque são mais leves e cansam menos", "Porque não produzem faísca ao bater ou raspar, o que evita a ignição do vapor", "Porque não enferrujam em contato com solvente"]', 2, 25),

    ('Um colega respingou produto inflamável no rosto e nos olhos. O que fazer?',
     '["Levar imediatamente ao chuveiro e lava-olhos de emergência, lavar por bastante tempo e acionar o atendimento médico", "Limpar com pano seco e observar por meia hora", "Aplicar pomada e voltar ao serviço", "Lavar apenas com álcool, para dissolver o produto"]', 0, 26),

    ('Um trabalhador começa a sentir dor de cabeça, tontura e enjoo em área com vapores. Isso pode indicar:',
     '["Exposição aos vapores do produto: ele deve sair para local arejado e ser atendido", "Apenas cansaço do turno, sem relação com o trabalho", "Efeito normal do calor, que passa sozinho", "Falta de café da manhã"]', 0, 27),

    ('Sobre fumar em área de inflamáveis:',
     '["Pode, se for a mais de dez metros do tanque", "Pode, se for dentro do veículo com o vidro fechado", "Pode, se não houver cheiro de produto no ar", "É proibido, e a proibição alcança isqueiro, fósforo e qualquer fonte de ignição levada para a área"]', 3, 28),

    ('Como devem ficar os tambores de inflamável no depósito?',
     '["Empilhados o mais alto possível, para ganhar espaço", "Bem fechados, identificados, em local ventilado, protegidos do sol e afastados de fontes de calor", "Abertos, para o vapor sair aos poucos", "Junto aos cilindros de oxigênio, para centralizar o controle"]', 1, 29),

    ('A ventilação de um depósito de inflamáveis serve para:',
     '["Diminuir o cheiro, por conforto das pessoas", "Evitar mofo nas embalagens", "Impedir o acúmulo de vapor no ambiente e manter a concentração longe da faixa que pega fogo", "Manter a temperatura agradável para quem trabalha"]', 2, 30),

    ('Um veículo precisa entrar na área de inflamáveis. O que a empresa exige?',
     '["Apenas que o motorista tenha crachá", "Apenas que ele ande devagar", "Autorização, rota definida e veículo em condição adequada, com os dispositivos de proteção previstos, como o supressor de faíscas no escapamento", "Apenas que ele desligue o rádio do veículo"]', 2, 31),

    ('A empresa passou a usar um produto inflamável novo no setor. O que muda no treinamento?',
     '["Nada, porque o trabalhador já fez o curso uma vez", "O trabalhador precisa ser capacitado de novo sobre o risco do produto novo, antes de começar a trabalhar com ele", "Basta afixar a informação no mural", "Basta o encarregado explicar quando alguém perguntar"]', 1, 32),

    ('Sobre o vestuário de quem trabalha com inflamáveis:',
     '["Camiseta de malha sintética é preferida, por ser leve", "Qualquer roupa serve, desde que limpa", "A roupa deve ser bem larga, para ventilar melhor", "Deve ser de material que não acumule carga estática nem derreta com o calor, e roupa molhada de produto precisa ser trocada na hora"]', 3, 33),

    ('O que fazer com um extintor depois de usado, mesmo que por poucos segundos?',
     '["Retirar de serviço, encaminhar para recarga e colocar outro no lugar", "Recolocar no suporte, já que ainda tem carga", "Guardar no almoxarifado para usar em treinamento", "Sacudir para redistribuir o pó e devolver ao lugar"]', 0, 34),

    ('Qual é o objetivo de manter desobstruída a área em volta de hidrantes e extintores?',
     '["Facilitar a limpeza do piso", "Manter a aparência organizada do setor", "Cumprir a marcação amarela do piso", "Garantir que o equipamento seja alcançado em segundos: no incêndio, o tempo perdido procurando acesso custa vidas"]', 3, 35),

    ('Há empresa contratada trabalhando na área de inflamáveis. Como fica a informação sobre os riscos?',
     '["A contratante informa os riscos e as regras da instalação, e as duas empresas harmonizam entre si as medidas de prevenção", "Somente a contratada se vira, porque é quem executa", "Somente a contratante responde, e a contratada não precisa de procedimento", "Cada uma cuida dos seus empregados, sem trocar informação"]', 0, 36),

    ('Sobre a inspeção de mangueiras, bombas e conexões usadas na transferência de inflamáveis:',
     '["Basta olhar quando aparecer vazamento visível", "É tarefa exclusiva da manutenção, sem participação de quem opera", "O operador inspeciona antes do uso, e equipamento com trinca, ressecamento ou gotejamento sai de serviço", "Só é necessária depois de um ano de uso"]', 2, 37),

    ('Por que o nível precisa ser acompanhado durante o enchimento de um tanque?',
     '["Porque o produto pode mudar de cor", "Porque o transbordamento espalha produto e vapor pela área e cria risco imediato de incêndio e de contaminação", "Porque a bomba pode consumir mais energia", "Porque o medidor perde a calibração"]', 1, 38),

    ('Um trabalhador percebe uma condição insegura na área de inflamáveis, mas o serviço está atrasado. O que fazer?',
     '["Seguir o serviço e comunicar quando terminar", "Interromper a atividade e comunicar de imediato: diante de risco grave e iminente o trabalhador pode parar", "Resolver por conta própria com o que tiver à mão", "Anotar para tratar na próxima reunião"]', 1, 39),

    ('Sobre a Permissão de Trabalho emitida para uma tarefa em área de inflamáveis:',
     '["Vale para qualquer serviço parecido no mesmo mês", "Pode ser preenchida depois, se o serviço for urgente", "Vale para a tarefa, a área e o prazo definidos, e perde a validade se as condições mudarem ou se houver emergência", "Fica arquivada no escritório e não precisa estar no local do serviço"]', 2, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-20';


-- =====================================================================
--  NR-26 — Sinalização de segurança
--  As dez antigas fecharam vermelho, amarelo, verde, azul e a rotulagem
--  básica. Estas trinta abrem as cores que sobraram, a forma das placas
--  (o círculo proíbe, o triângulo avisa, o retângulo verde salva) e os
--  pictogramas um a um — que é o que o trabalhador vê no rótulo antes
--  de abrir a embalagem.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-26')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('A cor laranja, na sinalização de segurança, é usada para:',
     '["Indicar rotas de fuga", "Assinalar partes móveis e perigosas de máquinas, faces internas de proteções e caixas de dispositivos elétricos", "Delimitar áreas de armazenamento", "Identificar tubulação de água"]', 1, 11),

    ('A cor branca é empregada principalmente para:',
     '["Indicar risco de choque elétrico", "Sinalizar equipamentos de combate a incêndio", "Identificar produtos corrosivos", "Demarcar faixas de circulação, áreas em volta de equipamentos e a localização de coletores de resíduos"]', 3, 12),

    ('Para que serve a faixa zebrada amarela e preta no piso e nas quinas?',
     '["Chamar a atenção para um ponto de risco de tropeço, de impacto ou de passagem de equipamento", "Indicar o caminho até a saída de emergência", "Marcar o local de guarda do EPI", "Indicar área liberada para estacionamento"]', 0, 13),

    ('Uma placa redonda de fundo azul, com desenho branco, significa:',
     '["Proibição", "Advertência de perigo", "Obrigação: indica o que a pessoa é obrigada a fazer ou a usar naquele local", "Localização de equipamento de emergência"]', 2, 14),

    ('Uma placa redonda branca, com borda vermelha e uma barra atravessada, significa:',
     '["Obrigação de usar EPI", "Indicação de saída", "Proibição: o que está desenhado não pode ser feito ali", "Advertência sobre risco elétrico"]', 2, 15),

    ('Uma placa triangular amarela com borda preta serve para:',
     '["Advertir sobre um perigo presente no local, como choque, queda ou material inflamável", "Indicar equipamento de primeiros socorros", "Proibir a entrada de pessoas", "Obrigar o uso do capacete"]', 0, 16),

    ('Placas retangulares verdes com símbolo branco indicam:',
     '["Risco de contaminação", "Áreas em manutenção", "Proibição de fumar", "Salvamento e emergência: saída, rota de fuga, chuveiro lava-olhos e ponto de primeiros socorros"]', 3, 17),

    ('A sinalização de saída de emergência precisa:',
     '["Ser fixada apenas na porta de saída", "Ficar visível, iluminada mesmo com falta de energia, e com o caminho sempre desobstruído", "Ser mudada de lugar conforme o setor for reorganizado", "Ficar dentro do quadro de avisos do setor"]', 1, 18),

    ('No rótulo de um produto químico, a palavra PERIGO, comparada com a palavra ATENÇÃO, indica:',
     '["Um risco mais grave, dentro do mesmo sistema de classificação", "Que o produto é mais caro e exige cuidado no transporte", "Que o produto é de uso exclusivo da manutenção", "Que o produto tem cheiro forte"]', 0, 19),

    ('O pictograma da chama no rótulo indica que o produto:',
     '["Ataca a pele e os metais", "É inflamável e pega fogo com facilidade", "É tóxico se for ingerido", "Está sob pressão"]', 1, 20),

    ('O pictograma que mostra líquido derramando sobre uma mão e sobre uma placa de metal indica:',
     '["Produto oxidante", "Produto explosivo", "Produto corrosivo, que queima a pele e os olhos e ataca metais", "Produto perigoso ao meio ambiente"]', 2, 21),

    ('O pictograma com o desenho de um cilindro indica que o produto:',
     '["É radioativo", "É um resíduo perigoso", "Precisa ser mantido refrigerado", "É gás sob pressão, que pode explodir com o calor ou causar queimadura por frio"]', 3, 22),

    ('O pictograma com a silhueta de uma pessoa e uma estrela no peito alerta para:',
     '["Risco de choque elétrico", "Risco de queda de altura", "Necessidade de exame médico admissional", "Efeitos graves à saúde, como dano a órgãos, sensibilização respiratória ou risco de câncer"]', 3, 23),

    ('O pictograma do peixe com a árvore no rótulo indica:',
     '["Produto de origem natural", "Produto biodegradável, liberado para descarte comum", "Perigo ao meio ambiente: o produto é danoso à vida aquática e não pode ir para o ralo nem para o solo", "Produto próprio para uso em áreas verdes"]', 2, 24),

    ('Onde a Ficha com Dados de Segurança dos produtos precisa estar?',
     '["Arquivada no setor de compras", "Disponível no local de trabalho, em português, ao alcance de quem manuseia o produto", "Guardada apenas com o responsável técnico", "Anexada ao contrato com o fornecedor"]', 1, 25),

    ('O rótulo de um recipiente de produto químico ficou apagado e ilegível. O que fazer?',
     '["Não usar o produto e providenciar a identificação correta antes de qualquer manuseio", "Cheirar para tentar identificar o produto", "Usar assim mesmo, se o pessoal do setor souber o que é", "Passar fita crepe e escrever o setor de destino"]', 0, 26),

    ('A sinalização de segurança pode substituir uma proteção coletiva?',
     '["Sim, quando a proteção for cara", "Não: a sinalização avisa e orienta, mas não elimina nem controla o risco", "Sim, se a placa for grande e bem visível", "Sim, desde que o trabalhador seja treinado"]', 1, 27),

    ('Por que colocar placas demais em um mesmo ponto atrapalha?',
     '["Porque o excesso de informação faz as pessoas pararem de ler, e a placa que realmente importa se perde no meio", "Porque a norma limita o número de placas por metro quadrado", "Porque as placas encarecem a manutenção", "Porque as placas escurecem o ambiente"]', 0, 28),

    ('Um trabalhador retirou uma placa de advertência porque ela atrapalhava a passagem. Isso é:',
     '["Correto, se ele avisar depois", "Correto, se a placa já estiver velha", "Aceitável enquanto durar o serviço", "Errado: a sinalização só é retirada ou alterada pelo responsável, e sem ela o próximo trabalhador fica sem o aviso do risco"]', 3, 29),

    ('Em que idioma a sinalização e os rótulos precisam estar?',
     '["No idioma do fabricante", "Em inglês, por ser o padrão internacional", "Em português, para que quem trabalha entenda o que está escrito", "Tanto faz, porque os símbolos já explicam"]', 2, 30),

    ('O piso ficou molhado após a lavagem no meio do expediente. O correto é:',
     '["Avisar apenas quem estiver por perto", "Esperar secar, sem tomar providência", "Sinalizar com placa de piso molhado e, quando possível, isolar a área até secar", "Passar um pano por cima e liberar a passagem"]', 2, 31),

    ('Sobre a sinalização sonora e luminosa de empilhadeiras e pontes rolantes:',
     '["Serve apenas para chamar a atenção do próprio operador", "Substitui a demarcação do piso", "Pode ser desligada em áreas silenciosas", "Avisa quem está ao redor de que o equipamento está em movimento, e não pode ser desativada nem improvisada"]', 3, 32),

    ('Para que serve a demarcação que separa a rota de pedestres da rota de veículos?',
     '["Manter as pessoas fora da faixa por onde circulam empilhadeiras e outros equipamentos, reduzindo o atropelamento", "Organizar visualmente o setor para a auditoria", "Indicar por onde passam as tubulações", "Delimitar a área de responsabilidade de cada encarregado"]', 0, 33),

    ('O símbolo internacional de radiação ionizante deve ser usado:',
     '["Em qualquer sala com aparelho elétrico", "Nos locais e equipamentos com fonte de radiação, junto com a restrição de acesso", "Apenas em hospitais", "Somente durante a manutenção do equipamento"]', 1, 34),

    ('O símbolo de risco biológico deve estar presente em:',
     '["Recipientes de resíduo com material contaminado e locais de manuseio de agentes biológicos", "Todo lixo do refeitório", "Salas com ar-condicionado", "Vestiários e banheiros"]', 0, 35),

    ('A empresa comprou um produto químico novo. O que precisa acontecer antes do uso?',
     '["Basta guardar no almoxarifado junto com os demais", "Basta lançar no controle de estoque", "Os trabalhadores precisam ser informados sobre os perigos, o rótulo, a ficha de segurança, o EPI necessário e a conduta em emergência", "Basta o encarregado ler a ficha e explicar quando alguém perguntar"]', 2, 36),

    ('Um trabalhador do setor tem dificuldade de leitura. Como a informação de segurança do produto chega até ele?',
     '["Afixando a ficha no mural e considerando o assunto resolvido", "Com orientação e treinamento que garantam a compreensão: a empresa precisa se certificar de que a mensagem foi entendida, e não apenas entregar o papel", "Deixando que o colega mais próximo explique quando houver dúvida", "Trocando o trabalhador de setor para evitar o problema"]', 1, 37),

    ('Uma placa está desbotada pelo sol e quase não se lê. O correto é:',
     '["Deixar como está, porque todos já conhecem o local", "Cobrir com plástico transparente", "Reescrever à mão com caneta", "Substituir a placa: sinalização que não se lê não cumpre a função e ainda passa a falsa sensação de que o risco está avisado"]', 3, 38),

    ('Sobre a sinalização de equipamentos e tubulações que estão em manutenção:',
     '["Basta comunicar a equipe do turno de viva-voz", "Basta desligar a chave geral", "É dispensável quando o serviço é curto", "O equipamento fica sinalizado e identificado como impedido de operar, com a indicação de quem é o responsável"]', 3, 39),

    ('Onde a sinalização de segurança deve ser posicionada?',
     '["Na altura dos olhos, perto do risco ou do equipamento a que se refere, e visível para quem se aproxima", "No mural do refeitório, por onde todos passam", "No escritório do setor, junto dos procedimentos", "Em qualquer parede livre do setor"]', 0, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-26';


-- =====================================================================
--  NR-33 — Espaços confinados
--  As dez antigas já batiam na tecla do resgate improvisado. Estas
--  trinta vão para o que acontece antes da boca do espaço: bloqueio de
--  linha, medição em vários níveis, gás que engana o olfato e o
--  equipamento de retirada que precisa estar montado ANTES de alguém
--  descer. Também entram os riscos que não são de atmosfera: soterramento
--  em silo, agitador que gira e calor.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-33')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Quais são as três funções previstas para a equipe de trabalho em espaço confinado?',
     '["Encarregado, operador e ajudante", "Brigadista, socorrista e motorista", "Técnico de segurança, engenheiro e médico do trabalho", "Supervisor de entrada, vigia e trabalhador autorizado"]', 3, 11),

    ('Como o espaço confinado deve ficar quando ninguém está trabalhando dentro dele?',
     '["Aberto, para ventilar naturalmente", "Fechado, com a entrada travada ou bloqueada e com sinalização informando que é espaço confinado e que a entrada sem autorização é proibida", "Apenas com uma fita amarela na frente", "Com a tampa apoiada, sem travar, para facilitar o acesso da manutenção"]', 1, 12),

    ('Antes da entrada, as tubulações que chegam ao equipamento precisam ser:',
     '["Apenas fechadas pelas válvulas", "Apenas identificadas com etiqueta", "Bloqueadas fisicamente, com raquete ou desconexão, além do bloqueio e travamento das fontes de energia", "Deixadas como estão, se o processo estiver parado"]', 2, 13),

    ('Por que a atmosfera precisa ser medida em vários níveis do espaço confinado?',
     '["Porque cada gás se acumula em uma altura diferente: uns são mais pesados e ficam no fundo, outros sobem", "Porque o aparelho precisa ser testado várias vezes seguidas", "Porque a temperatura muda com a altura", "Porque a norma exige três medições por hora"]', 0, 14),

    ('Um trabalhador vai apenas colocar a cabeça dentro do tanque para dar uma olhada. Isso é:',
     '["Permitido, porque o corpo fica do lado de fora", "Considerado entrada em espaço confinado, e exige todos os requisitos, inclusive a medição e a permissão", "Permitido, se ele prender a respiração", "Permitido, se durar menos de um minuto"]', 1, 15),

    ('O gás sulfídrico tem cheiro de ovo podre. Por que não se pode confiar no olfato para detectá-lo?',
     '["Porque o cheiro só aparece em concentração muito alta", "Porque o cheiro se confunde com o de esgoto", "Porque em concentração perigosa ele paralisa o olfato, e a pessoa deixa de sentir o cheiro achando que o ar melhorou", "Porque o cheiro depende da umidade do ar"]', 2, 16),

    ('O monóxido de carbono é perigoso em espaço confinado porque:',
     '["Não tem cor nem cheiro, se acumula sem aviso e impede o sangue de transportar oxigênio", "Tem cheiro forte que incomoda muito", "Só aparece em ambientes com produtos químicos", "É visível como uma fumaça branca"]', 0, 17),

    ('Um gerador ou uma máquina com motor a combustão pode ficar trabalhando junto à boca do espaço confinado?',
     '["Pode, desde que fique a menos de dois metros, para facilitar", "Pode, se o motor for novo", "Pode, se houver um ventilador ligado", "Não: o escapamento libera monóxido de carbono, que entra no espaço e pode matar quem está lá dentro"]', 3, 18),

    ('A concentração de oxigênio medida foi de 24%. O que isso significa?',
     '["Está ótima, quanto mais oxigênio melhor", "Está dentro da faixa segura de entrada", "Está acima do permitido: o excesso de oxigênio deixa os materiais muito mais fáceis de pegar fogo", "O aparelho está com defeito, porque esse valor não existe"]', 2, 19),

    ('Pode-se usar oxigênio de cilindro para ventilar um espaço confinado?',
     '["Pode, se for por pouco tempo", "Pode, se o espaço estiver com pouco ar", "Pode, se a mangueira estiver em bom estado", "Nunca: a atmosfera enriquecida com oxigênio provoca incêndio violento com qualquer faísca"]', 3, 20),

    ('O que precisa estar pronto ANTES de o trabalhador entrar no espaço confinado?',
     '["Apenas o extintor no local", "Os meios de resgate e a equipe preparada para agir de fora, sem que ninguém precise entrar sem proteção", "O relatório de encerramento do serviço", "A escala do turno seguinte"]', 1, 21),

    ('Para que serve o tripé com guincho montado na boca do espaço confinado?',
     '["Permitir a retirada do trabalhador de fora, sem que ninguém precise entrar no ambiente perigoso", "Descer as ferramentas com mais facilidade", "Sustentar a iluminação do local", "Apoiar a mangueira de ventilação"]', 0, 22),

    ('A comunicação entre o vigia e quem está dentro deve ser:',
     '["Contínua e combinada antes da entrada, por voz, rádio ou sinais, de modo que a perda de contato seja tratada como emergência", "Feita apenas na entrada e na saída", "Feita a cada uma hora", "Dispensável quando o serviço é rápido"]', 0, 23),

    ('Por que a iluminação usada dentro do espaço confinado precisa ser apropriada?',
     '["Para economizar energia", "Para não atrapalhar a visão do vigia", "Para durar o turno inteiro sem troca de lâmpada", "Porque em ambiente úmido e com possível vapor inflamável a luminária comum pode dar choque ou provocar ignição"]', 3, 24),

    ('Um trabalhador dentro do espaço começou a sentir tontura e falta de ar. O que deve acontecer?',
     '["Ele descansa sentado ali mesmo por alguns minutos", "Ele avisa e termina o serviço com mais calma", "Ele sai imediatamente, o serviço é interrompido e a atmosfera é reavaliada antes de qualquer nova entrada", "O vigia entra para ajudá-lo a levantar"]', 2, 25),

    ('Trabalho a quente dentro de espaço confinado exige:',
     '["Apenas o extintor por perto", "As medidas do espaço confinado somadas às do trabalho a quente, com monitoramento contínuo da atmosfera e liberação específica", "Apenas a ventilação ligada", "Apenas a presença do supervisor no local"]', 1, 26),

    ('O que é o risco de engolfamento em silos e moegas?',
     '["O risco de o trabalhador escorregar na parede interna", "O risco de a estrutura desabar sobre o equipamento", "O risco de o produto queimar por atrito", "O risco de o material solto se comportar como areia movediça e soterrar o trabalhador em segundos"]', 3, 27),

    ('Antes de entrar em um tanque que armazenou produto químico, é preciso lembrar que:',
     '["O lodo e o resíduo de fundo continuam liberando gás, principalmente quando são mexidos durante a limpeza", "Tanque vazio não oferece risco algum", "Basta enxaguar com água para eliminar o risco", "O risco acaba depois de 24 horas com a tampa aberta"]', 0, 28),

    ('Agitadores, roscas e pás existentes dentro do equipamento precisam ser:',
     '["Deixados no automático, para não perder o ajuste", "Bloqueados e travados, com a energia dissipada e a partida testada, antes de qualquer entrada", "Apenas desligados no painel", "Girados manualmente, para conferir se estão livres"]', 1, 29),

    ('A capacitação para trabalho em espaço confinado deve ser:',
     '["Feita uma única vez na vida do trabalhador", "Feita apenas quando a empresa muda de ramo", "Inicial e periódica, e refeita quando mudam os procedimentos, os equipamentos ou quando o desempenho mostrar necessidade", "Feita somente por quem for supervisor de entrada"]', 2, 30),

    ('Como se controla quem está dentro do espaço confinado?',
     '["Pela memória do vigia", "Pelo registro de entrada e saída de cada pessoa, de modo que se saiba a qualquer momento quantas e quem está lá dentro", "Pela lista de presença do treinamento", "Pelo crachá deixado na portaria"]', 1, 31),

    ('Um trabalhador pode entrar sozinho em espaço confinado quando o serviço é simples?',
     '["Não: sempre é preciso o vigia do lado de fora e o supervisor responsável pela liberação", "Pode, se ele levar o rádio", "Pode, se o serviço durar menos de meia hora", "Pode, se ele for o mais experiente da equipe"]', 0, 32),

    ('Sobre o detector de gases durante a execução do serviço:',
     '["Basta a medição feita antes da entrada", "Basta medir de novo depois do almoço", "A atmosfera é monitorada continuamente, porque as condições mudam durante o trabalho", "O aparelho fica sempre com o vigia, do lado de fora"]', 2, 33),

    ('Uma empresa contratada vai executar serviço em espaço confinado do cliente. Quem cuida do quê?',
     '["A contratada resolve tudo sozinha, porque conhece o serviço", "A contratante libera e a contratada não precisa de procedimento próprio", "Cada uma cuida da sua parte, sem trocar informação", "A contratante informa os riscos e as condições do espaço, e as duas ajustam entre si as medidas e a resposta a emergências"]', 3, 34),

    ('Depois de encerrado o serviço, a permissão de entrada e trabalho:',
     '["Pode ser descartada", "Fica com o trabalhador que executou", "É encerrada formalmente e arquivada pela empresa pelo prazo previsto, servindo de registro do que foi feito", "Continua valendo para a próxima entrada no mesmo equipamento"]', 2, 35),

    ('A ventilação forçada deve ser posicionada de modo a:',
     '["Soprar direto no rosto do trabalhador, para refrescar", "Renovar o ar de todo o espaço, inclusive dos cantos e do fundo, sem puxar de volta o ar contaminado que sai", "Ficar desligada durante a medição", "Empurrar o ar apenas na boca do espaço"]', 1, 36),

    ('Por que a empresa precisa manter identificados e cadastrados os espaços confinados do estabelecimento?',
     '["É uma exigência da contabilidade", "Serve para calcular o número de brigadistas", "Ajuda no controle do patrimônio", "Porque sem identificar e sinalizar cada espaço, alguém acaba entrando sem saber que aquele local é um espaço confinado"]', 3, 37),

    ('Calor excessivo dentro do espaço confinado exige:',
     '["Revezamento, pausas, hidratação e acompanhamento das condições do trabalhador", "Apenas um ventilador ligado no rosto", "Apenas roupa mais leve", "Trabalhar mais rápido, para sair antes"]', 0, 38),

    ('O respirador com linha de ar usado no espaço confinado precisa:',
     '["Ter a fonte de ar limpa, posicionada longe de contaminantes, e reserva de ar suficiente para a saída em emergência", "Ser ligado ao compressor mais próximo, qualquer que seja", "Ser compartilhado entre os trabalhadores, para economizar", "Funcionar apenas enquanto durar a bateria do detector"]', 0, 39),

    ('Qual é a atitude correta de quem está de vigia e precisa ir ao banheiro?',
     '["Pedir para o trabalhador sair rapidinho e voltar depois", "Não deixar o posto sem que outro vigia capacitado assuma o lugar, e parar o serviço se isso não for possível", "Avisar por rádio e ir, se demorar pouco", "Pedir a qualquer colega da área para olhar a boca do espaço"]', 1, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-33';


-- =====================================================================
--  NR-34.5 — Trabalho a quente
--  As dez antigas cuidaram da permissão, do vigia e do fogo. Estas
--  trinta cobram o que adoece e o que fere no dia a dia do soldador:
--  fumo metálico, radiação do arco, choque na solda elétrica, cilindro
--  deitado, óleo em válvula de oxigênio e disco de esmerilhadeira. E a
--  faísca, que ninguém acompanha depois que sai de perto da peça.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-34.5')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Por que os fumos de solda são um risco à saúde?',
     '["São partículas e gases finos que entram nos pulmões e podem causar doença respiratória e intoxicação ao longo do tempo", "Apenas incomodam a visão do soldador", "Só oferecem risco quando se solda alumínio", "Só fazem mal quando o cheiro está forte"]', 0, 11),

    ('Qual é a medida mais eficaz contra os fumos de solda em ambiente fechado?',
     '["Abrir a porta e trabalhar mais rápido", "Usar uma máscara de tecido", "Exaustão localizada junto ao ponto de solda, retirando o fumo antes que ele chegue à respiração do trabalhador", "Ligar um ventilador soprando nas costas do soldador"]', 2, 12),

    ('O que provoca o chamado olho de solda?',
     '["A poeira do esmerilhamento", "A radiação ultravioleta do arco elétrico, que queima a superfície do olho e dói horas depois", "O calor da peça recém-soldada", "O reflexo do sol na chapa"]', 1, 13),

    ('Para que servem os biombos e as cortinas de proteção no serviço de solda?',
     '["Para dividir o espaço entre as equipes", "Para segurar as peças em posição", "Para reduzir o ruído do esmeril", "Para impedir que a radiação do arco atinja os olhos de quem trabalha ou passa por perto"]', 3, 14),

    ('O soldador está com a roupa encharcada de suor e o piso molhado. Qual é o risco na solda elétrica?',
     '["Não há risco, porque a solda trabalha em baixa tensão", "Apenas o risco de resfriado", "Apenas a perda de qualidade do cordão de solda", "O risco de choque aumenta muito, porque a umidade reduz a isolação do corpo e dos equipamentos"]', 3, 15),

    ('Onde deve ser fixado o cabo de retorno, o chamado terra, da máquina de solda?',
     '["Diretamente na peça que será soldada, o mais próximo possível do ponto de trabalho", "Em qualquer estrutura metálica do galpão", "Na tubulação de água mais próxima", "No andaime em que o soldador está apoiado"]', 0, 16),

    ('O porta-eletrodo está com o isolamento rachado. O que fazer?',
     '["Enrolar com fita isolante comum e usar até o fim do serviço", "Usar apenas com luva de raspa", "Retirar de uso e substituir, porque a falha de isolamento expõe o soldador ao choque", "Usar somente em serviços curtos"]', 2, 17),

    ('Por que não se deve deitar um cilindro de acetileno?',
     '["Porque a válvula pode quebrar com o peso", "Porque o acetileno fica dissolvido em uma massa porosa com acetona, e deitado o cilindro pode liberar acetona junto com o gás", "Porque o gás esfria e perde pressão", "Porque a marcação do cilindro fica ilegível"]', 1, 18),

    ('Um cilindro chegou deitado no caminhão. O que fazer antes de usar?',
     '["Usar normalmente, já que o gás é o mesmo", "Colocar em pé e deixar em repouso pelo tempo indicado antes de abrir a válvula", "Rolar até o local de uso e conectar", "Aquecer levemente, para estabilizar a pressão"]', 1, 19),

    ('Por que é proibido usar óleo ou graxa nas válvulas e conexões de oxigênio?',
     '["Porque sujam a mangueira", "Porque dificultam o aperto da conexão", "Porque atacam a borracha da mangueira", "Porque óleo em contato com oxigênio sob pressão pode inflamar de forma violenta"]', 3, 20),

    ('Pode-se usar o jato de oxigênio para limpar a roupa ou refrescar o ambiente?',
     '["Nunca: a roupa fica saturada de oxigênio e qualquer faísca provoca queimadura grave e incêndio", "Pode, se for rápido e longe do maçarico", "Pode, apenas para tirar a poeira do rosto", "Pode, se a pressão estiver baixa"]', 0, 21),

    ('Houve retrocesso de chama no maçarico. Qual é a conduta?',
     '["Aumentar a vazão de oxigênio para empurrar a chama de volta", "Bater no maçarico para desentupir o bico", "Fechar as válvulas conforme o procedimento, afastar-se e só voltar a usar o conjunto depois da inspeção", "Mergulhar o bico na água e continuar"]', 2, 22),

    ('Sobre as mangueiras do conjunto de oxiacetileno:',
     '["Emenda com arame e abraçadeira improvisada é aceitável", "Podem passar sobre peças quentes, se estiverem novas", "Devem estar íntegras, com conexões apropriadas, protegidas do trânsito e dos respingos, e sem emenda improvisada", "Podem ser trocadas entre o oxigênio e o gás combustível, porque são iguais"]', 2, 23),

    ('Por que a área abaixo e ao redor do trabalho a quente precisa ser isolada?',
     '["Para deixar espaço para as ferramentas", "Porque respingo, escória e faísca caem e ricocheteiam, atingindo pessoas e material combustível a vários metros de distância", "Para evitar que estranhos vejam o serviço", "Para reduzir o eco do esmerilhamento"]', 1, 24),

    ('Ralos, frestas, aberturas de piso e passagens de cabo perto do serviço a quente devem ser:',
     '["Deixados abertos, para ventilação", "Marcados com giz e ignorados", "Molhados apenas no início do serviço", "Vedados com manta ou material resistente ao fogo, para a faísca não alcançar o nível de baixo nem áreas com combustível"]', 3, 25),

    ('Se o alarme de emergência da unidade tocar durante um trabalho a quente, o correto é:',
     '["Interromper o serviço, deixar tudo em condição segura, fechar as válvulas e sair pela rota de fuga", "Terminar o cordão de solda que estava em andamento", "Aguardar a autorização do vigia para parar", "Continuar, porque o alarme pode ser de outra área"]', 0, 26),

    ('Sobre o disco da esmerilhadeira:',
     '["Deve estar dentro da validade, sem trinca, com rotação compatível com a máquina, e disco de corte não serve para desbaste", "Pode ser usado trincado, se a rotação for reduzida", "Serve para corte e desbaste indistintamente", "A proteção pode ser retirada quando atrapalha o acesso"]', 0, 27),

    ('Por que os óculos de segurança são usados por baixo da máscara de solda?',
     '["Para melhorar a visão do cordão", "Porque a máscara é levantada na hora de picotar a escória, e é nesse momento que o fragmento quente atinge o olho", "Porque a máscara embaça com facilidade", "Porque a norma exige dois EPI no rosto"]', 1, 28),

    ('A máscara de solda com escurecimento automático precisa:',
     '["Apenas estar limpa", "Apenas estar no grau mais escuro possível", "Ser testada antes do uso, porque bateria fraca ou sensor sujo deixam o filtro claro no momento da abertura do arco", "Ser guardada ligada, para manter a carga"]', 2, 29),

    ('Peças recém-soldadas ou cortadas devem ser:',
     '["Jogadas em qualquer local afastado", "Resfriadas com a mão protegida por luva de algodão", "Deixadas no caminho, para esfriar mais rápido", "Sinalizadas ou isoladas, porque peça quente não muda de cor e queima quem encosta sem saber"]', 3, 30),

    ('A escória e os restos quentes do serviço devem ser:',
     '["Varridos para o canto do galpão", "Colocados no lixo comum ao fim do turno", "Deixados no piso até o dia seguinte", "Recolhidos em recipiente metálico próprio, depois de resfriados, longe de material combustível"]', 3, 31),

    ('O que o vigia de fogo faz se aparecer um foco de incêndio?',
     '["Corre para chamar o encarregado e volta depois", "Espera o soldador terminar o cordão, para não perder a peça", "Interrompe o serviço, atua com o extintor no princípio de incêndio e aciona o alarme e a brigada", "Joga água sobre qualquer tipo de foco"]', 2, 32),

    ('O vigia de fogo precisa ser:',
     '["Capacitado para a função, saber usar o extintor e o meio de alarme, e ficar dedicado só a isso durante o serviço", "Qualquer ajudante que estiver livre no momento", "O próprio soldador, revezando a atenção", "O encarregado da obra, por ser o responsável"]', 0, 33),

    ('O serviço a quente vai ser feito em altura, sobre andaime. O que muda?',
     '["Nada muda, porque o risco de fogo é o mesmo", "Somam-se as exigências do trabalho em altura, e é preciso proteger cinto, talabarte e cordas do respingo de solda", "Basta subir o extintor junto", "Basta o vigia ficar embaixo"]', 1, 34),

    ('Um cinto ou talabarte recebeu respingo de solda. O que fazer?',
     '["Escovar a marca e continuar usando", "Retirar de uso: a fita queimada perde resistência e pode romper na queda", "Usar apenas em serviços de altura menor", "Cobrir a marca com fita e seguir"]', 1, 35),

    ('O serviço a quente vai durar dez minutos apenas. A permissão de trabalho é necessária?',
     '["Sim: o tempo curto não reduz o risco, e boa parte dos incêndios começa em serviço rápido feito sem liberação", "Não, se o encarregado autorizar de viva-voz", "Não, se houver extintor no local", "Somente se o serviço for dentro de área classificada"]', 0, 36),

    ('Ao encerrar o trabalho a quente, antes de deixar o local, é preciso:',
     '["Apenas desligar a máquina de solda", "Apenas recolher as ferramentas", "Apenas avisar a portaria", "Fechar as válvulas dos cilindros, aliviar as mangueiras, desligar os equipamentos e inspecionar a área e os níveis vizinhos em busca de brasa ou fumaça"]', 3, 37),

    ('Por que a última hora do expediente é um momento crítico no trabalho a quente?',
     '["Porque o soldador cansado erra o cordão", "Porque a energia elétrica oscila no fim do dia", "Porque o serviço encerrado às pressas deixa a área sem observação, e o foco iniciado por uma faísca só cresce depois que todo mundo foi embora", "Porque a portaria fecha e ninguém consegue sair"]', 2, 38),

    ('Pintura, solvente ou produto químico aplicado há pouco tempo perto do local do serviço a quente:',
     '["Não interfere, porque a tinta seca rápido", "Ajuda, porque a tinta protege a chapa", "Impede a liberação do serviço até que os vapores tenham sido eliminados e a área tenha sido avaliada de novo", "Só importa se o cheiro estiver muito forte"]', 2, 39),

    ('Antes de soldar em uma tubulação ou equipamento de processo, é preciso:',
     '["Apenas fechar a válvula mais próxima", "Apenas avisar a sala de controle", "Apenas esvaziar o trecho da tubulação", "Confirmar que a linha foi despressurizada, drenada, limpa, bloqueada e liberada por escrito, porque resíduo e pressão dentro da linha explodem com o calor"]', 3, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-34.5';


-- =====================================================================
--  NR-35-REC — Trabalho em altura (reciclagem)
--
--  O CÓDIGO É 'NR-35-REC', E NÃO 'NR-35'. O inicial saiu do EaD pela
--  Portaria MTE 1.259/2026 (ver 07-nr35-somente-reciclagem.sql) e quem
--  está no catálogo é a reciclagem. Bloco escrito com 'NR-35' não dá
--  erro nenhum: o where não casa, o insert grava zero linha e o curso
--  fica sem prova sem ninguém perceber. Por isso a consulta do fim do
--  arquivo confere a contagem.
--
--  O ALUNO DAQUI JÁ FEZ O INICIAL PRESENCIAL. Nenhuma questão pergunta
--  o que é trabalho em altura ou para que serve um cinto. A reciclagem
--  cobra o que enferruja com o tempo: inspeção e descarte do cinto e do
--  talabarte, escolha e conferência da ancoragem, fator de queda e zona
--  livre, análise de risco e permissão de trabalho da tarefa, condição
--  que impede o serviço, e o resgate de quem ficou pendurado.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'NR-35-REC')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Qual é a ordem correta das medidas contra a queda de altura?',
     '["Entregar o cinto e liberar o serviço", "Usar o cinto e, se sobrar tempo, instalar guarda-corpo", "Primeiro evitar o trabalho em altura, depois usar proteção coletiva como o guarda-corpo e, quando não for possível, o sistema de retenção de queda", "Escolher a medida mais barata para a obra"]', 2, 11),

    ('O que é o fator de queda?',
     '["O peso máximo que o cinto suporta", "O número de vezes que o equipamento já foi usado", "A altura do prédio dividida pelo número de pavimentos", "A relação entre a distância percorrida na queda e o comprimento do talabarte: quanto mais alto o ponto de ancoragem, menor o fator e menor o impacto sobre o corpo"]', 3, 12),

    ('O que é a zona livre de queda?',
     '["O espaço que precisa existir abaixo do trabalhador para que ele seja freado antes de bater no piso ou em um obstáculo", "A área isolada no chão para a passagem de pedestres", "A distância mínima entre dois trabalhadores na mesma estrutura", "O espaço lateral entre a fachada e o andaime"]', 0, 13),

    ('Ao mudar de ponto de ancoragem durante o deslocamento em altura, como o trabalhador evita ficar desconectado?',
     '["Solta e prende depressa, com atenção no apoio dos pés", "Com o talabarte duplo, em Y: uma das pontas fica presa enquanto a outra é movida para o ponto seguinte", "Segurando firme na estrutura com as duas mãos enquanto troca o gancho", "Pedindo para um colega segurar o cinto durante a troca"]', 1, 14),

    ('Sobre os conectores e mosquetões:',
     '["Devem ter trava dupla, ser inspecionados, e nunca ser conectados um no outro nem em posição que force a trava", "Podem ser substituídos por argola de aço comum", "Podem ficar sem trava se o trabalho for rápido", "Podem ser conectados em qualquer parte da fita do cinto"]', 0, 15),

    ('Qual é a diferença entre o talabarte de posicionamento e o sistema de retenção de queda?',
     '["Não existe diferença prática", "O de posicionamento serve para manter o trabalhador apoiado enquanto trabalha, e não foi feito para frear uma queda, que exige o sistema de retenção", "O de posicionamento é usado somente acima de 10 metros", "O de retenção só pode ser usado em andaime"]', 1, 16),

    ('A linha de vida horizontal instalada na obra precisa:',
     '["Ser esticada por quem for usar, com o material que houver à mão", "Ser sempre de corda de nylon comum", "Suportar quantas pessoas forem necessárias no dia", "Ter projeto de profissional legalmente habilitado, com pontos, carga e número máximo de usuários definidos"]', 3, 17),

    ('Para subir uma escada tipo marinheiro com linha de vida vertical, usa-se:',
     '["Um talabarte comum amarrado no degrau", "As duas mãos livres, sem qualquer conexão", "O trava-quedas conectado ao cabo ou à corda, acompanhando o trabalhador na subida e travando na queda", "O cinto conectado à própria escada"]', 2, 18),

    ('Como o cinto tipo paraquedista deve ser ajustado?',
     '["Bem folgado, para dar liberdade de movimento", "Apertado somente na cintura", "Com a tira do peito solta, para respirar melhor", "Firme no corpo, com as fitas das pernas e do peito ajustadas e o ponto de conexão dorsal centralizado nas costas"]', 3, 19),

    ('Ao trabalhar em plataforma elevatória, onde o trabalhador conecta o talabarte?',
     '["Em uma estrutura fixa do prédio, ao lado da cesta", "No guarda-corpo da cesta, que é o ponto mais alto", "No ponto de ancoragem próprio da cesta, indicado pelo fabricante", "Em qualquer barra da cesta, desde que pareça resistente"]', 2, 20),

    ('Sobre subir no guarda-corpo da cesta ou usar caixote para alcançar mais alto:',
     '["Pode, se outro colega segurar", "É proibido: a plataforma foi projetada para o trabalhador com os pés no piso da cesta, e subir anula a proteção", "Pode, se o serviço for rápido", "Pode, desde que o cinto esteja conectado"]', 1, 21),

    ('No andaime suspenso, o chamado balancim, o trava-quedas do trabalhador deve estar conectado:',
     '["A um cabo de segurança independente, ancorado na estrutura do prédio, e não no próprio balancim", "Ao cabo de sustentação do balancim", "Ao guarda-corpo do próprio equipamento", "À catraca do sistema de subida"]', 0, 22),

    ('Ao trabalhar sobre telhado com telhas frágeis, o correto é:',
     '["Pisar somente sobre as telhas, distribuindo o peso", "Usar tábuas ou passarelas apoiadas na estrutura, além do sistema de retenção de queda devidamente ancorado", "Andar rápido, para não concentrar o peso", "Andar agachado, para reduzir o esforço sobre a telha"]', 1, 23),

    ('Como as ferramentas devem ser levadas e mantidas em altura?',
     '["Presas com cordão ou talabarte de ferramenta, guardadas em bolsa própria, e com a área abaixo isolada e sinalizada", "Nos bolsos da calça, para deixar as mãos livres", "Apoiadas na borda da estrutura, ao alcance da mão", "Jogadas de baixo para cima pelo ajudante"]', 0, 24),

    ('Começou vento forte e caiu um raio perto da obra. O que fazer com o serviço em altura?',
     '["Continuar, desde que todos estejam ancorados", "Continuar apenas nos pontos protegidos por cobertura", "Interromper a atividade e descer, retomando somente quando as condições permitirem com segurança", "Amarrar melhor os materiais e seguir"]', 2, 25),

    ('Um cinto foi usado por um trabalhador que sofreu queda e ficou suspenso. Depois do resgate, o que se faz com o equipamento?',
     '["Guardar para usar apenas em serviços mais baixos", "Lavar e devolver ao almoxarifado", "Usar novamente, se não houver corte visível", "Retirar de uso definitivamente, porque o conjunto absorveu o impacto e pode não resistir a outra queda"]', 3, 26),

    ('Como o cinto e as cordas devem ser guardados?',
     '["Dentro da caixa de ferramentas, junto com o material do dia", "Pendurados no sol, para secarem mais rápido", "Limpos e secos, em local ventilado, longe do sol, do calor, da umidade e de produtos químicos e solventes", "Enrolados no porta-malas do veículo"]', 2, 27),

    ('O que precisa existir ANTES de começar o trabalho em altura, e não depois do acidente?',
     '["O plano de resgate, com os meios e as pessoas preparadas para tirar rapidamente quem ficar suspenso", "A lista de presença do treinamento assinada", "O contrato do serviço aprovado", "A conferência dos crachás da equipe"]', 0, 28),

    ('Após o resgate de um trabalhador que ficou vários minutos suspenso pelo cinto, o cuidado é:',
     '["Colocá-lo de pé e mandar caminhar, para ativar a circulação", "Deitá-lo depressa e deixá-lo sozinho descansando", "Dar água gelada e liberar para casa", "Mantê-lo sob avaliação e encaminhar ao atendimento médico, mesmo que ele diga que está bem"]', 3, 29),

    ('Trabalho em altura próximo a rede elétrica energizada exige:',
     '["Apenas atenção redobrada do trabalhador", "Manter a distância de segurança, ou providenciar o desligamento e a isolação da rede, com avaliação prévia do risco elétrico", "Apenas o uso de luva de raspa", "Apenas escolher um dia sem chuva"]', 1, 30),

    ('Sobre executar serviço apoiado em escada de mão:',
     '["Pode em qualquer serviço, desde que a escada esteja amarrada", "Pode, desde que o trabalhador fique pouco tempo no último degrau", "Pode, se outro colega segurar a base", "É admitido apenas em serviço leve e de curta duração, sem esforço lateral, e a escada não substitui plataforma nem andaime"]', 3, 31),

    ('A Permissão de Trabalho emitida para a tarefa em altura:',
     '["Vale para o mês inteiro, se o serviço for sempre o mesmo", "Vale para a tarefa, a equipe e o prazo definidos, fica disponível no local do serviço e é cancelada se as condições mudarem", "Fica arquivada no escritório junto com a análise de risco", "Pode ser assinada depois, quando o serviço for urgente"]', 1, 32),

    ('Um trabalhador amarrou uma corda comum na cintura, como talabarte improvisado. Isso é:',
     '["Proibido: só se usa equipamento certificado, projetado para retenção de queda, com o cinto tipo paraquedista", "Aceitável, se a corda for nova e grossa", "Aceitável em serviços de curta duração", "Aceitável, se ele der várias voltas na estrutura"]', 0, 33),

    ('A capacitação para trabalho em altura precisa ser refeita quando:',
     '["Somente a cada cinco anos", "Somente quando o trabalhador mudar de empresa", "Periodicamente, e também na mudança de procedimento ou de equipamento, no retorno de afastamento longo e quando houver acidente ou desvio identificado", "Somente quando a fiscalização exigir"]', 2, 34),

    ('A empresa pode retirar de um trabalhador a autorização para atuar em altura?',
     '["Pode: a autorização depende da capacitação, da aptidão de saúde e do cumprimento dos procedimentos, e é suspensa quando algum desses requisitos falha", "Não, porque a autorização é definitiva depois do curso", "Só com a concordância do sindicato", "Só no caso de acidente com afastamento"]', 0, 35),

    ('O andaime fachadeiro montado junto ao prédio precisa:',
     '["Sustentar-se apenas pelo próprio peso", "Ser montado por qualquer trabalhador da equipe", "Ter piso somente no nível em que o serviço está sendo feito", "Ser travado e amarrado à estrutura do prédio, com piso completo, rodapé, guarda-corpo e acesso próprio, montado sob supervisão"]', 3, 36),

    ('Antes de o serviço começar, a área abaixo do trabalho em altura precisa:',
     '["Ser mantida livre apenas durante o içamento de material", "Ficar liberada para a circulação normal", "Ser isolada e sinalizada, para que ninguém circule embaixo do risco de queda de material", "Ser limpa apenas ao final do dia"]', 2, 37),

    ('Além da conferência antes de cada uso, o que se espera do cinto, do talabarte e dos acessórios?',
     '["Que sejam trocados a cada seis meses, independentemente do estado", "Inspeção periódica registrada, feita por pessoa capacitada, com retirada de uso e descarte do equipamento reprovado", "Que fiquem guardados no almoxarifado sem inspeção até a próxima obra", "Que o fabricante venha inspecionar uma vez por ano no canteiro"]', 1, 38),

    ('Trabalhador sozinho em serviço de altura, sem ninguém por perto:',
     '["Pode, se ele avisar por telefone a cada hora", "Não é admitido: é preciso haver alguém capacitado por perto, capaz de acionar e executar o resgate", "Pode, se o serviço for de manutenção leve", "Pode, se o supervisor autorizar por mensagem"]', 1, 39),

    ('A análise de risco do trabalho em altura deve considerar:',
     '["Apenas a altura do serviço", "Apenas o equipamento de proteção disponível", "O local, o acesso, a estrutura de ancoragem, as condições do tempo, os riscos adicionais como energia e produtos químicos, a duração do serviço e o resgate", "Apenas a experiência da equipe"]', 2, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'NR-35-REC';


-- a aprovação continua em 70% para todo mundo
update public.trein_curso set nota_minima = 70;

-- Confira quantas perguntas cada curso tem agora:
select c.codigo, c.titulo, c.nota_minima, count(q.id) as perguntas
  from public.trein_curso c
  left join public.trein_questao q on q.curso_id = c.id
 group by c.id order by perguntas desc, c.ordem;

-- Confira a faixa de ordem dos cinco cursos deste arquivo:
select c.codigo, min(q.ordem) as menor, max(q.ordem) as maior, count(*) as total
  from public.trein_curso c
  join public.trein_questao q on q.curso_id = c.id
 where c.codigo in ('NR-20','NR-26','NR-33','NR-34.5','NR-35-REC')
 group by c.codigo order by c.codigo;

-- Se algum dos cinco não aparecer na lista acima, o código está errado e
-- o insert daquele bloco gravou zero linha. Foi o que quase aconteceu com
-- a reciclagem da NR-35, que na base é 'NR-35-REC' e não 'NR-35'.
