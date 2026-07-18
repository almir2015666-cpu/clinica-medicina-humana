// =====================================================================
//  Edge Function: criar-acesso
//  Cria login de PACIENTE (CPF), MÉDICO (CRM) ou FUNCIONÁRIO (login).
//  - Paciente/Médico: qualquer funcionário ativo pode criar.
//  - Funcionário: só GESTOR pode criar.
//  Deploy: Supabase > Edge Functions > nome: criar-acesso
// =====================================================================
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const DOM_PACIENTE = "paciente.clinicamedicinahumana.com.br";
const DOM_MEDICO = "medico.clinicamedicinahumana.com.br";
const DOM_FUNC = "admin.clinicamedicinahumana.com.br";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};
const json = (b: unknown, s = 200) =>
  new Response(JSON.stringify(b), { status: s, headers: { ...cors, "Content-Type": "application/json" } });

function gerarSenha(n = 10): string {
  const chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789";
  const b = new Uint8Array(n); crypto.getRandomValues(b);
  let s = ""; for (let i = 0; i < n; i++) s += chars[b[i] % chars.length]; return s;
}
const norm = (s: string) => (s || "").toLowerCase().replace(/[^a-z0-9]/g, "");

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  if (req.method !== "POST") return json({ error: "Método não permitido" }, 405);

  const URL = Deno.env.get("SUPABASE_URL")!;
  const SERVICE = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
  const ANON = Deno.env.get("SUPABASE_ANON_KEY")!;

  const caller = createClient(URL, ANON, { global: { headers: { Authorization: req.headers.get("Authorization") ?? "" } } });
  const { data: ud } = await caller.auth.getUser();
  if (!ud?.user) return json({ error: "Não autenticado" }, 401);

  const admin = createClient(URL, SERVICE);
  const { data: me } = await admin.from("funcionarios").select("papel,ativo").eq("id", ud.user.id).maybeSingle();
  if (!me || !me.ativo) return json({ error: "Sem permissão (funcionário inativo ou inexistente)" }, 403);

  let body: any; try { body = await req.json(); } catch { return json({ error: "JSON inválido" }, 400); }
  const tipo = ["paciente", "medico", "funcionario"].includes(body?.tipo) ? body.tipo : "paciente";
  const nome = (body?.nome ?? "").trim();
  const telefone = (body?.telefone ?? "").replace(/\D/g, "");
  if (!nome) return json({ error: "Nome é obrigatório" }, 400);

  let email = "", tabela = "", registro: Record<string, unknown> = {};

  if (tipo === "paciente") {
    const cpf = (body?.cpf ?? "").replace(/\D/g, "");
    if (cpf.length !== 11) return json({ error: "CPF deve ter 11 dígitos" }, 400);
    if ((await admin.from("pacientes").select("id").eq("cpf", cpf).maybeSingle()).data)
      return json({ error: "Já existe um paciente com esse CPF" }, 409);
    email = `${cpf}@${DOM_PACIENTE}`; tabela = "pacientes"; registro = { cpf, nome, telefone };

  } else if (tipo === "medico") {
    const crmRaw = (body?.crm ?? "").trim(); const crm = norm(crmRaw);
    if (!crm) return json({ error: "CRM é obrigatório" }, 400);
    if ((await admin.from("medicos").select("id").eq("crm", crmRaw).maybeSingle()).data)
      return json({ error: "Já existe um médico com esse CRM" }, 409);
    email = `${crm}@${DOM_MEDICO}`; tabela = "medicos";
    registro = { crm: crmRaw, nome, especialidade: (body?.especialidade ?? "").trim() || null, telefone };

  } else { // funcionario — só gestor cria
    if (me.papel !== "gestor") return json({ error: "Apenas o gestor pode cadastrar funcionários" }, 403);
    const login = norm(body?.login ?? "");
    const papel = ["gestor", "recepcao", "tecnico"].includes(body?.papel) ? body.papel : "recepcao";
    if (!login) return json({ error: "Login é obrigatório" }, 400);
    email = `${login}@${DOM_FUNC}`; tabela = "funcionarios"; registro = { nome, papel };
  }

  const senha = gerarSenha();
  const { data: created, error: cErr } = await admin.auth.admin.createUser({
    email, password: senha, email_confirm: true, user_metadata: { nome, tipo },
  });
  if (cErr || !created.user) return json({ error: "Falha ao criar acesso: " + (cErr?.message ?? "") }, 400);

  const { error: iErr } = await admin.from(tabela).insert({ id: created.user.id, ...registro });
  if (iErr) { await admin.auth.admin.deleteUser(created.user.id); return json({ error: "Falha ao salvar: " + iErr.message }, 400); }

  return json({ id: created.user.id, tipo, nome, senha, email });
});
