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
| `MAIL_TO` | quem recebe — hoje `almir2015.666@gmail.com`, depois o da clínica |
| `SITE_ORIGIN` | `https://clinicamedicinahumana.com.br` |

**Trocar o destinatário depois = mudar só o `MAIL_TO`.** Nada no site muda,
nenhuma ativação, nada quebra.

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
