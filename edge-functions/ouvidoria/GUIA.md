# Ouvidoria por e-mail — guia de configuração

Envia o formulário da Ouvidoria por SMTP do Gmail, sem serviço terceiro,
sem etapa de "ativação" e sem cair no spam.

```
ouvidoria.html  →  Edge Function (guarda a senha)  →  Gmail  →  caixa de destino
```

## 1. Gerar a senha de app no Gmail

Na conta Gmail que vai **enviar** (pode ser a mesma que recebe):

1. Ative a **verificação em duas etapas**: https://myaccount.google.com/security
   (sem isso o Google não libera senha de app)
2. Vá em https://myaccount.google.com/apppasswords
3. Nome: `Site Ouvidoria` → **Criar**
4. Copie os **16 caracteres**. Guarde — o Google não mostra de novo.

> Essa senha só serve para enviar e-mail e pode ser revogada a qualquer momento
> sem trocar a senha real da conta.

## 2. Publicar a função no Supabase

1. Painel do Supabase → **Edge Functions** → **Deploy new function**
2. Nome: **`ouvidoria`**
3. Cole o conteúdo de `index.ts` → **Deploy**
4. Em **Settings** da função, desmarque **Verify JWT**
   (o formulário é público, o visitante não faz login)

## 3. Cadastrar os secrets

Edge Functions → **Secrets** → adicione:

| Nome | Valor |
|---|---|
| `SMTP_USER` | o Gmail que envia — ex.: `clinicamedicinahumana2@gmail.com` |
| `SMTP_PASS` | os 16 caracteres do passo 1 (sem espaços) |
| `MAIL_TO` | destino padrão — hoje `almir2015.666@gmail.com` |
| `SITE_ORIGIN` | `https://clinicamedicinahumana.com.br` |

### Destinos separados por formulário

A função atende três formulários. Enquanto existir só o `MAIL_TO`, todos
caem na mesma caixa. Para separar, crie:

| Nome | Quem recebe |
|---|---|
| `MAIL_TO_OUVIDORIA` | mensagens de `ouvidoria.html` |
| `MAIL_TO_CONTATOS` | mensagens de `contatos.html` (comercial) |
| `MAIL_TO_AGENDAMENTO` | pedidos de `agende-exame.html` |

Cada um sobrepõe o `MAIL_TO` no seu formulário. **Trocar destinatário =
mudar o secret.** Nada no site muda, nenhuma ativação, nada quebra.

O agendamento tem uma escada a mais: sem `MAIL_TO_AGENDAMENTO` ele usa o
`MAIL_TO_CONTATOS`. Ou seja, os pedidos de exame já nascem chegando na caixa
do comercial — só crie o secret próprio no dia em que quiser separar.

### Quem recebe em cópia (Cc)

| Nome | Quem recebe em cópia |
|---|---|
| `MAIL_CC` | **todos** os formulários |
| `MAIL_CC_OUVIDORIA` | só a Ouvidoria |
| `MAIL_CC_CONTATOS` | só os Contatos (e o agendamento, se não tiver o de baixo) |
| `MAIL_CC_AGENDAMENTO` | só os agendamentos de exame |

Vários endereços no mesmo secret, separados por vírgula:

```
atendimentocmh@medicinahumana.com.br, recepcao@medicinahumana.com.br
```

Vale o primeiro secret preenchido da escada (do mais específico para o
`MAIL_CC`) — não é soma. Endereços malformados são descartados em silêncio,
e o destinatário principal nunca entra na cópia duas vezes.

**Como está hoje:** só existe o `MAIL_CC_AGENDAMENTO`, com o atendimento e a
recepção. Ouvidoria e Contatos não têm cópia — vão só para o destinatário
principal. Para dar cópia a eles depois, crie o secret do formulário
correspondente (ou o `MAIL_CC`, que pega os três de uma vez).

> Quem está em Cc **enxerga os outros endereços da cópia**. Como aqui são todos
> e-mails da própria clínica, isso não é problema — mas se um dia precisar de
> cópia oculta, é uma linha de código.

> O site manda só o **nome do formulário** (`ouvidoria` / `contatos` /
> `agendamento`), nunca o endereço de destino. Se o endereço viesse do
> navegador, qualquer um poderia mandar spam em nome da clínica para quem
> quisesse.

### Quando mexer no `index.ts` (importante)

Editar o arquivo aqui no repositório **não muda nada sozinho** — o que roda é
a cópia que está publicada no Supabase. Depois de qualquer alteração:

1. Painel do Supabase → **Edge Functions** → abra a função (slug `rapid-function`)
2. Cole o conteúdo novo de `index.ts` por cima → **Deploy**

Enquanto o deploy não for feito, o formulário novo responde
*"Formulário desconhecido"* — a versão antiga da função não conhece o
`agendamento`.

## 4. Apontar o site para a função

> **Cuidado com o slug.** O painel deixa você dar o nome `ouvidoria`, mas o
> deploy pelo editor gera um slug aleatório — no nosso caso `rapid-function`.
> O que vale na URL é o **slug**, que aparece no breadcrumb e na URL mostrada
> no topo da função. (A `swift-api` do sistema de resultados é o mesmo caso.)

O slug fica em `js/supabase-config.js`, na chave `ouvidoriaFunction`.
Se um dia refizer o deploy e o slug mudar, é só atualizar lá.

Endpoint atual:

```
https://ojhulerxocgaxbiutrnm.supabase.co/functions/v1/rapid-function
```

## Por que não vai para o spam

- O remetente é a própria conta Gmail, autenticada por SPF/DKIM do Google.
- O e-mail de quem escreveu vai no **Reply-To**, não no From — pôr o endereço
  do visitante como remetente é justamente o que faz a mensagem ser barrada.
- Responder na caixa responde direto para o visitante, como esperado.

## Limites

Gmail comum: ~500 envios/dia. Muito acima do volume de uma ouvidoria.
