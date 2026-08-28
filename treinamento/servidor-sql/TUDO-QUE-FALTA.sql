-- =====================================================================
--  TUDO O QUE FALTA, NUM ARQUIVO SO
--
--  Cole inteiro no SQL Editor do Supabase e rode UMA vez. Pode rodar de
--  novo sem estragar nada: cada pedaco ou substitui o que ja existe, ou
--  regrava o mesmo conteudo.
--
--  O QUE ENTRA AQUI
--   . A assinatura da responsavel tecnica no bucket privado
--   . Apostila aprofundada da NR-10
--   . Apostilas aprofundadas: NR-33, NR-35-REC e NR-12
--   . Apostilas aprofundadas: NR-10-SEP, NR-05 (CIPA) e NR-11
--   . Apostilas aprofundadas: BRIG, NR-18, NR-20 e NR-34.5
--   . Apostilas aprofundadas: DD, DD-REC, as duas integracoes, NR-06, NR-17, NR-26 e LOTO
-- =====================================================================


-- #####################################################################
-- #  A assinatura da responsavel tecnica no bucket privado
-- #  (vem de 37-assinatura-do-responsavel.sql)
-- #####################################################################

-- =====================================================================
--  A ASSINATURA DO RESPONSÁVEL TÉCNICO NO CERTIFICADO
--
--  Rode quando quiser. Pode rodar mais de uma vez.
--
--  O que este arquivo faz
--  ----------------------
--  Abre um lugar no bucket privado para a imagem da assinatura, sem
--  torná-la pública. A imagem fica em `responsavel/assinatura.png`, o
--  admin envia por lá, e o certificado pede uma URL assinada de curta
--  duração na hora de desenhar.
--
--  Por que não deixar a imagem no site, junto com as outras
--  -------------------------------------------------------
--  Porque o site é público. Uma assinatura escaneada num endereço fixo e
--  adivinhável é uma assinatura que qualquer pessoa baixa e cola em
--  qualquer papel. No bucket privado ela só sai para quem está logado, e
--  a página de conferência pública NÃO a mostra: para o auditor, o que
--  prova o documento é o código, conferido no site da clínica.
--
--  DE QUEBRA, CONSERTA UM ERRO QUE JÁ ESTAVA AQUI
--  ----------------------------------------------
--  A política de leitura fazia isto:
--
--      public.trein_pode_ver( (storage.foldername(name))[1]::uuid )
--
--  Ela assume que a primeira pasta é SEMPRE um uuid de curso. Qualquer
--  arquivo guardado fora desse formato, inclusive o que este arquivo
--  passa a permitir, faria o cast levantar `invalid input syntax for
--  type uuid` e a leitura morrer com erro de banco, e não com "não
--  pode". Agora o formato é conferido antes do cast.
-- =====================================================================

drop policy if exists trein_stor_read on storage.objects;
create policy trein_stor_read on storage.objects
  for select using (
    bucket_id = 'treinamentos'
    and (
      public.trein_is_equipe()

      -- A assinatura: qualquer pessoa LOGADA lê. O aluno precisa dela
      -- para o próprio certificado sair assinado, e ele não é da equipe.
      -- Quem não tem login nenhum continua sem ver.
      or ( name like 'responsavel/%' and auth.uid() is not null )

      -- O material do curso: só com matrícula válida. O regex confere
      -- que a pasta tem cara de uuid ANTES de converter; sem isso o
      -- cast levanta exceção em vez de negar.
      or (
        (storage.foldername(name))[1] ~*
          '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
        and public.trein_pode_ver(((storage.foldername(name))[1])::uuid)
      )
    )
  );

-- Escrever, trocar e apagar continuam sendo só da equipe, e as políticas
-- de escrita já eram assim: ficam como estão.

-- #####################################################################
-- #  Apostila aprofundada da NR-10
-- #  (vem de 36-apostila-nr-10.sql)
-- #####################################################################

-- =====================================================================
--  APOSTILA APROFUNDADA: NR-10 (a primeira, como modelo)
--
--  Rode quando quiser. Pode rodar mais de uma vez.
--
--  ATENCAO: CONTEUDO TECNICO. Antes de publicar, a responsavel tecnica
--  precisa conferir. Os numeros aqui (limites de zona, classes de luva,
--  efeitos da corrente) valem vida, e a norma muda.
--
--  Por que esta apostila e maior que as anteriores
--  ----------------------------------------------
--  As primeiras tinham cerca de 950 palavras. Para um curso de 40 horas
--  isso e um resumo, nao um material de estudo: o aluno le em cinco
--  minutos e continua sem ter onde tirar duvida no meio do turno.
--
--  Esta tem por volta de 4.500. Ela usa quadro comparativo e passo a
--  passo numerado, que a pagina passou a desenhar hoje. Num procedimento
--  de seguranca a ORDEM e o conteudo: testar o detector antes e depois,
--  aterrar antes de tocar. Escrito com bolinha, a sequencia vira sugestao.
-- =====================================================================

update public.trein_curso set apostila =
'# Segurança em instalações e serviços em eletricidade

A eletricidade não avisa. Não tem cheiro, não tem cor, não faz barulho antes de acontecer, e o corpo humano só percebe que ela está ali quando já está passando por dentro dele. É por isso que este é um dos poucos riscos em que a percepção não protege: quem confia nos sentidos, morre. Quem confia no procedimento, volta para casa.

Esta apostila acompanha o curso e serve para depois dele. Ela foi escrita para ser consultada no meio do turno, no celular, quando aparece a dúvida real: posso mexer nisso? testei direito? falta alguma coisa antes de eu encostar?

## Como usar este material

Leia inteiro uma vez, sem pressa, antes da prova. Depois volte por partes.

- Os **quadros** existem para consulta rápida. Guarde onde eles estão.
- Os **passos numerados** são sequência obrigatória. A ordem não é estilo, é a proteção.
- Os trechos **recuados, com filete ao lado**, são as coisas que mais matam. Se você lembrar só deles, já foi um ganho.
- No fim há **exercícios com gabarito comentado**. Faça antes de olhar a resposta.

## O que você deve saber ao final

- Explicar o que é choque elétrico e o que é arco elétrico, e por que os dois exigem proteções diferentes.
- Executar e conferir a sequência de desenergização e a de reenergização, na ordem certa.
- Reconhecer a zona de risco e a zona controlada e saber quem pode entrar em cada uma.
- Escolher, inspecionar e usar o EPI adequado, sabendo o que cada classe de luva suporta.
- Identificar os documentos que precisam existir antes de o serviço começar.
- Agir nos primeiros minutos de um acidente elétrico sem virar a segunda vítima.

## O risco elétrico

### O choque elétrico

Choque é a passagem de corrente elétrica pelo corpo. O que machuca não é a tensão, é a **corrente**, e o quanto ela machuca depende de três coisas: a intensidade, o caminho que ela faz dentro do corpo e o tempo que ela fica passando.

O caminho importa mais do que as pessoas imaginam. Uma corrente que entra pela mão e sai pelo pé atravessa o tórax, ou seja, passa pelo coração e pelo diafragma. A mesma corrente entrando e saindo pela mesma mão faz um estrago local muito menor. É por isso que eletricista experiente trabalha com uma mão só quando pode, e mantém a outra longe de qualquer coisa aterrada.

| Corrente | O que acontece no corpo |
| --- | --- |
| 1 mA | Formigamento, limiar de percepção |
| 10 a 16 mA | Contração muscular que impede soltar o condutor |
| 20 a 30 mA | Contração do diafragma, dificuldade ou parada respiratória |
| 50 a 100 mA | Risco de fibrilação ventricular |
| Acima de 1 A | Parada cardíaca, queimadura profunda no trajeto |

Repare no segundo item. Entre dez e dezesseis miliampères a pessoa **não consegue mais soltar**: a mão fecha sozinha em volta do fio. Todo mundo acha que vai conseguir se afastar, e não vai. Por isso não existe choque pequeno, existe choque que terminou cedo.

> Um chuveiro comum puxa mais de trinta ampères. A corrente que provoca fibrilação é de cinquenta miliampères, ou seja, cerca de seiscentas vezes menos. A instalação não precisa ser grande para matar.

A umidade muda tudo. A pele seca oferece resistência alta; suada, molhada ou ferida, essa resistência despenca, e a mesma tensão que daria um susto passa a dar um acidente. Trabalho na chuva, no vão molhado, com a camisa encharcada de suor, é outro trabalho.

### O arco elétrico

O arco é diferente, e é o que muita gente subestima. Não é preciso encostar em nada: basta aproximar demais, ou provocar um curto, para o ar entre dois pontos virar condutor. O arco chega a temperaturas da ordem de 20.000 graus, várias vezes a superfície do Sol, e projeta metal derretido e uma onda de pressão.

As consequências típicas de um arco não são choque: são **queimadura de segundo e terceiro grau**, perda de audição pelo estampido, cegueira temporária ou permanente pelo clarão e trauma pela projeção do corpo.

Isso explica por que a roupa importa tanto. A vestimenta contra arco elétrico é avaliada em cal/cm2, o chamado ATPV, e precisa ser compatível com a energia incidente calculada para aquele ponto da instalação. E explica por que roupa de tecido sintético é proibida perto de eletricidade: o poliéster não queima, ele derrete, e gruda na pele.

### Os outros riscos que vêm junto

Um serviço elétrico quase nunca tem só risco elétrico. Vem com altura, com espaço confinado, com máquina que pode partir sozinha, com material inflamável ao lado. Os campos eletromagnéticos, presentes principalmente em alta tensão, também entram na avaliação. A análise de risco tem que enxergar o serviço inteiro, e não só a parte com fio.

## O que a NR-10 exige

A NR-10 vale para todas as fases da instalação: projeto, construção, montagem, operação, manutenção e também a reforma e a ampliação. E vale para quem trabalha nas proximidades, não apenas para quem põe a mão.

Quatro palavras aparecem o tempo todo e são confundidas com frequência. Vale decorar a diferença.

| Termo | O que significa |
| --- | --- |
| Qualificado | Tem formação reconhecida pelo sistema oficial de ensino |
| Habilitado | É qualificado e tem registro no conselho de classe |
| Capacitado | Trabalha sob supervisão de habilitado, com treinamento na empresa |
| Autorizado | Qualificado, habilitado ou capacitado, e formalmente liberado pela empresa |

O ponto prático: **autorizado é a condição para tocar na instalação**. Ter curso não basta, ter diploma não basta. A empresa precisa autorizar por escrito, nominalmente, e essa autorização tem prazo e escopo.

### Sobre o treinamento

Quem atua no sistema elétrico de potência, ou seja, na geração, transmissão e distribuição, precisa também do treinamento complementar, além deste.

A reciclagem é **bienal**, e além do prazo ela é obrigatória em três situações: quando o trabalhador muda de função ou de empresa, quando a instalação ou o método de trabalho mudam, e quando o resultado de uma avaliação mostra que o desempenho não está adequado.

## Desenergizar, a única proteção que não depende de sorte

A regra de ouro da NR-10 é simples de enunciar e difícil de cumprir sob pressão: **serviço em instalação elétrica é feito desenergizado**. Trabalho energizado é exceção, precisa de justificativa técnica, procedimento específico e autorização, e não é assunto de curso básico.

Desenergizado, para a norma, não é o mesmo que desligado. Uma chave aberta não é uma instalação desenergizada. A instalação só está desenergizada quando os seis passos abaixo foram cumpridos, nesta ordem, e assim permanecem.

1. **Seccionamento.** Abrir o dispositivo e criar um ponto de corte visível ou comprovado. Chave aberta não é o fim, é o começo.
2. **Impedimento de reenergização.** Travar com cadeado, o seu, com a sua chave no seu bolso, e etiquetar com nome, data e serviço. Se várias pessoas trabalham no mesmo circuito, cada uma põe o seu cadeado, e o circuito só volta quando o último sair.
3. **Constatação da ausência de tensão.** Com detector adequado à tensão, testando o instrumento em fonte conhecida antes e depois da medição. Detector que falhou entre um teste e outro diria que está morto um circuito vivo.
4. **Instalação de aterramento temporário** com equipotencialização dos condutores. É o que protege contra religação indevida, contra tensão induzida de circuito paralelo e contra retorno por gerador ou inversor.
5. **Proteção dos elementos energizados** que continuam existindo na zona controlada, com mantas, coberturas e barreiras.
6. **Sinalização de impedimento de reenergização**, visível para quem chega depois e não sabe o que está acontecendo ali.

> O passo 3 é o que mais se pula, e é o que mais mata. Testar a instalação e não testar o detector é confiar a sua vida num aparelho que você não conferiu. Fonte conhecida antes, medição, fonte conhecida depois. Sempre nessa ordem.

O aterramento temporário, passo 4, é o que salva quando alguém erra o passo 2. Instalação com geração distribuída, com nobreak, com banco de capacitores ou com inversor de painel solar pode ter tensão mesmo com a concessionária cortada. Painel fotovoltaico gera com a luz do dia, e não existe disjuntor que desligue o sol.

### Reenergizar também tem ordem

Voltar não é desfazer de qualquer jeito. A sequência é esta, e ela existe para que ninguém seja surpreendido pela energia de volta.

1. Retirar ferramentas, utensílios e equipamentos da área.
2. Retirar da zona controlada todos os trabalhadores não envolvidos na religação.
3. Remover o aterramento temporário, a equipotencialização e as proteções adicionais.
4. Remover a sinalização de impedimento.
5. Destravar e religar os dispositivos de seccionamento.

Repare que o aterramento sai **depois** de as pessoas saírem, e a sinalização é a última coisa a ser retirada antes de religar. Inverter isso significa devolver energia a um circuito que ainda tem gente perto.

## Zona de risco, zona controlada, zona livre

Perto de parte energizada, a distância é uma medida de segurança tanto quanto o EPI. A norma divide o espaço em três faixas, e o limite de cada uma depende da tensão: quanto maior a tensão, mais longe começa o perigo, porque o arco atravessa mais ar.

| Zona | O que é | Quem pode entrar |
| --- | --- | --- |
| Livre | Fora do alcance do risco | Qualquer pessoa |
| Controlada | Proximidade que exige controle | Somente pessoa autorizada |
| De risco | Junto da parte energizada | Autorizado, com procedimento e liberação formal |

Duas confusões comuns valem correção. A primeira: a zona controlada não é um corredor de passagem, é área de trabalho, e entrar nela sem autorização é infração, mesmo que a pessoa não vá tocar em nada. A segunda: os limites saem das tabelas do anexo da norma conforme a tensão, e não do bom senso de quem está ali. Ninguém estima zona de risco a olho.

## Proteção coletiva e individual, nessa ordem

A NR-10 estabelece uma hierarquia que não é negociável: primeiro tenta-se eliminar o risco, depois protege-se o coletivo, e só então entra a proteção individual. EPI é a última barreira, não a primeira.

Proteção coletiva é a desenergização, o aterramento temporário, a barreira, o invólucro, o bloqueio, a sinalização, o obstáculo. Proteção individual entra quando o coletivo é inviável ou insuficiente.

### As luvas isolantes

A luva isolante é classificada pela tensão que suporta. Usar classe abaixo da necessária é o mesmo que não usar.

| Classe | Tensão máxima de uso |
| --- | --- |
| 00 | 500 V |
| 0 | 1.000 V |
| 1 | 7.500 V |
| 2 | 17.000 V |
| 3 | 26.500 V |
| 4 | 36.000 V |

A luva isolante trabalha acompanhada. Por fora vai a **luva de cobertura**, de couro, que a protege do corte e da abrasão, porque um furo de meio milímetro invisível já anula a isolação. Por dentro pode ir a luva de algodão, para o suor.

Antes de cada uso, faz-se o **teste de inflação**: enrola-se o punho para prender ar dentro da luva, aperta-se, e observa-se se ela mantém a forma e se não há assobio ou cheiro de escape. Leva quinze segundos. A luva também tem prazo de ensaio elétrico periódico em laboratório, e luva vencida é luva de mentira.

### O resto do conjunto

- **Vestimenta contra arco elétrico** com ATPV compatível com a energia incidente do ponto. Nada de sintético por baixo.
- **Capacete classe B**, isolante, com jugular.
- **Protetor facial** contra arco, junto com óculos de segurança.
- **Calçado isolante**, sem componente metálico exposto.
- Nada de metal no corpo: relógio, aliança, corrente, pulseira, piercing. Metal conduz e, no arco, esquenta e queima onde encosta.

## O que precisa existir no papel

Antes de o serviço começar, alguns documentos precisam estar prontos. Eles não são burocracia: são a prova de que alguém pensou antes.

- **Prontuário das instalações elétricas**, obrigatório para estabelecimentos com carga instalada acima de 75 kW. Reúne esquemas unifilares, especificação das proteções, procedimentos, relação de autorizados, certificados de treinamento, laudos e resultados de ensaios.
- **Análise preliminar de risco**, feita para o serviço específico, com as medidas de controle definidas antes.
- **Ordem de serviço** ou **permissão de trabalho**, quando aplicável, assinada por quem libera.
- **Procedimento de trabalho** escrito para atividades em instalações energizadas ou de risco relevante.

Se o serviço mudar no meio do caminho, o papel muda junto. Análise de risco feita para trocar um disjuntor não cobre a decisão de aproveitar e mexer no barramento.

## Quando dá errado

### Vítima de choque

O primeiro instinto é o errado. Puxar a vítima com a mão é a forma mais comum de transformar um acidente em dois.

1. **Não toque na vítima.** Enquanto a corrente estiver passando, ela é parte do circuito.
2. **Corte a energia** no disjuntor ou na chave geral. Se não for possível, afaste a vítima com material isolante e seco, estando você também isolado do chão.
3. **Chame socorro**: 192 para o SAMU, 193 para os bombeiros. Diga que é acidente elétrico, porque isso muda a equipe enviada.
4. **Verifique consciência e respiração.** Sem respiração normal, inicie compressões torácicas, cerca de cem a cento e vinte por minuto, no centro do peito, sem interromper.
5. **Use o DEA assim que chegar** e siga as instruções faladas pelo aparelho.
6. **Não solte a vítima do atendimento** mesmo que ela pareça bem. O choque provoca arritmia que aparece horas depois, e queimadura elétrica destrói por dentro muito mais do que mostra na pele.

> Toda vítima de choque vai para avaliação médica, sem exceção, mesmo acordada, andando e conversando. A entrada e a saída da corrente podem ser duas marcas pequenas com um trajeto destruído entre elas.

### Incêndio de origem elétrica

Fogo em equipamento energizado é **classe C**, e o extintor é de CO2 ou pó químico. Água e espuma conduzem, e quem aplica leva o choque de volta pelo jato. A primeira providência, quando dá, é cortar a energia: desenergizado, o fogo passa a ser da classe do material que está queimando.

## De quem é a responsabilidade

**Do empregador:** garantir instalação segura, manter o prontuário, fornecer EPI adequado e em bom estado, treinar e reciclar, autorizar formalmente, custear tudo isso e fiscalizar o cumprimento.

**Do trabalhador:** cumprir os procedimentos, usar corretamente o que recebeu, zelar pela própria segurança e pela dos colegas, comunicar imediatamente qualquer situação que considere de risco, e **interromper a tarefa** diante de risco grave e iminente, comunicando ao superior.

Esse último ponto é um direito, e não uma insubordinação. Parar diante de risco grave e iminente está previsto na norma. Quem manda continuar assume o que vier.

## Os erros que mais aparecem

- Testar o circuito e não testar o detector, antes e depois.
- Confiar na chave aberta sem cadeado e sem etiqueta, porque "ninguém vai mexer".
- Esquecer a fonte alternativa: gerador, nobreak, banco de capacitores, painel solar.
- Usar luva isolante sem a luva de cobertura, ou com o ensaio vencido.
- Deixar relógio ou aliança porque "é só um minutinho".
- Trabalhar sozinho em circuito de risco, sem ninguém para cortar a energia se algo acontecer.
- Ampliar o serviço além do que a análise de risco previu.

## Antes de começar, confira

- A tarefa está prevista em ordem de serviço ou permissão de trabalho?
- Existe análise de risco para **este** serviço?
- Você está formalmente autorizado para ele?
- A instalação foi desenergizada nos seis passos, na ordem?
- O detector foi testado em fonte conhecida antes e depois?
- O aterramento temporário está instalado?
- Todas as fontes alternativas foram identificadas e bloqueadas?
- O EPI está íntegro, na classe certa e dentro do prazo de ensaio?
- Há sinalização visível para quem chegar depois de você?
- Alguém sabe onde você está e o que você está fazendo?

## Glossário

**Arco elétrico:** descarga através do ar entre pontos com diferença de potencial, com temperatura e pressão altíssimas.

**ATPV:** valor, em cal/cm2, que indica quanta energia térmica de arco a vestimenta suporta antes do limiar de queimadura.

**Barreira:** dispositivo que impede contato com parte energizada por qualquer direção habitual de acesso.

**DEA:** desfibrilador externo automático, aparelho que analisa o ritmo cardíaco e aplica choque terapêutico quando indicado.

**DR:** dispositivo diferencial residual, que desliga o circuito ao detectar fuga de corrente, tipicamente 30 mA para proteção de pessoas.

**Equipotencialização:** ligação entre partes condutoras para que fiquem no mesmo potencial, eliminando a diferença que geraria corrente.

**Fibrilação ventricular:** contração desordenada do coração, que deixa de bombear sangue. É a principal causa de morte por choque.

**Prontuário:** conjunto organizado de documentos das instalações elétricas exigido pela norma.

**SEP:** sistema elétrico de potência, o conjunto de geração, transmissão e distribuição.

**Zona controlada:** faixa em torno da parte energizada cujo acesso é restrito a pessoa autorizada.

## Exercícios

**1.** Você abriu a chave geral, testou com o detector e não acusou tensão. Pode começar?

**2.** Por que o detector precisa ser testado depois da medição, e não só antes?

**3.** Uma corrente de 15 mA atravessa o antebraço de um colega em contato com um condutor. Qual o efeito esperado e por que ele é perigoso?

**4.** O painel tem geração solar no telhado. A concessionária foi cortada. A instalação está segura?

**5.** Qual a classe mínima de luva isolante para um serviço em 13.800 V?

**6.** Um colega recebeu um choque, está de pé, falando e diz que passou. O que você faz?

**7.** Pegou fogo num quadro de comando energizado. Qual extintor, e qual a primeira providência?

### Gabarito comentado

**1.** Não. Faltam quatro passos: impedimento de reenergização com cadeado e etiqueta, aterramento temporário com equipotencialização, proteção dos elementos energizados que continuam na zona controlada e sinalização. Chave aberta e ausência de tensão constatada são apenas os passos 1 e 3.

**2.** Porque o detector pode ter falhado entre um momento e outro, com bateria acabando ou ponta partida. Se ele falhou, a leitura de ausência de tensão foi falsa, e você já teria começado a trabalhar acreditando nela. O teste posterior é o que valida a medição feita.

**3.** É a faixa da contração muscular que impede soltar o condutor. O perigo não é o valor em si, é o tempo: a mão fecha em volta do fio, a pessoa não consegue se afastar sozinha, e a corrente segue passando até que alguém corte a energia. Choque que não termina rápido vira choque grave.

**4.** Não. O painel fotovoltaico gera com a luz do dia, independentemente da concessionária, e pode alimentar o circuito pelo inversor. É preciso identificar e bloquear todas as fontes, e é exatamente para esse tipo de situação que existe o aterramento temporário.

**5.** Classe 2, que suporta até 17.000 V. A classe 1 vai só até 7.500 V, abaixo da tensão do serviço.

**6.** Encaminha para avaliação médica imediatamente, mesmo com ele dizendo que está bem, e comunica o acidente. Arritmia após choque pode aparecer horas depois, e a queimadura elétrica destrói tecido no trajeto interno sem mostrar quase nada na pele.

**7.** Extintor de CO2 ou de pó químico, porque é fogo classe C. A primeira providência, sempre que possível, é cortar a energia: desenergizado, o incêndio passa a ser tratado pela classe do material que queima. Água e espuma estão proibidas enquanto houver tensão, porque conduzem pelo jato.

## Referências

- NR-10, Segurança em Instalações e Serviços em Eletricidade, Ministério do Trabalho e Emprego.
- NR-06, Equipamento de Proteção Individual.
- NR-01, Disposições Gerais e Gerenciamento de Riscos Ocupacionais.
- NBR 5410, Instalações elétricas de baixa tensão, ABNT.
- NBR 14039, Instalações elétricas de média tensão, ABNT.
- Diretrizes de ressuscitação cardiopulmonar da American Heart Association, edição vigente.

> Este material é de apoio e não substitui a norma, o procedimento interno da sua empresa nem a orientação do profissional habilitado que responde pela instalação. Em caso de divergência, vale o texto oficial da norma.
'
where codigo = 'NR-10';

-- #####################################################################
-- #  Apostilas aprofundadas: NR-33, NR-35-REC e NR-12
-- #  (vem de 39-apostilas-fundas-1.sql)
-- #####################################################################

-- =====================================================================
--  APOSTILAS APROFUNDADAS, GRUPO 1: NR-33, NR-35-REC e NR-12
--
--  Rode quando quiser. Pode rodar mais de uma vez.
--
--  ATENCAO: CONTEUDO TECNICO. Antes de publicar, a responsavel tecnica
--  precisa conferir. Limites de atmosfera, alturas, prazos de reciclagem
--  e sequencias de bloqueio valem vida, e a norma muda.
--
--  Estes tres vieram primeiro porque sao os de maior risco de morte:
--  espaco confinado, altura e maquina respondem pela maior parte dos
--  acidentes fatais em obra e industria.
--
--  O tamanho acompanha a carga horaria, e nao um numero fixo: NR-33 tem
--  16 horas e ficou com cerca de 2.600 palavras; os de 8 horas, com
--  cerca de 2.100. Apostila maior que o curso e enfeite.
-- =====================================================================

-- ---------------------------------------------------------------------
--  NR-33: Espacos confinados (16h)
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'Espaço confinado mata rápido e mata calado. Não há fogo, não há barulho, não há sangue: a pessoa entra, respira duas vezes e cai. E mata em série, porque quem está de fora vê o colega caído e desce para ajudar, sem equipamento nenhum, e cai também. Boa parte das mortes em espaço confinado no mundo inteiro é de socorrista improvisado, gente que entrou para salvar alguém e virou a segunda vítima.

É por isso que este treinamento existe e é por isso que ele tem regra para tudo. Aqui, boa vontade sem procedimento não salva ninguém: só aumenta o número de corpos.

## Como usar este material

Leia inteiro antes da prova. Depois volte por partes, principalmente na seção do vigia e na do resgate.

- Os **quadros** existem para consulta rápida.
- Os **passos numerados** são sequência obrigatória. A ordem é a proteção.
- Os trechos **recuados, com filete ao lado**, são as coisas que mais matam.
- No fim há **exercícios com gabarito comentado**. Faça antes de olhar a resposta.

## O que você deve saber ao final

- Reconhecer um espaço confinado, inclusive os que não parecem.
- Explicar os três riscos de atmosfera e os limites aceitáveis de cada um.
- Saber o que é a Permissão de Entrada e Trabalho e o que a invalida.
- Executar o seu papel, seja o de trabalhador autorizado, seja o de vigia.
- Entender por que o vigia nunca entra, mesmo vendo o colega caído.
- Reconhecer quando parar e sair.

## O que é um espaço confinado

Para a norma, espaço confinado é qualquer área ou ambiente que reúne três características ao mesmo tempo: não foi projetado para ocupação humana contínua, tem meios limitados de entrada e saída, e a ventilação existente é insuficiente para remover contaminantes ou pode haver deficiência ou enriquecimento de oxigênio.

Repare que nada disso fala de tamanho. Um espaço confinado pode ser grande. O que o define é a combinação: entrar é difícil, sair é mais difícil ainda, e o ar lá dentro não se renova sozinho.

| Costumam ser | Também são, e muita gente esquece |
| --- | --- |
| Tanques e reservatórios | Valas com mais de 1,20 m de profundidade |
| Silos e moegas | Poços de elevador e caixas de passagem |
| Caldeiras e fornos | Galerias, dutos e canaletas fechadas |
| Tubulações de grande diâmetro | Porões e compartimentos de embarcação |
| Caixas de água e cisternas | Espaço entre laje e telhado |

> A pergunta certa não é "isso é um espaço confinado?". É "se eu passar mal aqui dentro, alguém consegue me tirar em dois minutos?". Se a resposta for não, trate como espaço confinado até que alguém habilitado diga o contrário por escrito.

## Os riscos de atmosfera

Este é o grupo que mais mata, e é invisível. Nenhum dos três se enxerga, e dois deles não se cheiram.

### Deficiência de oxigênio

O ar que respiramos tem cerca de 20,9% de oxigênio. Abaixo de 19,5% a atmosfera já é considerada deficiente e a entrada é proibida sem proteção respiratória adequada.

O que assusta é a velocidade. Abaixo de 10% a pessoa perde a consciência em segundos, sem sentir falta de ar antes: o corpo humano avisa quando sobra gás carbônico, e não quando falta oxigênio. Quem entra num tanque com pouco oxigênio não sente sufoco, não fica tonto o suficiente para reagir, simplesmente apaga.

O oxigênio some por consumo (ferrugem, fermentação, decomposição, gente respirando) ou por deslocamento: nitrogênio, argônio ou gás carbônico usados numa purga empurram o ar para fora e ocupam o lugar dele.

### Enriquecimento de oxigênio

Acima de 23% a atmosfera é perigosa pelo motivo oposto. Com oxigênio em excesso, materiais que normalmente resistem passam a queimar com facilidade, e uma faísca que não daria em nada vira incêndio. Vazamento de mangueira de oxigênio de maçarico dentro de um espaço confinado é causa clássica.

### Gases inflamáveis e gases tóxicos

O limite de trabalho é **10% do Limite Inferior de Explosividade**. Acima disso, o serviço para e o espaço é ventilado. Não se trabalha "com cuidado" numa atmosfera explosiva.

Entre os tóxicos, dois merecem nome próprio. O **gás sulfídrico** cheira a ovo podre em concentração baixa e, em concentração alta, **anestesia o olfato**: a pessoa deixa de sentir o cheiro justamente quando ele ficou letal. O **monóxido de carbono** não tem cheiro nenhum e vem de qualquer motor a combustão, inclusive do gerador que alguém deixou ligado do lado de fora, perto da abertura.

> Nariz não é detector. O ar que "está limpo" para o seu nariz pode estar com oxigênio em 15% e gás sulfídrico em nível letal. A única resposta confiável é a do aparelho.

## A medição da atmosfera

A avaliação é feita **sempre antes da entrada** e **continuamente durante** todo o trabalho, com aparelho calibrado e por pessoa capacitada. Ninguém entra para medir: mede-se de fora, com a sonda.

1. **Ligue e teste o detector** em ar limpo, fora do espaço, e confira a carga e a validade da calibração.
2. **Meça na ordem certa**: primeiro oxigênio, depois gases inflamáveis, depois tóxicos. Os sensores de inflamáveis dependem do oxigênio para funcionar, e a leitura sai errada se a ordem for outra.
3. **Meça em três alturas**: topo, meio e fundo. Gás mais pesado que o ar se acumula embaixo, mais leve se acumula em cima, e uma medição só no bocal engana.
4. **Espere o tempo de resposta** do aparelho em cada ponto, sem apressar.
5. **Registre os valores** na permissão de trabalho, com hora.
6. **Mantenha o aparelho ligado** com o trabalhador, dentro do espaço, durante todo o serviço.

| Medida | Aceitável | O que fazer fora da faixa |
| --- | --- | --- |
| Oxigênio | 19,5% a 23% | Ventilar e medir de novo. Não entrar |
| Inflamáveis | até 10% do LIE | Parar, ventilar, procurar a fonte |
| Tóxicos | abaixo do limite do agente | Ventilar, e usar proteção respiratória adequada |

## A Permissão de Entrada e Trabalho

A PET é o documento que autoriza a entrada. Ela é preenchida antes, assinada pelo supervisor de entrada, fica **exposta na entrada do espaço** durante todo o serviço, e vale apenas para aquela equipe, aquele serviço e aquela jornada.

Ela é cancelada, e o serviço para, quando qualquer coisa muda: a atmosfera sai da faixa, o serviço passa a ser outro, entra gente que não estava prevista, cai a ventilação, cai a comunicação, ou termina o turno.

A permissão cancelada e as concluídas ficam arquivadas por **cinco anos**.

## Quem é quem

**Trabalhador autorizado** é quem entra. Precisa de capacitação, de aptidão médica e de autorização formal da empresa.

**Vigia** fica do lado de fora, e o trabalho dele é o mais mal compreendido de todos. Ele não é o ajudante: ele é a vida de quem está dentro.

- Conta quem entra e quem sai, e sabe a qualquer momento quantos estão lá dentro.
- Mantém comunicação constante com quem entrou.
- Vigia o entorno: quem se aproxima, o que muda, o gerador que alguém ligou perto da abertura.
- Aciona o resgate ao primeiro sinal de problema.
- **Nunca entra.** Nem para ajudar, nem por um segundo, nem vendo o colega caído.

**Supervisor de entrada** avalia, emite e assina a PET, garante os recursos, encerra os trabalhos e responde pelo conjunto.

> O vigia que entra deixa quem está dentro sem ninguém para chamar socorro, e vira a segunda vítima. Duas pessoas caídas num tanque não são o dobro de um problema: são um problema sem solução, porque não sobrou quem acionasse o resgate.

## Antes de abrir e de entrar

- **Isolar e sinalizar** a área, impedindo que alguém se aproxime ou caia dentro.
- **Bloquear todas as energias** que alimentam o espaço: elétrica, mecânica, hidráulica, pneumática, térmica e química. Bloqueio com cadeado e etiqueta, e teste de que ficou mesmo sem energia.
- **Bloquear as linhas** de processo que chegam ao espaço, com raquete ou desconexão física. Válvula fechada não é bloqueio: válvula vaza e válvula é aberta por engano.
- **Purgar, lavar e ventilar** conforme o que havia lá dentro.
- **Manter ventilação forçada** durante todo o trabalho, com a tomada de ar em lugar limpo.
- **Preparar o resgate antes**, e não depois: equipe, tripé, cabo, cinturão e proteção respiratória autônoma no local.

## O resgate

Todo espaço confinado precisa de um plano de resgate escrito, com equipe treinada e equipamento no local, **antes** de a primeira pessoa entrar.

O resgate preferido é o **externo**, feito de fora, sem ninguém precisar descer: por isso o trabalhador entra com cinturão tipo paraquedista ligado a um cabo, e o tripé fica montado na abertura. Puxar alguém para fora é sempre melhor do que mandar mais alguém para dentro.

Quando alguém precisa entrar para resgatar, entra com **proteção respiratória autônoma** e com a própria linha de vida, sempre. Nunca com máscara de filtro: filtro não fabrica oxigênio, e numa atmosfera com 12% de oxigênio a máscara com filtro protege exatamente nada.

## Os erros que mais aparecem

- Entrar para "dar uma olhada rápida" sem permissão e sem medição.
- Medir só no bocal, e não no fundo.
- Confiar no cheiro, principalmente com gás sulfídrico.
- Achar que válvula fechada é bloqueio.
- Ligar gerador ou compressor perto da entrada, jogando monóxido para dentro.
- Vigia que sai do posto para buscar ferramenta, ou que entra para ajudar.
- Usar máscara com filtro onde falta oxigênio.
- Continuar o serviço depois que a ventilação parou.

## Antes de entrar, confira

- Existe PET assinada, para este serviço, hoje, e ela está na entrada?
- Você está autorizado e apto para esta função?
- A atmosfera foi medida nas três alturas e os valores estão registrados?
- O detector vai entrar com você, ligado?
- Todas as energias e linhas estão bloqueadas e testadas?
- A ventilação está funcionando e o ar de entrada está limpo?
- O vigia está posicionado, e vocês combinaram como se comunicar?
- O tripé, o cabo e o equipamento de resgate estão montados?
- Você sabe quem chamar e como sair correndo?

## Glossário

**Atmosfera IPVS:** imediatamente perigosa à vida ou à saúde. Condição em que a exposição, mesmo curta, causa dano irreversível ou morte.

**Bloqueio:** impedimento físico de que uma energia volte, com cadeado e etiqueta, e não apenas um botão desligado.

**LIE:** limite inferior de explosividade, a menor concentração de um gás no ar capaz de pegar fogo.

**PET:** Permissão de Entrada e Trabalho.

**Purga:** substituição da atmosfera interna, deslocando o que estava lá dentro.

**Raquete:** disco metálico instalado entre flanges para interromper fisicamente uma linha.

**Vigia:** trabalhador que permanece fora do espaço, acompanha quem entrou e aciona o resgate.

## Exercícios

**1.** Uma vala de 1,50 m de profundidade, aberta e larga, é espaço confinado?

**2.** O detector acusou oxigênio em 20,9% no bocal do tanque. Pode entrar?

**3.** Você sente cheiro de ovo podre ao abrir a boca de visita. Depois de alguns segundos o cheiro some. O que aconteceu?

**4.** Por que a medição segue a ordem oxigênio, inflamáveis e tóxicos?

**5.** O vigia vê o colega desmaiar lá dentro. O que ele faz?

**6.** Vale usar máscara com filtro químico numa atmosfera com 14% de oxigênio?

**7.** A ventilação forçada parou no meio do serviço, e a última medição estava boa. O que fazer?

### Gabarito comentado

**1.** Pode ser, e provavelmente é. A profundidade acima de 1,20 m já dificulta a saída rápida, e gases mais pesados que o ar se acumulam no fundo mesmo com a vala aberta em cima. Quem decide é a avaliação técnica, não a aparência.

**2.** Não. Faltou medir o meio e o fundo. Gás pesado se acumula embaixo, e uma leitura boa no bocal é justamente a leitura que engana. E falta o resto: PET, bloqueios, ventilação, vigia e resgate montado.

**3.** O gás sulfídrico anestesiou o seu olfato. O cheiro sumir não significa que o gás sumiu, significa que a concentração subiu a ponto de você não sentir mais. É um dos sinais mais perigosos que existem, porque parece uma boa notícia.

**4.** Porque os sensores de gases inflamáveis precisam de oxigênio para funcionar. Numa atmosfera pobre em oxigênio, a leitura de inflamáveis sai mais baixa do que a realidade, e o espaço pareceria seguro justamente quando não está.

**5.** Aciona o resgate imediatamente, mantém a comunicação, e faz o resgate pelo lado de fora com o tripé e o cabo, se estiver preparado para isso. O que ele não faz, em hipótese nenhuma, é entrar. Entrar deixa quem está dentro sem ninguém para chamar socorro.

**6.** Não. Filtro químico retém contaminante, não produz oxigênio. Com 14% de oxigênio, a máscara com filtro entrega ar com 14% de oxigênio, e a pessoa desmaia com ela no rosto. Nesse caso só serve equipamento autônomo ou de linha de ar.

**7.** Sair imediatamente e cancelar a permissão. A medição anterior descreve o ar de antes; sem ventilação, a atmosfera muda em minutos, e a que vale é a de agora. Só se volta depois de ventilar e medir de novo.

## Referências

- NR-33, Segurança e Saúde nos Trabalhos em Espaços Confinados.
- NR-01, Disposições Gerais e Gerenciamento de Riscos Ocupacionais.
- NR-06, Equipamento de Proteção Individual.
- NR-15, Atividades e Operações Insalubres.

> Este material é de apoio e não substitui a norma, o procedimento interno da sua empresa nem a orientação do responsável técnico. Em caso de divergência, vale o texto oficial da norma.
'
where codigo = 'NR-33';

-- ---------------------------------------------------------------------
--  NR-35-REC: Trabalho em altura, reciclagem (8h)
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'Você já fez este curso. Esta reciclagem não existe para ensinar de novo o que é um cinturão: existe porque a queda acontece com quem já sabe.

Quem nunca subiu tem medo, e o medo protege. Quem sobe todo dia perde o medo, e é aí que aparece o "só um instante", o talabarte solto durante o deslocamento, a ancoragem escolhida no olho. As estatísticas de queda no Brasil não são feitas de novatos: são feitas de gente experiente num dia comum.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os **passos numerados** são sequência obrigatória.
- Os trechos **recuados, com filete ao lado**, são as coisas que mais matam.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Reconhecer quando a atividade é trabalho em altura e o que ela exige.
- Aplicar a hierarquia: evitar, depois proteger o coletivo, depois o indivíduo.
- Escolher e inspecionar o sistema de retenção de queda.
- Calcular mentalmente a zona livre de queda antes de se ancorar.
- Explicar o que é trauma de suspensão e por que o resgate tem minutos.
- Reconhecer as condições que impedem o trabalho e recusá-lo.

## O que conta como trabalho em altura

Toda atividade executada **acima de 2,00 m do nível inferior**, onde haja risco de queda. Não importa o tempo: trocar uma lâmpada em três minutos é trabalho em altura.

E o risco de queda não some abaixo de dois metros. Queda de 1,80 m sobre uma ferragem exposta mata igual. A norma dá um piso, não uma licença.

## A ordem das proteções

A norma manda seguir uma ordem, e ela não é negociável.

1. **Evitar o trabalho em altura.** Dá para fazer no chão? Montar embaixo e içar depois? Usar ferramenta com extensão? A queda que não acontece é a que foi eliminada no planejamento.
2. **Proteger o coletivo.** Guarda-corpo, rodapé, plataforma, rede, fechamento de abertura no piso. Protege todo mundo, inclusive quem chegou agora e não sabe de nada.
3. **Proteger o indivíduo.** Sistema de retenção de queda, quando as duas primeiras não bastam.

> Cinturão é a última barreira, não a primeira. Onde cabe guarda-corpo, o certo é guarda-corpo: ele protege sem depender de a pessoa lembrar de se prender.

## Análise de risco e permissão de trabalho

Toda atividade em altura exige **análise de risco**, feita antes, considerando o local, o acesso, o clima, os riscos adicionais (energia, espaço confinado, material que pode cair) e o resgate.

Quando a atividade não está prevista em procedimento operacional, ela exige também **Permissão de Trabalho**, emitida antes, válida para a jornada e encerrada ao fim dela.

## O sistema que segura você

| Peça | O que faz | O que anula |
| --- | --- | --- |
| Cinturão paraquedista | Distribui o impacto pelo corpo | Cinto abdominal, proibido para retenção |
| Talabarte duplo | Permite deslocar sempre preso | Soltar os dois ao mesmo tempo |
| Absorvedor de energia | Reduz a força do tranco | Absorvedor já acionado, que deve ser descartado |
| Trava-queda | Acompanha e trava na queda | Instalar de cabeça para baixo |
| Ponto de ancoragem | Sustenta a carga da queda | Escolher no olho, sem avaliação |

O ponto de ancoragem precisa ser avaliado por profissional habilitado e, sempre que possível, ficar **acima do nível da cintura**, de preferência acima da cabeça. Quanto mais alto o ponto, menor a queda e menor o tranco.

### Zona livre de queda

É a distância que precisa existir abaixo de você para que o sistema tenha espaço de trabalhar. Ela soma o comprimento do talabarte, a abertura do absorvedor, a altura do seu corpo abaixo do ponto de conexão e uma folga de segurança.

Fazer a conta importa: um talabarte de 1,80 m com absorvedor acionado precisa de bem mais de dois metros livres. Ancorado nos pés, numa plataforma baixa, a pessoa cai o dobro e chega ao chão antes de o sistema terminar de agir.

## Trauma de suspensão

Este é o assunto que mais se esquece entre uma reciclagem e outra, e é o que transforma uma queda contida em morte.

Quem fica pendurado no cinturão, **parado e consciente**, começa a ter o retorno do sangue das pernas prejudicado pelas correias das coxas. Em poucos minutos vem tontura, náusea e desmaio. Quem está inconsciente, pendurado, tem ainda menos tempo.

Por isso o resgate não pode depender de chamar alguém de fora e esperar. **O plano de resgate faz parte do trabalho**, com equipe e equipamento no local, capaz de tirar a pessoa da suspensão em poucos minutos.

Enquanto o resgate não chega, quem está pendurado e consciente deve mexer as pernas, apoiar os pés em qualquer coisa e usar o estribo de alívio, se houver, para tirar a pressão das correias.

## Antes de subir

1. **Confira a análise de risco e a permissão**, e veja se elas descrevem o serviço que você vai realmente fazer.
2. **Inspecione o EPI** peça por peça: costura, fita, fivela, mosquetão, trava, absorvedor. Qualquer corte, queimadura, mofo, deformação ou etiqueta ilegível reprova o equipamento.
3. **Confirme a ancoragem** indicada, e a altura dela.
4. **Calcule a zona livre de queda** para o ponto que você vai usar.
5. **Verifique o clima**: vento, chuva, trovoada, superfície molhada.
6. **Isole a área abaixo**, porque ferramenta cai.
7. **Combine o resgate**: quem, com o quê, e em quanto tempo.

> Equipamento que sofreu uma queda sai de uso, mesmo parecendo inteiro. O absorvedor já gastou o que tinha para gastar, e as fibras que esticaram não voltam. Não se guarda para "usar num serviço leve".

## Quando não se sobe

- Vento forte, chuva, tempestade com raios.
- Superfície escorregadia, gelada ou instável.
- Trabalhador sem aptidão médica válida, ou passando mal.
- Sem ancoragem avaliada, sem resgate planejado, sem permissão quando exigida.
- Sozinho, quando o serviço exige acompanhamento.

Recusar trabalho diante de risco grave e iminente é direito previsto, e não insubordinação. Quem manda subir assim assume o que vier.

## Os erros que mais aparecem

- Soltar os dois talabartes ao mesmo tempo para "passar rapidinho".
- Ancorar no primeiro cano que aparece, sem saber o que ele aguenta.
- Ancorar abaixo dos pés e dobrar a altura da queda.
- Usar cinto abdominal em vez de paraquedista.
- Guardar equipamento que já sofreu queda.
- Subir escada com ferramenta na mão, em vez de içá-la.
- Deixar o resgate para "se acontecer".

## Glossário

**Absorvedor de energia:** dispositivo que se abre na queda e reduz a força que chega ao corpo.

**Ancoragem:** ponto ou dispositivo capaz de suportar as cargas de uma queda, avaliado por profissional habilitado.

**Fator de queda:** relação entre a distância da queda e o comprimento do talabarte. Quanto maior, mais violento o tranco.

**Retenção de queda:** sistema que detém a queda depois que ela começa.

**Trava-queda:** dispositivo que corre na linha de vida e trava quando o movimento é brusco.

**Zona livre de queda:** espaço livre necessário abaixo do trabalhador para o sistema atuar sem que ele bata no nível inferior.

## Exercícios

**1.** Trocar uma lâmpada a 2,20 m, em cinco minutos, exige tudo isso mesmo?

**2.** Por que ancorar acima da cabeça é melhor do que ancorar na altura dos pés?

**3.** O talabarte tem 1,80 m e você vai se ancorar num ponto na altura da cintura, numa plataforma a 3 m do chão. Qual é o problema?

**4.** O colega caiu, o cinturão segurou, e ele está pendurado, consciente, a quatro metros do chão. Qual é a urgência?

**5.** O absorvedor de energia está aberto, mas as fitas parecem íntegras. Pode usar?

**6.** Começou a ventar forte no meio do serviço. O que fazer?

### Gabarito comentado

**1.** Exige. A norma não fala em duração, fala em altura e em risco de queda. Cinco minutos a 2,20 m é trabalho em altura, com análise de risco, EPI adequado, ancoragem avaliada e resgate previsto. A maior parte das quedas graves acontece em serviço rápido.

**2.** Porque a distância que você cai antes de o sistema agir é menor, e o tranco também. Ancorado acima da cabeça, a queda é curta. Ancorado nos pés, você cai o comprimento do talabarte duas vezes antes de o sistema começar a trabalhar.

**3.** A zona livre de queda não fecha. Somando o talabarte, a abertura do absorvedor, a distância do seu corpo abaixo do ponto de conexão e a folga de segurança, você precisa de mais do que os três metros disponíveis: o sistema seguraria você já no chão.

**4.** O trauma de suspensão. Pendurado e parado, o retorno do sangue das pernas fica prejudicado e em poucos minutos vem desmaio. O resgate tem que sair agora, com equipamento que já esteja no local. Enquanto isso, ele deve mexer as pernas e buscar apoio para os pés.

**5.** Não. Absorvedor aberto é absorvedor que já trabalhou: ele gastou o que tinha para gastar, e numa segunda queda não abre de novo. O conjunto sai de uso e é descartado.

**6.** Interromper, descer com segurança e reavaliar. Vento forte é condição impeditiva, e a análise de risco foi feita para outro cenário. Retomar só quando as condições voltarem, com a permissão revalidada.

## Referências

- NR-35, Trabalho em Altura.
- NR-06, Equipamento de Proteção Individual.
- NR-18, Segurança e Saúde no Trabalho na Indústria da Construção.
- NR-01, Disposições Gerais e Gerenciamento de Riscos Ocupacionais.

> Este material é de apoio e não substitui a norma, o procedimento interno da sua empresa nem a orientação do responsável técnico. Em caso de divergência, vale o texto oficial da norma.
'
where codigo = 'NR-35-REC';

-- ---------------------------------------------------------------------
--  NR-12: Maquinas e equipamentos (8h)
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'Máquina não tem má intenção e não tem pressa. Ela faz exatamente o que foi mandada fazer, com a mesma força, com a mesma velocidade, na hora em que a energia chega. É por isso que ela é previsível, e é por isso que quase todo acidente com máquina tem uma explicação simples depois: alguém pôs a mão onde a máquina ia passar, achando que ela estava desligada.

A maior parte das amputações no trabalho acontece com máquina que a pessoa operava havia anos.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os **passos numerados** são sequência obrigatória.
- Os trechos **recuados, com filete ao lado**, são as coisas que mais mutilam.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Identificar a zona de perigo de uma máquina e os movimentos que ferem.
- Reconhecer os tipos de proteção e saber quando cada um se aplica.
- Entender por que anular uma proteção é falta grave.
- Bloquear energia antes de qualquer manutenção, inclusive a energia guardada.
- Saber o que conferir antes de ligar e quando parar.

## O que fere numa máquina

Antes de falar de proteção, é preciso enxergar o perigo. Os movimentos que ferem são poucos e se repetem em máquinas muito diferentes.

| Movimento | Como acontece | Onde aparece |
| --- | --- | --- |
| Prensagem | Duas superfícies se aproximam | Prensa, dobradeira, injetora |
| Cisalhamento | Duas partes deslizam como tesoura | Guilhotina, portão, esteira |
| Corte | Ferramenta afiada em movimento | Serra, fresa, faca de moinho |
| Arrastamento | Peça gira e puxa junto | Rolo, correia, eixo, broca |
| Impacto | Peça em movimento atinge o corpo | Martelo, braço robótico |
| Projeção | Material ou parte se solta | Rebolo, torno, sopradora |

Repare no arrastamento. Ele é o que pega mais gente, porque não parece perigoso: um eixo girando devagar, uma correia lisa. Basta uma manga, uma luva, um cordão de crachá ou um cabelo, e o corpo inteiro vai junto em menos de um segundo.

> Perto de máquina rotativa, luva é risco, e não proteção. Manga solta, anel, corrente, relógio e cabelo solto entram na mesma lista. O que segura a peça é a máquina; o que a máquina agarra é você.

## As proteções

A norma segue uma ordem: primeiro tenta-se eliminar o risco no projeto, depois protege-se o coletivo, e só então entra a proteção individual.

**Proteção fixa** é a que só sai com ferramenta. É a mais confiável, porque ninguém a abre por impulso.

**Proteção móvel com intertravamento** é a porta que, ao ser aberta, faz a máquina parar. E ela precisa parar de verdade: intertravamento que só acende uma luz não é proteção.

**Dispositivos de segurança** substituem a barreira física onde ela impediria o trabalho: cortina de luz, tapete sensível, comando bimanual, chave de segurança, scanner de área.

**Parada de emergência** é obrigatória, precisa estar ao alcance de quem opera, tem que parar tudo, e o rearme dela é sempre manual: a máquina nunca volta a andar sozinha depois que alguém apertou o botão.

### Anular proteção

Amarrar a porta, colar fita no sensor, pôr um imã na chave de segurança, travar o comando bimanual com um pedaço de madeira: tudo isso é anular proteção, e é falta grave.

Quem anula quase sempre tem um motivo prático e verdadeiro, geralmente a produção. O problema é que o dispositivo é a única coisa entre a mão e a zona de prensagem. Se ele atrapalha o trabalho, o caminho é comunicar e ajustar o processo, e não desarmar o que segura o acidente.

## Manutenção: bloqueio de energia

Nenhuma limpeza, ajuste, desatolamento ou manutenção é feita com a máquina energizada. E "desligada no botão" não é o mesmo que "sem energia".

1. **Avise** quem opera e quem depende da máquina.
2. **Pare** pelo procedimento normal.
3. **Seccione** todas as fontes: elétrica, pneumática, hidráulica, térmica, química.
4. **Bloqueie com cadeado** cada dispositivo de corte, e **etiquete** com nome, data e serviço. Cada pessoa põe o seu cadeado; a máquina só volta quando o último sair.
5. **Dissipe a energia guardada**: peça suspensa que pode descer pelo próprio peso, mola comprimida, ar no reservatório, óleo sob pressão, capacitor carregado, superfície quente.
6. **Teste**: acione o comando e confirme que nada se move.

> A energia que mais surpreende não é a da tomada, é a que já estava dentro da máquina. Cilindro pneumático com ar preso, prensa com a matriz no alto, contrapeso, mola de retorno: tudo isso trabalha depois que a chave geral já foi desligada.

## Quem pode operar

Operação só por trabalhador **capacitado e formalmente autorizado** pela empresa, com treinamento específico daquela máquina.

A máquina precisa ter manual em português, inventário atualizado e sinalização legível. E toda máquina precisa de procedimento de trabalho e segurança acessível a quem opera.

## Antes de ligar, confira

- Você está autorizado para esta máquina?
- Todas as proteções estão no lugar, íntegras e funcionando?
- A parada de emergência está acessível e testada?
- A área está livre de pessoas e de material solto?
- Não há ferramenta esquecida dentro da máquina?
- O painel elétrico está fechado e o aterramento em ordem?
- Você está sem luva, anel, relógio, corrente e com a manga fechada?
- Você sabe como parar tudo em um segundo?

## Os erros que mais aparecem

- Limpar, desatolar ou ajustar com a máquina ligada.
- Anular sensor ou intertravamento para ganhar tempo.
- Confiar no botão desligado em vez de bloquear com cadeado.
- Esquecer a energia guardada: peça suspensa, mola, ar comprimido.
- Usar luva perto de rotativo.
- Operar máquina para a qual não foi capacitado, "porque é parecida".
- Deixar a proteção de fora depois da manutenção.

## Glossário

**Bloqueio e etiquetagem:** procedimento de travar fisicamente as fontes de energia e identificar quem travou e por quê.

**Comando bimanual:** dispositivo que exige as duas mãos ao mesmo tempo, mantendo-as fora da zona de perigo.

**Cortina de luz:** barreira ótica que para a máquina quando algo atravessa o feixe.

**Intertravamento:** ligação entre a proteção e o comando, que impede o funcionamento com a proteção aberta.

**Zona de perigo:** região da máquina onde o corpo pode ser atingido.

## Exercícios

**1.** A peça travou na esteira. Dá para tirar com a máquina em movimento lento?

**2.** Por que luva pode ser mais perigosa do que a mão nua perto de um eixo girando?

**3.** A chave geral foi desligada e cadeada. A prensa está segura?

**4.** Um colega pôs fita no sensor da porta porque ele "dispara sozinho". O que fazer?

**5.** Dois mantenedores vão trabalhar na mesma máquina. Quantos cadeados?

**6.** O botão de emergência foi apertado e o problema resolvido. A máquina pode voltar sozinha?

### Gabarito comentado

**1.** Não. Desatolamento é manutenção, e manutenção é feita com a máquina parada e bloqueada. Movimento lento continua tendo toda a força, e é justamente nesse tipo de intervenção rápida que acontece a maior parte das amputações.

**2.** Porque a luva dá ao eixo uma superfície para agarrar. A mão nua pode escapar; a luva é puxada e leva a mão junto, e o braço atrás. Perto de rotativo, luva é risco.

**3.** Ainda não necessariamente. Falta dissipar a energia guardada: se a matriz está suspensa, ela pode descer pelo próprio peso; pode haver ar no reservatório e óleo sob pressão. Só depois de dissipar e testar o comando é que a máquina está segura.

**4.** Não usar a máquina e comunicar imediatamente. Sensor que dispara sozinho é defeito para manutenção corrigir. A fita transforma um defeito num acidente esperando acontecer, e quem anula responde por isso.

**5.** Dois, um de cada. Cada pessoa põe o seu cadeado e guarda a própria chave, e a máquina só religa quando o último cadeado sair. Com um cadeado só, quem sair primeiro libera a máquina com o colega ainda dentro dela.

**6.** Não. O rearme da parada de emergência é sempre manual, e o religamento é uma ação consciente de quem opera. Máquina que volta sozinha depois de uma emergência pega quem foi verificar o que aconteceu.

## Referências

- NR-12, Segurança no Trabalho em Máquinas e Equipamentos.
- NR-10, Segurança em Instalações e Serviços em Eletricidade.
- NR-06, Equipamento de Proteção Individual.
- NR-01, Disposições Gerais e Gerenciamento de Riscos Ocupacionais.

> Este material é de apoio e não substitui a norma, o procedimento interno da sua empresa nem a orientação do responsável técnico. Em caso de divergência, vale o texto oficial da norma.
'
where codigo = 'NR-12';

-- #####################################################################
-- #  Apostilas aprofundadas: NR-10-SEP, NR-05 (CIPA) e NR-11
-- #  (vem de 40-apostilas-fundas-2.sql)
-- #####################################################################

-- =====================================================================
--  APOSTILAS APROFUNDADAS, GRUPO 2: NR-10-SEP, NR-05 (CIPA) e NR-11
--
--  Rode quando quiser. Pode rodar mais de uma vez.
--
--  ATENCAO: CONTEUDO TECNICO. Antes de publicar, a responsavel tecnica
--  precisa conferir. Distancias, cargas horarias, prazos de mandato e
--  regras de estabilidade mudam com a norma.
--
--  A CIPA merece atencao especial na conferencia: a Lei 14.457/2022
--  acrescentou as medidas contra assedio e mudou ate o nome da comissao.
--  E a parte mais recente, e a que mais gente ainda ensina errado.
-- =====================================================================

-- ---------------------------------------------------------------------
--  NR-10-SEP: Eletricidade, complementar (40h)
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'No curso básico você aprendeu que a regra de ouro é desenergizar. No sistema elétrico de potência essa regra continua valendo, e continua sendo difícil pelo mesmo motivo de sempre: desligar uma linha significa deixar bairro, hospital ou fábrica sem energia. A pressão para trabalhar energizado é maior aqui do que em qualquer outro lugar.

E as consequências também. Em baixa tensão, o erro dá choque. No SEP, com dezenas de milhares de volts, o erro dá arco, e arco a essa tensão não perdoa: não é preciso encostar em nada, basta chegar perto demais.

Este complementar existe porque o SEP tem outra escala, outro tipo de instalação e outro tipo de acidente.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os **passos numerados** são sequência obrigatória.
- Os trechos **recuados, com filete ao lado**, são as coisas que mais matam.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Reconhecer o que é o SEP e onde ficam as fronteiras dele.
- Explicar por que a distância é uma proteção, e não uma recomendação.
- Executar a desenergização em alta tensão, incluindo o aterramento temporário.
- Entender o papel do centro de operação e por que ninguém manobra por conta própria.
- Reconhecer os riscos que só existem aqui: linha viva, altura em estrutura, câmara subterrânea, animal peçonhento.
- Agir nos primeiros minutos de um acidente com queimadura por arco.

## O que é o sistema elétrico de potência

O SEP é o conjunto que leva a energia da usina até o consumidor: **geração, transmissão e distribuição**, com as subestações que ligam uma coisa à outra.

Cada trecho tem a sua natureza. A transmissão trabalha com as tensões mais altas, em linhas longas e torres altas, longe de tudo. A distribuição trabalha mais perto das pessoas, no meio da rua, com poste, transformador e ramal, e por isso convive com trânsito, pedestre, casa e árvore. Subestação concentra equipamento pesado, área classificada e manobra.

Vale para todas as fases: projeto, construção, montagem, operação, manutenção, reforma e ampliação. E vale para quem trabalha nas proximidades, não só para quem põe a mão.

> A fronteira do SEP não é o portão da empresa: é onde a instalação faz parte do sistema de potência. Quem entra em subestação de cliente, em cabine primária ou em rede da concessionária está no SEP, mesmo que a empresa dele seja pequena.

## A distância é a proteção

Em baixa tensão a proteção principal é a barreira física. Em alta tensão, boa parte da proteção é **espaço vazio**: o ar entre você e a parte energizada é o isolante, e ele só isola se for suficiente.

Por isso as zonas de risco e controlada aqui são grandes, e crescem com a tensão. As distâncias saem das tabelas da norma conforme o nível de tensão da instalação, e nunca do bom senso de quem está ali.

O que muda na prática, e que quem vem da baixa tensão estranha:

- Ferramenta comprida vira parte do corpo. Vara, escada, trena metálica, cabo de içamento e até o jato de água de uma lavagem entram na conta da distância.
- Caminhão munck, cesto aéreo e guindaste têm distância própria, e quem opera precisa saber qual é.
- Aproximar sem tocar já é acidente esperando acontecer, porque o arco atravessa o ar.

## Antes de tocar: a desenergização em alta tensão

A sequência é a mesma do básico, com peso maior em cada passo.

1. **Solicitar e obter a liberação** junto ao centro de operação, com registro. Ninguém manobra por conta própria no SEP: a instalação faz parte de um sistema, e o que você abre aqui apaga alguma coisa lá.
2. **Seccionar**, com abertura plenamente visível ou comprovada, e conferir a posição real do equipamento, e não apenas a sinalização do painel.
3. **Impedir a reenergização**, com bloqueio, travamento e etiqueta, e com o centro de operação sabendo.
4. **Constatar a ausência de tensão** com detector adequado à tensão, testado em fonte conhecida antes e depois.
5. **Aterrar e equipotencializar**, instalando o conjunto de aterramento temporário em todos os condutores, dos dois lados do ponto de trabalho quando houver alimentação por mais de um lado.
6. **Proteger os elementos energizados** que continuam por perto e **sinalizar** a área.

> O aterramento temporário no SEP não protege só contra religação: protege contra **tensão induzida** pela linha vizinha que continua energizada, e contra descarga atmosférica em linha longa. Uma linha desligada, correndo paralela a outra energizada por quilômetros, tem tensão suficiente para matar.

O conjunto de aterramento precisa ser dimensionado para a **corrente de curto-circuito prevista naquele ponto**. Conjunto subdimensionado se rompe no momento em que mais precisaria segurar, e a proteção some justamente quando a energia volta.

### Reenergizar

1. Retirar ferramentas, equipamentos e pessoas.
2. Remover os aterramentos temporários e a equipotencialização.
3. Remover a sinalização e o bloqueio.
4. Comunicar o centro de operação e só então autorizar a energização.

Quem autoriza é o responsável pelo serviço, depois de confirmar que todos saíram. Nunca o operador que está com pressa, nunca o primeiro que chega ao painel.

## Trabalho em linha viva

Existe, é feito, e não é assunto de improviso. Trabalho energizado no SEP exige justificativa técnica, procedimento escrito, equipe treinada especificamente para o método, ferramental próprio e supervisão.

| Método | Como é |
| --- | --- |
| Ao contato | Com luvas isolantes classe adequada, tocando o condutor protegido |
| À distância | Com varas de manobra, sem aproximação do corpo |
| Ao potencial | O trabalhador se coloca no mesmo potencial da linha, isolado da terra |

O que vale para você saber agora: **você só participa disso se foi treinado para aquele método específico e autorizado por escrito**. Não existe "ajudar" numa equipe de linha viva.

## Os riscos que só aparecem aqui

**Altura.** Poste, torre e estrutura são trabalho em altura com tudo o que a NR-35 exige, feito ao lado de parte energizada.

**Espaço confinado.** Câmara subterrânea, caixa de passagem e galeria de cabos são espaço confinado com risco elétrico junto. Vale a NR-33 inteira: medição, permissão, vigia e resgate.

**Ambiente.** Serviço em rede de distribuição acontece na rua, com trânsito passando: sinalização viária e isolamento da área fazem parte da proteção. E acontece no mato, com animal peçonhento em poste, caixa e transformador.

**Campos eletromagnéticos.** Presentes em alta tensão, entram na avaliação de risco da atividade.

**Área classificada.** Em subestação e em instalação com risco de atmosfera explosiva, o equipamento precisa ser próprio para a área, e a permissão de trabalho a quente vale integralmente.

## O ferramental e a roupa

- **Detector de tensão para alta tensão**, com validade de aferição em dia, testado antes e depois.
- **Vara de manobra** limpa, seca e com ensaio no prazo. Vara suja conduz.
- **Conjunto de aterramento temporário** dimensionado para a corrente de curto do ponto, com garras e cabos íntegros.
- **Luvas isolantes de classe compatível com a tensão**, com luva de cobertura por fora e ensaio periódico em dia.
- **Vestimenta contra arco elétrico** com ATPV compatível com a energia incidente calculada, sem nada sintético por baixo.
- **Capacete classe B, protetor facial contra arco, calçado isolante**, e nenhum metal no corpo.

Tudo isso tem prazo de ensaio em laboratório. Equipamento vencido é equipamento de mentira: parece proteção e não é.

## Quando algo dá errado

A queimadura por arco é diferente da queimadura comum: atinge grande superfície, vem acompanhada de trauma pela projeção e, quase sempre, de lesão respiratória pelo ar superaquecido.

1. **Garanta a própria segurança primeiro.** Não se aproxime enquanto houver parte energizada exposta ou possibilidade de religamento.
2. **Peça o desligamento** ao centro de operação e confirme.
3. **Chame o socorro**: 192, dizendo que é acidente elétrico com queimadura, porque isso muda a equipe enviada.
4. **Não remova roupa grudada** na pele nem aplique nada sobre a queimadura.
5. **Cubra com pano limpo e seco**, mantenha a pessoa aquecida e monitore a respiração.
6. **Sem respiração normal**, inicie compressões torácicas e use o DEA assim que chegar.
7. **Toda vítima vai para avaliação médica**, mesmo consciente e andando.

## Os erros que mais aparecem

- Confiar na sinalização do painel em vez de conferir a posição real do equipamento.
- Aterrar de um lado só, numa linha alimentada por dois.
- Usar conjunto de aterramento sem saber a corrente de curto do ponto.
- Esquecer a tensão induzida da linha paralela que continua energizada.
- Manobrar sem falar com o centro de operação.
- Aproximar munck, cesto ou escada sem calcular a distância.
- Trabalhar com ensaio de luva ou de vara vencido.

## Antes de começar, confira

- Existe ordem de serviço e análise de risco para **este** serviço?
- A liberação com o centro de operação foi obtida e registrada?
- O seccionamento é visível ou comprovado, e a posição real foi conferida?
- O detector foi testado em fonte conhecida antes e depois?
- Há aterramento temporário em todos os condutores e de todos os lados que alimentam?
- O conjunto de aterramento serve para a corrente de curto deste ponto?
- A distância para ferramentas, veículos e equipamentos foi calculada?
- Os ensaios das luvas, das varas e do detector estão no prazo?
- O plano de resgate cobre altura e espaço confinado, se houver?

## Glossário

**Centro de operação:** onde se comanda e se autoriza a manobra do sistema. Nada se abre nem se fecha no SEP sem passar por ele.

**Corrente de curto-circuito:** a corrente que circula num defeito. É ela que dimensiona o conjunto de aterramento.

**Equipotencialização:** ligar as partes condutoras entre si para que fiquem no mesmo potencial, eliminando a diferença que geraria corrente pelo corpo.

**Linha viva:** trabalho executado com a instalação energizada, por método específico.

**SEP:** sistema elétrico de potência, o conjunto de geração, transmissão e distribuição.

**Tensão induzida:** tensão que aparece num condutor desligado por efeito de outro, energizado e próximo.

## Exercícios

**1.** A linha foi desligada e aterrada num lado só. Ela é alimentada por dois. Qual é o risco?

**2.** Por que uma linha desligada, paralela a outra energizada, pode matar?

**3.** O painel indica que o disjuntor está aberto. Isso basta?

**4.** O conjunto de aterramento disponível é o de sempre, mas ninguém sabe a corrente de curto deste ponto. Pode usar?

**5.** Um caminhão munck precisa operar perto da rede. O que define se pode?

**6.** Um colega sofreu queimadura por arco e a roupa está grudada na pele. O que você faz?

### Gabarito comentado

**1.** A energia pode voltar pelo lado que não foi aterrado, e o aterramento instalado não protege contra isso. Quando há alimentação por mais de um lado, aterra-se dos dois, cercando o ponto de trabalho.

**2.** Por tensão induzida. Correndo paralela por quilômetros, a linha energizada induz tensão na desligada, e ela chega a valores letais. É por isso que o aterramento temporário não é apenas contra religação indevida.

**3.** Não. Indicação de painel é informação, não é constatação: contato pode estar colado, a sinalização pode estar errada e o equipamento pode não ter completado a abertura. Confere-se a posição real e, depois, mede-se a ausência de tensão.

**4.** Não. O conjunto tem que suportar a corrente de curto prevista para aquele ponto; subdimensionado, ele se rompe justamente quando a energia volta, e a proteção some no pior momento. Sem o dado, o serviço não começa.

**5.** A distância de segurança para aquela tensão, considerando o alcance máximo da lança, e não a posição em que o caminhão está parado. Quem opera precisa saber a distância, e a área precisa estar isolada e sinalizada.

**6.** Não remove a roupa grudada e não aplica nada sobre a queimadura. Cobre com pano limpo e seco, mantém a pessoa aquecida, chama o 192 dizendo que é acidente elétrico com queimadura, e monitora a respiração. Remover a roupa arranca a pele junto.

## Referências

- NR-10, Segurança em Instalações e Serviços em Eletricidade, com o anexo do SEP.
- NR-35, Trabalho em Altura.
- NR-33, Segurança e Saúde nos Trabalhos em Espaços Confinados.
- NR-06, Equipamento de Proteção Individual.
- NBR 14039, Instalações elétricas de média tensão, ABNT.

> Este material é de apoio e não substitui a norma, o procedimento interno da sua empresa nem a orientação do profissional habilitado que responde pela instalação. Em caso de divergência, vale o texto oficial da norma.
'
where codigo = 'NR-10-SEP';

-- ---------------------------------------------------------------------
--  NR-05: CIPA (20h)
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'A CIPA é a única instância da empresa onde trabalhador e empregador sentam do mesmo lado da mesa para tratar de segurança. Não é sindicato, não é departamento e não é comissão de festa: é o lugar onde quem faz o serviço conta o que enxerga do chão de fábrica, e quem decide ouve.

Ela funciona ou não funciona pelo mesmo motivo: quando as reuniões viram assinatura de ata, ninguém leva a sério; quando as recomendações viram ação com prazo e responsável, a CIPA passa a ser o instrumento mais barato de prevenção que a empresa tem.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os **passos numerados** são sequência.
- Os trechos **recuados, com filete ao lado**, são os pontos que mais geram dúvida e autuação.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Explicar para que serve a CIPA e o que ela não é.
- Saber como ela é composta, eleita e dimensionada.
- Conhecer a estabilidade do cipeiro e os limites dela.
- Conduzir e registrar uma reunião, e escrever uma recomendação que funcione.
- Investigar um acidente procurando a causa, e não o culpado.
- Aplicar as medidas contra assédio que passaram a ser atribuição da comissão.

## O nome mudou, e o motivo importa

Desde a Lei 14.457, de 2022, a sigla passou a significar **Comissão Interna de Prevenção de Acidentes e de Assédio**. Não foi troca de letra: a lei acrescentou à comissão a tarefa de participar das medidas de prevenção e combate ao assédio sexual e às demais formas de violência no trabalho.

Na prática isso significa que a CIPA passou a tratar também do que adoece sem deixar marca visível, e que o treinamento dos cipeiros precisa incluir o tema.

## Para que ela serve

A finalidade é simples de enunciar: **observar e relatar as condições de risco no ambiente de trabalho, e solicitar medidas para reduzir ou eliminar esses riscos**.

O que ela faz, na prática:

- Acompanha o inventário de riscos e o plano de ação do PGR.
- Identifica situações de risco que aparecem no dia a dia e que não estavam no papel.
- Participa da investigação dos acidentes e das doenças relacionadas ao trabalho.
- Verifica se as medidas combinadas foram cumpridas, e cobra quando não foram.
- Promove a SIPAT e as ações de conscientização.
- Participa das medidas contra o assédio e a violência no trabalho.

O que ela **não** é: não é fiscal, não pune, não substitui o SESMT e não decide sozinha o investimento. A CIPA recomenda, registra e cobra. A responsabilidade pela execução continua sendo do empregador.

## Como ela é formada

A comissão tem duas metades. Os representantes do **empregador são designados** por ele. Os representantes dos **empregados são eleitos** por voto secreto, em eleição organizada pela empresa com comissão eleitoral própria.

| Cargo | Quem escolhe |
| --- | --- |
| Presidente | Designado pelo empregador |
| Vice-presidente | Escolhido pelos titulares eleitos dos empregados |
| Secretário | Definido de comum acordo |

O **mandato é de um ano**, permitida uma reeleição. O número de membros sai do quadro da própria norma, conforme a atividade da empresa e o número de empregados. Empresa pequena demais para ter comissão designa um responsável pelo cumprimento das atribuições.

### A estabilidade

O empregado eleito, titular ou suplente, tem garantia de emprego **desde o registro da candidatura até um ano após o fim do mandato**. Ele não pode ser dispensado sem motivo, exceto por falta grave, por motivo disciplinar, técnico, econômico ou financeiro devidamente comprovado.

> A estabilidade não é prêmio nem blindagem: existe para que o cipeiro possa apontar um risco incômodo sem medo de perder o emprego por causa disso. Um cipeiro que não pode falar não serve para nada, e a comissão inteira vira encenação.

Representante designado pelo empregador não tem essa garantia, porque ele não corre esse risco.

## As reuniões

As reuniões ordinárias são **mensais**, em horário de expediente, com **ata registrada**. Reunião extraordinária acontece quando há acidente grave ou fatal, ou quando a situação exige.

Uma reunião que funciona tem sempre a mesma espinha:

1. **Leitura da ata anterior** e conferência do que ficou pendente. Item que não é cobrado nunca é feito.
2. **Relato do que foi observado** no período, por quem observou, com local e situação.
3. **Análise dos acidentes e quase acidentes** ocorridos.
4. **Decisão sobre recomendações**, cada uma com responsável e prazo.
5. **Registro em ata**, assinada, com o que foi decidido e por quem.

### Uma recomendação que funciona

Recomendação vaga morre na ata. Compare:

| Não funciona | Funciona |
| --- | --- |
| "Melhorar a sinalização" | "Instalar faixa antiderrapante nos 4 degraus da escada do almoxarifado. Manutenção. Até 30 dias" |
| "Cuidado com o piso molhado" | "Colocar cone e placa no corredor da cozinha sempre que houver lavagem. Zeladoria. Imediato" |

O que faz a diferença são três coisas: **o que fazer, quem faz e até quando**.

## Investigar acidente

A investigação existe para achar a **causa**, não o culpado. É a diferença entre um relatório que evita o próximo acidente e um que só encerra o assunto.

Quando a conclusão é "falta de atenção do trabalhador", a investigação parou cedo demais. Falta de atenção é o que acontece com todo ser humano em algum momento: a pergunta certa é por que um instante de desatenção foi capaz de machucar alguém.

1. **Preservar o local**, quando possível, e atender a vítima primeiro.
2. **Ouvir quem viu**, separadamente e sem plateia, logo depois, enquanto a memória é fresca.
3. **Levantar os fatos**: o que a pessoa estava fazendo, com que ferramenta, com que ordem, sob que pressão de tempo.
4. **Procurar as causas em camadas**: o que aconteceu, o que permitiu que acontecesse, e o que na organização do trabalho tornou aquilo provável.
5. **Propor medidas** que ataquem a causa, com responsável e prazo.
6. **Acompanhar** até a conclusão.

> Quase acidente é presente de graça. É o acidente que avisou antes de acontecer, e investigar um deles custa infinitamente menos do que investigar o acidente de verdade que vem depois.

## Assédio e violência no trabalho

Esta é a parte nova, e a que mais gera dúvida.

**Assédio moral** é a conduta repetida que humilha, isola ou constrange alguém no trabalho. Metas impossíveis usadas como castigo, apelido humilhante, isolamento deliberado, gritos como método.

**Assédio sexual** é a conduta de natureza sexual não desejada, que constrange, e que se agrava quando existe relação de hierarquia.

O que cabe à comissão, conforme a lei:

- Participar da divulgação das regras de conduta e dos canais de denúncia.
- Incluir o tema nas ações de conscientização e na SIPAT.
- Zelar para que exista procedimento de recebimento e apuração das denúncias, com garantia de anonimato ao denunciante.

O que **não** cabe à comissão: julgar, apurar por conta própria ou expor o nome de quem denunciou. O papel é garantir que exista canal, que ele funcione, e que o assunto não seja tratado como piada.

## Os erros que mais aparecem

- Reunião sem ata, ou ata que só registra presença.
- Recomendação sem responsável e sem prazo.
- Investigação que termina em "falta de atenção".
- Cipeiro eleito que não recebe tempo para exercer a função.
- Comissão que só aparece na semana da SIPAT.
- Tratar quase acidente como sorte, e não como aviso.
- Confundir estabilidade com garantia contra falta grave.

## Glossário

**Ata:** registro do que foi tratado e decidido na reunião, assinado pelos presentes.

**Cipeiro:** membro da comissão, eleito ou designado.

**PGR:** Programa de Gerenciamento de Riscos, que reúne o inventário de riscos e o plano de ação.

**Quase acidente:** evento que quase resultou em lesão ou dano, e que por sorte não resultou.

**SESMT:** Serviço Especializado em Engenharia de Segurança e em Medicina do Trabalho.

**SIPAT:** Semana Interna de Prevenção de Acidentes do Trabalho.

## Exercícios

**1.** O presidente da CIPA é eleito pelos trabalhadores?

**2.** Um cipeiro eleito cometeu falta grave comprovada. A estabilidade impede a dispensa?

**3.** A investigação de um corte na mão concluiu "falta de atenção do operador". O que está faltando?

**4.** A CIPA recebeu uma denúncia de assédio moral. O que ela faz?

**5.** Por que uma recomendação precisa de prazo e responsável?

**6.** Um quase acidente aconteceu e ninguém se machucou. Vale investigar?

### Gabarito comentado

**1.** Não. O presidente é **designado pelo empregador**. Quem os trabalhadores elegem são os representantes deles, e são os titulares eleitos que escolhem o vice-presidente. Confundir os dois é o erro mais comum na prova e na prática.

**2.** Não impede. A garantia protege contra a dispensa arbitrária ou sem justa causa; falta grave comprovada, e também motivo disciplinar, técnico, econômico ou financeiro devidamente comprovado, continuam permitindo a dispensa. A estabilidade existe para o cipeiro poder falar, não para blindá-lo de tudo.

**3.** Falta perguntar por que um instante de desatenção foi capaz de machucar. Onde estava a proteção da máquina, por que a tarefa exigia a mão naquele ponto, se havia pressão de tempo, se a ferramenta era a adequada. "Falta de atenção" descreve o ser humano, não a causa.

**4.** Encaminha pelo canal de denúncia da empresa, garantindo o anonimato de quem denunciou, e acompanha para que exista apuração. A comissão não julga, não apura por conta própria e não expõe nomes. O papel dela é garantir que o canal exista e funcione.

**5.** Porque sem os dois ela não é cobrável. Na reunião seguinte não há como saber se foi feita nem de quem cobrar, e o item se repete na ata por meses até todo mundo parar de lê-lo.

**6.** Vale, e é a investigação mais barata que existe. O quase acidente mostra o mesmo caminho que levaria ao acidente, sem ninguém ferido e sem o custo. Tratado como sorte, ele volta, e da segunda vez pode não haver sorte.

## Referências

- NR-05, Comissão Interna de Prevenção de Acidentes e de Assédio.
- Lei 14.457, de 2022, que instituiu as medidas de prevenção e combate ao assédio.
- NR-01, Disposições Gerais e Gerenciamento de Riscos Ocupacionais.
- NR-04, Serviços Especializados em Segurança e em Medicina do Trabalho.

> Este material é de apoio e não substitui a norma, o procedimento interno da sua empresa nem a orientação do responsável técnico. Em caso de divergência, vale o texto oficial da norma.
'
where codigo = 'NR-05';

-- ---------------------------------------------------------------------
--  NR-11: Operacao de empilhadeira (16h)
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'Empilhadeira é a máquina mais subestimada do galpão. Ela anda devagar, faz pouco barulho e quem opera passa o dia inteiro nela sem que nada aconteça. Justamente por isso o operador esquece três coisas: que ela pesa várias vezes mais que um carro, que ela vira para o lado com facilidade e que ela não enxerga o pedestre que aparece atrás da carga.

Os acidentes graves com empilhadeira quase nunca são de gente sem treino. São de operador experiente, num percurso conhecido, num dia comum.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os **passos numerados** são sequência obrigatória.
- Os trechos **recuados, com filete ao lado**, são as coisas que mais matam ou mutilam.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Saber quem pode operar e o que a empresa precisa ter no papel.
- Fazer a inspeção antes de ligar, e saber o que reprova a máquina.
- Entender o triângulo de estabilidade e por que a empilhadeira tomba.
- Ler a placa de capacidade e calcular se a carga cabe.
- Circular com segurança onde há pedestre, rampa e cruzamento.
- Saber exatamente o que fazer se a máquina começar a tombar.

## Quem pode operar

Somente trabalhador **capacitado e autorizado pela empresa**, com treinamento específico, comprovação de aptidão física e mental, e **crachá de identificação** com nome e fotografia, visível, que o autoriza a operar.

O treinamento é específico para o tipo de equipamento. Quem foi treinado em contrabalançada não está autorizado a operar retrátil ou patolada só porque "é parecido": muda o centro de gravidade, muda a visão e muda o comportamento da máquina.

A reciclagem segue o procedimento da empresa, e a prática de mercado é refazer a capacitação a cada dois anos, além de sempre que o operador mudar de equipamento, houver mudança no processo, ou ocorrer acidente.

## Antes de ligar: a inspeção

A inspeção do início do turno não é burocracia, é a única oportunidade de achar o defeito com a máquina parada.

1. **Volta a pé em torno da máquina**: vazamento no chão, dano visível, garfos tortos ou trincados, calços e travas.
2. **Pneus**: corte, desgaste, pressão nos pneumáticos, aro danificado.
3. **Corrente e mangueiras da torre**: folga irregular, elo torcido, vazamento de óleo.
4. **Nível de óleo, água e combustível**, ou carga da bateria.
5. **Freio de serviço e de estacionamento**, um a um.
6. **Direção**, buzina, alarme de ré, faróis e giroflex.
7. **Cinto de segurança**, protetor de carga e grade de proteção.
8. **Extintor** presente, com carga e no prazo.

> Máquina reprovada na inspeção não sai do lugar, e a informação vai por escrito para a manutenção. Operar sabendo do defeito transfere a responsabilidade para quem opera, e o defeito que mais mata é o freio "que ainda pega".

## Por que a empilhadeira tomba

A empilhadeira não tem quatro rodas de apoio como um carro. As rodas de trás fazem a direção e, para efeito de equilíbrio, valem como um **ponto só**, no meio do eixo traseiro. O apoio dela é um **triângulo**: as duas rodas da frente e esse ponto atrás.

Enquanto o centro de gravidade do conjunto máquina mais carga estiver **dentro desse triângulo**, ela fica de pé. Quando sai, ela tomba. E o centro de gravidade se desloca com tudo o que o operador faz:

| O que você faz | Para onde o peso vai |
| --- | --- |
| Levanta a carga | Sobe, e o equilíbrio fica mais frágil |
| Faz curva | Joga para fora da curva |
| Freia com carga alta | Joga para frente |
| Inclina a torre para frente | Joga para frente, e é a pior combinação com carga alta |
| Anda em terreno inclinado | Joga para o lado de baixo |

Por isso a regra prática: **carga baixa para andar, alta só para empilhar, e nunca girar com a carga no alto.**

### A placa de capacidade

Toda empilhadeira tem uma placa que diz quanto ela levanta, **e a que distância**. Esse segundo número é o centro de carga, e ele muda tudo.

Uma máquina de 2.500 kg a 500 mm de centro de carga não levanta 2.500 kg de uma carga comprida, cujo peso fica a 800 mm do calcanhar do garfo. Quanto mais longe o peso, menos ela aguenta: é o mesmo motivo pelo qual você segura um balde encostado no corpo, e não com o braço esticado.

Carga fora da placa não é "um pouquinho mais": é a máquina trabalhando fora do que o fabricante garantiu.

## Circular

- **Velocidade compatível** com o local, a carga e o piso. Dentro do galpão, velocidade de caminhada.
- **Garfos a cerca de 15 a 20 cm do chão** em deslocamento, com a torre levemente inclinada para trás.
- **Buzinar em cruzamentos, portas e saídas de corredor**, e reduzir.
- **Nunca transportar pessoas**, nem no garfo, nem no palete, nem em pé ao lado.
- **Ninguém passa nem fica sob a carga elevada.**
- **Carga que tapa a visão**: dirigir de ré, olhando para o sentido do movimento, ou usar acompanhante.
- **Rampa**: com carga, sobe de frente e desce de ré, sempre com a carga voltada para a parte de cima da rampa. Sem carga, o contrário. Nunca fazer curva na rampa.
- **Distância dos outros equipamentos** e das docas, com calço no caminhão que está sendo carregado.
- **Ao estacionar**: garfos no chão, torre inclinada para frente, freio de estacionamento, chave retirada.

> O pedestre é o que mais morre em acidente com empilhadeira, e quase sempre atropelado ou prensado contra uma estrutura. Ele não ouve a máquina elétrica, não vê o operador atrás da carga, e acha que a empilhadeira vai parar. Onde há empilhadeira e pedestre no mesmo espaço, a separação física é a única proteção que funciona sozinha.

## Bateria e combustível

**Empilhadeira elétrica** carrega em área ventilada e sinalizada: a carga libera hidrogênio, que é explosivo. Nada de chama, faísca ou cigarro perto. O eletrólito é ácido, então luva, avental e proteção facial na hora de manusear.

**Empilhadeira a combustão** não opera em ambiente fechado sem ventilação adequada, por causa do monóxido de carbono. Abastecimento com o motor desligado, sem chama por perto.

## Se ela começar a tombar

Este é o parágrafo que salva vida, e o instinto está errado.

**Não pule.** A maior parte das mortes por tombamento acontece quando o operador pula e é esmagado pela estrutura da própria máquina que cai atrás dele.

1. **Fique no assento.** É por isso que existe o cinto e a estrutura de proteção.
2. **Segure firme** no volante.
3. **Firme os pés** no piso da cabine.
4. **Incline o corpo para o lado contrário** ao da queda.
5. Deixe a máquina cair. A estrutura foi feita para preservar o espaço onde você está.

E é por isso que o **cinto de segurança é obrigatório**: sem ele, o corpo é jogado para fora justamente na direção em que a máquina vai tombar.

## Os erros que mais aparecem

- Andar com a carga no alto.
- Girar com a carga elevada.
- Levar carga fora da placa de capacidade, ou com centro de carga maior que o previsto.
- Transportar colega no garfo, "só até ali".
- Passar por baixo de carga elevada.
- Descer rampa carregada de frente.
- Operar máquina reprovada na inspeção, porque a produção está atrasada.
- Pular no tombamento.

## Antes de operar, confira

- Você está autorizado para **este** tipo de máquina, com crachá visível?
- A inspeção do turno foi feita e a máquina passou?
- Você conhece o peso da carga e o centro de carga dela?
- A placa de capacidade permite essa carga nessa altura?
- O piso, a rampa e o percurso estão livres e em condição?
- Há pedestre na rota, e existe separação ou combinação de passagem?
- O cinto está afivelado?

## Glossário

**Centro de carga:** distância entre o calcanhar do garfo e o centro de gravidade da carga. Quanto maior, menos a máquina levanta.

**Contrabalançada:** empilhadeira com contrapeso na traseira, o tipo mais comum.

**Estrutura de proteção:** a gaiola sobre o operador, que preserva o espaço dele no tombamento.

**Placa de capacidade:** placa fixada na máquina com a carga máxima por altura e por centro de carga.

**Triângulo de estabilidade:** figura formada pelas duas rodas dianteiras e o ponto central do eixo traseiro. Fora dele, a máquina tomba.

## Exercícios

**1.** A empilhadeira de 2.500 kg pode levantar uma carga de 2.200 kg, comprida, com o peso a 900 mm do garfo?

**2.** Por que não se faz curva com a carga elevada?

**3.** Descendo uma rampa com carga, você desce de frente ou de ré?

**4.** A máquina começou a tombar. Você pula?

**5.** Um colega pede carona no garfo por dez metros. Pode?

**6.** A carga tapa a sua visão à frente. O que fazer?

### Gabarito comentado

**1.** Provavelmente não. A capacidade nominal vale para o centro de carga indicado na placa, em geral 500 mm. Com o peso a 900 mm, a capacidade cai bastante, e 2.200 kg pode estar acima do permitido. Quem responde é a placa da máquina, e ela precisa ser consultada, não estimada.

**2.** Porque a curva joga o centro de gravidade para fora, e a carga elevada já deixou esse centro alto. As duas coisas juntas tiram o conjunto do triângulo de estabilidade, e a máquina tomba de lado. Carga baixa para andar, alta só para empilhar.

**3.** De ré, com a carga voltada para a parte de cima da rampa. Descendo de frente, o peso vai para a frente na inclinação e a carga pode cair, ou a máquina tomba para a frente.

**4.** Não. Fique no assento, segure o volante, firme os pés e incline o corpo para o lado contrário ao da queda. A maior parte das mortes por tombamento é de operador que pulou e foi esmagado pela própria máquina.

**5.** Não, em hipótese nenhuma. Empilhadeira transporta carga, não pessoa, e o garfo não tem nada que segure alguém. É proibido inclusive por dez metros, e é assim que acontece boa parte das quedas graves.

**6.** Dirigir de ré, olhando para o sentido do movimento, ou trabalhar com um acompanhante orientando. Nunca seguir em frente contando com a sorte, porque o pedestre que aparece na frente da carga é invisível para você até o momento do impacto.

## Referências

- NR-11, Transporte, Movimentação, Armazenagem e Manuseio de Materiais.
- NR-12, Segurança no Trabalho em Máquinas e Equipamentos.
- NR-06, Equipamento de Proteção Individual.
- NR-01, Disposições Gerais e Gerenciamento de Riscos Ocupacionais.

> Este material é de apoio e não substitui a norma, o manual do fabricante da sua máquina, o procedimento interno da sua empresa nem a orientação do responsável técnico. Em caso de divergência, vale o texto oficial da norma.
'
where codigo = 'NR-11';

-- #####################################################################
-- #  Apostilas aprofundadas: BRIG, NR-18, NR-20 e NR-34.5
-- #  (vem de 41-apostilas-fundas-3.sql)
-- #####################################################################

-- =====================================================================
--  APOSTILAS APROFUNDADAS, GRUPO 3: BRIG, NR-18, NR-20 e NR-34.5
--
--  Rode quando quiser. Pode rodar mais de uma vez.
--
--  ATENCAO: CONTEUDO TECNICO. Antes de publicar, a responsavel tecnica
--  precisa conferir. Distancias de isolamento, tempos de vigilancia,
--  alturas de guarda-corpo e protocolos de primeiros socorros mudam.
--
--  NENHUMA apostila cita carga horaria de curso: esse numero e do
--  certificado, e repetir em dois lugares e garantir divergencia um dia.
--
--  A brigada merece a conferida mais cuidadosa: as manobras de primeiros
--  socorros seguem as diretrizes de ressuscitacao vigentes, que sao
--  revisadas periodicamente.
-- =====================================================================

-- ---------------------------------------------------------------------
--  BRIG: Brigada de incendio e primeiros socorros
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'Numa emergência real, ninguém se eleva à altura da ocasião: as pessoas caem ao nível do treinamento que têm. Quem nunca praticou congela, procura o chefe, tenta ligar para alguém. Quem praticou faz, e faz na ordem certa, porque o corpo já sabe.

É para isso que existe a brigada. Não é para você virar bombeiro: é para os primeiros minutos, que são os que decidem, terem alguém que sabe o que fazer enquanto o socorro não chega.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os **passos numerados** são sequência. Numa emergência, a ordem é a diferença entre ajudar e atrapalhar.
- Os trechos **recuados, com filete ao lado**, são as coisas que mais matam.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Explicar como o fogo nasce e como se apaga.
- Escolher o extintor certo e usá-lo sem hesitar.
- Conduzir uma evacuação e saber por que a fumaça é o inimigo.
- Avaliar uma vítima e iniciar a reanimação.
- Agir em engasgo, hemorragia, queimadura, fratura e convulsão.
- Saber o que **não** fazer, que é onde a boa intenção mais machuca.

## Como o fogo nasce

O fogo precisa de quatro coisas ao mesmo tempo: **combustível, oxigênio, calor e a reação em cadeia** que mantém tudo isso se alimentando. Tire qualquer uma e o fogo acaba. É só isso que um extintor faz.

| Retirar | Nome | Exemplo |
| --- | --- | --- |
| Calor | Resfriamento | Água |
| Oxigênio | Abafamento | Espuma, CO2, manta |
| Combustível | Isolamento | Fechar o registro do gás |
| Reação em cadeia | Extinção química | Pó químico |

### As classes, e por que elas importam

Usar o extintor errado não é apenas ineficaz: em dois casos, piora.

| Classe | O que queima | Extintor |
| --- | --- | --- |
| A | Sólidos: papel, madeira, tecido | Água, espuma, pó ABC |
| B | Líquidos: combustível, tinta, solvente | Espuma, pó, CO2 |
| C | Equipamento energizado | CO2, pó. **Nunca água** |
| D | Metais: magnésio, sódio, alumínio em pó | Pó especial. **Nunca água** |
| K | Óleo e gordura de cozinha | Extintor classe K |

> Água em fogo classe C leva o choque de volta pelo jato. Água em líquido inflamável espalha o fogo, porque o combustível boia e sai correndo com a água. Água em metal em combustão provoca explosão. Essas três são as que matam brigadista.

## Usar o extintor

Quatro passos, e um detalhe que quase todo mundo erra.

1. **Puxe o pino**, quebrando o lacre.
2. **Aponte para a base do fogo**, e não para as chamas. As chamas são o resultado; o que queima está embaixo.
3. **Aperte o gatilho**, firme.
4. **Mova em leque**, cobrindo a base, avançando devagar.

Fique a **dois ou três metros**, com o vento ou a corrente de ar nas suas costas, e sempre com a saída atrás de você. Nunca deixe o fogo entre você e a porta.

Um extintor dura de dez a vinte segundos. Se não resolveu, ele não vai resolver: saia, feche a porta atrás de você e acione o socorro.

## Evacuar

**A fumaça mata mais do que a chama.** Ela cega, desorienta, envenena com monóxido de carbono e sobe primeiro, deixando uma camada de ar melhor perto do chão.

1. **Acione o alarme** e o socorro: 193.
2. **Oriente pela rota de fuga**, em voz firme, sem correria.
3. **Não use elevador**, nunca. Ele para no andar do fogo, ou fica preso sem energia.
4. **Se houver fumaça, abaixe-se** e avance agachado, protegendo as vias aéreas com pano, de preferência úmido.
5. **Antes de abrir uma porta, sinta a temperatura** com as costas da mão, perto da maçaneta e no alto. Porta quente significa fogo do outro lado: não abra.
6. **Feche as portas** ao sair de cada ambiente. Porta fechada segura o fogo por minutos preciosos.
7. **Leve todos ao ponto de encontro** e **confira a lista**.
8. **Ninguém volta** para buscar nada nem ninguém. Quem falta é informado ao Corpo de Bombeiros, que tem equipamento para entrar.

## Primeiros socorros

A regra que vem antes de todas as outras: **primeiro a sua segurança**. Socorrista que vira vítima duplica o problema e tira o socorro de quem precisava.

1. **Avalie a cena.** Há fogo, energia, gás, trânsito, risco de desabamento?
2. **Chame o socorro**: 192 para o SAMU, 193 para os bombeiros. Diga o local exato, o que aconteceu e quantas vítimas.
3. **Verifique a resposta**: chame a pessoa, toque nos ombros.
4. **Veja se respira normalmente**, olhando o peito por até dez segundos.

### Parada cardiorrespiratória

Sem resposta e sem respiração normal, comece já.

1. **Peça o DEA** e mande alguém buscar, nominalmente: "você, de camisa azul, traga o desfibrilador".
2. **Compressões no centro do peito**, entre os mamilos, com as duas mãos.
3. **Ritmo de cerca de cem a cento e vinte por minuto**, e profundidade de uns cinco centímetros num adulto.
4. **Deixe o peito voltar** completamente entre uma compressão e outra.
5. **Não interrompa**, exceto para usar o DEA.
6. **Use o DEA assim que chegar** e siga as instruções faladas por ele.
7. **Reveze** a cada dois minutos, se houver outra pessoa treinada, porque a qualidade cai com o cansaço.

> Compressão malfeita e compressão nenhuma têm quase o mesmo resultado. Os erros que mais tiram a eficácia são comprimir raso, deixar a mão apoiada sem soltar o peito, e parar toda hora para conferir. Na dúvida, comprima forte, rápido e sem parar.

### Engasgo

Se a pessoa **tosse e fala**, a via está parcialmente aberta: incentive a tossir e não bata nas costas.

Se ela **não fala, não tosse e leva as mãos ao pescoço**, é obstrução grave:

1. Posicione-se atrás dela.
2. Abrace, colocando o punho fechado acima do umbigo, abaixo do esterno.
3. Faça compressões firmes para dentro e para cima.
4. Repita até desobstruir ou até a pessoa desmaiar.
5. Se desmaiar, deite no chão e inicie compressões torácicas.

### Hemorragia

1. **Pressão direta** sobre o ferimento, com pano limpo, com força e sem aliviar para espiar.
2. Se encharcar, **coloque outro pano por cima**, sem retirar o primeiro.
3. **Eleve o membro**, se não houver suspeita de fratura.
4. **Não remova** objeto encravado: estabilize em volta dele.

### Queimadura

1. **Resfrie com água corrente** em temperatura ambiente por cerca de dez a vinte minutos.
2. **Não use gelo**, que agrava a lesão.
3. **Não estoure bolhas.**
4. **Não passe pasta de dente, manteiga, borra de café nem pomada.**
5. **Não retire roupa grudada** na pele.
6. **Cubra com pano limpo e seco** e encaminhe.

### Fratura e suspeita de lesão na coluna

1. **Não mova a vítima**, a não ser que haja risco iminente no local.
2. **Imobilize na posição encontrada**, sem tentar endireitar.
3. **Estabilize a cabeça** com as mãos, se houver suspeita de lesão cervical.
4. Aguarde o socorro.

### Convulsão

1. **Afaste objetos** e proteja a cabeça com algo macio.
2. **Não segure** a pessoa nem tente conter os movimentos.
3. **Não coloque nada na boca**, nunca. A pessoa não engole a língua, e o que se enfia na boca quebra dente e obstrui.
4. **Marque a hora** de início.
5. Passada a crise, **lateralize** a cabeça e acompanhe até chegar ajuda.

## Os erros que mais aparecem

- Usar água em painel elétrico ou em líquido inflamável.
- Apontar o extintor para as chamas em vez da base.
- Deixar o fogo entre você e a saída.
- Usar o elevador na evacuação.
- Voltar para buscar alguma coisa.
- Bater nas costas de quem está engasgado e ainda tosse.
- Passar pomada ou pasta de dente em queimadura.
- Colocar objeto na boca de quem convulsiona.
- Mover vítima com suspeita de lesão na coluna sem necessidade.

## Glossário

**DEA:** desfibrilador externo automático. Analisa o ritmo do coração e só aplica choque quando é o caso.

**Ponto de encontro:** local combinado, fora e distante da edificação, onde todos se reúnem e são contados.

**RCP:** ressuscitação cardiopulmonar.

**Rota de fuga:** caminho sinalizado e desobstruído que leva à saída de emergência.

**Tetraedro do fogo:** combustível, oxigênio, calor e reação em cadeia.

## Exercícios

**1.** Pegou fogo num quadro elétrico energizado. Pode usar o extintor de água que está ao lado?

**2.** Você entra numa sala com fumaça densa no teto. Como avança?

**3.** Um colega está engasgado, tossindo com força e conseguindo falar. O que fazer?

**4.** A vítima não responde e não respira. Qual a primeira coisa?

**5.** Alguém se queimou com óleo quente e a pele está vermelha, com bolhas. O que fazer e o que não fazer?

**6.** Um colega está convulsionando. Você segura ele para não se machucar?

### Gabarito comentado

**1.** Não. Fogo em equipamento energizado é classe C, e a água conduz: o choque volta pelo jato. Usa-se CO2 ou pó. E a primeira providência, quando dá, é cortar a energia, porque aí o incêndio passa a ser da classe do material que está queimando.

**2.** Agachado, o mais perto do chão possível, protegendo as vias aéreas com um pano, de preferência úmido. A fumaça sobe e deixa uma camada de ar melhor embaixo. E sempre com a saída conhecida atrás de você.

**3.** Incentivar a tossir e não bater nas costas. Quem tosse e fala tem a via parcialmente aberta, e a tosse é o mecanismo mais eficiente que existe para desobstruir. A manobra só entra quando a pessoa não fala, não tosse e leva as mãos ao pescoço.

**4.** Chamar o socorro e pedir o DEA, apontando uma pessoa pelo nome ou pela roupa, e começar as compressões imediatamente. Pedir "alguém chame ajuda" para um grupo faz com que ninguém chame, porque cada um acha que outro foi.

**5.** Resfriar com água corrente em temperatura ambiente por dez a vinte minutos, cobrir com pano limpo e seco e encaminhar. Não usar gelo, não estourar as bolhas, não passar pasta de dente, manteiga, borra de café nem pomada, e não retirar roupa grudada.

**6.** Não. Não se segura nem se contém quem convulsiona, e não se coloca nada na boca. O que se faz é afastar objetos, proteger a cabeça com algo macio, marcar a hora e, passada a crise, lateralizar a cabeça.

## Referências

- NR-23, Proteção Contra Incêndios.
- Instrução Técnica do Corpo de Bombeiros do estado, sobre brigada de incêndio.
- NBR 14276, Brigada de incêndio, ABNT.
- Diretrizes de ressuscitação cardiopulmonar da American Heart Association, edição vigente.

> Este material é de apoio e não substitui a norma, o plano de emergência da sua empresa nem a orientação do responsável técnico. Em caso de divergência, vale o texto oficial.
'
where codigo = 'BRIG';

-- ---------------------------------------------------------------------
--  NR-18: Construcao civil
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'Canteiro de obra é o único lugar de trabalho que muda de forma todos os dias. O que era piso ontem virou vão hoje; a proteção que estava ali foi retirada para passar material e ninguém recolocou; o andaime cresceu mais um lance durante a noite.

Por isso a construção civil lidera as estatísticas de morte no trabalho no Brasil, e por isso a maior parte dessas mortes tem duas causas só: **queda de altura e soterramento**. As duas são previsíveis, e as duas são evitadas com coisas baratas que alguém precisa lembrar de instalar e de recolocar.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os **passos numerados** são sequência.
- Os trechos **recuados, com filete ao lado**, são as coisas que mais matam na obra.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Reconhecer as proteções de periferia e saber quando elas estão erradas.
- Entender por que escavação desaba e o que segura o talude.
- Avaliar um andaime antes de subir.
- Saber o que a obra precisa oferecer em área de vivência.
- Identificar as armadilhas do canteiro: abertura no piso, prego, entulho, instalação provisória.

## O papel do PGR na obra

A obra tem que ter o gerenciamento de riscos por escrito, com o inventário dos riscos e o plano de ação, e ele acompanha as fases: fundação, estrutura, alvenaria e acabamento têm riscos diferentes.

O que isso significa para quem trabalha: **existe um documento que diz o que era para estar protegido**. Quando a proteção não está lá, não é azar, é descumprimento de um plano que alguém escreveu.

## Queda de altura: as proteções de periferia

É a causa que mais mata em obra. E o que impede a queda quase sempre é uma peça simples:

- **Guarda-corpo** na periferia da laje, nas rampas, nas escadas e em toda abertura. Ele tem travessa superior, travessa intermediária e **rodapé**, e é dimensionado para resistir a um esforço horizontal, e não apenas para marcar a borda.
- **Fechamento das aberturas no piso** com material resistente, fixado, e sinalizado. Tábua solta jogada em cima de um vão é armadilha, e não proteção.
- **Plataformas de proteção** nas fachadas, conforme a altura da edificação.
- **Proteção nos vãos de elevador**, em todos os pavimentos.

> A proteção que mais mata é a que foi **retirada para passar material e não voltou**. Quem tira é responsável por recolocar, na hora, e não no fim do dia. Se o serviço exige remover, isola-se a área enquanto ela estiver aberta.

Onde a proteção coletiva não é possível, entra o sistema de retenção de queda, com tudo o que a NR-35 exige: análise de risco, ancoragem avaliada, cinturão paraquedista, talabarte duplo, e plano de resgate.

## Escavação: por que desaba

Terra parece firme e é traiçoeira. Um metro cúbico de solo pesa mais de uma tonelada, e um desabamento não precisa cobrir a pessoa inteira: enterrado até o peito, ninguém consegue expandir o tórax para respirar.

O que faz desabar:

- **Corte vertical** sem talude nem escoramento.
- **Material empilhado na borda**, que soma peso justamente onde o solo é mais fraco.
- **Vibração** de máquina, caminhão ou bate-estaca passando ao lado.
- **Água**, de chuva ou de vazamento, que amolece e aumenta o peso.

O que segura:

1. **Talude** com inclinação adequada ao tipo de solo, ou **escoramento** dimensionado, definido por profissional habilitado.
2. **Afastamento do material escavado** da borda.
3. **Escadas ou rampas de acesso** distribuídas ao longo da vala, para saída rápida.
4. **Isolamento e sinalização** de toda a área.
5. **Inspeção antes de cada jornada**, e de novo depois de chuva.

> Vala funda também é espaço confinado quando a ventilação não renova o ar: gás mais pesado que o ar se acumula no fundo. Nesses casos, vale a NR-33 junto.

## Andaimes

1. **Base firme e nivelada**, sobre calço adequado, nunca sobre tijolo, lata ou entulho.
2. **Montagem por trabalhador capacitado**, com peças do mesmo sistema, sem improviso.
3. **Piso completo**, forrado, travado e sem vão entre as pranchas.
4. **Guarda-corpo e rodapé** em todo o perímetro de trabalho.
5. **Ancoragem à estrutura**, conforme a altura.
6. **Acesso por escada incorporada**, e não escalando a estrutura.
7. **Nada de escada, caixote ou banco em cima do andaime** para alcançar mais alto.

Andaime suspenso tem regras próprias, incluindo cabos, sustentação, dimensionamento e cinturão ligado a **cabo independente** do andaime, e não à própria plataforma.

## As armadilhas do canteiro

**Instalação elétrica provisória.** Quadro fechado, com disjuntor e dispositivo diferencial residual, cabos suspensos e íntegros, sem emenda com fita no chão molhado. Ferramenta elétrica com carcaça e cabo em ordem.

**Serra circular de bancada.** Precisa de coifa protetora do disco, cutelo divisor e coletor de serragem, e ser operada por trabalhador capacitado. É uma das maiores causas de amputação na obra.

**Betoneira.** Proteção nas engrenagens e nas correias, e limpeza só com a máquina desligada e bloqueada.

**Entulho e prego.** Tábua com prego exposto vira perfuração; entulho no caminho vira tropeço na hora em que a pessoa está carregando peso e não enxerga o chão.

**Movimentação de cargas.** Ninguém circula nem permanece sob carga suspensa. Área isolada e sinalizada.

## Área de vivência

Não é regalia: é condição de trabalho, e é obrigação da obra.

| O que | Para quê |
| --- | --- |
| Instalação sanitária | Vaso, mictório, lavatório e chuveiro em número suficiente |
| Vestiário | Armário individual para separar a roupa de trabalho da pessoal |
| Refeitório | Lugar sentado, coberto, para comer fora da poeira e do sol |
| Água potável | Fresca, em bebedouro, e não em copo coletivo |
| Local para descanso | Conforme o porte da obra |

## Os erros que mais aparecem

- Retirar guarda-corpo para passar material e não recolocar.
- Fechar abertura de piso com tábua solta, sem fixar.
- Empilhar material na borda da escavação.
- Montar andaime sobre calço improvisado.
- Subir mais um degrau usando caixote em cima do andaime.
- Serra circular sem coifa, "porque atrapalha".
- Circular ou parar sob carga suspensa.

## Antes de começar, confira

- A proteção de periferia está completa no seu trecho, com rodapé?
- As aberturas de piso estão fechadas e fixadas?
- O andaime tem base firme, piso completo, guarda-corpo e ancoragem?
- A escavação tem talude ou escoramento, e acesso para sair rápido?
- O material escavado está afastado da borda?
- O quadro elétrico está fechado e com dispositivo diferencial?
- Há carga suspensa no seu caminho?
- Você tem o EPI da tarefa, e ele está em condição?

## Glossário

**Escoramento:** estrutura que sustenta as paredes de uma escavação e impede o desabamento.

**Guarda-corpo:** barreira de periferia com travessa superior, intermediária e rodapé.

**Plataforma de proteção:** estrutura em balanço na fachada, que apara queda de material e de pessoas.

**Rodapé:** peça baixa junto ao piso que impede material de cair pela borda.

**Talude:** inclinação dada à parede da escavação para que ela se sustente.

## Exercícios

**1.** Um vão no piso foi coberto com duas tábuas soltas. Está protegido?

**2.** Por que o material escavado não pode ficar na borda da vala?

**3.** Falta pouco para alcançar o teto. Dá para colocar um caixote sobre o andaime?

**4.** O guarda-corpo foi retirado para receber material pelo guincho. Quando ele volta?

**5.** Uma vala de 2 m está sendo escavada em solo arenoso, com corte vertical. Pode descer?

**6.** A serra circular está sem a coifa porque "atrapalha o corte". O que fazer?

### Gabarito comentado

**1.** Não. Fechamento de abertura precisa ser de material resistente, **fixado** e sinalizado. Tábua solta desliza quando alguém pisa na ponta, e vira alçapão. É uma das quedas mais comuns da obra.

**2.** Porque o peso do material somado na borda é exatamente a carga que faz a parede ceder, e é ali que o solo tem menos apoio. O material vai para longe da borda, na distância definida pelo responsável.

**3.** Não, nunca. Caixote, escada ou banco sobre andaime elevam o centro de gravidade e anulam o guarda-corpo, que passa a ficar abaixo da cintura. Se falta altura, o andaime é que precisa ser ajustado.

**4.** Na hora em que o recebimento terminar, e não no fim do dia. Enquanto estiver aberto, a área fica isolada e sinalizada, e quem retirou responde por recolocar. Proteção retirada e esquecida é a causa mais comum de queda em obra.

**5.** Não. Solo arenoso com corte vertical desaba com facilidade, e 2 m já é altura suficiente para soterrar até o peito, o que impede a respiração. Precisa de talude ou escoramento definido por profissional habilitado, e de acesso para saída rápida.

**6.** Não usar a máquina e comunicar imediatamente. Coifa, cutelo divisor e coletor são exigências, e a serra circular é uma das maiores causas de amputação na construção. Quem retira a proteção responde pelo que acontecer.

## Referências

- NR-18, Segurança e Saúde no Trabalho na Indústria da Construção.
- NR-35, Trabalho em Altura.
- NR-12, Segurança no Trabalho em Máquinas e Equipamentos.
- NR-01, Disposições Gerais e Gerenciamento de Riscos Ocupacionais.

> Este material é de apoio e não substitui a norma, o procedimento interno da sua empresa nem a orientação do responsável técnico. Em caso de divergência, vale o texto oficial da norma.
'
where codigo = 'NR-18';

-- ---------------------------------------------------------------------
--  NR-20: Inflamaveis e combustiveis
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'Líquido inflamável não pega fogo. Quem pega fogo é o **vapor** que ele solta, e essa distinção, que parece detalhe de sala de aula, é a diferença entre entender e não entender esta norma.

É por isso que um tambor aparentemente fechado explode, que uma poça pequena incendeia um galpão inteiro, e que a faísca que acendeu o fogo estava a vinte metros de distância do líquido. O vapor viaja, desce, se acumula, e espera.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os **passos numerados** são sequência obrigatória.
- Os trechos **recuados, com filete ao lado**, são as coisas que mais matam.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Explicar ponto de fulgor e por que ele classifica o produto.
- Entender por que o vapor desce e o que isso muda no seu trabalho.
- Reconhecer as fontes de ignição, inclusive as que ninguém vê.
- Aterrar e equipotencializar num trasvase, e dizer por quê.
- Agir num vazamento e num princípio de incêndio classe B.

## O que faz um produto ser inflamável

O **ponto de fulgor** é a menor temperatura em que o líquido solta vapor suficiente para formar uma mistura que pega fogo na presença de uma fonte de ignição.

| Produto | Ponto de fulgor | Na prática |
| --- | --- | --- |
| Inflamável | igual ou abaixo de 60 graus | Solta vapor já em temperatura ambiente |
| Combustível | acima de 60 graus | Precisa ser aquecido para soltar vapor |

Gasolina tem ponto de fulgor bem abaixo de zero: num dia comum, ela já está soltando vapor o tempo todo. Óleo diesel tem ponto de fulgor bem mais alto, e por isso um fósforo aceso jogado no diesel frio costuma apagar. Isso não faz o diesel seguro: aquecido, ou espalhado em pano, ele queima muito bem.

### Os limites de inflamabilidade

O vapor só queima dentro de uma faixa de concentração. Abaixo do **limite inferior** é pobre demais; acima do **limite superior** é rico demais. Entre os dois, qualquer faísca serve.

O que isso significa na prática: um tanque quase vazio é mais perigoso do que um tanque cheio, porque o espaço vazio dele tem mistura na faixa que queima.

> A regra de trabalho é **10% do limite inferior**. Acima disso, o serviço para e o local é ventilado. Não se trabalha com cuidado numa atmosfera explosiva.

## O vapor desce

A maior parte dos vapores inflamáveis é **mais pesada que o ar**. Eles não sobem e se dissipam: escorrem pelo chão, entram em canaleta, ralo, caixa de passagem e valeta, e se acumulam no ponto mais baixo.

Duas consequências que salvam vida:

- A fonte de ignição perigosa pode estar **longe da poça**, no fim da canaleta, onde o vapor chegou.
- Detector de gás no teto não vê nada. Mede-se **no nível do chão** e nos pontos baixos.

## As fontes de ignição

As óbvias: chama, maçarico, cigarro, solda, esmeril.

As que pegam gente experiente:

- **Superfície quente**: escapamento de veículo, motor, luminária, mancal aquecido.
- **Faísca mecânica**: ferramenta de aço batendo em concreto ou em metal.
- **Eletricidade**: interruptor comum, motor, celular e lanterna que não sejam próprios para área classificada.
- **Eletricidade estática**: a que mais surpreende. O líquido em movimento acumula carga, e a descarga entre o bico e o recipiente acende o vapor.

### Por que se aterra no trasvase

Ao transferir líquido de um recipiente para outro, a fricção separa cargas elétricas. Se os dois recipientes não estiverem no mesmo potencial, a diferença se resolve numa faísca, e a faísca acontece exatamente onde há vapor concentrado, na boca do recipiente.

1. **Aterre** o recipiente que fornece.
2. **Aterre** o recipiente que recebe.
3. **Ligue os dois entre si** com cabo e garra, metal com metal, raspando a tinta se preciso.
4. Só então **inicie a transferência**, devagar, mantendo o bico encostado.
5. **Nada de recipiente plástico** não apropriado, que não dissipa carga.

## Armazenar

- **Área ventilada**, de preferência com ventilação natural cruzada, e ao nível do chão.
- **Bacia de contenção** capaz de reter o volume, para que um vazamento não corra pelo piso.
- **Separação por incompatibilidade**: inflamável longe de oxidante, longe de ácido, longe de fonte de calor.
- **Recipientes fechados e identificados**, com o rótulo original e a ficha de segurança acessível.
- **Sinalização** de proibido fumar e de área classificada, e equipamento elétrico próprio para a área.
- **Quantidade mínima na área de trabalho**: o que sobra volta para o depósito no fim do turno.

## Trabalho a quente perto de inflamável

É a combinação clássica de acidente grave. Exige **permissão de trabalho**, análise de risco, remoção ou proteção de todo material combustível no entorno, fechamento de ralos e canaletas, medição da atmosfera antes e durante, extintor no local e **vigia de fogo** durante o serviço e por um tempo depois dele, porque brasa escondida reacende.

## Quando dá errado

### Vazamento

1. **Afaste-se e afaste os outros**, saindo pelo lado de onde vem o vento, nunca pelo caminho da nuvem.
2. **Elimine fontes de ignição**: desligue equipamentos pelo comando externo, nada de acionar interruptor na área.
3. **Acione o plano de emergência.**
4. **Contenha**, se for treinado e se for seguro: barreira, absorvente, fechamento de ralo.
5. **Ventile** naturalmente, e não com ventilador comum, que é fonte de faísca.
6. **Não lave para o ralo**: joga o problema para dentro da rede, onde ele vira explosão.

### Incêndio classe B

Espuma, pó químico ou CO2, aplicados na base do fogo, em leque, cobrindo a superfície. A espuma funciona porque forma um tapete que separa o vapor do ar.

> **Nunca jato de água direto em líquido inflamável.** O líquido boia sobre a água, e o jato espalha a poça em chamas para todos os lados. Água só entra na forma de neblina, e por quem sabe usar, para resfriar recipientes vizinhos e impedir que eles cedam.

## Os erros que mais aparecem

- Achar que o líquido pega fogo, e não o vapor.
- Medir a atmosfera na altura do peito, e não no chão.
- Trasvasar sem aterrar e sem ligar os recipientes entre si.
- Usar recipiente plástico comum para inflamável.
- Deixar tambor aberto "só um instante" para arejar.
- Trabalhar a quente sem fechar ralo e canaleta.
- Lavar derramamento para o ralo.
- Jogar água em fogo de líquido inflamável.

## Antes de começar, confira

- Você conhece o produto e leu a ficha de segurança dele?
- A área está ventilada e a atmosfera foi medida no nível do chão?
- Todas as fontes de ignição foram eliminadas no raio de trabalho?
- Ralos e canaletas estão fechados?
- No trasvase, os dois recipientes estão aterrados e ligados entre si?
- Há extintor adequado ao alcance, e você sabe usá-lo?
- Você sabe para onde correr, e por qual lado?

## Glossário

**Área classificada:** local onde pode existir atmosfera explosiva, e onde todo equipamento precisa ser próprio para isso.

**Bacia de contenção:** estrutura que retém o líquido em caso de vazamento.

**Equipotencialização:** ligar duas partes condutoras entre si para que fiquem no mesmo potencial elétrico.

**Ponto de fulgor:** menor temperatura em que o líquido solta vapor suficiente para inflamar.

**Trasvase:** transferência de líquido de um recipiente para outro.

**Vigia de fogo:** pessoa que acompanha o trabalho a quente e permanece observando depois dele.

## Exercícios

**1.** Um tambor quase vazio de gasolina é mais perigoso ou menos perigoso que um cheio?

**2.** O detector de gases foi instalado no teto do depósito. Está certo?

**3.** Por que se liga um cabo entre os dois recipientes antes de transferir combustível?

**4.** Houve um pequeno derramamento no piso. Pode lavar com mangueira para o ralo?

**5.** Um fósforo aceso jogado no diesel frio apagou. O diesel é seguro?

**6.** Fogo numa poça de solvente. Você usa o esguicho de água que está ali?

### Gabarito comentado

**1.** Mais perigoso. O espaço vazio contém mistura de vapor e ar dentro da faixa que queima, enquanto o tambor cheio tem pouco espaço e mistura rica demais. Tambor "vazio" é a causa clássica de explosão em serviço de solda e corte.

**2.** Não. A maior parte dos vapores inflamáveis é mais pesada que o ar e se acumula no chão e nos pontos baixos. Detector no teto pode indicar atmosfera limpa enquanto existe mistura explosiva no nível do piso.

**3.** Para igualar o potencial elétrico dos dois. O líquido em movimento acumula carga estática, e sem a ligação essa diferença se resolve numa faísca, bem na boca do recipiente, que é onde o vapor está mais concentrado.

**4.** Não. Lavar para o ralo leva o produto e o vapor para dentro da rede, onde eles se acumulam e podem explodir longe do ponto do derramamento. Contém-se com barreira e absorvente, e o resíduo tem destinação própria.

**5.** Não. Significa apenas que o diesel frio está abaixo do ponto de fulgor e não estava soltando vapor suficiente naquele momento. Aquecido, pulverizado ou embebido em pano, ele queima muito bem, e pano com diesel ainda pode se aquecer sozinho.

**6.** Não com jato direto. O solvente boia sobre a água e o jato espalha a poça em chamas. Usa-se espuma, pó ou CO2 na base do fogo. Água só como neblina, por quem sabe, para resfriar recipientes ao redor.

## Referências

- NR-20, Segurança e Saúde no Trabalho com Inflamáveis e Combustíveis.
- NR-33, Segurança e Saúde nos Trabalhos em Espaços Confinados.
- NR-23, Proteção Contra Incêndios.
- Ficha de Informações de Segurança de Produto Químico do produto em uso.

> Este material é de apoio e não substitui a norma, a ficha de segurança do produto, o procedimento interno da sua empresa nem a orientação do responsável técnico. Em caso de divergência, vale o texto oficial.
'
where codigo = 'NR-20';

-- ---------------------------------------------------------------------
--  NR-34.5: Trabalho a quente
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'Trabalho a quente tem uma característica que nenhum outro risco tem: **o acidente costuma acontecer depois que o serviço acabou**. O soldador guarda a máquina, tira o EPI, vai embora satisfeito, e o incêndio começa quarenta minutos mais tarde, na madeira que uma fagulha atingiu do outro lado da parede.

Por isso este treinamento fala tanto do antes e do depois, e relativamente pouco do durante. Soldar, quase todo mundo sabe. Preparar a área e vigiar depois é o que separa o serviço seguro do incêndio.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os **passos numerados** são sequência obrigatória.
- Os trechos **recuados, com filete ao lado**, são as coisas que mais causam incêndio.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Reconhecer o que conta como trabalho a quente.
- Preparar a área antes de abrir chama, e saber até onde ela vai.
- Cumprir o papel do vigia de fogo, durante e depois.
- Manusear cilindros e mangueiras sem improviso.
- Proteger-se dos fumos e da radiação, e proteger quem passa.

## O que conta como trabalho a quente

Qualquer atividade que produza **chama, faísca, brasa ou aquecimento** capaz de dar início a fogo: soldagem, corte com maçarico, esmerilhamento, lixamento com disco, aquecimento com maçarico, aplicação de asfalto quente, e até furadeira em material que gera fagulha.

O erro comum é achar que só solda conta. Um esmeril jogando fagulha por três metros é trabalho a quente com todas as letras.

## A fagulha viaja

Este é o número que muda o comportamento de quem entende: uma fagulha de esmerilhamento ou de corte pode ser projetada por **mais de dez metros**, e ela não anda só na horizontal. Ela cai por vãos, entra por frestas, atravessa grade de piso, escorre por canaleta e atinge o pavimento de baixo.

Por isso a preparação da área não é o raio de um passo em volta do serviço: é toda a região que a fagulha alcança, **em todas as direções, inclusive para baixo**.

1. **Retire o material combustível** de toda a área alcançada: papel, madeira, tecido, plástico, estopa, embalagem, líquido inflamável.
2. **O que não puder sair, cubra** com manta ou proteção resistente ao fogo, bem fixada.
3. **Feche ralos, canaletas, frestas e juntas de dilatação**, e proteja vãos e grades de piso.
4. **Isole e sinalize** a área, inclusive o pavimento abaixo.
5. **Proteja quem passa** da radiação, com biombo ou cortina de solda.
6. **Coloque o extintor adequado** ao alcance da mão, e não no corredor.
7. **Meça a atmosfera**, quando houver risco de gás ou vapor inflamável.

## A permissão de trabalho

Trabalho a quente exige **permissão de trabalho** emitida antes, com análise de risco, assinada por quem libera, exposta no local e válida para aquela jornada e aquele serviço.

Ela é cancelada, e o serviço para, quando algo muda: a atmosfera sai da faixa, o serviço passa a ser outro, entra material combustível na área, cai a ventilação, ou termina o turno.

> A permissão não é papel para arquivar: é a lista do que precisava estar pronto antes de a chama abrir. Quem assina sem conferir a área está assinando um incêndio.

## O vigia de fogo

É a função mais mal compreendida do trabalho a quente, e a que evita a maior parte dos incêndios.

O vigia **não ajuda no serviço**. O trabalho dele é olhar para onde o soldador não está olhando: o outro lado da chapa, o pavimento de baixo, o canto onde a fagulha caiu.

- Fica na área **durante todo o serviço**, com extintor à mão.
- Observa o entorno, e não a solda.
- Interrompe o serviço ao primeiro sinal de fumaça, cheiro de queimado ou brasa.
- **Permanece na área depois que o serviço termina**, vigiando, pelo tempo definido no procedimento da empresa, que costuma ser de pelo menos trinta minutos.
- Faz a inspeção final antes de liberar o local.

> É nesse tempo depois que a maior parte dos incêndios é descoberta. A brasa que caiu numa fresta trabalha em silêncio: aquece a madeira devagar, e só aparece quando já pegou. Vigia que vai embora junto com o soldador anula todo o resto.

## Cilindros, mangueiras e maçarico

1. **Cilindros em pé**, presos com corrente ou cinta, longe de fonte de calor, com capacete de proteção quando não estiverem em uso.
2. **Oxigênio longe de óleo e graxa**, inclusive nas mãos e nas luvas: a combinação de oxigênio com óleo reage violentamente.
3. **Válvula corta-chama** instalada, contra retrocesso.
4. **Mangueiras íntegras**, sem emenda improvisada, sem esmagamento, com abraçadeira adequada.
5. **Teste de vazamento com água e sabão**, nunca com chama.
6. **Abertura lenta das válvulas**, na sequência do procedimento.
7. **Ao terminar**, fechar as válvulas dos cilindros, aliviar as mangueiras e recolher tudo.

Nunca use oxigênio para limpar roupa, ventilar ambiente ou soprar poeira: enriquecer o ar com oxigênio faz o que normalmente resistiria queimar com facilidade.

## Fumos, radiação e choque

**Fumos metálicos** são o risco de saúde do soldador, e o mais silencioso, porque o dano aparece anos depois. Trabalhe com ventilação ou exaustão local, e com proteção respiratória adequada quando indicado. Atenção especial a materiais revestidos: zinco, tinta e galvanizado geram fumos mais agressivos.

**Radiação do arco** queima a retina e a pele. Máscara com filtro do tom adequado ao processo e à corrente, e proteção para quem está por perto: a vista de quem passa e olha por um instante também é atingida.

**Choque elétrico** na solda elétrica é subestimado. Porta-eletrodo em boas condições, cabo íntegro, aterramento da máquina, e nada de trabalhar com roupa ou luva encharcada de suor.

**Roupa**: couro ou tecido próprio, sem fibra sintética, sem bolso aberto para cima, calça por fora da bota, sem barra dobrada. Fagulha que entra no bolso ou na dobra da calça só é percebida quando já queimou.

## Trabalho a quente em espaço confinado

É a combinação mais perigosa que existe neste assunto. Vale tudo da NR-33 junto: permissão de entrada, medição contínua, ventilação, vigia e resgate montado. Os cilindros ficam **fora** do espaço, e as tochas são retiradas nas pausas, para não vazar gás lá dentro.

## Os erros que mais aparecem

- Preparar só o raio de um passo em volta do serviço.
- Esquecer o pavimento de baixo e o outro lado da parede.
- Deixar ralo e canaleta abertos.
- Vigia que ajuda no serviço, ou que vai embora junto.
- Testar vazamento com chama.
- Deixar cilindro deitado ou solto.
- Usar oxigênio para soprar poeira ou arejar.
- Soldar galvanizado sem exaustão nem proteção respiratória.

## Antes de abrir a chama, confira

- Existe permissão de trabalho para **este** serviço, hoje, exposta no local?
- A área foi limpa em todas as direções que a fagulha alcança, inclusive abaixo?
- Ralos, canaletas, frestas e vãos estão fechados?
- O que não saiu está coberto com manta bem fixada?
- O extintor está ao alcance da mão?
- O vigia de fogo está posicionado e sabe que fica depois?
- Os cilindros estão em pé, presos e com corta-chama?
- As mangueiras foram testadas com água e sabão?
- Há biombo protegendo quem passa?

## Glossário

**Corta-chama:** válvula que impede o retorno da chama para dentro da mangueira e do cilindro.

**Fumos metálicos:** partículas finíssimas geradas na soldagem, inaladas e depositadas no pulmão.

**Manta de proteção:** cobertura resistente ao fogo usada para proteger o que não pode ser retirado.

**Retrocesso de chama:** retorno da chama para dentro da mangueira.

**Vigia de fogo:** pessoa que observa a área durante o serviço e permanece depois dele.

## Exercícios

**1.** Vou apenas esmerilhar um pedaço de cantoneira, cinco minutos. É trabalho a quente?

**2.** A área foi limpa num raio de dois metros. Está suficiente?

**3.** O serviço terminou e não houve nenhum problema. O vigia pode ir embora com o soldador?

**4.** Como se testa vazamento numa mangueira de oxiacetileno?

**5.** Um colega vai usar o jato de oxigênio para tirar a poeira da roupa. Pode?

**6.** Vai soldar chapa galvanizada dentro do galpão. O que muda?

### Gabarito comentado

**1.** É. Esmerilhamento produz fagulha, e fagulha inicia fogo do mesmo jeito que a solda. A duração não muda nada: cinco minutos de esmeril projetam fagulha por metros, e a maior parte dos incêndios começa em serviço rápido, que ninguém achou que precisasse de preparação.

**2.** Não. A fagulha pode ser projetada por mais de dez metros e ainda cai por vãos, frestas e grades, atingindo o pavimento de baixo. A área a preparar é toda a que a fagulha alcança, em todas as direções, inclusive abaixo.

**3.** Não. É justamente depois que a maior parte dos incêndios é descoberta: a brasa alojada numa fresta aquece o material devagar e só aparece quando já pegou. O vigia permanece pelo tempo previsto no procedimento, que costuma ser de pelo menos trinta minutos, e faz a inspeção final.

**4.** Com água e sabão, observando a formação de bolhas. Nunca com chama, e nunca "escutando". Testar vazamento com fogo é acender exatamente aquilo que se procura.

**5.** Não, de jeito nenhum. O oxigênio impregna a roupa e o cabelo, e o tecido enriquecido queima com uma violência que não teria no ar comum. Uma fagulha depois disso transforma a roupa em tocha.

**6.** Muda a proteção respiratória e a ventilação. O revestimento de zinco gera fumos bem mais agressivos, capazes de causar mal-estar agudo. Exige exaustão local ou ventilação forçada e proteção respiratória adequada, além de tudo o mais.

## Referências

- NR-34, Condições e Meio Ambiente de Trabalho na Indústria da Construção, Reparação e Desmonte Naval.
- NR-33, Segurança e Saúde nos Trabalhos em Espaços Confinados.
- NR-20, Segurança e Saúde no Trabalho com Inflamáveis e Combustíveis.
- NR-06, Equipamento de Proteção Individual.

> Este material é de apoio e não substitui a norma, o procedimento interno da sua empresa nem a orientação do responsável técnico. Em caso de divergência, vale o texto oficial da norma.
'
where codigo = 'NR-34.5';

-- #####################################################################
-- #  Apostilas aprofundadas: DD, DD-REC, as duas integracoes, NR-06, NR-17, NR-26 e LOTO
-- #  (vem de 42-apostilas-fundas-4.sql)
-- #####################################################################

-- =====================================================================
--  APOSTILAS APROFUNDADAS, GRUPO 4 (o ultimo): DD, DD-REC, NR-01-INT4,
--  NR-01-INT8, NR-06, NR-17, NR-26 e LOTO
--
--  Rode quando quiser. Pode rodar mais de uma vez.
--
--  ATENCAO: CONTEUDO TECNICO. Antes de publicar, a responsavel tecnica
--  precisa conferir. Cores de sinalizacao, limites de peso e regras de
--  bloqueio seguem tambem o padrao interno de cada empresa.
--
--  Nenhuma apostila cita carga horaria de curso.
--
--  Os pares DD/DD-REC e INT4/INT8 foram escritos para NAO se repetirem:
--  quem faz os dois nao pode ler duas vezes o mesmo texto. A reciclagem
--  de direcao trata do que o motorista experiente esquece; a integracao
--  de 8 horas trata do gerenciamento de riscos, e a de 4 horas trata da
--  primeira semana na empresa.
-- =====================================================================

-- ---------------------------------------------------------------------
--  DD: Direcao defensiva
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'Dirigir bem é não bater. Dirigir defensivamente é não bater **mesmo quando o outro erra**, e é essa a diferença que este curso trata.

Todo motorista sabe que existe gente distraída, apressada e imprudente no trânsito. A direção defensiva é organizar o seu jeito de dirigir em torno dessa certeza: partir do princípio de que o carro do lado vai mudar de faixa sem seta, de que o pedestre vai atravessar fora da faixa, de que o sinal amarelo vai ser furado. Não por pessimismo, mas porque é o que acontece todos os dias.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os **passos numerados** são sequência.
- Os trechos **recuados, com filete ao lado**, são as coisas que mais matam.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Manter distância suficiente para o tempo que o seu corpo leva para reagir.
- Reconhecer e compensar as condições adversas.
- Enxergar o ponto cego, o seu e o dos outros.
- Entender por que celular ao volante não é questão de habilidade.
- Inspecionar o veículo antes de sair.

## Os cinco elementos

A direção defensiva se apoia em cinco coisas, e as três do meio são as que se treinam.

| Elemento | O que é |
| --- | --- |
| Conhecimento | Saber as regras e conhecer o veículo |
| Atenção | Estar presente no que está acontecendo agora |
| Previsão | Antecipar o que o outro vai fazer |
| Habilidade | Conseguir executar a manobra |
| Ação | Decidir e agir a tempo |

## A distância é tudo

Toda colisão traseira tem a mesma causa: espaço insuficiente para o tempo de reação.

O que acontece quando o carro da frente freia:

1. Você **vê** a luz de freio.
2. Seu cérebro **entende** o que está acontecendo.
3. Seu pé **sai do acelerador e pisa no freio**.
4. O carro **começa** a desacelerar.
5. O carro **para**.

Do passo 1 ao 4 passam cerca de um segundo, e nesse tempo você não freou nada: apenas percorreu distância. A 80 km/h, um segundo são mais de vinte metros andados antes de o freio começar a agir.

**A regra dos dois segundos:** escolha um ponto fixo na via, um poste ou uma placa. Quando o carro da frente passar por ele, conte "mil e um, mil e dois". Se você chegar ao ponto antes de terminar, está perto demais.

> Em chuva, à noite, com carga, com pneu gasto ou atrás de moto, a conta vira **três segundos ou mais**. E atrás de caminhão a distância é maior ainda, por um motivo a mais: colado nele, você não enxerga nada além dele.

## As condições adversas

| Adversa | O que muda |
| --- | --- |
| Luz | Sol baixo cega; à noite, o alcance do farol limita a velocidade segura |
| Tempo | Chuva, neblina e vento cruzado |
| Via | Buraco, areia, obra, sinalização apagada |
| Trânsito | Congestionamento, moto entre faixas, ônibus parando |
| Veículo | Pneu, freio, luz, limpador |
| Condutor | Sono, pressa, medicamento, discussão, celular |

A última é a que menos se admite e a que mais aparece nas estatísticas.

## O ponto cego

Todo veículo tem regiões que os espelhos não cobrem. Um carro inteiro cabe no ponto cego de outro carro, e uma moto some com facilidade.

- **Ajuste os espelhos** para reduzir a área cega: o retrovisor externo deve mostrar pouco do próprio carro.
- **Confirme com a cabeça** antes de mudar de faixa, e não apenas com o espelho.
- **Não fique no ponto cego dos outros**: ou passa, ou fica atrás.
- **Caminhão tem ponto cego enorme**, principalmente à direita. Se você não enxerga o espelho dele, ele não enxerga você.

## Celular

Não é questão de habilidade nem de força de vontade. Quando a atenção vai para a conversa, o campo visual se estreita e o cérebro deixa de processar parte do que os olhos veem: a pessoa **olha e não enxerga**. Ler uma mensagem por três segundos a 60 km/h significa percorrer meio quarteirão de olhos fechados.

Viva-voz melhora pouco, porque o que ocupa não é a mão, é a atenção.

## Antes de sair

1. **Pneus**: calibragem, sulco e desgaste irregular. Sulco raso é o que causa aquaplanagem.
2. **Freio**: curso do pedal, ruído, puxar para um lado.
3. **Luzes**: farol, lanterna, freio, seta, ré.
4. **Nível de óleo, água e limpador**.
5. **Limpadores e visibilidade**: palheta gasta em chuva é o mesmo que dirigir cego.
6. **Espelhos ajustados** para você, e não para quem usou antes.
7. **Cinto**, banco e apoio de cabeça na altura certa.
8. **Documentação, triângulo, macaco e chave**.

## Os erros que mais aparecem

- Colar no carro da frente para "não deixar entrar ninguém".
- Mudar de faixa olhando só o espelho.
- Ficar ao lado de caminhão, na altura da cabine.
- Ultrapassar em faixa contínua ou em subida sem visão.
- Confiar na preferência: preferência não para o outro carro.
- Dirigir com sono achando que o café resolve.
- Levar carga solta na caçamba ou no porta-malas.

## Glossário

**Aquaplanagem:** perda de contato do pneu com o solo por acúmulo de água.

**Distância de reação:** distância percorrida entre ver o perigo e começar a frear.

**Ponto cego:** área ao redor do veículo que os espelhos não cobrem.

**Regra dos dois segundos:** método para medir a distância do carro da frente pelo tempo.

## Exercícios

**1.** Você mantém uns dez metros do carro da frente a 80 km/h. É suficiente?

**2.** Por que não se deve trafegar ao lado da cabine de um caminhão?

**3.** Viva-voz resolve o problema do celular ao volante?

**4.** O sinal abriu para você. Pode seguir direto?

**5.** Começou a chover forte. O que muda na sua condução?

### Gabarito comentado

**1.** Não. A 80 km/h você percorre mais de vinte metros só no tempo de reação, antes de o freio começar a agir. Dez metros somem antes de você pisar. A conta certa é por tempo, com a regra dos dois segundos.

**2.** Porque é exatamente ali o maior ponto cego dele, principalmente do lado direito. Se você não enxerga o espelho do caminhão, o motorista não enxerga você, e uma mudança de faixa dele acaba com o seu carro.

**3.** Melhora pouco. O que ocupa não é a mão, é a atenção: o campo visual se estreita e a pessoa passa a olhar sem enxergar. A conversa continua consumindo o mesmo espaço mental.

**4.** Não sem olhar. Sinal aberto dá o direito de passagem, não a garantia de que o outro vai parar. Sinal furado é uma das causas mais comuns de colisão grave em cruzamento: reduz-se e confere-se antes de cruzar.

**5.** Aumenta a distância de seguimento para três segundos ou mais, reduz a velocidade, liga o farol baixo, evita frear e esterçar bruscamente, e redobra a atenção nas primeiras chuvas depois de muito tempo seco, quando o óleo do asfalto sobe e a pista fica mais escorregadia.

## Referências

- Código de Trânsito Brasileiro e resoluções do CONTRAN.
- NR-12, quando o veículo for equipamento de trabalho.
- Procedimento interno de segurança veicular da empresa.

> Este material é de apoio e não substitui a legislação de trânsito nem o procedimento interno da sua empresa. Em caso de divergência, vale o texto oficial.
'
where codigo = 'DD';

-- ---------------------------------------------------------------------
--  DD-REC: Direcao defensiva, reciclagem
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'Você já sabe manter distância, olhar o ponto cego e não usar celular ao volante. Esta reciclagem não vai repetir isso.

Ela trata do que acontece com **quem dirige há muitos anos**: a experiência que protege é a mesma que faz baixar a guarda. O motorista experiente conhece o trajeto, confia no próprio reflexo e passa a dirigir no automático, com a cabeça em outro lugar. E é nesse estado que ele encontra a única coisa contra a qual a experiência não serve de nada: o sono.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os trechos **recuados, com filete ao lado**, são as coisas que mais matam.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Reconhecer os sinais de sono antes da microssoneca.
- Saber quais são as janelas de risco do dia.
- Entender por que à noite a velocidade segura é menor do que parece.
- Reagir corretamente à aquaplanagem e à derrapagem.
- Conduzir carga sem alterar o comportamento do veículo.
- Agir nos primeiros minutos depois de um acidente.

## A microssoneca

É um apagão de dois a dez segundos, do qual a pessoa **não percebe que dormiu**. A dez segundos a 100 km/h, o veículo anda quase trezentos metros sozinho.

Ela não avisa com um bocejo educado. Os sinais reais são estes:

- Piscar mais devagar e sentir os olhos ardendo ou pesando.
- Não lembrar dos últimos quilômetros percorridos.
- Sair da faixa e corrigir com um susto.
- Cabeça pendendo, e a correção brusca do pescoço.
- Pensamento desconexo, dificuldade de manter o foco.
- Ficar irritado sem motivo.

> Quando qualquer um desses aparece, o sono já venceu. Não existe dirigir com sono "com cuidado": o cérebro que decide dormir não pede licença. Só uma coisa resolve, e é parar.

Café e energético dão vinte ou trinta minutos, e o efeito vem acompanhado de uma queda pior depois. Abrir a janela, aumentar o som e conversar não fazem nada. Uma **parada de quinze a vinte minutos com uma soneca curta** é a única medida com efeito real.

### As janelas de risco

O corpo tem horários em que a pressão do sono é maior, e eles não dependem de quanto você dormiu.

| Faixa | Por quê |
| --- | --- |
| Entre 2h e 6h da manhã | O vale mais profundo do ritmo do corpo |
| Entre 13h e 16h | A queda da tarde, mesmo em quem dormiu bem |

Some a isso a monotonia da estrada reta, o calor da cabine e a refeição pesada, e o risco se multiplica.

## À noite, a velocidade segura é menor

Existe um erro silencioso que quase todo motorista experiente comete: **dirigir mais rápido do que o farol enxerga**.

O farol baixo ilumina algo em torno de sessenta metros. A 100 km/h você percorre sessenta metros em pouco mais de dois segundos, ou seja, quando o obstáculo aparece na luz, já não há distância para parar. Você está dirigindo às cegas com a luz acesa.

Por isso, à noite: **a velocidade tem que caber dentro do alcance do farol**. Em estrada sem iluminação, use o alto sempre que possível, e volte ao baixo ao cruzar ou ao se aproximar de outro veículo por trás.

Ofuscamento: se o outro não baixa, **não olhe para o farol dele**. Desvie os olhos para a faixa da direita e siga por ela, reduzindo.

## Aquaplanagem e derrapagem

**Aquaplanagem** é o pneu perdendo contato com o solo por acúmulo de água. O volante fica leve, o motor acelera sem o carro responder, e o veículo passa a deslizar.

1. **Não freie** e **não esterce**.
2. **Tire o pé do acelerador**, devagar.
3. **Mantenha o volante firme e reto.**
4. **Espere** o pneu voltar a tocar o solo, o que acontece em pouco tempo.
5. Só então corrija a trajetória.

O que evita: sulco de pneu em condição, calibragem correta e velocidade compatível com a chuva.

**Derrapagem da traseira**: tire o pé, não freie e **olhe para onde você quer ir**, esterçando suavemente nessa direção. O carro tende a seguir o olhar.

## Carga muda o veículo

Com carga, o veículo passa a ser outro: freia em distância maior, aceita menos curva e tomba mais fácil.

- **Peso baixo e centralizado.** Carga alta levanta o centro de gravidade e é o que faz tombar em curva.
- **Amarração** que impeça deslocamento para frente, para trás e para os lados. Carga solta na freada vira projétil.
- **Nada solto na cabine**: ferramenta, garrafa e capacete soltos voam numa colisão.
- **Distribuição**: peso concentrado num eixo prejudica freio e direção.
- **Revise a amarração** depois dos primeiros quilômetros, porque a carga acomoda.

## Os primeiros minutos depois de um acidente

1. **Sinalize e proteja o local.** Pisca-alerta, triângulo a distância suficiente considerando a velocidade da via, e cuidado com o trânsito que continua vindo.
2. **Saia do veículo com segurança**, pelo lado protegido, e afaste-se da pista.
3. **Chame o socorro**: 192 para vítimas, 193 para os bombeiros, 190 para a polícia. Informe local exato, número de vítimas e se há vazamento ou fogo.
4. **Não movimente vítimas**, exceto se houver risco iminente de fogo ou de novo atropelamento.
5. **Corte o contato** do veículo, se der para chegar com segurança.
6. **Não fume** nem deixe fumar perto.
7. **Avise a empresa**, conforme o procedimento.

> O segundo acidente é comum e costuma ser pior que o primeiro: acontece com quem parou para ajudar e foi atropelado. Antes de socorrer, proteja o local e a si mesmo.

## Os erros que mais aparecem em quem tem experiência

- Achar que reconhece o sono e consegue "segurar mais um pouco".
- Dirigir mais rápido do que o farol alcança.
- Frear na aquaplanagem.
- Confiar no trajeto conhecido e dirigir no automático.
- Levar carga alta ou mal amarrada por ser trecho curto.
- Parar para ajudar num acidente sem proteger o local antes.

## Glossário

**Microssoneca:** episódio de sono de segundos, do qual a pessoa não tem consciência.

**Ofuscamento:** perda momentânea de visão por excesso de luz.

**Sobredirigir o farol:** andar a uma velocidade em que a distância de parada é maior do que o alcance da luz.

## Exercícios

**1.** Você não lembra dos últimos quilômetros. O que isso significa?

**2.** Café resolve o sono ao volante?

**3.** Por que 100 km/h à noite, em estrada sem iluminação, pode ser rápido demais?

**4.** O volante ficou leve numa poça e o carro deslizou. Você freia?

**5.** A carga é leve, mas alta e sem amarração. Trecho de dois quilômetros. Pode?

**6.** Você chega primeiro a um acidente na estrada. Qual a primeira coisa?

### Gabarito comentado

**1.** Que você já teve microssonecas. O trecho existiu, o carro andou, e você não estava presente para registrá-lo. É o sinal mais confiável de que o sono venceu, e a única resposta é parar.

**2.** Não. Dá vinte ou trinta minutos e depois cobra com uma queda maior. O que funciona é parar em local seguro e dormir de quinze a vinte minutos. Janela aberta, som alto e conversa não têm efeito nenhum.

**3.** Porque o farol baixo alcança cerca de sessenta metros, e a 100 km/h você percorre isso em pouco mais de dois segundos. Quando o obstáculo aparece na luz, já não há distância de parada: é dirigir às cegas com a luz acesa.

**4.** Não. Frear ou esterçar na aquaplanagem é o que transforma o deslize em rodopio. Tira-se o pé do acelerador devagar, mantém-se o volante firme e reto, e espera-se o pneu voltar a tocar o solo.

**5.** Não. Carga alta levanta o centro de gravidade e é justamente o que faz tombar em curva, mesmo sendo leve. E carga sem amarração vira projétil numa freada. A distância curta não muda a física, e é em trecho curto que quase todo mundo relaxa.

**6.** Proteger o local e a si mesmo: pisca-alerta, triângulo a distância suficiente, e sair da pista. O segundo acidente é comum e costuma ser pior, e ele acontece com quem parou para ajudar. Só depois de proteger é que se socorre e se chama o 192.

## Referências

- Código de Trânsito Brasileiro e resoluções do CONTRAN.
- Procedimento interno de segurança veicular da empresa.

> Este material é de apoio e não substitui a legislação de trânsito nem o procedimento interno da sua empresa. Em caso de divergência, vale o texto oficial.
'
where codigo = 'DD-REC';

-- ---------------------------------------------------------------------
--  NR-01-INT4: Integracao de seguranca do trabalho
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'Este é o seu primeiro dia, e existe uma estatística incômoda sobre ele: **a chance de se acidentar é maior nos primeiros meses de trabalho num lugar novo do que em todo o resto do tempo ali**. Não por falta de capacidade. Por falta de mapa.

Quem está há dois anos na empresa sabe que aquele corredor tem empilhadeira, que aquela porta abre para fora, que aquele piso escorrega quando lavam. Você ainda não sabe nada disso. Esta integração serve para encurtar esse período.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os trechos **recuados, com filete ao lado**, são o essencial.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Onde ficam as saídas, os extintores e o ponto de encontro.
- O que é a sua ordem de serviço e por que você assina.
- Como reconhecer área isolada e sinalização.
- O que fazer se algo acontecer, e para quem contar.
- Que você pode recusar trabalho com risco grave e iminente.

## As quatro coisas para saber hoje

Antes de qualquer teoria, encontre isto no seu setor, hoje:

1. **Onde é a saída de emergência** mais próxima, e a segunda opção.
2. **Onde está o extintor** mais próximo, e de que tipo.
3. **Onde é o ponto de encontro** em caso de evacuação.
4. **Quem é o seu líder direto** e quem é a segurança do trabalho.

> Numa emergência ninguém procura placa. As pessoas correm para a porta por onde entraram, mesmo que exista uma saída melhor do lado. Descobrir o caminho hoje, calmo, é o que faz você usar o certo depois, no susto.

## A ordem de serviço

É o documento que descreve a sua função, os riscos dela e as regras que você precisa cumprir. Você assina, e a assinatura significa duas coisas: que a empresa informou e que você foi informado.

Não assine sem ler. Se houver algo ali que você não sabe fazer, ou risco que ninguém explicou, é agora o momento de perguntar, e não depois do acidente.

## O que é risco, na prática

Risco é tudo o que pode causar dano. Na empresa eles são organizados em grupos:

| Grupo | Exemplos |
| --- | --- |
| Físico | Ruído, calor, vibração, radiação |
| Químico | Poeira, vapor, produto, fumo |
| Biológico | Vírus, bactéria, fungo |
| Ergonômico | Peso, repetição, postura, ritmo |
| Acidente | Máquina, altura, eletricidade, veículo, piso |

Você não precisa decorar a lista. Precisa saber que **os riscos do seu posto estão levantados num documento**, que existem medidas definidas para eles, e que você tem direito de saber quais são.

## Sinalização: o mínimo

- **Vermelho**: combate a incêndio. Extintor, hidrante, alarme.
- **Amarelo**: cuidado. Piso irregular, desnível, corrimão, faixa de atenção.
- **Verde**: segurança. Saída, chuveiro de emergência, lava-olhos, maca.
- **Azul**: ação obrigatória. É a cor das placas de uso obrigatório de EPI.
- **Faixa listrada, cone, fita e cavalete**: área isolada.

**Área isolada não se atravessa**, nem para encurtar caminho, nem sendo rápido. Alguém isolou porque ali existe algo que machuca. Se você precisa passar, procure quem isolou.

## O EPI

O equipamento que a empresa te entregar tem que ser usado durante toda a exposição ao risco, e não só quando alguém está olhando.

- Ele é **fornecido gratuitamente**, e vem com registro do que você recebeu.
- **Guarde e conserve.** Equipamento sujo ou torto protege menos.
- **Comunique quando danificar ou perder**, e peça a troca. Trabalhar sem, esperando a reposição, é o que causa o acidente.
- **Não empreste** o seu: EPI é individual, e tem ajuste e higiene.

## Se algo acontecer

1. **Cuide da segurança primeiro**, a sua e a de quem está por perto.
2. **Comunique imediatamente** ao seu líder, por menor que pareça.
3. **Procure atendimento**, mesmo em ferimento pequeno.
4. **Não volte** ao trabalho antes da liberação.

E **comunique também o que quase aconteceu**. O quase acidente é o mesmo acidente avisando com antecedência, e de graça.

> Comunicar acidente pequeno não é frescura nem vai te prejudicar: é o que garante o registro, o atendimento e o direito, e é o que faz a empresa corrigir a causa antes que ela pegue outra pessoa.

## O seu direito de recusa

Diante de **risco grave e iminente**, você tem o direito de interromper a tarefa e comunicar ao superior. Isso está previsto na norma, não é insubordinação, e quem manda continuar assume o que vier.

Risco grave e iminente é aquele capaz de causar lesão séria agora, e não daqui a meses.

## Os erros que mais aparecem no começo

- Atravessar área isolada para encurtar caminho.
- Não perguntar por vergonha de parecer inexperiente.
- Aceitar tarefa para a qual não foi treinado, para não desagradar.
- Deixar de comunicar ferimento pequeno.
- Usar EPI só quando o supervisor aparece.
- Copiar o jeito do colega antigo que "faz assim há anos".

## Glossário

**Área isolada:** espaço delimitado por fita, cone ou grade, onde existe risco e por onde não se passa.

**EPI:** equipamento de proteção individual.

**Ordem de serviço:** documento que descreve a função, os riscos e as regras do posto.

**Quase acidente:** evento que quase causou lesão e não causou.

**Risco grave e iminente:** situação capaz de causar lesão séria de imediato.

## Exercícios

**1.** Você cortou levemente o dedo e o sangramento parou sozinho. Comunica?

**2.** O caminho mais curto até o refeitório passa por uma área com fita zebrada. Pode passar?

**3.** Um colega antigo diz que aquela luva "só atrapalha" e ninguém usa. O que fazer?

**4.** Pediram uma tarefa que você nunca fez e para a qual não foi treinado. O que você diz?

**5.** O que significa a cor azul numa placa?

### Gabarito comentado

**1.** Sim. Comunicar garante o registro e o atendimento, e é o que protege você se aquilo infeccionar ou piorar depois. Além disso, o corte pequeno mostra onde está a causa, que da próxima vez pode pegar mais fundo.

**2.** Não. Fita zebrada delimita área isolada, e alguém isolou porque ali existe risco: pode ser piso removido, carga suspensa, serviço acima ou produto no chão. Se precisa passar, procure quem isolou.

**3.** Usar a luva e conversar com o líder ou com a segurança do trabalho. "Ninguém usa" não é procedimento, e se o EPI atrapalha o serviço, o caminho é avaliar o modelo adequado, e não trabalhar sem.

**4.** Que você não foi treinado para aquilo e precisa de orientação antes. Aceitar para não desagradar é como acontece boa parte dos acidentes de quem chegou há pouco. Pedir treinamento não é recusar trabalho.

**5.** Ação obrigatória. É a cor usada nas placas de uso obrigatório de EPI, como capacete, óculos e protetor auricular.

## Referências

- NR-01, Disposições Gerais e Gerenciamento de Riscos Ocupacionais.
- NR-06, Equipamento de Proteção Individual.
- NR-26, Sinalização de Segurança.
- Ordem de serviço e procedimentos internos da empresa.

> Este material é de apoio e não substitui a norma nem o procedimento interno da sua empresa. Em caso de divergência, vale o texto oficial.
'
where codigo = 'NR-01-INT4';

-- ---------------------------------------------------------------------
--  NR-01-INT8: Integracao a NR-01
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'A NR-01 é a norma que organiza todas as outras. Ela não fala de altura, de eletricidade nem de máquina: ela diz **como a empresa deve enxergar os próprios riscos** e o que fazer com o que enxergou.

Antes dela, cada norma pedia um programa. Hoje existe um só caminho, chamado gerenciamento de riscos ocupacionais, e todo o resto pendura nele. Entender esta norma é entender por que a empresa faz o que faz.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os **passos numerados** são sequência.
- Os trechos **recuados, com filete ao lado**, são o que mais gera dúvida.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Explicar o que é o GRO e o que é o PGR.
- Entender como um risco vira linha no inventário e depois vira ação.
- Aplicar a hierarquia de controle, e saber por que o EPI vem por último.
- Reconhecer as responsabilidades de cada lado.
- Saber o que é risco grave e iminente e o que fazer diante dele.

## GRO e PGR

**GRO** é o gerenciamento de riscos ocupacionais: o processo contínuo de identificar perigos, avaliar riscos, controlar e acompanhar.

**PGR** é o documento que registra esse processo. Ele tem duas peças:

| Peça | O que traz |
| --- | --- |
| Inventário de riscos | Tudo o que foi identificado, avaliado e classificado |
| Plano de ação | O que será feito, por quem e até quando |

Sem plano de ação com responsável e prazo, o PGR vira relatório. Com ele, vira trabalho.

## Como um risco vira ação

1. **Identificar o perigo.** O que existe ali capaz de causar dano: a serra sem proteção, o ruído da prensa, o peso da caixa, o produto químico.
2. **Avaliar o risco.** Cruzar a **probabilidade** de acontecer com a **severidade** do dano.
3. **Classificar.** O resultado do cruzamento diz o que é prioridade e o que pode esperar.
4. **Definir o controle**, seguindo a hierarquia.
5. **Registrar no plano de ação**, com responsável e prazo.
6. **Executar e verificar** se o controle funcionou de verdade.
7. **Revisar**, sempre que algo mudar e nos prazos previstos.

> Um risco de severidade alta e probabilidade baixa não é um risco pequeno. Queda de laje acontece raramente e mata sempre. A classificação serve para ordenar o trabalho, e não para justificar deixar coisa grave sem tratamento.

## A hierarquia de controle

Esta é a parte da NR-01 que mais muda a prática, e a ordem é obrigatória.

1. **Eliminar** o risco ou o processo que o gera. Se não é preciso subir, não se sobe.
2. **Substituir** por algo menos perigoso. Outro produto, outro método.
3. **Controle de engenharia**: enclausurar, isolar, exaurir, proteger a máquina.
4. **Controle administrativo**: procedimento, rodízio, sinalização, treinamento, permissão de trabalho.
5. **EPI**, por último.

O EPI vem por último por um motivo prático: ele **depende da pessoa**. Precisa estar disponível, ser o certo, estar ajustado, em bom estado, e ser usado o tempo todo. Falha em qualquer um desses pontos e a proteção some. Uma máquina enclausurada protege mesmo quem chegou hoje e não sabe de nada.

> EPI não é errado nem dispensável: ele é a última barreira. O erro é começar por ele, porque aí a segurança inteira passa a depender de o trabalhador lembrar, todos os dias, para sempre.

## De quem é a responsabilidade

**Do empregador:** identificar os perigos e avaliar os riscos, implementar as medidas, garantir informação e treinamento, fornecer EPI adequado e gratuito, manter os documentos, e cumprir os prazos do plano de ação.

**Do trabalhador:** cumprir as disposições, colaborar com a empresa na aplicação da norma, usar corretamente o que recebeu, submeter-se aos exames médicos previstos e **comunicar as situações de risco** que considerar perigosas.

A obrigação de comunicar não é detalhe: quem está no posto vê o que nenhum documento vê.

## Risco grave e iminente

É a situação capaz de causar lesão grave **de imediato**. Diante dela, o trabalhador pode **interromper a atividade** e comunicar ao superior, e a empresa deve adotar as providências.

Isso não é insubordinação e não pode gerar punição. É a válvula de escape prevista para quando o sistema falhou e alguém está prestes a se machucar.

## Ordem de serviço e treinamento

A empresa precisa dar a você, por escrito, as informações sobre os riscos da sua função e as medidas de controle. E precisa treinar: treinamento inicial, e depois periódico e eventual, quando muda a função, o processo ou o equipamento, ou quando ocorre acidente.

Treinamento não é assinar lista. É o que faz você conseguir executar a tarefa com segurança sem precisar de alguém do lado.

## Os erros que mais aparecem

- Plano de ação sem responsável e sem prazo.
- Começar pelo EPI e parar por aí.
- Tratar o PGR como documento de armário, revisado só na auditoria.
- Confundir perigo com risco.
- Não revisar depois de mudar processo ou equipamento.
- Achar que risco raro é risco pequeno.

## Glossário

**GRO:** gerenciamento de riscos ocupacionais, o processo.

**Inventário de riscos:** relação dos perigos identificados, avaliados e classificados.

**Perigo:** a fonte com potencial de causar dano.

**PGR:** Programa de Gerenciamento de Riscos, o documento.

**Plano de ação:** relação do que será feito, por quem e até quando.

**Risco:** a combinação entre a probabilidade de o dano ocorrer e a severidade dele.

## Exercícios

**1.** Qual a diferença entre perigo e risco?

**2.** Por que o EPI é a última medida da hierarquia?

**3.** Uma queda de laje é rara na obra. Isso torna o risco pequeno?

**4.** O PGR listou o problema, mas ninguém sabe quem resolve nem quando. O que falta?

**5.** Você identificou uma situação que pode machucar alguém hoje. O que faz?

### Gabarito comentado

**1.** Perigo é a fonte capaz de causar dano, como a serra sem proteção. Risco é a combinação entre a chance de aquilo acontecer e a gravidade do que aconteceria. O perigo existe; o risco se mede.

**2.** Porque ele depende da pessoa: precisa estar disponível, ser o certo, estar ajustado, em bom estado, e ser usado o tempo inteiro. Qualquer falha nessa cadeia e a proteção some. Um controle de engenharia protege sem depender de ninguém lembrar.

**3.** Não. A avaliação cruza probabilidade com severidade, e a severidade aqui é máxima. Evento raro de consequência fatal continua sendo prioridade: a classificação serve para ordenar o trabalho, não para adiar o que mata.

**4.** Falta o plano de ação. Inventário sem responsável e sem prazo é diagnóstico sem tratamento: o item se repete de revisão em revisão sem que nada mude.

**5.** Comunica imediatamente ao superior e, se o risco for grave e iminente, interrompe a atividade. Comunicar situações de risco é obrigação prevista na norma, e interromper diante de risco grave e iminente é direito assegurado.

## Referências

- NR-01, Disposições Gerais e Gerenciamento de Riscos Ocupacionais.
- NR-06, Equipamento de Proteção Individual.
- NR-05, Comissão Interna de Prevenção de Acidentes e de Assédio.
- PGR e ordem de serviço da sua empresa.

> Este material é de apoio e não substitui a norma nem o procedimento interno da sua empresa. Em caso de divergência, vale o texto oficial da norma.
'
where codigo = 'NR-01-INT8';

-- ---------------------------------------------------------------------
--  NR-06: Uso de EPI
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'EPI é a última barreira entre você e o dano, e é a única que depende inteiramente de uma pessoa: você. A máquina protegida protege até quem chegou hoje e não sabe de nada. O EPI protege apenas quem o está usando, do jeito certo, naquele momento.

Por isso este treinamento fala pouco de lista de equipamento e muito de três coisas que decidem se ele funciona: **ser o certo, estar em condição e estar ajustado**.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os trechos **recuados, com filete ao lado**, são o que mais anula a proteção.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Saber o que é o CA e por que ele importa.
- Conhecer as obrigações do empregador e as suas.
- Escolher, ajustar, conservar e trocar o equipamento.
- Reconhecer quando um EPI deixou de proteger.

## O EPI é a última barreira

A norma manda seguir uma ordem: primeiro eliminar o risco, depois substituir, depois proteger o coletivo com engenharia, depois organizar o trabalho, e só então o EPI.

Isso não diminui o EPI. Significa apenas que **começar por ele é errado**, porque aí toda a segurança passa a depender de alguém lembrar, todos os dias, para sempre.

## O Certificado de Aprovação

Todo EPI vendido e usado no Brasil precisa ter o **CA**, número impresso no próprio equipamento. Ele é a prova de que aquele modelo foi ensaiado e aprovado para o risco a que se destina.

O que isso significa na prática:

- **Sem CA, não é EPI.** É acessório.
- O CA tem **validade**, e equipamento com CA vencido não serve.
- O CA vale para **aquele risco**. Luva aprovada para risco mecânico não protege contra produto químico, mesmo parecendo igual.

## Quem faz o quê

| Do empregador | Do trabalhador |
| --- | --- |
| Fornecer gratuitamente, adequado ao risco | Usar apenas para a finalidade a que se destina |
| Escolher o modelo certo para a atividade | Usar durante toda a exposição ao risco |
| Orientar e treinar sobre o uso | Responsabilizar-se pela guarda e conservação |
| Substituir quando danificado ou vencido | Comunicar qualquer alteração que o torne impróprio |
| Higienizar e manter | Cumprir as orientações recebidas |
| Registrar a entrega | |

O registro de entrega existe para os dois lados: prova que a empresa forneceu e prova que você recebeu aquele modelo, naquela data.

## Ser o certo

O erro mais comum não é a falta de EPI: é o EPI **errado para aquele risco**.

- **Óculos** de proteção mecânica não protege contra respingo químico, que exige ampla visão ou protetor facial.
- **Luva** de raspa protege contra abrasão e não contra produto químico nem contra eletricidade.
- **Respirador** com filtro para poeira não retém vapor orgânico, e filtro nenhum fabrica oxigênio.
- **Protetor auricular** tem atenuação declarada; a escolha depende do ruído medido no posto.

## Estar ajustado

Equipamento do tamanho errado protege menos, e às vezes não protege nada.

**Capacete**: a suspensão interna é o que absorve o impacto, e ela precisa estar ajustada à cabeça, com espaço entre o casco e o crânio. Jugular quando houver risco de queda ou de o capacete sair. Capacete que sofreu impacto é descartado, mesmo parecendo inteiro.

**Respirador**: só protege se **vedar**. Barba na região da vedação impede o ajuste, e é uma das causas mais frequentes de exposição em quem estava usando proteção. Antes de cada uso, faça a **verificação de vedação**: tape a entrada de ar e inspire, e a peça deve colar levemente no rosto sem entrar ar pelas bordas.

**Protetor auricular tipo plugue**: precisa ser inserido corretamente, com o canal esticado, e não apenas encostado na orelha. Mal inserido, perde a maior parte da atenuação.

**Cinturão paraquedista**: fitas ajustadas, sem folga, com o ponto de conexão na posição correta.

> Muita gente acha que está protegida e não está. Respirador por cima da barba, plugue mal enfiado e capacete frouxo dão a sensação de proteção sem a proteção. Nesses casos, o EPI virou enfeite que tranquiliza.

## Conservar, guardar e trocar

- **Higienize** conforme a orientação. Suor e sujeira degradam o material.
- **Guarde** em local próprio, longe de sol, calor, umidade e produto químico. Luva isolante guardada dobrada num porta-luvas quente racha.
- **Inspecione antes de cada uso**: corte, furo, ressecamento, deformação, costura solta, etiqueta ilegível.
- **Troque** quando o prazo vencer, quando danificar, ou quando sofrer um evento, como uma queda contida.
- **Não empreste**: além da higiene, o ajuste é individual.
- **Comunique** a perda ou o dano e peça a reposição. Trabalhar sem, esperando, é o que causa o acidente.

## Os erros que mais aparecem

- Usar EPI aprovado para outro risco.
- Respirador sobre barba.
- Plugue auricular só encostado no ouvido.
- Guardar luva isolante dobrada, no calor.
- Continuar com equipamento vencido ou já danificado.
- Emprestar o próprio EPI.
- Tirar "só um instante" durante a exposição.

## Glossário

**Atenuação:** quanto o protetor auricular reduz do ruído, em decibéis.

**CA:** Certificado de Aprovação, o número que identifica o modelo aprovado.

**EPC:** equipamento de proteção coletiva, que protege todo mundo ao mesmo tempo.

**Verificação de vedação:** teste rápido feito pelo usuário para conferir se o respirador está selando no rosto.

## Exercícios

**1.** A luva de raspa serve para manusear solvente?

**2.** O capacete caiu de dois metros e não trincou. Continua servindo?

**3.** Um colega usa respirador por cima da barba. Ele está protegido?

**4.** O EPI que você recebeu vive apertando e machucando. O que fazer?

**5.** Por que o EPI é a última medida da hierarquia de controle?

### Gabarito comentado

**1.** Não. Luva de raspa é para risco mecânico, abrasão e calor moderado. Solvente atravessa o couro e ainda fica retido dentro da luva, em contato prolongado com a pele. Para produto químico, a luva tem que ser aprovada para aquele produto.

**2.** Não. O capacete trabalha deformando para absorver o impacto, e essa deformação pode não ser visível. Depois de sofrer impacto, ele é descartado, mesmo parecendo inteiro.

**3.** Não. O respirador só protege se vedar, e barba na região da vedação abre caminho para o ar contaminado entrar pelas bordas. Ele fica com a sensação de proteção sem a proteção, que é a pior das situações.

**4.** Comunicar e pedir a substituição pelo tamanho ou modelo adequado. EPI que machuca acaba sendo tirado, e a proteção some. Ajuste não é conforto: é condição para funcionar.

**5.** Porque depende inteiramente da pessoa: estar disponível, ser o certo, estar ajustado, em condição, e ser usado durante toda a exposição. As medidas anteriores protegem sem depender de ninguém lembrar.

## Referências

- NR-06, Equipamento de Proteção Individual.
- NR-01, Disposições Gerais e Gerenciamento de Riscos Ocupacionais.
- NR-09, Avaliação e Controle das Exposições Ocupacionais a Agentes Físicos, Químicos e Biológicos.

> Este material é de apoio e não substitui a norma, a orientação do fabricante do equipamento nem o procedimento interno da sua empresa. Em caso de divergência, vale o texto oficial.
'
where codigo = 'NR-06';

-- ---------------------------------------------------------------------
--  NR-17: Ergonomia
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'Ergonomia é o único assunto de segurança do trabalho em que o dano não tem um instante. Não existe o momento em que a coluna se machucou: existe um ano de levantar peso errado, e um dia em que ela avisa.

Por isso ela é a mais fácil de ignorar e a que mais afasta gente do trabalho. Ninguém sai de casa preocupado com a própria postura, e é justamente esse tipo de risco, silencioso e acumulado, que este material trata.

A ideia central da norma é simples e vale a pena guardar: **o trabalho se adapta à pessoa, e não a pessoa ao trabalho**.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os **passos numerados** são sequência.
- Os trechos **recuados, com filete ao lado**, são o que mais adoece.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Levantar e transportar carga sem sacrificar a coluna.
- Reconhecer postura forçada e trabalho repetitivo.
- Ajustar posto de trabalho sentado e em pé.
- Entender por que pausa não é perda de tempo.
- Saber quando pedir avaliação ergonômica.

## Levantar peso

A coluna aguenta compressão e não aguenta compressão **com o tronco inclinado e girado**. É a combinação de peso, distância e torção que arrebenta o disco.

1. **Avalie antes**: o peso, o trajeto, o destino, e se dá para usar equipamento.
2. **Chegue perto da carga.** Cada centímetro afastado do corpo multiplica o esforço na coluna.
3. **Afaste os pés**, um pouco à frente do outro, para ter base.
4. **Dobre os joelhos**, mantendo as costas retas e o olhar à frente.
5. **Segure firme** e traga a carga para junto do corpo.
6. **Suba com as pernas**, sem solavanco.
7. **Gire com os pés**, nunca com a cintura.
8. **Deposite** dobrando os joelhos de novo.

> A torção é o que mais machuca. Levantar bem e depois girar o tronco para colocar a caixa na esteira anula tudo o que foi feito certo. Movem-se os pés.

E antes de tudo isso: **carga que pode ser dividida, empurrada, arrastada ou movida com equipamento não precisa ser levantada.** A melhor técnica de levantamento é não levantar.

## Trabalho repetitivo

O dano por repetição depende de quatro coisas: **força, repetição, postura e tempo sem recuperação**. Movimento leve repetido milhares de vezes por dia, com o punho torto, causa mais lesão do que um esforço grande e ocasional.

O que reduz:

- **Alternar tarefas** ao longo do turno, para mudar o grupo muscular usado.
- **Pausas curtas e frequentes**, que valem mais que uma pausa longa no fim.
- **Ferramenta adequada**, que dispense torcer o punho e apertar com força.
- **Altura de trabalho certa**, para não trabalhar com o ombro elevado.

> Pausa não é perda de produção: o corpo se recupera durante ela, e sem recuperação a lesão se instala. O afastamento que vem depois custa muito mais tempo do que todas as pausas somadas.

## Posto de trabalho sentado

| Parte | Como deve ficar |
| --- | --- |
| Pés | Apoiados no chão ou em apoio, sem pressão na coxa |
| Joelhos | Em ângulo próximo de 90 graus |
| Costas | Apoiadas no encosto, com a lombar sustentada |
| Ombros | Relaxados, sem elevação |
| Cotovelos | Próximos ao corpo, em ângulo próximo de 90 graus |
| Punhos | Retos, sem apoiar sobre quina |
| Tela | Topo na altura dos olhos, a cerca de um braço de distância |

Cadeira precisa ter regulagem de altura e encosto, e a mesa precisa deixar espaço para as pernas. Trabalhar em notebook sem suporte e sem teclado externo obriga a escolher entre pescoço torto e punho torto: com o suporte, não é preciso escolher.

## Trabalho em pé

- **Alterne a posição** e mude o apoio do peso.
- **Apoio para um dos pés**, alternando, alivia bastante a lombar.
- **Calçado** com amortecimento e sem salto rígido.
- **Tapete antifadiga** onde a permanência é longa.
- **Bancada na altura certa**: trabalho de precisão mais alto, trabalho de força mais baixo.
- **Assento disponível** para as pausas, mesmo que a atividade seja em pé.

## Ambiente

**Iluminação** suficiente e sem ofuscamento, com a luz vindo do lado e não de trás da tela nem de frente para os olhos.

**Ruído** confortável nas atividades que exigem concentração e comunicação.

**Temperatura e ventilação** compatíveis com a atividade.

**Ritmo**: exigências de produção que obriguem a abrir mão da postura e da pausa são, elas próprias, um risco ergonômico. O ritmo entra na avaliação.

## A avaliação ergonômica

Quando há queixa, afastamento, mudança de processo ou posto novo, a empresa faz a avaliação ergonômica: alguém observa o trabalho **como ele é feito de verdade**, mede, ouve quem trabalha ali, e propõe mudanças com prazo.

Quem trabalha no posto é a fonte mais confiável dessa avaliação. Se ninguém perguntou a você, avise.

## Os erros que mais aparecem

- Levantar com as costas e girar com a cintura.
- Carregar a caixa afastada do corpo.
- Encarar dor como parte do serviço e não comunicar.
- Notebook direto na mesa, o dia inteiro.
- Trabalhar com o ombro elevado por causa da altura da bancada.
- Juntar todas as pausas no fim do turno.
- Regular a cadeira uma vez e nunca mais.

## Glossário

**Avaliação ergonômica:** análise do trabalho real, com medições e propostas de melhoria.

**Postura forçada:** posição mantida fora da neutra, que aumenta a carga sobre articulações.

**Trabalho estático:** manter a mesma posição por longo tempo, que cansa mais do que o movimento.

## Exercícios

**1.** Qual é o pior momento do levantamento de peso?

**2.** Uma caixa leve, levantada mil vezes por dia, é um problema ergonômico?

**3.** Por que trabalhar em notebook sem suporte adoece?

**4.** É melhor uma pausa de vinte minutos no fim do turno ou pausas curtas ao longo dele?

**5.** Você sente dor no punho no fim do dia, mas ela passa dormindo. Comunica?

### Gabarito comentado

**1.** A torção. Girar o tronco com a carga nas mãos combina compressão e rotação no disco, e é a combinação que mais causa lesão. Levanta-se com as pernas e gira-se com os pés.

**2.** É, e dos sérios. O dano por repetição depende de força, repetição, postura e tempo sem recuperação. Peso pequeno repetido milhares de vezes, com punho torto, causa mais lesão do que um esforço grande e isolado.

**3.** Porque a tela e o teclado ficam presos um ao outro: na altura certa para os olhos, o teclado fica alto demais; na altura certa para as mãos, a tela fica baixa e o pescoço curva. Suporte com teclado externo desfaz a escolha.

**4.** Pausas curtas e frequentes. A recuperação acontece durante a pausa, e ela precisa vir antes de a fadiga se acumular. Juntar tudo no fim é recuperar quando o dano do dia já foi feito.

**5.** Sim. Dor que aparece no fim do dia e melhora com o repouso é o primeiro estágio das lesões por esforço repetitivo, e é justamente o estágio em que ainda dá para reverter mudando o posto. Esperar piorar é o que leva ao afastamento.

## Referências

- NR-17, Ergonomia.
- NR-01, Disposições Gerais e Gerenciamento de Riscos Ocupacionais.
- Avaliação ergonômica preliminar e análise ergonômica do trabalho da sua empresa.

> Este material é de apoio e não substitui a norma, a avaliação ergonômica do seu posto nem a orientação do responsável técnico. Em caso de divergência, vale o texto oficial da norma.
'
where codigo = 'NR-17';

-- ---------------------------------------------------------------------
--  NR-26: Sinalizacao de seguranca
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'Sinalização é a única proteção que funciona sem ninguém por perto. Ela avisa às três da manhã, avisa para o terceirizado que chegou hoje, avisa para quem não fala a sua língua. Custa pouco e trabalha sozinha.

Só que ela tem uma condição para funcionar: **ser entendida na hora, sem pensar**. Placa que precisa ser interpretada já falhou, e sinalização demais funciona tão mal quanto sinalização nenhuma, porque o olho para de ver o que está sempre lá.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os trechos **recuados, com filete ao lado**, são o essencial.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Reconhecer as cores de segurança e o que cada uma manda fazer.
- Ler um rótulo de produto químico e saber onde está a ficha de segurança.
- Entender por que sinalização em excesso deixa de proteger.
- Saber sinalizar uma área temporária corretamente.

## As cores

A norma padroniza as cores usadas na prevenção. Elas identificam equipamento, delimitam área e advertem contra risco.

| Cor | O que indica |
| --- | --- |
| Vermelho | Combate a incêndio: extintor, hidrante, alarme, sprinkler |
| Amarelo | Cuidado, atenção: desnível, quina, corrimão, faixa de piso |
| Verde | Segurança: saída, chuveiro de emergência, lava-olhos, maca |
| Azul | Ação obrigatória, e equipamento fora de operação |
| Laranja | Partes móveis e perigosas de máquinas |
| Púrpura | Radiação ionizante |
| Branco | Faixas de circulação, áreas de armazenagem, coletores |
| Preto | Coletores de resíduos |

O que mais confunde: **azul não é informação, é ordem**. É a cor das placas de uso obrigatório de EPI e do aviso de equipamento em manutenção que não pode ser ligado.

E o vermelho é reservado ao combate a incêndio: pintar de vermelho o que não tem nada a ver com fogo enfraquece o único código que precisa ser óbvio numa emergência.

> A empresa pode ter um padrão interno mais detalhado, e ele prevalece dentro dela. O que não pode é cada setor inventar o seu: a sinalização só protege enquanto significa a mesma coisa no galpão inteiro.

## Sinalização de área temporária

A área isolada é o tipo de sinalização que mais salva e a que mais gente desrespeita, porque ela nasce e some no mesmo dia.

1. **Delimite todo o perímetro**, e não só a frente. Quase todo mundo entra pelo lado que ficou aberto.
2. **Use fita, cone, cavalete ou grade**, conforme o risco e o tempo.
3. **Coloque a placa** dizendo o que há e quem responde.
4. **Sinalize o pavimento de baixo**, quando houver risco de queda de material.
5. **Retire assim que terminar.** Isolamento esquecido ensina todo mundo a ignorar isolamento.

## Rótulo de produto químico

Todo produto precisa vir com o rótulo do fabricante, com o nome do produto, os pictogramas de perigo, a palavra de advertência (**perigo** ou **atenção**), as frases de perigo e as de precaução.

- **Nunca use embalagem sem rótulo**, e nunca transfira produto para garrafa de refrigerante. É como acontecem os envenenamentos.
- **Rótulo apagado ou ilegível** tira o produto de uso até ser identificado.
- A **ficha de informações de segurança** precisa estar acessível a quem manuseia, e é ela que traz o que fazer em caso de contato, ingestão, incêndio e derramamento.

## Por que sinalização demais atrapalha

O olho aprende a ignorar o que está sempre presente. Um corredor com quarenta placas não tem nenhuma placa: tem parede decorada.

O que faz a sinalização funcionar é ser **pouca, no lugar certo, legível e verdadeira**. Placa desatualizada, avisando de um risco que não existe mais, ensina as pessoas a duvidar de todas as outras.

## Os erros que mais aparecem

- Pintar de vermelho o que não é combate a incêndio.
- Isolar só a frente da área.
- Deixar isolamento montado depois que o serviço acabou.
- Transferir produto químico para embalagem sem rótulo.
- Cobrir extintor, hidrante ou placa de saída com material empilhado.
- Encher o corredor de placas e achar que isso é segurança.

## Glossário

**FISPQ:** ficha de informações de segurança de produto químico.

**Palavra de advertência:** perigo ou atenção, indicando a gravidade.

**Pictograma:** símbolo dentro do losango vermelho do rótulo, que indica o tipo de perigo.

## Exercícios

**1.** Qual cor identifica a obrigação de usar EPI?

**2.** Uma máquina está em manutenção e não pode ser ligada. Qual cor?

**3.** Você precisa isolar uma área para trocar uma lâmpada no alto. Como faz?

**4.** Sobrou solvente e a lata original furou. Pode passar para uma garrafa PET?

**5.** Um corredor tem trinta placas de aviso. Isso é bom?

### Gabarito comentado

**1.** Azul. Ela indica ação obrigatória, e é a cor das placas de uso obrigatório de capacete, óculos, protetor auricular e demais equipamentos.

**2.** Azul também. Além da ação obrigatória, o azul identifica equipamento fora de operação que não pode ser acionado. Na prática ela vem junto do bloqueio e da etiqueta com o nome de quem bloqueou.

**3.** Delimitando todo o perímetro abaixo do serviço, e não só a frente, com fita ou cone, placa dizendo o que está acontecendo e quem responde, e retirando o isolamento assim que terminar.

**4.** Não. Produto químico em embalagem de bebida é uma das principais causas de ingestão acidental, e sem rótulo ninguém sabe o que é nem o que fazer em caso de contato. O produto vai para recipiente apropriado e identificado.

**5.** Não. O olho ignora o que está sempre presente, e trinta placas equivalem a nenhuma. Sinalização funciona quando é pouca, no lugar certo, legível e verdadeira.

## Referências

- NR-26, Sinalização de Segurança.
- NBR 7195, Cores para segurança, ABNT.
- Sistema Globalmente Harmonizado de classificação e rotulagem de produtos químicos.
- Fichas de informações de segurança dos produtos usados na sua empresa.

> Este material é de apoio e não substitui a norma, o padrão interno da sua empresa nem a ficha de segurança do produto. Em caso de divergência, vale o texto oficial.
'
where codigo = 'NR-26';

-- ---------------------------------------------------------------------
--  LOTO: Bloqueio e etiquetagem
-- ---------------------------------------------------------------------
update public.trein_curso set apostila =
'Quase toda amputação em manutenção tem a mesma história: a máquina estava desligada, alguém a ligou, e quem estava com a mão dentro dela não teve tempo de nada.

O bloqueio existe para tornar essa história impossível. Ele não depende de aviso, de bom senso, de rádio nem de alguém lembrar: depende de um cadeado físico cuja **única chave está no seu bolso**.

## Como usar este material

- Os **quadros** existem para consulta rápida.
- Os **passos numerados** são sequência obrigatória, e a ordem é a proteção.
- Os trechos **recuados, com filete ao lado**, são o que mais mutila.
- No fim há **exercícios com gabarito comentado**.

## O que você deve saber ao final

- Identificar todas as fontes de energia de um equipamento, inclusive as guardadas.
- Executar os seis passos do bloqueio, na ordem.
- Entender por que o cadeado é individual e por que só quem colocou retira.
- Usar caixa de bloqueio no trabalho em equipe.
- Reconhecer quando o bloqueio ainda não está completo.

## Desligado não é bloqueado

| Situação | Protege? |
| --- | --- |
| Botão desligado | Não. Qualquer um liga de volta |
| Chave geral desligada, sem cadeado | Não. Alguém liga achando que resolve |
| Aviso no rádio para não ligar | Não. Rádio falha, gente troca de turno |
| Placa avisando, sem cadeado | Não. Placa não impede a mão |
| Cadeado individual, com a chave no seu bolso | **Sim** |

## As energias que ninguém lembra

A energia elétrica é a que todo mundo bloqueia. As outras são as que pegam.

- **Mecânica guardada**: peça suspensa que desce pelo próprio peso, contrapeso, volante girando por inércia.
- **Mola** comprimida ou tensionada, que solta ao desmontar.
- **Pneumática**: ar preso em reservatório e em cilindro, que move a peça mesmo com o compressor desligado.
- **Hidráulica**: óleo sob pressão na linha.
- **Térmica**: superfície quente, vapor, fluido aquecido.
- **Química**: produto na linha, que precisa de bloqueio físico e não de válvula fechada.
- **Elétrica armazenada**: capacitor carregado, nobreak, banco de baterias, inversor de painel solar.

> Válvula fechada não é bloqueio. Válvula vaza, válvula é aberta por engano e válvula não tem cadeado. Bloqueio de linha é raquete, disco cego ou desconexão física.

## Os seis passos

1. **Prepare e avise.** Saiba quais são as fontes, quais dispositivos existem e comunique quem opera e quem depende do equipamento.
2. **Desligue** pelo procedimento normal de parada, sem cortar bruto.
3. **Isole** cada fonte de energia no dispositivo de seccionamento correspondente.
4. **Bloqueie e etiquete**: cadeado individual em cada dispositivo, com etiqueta trazendo **nome, data e motivo**. A chave fica com você.
5. **Dissipe a energia guardada**: baixe a peça suspensa ou calce, alivie o ar e o óleo, descarregue capacitores, espere esfriar, drene a linha.
6. **Teste**: acione o comando de partida e confirme que nada se move, e meça a ausência de tensão onde couber. Depois devolva o comando à posição desligada.

O passo 6 é o que transforma bloqueio em segurança. Sem testar, você tem uma sequência bem-intencionada; com o teste, você tem certeza.

## Cadeado individual

Cada pessoa que vai trabalhar no equipamento coloca **o seu próprio cadeado**, e guarda a própria chave.

- Um cadeado só, do encarregado, **não** serve para a equipe: quando ele sair, libera a máquina com os outros ainda dentro dela.
- **Só quem colocou retira.** Ninguém corta cadeado dos outros, ninguém retira "porque o colega já foi embora".
- Quando há muitos dispositivos ou muita gente, usa-se a **caixa de bloqueio**: as chaves dos dispositivos ficam trancadas dentro dela, e cada trabalhador põe o seu cadeado na caixa. Ela só abre quando o último cadeado sair.

> A regra de ouro é esta: **a máquina volta quando o último cadeado sair, e não quando o serviço parecer terminado.**

## Quando alguém esquece o cadeado

Acontece: a pessoa foi embora com a chave no bolso. Isso não autoriza cortar o cadeado por conta própria.

Existe um procedimento formal para essa situação, que envolve confirmar que a pessoa não está na área, tentar contato, autorização de um responsável designado e registro do que foi feito. Cortar cadeado sem esse procedimento é a forma mais direta de matar alguém que voltou para pegar uma ferramenta.

## Ao devolver a máquina

1. Retire ferramentas, peças e materiais.
2. Recoloque **todas as proteções** que foram removidas.
3. Afaste as pessoas da área.
4. Cada um retira o **seu** cadeado e a sua etiqueta.
5. Comunique quem opera.
6. Religue, e acompanhe a partida.

Proteção esquecida do lado de fora é o acidente da semana seguinte.

## Os erros que mais aparecem

- Confiar no botão desligado.
- Bloquear só a energia elétrica.
- Achar que válvula fechada é bloqueio.
- Um cadeado só para a equipe inteira.
- Pular o teste de partida.
- Retirar o cadeado do colega.
- Devolver a máquina sem recolocar as proteções.

## Glossário

**Caixa de bloqueio:** caixa onde ficam trancadas as chaves dos dispositivos, e que recebe o cadeado de cada trabalhador.

**Dispositivo de bloqueio:** peça que prende o seccionador na posição desligada e recebe o cadeado.

**Energia residual:** energia que permanece armazenada depois do desligamento.

**Etiqueta:** identificação que acompanha o cadeado, com nome, data e motivo.

**Raquete:** disco metálico instalado entre flanges para interromper fisicamente uma linha.

## Exercícios

**1.** A chave geral foi desligada e cadeada. A prensa está segura?

**2.** Três pessoas vão trabalhar na mesma máquina. Quantos cadeados?

**3.** O colega foi embora e esqueceu o cadeado. Pode cortar?

**4.** A linha de produto foi isolada fechando a válvula. É bloqueio?

**5.** Por que o teste de partida é indispensável?

### Gabarito comentado

**1.** Ainda não necessariamente. Falta dissipar a energia guardada: a matriz pode estar suspensa e descer pelo próprio peso, pode haver ar no reservatório, óleo sob pressão e capacitor carregado. E falta testar.

**2.** Três, um de cada, cada um com a própria chave, ou os três na caixa de bloqueio. Com um cadeado só, quem sair primeiro libera a máquina com os outros ainda trabalhando nela.

**3.** Não por conta própria. Existe procedimento formal: confirmar que a pessoa não está na área, tentar contato, obter autorização do responsável designado e registrar. Cortar sem isso mata quem voltou para pegar uma ferramenta.

**4.** Não. Válvula vaza, é aberta por engano e não recebe cadeado. Bloqueio de linha é raquete, disco cego ou desconexão física, com cadeado no dispositivo.

**5.** Porque é ele que prova que o bloqueio funcionou. Sem o teste, você tem uma sequência bem-intencionada que pode ter falhado num ponto qualquer: dispositivo errado, fonte esquecida, energia ainda armazenada. Com o teste, você tem certeza.

## Referências

- NR-12, Segurança no Trabalho em Máquinas e Equipamentos.
- NR-10, Segurança em Instalações e Serviços em Eletricidade.
- NR-33, Segurança e Saúde nos Trabalhos em Espaços Confinados.
- Procedimento de bloqueio e etiquetagem da sua empresa.

> Este material é de apoio e não substitui a norma, o procedimento interno da sua empresa nem a orientação do responsável técnico. Em caso de divergência, vale o texto oficial.
'
where codigo = 'LOTO';


-- =====================================================================
--  CONFERENCIA FINAL
--
--  Uma consulta so, com tudo o que precisa estar certo. Todas as linhas
--  tem de vir com `ok` na ultima coluna. Qualquer `FALTA` me mande.
--
--  As contas sao por FAIXA, e nao por numero exato: a Anandda vai
--  corrigir questao e reescrever apostila, e uma conferencia que exige
--  numero exato passaria a acusar erro justamente quando o material
--  estivesse sendo melhorado.
-- =====================================================================
with olhada as (
  select 1 as ordem,
         'apostilas escritas' as item,
         (select count(*) from public.trein_curso
           where ativo and apostila is not null
             and length(apostila) > 400)::text as encontrei,
         'os 19' as esperado,
         (select count(*) from public.trein_curso
           where ativo and apostila is not null
             and length(apostila) > 400) = 19 as passou

  union all select 2, 'apostila da NR-10, em palavras',
         coalesce((select array_length(
                     regexp_split_to_array(apostila, '\s+'), 1)::text
                     from public.trein_curso where codigo = 'NR-10'), 'nenhuma'),
         'mais de 3.000',
         coalesce((select array_length(
                     regexp_split_to_array(apostila, '\s+'), 1)
                     from public.trein_curso where codigo = 'NR-10'), 0) > 3000

  union all select 3, 'apostilas fundas (NR-33, NR-35, NR-12)',
         (select count(*) from public.trein_curso
           where codigo in ('NR-33','NR-35-REC','NR-12')
             and length(apostila) > 8000)::text,
         'as 3',
         (select count(*) from public.trein_curso
           where codigo in ('NR-33','NR-35-REC','NR-12')
             and length(apostila) > 8000) = 3

  union all select 4, 'cursos na vitrine',
         (select count(*) from public.trein_curso where ativo)::text,
         '19', (select count(*) from public.trein_curso where ativo) = 19

  union all select 5, 'apostila fechada para quem nao tem login',
         (not has_column_privilege('anon','public.trein_curso',
                                   'apostila','select'))::text,
         'true',
         not has_column_privilege('anon','public.trein_curso',
                                  'apostila','select')

  union all select 6, 'titulo aberto (a vitrine depende dele)',
         has_column_privilege('anon','public.trein_curso',
                              'titulo','select')::text,
         'true',
         has_column_privilege('anon','public.trein_curso',
                              'titulo','select')

  union all select 7, 'porta da apostila do aluno',
         (select count(*) from pg_proc p
            join pg_namespace n on n.oid = p.pronamespace
           where n.nspname = 'public' and p.proname = 'trein_apostila')::text,
         '1',
         (select count(*) from pg_proc p
            join pg_namespace n on n.oid = p.pronamespace
           where n.nspname = 'public' and p.proname = 'trein_apostila') = 1

  union all select 8, 'bucket libera a assinatura para quem tem login',
         (select coalesce(bool_or(qual like '%responsavel%'), false)
            from pg_policies where schemaname = 'storage'
              and tablename = 'objects'
              and policyname = 'trein_stor_read')::text,
         'true',
         (select coalesce(bool_or(qual like '%responsavel%'), false)
            from pg_policies where schemaname = 'storage'
              and tablename = 'objects'
              and policyname = 'trein_stor_read')

  union all select 9, 'questoes no banco',
         (select count(*) from public.trein_questao)::text,
         'pelo menos 2.500',
         (select count(*) from public.trein_questao) >= 2500

  union all select 10, 'aulas com video (o que falta para abrir)',
         (select count(*) from public.trein_aula)::text,
         'pelo menos 1',
         (select count(*) from public.trein_aula) >= 1
)
select item, encontrei, esperado,
       case when passou then 'ok' else 'FALTA' end as situacao
  from olhada order by ordem;
