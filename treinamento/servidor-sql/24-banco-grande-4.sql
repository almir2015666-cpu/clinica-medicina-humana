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
