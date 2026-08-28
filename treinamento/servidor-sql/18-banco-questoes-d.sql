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
--  Banco de questões — grupo D: BRIG, DD, DD-REC e LOTO
--  30 questões novas por curso (ordem 11 a 40), 120 no total.
--
--  Rode no SQL Editor. Pode rodar quantas vezes quiser: cada bloco apaga
--  SÓ a faixa 11..40 do seu curso antes de inserir. As 10 primeiras
--  questões, que vieram do 12-provas-demais-cursos.sql, ficam intactas.
--  Depois deste arquivo cada um dos quatro cursos passa a ter 40
--  questões, e a prova pode sortear em vez de sempre repetir as mesmas.
--
--  ATENÇÃO: ESTAS PERGUNTAS PRECISAM DA CONFERIDA DO RESPONSÁVEL TÉCNICO
--  ANTES DE VALEREM PARA CERTIFICADO.
--  Foram escritas a partir do conteúdo usual de cada curso e do que se
--  cobra em campo. São coerentes com a prática, mas quem responde pela
--  prova é o responsável técnico — prova errada reprova quem sabe e
--  aprova quem não sabe, e é a assinatura dele que está no certificado.
--
--  NENHUMA QUESTÃO DAQUI REPETE AS 10 QUE JÁ EXISTEM. Também não repete
--  o mesmo assunto com outras palavras: quem já respondeu sobre o cinto
--  do banco traseiro não vai responder de novo sobre a mesma coisa com a
--  frase trocada.
--
--  DD E DD-REC SÃO O MESMO TEMA E FORAM SEPARADOS DE PROPÓSITO. O DD fica
--  com o básico do dia a dia. A reciclagem cobra o que só aparece depois
--  de uns anos de estrada: fadiga, direção noturna, chuva, veículo
--  carregado, comportamento de risco e os primeiros minutos depois de um
--  acidente. Reciclagem que devolve a mesma prova não mede nada.
--
--  A COLUNA `correta` É O ÍNDICE, COMEÇANDO EM ZERO
--  Se a resposta certa é a primeira alternativa, `correta` é 0. A posição
--  da resposta certa foi espalhada pelos quatro índices sem padrão: aluno
--  que decora sequência de gabarito não aprende segurança nenhuma.
--
--  CADA ARRAY FICA NUMA LINHA SÓ, de propósito: o Postgres recusa JSON
--  com quebra de linha dentro do texto ("Character with value 0x0d must
--  be escaped"). Já derrubou um arquivo deste projeto uma vez e não custa
--  nada evitar de novo. Também não existe apóstrofo em nenhum enunciado,
--  pelo mesmo motivo: apóstrofo fecha o literal e quebra o insert.
--
--  As alternativas erradas são erros que se ouve na obra, no chão de
--  fábrica e na boca do motorista experiente. Alternativa absurda não
--  mede nada: o aluno acerta por eliminação sem ter entendido o risco.
-- =====================================================================


-- =====================================================================
--  BRIG — Brigada de incêndio e primeiros socorros (16h)
--  As 10 primeiras já cobriram extintor de água, quadro elétrico, RCP,
--  engasgo, queimadura, hemorragia e coluna. Aqui entram as classes de
--  fogo que faltaram, a propagação, a conservação do próprio extintor, o
--  abandono da área e o socorro que o brigadista faz mais do que imagina:
--  convulsão, desmaio, choque elétrico e vítima inconsciente que respira.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'BRIG')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O que precisa estar junto para o fogo existir?',
     '["Somente material combustível e uma faísca", "Somente calor e ar em movimento", "Combustível, oxigênio e calor, mantidos pela reação em cadeia", "Somente combustível e temperatura alta do ambiente"]', 2, 11),

    ('Apagar o fogo por abafamento significa:',
     '["Cortar o contato do fogo com o oxigênio, cobrindo ou sufocando as chamas", "Molhar o material até ele esfriar", "Retirar o material que ainda não pegou fogo", "Aumentar a ventilação para dispersar o calor"]', 0, 12),

    ('Fogo em gasolina, tinta ou solvente pertence a qual classe?',
     '["Classe A", "Classe B", "Classe C", "Classe D"]', 1, 13),

    ('A gordura da fritadeira da cozinha industrial começou a queimar. O correto é:',
     '["Jogar água para resfriar rápido", "Retirar a panela e levar para fora do prédio", "Usar extintor de água pressurizada", "Cortar o gás, abafar a panela com tampa e usar extintor de classe K, nunca água"]', 3, 14),

    ('Por que não se usa água em incêndio com metais como magnésio e alumínio em pó?',
     '["Porque a água escorre e não alcança o metal", "Porque a água mancha o metal", "Porque a reação da água com esses metais piora o fogo, e o correto é o pó especial de classe D", "Porque a água só serve em ambiente fechado"]', 2, 15),

    ('Até onde vai o combate ao fogo feito pela brigada da empresa?',
     '["Até o princípio de incêndio, com a rota de saída livre atrás do brigadista e recuo imediato assim que o fogo crescer ou a fumaça tomar o ambiente", "Até apagar, custe o que custar, porque a brigada foi treinada para isso", "Até a chegada do Corpo de Bombeiros, sem recuar em nenhuma situação", "Somente depois que o Corpo de Bombeiros autorizar por telefone"]', 0, 16),

    ('Um incêndio começa no térreo e o calor chega ao andar de cima sem que a chama suba pela escada. Isso acontece por:',
     '["Falha do sistema de alarme", "Propagação do calor por convecção e irradiação, que atravessa lajes, dutos e aberturas", "Aumento da pressão do ar dentro do prédio", "Falta de janelas abertas no térreo"]', 1, 17),

    ('Na inspeção do extintor, o ponteiro do manômetro está fora da faixa verde. O que fazer?',
     '["Sacudir o extintor para o ponteiro voltar", "Deixar no lugar, porque ainda tem pó dentro", "Usar assim mesmo, já que a validade não venceu", "Retirar de serviço, comunicar o responsável e providenciar a recarga, deixando outro extintor no lugar"]', 3, 18),

    ('O extintor está atrás de um monte de material empilhado e a placa de sinalização ficou coberta. Qual a atitude correta?',
     '["Liberar o acesso na hora e comunicar o responsável pela área", "Deixar como está, pois todo mundo sabe onde fica", "Mudar o extintor para um canto vazio qualquer", "Anotar na próxima inspeção mensal"]', 0, 19),

    ('O extintor foi usado por apenas dois ou três segundos e o fogo apagou. E agora?',
     '["Voltar com ele para o suporte, porque quase não gastou", "Guardar no almoxarifado para uma emergência menor", "Enviar para recarga: extintor usado, mesmo por pouco tempo, perde pressão e não é confiável", "Conferir o peso e, se estiver perto do original, devolver ao suporte"]', 2, 20),

    ('A roupa de um colega pegou fogo e ele começa a correr. O que fazer?',
     '["Correr atrás com o extintor e disparar no rosto dele", "Fazer ele parar, deitar no chão e rolar, abafando as chamas com um cobertor ou pano grosso", "Jogar um balde de água quando conseguir alcançar", "Pedir para ele tirar a roupa em movimento"]', 1, 21),

    ('Para atravessar um corredor tomado pela fumaça, o correto é:',
     '["Correr em pé para passar mais rápido", "Prender a respiração e seguir normalmente", "Abrir todas as portas do caminho para ventilar", "Sair agachado ou rastejando, porque perto do chão o ar é menos quente e menos tóxico"]', 3, 22),

    ('Durante um incêndio você encontra uma porta fechada e o metal da maçaneta está quente. O correto é:',
     '["Não abrir e procurar outra rota de saída, porque pode haver fogo do outro lado", "Abrir devagar para ver o que tem lá dentro", "Abrir de uma vez e passar correndo", "Molhar a mão e abrir mesmo assim"]', 0, 23),

    ('Você vê um princípio de incêndio pequeno, que parece que vai apagar sozinho. O certo é:',
     '["Esperar cinco minutos para ver no que dá", "Avisar só o encarregado no fim do turno", "Acionar o alarme e a brigada primeiro e, se for treinado e seguro, combater com o extintor", "Combater sozinho e só avisar se não conseguir"]', 2, 24),

    ('Um botijão de GLP está vazando com chama na saída da válvula. Qual a conduta?',
     '["Apagar a chama primeiro com o extintor e depois pensar no registro", "Fechar o registro se der para chegar com segurança, isolar a área e acionar o Corpo de Bombeiros, sem apagar a chama enquanto o gás continua saindo", "Jogar água fria no botijão até ele esfriar", "Deitar o botijão no chão para o gás sair mais devagar"]', 1, 25),

    ('Sobre as rotas de fuga e as saídas de emergência:',
     '["Podem ser usadas para guardar material leve", "Podem ficar trancadas fora do horário de expediente", "Podem ser estreitadas quando falta espaço no setor", "Precisam ficar sempre desobstruídas, sinalizadas, iluminadas e com as portas destravadas por dentro"]', 3, 26),

    ('Chegando ao ponto de encontro depois do abandono, o que a brigada precisa fazer?',
     '["Conferir a lista de pessoas do setor e informar imediatamente quem está faltando", "Liberar todo mundo para ir embora", "Deixar cada um voltar para pegar seus pertences", "Esperar em silêncio até o alarme parar"]', 0, 27),

    ('Qual é o papel do brigadista durante o abandono da área?',
     '["Combater o fogo sozinho enquanto os outros saem", "Orientar a saída, varrer a área conferindo banheiros e salas, conduzir ao ponto de encontro e ajudar quem tem dificuldade de locomoção", "Ficar na portaria anotando os nomes", "Recolher os equipamentos de valor antes de sair"]', 1, 28),

    ('Ao ligar para o Corpo de Bombeiros (193), o que é essencial informar?',
     '["Somente o nome da empresa", "Somente o telefone para retorno", "Somente o tipo de material que está queimando", "Endereço completo com ponto de referência, o que está queimando, se há vítimas ou pessoas presas, e permanecer na linha até o atendente liberar"]', 3, 29),

    ('Antes de socorrer qualquer vítima, a primeira coisa é:',
     '["Perguntar o nome dela", "Verificar se ela tem documento", "Chamar a família", "Avaliar a segurança da cena, porque socorrista ferido vira a segunda vítima e ninguém socorre ninguém"]', 2, 30),

    ('Por que o socorrista deve usar luvas e evitar contato direto com sangue e secreções?',
     '["Para se proteger de doenças transmitidas pelo sangue e não contaminar o ferimento da vítima", "Para não sujar o uniforme da empresa", "Porque a luva melhora a firmeza das mãos", "Porque é exigência apenas em hospital"]', 0, 31),

    ('Vítima inconsciente, mas respirando normalmente e sem suspeita de trauma. Qual a conduta?',
     '["Sentar a vítima encostada na parede", "Dar água aos poucos para ela acordar", "Colocar em posição lateral de segurança, manter as vias aéreas livres, agasalhar e vigiar a respiração até o socorro chegar", "Sacudir a vítima até ela responder"]', 2, 32),

    ('Ao usar o desfibrilador externo automático (DEA), é correto:',
     '["Aplicar o choque com a vítima sobre poça de água", "Ligar o aparelho, seguir os comandos de voz e garantir que ninguém esteja encostando na vítima no momento do choque", "Colocar as pás sobre a roupa para ganhar tempo", "Usar só quando o médico autorizar por telefone"]', 1, 33),

    ('Um colega está em crise convulsiva no chão. O que fazer?',
     '["Segurar os braços e as pernas para parar o movimento", "Colocar uma colher ou pano na boca para ele não morder a língua", "Jogar água no rosto dele", "Afastar objetos, proteger a cabeça com algo macio, não conter os movimentos, marcar o tempo e virar de lado quando a crise passar"]', 3, 34),

    ('Uma pessoa desmaiou, está pálida e voltando a si. A conduta é:',
     '["Deitar de costas, elevar as pernas, afrouxar a roupa, deixar em local arejado e não dar nada para beber", "Sentar rápido e dar café quente", "Levantar a pessoa e fazer ela caminhar", "Dar açúcar na boca imediatamente"]', 0, 35),

    ('Você encontra um colega em contato com um cabo energizado. A primeira ação é:',
     '["Puxar pelo braço com força", "Jogar água para interromper a corrente", "Desligar a energia ou afastar o cabo com material isolante e seco, antes de qualquer contato com a vítima", "Tocar rapidamente só com a ponta dos dedos"]', 2, 36),

    ('Uma pessoa foi retirada de um ambiente com muita fumaça, está tossindo e diz que já está bem. O correto é:',
     '["Liberar para voltar ao trabalho, já que ela melhorou", "Levar para local com ar fresco, manter em repouso, vigiar a respiração e acionar o atendimento médico, porque o efeito da fumaça pode piorar depois", "Dar leite para cortar o efeito da fumaça", "Pedir para ela respirar fundo várias vezes seguidas"]', 1, 37),

    ('Vítima com uma barra de ferro encravada no abdômen. A conduta é:',
     '["Retirar devagar para poder fazer o curativo", "Retirar e comprimir o ferimento na sequência", "Girar o objeto para soltar antes de puxar", "Não retirar o objeto, estabilizar com panos ao redor para ele não se mexer e acionar o socorro"]', 3, 38),

    ('Um trabalhador recebeu respingo de produto químico no braço. O que fazer?',
     '["Lavar em água corrente por bastante tempo, retirar a roupa contaminada e buscar a ficha do produto e o atendimento médico", "Passar pomada e cobrir logo", "Neutralizar com outro produto químico", "Esfregar com pano seco para retirar o excesso"]', 0, 39),

    ('Suspeita de fratura no antebraço, com dor e deformidade. O correto é:',
     '["Puxar o braço para alinhar o osso no lugar", "Fazer a vítima mexer o braço para ver até onde dói", "Imobilizar na posição em que está, sem tentar alinhar, apoiar o braço e encaminhar ao atendimento médico", "Amarrar bem apertado para segurar o osso"]', 2, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'BRIG';


-- =====================================================================
--  DD — Direção defensiva (8h)
--  As 10 primeiras cobriram conceito, distância de seguimento,
--  aquaplanagem, celular, ponto cego, álcool, sono, ultrapassagem, cinto
--  e a checagem antes de sair. Aqui fica o resto do básico: como o
--  motorista se comporta no cruzamento, na curva, no pátio da empresa e
--  com as regras da própria empresa sobre carona, carroceria e CNH.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'DD')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Quais são as condições adversas que o motorista precisa avaliar antes e durante o trajeto?',
     '["Apenas a chuva e o horário", "Apenas o estado do veículo", "Motorista, veículo, via, trânsito, clima e luz", "Apenas o trânsito e o tipo de carga"]', 2, 11),

    ('O semáforo abriu para você. Qual é a atitude defensiva?',
     '["Arrancar logo, porque a preferência é sua", "Olhar para os dois lados antes de avançar, porque alguém pode furar o sinal", "Buzinar para avisar que vai passar", "Acelerar para não pegar o amarelo na frente"]', 1, 12),

    ('O que acontece com a distância necessária para parar o veículo quando a velocidade aumenta?',
     '["Ela aumenta na mesma proporção da velocidade", "Ela não muda, porque o freio é o mesmo", "Ela diminui, porque o carro responde melhor rápido", "Ela cresce bem mais que a velocidade, porque soma a distância percorrida no tempo de reação com a distância de frenagem"]', 3, 13),

    ('Antes de mudar de faixa, o correto é:',
     '["Sinalizar com a seta, olhar os espelhos e conferir o ponto cego com uma olhada rápida por cima do ombro", "Só ligar a seta e ir mudando aos poucos", "Só olhar o retrovisor interno", "Mudar rápido para não atrapalhar quem vem atrás"]', 0, 14),

    ('Ao chegar em uma rotatória, a preferência é:',
     '["De quem chega pela direita", "De quem tem o veículo maior", "De quem já está circulando dentro da rotatória", "De quem entra primeiro, independentemente do resto"]', 2, 15),

    ('Um pedestre começa a atravessar na faixa. O motorista deve:',
     '["Buzinar para ele apressar o passo", "Parar antes da faixa e aguardar a travessia terminar", "Passar por trás dele com cuidado", "Seguir, porque o pedestre deve esperar o carro"]', 1, 16),

    ('Qual é a forma segura de fazer uma curva?',
     '["Reduzir a velocidade antes de entrar e acelerar suavemente na saída", "Entrar rápido e frear forte no meio da curva", "Manter a velocidade e corrigir a direção quando o carro sair de traço", "Engatar o ponto morto para o carro ficar mais leve"]', 0, 17),

    ('Qual é o uso correto da buzina?',
     '["Para reclamar de quem está devagar", "Para avisar que você vai ultrapassar sem sinalizar", "Para pedir passagem em congestionamento", "Toque breve, apenas para avisar da sua presença e evitar um acidente"]', 3, 18),

    ('Sobre manter o farol baixo aceso durante o dia em rodovia:',
     '["Só serve para gastar bateria", "Ajuda os outros motoristas a enxergarem seu veículo de longe e é exigido em rodovia de pista simples", "Só é útil quando está nublado", "Atrapalha quem vem no sentido contrário"]', 1, 19),

    ('Um animal atravessa de repente na sua frente, em pista de velocidade. A reação mais segura é:',
     '["Esterçar bruscamente para o lado que estiver mais livre", "Acelerar para passar antes do animal", "Frear com firmeza mantendo o veículo na sua faixa, sem manobra brusca que pode capotar ou jogar o carro na pista contrária", "Frear e puxar o freio de mão junto"]', 2, 20),

    ('Em uma descida longa, para não perder o freio, o motorista deve:',
     '["Engatar marcha reduzida e usar o freio motor, aplicando o freio de serviço em toques curtos", "Descer em ponto morto para economizar combustível", "Manter o pé no freio o tempo todo, para controlar a velocidade", "Acelerar no início para ganhar embalo e frear só no fim"]', 0, 21),

    ('Antes de dar ré em pátio de obra ou área de carga, o correto é:',
     '["Confiar no sensor de ré do veículo", "Dar ré devagar e buzinando", "Olhar só pelo retrovisor e ir devagar", "Descer e verificar a área atrás do veículo e, sempre que possível, contar com um sinaleiro orientando a manobra"]', 3, 22),

    ('Ao abrir a porta do veículo estacionado na via, o motorista deve:',
     '["Abrir rápido para não ficar exposto", "Conferir pelo espelho e olhando para trás se vem carro, moto ou bicicleta, e abrir devagar", "Abrir só um pouco e descer de lado sem olhar", "Abrir e sair pelo lado do passageiro sempre"]', 1, 23),

    ('Sobre transportar trabalhadores na carroceria da caminhonete ou do caminhão:',
     '["É proibido: pessoas só viajam em local com banco e cinto de segurança", "Pode, se o trajeto for dentro da obra", "Pode, se todos ficarem sentados no fundo", "Pode, se a velocidade for baixa"]', 0, 24),

    ('Um conhecido pede carona no veículo da empresa durante o serviço. O correto é:',
     '["Levar, se ele for funcionário de outra empresa", "Levar, se for um trecho curto", "Levar e não comentar com ninguém", "Não levar: o veículo é da empresa e só transporta quem está autorizado, por causa da responsabilidade em caso de acidente"]', 3, 25),

    ('O motorista descobre que a CNH dele venceu ou foi suspensa. O que fazer?',
     '["Dirigir só dentro da empresa", "Dirigir até resolver, evitando as rodovias", "Comunicar a chefia na hora e não assumir a direção enquanto a situação não for regularizada", "Pedir para um colega dirigir e assinar a saída no lugar dele"]', 2, 26),

    ('Ao descer do veículo parado no acostamento ou em pátio industrial, o motorista deve:',
     '["Vestir o colete refletivo, descer pelo lado protegido do trânsito e ficar atento à movimentação de veículos e máquinas", "Descer pelo lado do motorista, que é mais rápido", "Descer sem colete, se for parada rápida", "Descer somente quando parar de passar veículo"]', 0, 27),

    ('Dirigindo dentro do pátio da empresa ou do canteiro de obras, o correto é:',
     '["Manter a velocidade da rua, já que a área é fechada", "Andar em velocidade baixa, com faróis acesos, respeitando a rota de pedestres e dando preferência a quem está a pé", "Buzinar sempre e seguir sem reduzir", "Só reduzir onde tem lombada"]', 1, 28),

    ('Ajustar o GPS, procurar música no rádio ou mexer no ar-condicionado deve ser feito:',
     '["Em movimento, em trecho reto e vazio", "No semáforo fechado", "Enquanto o carro anda devagar no congestionamento", "Com o veículo parado, antes de iniciar o trajeto"]', 3, 29),

    ('Um motorista fechou seu veículo e fez gesto agressivo. A conduta defensiva é:',
     '["Fechar de volta para ele aprender", "Acompanhar e cobrar explicação no próximo semáforo", "Não revidar, manter distância, deixar ele seguir e, se for veículo da empresa, registrar o ocorrido depois", "Buzinar sem parar até ele se afastar"]', 2, 30),

    ('Sobre o airbag do veículo:',
     '["Ele funciona junto com o cinto e não substitui o cinto: sem cinto, o airbag pode até agravar a lesão", "Ele substitui o cinto no banco da frente", "Ele dispensa o cinto em baixa velocidade", "Ele só funciona se o cinto estiver solto"]', 0, 31),

    ('Antes de dar a partida, o motorista deve regular:',
     '["Somente o banco", "Banco, encosto, encosto de cabeça na altura da nuca e os três espelhos, para enxergar bem e reduzir o ponto cego", "Somente os espelhos externos", "Somente o volante"]', 1, 32),

    ('A faixa central da pista é contínua no trecho em que você está. Isso significa que:',
     '["Pode ultrapassar se não vier ninguém em sentido contrário", "Pode ultrapassar veículo lento, como trator", "Pode ultrapassar durante o dia", "Não pode ultrapassar nem cruzar a faixa: o trecho não tem visibilidade ou espaço seguro para isso"]', 3, 33),

    ('Ferramentas, capacete e garrafa térmica soltos dentro da cabine:',
     '["Não têm importância, porque são leves", "Só atrapalham se estiverem no banco da frente", "Viram projéteis numa freada brusca ou colisão e devem ficar guardados e presos", "Podem ficar soltos se o trajeto for curto"]', 2, 34),

    ('Ao estacionar em uma ladeira, além de puxar o freio de estacionamento, é correto:',
     '["Engatar uma marcha e esterçar as rodas para a guia, calçando o veículo quando for pesado", "Deixar em ponto morto para não forçar o câmbio", "Deixar apenas o freio de mão, que é suficiente", "Deixar a chave na ignição para outro motorista poder mover"]', 0, 35),

    ('Em trânsito urbano com muitas motos, a atitude defensiva é:',
     '["Ocupar o meio da faixa para a moto não passar", "Contar que a moto pode estar entre as faixas: conferir espelhos e ponto cego antes de qualquer mudança de faixa ou abertura de porta", "Buzinar sempre que perceber uma moto ao lado", "Acelerar para deixar a moto para trás"]', 1, 36),

    ('Durante o trajeto o motorista percebe um barulho estranho no freio e o pedal mais mole. O correto é:',
     '["Seguir devagar até o fim da rota e avisar depois", "Testar o freio algumas vezes e continuar se melhorar", "Parar em local seguro, comunicar a empresa e não seguir viagem com o veículo antes da avaliação da manutenção", "Completar o fluido no primeiro posto e continuar"]', 2, 37),

    ('Sobre o limite de velocidade da via:',
     '["É uma meta a ser alcançada quando a pista está livre", "Pode ser ultrapassado em pequena margem sem risco", "Vale apenas onde há radar", "É o limite máximo em condição ideal, e chuva, neblina, pista ruim ou trânsito pedem velocidade menor que a placa"]', 3, 38),

    ('Outro veículo iniciou a ultrapassagem do seu. A conduta correta é:',
     '["Manter a velocidade, manter-se à direita da faixa e facilitar a manobra dele", "Acelerar para não ser ultrapassado", "Frear de repente para ele passar logo", "Ligar o pisca-alerta e sair pelo acostamento"]', 0, 39),

    ('Uma ambulância vem atrás com sirene e giroflex ligados. O que fazer?',
     '["Frear no meio da pista para ela desviar", "Acelerar para não atrapalhar o caminho dela", "Sinalizar, encostar à direita com segurança e dar passagem, sem manobra brusca e sem avançar sinal", "Seguir na mesma faixa, porque a ambulância tem espaço para desviar"]', 2, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'DD';


-- =====================================================================
--  DD-REC — Direção defensiva, reciclagem (8h)
--  NENHUMA DAS 30 REPETE O DD. Nem as 10 antigas dele, nem as 30 novas.
--  Quem faz reciclagem já sabe o básico e vai errar em outro lugar:
--  cansaço que ele não reconhece como cansaço, farol contrário, os
--  primeiros minutos de chuva, veículo carregado que freia diferente,
--  pressa por causa da meta e o que fazer nos cinco minutos seguintes a
--  um acidente, que é quando acontece o segundo acidente.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'DD-REC')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('Quais são sinais de que a fadiga já está afetando o motorista?',
     '["Somente o bocejo", "Somente fechar os olhos por alguns segundos", "Somente dor nas costas", "Piscar demais, olhos ardendo, não lembrar dos últimos quilômetros, sair da faixa sem perceber e demorar a reagir"]', 3, 11),

    ('O que é o microssono ao volante?',
     '["Um apagão de poucos segundos, em que o motorista dorme sem perceber e percorre dezenas de metros sem controle", "Um cochilo curto e planejado no acostamento", "Uma distração causada por conversa dentro do veículo", "Um sono leve que permite continuar dirigindo com atenção"]', 0, 12),

    ('Qual é a forma correta de lidar com o cansaço em viagem longa?',
     '["Descansar apenas quando o sono aparecer", "Dirigir mais rápido para chegar antes de cansar", "Planejar paradas regulares para descanso, a cada duas horas mais ou menos, parando antes de o cansaço apertar", "Alternar apenas o volume do som e a temperatura do ar"]', 2, 13),

    ('O motorista dormiu menos de cinco horas na noite anterior e vai começar uma viagem. Isso significa que:',
     '["Não tem problema, desde que ele tome café", "A privação de sono prejudica a atenção e o tempo de reação de forma comparável ao efeito do álcool, e ele não deve assumir a direção", "O risco só existe depois de duas noites mal dormidas", "Basta reduzir a velocidade para compensar"]', 1, 14),

    ('Quais são os horários de maior risco de sono ao volante?',
     '["No fim da tarde e no começo da noite", "Somente durante a madrugada", "Somente no primeiro horário da manhã", "Na madrugada e no começo da tarde, logo depois do almoço"]', 3, 15),

    ('Sobre café e bebida energética para enfrentar o sono na direção:',
     '["Resolvem o problema enquanto durar a viagem", "Substituem o descanso quando a dose é alta", "Dão um alívio curto e enganoso: o sono volta mais forte e o único remédio é parar e dormir", "Não têm efeito nenhum sobre a atenção"]', 2, 16),

    ('Um veículo vem em sentido contrário com farol alto e ofusca sua visão. O correto é:',
     '["Reduzir a velocidade e desviar o olhar para a borda direita da pista, usando a faixa como referência até ele passar", "Acender o farol alto também para revidar", "Fechar um dos olhos até ele passar", "Manter a velocidade e olhar direto para o farol dele"]', 0, 17),

    ('Qual velocidade é adequada na direção noturna em rodovia sem iluminação?',
     '["A mesma do dia, já que a pista está mais vazia", "Uma velocidade que permita parar dentro da distância iluminada pelo farol", "A permitida pela placa, sempre", "Um pouco acima do dia, porque há menos trânsito"]', 1, 18),

    ('Por que à noite é preciso redobrar a atenção com as bordas da pista e o acostamento?',
     '["Porque o asfalto fica mais escorregadio à noite", "Porque o motor perde potência no frio", "Porque a sinalização some quando escurece", "Porque pedestre, ciclista e animal aparecem sem refletivo, quase invisíveis até o farol alcançar"]', 3, 19),

    ('Para-brisa sujo por dentro, lâmpada queimada e farol desregulado atrapalham porque:',
     '["Espalham a luz, criam brilho e reduzem muito o alcance da visão à noite, além de ofuscar quem vem em sentido contrário", "Só incomodam durante o dia", "Aumentam o consumo de combustível", "Só atrapalham em dia de chuva"]', 0, 20),

    ('Por que os primeiros minutos de uma chuva são os mais perigosos?',
     '["Porque o motorista se distrai com o limpador", "Porque a temperatura do pneu cai de repente", "Porque a água se mistura ao óleo e à borracha acumulados no asfalto e a pista fica bem mais escorregadia", "Porque a chuva fraca reduz mais a visibilidade que a chuva forte"]', 2, 21),

    ('A chuva ficou tão forte que o limpador não dá conta e a visibilidade some. O correto é:',
     '["Ligar o pisca-alerta e continuar devagar na pista", "Sair da pista em local seguro, como posto ou área afastada do acostamento, com as luzes ligadas, e esperar melhorar", "Parar em cima do acostamento e ficar dentro do veículo", "Seguir acompanhando de perto a lanterna do carro da frente"]', 1, 22),

    ('O veículo começou a flutuar sobre a água e a direção ficou leve. Qual a reação correta?',
     '["Tirar o pé do acelerador, manter o volante firme e reto e esperar os pneus voltarem a tocar o asfalto, sem frear brusco e sem esterçar", "Frear com força para recuperar o contato", "Esterçar rápido para um lado e para o outro", "Acelerar para o carro ganhar aderência"]', 0, 23),

    ('Depois de atravessar uma poça funda ou um trecho alagado, é recomendado:',
     '["Acelerar para secar o freio pelo vento", "Parar imediatamente e esperar secar sozinho", "Nada, porque o freio não muda com água", "Seguir devagar aplicando o freio de leve algumas vezes, para secar as lonas e pastilhas antes de voltar à velocidade normal"]', 3, 24),

    ('Sobre o pisca-alerta durante a chuva:',
     '["Deve ficar ligado o tempo todo enquanto chove", "Deve ser usado sempre que a velocidade cair", "Não se usa com o veículo em movimento: ele indica veículo parado ou em emergência e confunde quem vem atrás, além de esconder a seta", "Substitui o farol quando a chuva é forte"]', 2, 25),

    ('Ao ser ultrapassado por uma carreta em rodovia com vento lateral, o motorista deve:',
     '["Acelerar para encurtar o tempo lado a lado", "Segurar o volante com firmeza nas duas mãos e reduzir um pouco, prevendo o solavanco do deslocamento de ar", "Sair para o acostamento até ela passar", "Frear com força quando sentir o carro puxar"]', 1, 26),

    ('Um veículo carregado se comporta diferente na curva porque:',
     '["Ele fica mais estável quanto mais peso tiver", "A carga não interfere se estiver amarrada", "O peso extra só afeta o consumo de combustível", "A carga eleva o centro de gravidade e aumenta o risco de tombamento, exigindo entrar na curva bem mais devagar"]', 3, 27),

    ('Com o veículo carregado, a distância que se deve manter do veículo da frente:',
     '["Precisa ser maior, porque o peso aumenta bastante o espaço necessário para parar", "Continua a mesma, porque o freio é dimensionado para a carga", "Pode ser menor, porque o peso ajuda a frear", "Só muda em descida"]', 0, 28),

    ('Depois dos primeiros quilômetros de viagem com carga amarrada, o motorista deve:',
     '["Confiar na amarração feita na origem", "Parar em local seguro e conferir e reapertar as cintas, porque a carga acomoda e as cintas folgam com a vibração", "Conferir apenas ao chegar no destino", "Conferir somente se ouvir barulho na carroceria"]', 1, 29),

    ('A carga ultrapassa a traseira da carroceria. O correto é:',
     '["Seguir devagar, porque a saliência é pequena", "Amarrar um pano qualquer e não se preocupar", "Sinalizar a saliência conforme a regra, com bandeira ou dispositivo refletivo bem visível, e respeitar o limite permitido", "Transportar somente à noite"]', 2, 30),

    ('O motorista está atrasado para a entrega e a meta do dia está apertada. A decisão correta é:',
     '["Comunicar o atraso ao responsável e manter a direção segura: nenhuma entrega vale um acidente", "Aumentar a velocidade nos trechos livres para recuperar o tempo", "Cortar as paradas de descanso previstas", "Fazer as ultrapassagens que der para fazer"]', 0, 31),

    ('Por que o motorista experiente também se acidenta?',
     '["Porque o veículo velho falha mais", "Porque ele dirige menos horas por dia", "Porque a experiência piora os reflexos", "Porque o excesso de confiança faz ele abrir mão da margem de segurança: reduz distância, dispensa checagem e conta com a própria habilidade para corrigir"]', 3, 32),

    ('O motorista saiu de casa depois de uma discussão e está irritado. Como isso afeta a direção?',
     '["Não afeta, porque o volante não sabe do humor", "Irritação e estresse reduzem a atenção e favorecem decisões impulsivas, e o certo é esperar se acalmar antes de assumir a direção", "Ajuda, porque o motorista fica mais alerta", "Afeta apenas em trânsito parado"]', 1, 33),

    ('O pneu estourou com o veículo em movimento. Qual a reação correta?',
     '["Frear com força imediatamente", "Puxar o freio de mão para parar mais rápido", "Segurar o volante firme, tirar o pé do acelerador e deixar o veículo perder velocidade aos poucos, saindo da pista com segurança para só então parar", "Esterçar rápido para o acostamento"]', 2, 34),

    ('Nos primeiros minutos depois de uma colisão, antes de qualquer socorro, é preciso:',
     '["Garantir a própria segurança, desligar o motor, acionar o freio de estacionamento, sinalizar o local e não deixar ninguém fumar perto dos veículos", "Tirar fotos para o seguro antes que alguém mexa", "Discutir a culpa com o outro motorista", "Ligar o motor de novo para tirar o carro do lugar"]', 0, 35),

    ('Uma vítima está presa nas ferragens, consciente e falando. O que fazer?',
     '["Puxar pelo braço com cuidado", "Reclinar o banco e deitar a vítima", "Cortar o cinto e retirar rápido", "Não tentar retirar: acionar o socorro, manter a vítima calma e conversando e só remover se houver risco imediato, como fogo"]', 3, 36),

    ('Ao acionar o socorro depois de um acidente, o que é essencial informar?',
     '["Somente a placa dos veículos", "O local exato com quilômetro ou ponto de referência, quantas vítimas há, o estado delas e se existe risco de fogo ou produto derramado", "Somente o nome da empresa e do motorista", "Somente o horário do acidente"]', 1, 37),

    ('A vítima está consciente, sentada fora do veículo, e pede água. O correto é:',
     '["Dar água em pouca quantidade", "Dar um alimento leve para ela recuperar a força", "Não dar água, comida nem remédio, manter a vítima agasalhada, calma e sentada até o socorro chegar", "Dar remédio para dor se ela reclamar muito"]', 2, 38),

    ('Há vazamento de combustível no local do acidente. A conduta é:',
     '["Afastar todo mundo, proibir qualquer chama ou cigarro, evitar acionar a partida dos veículos e usar o extintor apenas em princípio de fogo, se houver segurança", "Cobrir o vazamento com pano para conter", "Ligar o veículo e movê-lo para longe da poça", "Jogar terra e liberar o trânsito na sequência"]', 0, 39),

    ('Uma batida leve, sem feridos, deixou os dois carros parados na faixa da direita atrapalhando o fluxo. O correto é:',
     '["Deixar tudo parado no mesmo lugar até a perícia chegar, em qualquer situação", "Sair do local para não se envolver em discussão", "Sinalizar de imediato, tirar os carros para o acostamento já que ninguém se feriu, anotar placas e dados e comunicar a empresa", "Empurrar os carros para o lado sem sinalizar nada"]', 2, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'DD-REC';


-- =====================================================================
--  LOTO — Bloqueio e etiquetagem de energias perigosas (4h)
--  As 10 primeiras cobriram o conceito, os tipos de energia, cadeado
--  individual, quem retira, etiqueta sem cadeado, teste de partida,
--  máquina bloqueada por outro, cadeado esquecido, troca de turno e a
--  liberação final. O que sobra é onde as pessoas se machucam: energia
--  que fica guardada depois de desligar, máquina que parte sozinha por
--  comando remoto e o gesto de enfiar a mão para desatolar.
-- =====================================================================

delete from public.trein_questao
 where curso_id = (select id from public.trein_curso where codigo = 'LOTO')
   and ordem between 11 and 40;

insert into public.trein_questao (curso_id, enunciado, alternativas, correta, ordem)
select c.id, q.enunciado, q.alternativas::jsonb, q.correta, q.ordem
  from public.trein_curso c,
       (values
    ('O que é uma fonte de energia perigosa em uma máquina?',
     '["Somente a tomada de força e o motor elétrico", "Qualquer energia capaz de acionar a máquina ou machucar quem trabalha nela, mesmo com o equipamento parado", "Somente a energia que aparece no painel de comando", "Somente as energias com tensão acima de 220 volts"]', 1, 11),

    ('O painel foi desligado, mas o inversor de frequência tem capacitores. Isso significa que:',
     '["A tensão desaparece assim que a chave é aberta", "Basta esperar o ventilador do painel parar", "O risco só existe se a máquina estiver em operação", "Ainda pode haver carga armazenada, e é preciso respeitar o tempo de descarga indicado antes de tocar nos componentes"]', 3, 12),

    ('A máquina tem uma peça suspensa e uma mola comprimida no mecanismo. Ao bloquear, o correto é:',
     '["Descer a peça até o apoio ou travar mecanicamente, e aliviar ou travar a mola, porque bloquear a energia elétrica não segura peso nem mola", "Confiar no travamento do próprio sistema hidráulico", "Bloquear só a energia elétrica, que é a que aciona tudo", "Colocar uma etiqueta avisando da peça suspensa"]', 0, 13),

    ('Sobre a energia pneumática antes do serviço na máquina:',
     '["Basta fechar o compressor", "Basta desligar a máquina, porque o ar escapa sozinho", "É preciso bloquear a alimentação de ar e despressurizar a linha, purgando o ar que ficou nos reservatórios e cilindros", "É preciso apenas reduzir a pressão pela metade"]', 2, 14),

    ('Um forno acabou de ser desligado e bloqueado. Quando o serviço pode começar?',
     '["Assim que o cadeado estiver colocado no painel", "Somente depois que a temperatura cair a um nível seguro e isso for confirmado, porque o calor acumulado é energia perigosa mesmo com tudo desligado", "Assim que as luzes do painel apagarem", "Quando o operador liberar verbalmente o equipamento"]', 1, 15),

    ('Para que serve o dispositivo tipo garra, o hasp de bloqueio?',
     '["Permitir que várias pessoas coloquem seus cadeados no mesmo ponto de bloqueio, e só liberar quando o último for retirado", "Substituir o cadeado quando falta um", "Prender a etiqueta na máquina", "Bloquear duas máquinas com um cadeado só"]', 0, 16),

    ('Como funciona a caixa de bloqueio, a lock box?',
     '["Guarda os cadeados reservas da equipe", "Guarda as etiquetas usadas no turno", "Serve para transportar as ferramentas do bloqueio", "As chaves dos bloqueios feitos ficam dentro dela, e cada trabalhador coloca o seu cadeado na caixa, que só abre quando todos retirarem os seus"]', 3, 17),

    ('Onde deve ficar a chave do cadeado de bloqueio individual?',
     '["Pendurada no quadro do setor, identificada", "Com o encarregado, para agilizar a liberação", "Em poder do próprio trabalhador que fez o bloqueio, sem cópia disponível para outra pessoa", "Na portaria, junto com as chaves da área"]', 2, 18),

    ('Sobre o cadeado usado no bloqueio:',
     '["É de uso exclusivo do bloqueio, identificado com o nome do trabalhador, e não serve para trancar armário, portão ou caixa de ferramenta", "Pode ser qualquer cadeado que estiver à mão", "Pode ser compartilhado entre os colegas do mesmo turno", "Pode ser o mesmo do armário, desde que esteja com o trabalhador"]', 0, 19),

    ('O que a etiqueta de bloqueio precisa informar?',
     '["Apenas a palavra bloqueado", "Apenas o setor responsável", "Apenas a data de colocação", "Nome de quem bloqueou, setor, data e hora, motivo do bloqueio e como encontrar essa pessoa"]', 3, 20),

    ('No bloqueio de uma válvula de linha de produto, o correto é:',
     '["Fechar a válvula e escrever a giz que está fechada", "Fechar a válvula, aplicar o dispositivo de bloqueio próprio com cadeado e, quando o serviço exigir abertura da linha, usar flange cego ou raquete para garantia física", "Fechar a válvula e retirar o volante do lugar", "Fechar a válvula e pedir para a operação não abrir"]', 1, 21),

    ('Qual é a diferença entre o trabalhador autorizado e o trabalhador afetado no LOTO?',
     '["Os dois colocam cadeado, mas em pontos diferentes", "O afetado é quem bloqueia e o autorizado é quem libera", "O autorizado é quem executa o bloqueio e o serviço; o afetado é quem opera ou trabalha perto da máquina e precisa ser avisado, mas não bloqueia", "Não há diferença, os dois termos são a mesma coisa"]', 2, 22),

    ('Antes de aplicar o bloqueio, o que deve acontecer?',
     '["Comunicar a operação e fazer a parada ordenada do equipamento, seguindo o procedimento normal de desligamento", "Cortar a energia direto na chave geral, sem avisar", "Esperar o fim do turno para não atrapalhar a produção", "Retirar as proteções para agilizar o serviço"]', 0, 23),

    ('Depois de desligar e bloquear o disjuntor, antes de tocar nos condutores, é preciso:',
     '["Confiar na posição da chave, que indica desligado", "Aguardar cinco minutos e começar o serviço", "Encostar rapidamente para sentir se há tensão", "Testar a ausência de tensão com detector apropriado, verificando o detector em fonte conhecida antes e depois do teste"]', 3, 24),

    ('A máquina é alimentada por dois painéis diferentes, em pontos distantes do galpão. O correto é:',
     '["Bloquear o painel principal, que corta os dois", "Bloquear o painel mais próximo do serviço", "Bloquear todas as fontes de alimentação identificadas no procedimento, sem exceção", "Bloquear um painel e desligar o outro pela botoeira"]', 2, 25),

    ('O botão de emergência da máquina foi acionado. Isso serve como bloqueio?',
     '["Serve, se ninguém mais tiver acesso ao painel", "Não serve: o botão de emergência é dispositivo de parada, pode ser rearmado por qualquer pessoa e não substitui o bloqueio da fonte de energia", "Serve, se a máquina for pequena", "Serve durante o turno em que a equipe está na área"]', 1, 26),

    ('Máquina comandada por CLP, com partida automática por sensor e possibilidade de acionamento remoto. Nesse caso:',
     '["Basta colocar a máquina em modo manual", "Basta desativar o programa pelo painel do operador", "Basta avisar a sala de controle", "O bloqueio deve ser feito no seccionamento físico da energia, porque comando por software ou remoto pode religar a máquina sem ninguém estar por perto"]', 3, 27),

    ('O disjuntor geral está desligado e bloqueado, mas o equipamento tem nobreak e banco de baterias. O que isso significa?',
     '["Ainda existe energia disponível no sistema, e essas fontes também precisam ser bloqueadas e a energia dissipada", "Não muda nada, porque a alimentação principal está cortada", "O nobreak desliga sozinho quando a rede cai", "Basta desligar o nobreak pelo botão do painel"]', 0, 28),

    ('A esteira travou com material entalado e a produção está parada esperando. O correto é:',
     '["Desatolar com uma barra, sem entrar na máquina", "Pedir para um colega segurar o botão de parada enquanto você retira", "Parar o equipamento, bloquear e etiquetar as fontes de energia e só então retirar o material, porque desatolar máquina em movimento é o gesto que mais amputa mão nesse tipo de serviço", "Retirar rapidamente aproveitando que a esteira está parada"]', 2, 29),

    ('Um colega retirou a proteção fixa e prendeu a chave de intertravamento com fita para a máquina rodar durante o ajuste. Isso é:',
     '["Aceitável, se durar poucos minutos", "Proibido: burlar o intertravamento anula a proteção e coloca a pessoa dentro da zona de risco com a máquina viva", "Aceitável, se houver um vigia acompanhando", "Aceitável, se for feito por um mecânico experiente"]', 1, 30),

    ('No meio do serviço é preciso energizar a máquina para um teste. Como proceder?',
     '["Manter o bloqueio e pedir para alguém acionar rapidamente", "Retirar só o cadeado do encarregado e testar", "Testar com metade da equipe afastada e a outra observando", "Seguir o procedimento de remoção temporária: afastar a equipe da zona de risco, remover os bloqueios de forma controlada, energizar apenas o tempo do teste e refazer todo o bloqueio antes de qualquer pessoa voltar à máquina"]', 3, 31),

    ('Uma empresa contratada vai trabalhar na mesma máquina que a equipe própria. Como fica o bloqueio?',
     '["Cada trabalhador envolvido, da contratante e da contratada, coloca o seu próprio cadeado, com procedimento e comunicação combinados entre as duas empresas", "O cadeado da contratante vale para os terceiros", "A contratada assina um termo e trabalha sem cadeado", "A contratada bloqueia sozinha, porque é quem executa o serviço"]', 0, 32),

    ('Não há cadeado de bloqueio disponível no momento do serviço. O que fazer?',
     '["Improvisar com arame ou fita e colocar a etiqueta", "Usar um cadeado de armário emprestado", "Não executar o serviço: providenciar o dispositivo correto antes de começar, porque bloqueio improvisado não segura ninguém", "Fazer o serviço com um colega vigiando o painel"]', 2, 33),

    ('Sobre o procedimento de bloqueio de cada equipamento:',
     '["Um procedimento geral da empresa resolve para todas as máquinas", "Cada equipamento precisa de procedimento específico e escrito, com todas as fontes de energia mapeadas, os pontos de bloqueio e a sequência de desligamento e liberação", "O procedimento é dispensável quando o mecânico conhece a máquina", "O procedimento só é exigido em máquinas de grande porte"]', 1, 34),

    ('Quem pode executar o bloqueio e a etiquetagem?',
     '["Somente trabalhadores treinados e formalmente autorizados pela empresa, com reciclagem e auditoria periódica do procedimento", "Qualquer pessoa da manutenção, mesmo sem treinamento", "Quem estiver mais perto do painel no momento", "Somente engenheiros e técnicos de segurança"]', 0, 35),

    ('Sobre o registro do bloqueio:',
     '["É dispensável quando o serviço é rápido", "Basta a etiqueta na máquina", "Basta a anotação no caderno do encarregado", "O bloqueio deve ficar registrado, com a identificação de quem bloqueou, o equipamento, as fontes bloqueadas e o horário, permitindo conferir a situação a qualquer momento"]', 3, 36),

    ('Além de bloquear as energias, o que ajuda a proteger quem está executando o serviço?',
     '["Trabalhar sempre em dupla, sem outra medida", "Deixar o painel aberto para todo mundo ver", "Isolar e sinalizar a área do serviço, para que ninguém circule ou acione algo por engano na zona de risco", "Reduzir a iluminação da área para chamar menos atenção"]', 2, 37),

    ('Serviço em uma linha que conduz produto químico. Além do bloqueio da válvula, é necessário:',
     '["Drenar, purgar ou lavar o trecho da linha e confirmar que não há produto nem pressão antes de abrir, usando os EPI indicados na ficha do produto", "Abrir devagar e observar se sai produto", "Apenas usar luva e óculos e abrir a flange", "Apenas avisar a área de processo"]', 0, 38),

    ('Por que um sistema hidráulico continua perigoso mesmo com a bomba desligada?',
     '["Porque o óleo demora a esfriar e pode queimar a mão", "Porque o óleo permanece sob pressão e pode movimentar ou soltar cilindros e ferramentas suspensas, exigindo alívio da pressão e apoio mecânico da parte suspensa", "Porque o peso da tubulação pode desabar sozinho", "Porque a bomba pode ligar sozinha por falta de manutenção"]', 1, 39),

    ('O trabalhador desligou a máquina pelo botão do painel de operação e colocou o cadeado nesse botão. Está correto?',
     '["Está, porque a máquina não liga com o botão travado", "Está, se o painel ficar visível para a equipe", "Não está: o bloqueio precisa ser feito no dispositivo de seccionamento da energia, como a chave ou o disjuntor, e não no comando de operação", "Está, desde que a etiqueta esteja preenchida"]', 2, 40)
       ) as q(enunciado, alternativas, correta, ordem)
 where c.codigo = 'LOTO';


-- a aprovação continua em 70% para todo mundo
update public.trein_curso set nota_minima = 70;

-- Confira quantas perguntas cada curso tem depois de rodar:
select c.codigo, c.titulo, count(q.id) as perguntas,
       min(q.ordem) as primeira, max(q.ordem) as ultima
  from public.trein_curso c
  left join public.trein_questao q on q.curso_id = c.id
 where c.codigo in ('BRIG', 'DD', 'DD-REC', 'LOTO')
 group by c.id order by c.codigo;
