// =====================================================================
//  Edge Function: recuperar-senha
//
//  O trabalhador esqueceu a senha. Ele digita o CPF, o código da empresa e
//  escolhe uma senha nova.
//
//  POR QUE NÃO É POR E-MAIL
//  ------------------------
//  O login do aluno é <cpf>@aluno.clinicamedicinahumana.com.br — um
//  endereço interno, que não recebe mensagem nenhuma. E o e-mail de
//  verdade é OPCIONAL no resgate, de propósito: boa parte de quem faz NR
//  não tem e-mail, e exigir um deixaria essa gente sem conta. Mandar link
//  por e-mail atenderia a minoria e travaria a maioria.
//
//  O QUE AUTORIZA A TROCA
//  ----------------------
//  O mesmo que autorizou a conta a existir: o código do cupom. A conferência
//  não é só "o código existe" — é "ESTE CPF resgatou ESTE código", que está
//  gravado na trein_resgate. Quem não resgatou não troca a senha de ninguém.
//
//  O LIMITE DISSO, dito com todas as letras: um colega da mesma empresa tem
//  o mesmo código. Se ele souber o CPF de outro, consegue trocar a senha
//  dele. Foi uma escolha consciente — a alternativa era deixar sem
//  recuperação quem não tem e-mail. Se um dia isso incomodar, o caminho é a
//  clínica redefinir pelo SistemaCMH, e não pedir e-mail obrigatório.
//
//  Deploy: Supabase > Edge Functions > nome: recuperar-senha
// =====================================================================
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};
const json = (b: unknown, s = 200) =>
  new Response(JSON.stringify(b), { status: s, headers: { ...cors, "Content-Type": "application/json" } });

function digitos(s: unknown) { return String(s ?? "").replace(/\D/g, ""); }

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

  const admin = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );

  let body: any;
  try { body = await req.json(); } catch { return json({ error: "JSON inválido" }, 400); }

  const codigo = String(body?.codigo ?? "").trim().toUpperCase();
  const cpf = digitos(body?.cpf);
  const senha = String(body?.senha ?? "");

  if (!codigo) return json({ error: "Digite o código que a sua empresa enviou." }, 400);
  if (!cpfValido(cpf)) return json({ error: "CPF inválido. Confira os números." }, 400);
  if (senha.length < 6) return json({ error: "A senha nova precisa de pelo menos 6 caracteres." }, 400);

  // O MESMO RECADO PARA TODOS OS "NÃO"
  // CPF que não existe, código errado, ou o par não bate: tudo devolve esta
  // frase. Separar os casos ensinaria um curioso a descobrir quais CPF têm
  // conta na plataforma, só pela diferença da resposta.
  const naoConfere = { error: "CPF e código não conferem. Confira os dois, ou fale com o RH da sua empresa." };

  const { data: aluno } = await admin
    .from("trein_aluno").select("id").eq("cpf", cpf).maybeSingle();
  if (!aluno) return json(naoConfere, 400);

  const { data: cupom } = await admin
    .from("trein_cupom").select("id").eq("codigo", codigo).maybeSingle();
  if (!cupom) return json(naoConfere, 400);

  // é isto que prova que a pessoa é ela: o resgate daquele código, no nome
  // daquele CPF, está gravado
  const { data: resgate } = await admin
    .from("trein_resgate").select("aluno_id")
    .eq("cupom_id", cupom.id).eq("aluno_id", aluno.id).maybeSingle();
  if (!resgate) return json(naoConfere, 400);

  const { error } = await admin.auth.admin.updateUserById(aluno.id, { password: senha });
  if (error) return json({ error: "Não consegui trocar a senha: " + error.message }, 400);

  return json({ ok: true, login: cpf });
});
