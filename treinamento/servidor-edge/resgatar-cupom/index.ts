// =====================================================================
//  Edge Function: resgatar-cupom
//
//  É o que acontece quando o trabalhador digita o código no site. Cria a
//  conta INDIVIDUAL dele e libera os cursos daquele cupom.
//
//  Não pede login: quem chega aqui ainda não tem conta — é justamente
//  isso que ele está criando. O que autoriza é o cupom.
//
//  POR QUE A CONTA DA VAGA NÃO ESTÁ AQUI
//  -------------------------------------
//  Quem confere e consome a vaga é a função trein_resgatar, no banco, com
//  a linha do cupom travada. Se a conta fosse feita aqui, dois
//  trabalhadores clicando no mesmo segundo leriam "resta 1" os dois e
//  entrariam os dois. Aqui só criamos o usuário no Auth (que só a service
//  role pode) e desfazemos se o banco recusar.
//
//  Deploy: Supabase > Edge Functions > nome: resgatar-cupom
// =====================================================================
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const DOM_ALUNO = "aluno.clinicamedicinahumana.com.br";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};
const json = (b: unknown, s = 200) =>
  new Response(JSON.stringify(b), { status: s, headers: { ...cors, "Content-Type": "application/json" } });

// Os recados que o site mostra. A função do banco levanta um código seco;
// a frase que o trabalhador lê fica aqui, num lugar só.
const RECADOS: Record<string, string> = {
  CUPOM_INVALIDO:  "Não encontrei esse código. Confira as letras com o RH da sua empresa.",
  CUPOM_CANCELADO: "Esse código foi cancelado. Procure o RH da sua empresa.",
  CUPOM_VENCIDO:   "O prazo para usar esse código já passou. Procure o RH da sua empresa.",
  CUPOM_ESGOTADO:  "As vagas desse código acabaram. Procure o RH da sua empresa.",
};

function digitos(s: unknown) { return String(s ?? "").replace(/\D/g, ""); }

// Confere o CPF de verdade, e não só o tamanho: um dígito trocado vira
// certificado no nome errado, e ninguém percebe até a fiscalização.
function cpfValido(cpf: string): boolean {
  if (cpf.length !== 11 || /^(\d)\1{10}$/.test(cpf)) return false;
  for (const [ate, pos] of [[9, 10], [10, 11]] as const) {
    let soma = 0;
    for (let i = 0; i < ate; i++) soma += Number(cpf[i]) * (pos - i);
    let d = (soma * 10) % 11;
    if (d === 10) d = 0;
    if (d !== Number(cpf[ate])) return false;
  }
  return true;
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  if (req.method !== "POST") return json({ error: "Método não permitido" }, 405);

  const URL = Deno.env.get("SUPABASE_URL")!;
  const SERVICE = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
  const admin = createClient(URL, SERVICE);

  let body: any;
  try { body = await req.json(); } catch { return json({ error: "JSON inválido" }, 400); }

  const codigo = String(body?.codigo ?? "").trim().toUpperCase();
  const cpf = digitos(body?.cpf);
  const nome = String(body?.nome ?? "").trim();
  const senha = String(body?.senha ?? "");
  const email = String(body?.email ?? "").trim() || null;
  const telefone = digitos(body?.telefone) || null;

  if (!codigo) return json({ error: "Digite o código do cupom." }, 400);
  if (!cpfValido(cpf)) return json({ error: "CPF inválido. Confira os números." }, 400);
  if (nome.split(/\s+/).length < 2)
    return json({ error: "Escreva o nome completo — ele sai no certificado." }, 400);
  if (senha.length < 6)
    return json({ error: "A senha precisa de pelo menos 6 caracteres." }, 400);

  const login = `${cpf}@${DOM_ALUNO}`;

  // Quem já tem conta não cria outra: pode ser a segunda empresa dele, ou
  // um cupom novo de outro curso. Reaproveita o usuário e só resgata.
  const { data: ja } = await admin.from("trein_aluno").select("id").eq("cpf", cpf).maybeSingle();

  let alunoId = ja?.id ?? null;
  let contaNova = false;

  if (!alunoId) {
    const { data: criado, error: cErr } = await admin.auth.admin.createUser({
      email: login, password: senha, email_confirm: true,
      user_metadata: { nome, cpf, tipo: "aluno_treinamento" },
    });
    if (cErr || !criado.user) {
      return json({ error: "Não consegui criar o acesso: " + (cErr?.message ?? "") }, 400);
    }
    alunoId = criado.user.id;
    contaNova = true;
  }

  const { data: res, error: rErr } = await admin.rpc("trein_resgatar", {
    p_codigo: codigo, p_aluno_id: alunoId, p_cpf: cpf,
    p_nome: nome, p_email: email, p_telefone: telefone,
  });

  if (rErr) {
    // o banco recusou. Se a conta acabou de nascer só para este resgate,
    // ela não serve para nada — some com ela, senão o CPF fica preso a um
    // login que nunca abre nada e a pessoa não consegue tentar de novo.
    if (contaNova) await admin.auth.admin.deleteUser(alunoId);

    const seco = (rErr.message ?? "").match(/CUPOM_[A-Z]+/)?.[0] ?? "";
    if (seco === "CUPOM_INVALIDO" || !seco) {
      // resgatar duas vezes o mesmo cupom cai na chave primária do resgate
      if ((rErr.message ?? "").includes("trein_resgate_pkey")) {
        return json({ error: "Você já usou esse código. Entre com o seu CPF e senha." }, 409);
      }
    }
    return json({ error: RECADOS[seco] ?? "Não consegui resgatar o código." }, 400);
  }

  return json({
    ok: true,
    conta_nova: contaNova,
    login: cpf,                 // é o CPF que ele digita para entrar
    empresa: (res as any)?.empresa ?? null,
    expira_em: (res as any)?.expira_em ?? null,
    cursos: (res as any)?.cursos ?? 0,
  });
});
