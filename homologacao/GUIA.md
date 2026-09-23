# Homologação de atestados: como ligar

A homologação tem três partes:

- **Site:** `clinicamedicinahumana.com.br/homologacao/`. É onde o RH lança os atestados e o Dr. Everaldo dá o parecer.
- **Banco no Supabase:** onde ficam as tabelas, as regras de acesso e os arquivos dos atestados.
- **Módulo "Homologação" no SistemaCMH:** a clínica tira dele o login do RH a partir de cada contrato assinado pelos dois lados.

Faça os passos **nesta ordem**. Até o passo 1 terminar, o site mostra erro ao entrar.

## 1. O banco (uma vez)

1. Abra o Supabase, depois **SQL Editor** e **New query**.
2. Cole o arquivo **`homologacao/servidor-sql/01-esquema.sql` inteiro** e clique em **Run**.
3. No fim aparece uma tabela de conferência. A coluna **achei** tem de bater com a coluna **esperado** em todas as linhas:

| o_que | esperado |
|---|---|
| tabelas homol_ | 7 |
| tabelas com RLS ligada | 7 |
| gatilhos | 7 |
| balde de anexos privado | true |
| politicas do storage | 3 |
| anon NAO le processos | true |

Pode rodar o arquivo de novo sempre que ele mudar. Ele não apaga nada.

### 1.1. O arquivo que veio depois

Cole o **`homologacao/servidor-sql/02-cpf-e-historico.sql` inteiro** no
mesmo SQL Editor e clique em **Run**. Ele faz duas coisas:

- o colaborador passa a ser identificado pelo **CPF**, e não pela
  matrícula (a matrícula é o número que a *empresa* dá ao empregado:
  repete entre empresas, não tem dígito para conferir contra erro de
  digitação, e some quando a pessoa troca de emprego — justamente quando
  o histórico de atestados dela mais importa);
- o **histórico do processo** para de repetir o mesmo evento e passa a
  dizer *o quê* mudou, campo a campo. Alteração feita **depois** do
  parecer sai marcada com "ALTERADO DEPOIS DO PARECER".

Pode rodar de novo. No fim, quatro conferências mostram se pegou.

O histórico do colaborador **continua preso à empresa**, de propósito: o
RH da empresa B não vê o que a pessoa apresentou na empresa A, mesmo
sendo a mesma pessoa. Atestado é dado de saúde. Quem vê tudo é o médico,
que já via.

## 2. A função que cria o login do RH (uma vez)

1. Abra **Edge Functions**, clique em **Deploy a new function** e depois em **Via Editor**.
2. Dê o nome **`homologacao-rh`**.
3. Apague o exemplo, cole **`homologacao/servidor-edge/homologacao-rh/index.ts`** e clique em **Deploy**.
4. Deixe **Verify JWT ligado**. Quem chama a função é sempre alguém logado no SistemaCMH.
5. Confira o **slug** que o painel deu, que aparece na URL da função:
   - se for `homologacao-rh`, está pronto;
   - se vier outro, ajuste a constante `FUNCAO_HOMOLOGACAO` no `homologacao_nucleo.py` do SistemaCMH e publique o programa de novo.

A função usa os segredos que já existem no projeto. Não é preciso criar nenhum.

## 3. O e-mail com a carta de acesso

A carta de acesso sai pela mesma função de e-mail dos orçamentos (`orc-email`), com um texto próprio. Ele só vale depois que a função for publicada de novo:

- No painel, abra a função **orc-email**, cole o `index.ts` novo, que fica na pasta `nuvem/edge-functions/orc-email` do SistemaCMH, e clique em **Deploy**.
- Até essa publicação, o e-mail sai com o texto genérico de contrato, e o programa avisa isso.

## 4. Quem faz o quê, no SistemaCMH

- **Dr. Everaldo:** em **Usuários**, o cadastro dele precisa ter a categoria **Diretor médico**. É ela que dá o acesso de médico no site.
  - Ele entra no site com o **mesmo usuário e senha do SistemaCMH**.
  - Se a categoria sair ou o usuário for desativado, o acesso dele é cortado na hora.
- **Equipe que gera o login do RH:** marque o módulo **Homologação** em Usuários. Administrador já tem acesso.

## 5. O dia a dia

1. O contrato é assinado pelo cliente e pela clínica.
2. No SistemaCMH, abra **Homologação** e depois **Contratos assinados**. Escolha a empresa e clique em **Gerar login**. Confira o nome e o e-mail de quem vai usar.
3. Na janela de entrega você pode **ver, baixar ou enviar por e-mail** a carta em PDF, com o login e a senha.
4. O RH entra no site e lança o atestado com o arquivo. Ele preenche tipo, entidade e CID. O médico e o responsável pelo abono já vêm como Dr. Everaldo.
5. O Dr. Everaldo vê o atestado em **Para aprovar** e decide: **Aprovar**, **Pendente** ou **Reprovar**, com os motivos da lista. A empresa vê o resultado na hora.

## Regras que o banco garante

- O RH só vê os processos do CNPJ dele. Outra empresa nunca aparece para ele, nem se alguém mexer na tela.
- Só o Diretor médico dá parecer. O parecer decide o processo sozinho:
  - **Aprovado:** vira "Homologado".
  - **Reprovado:** vira "Não homologado".
  - **Pendente:** volta à empresa como "Aguardando documento".
- Processo não se apaga, e o histórico é escrito pelo banco.
- Os arquivos dos atestados ficam num balde **privado**. Cada abertura gera um link que vale 5 minutos, e só para quem pode ver o processo.

## Prévia no computador

Com o servidor local ligado, o endereço `http://127.0.0.1:8765/homologacao/index.html` abre a homologação com **dados de exemplo**, que vêm do `dados-demo.js`, sem tocar no banco:

- `?previa=empresa` entra como RH.
- `?previa=everaldo` entra como médico.
- `?real=1` usa o Supabase de verdade.

No site publicado a prévia nunca entra.
