// =====================================================================
//  Edge Function: ouvidoria
//  Recebe o formulário da Ouvidoria e envia por SMTP (Gmail da clínica).
//  A senha do e-mail vive como SECRET aqui no servidor — nunca no site.
//  Deploy: Supabase > Edge Functions > Deploy new function (cole este código).
//
//  Secrets necessários (Supabase > Edge Functions > Secrets):
//    SMTP_USER   -> conta Gmail que ENVIA   (ex.: clinica@gmail.com)
//    SMTP_PASS   -> senha de app de 16 dígitos (NÃO é a senha da conta)
//    MAIL_TO     -> quem RECEBE as mensagens (pode ser outro e-mail)
//    SITE_ORIGIN -> origem permitida (ex.: https://clinicamedicinahumana.com.br)
// =====================================================================
import { SMTPClient } from "https://deno.land/x/denomailer@1.6.0/mod.ts";

const SITE_ORIGIN = Deno.env.get("SITE_ORIGIN") ?? "*";

const cors = {
  "Access-Control-Allow-Origin": SITE_ORIGIN,
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
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
  const MAIL_TO = Deno.env.get("MAIL_TO") ?? SMTP_USER;
  if (!SMTP_USER || !SMTP_PASS) {
    return json({ error: "Envio de e-mail não configurado no servidor." }, 500);
  }

  let body: any;
  try { body = await req.json(); } catch { return json({ error: "JSON inválido" }, 400); }

  // Campo-armadilha: se veio preenchido, é robô. Responde ok e descarta.
  if (limpa(body?.hp)) return json({ ok: true });

  const dados = {
    assunto: limpa(body?.assunto, 60),
    nome: limpa(body?.nome, 120),
    cpf: limpa(body?.cpf, 20),
    email: limpa(body?.email, 160),
    telefone: limpa(body?.telefone, 40),
    paciente: limpa(body?.paciente, 120),
    mensagem: limpa(body?.mensagem, 5000),
  };

  if (!dados.assunto || !dados.nome || !dados.email || !dados.telefone || !dados.mensagem) {
    return json({ error: "Preencha todos os campos obrigatórios." }, 400);
  }
  if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(dados.email)) {
    return json({ error: "E-mail inválido." }, 400);
  }

  const linhas = [
    ["Assunto", dados.assunto],
    ["Nome completo", dados.nome],
    ["CPF", dados.cpf || "-"],
    ["E-mail", dados.email],
    ["Telefone", dados.telefone],
    ["Nome do paciente", dados.paciente || "-"],
  ];

  const html = `
    <div style="font-family:Arial,Helvetica,sans-serif;color:#1b2b3a;max-width:640px">
      <h2 style="color:#0a2e5c;margin:0 0 4px">Ouvidoria — nova mensagem</h2>
      <p style="color:#56718b;margin:0 0 18px;font-size:13px">Enviada pelo formulário do site</p>
      <table cellpadding="8" cellspacing="0" style="border-collapse:collapse;width:100%;font-size:14px">
        ${linhas.map(([k, v]) => `
          <tr>
            <td style="border:1px solid #dbe6f0;background:#f4f9fd;font-weight:bold;width:180px">${esc(k)}</td>
            <td style="border:1px solid #dbe6f0">${esc(v)}</td>
          </tr>`).join("")}
      </table>
      <h3 style="color:#0a2e5c;margin:22px 0 6px;font-size:15px">Mensagem</h3>
      <div style="border:1px solid #dbe6f0;border-radius:8px;padding:14px;white-space:pre-wrap;font-size:14px">${esc(dados.mensagem)}</div>
    </div>`;

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
      from: `Ouvidoria — Clínica Medicina Humana <${SMTP_USER}>`,
      to: MAIL_TO,
      // Assim o "Responder" da caixa vai direto para quem escreveu.
      replyTo: `${dados.nome} <${dados.email}>`,
      subject: `[Ouvidoria] ${dados.assunto} — ${dados.nome}`,
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
