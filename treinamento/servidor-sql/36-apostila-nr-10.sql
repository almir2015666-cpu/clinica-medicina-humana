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

-- =====================================================================
--  Confira
-- =====================================================================
select codigo,
       length(apostila)                                as caracteres,
       array_length(regexp_split_to_array(apostila, '\s+'), 1) as palavras,
       (length(apostila) - length(replace(apostila, '## ', ''))) / 3 as secoes
  from public.trein_curso
 where codigo = 'NR-10';
