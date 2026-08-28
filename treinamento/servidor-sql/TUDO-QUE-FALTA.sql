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

O curso básico tem quarenta horas. Quem atua no sistema elétrico de potência, ou seja, na geração, transmissão e distribuição, precisa também do complementar, com mais quarenta horas.

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
