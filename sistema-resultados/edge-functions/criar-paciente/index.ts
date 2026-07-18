// =====================================================================
//  Edge Function: criar-paciente
//  Cria o login do paciente (CPF -> e-mail interno) com senha gerada,
//  usando a chave de SERVIÇO (que só existe aqui no servidor).
//  Verifica que quem chamou é um ADMIN cadastrado.
//  Deploy: Supabase > Edge Functions > Deploy new function (cole este código).
// =====================================================================
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const EMAIL_DOMAIN = "paciente.clinicamedicinahumana.com.br";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...cors, "Content-Type": "application/json" },
  });
}

// senha forte, sem caracteres ambíguos (0/O, 1/l)
function gerarSenha(n = 10): string {
  const chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789";
  const bytes = new Uint8Array(n);
  crypto.getRandomValues(bytes);
  let s = "";
  for (let i = 0; i < n; i++) s += chars[bytes[i] % chars.length];
  return s;
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  if (req.method !== "POST") return json({ error: "Método não permitido" }, 405);

  const URL = Deno.env.get("SUPABASE_URL")!;
  const SERVICE = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
  const ANON = Deno.env.get("SUPABASE_ANON_KEY")!;

  // 1) Confere quem está chamando (precisa estar logado)
  const authHeader = req.headers.get("Authorization") ?? "";
  const asCaller = createClient(URL, ANON, {
    global: { headers: { Authorization: authHeader } },
  });
  const { data: userData, error: userErr } = await asCaller.auth.getUser();
  if (userErr || !userData.user) return json({ error: "Não autenticado" }, 401);

  // 2) Cliente com poderes de admin (chave de serviço)
  const admin = createClient(URL, SERVICE);

  // 3) Só ADMIN cadastrado pode criar paciente
  const { data: adm } = await admin
    .from("admins").select("user_id").eq("user_id", userData.user.id).maybeSingle();
  if (!adm) return json({ error: "Sem permissão (não é administrador)" }, 403);

  // 4) Valida entrada
  let body: any;
  try { body = await req.json(); } catch { return json({ error: "JSON inválido" }, 400); }
  const nome = (body?.nome ?? "").trim();
  const telefone = (body?.telefone ?? "").replace(/\D/g, "");
  const cpf = (body?.cpf ?? "").replace(/\D/g, "");
  if (!nome || cpf.length !== 11) return json({ error: "Nome e CPF (11 dígitos) são obrigatórios" }, 400);

  // 5) Já existe?
  const { data: existe } = await admin.from("pacientes").select("id").eq("cpf", cpf).maybeSingle();
  if (existe) return json({ error: "Já existe um paciente com esse CPF" }, 409);

  // 6) Cria o usuário de login (e-mail interno derivado do CPF)
  const email = `${cpf}@${EMAIL_DOMAIN}`;
  const senha = gerarSenha();
  const { data: created, error: cErr } = await admin.auth.admin.createUser({
    email, password: senha, email_confirm: true, user_metadata: { nome },
  });
  if (cErr || !created.user) return json({ error: "Falha ao criar acesso: " + (cErr?.message ?? "") }, 400);

  // 7) Cria o perfil do paciente (rollback se falhar)
  const { error: pErr } = await admin.from("pacientes")
    .insert({ id: created.user.id, cpf, nome, telefone });
  if (pErr) {
    await admin.auth.admin.deleteUser(created.user.id);
    return json({ error: "Falha ao salvar paciente: " + pErr.message }, 400);
  }

  return json({ id: created.user.id, cpf, nome, senha });
});
