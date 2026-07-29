// =====================================================================
//  Edge Function: ouvidoria  (slug do deploy: "rapid-function")
//  Recebe os formulários do site e envia por SMTP (Gmail da clínica).
//  A senha do e-mail vive como SECRET aqui no servidor — nunca no site.
//  Deploy: Supabase > Edge Functions > Deploy new function (cole este código).
//
//  Atende TRÊS formulários, cada um com seu destinatário:
//    ouvidoria.html    -> form: "ouvidoria"   -> secret MAIL_TO_OUVIDORIA
//    contatos.html     -> form: "contatos"    -> secret MAIL_TO_CONTATOS
//    agende-exame.html -> form: "agendamento" -> secret MAIL_TO_AGENDAMENTO
//                                                (cai em MAIL_TO_CONTATOS)
//
//  Secrets (Supabase > Edge Functions > Secrets):
//    SMTP_USER            -> conta Gmail que ENVIA
//    SMTP_PASS            -> senha de app de 16 dígitos (NÃO é a senha da conta)
//    MAIL_TO              -> destino padrão, usado quando os de baixo faltam
//    MAIL_TO_OUVIDORIA    -> (opcional) destino da Ouvidoria
//    MAIL_TO_CONTATOS     -> (opcional) destino do comercial
//    MAIL_TO_AGENDAMENTO  -> (opcional) destino dos agendamentos de exame;
//                            sem ele, os agendamentos vão para o comercial
//    MAIL_CC              -> (opcional) cópia em TODOS os formulários;
//                            vários e-mails separados por vírgula
//    MAIL_CC_OUVIDORIA / MAIL_CC_CONTATOS / MAIL_CC_AGENDAMENTO
//                         -> (opcional) cópia só naquele formulário
//    SITE_ORIGIN          -> ex.: https://clinicamedicinahumana.com.br
// =====================================================================
import { SMTPClient } from "https://deno.land/x/denomailer@1.6.0/mod.ts";

const SITE_ORIGIN = Deno.env.get("SITE_ORIGIN") ?? "*";

const cors = {
  "Access-Control-Allow-Origin": SITE_ORIGIN,
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

// Cada formulário declara seu título, para onde vai e quais campos entram no
// e-mail (chave -> rótulo, obrigatório?). O visitante escolhe o FORMULÁRIO,
// nunca o endereço de destino — senão isso viraria um relay aberto para spam
// sair em nome da clínica.
//
// secretsDestino é uma LISTA em ordem de preferência: vale o primeiro secret
// que estiver cadastrado. Assim o agendamento já nasce caindo na caixa do
// comercial, e no dia em que quiserem separar é só criar o secret próprio.
// secretsCopia funciona igual, para quem recebe em cópia (Cc). Vale o
// primeiro secret preenchido; MAIL_CC é o coringa que serve para todos.
const FORMULARIOS: Record<string, {
  titulo: string;
  secretsDestino: string[];
  secretsCopia: string[];
  campos: Array<[chave: string, rotulo: string, obrigatorio: boolean]>;
  // Alguns formulários são um pedido estruturado: o texto livre é opcional.
  exigeMensagem: boolean;
  rotuloMensagem: string;
}> = {
  ouvidoria: {
    titulo: "Ouvidoria",
    secretsDestino: ["MAIL_TO_OUVIDORIA"],
    secretsCopia: ["MAIL_CC_OUVIDORIA"],
    campos: [
      ["assunto", "Assunto", true],
      ["nome", "Nome completo", true],
      ["cpf", "CPF", false],
      ["email", "E-mail", true],
      ["telefone", "Telefone", true],
      ["paciente", "Nome do paciente", false],
    ],
    exigeMensagem: true,
    rotuloMensagem: "Mensagem",
  },
  contatos: {
    titulo: "Contato comercial",
    secretsDestino: ["MAIL_TO_CONTATOS"],
    secretsCopia: ["MAIL_CC_CONTATOS"],
    campos: [
      ["assunto", "Assunto", true],
      ["nome", "Nome", true],
      ["cnpj", "CNPJ", true],
      ["email", "E-mail", true],
      ["telefone", "Telefone", true],
    ],
    exigeMensagem: true,
    rotuloMensagem: "Mensagem",
  },
  agendamento: {
    titulo: "Agendamento de exame ocupacional",
    secretsDestino: ["MAIL_TO_AGENDAMENTO", "MAIL_TO_CONTATOS"],
    secretsCopia: ["MAIL_CC_AGENDAMENTO", "MAIL_CC_CONTATOS"],
    campos: [
      ["empresa", "Empresa", true],
      ["contrato", "Contrato", true],
      ["responsavel", "Responsável", false],
      ["email", "E-mail", true],
      ["telefone", "Telefone", false],
      ["regiao", "Região de atendimento", true],
      ["tipoExame", "Tipo de exame", true],
      ["data", "Data de comparecimento", true],
      ["quantidade", "Quantidade de pessoas", true],
    ],
    exigeMensagem: false,
    rotuloMensagem: "Observações",
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

const EMAIL_OK = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;

// Lê uma lista de e-mails de secrets (separados por vírgula, ponto e vírgula
// ou espaço) e devolve só os válidos. Vale o primeiro secret preenchido.
//
// A validação aqui não é frescura: o validateConfig do denomailer 1.6.0 tem um
// bug feio — ao achar um e-mail inválido no Cc ele faz `config.to = valCc.ok`,
// ou seja, SOBRESCREVE o destinatário principal com a lista de cópia. Um
// endereço com erro de digitação no secret faria o comercial parar de receber.
// Entregando só endereços válidos, esse trecho da biblioteca nunca roda.
function listaEmails(...nomesSecrets: string[]): string[] {
  for (const nome of nomesSecrets) {
    const bruto = Deno.env.get(nome);
    if (!bruto) continue;
    const emails = bruto
      .split(/[,;\s]+/)
      .map((e) => e.trim())
      .filter((e) => EMAIL_OK.test(e));
    if (emails.length > 0) return emails.slice(0, 20);
  }
  return [];
}

// ---------------------------------------------------------------------
//  Contorno para dois bugs do denomailer 1.6.0 (config/mail/encoding.ts).
//  Os dois fazem o e-mail chegar "cheio de letras e números soltos".
//
//  1. CORPO — quotedPrintableEncode() quebra a linha a cada 74 caracteres,
//     e nessa quebra ele pode comer os caracteres de uma sequência "=XX".
//     Como todo atributo HTML tem um "=" (e cada "=" vira "=3d"), o corpo é
//     o pior caso possível: quanto mais longo, mais chance de corromper.
//     Saída: mandar o corpo já em base64 pelo mimeContent — a biblioteca
//     escreve o conteúdo exatamente como recebeu, sem passar pelo encoder.
//
//  2. CABEÇALHOS — o mesmo encoder é usado no assunto, no nome do remetente
//     e no nome do Reply-To. Passando de 74 caracteres codificados, ele enfia
//     uma quebra de linha DENTRO do "=?utf-8?Q?...?=" e o cabeçalho vira lixo.
//     Saída: se não couber, tirar os acentos — em ASCII puro a biblioteca
//     devolve o texto intacto, sem codificar nada.
// ---------------------------------------------------------------------
const codificador = new TextEncoder();

// Corpo em base64, quebrado de 76 em 76 caracteres como o SMTP espera.
function base64Corpo(texto: string): string {
  const bytes = codificador.encode(texto);
  let bin = "";
  for (const b of bytes) bin += String.fromCharCode(b);
  return btoa(bin).replace(/.{1,76}/g, "$&\r\n").trimEnd();
}

// Quantos caracteres o texto ocuparia depois do quoted-printable deles.
function tamanhoQP(texto: string): number {
  let total = 0;
  for (const ch of texto) {
    const bytes = codificador.encode(ch);
    const code = bytes[0];
    const literal = bytes.length === 1 &&
      ((code >= 32 && code <= 126 && code !== 61) || code === 9);
    total += literal ? 1 : bytes.length * 3;
  }
  return total;
}

// Cabeçalho sem risco de ser partido no meio da codificação.
function cabecalhoSeguro(texto: string): string {
  if (tamanhoQP(texto) <= 74) return texto;
  return texto
    .normalize("NFD").replace(/[\u0300-\u036f]/g, "")
    .replace(/[^\x20-\x7E]/g, "-");
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

  // Primeiro secret cadastrado da lista do formulário; se nenhum existir,
  // cai no destino padrão.
  const destino = cfg.secretsDestino.map((s) => Deno.env.get(s)).find((v) => v) ??
    Deno.env.get("MAIL_TO") ?? SMTP_USER;

  // Quem recebe em cópia. MAIL_CC é o coringa que vale para todos os
  // formulários. Tira o destinatário principal da lista para ninguém receber
  // a mesma mensagem duas vezes.
  const copia = listaEmails(...cfg.secretsCopia, "MAIL_CC")
    .filter((e) => e.toLowerCase() !== destino.toLowerCase());

  const linhas: Array<[string, string]> = [];
  for (const [chave, rotulo, obrigatorio] of cfg.campos) {
    const valor = limpa(body?.[chave], chave === "email" ? 160 : 120);
    if (obrigatorio && !valor) {
      return json({ error: "Preencha todos os campos obrigatórios." }, 400);
    }
    linhas.push([rotulo, valor || "-"]);
  }

  // Quem assina a mensagem: nos formulários de empresa não existe "nome",
  // então o responsável (ou a própria empresa) faz esse papel.
  const nome = limpa(body?.nome, 120) || limpa(body?.responsavel, 120) ||
    limpa(body?.empresa, 120);
  const email = limpa(body?.email, 160);
  const assunto = limpa(body?.assunto, 60) || limpa(body?.tipoExame, 60);
  const mensagem = limpa(body?.mensagem, 5000);

  if (cfg.exigeMensagem && !mensagem) {
    return json({ error: "Preencha todos os campos obrigatórios." }, 400);
  }
  if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) {
    return json({ error: "E-mail inválido." }, 400);
  }

  // Montado sem quebras de linha e sem indentação. Não é mais obrigatório
  // desde que o corpo passou a ir em base64, mas manter assim evita
  // surpresas se um dia alguém trocar a codificação de volta.
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
    // Mensagem — sai fora quando o formulário é só um pedido estruturado
    // e o visitante não escreveu nada.
    mensagem
      ? `<tr><td style="padding:22px 26px 4px">` +
        `<div style="color:#0a2e5c;font-size:13px;font-weight:700;text-transform:uppercase;letter-spacing:.06em;margin-bottom:9px">${esc(cfg.rotuloMensagem)}</div>` +
        `<div style="background:#f6fafd;border:1px solid #e0ebf6;border-left:4px solid #3bb3ef;border-radius:8px;padding:15px 17px;color:#12263a;font-size:14px;line-height:1.65;white-space:pre-wrap">${esc(mensagem)}</div>` +
        `</td></tr>`
      : `<tr><td style="padding:10px 26px 0"></td></tr>`,
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
      from: `${cabecalhoSeguro(`${cfg.titulo} — Clínica Medicina Humana`)} <${SMTP_USER}>`,
      to: destino,
      cc: copia,
      // Assim o "Responder" da caixa vai direto para quem escreveu.
      replyTo: `${cabecalhoSeguro(nome)} <${email}>`,
      subject: cabecalhoSeguro(
        assunto ? `[${cfg.titulo}] ${assunto} — ${nome}` : `[${cfg.titulo}] ${nome}`,
      ),
      // Corpo já codificado por nós — ver o bloco de contorno lá em cima.
      // Passar "html" aqui de volta reintroduz o bug do quoted-printable.
      mimeContent: [{
        mimeType: 'text/html; charset="utf-8"',
        content: base64Corpo(html),
        transferEncoding: "base64",
      }],
    });
    await client.close();
  } catch (e) {
    console.error("Falha SMTP:", e);
    try { await client.close(); } catch { /* já fechado */ }
    return json({ error: "Não foi possível enviar a mensagem." }, 502);
  }

  return json({ ok: true });
});
