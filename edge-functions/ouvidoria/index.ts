// =====================================================================
//  Edge Function: ouvidoria  (slug do deploy: "rapid-function")
//  Recebe os formulários do site e envia por SMTP (Gmail da clínica).
//  A senha do e-mail vive como SECRET aqui no servidor — nunca no site.
//  Deploy: Supabase > Edge Functions > Deploy new function (cole este código).
//
//  Atende DOIS formulários, cada um com seu destinatário:
//    ouvidoria.html -> form: "ouvidoria" -> secret MAIL_TO_OUVIDORIA
//    contatos.html  -> form: "contatos"  -> secret MAIL_TO_CONTATOS
//
//  Secrets (Supabase > Edge Functions > Secrets):
//    SMTP_USER          -> conta Gmail que ENVIA
//    SMTP_PASS          -> senha de app de 16 dígitos (NÃO é a senha da conta)
//    MAIL_TO            -> destino padrão, usado quando os de baixo faltam
//    MAIL_TO_OUVIDORIA  -> (opcional) destino da Ouvidoria
//    MAIL_TO_CONTATOS   -> (opcional) destino do comercial
//    SITE_ORIGIN        -> ex.: https://clinicamedicinahumana.com.br
// =====================================================================
import { SMTPClient } from "https://deno.land/x/denomailer@1.6.0/mod.ts";

const SITE_ORIGIN = Deno.env.get("SITE_ORIGIN") ?? "*";

const cors = {
  "Access-Control-Allow-Origin": SITE_ORIGIN,
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

// Cada formulário declara seu título, o secret do destino e quais campos
// entram no e-mail (chave -> rótulo, obrigatório?). O visitante escolhe o
// FORMULÁRIO, nunca o endereço de destino — senão isso viraria um relay
// aberto para spam sair em nome da clínica.
const FORMULARIOS: Record<string, {
  titulo: string;
  secretDestino: string;
  campos: Array<[chave: string, rotulo: string, obrigatorio: boolean]>;
}> = {
  ouvidoria: {
    titulo: "Ouvidoria",
    secretDestino: "MAIL_TO_OUVIDORIA",
    campos: [
      ["assunto", "Assunto", true],
      ["nome", "Nome completo", true],
      ["cpf", "CPF", false],
      ["email", "E-mail", true],
      ["telefone", "Telefone", true],
      ["paciente", "Nome do paciente", false],
    ],
  },
  contatos: {
    titulo: "Contato comercial",
    secretDestino: "MAIL_TO_CONTATOS",
    campos: [
      ["assunto", "Assunto", true],
      ["nome", "Nome", true],
      ["cnpj", "CNPJ", true],
      ["email", "E-mail", true],
      ["telefone", "Telefone", true],
    ],
  },
};

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...cors, "Content-Type": "application/json" },
  });
}

// Escapa HTML para que o conteúdo digitado não injete marcação no e-mail.
function esc(s: string): string {
  return s.replace(/[&<>"']/g, (c) =>
    ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]!)
  );
}

// Corta campos absurdamente longos (defesa simples contra abuso).
function limpa(v: unknown, max = 400): string {
  return String(v ?? "").trim().slice(0, max);
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  if (req.method !== "POST") return json({ error: "Método não permitido" }, 405);

  const SMTP_USER = Deno.env.get("SMTP_USER");
  const SMTP_PASS = Deno.env.get("SMTP_PASS");
  if (!SMTP_USER || !SMTP_PASS) {
    return json({ error: "Envio de e-mail não configurado no servidor." }, 500);
  }

  let body: any;
  try { body = await req.json(); } catch { return json({ error: "JSON inválido" }, 400); }

  // Campo-armadilha: se veio preenchido, é robô. Responde ok e descarta.
  if (limpa(body?.hp)) return json({ ok: true });

  const cfg = FORMULARIOS[limpa(body?.form, 20) || "ouvidoria"];
  if (!cfg) return json({ error: "Formulário desconhecido." }, 400);

  // Destino específico do formulário; cai no padrão se ainda não foi separado.
  const destino = Deno.env.get(cfg.secretDestino) ?? Deno.env.get("MAIL_TO") ?? SMTP_USER;

  const linhas: Array<[string, string]> = [];
  for (const [chave, rotulo, obrigatorio] of cfg.campos) {
    const valor = limpa(body?.[chave], chave === "email" ? 160 : 120);
    if (obrigatorio && !valor) {
      return json({ error: "Preencha todos os campos obrigatórios." }, 400);
    }
    linhas.push([rotulo, valor || "-"]);
  }

  const nome = limpa(body?.nome, 120);
  const email = limpa(body?.email, 160);
  const assunto = limpa(body?.assunto, 60);
  const mensagem = limpa(body?.mensagem, 5000);

  if (!mensagem) return json({ error: "Preencha todos os campos obrigatórios." }, 400);
  if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) {
    return json({ error: "E-mail inválido." }, 400);
  }

  // ATENÇÃO: montado SEM quebras de linha e SEM indentação de propósito.
  // O SMTP codifica o corpo em quoted-printable; espaço antes de quebra de
  // linha vira um "=20" literal e aparece como lixo no e-mail.
  const fonte = "font-family:'Segoe UI',Arial,Helvetica,sans-serif";
  const celula = "padding:11px 16px;border-bottom:1px solid #e6eef7;font-size:14px";

  const html = [
    `<div style="${fonte};background:#eef4fa;padding:28px 12px">`,
    `<table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%" style="max-width:620px;margin:0 auto;background:#ffffff;border-radius:14px;overflow:hidden;box-shadow:0 2px 10px rgba(10,46,92,.10)">`,
    // Faixa de topo
    `<tr><td style="background:linear-gradient(120deg,#0a2e5c,#1d5fa8);padding:22px 26px">`,
    `<div style="color:#ffffff;font-size:19px;font-weight:700;letter-spacing:.2px">${esc(cfg.titulo)}</div>`,
    `<div style="color:#bcd8f2;font-size:13px;margin-top:3px">Nova mensagem pelo formulário do site</div>`,
    `</td></tr>`,
    // Dados
    `<tr><td style="padding:8px 26px 0">`,
    `<table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%">`,
    linhas.map(([k, v]) =>
      `<tr><td style="${celula};color:#6b829b;width:150px;vertical-align:top">${esc(k)}</td>` +
      `<td style="${celula};color:#12263a;font-weight:600">${esc(v)}</td></tr>`
    ).join(""),
    `</table></td></tr>`,
    // Mensagem
    `<tr><td style="padding:22px 26px 4px">`,
    `<div style="color:#0a2e5c;font-size:13px;font-weight:700;text-transform:uppercase;letter-spacing:.06em;margin-bottom:9px">Mensagem</div>`,
    `<div style="background:#f6fafd;border:1px solid #e0ebf6;border-left:4px solid #3bb3ef;border-radius:8px;padding:15px 17px;color:#12263a;font-size:14px;line-height:1.65;white-space:pre-wrap">${esc(mensagem)}</div>`,
    `</td></tr>`,
    // Rodapé
    `<tr><td style="padding:20px 26px 24px">`,
    `<a href="mailto:${esc(email)}" style="display:inline-block;background:#0a2e5c;color:#ffffff;text-decoration:none;font-size:14px;font-weight:600;padding:11px 22px;border-radius:8px">Responder para ${esc(nome)}</a>`,
    `<div style="color:#8fa4b8;font-size:12px;margin-top:14px;line-height:1.6">Basta responder este e-mail — a resposta vai direto para ${esc(email)}.</div>`,
    `</td></tr>`,
    `</table></div>`,
  ].join("");

  const client = new SMTPClient({
    connection: {
      hostname: "smtp.gmail.com",
      port: 465,
      tls: true,
      auth: { username: SMTP_USER, password: SMTP_PASS },
    },
  });

  try {
    await client.send({
      // O remetente é SEMPRE a conta da clínica. Usar o e-mail do visitante aqui
      // quebraria SPF/DKIM do Google e jogaria a mensagem direto no spam.
      from: `${cfg.titulo} — Clínica Medicina Humana <${SMTP_USER}>`,
      to: destino,
      // Assim o "Responder" da caixa vai direto para quem escreveu.
      replyTo: `${nome} <${email}>`,
      subject: `[${cfg.titulo}] ${assunto} — ${nome}`,
      html,
    });
    await client.close();
  } catch (e) {
    console.error("Falha SMTP:", e);
    try { await client.close(); } catch { /* já fechado */ }
    return json({ error: "Não foi possível enviar a mensagem." }, 502);
  }

  return json({ ok: true });
});
