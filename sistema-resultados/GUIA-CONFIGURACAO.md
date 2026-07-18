# Sistema de Resultados de Exames — Guia de Configuração

Segurança em camadas para **dado sensível de saúde (LGPD)**. O site institucional
continua no GitHub Pages; **só a parte de resultados** conversa com o Supabase.

## Arquitetura (resumo)

```
Paciente  →  resultados.html  →  Supabase (Auth + Banco + Storage)
                                   ▲  RLS: cada paciente só vê o próprio
Clínica   →  admin.html  →  Edge Function (chave secreta)  →  cria paciente / sobe PDF
```

- **Login do paciente:** CPF + senha (Supabase Auth).
- **PDFs:** bucket **privado**; download por **URL assinada que expira** em minutos.
- **RLS (Row Level Security):** o banco recusa qualquer acesso a dados de outro paciente,
  mesmo que alguém burle o front-end.
- **A chave `service_role` NUNCA vai pro navegador** — fica só como *secret* na Edge Function.

## Passo a passo (o que VOCÊ faz uma vez)

1. Crie conta em **https://supabase.com** (gratuito) e um **New Project**.
   - Região: **South America (São Paulo)**.
   - Guarde a **Database password**.
2. No projeto, vá em **SQL Editor → New query**, cole o conteúdo de
   `sql/01-esquema.sql` e clique em **Run**.
3. Vá em **Storage → New bucket** → nome **`resultados`** → marque **Private** → Create.
   (Depois rode de novo a seção "Storage" do SQL, se pedir.)
4. Em **Project Settings → API**, copie e me envie:
   - **Project URL** (ex.: `https://xxxx.supabase.co`)
   - **anon public key** (pode ser pública — protegida pela RLS)
   > A **service_role key** NÃO me mande em texto aberto aqui; ela vai como *secret*
   > no passo da Edge Function, direto no painel do Supabase.
5. Em **Authentication → Providers → Email**: deixe **Email** ativo e
   **Confirm email = OFF** (o acesso é entregue pela clínica, não por e-mail).

## O que EU construo depois disso

- `resultados.html` — tela de login do paciente (CPF + senha) e lista/downloads.
- `admin.html` — painel da clínica: cadastrar paciente, gerar senha, subir PDF e
  gerar a mensagem de WhatsApp pronta.
- **Edge Function** `criar-paciente` — cria o login do paciente com segurança.
- `js/resultados.js` — integração com o Supabase.

## Observações de conformidade (LGPD)

- Atualizar a **Política de Privacidade** citando a finalidade (disponibilizar resultados).
- Coletar **consentimento** do paciente.
- Definir **retenção** (por quanto tempo o resultado fica disponível) e permitir exclusão.
- Recomenda-se designar um **Encarregado (DPO)**.
- Este sistema aplica boas práticas técnicas, mas segurança é contínua: senhas fortes,
  acesso restrito ao painel e revisão periódica.

---

## Ativação final (fluxo 100% automático)

### 1. Deploy da Edge Function `criar-paciente`
- Supabase → **Edge Functions** → **Deploy a new function** (ou "Create function").
- Nome: **`criar-paciente`**.
- Cole o código de `edge-functions/criar-paciente/index.ts` → **Deploy**.
- Não precisa configurar segredos: a função já recebe `SUPABASE_URL`,
  `SUPABASE_ANON_KEY` e `SUPABASE_SERVICE_ROLE_KEY` automaticamente.

### 2. Criar o primeiro administrador (a equipe da clínica)
- **Authentication → Add user**: e-mail + senha da clínica → marque **Auto Confirm** → Create.
- Copie o **UID** desse usuário e rode no SQL Editor:
```sql
insert into public.admins (user_id) values ('UID_DO_ADMIN');
```

### 3. Usar
- Abra **`admin.html`**, entre com o login de admin.
- **Cadastrar paciente** → o sistema gera a senha e o botão de WhatsApp.
- **Enviar resultado** → sobe o PDF e gera o aviso de WhatsApp.
- O paciente acessa em **`resultados.html`** com CPF + senha.

### Segurança
- Rotacione a **secret key** que foi exposta (Project Settings → API Keys → roll).
- Compartilhe a URL do `admin.html` só com a equipe (a página tem `noindex`).
- A senha do paciente vai pelo WhatsApp; oriente a troca no 1º acesso (fluxo de
  troca de senha pode ser adicionado depois).
