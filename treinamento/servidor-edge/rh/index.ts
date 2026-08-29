// =====================================================================
//  Edge Function: rh
//
//  Cria, reativa e desliga o acesso do RH da empresa cliente ao painel
//  de acompanhamento.
//
//  POR QUE ISTO NÃO PODE VIVER NO NAVEGADOR
//  ----------------------------------------
//  Criar usuário no Auth exige a chave de serviço, que abre o banco
//  inteiro. Ela mora aqui, no servidor, e nunca no admin.html, que é um
//  arquivo que qualquer pessoa baixa do site.
//
//  QUEM PODE CHAMAR
//  Só quem está logado como equipe da clínica, e a conferência é feita
//  no banco, pela mesma função que o admin do treinamento usa. Não basta
//  ter um token: tem que ser gente com o módulo liberado no SistemaCMH.
//
//  A SENHA
//  É gerada aqui, forte, e devolvida UMA vez, para a clínica repassar ao
//  RH. Ela não fica guardada em lugar nenhum: o Auth guarda só o resumo
//  criptográfico dela. Se o RH perder, gera-se outra.
//
//  Deploy: Supabase > Edge Functions > nome: rh
// =====================================================================
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};
const json = (b: unknown, s = 200) =>
  new Response(JSON.stringify(b), {
    status: s,
    headers: { ...cors, "Content-Type": "application/json" },
  });

function digitos(s: unknown) { return String(s ?? "").replace(/\D/g, ""); }

// Confere o CNPJ de verdade, e não só o tamanho. CNPJ com um dígito
// trocado cria um acesso que nunca vai enxergar turma nenhuma, e o RH
// liga dizendo que o painel está vazio.
function cnpjValido(c: string): boolean {
  if (c.length !== 14 || /^(\d)\1{13}$/.test(c)) return false;
  const calc = (base: string, pesos: number[]) => {
    const soma = base.split("").reduce((a, d, i) => a + Number(d) * pesos[i], 0);
    const r = soma % 11;
    return r < 2 ? 0 : 11 - r;
  };
  const d1 = calc(c.slice(0, 12), [5,4,3,2,9,8,7,6,5,4,3,2]);
  const d2 = calc(c.slice(0, 13), [6,5,4,3,2,9,8,7,6,5,4,3,2]);
  return d1 === Number(c[12]) && d2 === Number(c[13]);
}

// Senha de 14 caracteres, sorteada com o gerador criptográfico do
// sistema. Sem os pares que se confundem lidos ao telefone ou copiados
// de um papel: I e l, O e 0, S e 5.
function senhaNova(): string {
  const letras = "ABCDEFGHJKLMNPQRTUVWXYZabcdefghijkmnpqrstuvwxyz23456789";
  const n = new Uint32Array(14);
  crypto.getRandomValues(n);
  return Array.from(n, (x) => letras[x % letras.length]).join("");
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  if (req.method !== "POST") return json({ error: "Método não permitido" }, 405);

  const url = Deno.env.get("SUPABASE_URL")!;
  const admin = createClient(url, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!);

  // ---- quem está pedindo -------------------------------------------
  const token = (req.headers.get("Authorization") ?? "").replace("Bearer ", "");
  const { data: ud } = await admin.auth.getUser(token);
  if (!ud?.user) return json({ error: "Entre com a sua conta da clínica." }, 401);

  // A CONFERÊNCIA É NO BANCO, e não numa lista aqui dentro. É a mesma
  // função que o admin do treinamento usa, então liberar o módulo para
  // mais alguém no SistemaCMH passa a valer aqui na hora, sem republicar
  // nada.
  const comoEle = createClient(url, Deno.env.get("SUPABASE_ANON_KEY")!, {
    global: { headers: { Authorization: `Bearer ${token}` } },
  });
  const { data: ehEquipe, error: erroEquipe } = await comoEle.rpc("trein_is_equipe");
  if (erroEquipe) {
    return json({ error: "Não consegui conferir a sua permissão agora. " +
                         "Tente de novo." }, 503);
  }
  if (!ehEquipe) {
    return json({ error: "Só quem tem o módulo Treinamentos liberado no " +
                         "SistemaCMH pode criar acesso de empresa." }, 403);
  }

  let body: any = null;
  try { body = await req.json(); } catch { return json({ error: "JSON inválido" }, 400); }
  const acao = String(body?.acao ?? "");

  // ---- criar ou refazer a senha -------------------------------------
  if (acao === "criar" || acao === "nova_senha") {
    const email = String(body?.email ?? "").trim().toLowerCase();
    if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) {
      return json({ error: "E-mail inválido." }, 400);
    }

    const senha = senhaNova();

    // Já existe conta com esse e-mail?
    //
    // `listUsers` não filtra por e-mail, então a busca é feita na nossa
    // tabela, que é onde a informação interessa. Uma conta de Auth sem
    // linha aqui seria de outra coisa (aluno, equipe), e aí o e-mail
    // colide de verdade e o certo é recusar, e não sequestrar a conta.
    const { data: jaTem } = await admin
      .from("trein_rh").select("id,nome,empresa_cnpj").eq("email", email)
      .maybeSingle();

    if (acao === "nova_senha") {
      if (!jaTem) return json({ error: "Não existe acesso com esse e-mail." }, 404);
      const { error } = await admin.auth.admin.updateUserById(jaTem.id, {
        password: senha,
      });
      if (error) return json({ error: "Não consegui trocar a senha: " + error.message }, 500);
      await admin.from("trein_rh").update({ ativo: true }).eq("id", jaTem.id);
      return json({ ok: true, email, senha, nome: jaTem.nome, refeita: true });
    }

    if (jaTem) {
      return json({ error: "Já existe um acesso com esse e-mail. Use " +
                           "\"Gerar nova senha\" em vez de criar outro." }, 409);
    }

    const nome = String(body?.nome ?? "").trim();
    const cnpj = digitos(body?.empresa_cnpj);
    const empresa = String(body?.empresa_nome ?? "").trim() || null;
    if (nome.length < 3) return json({ error: "Diga o nome de quem vai usar o acesso." }, 400);
    if (!cnpjValido(cnpj)) return json({ error: "CNPJ inválido." }, 400);

    const { data: criado, error: cErr } = await admin.auth.admin.createUser({
      email,
      password: senha,
      email_confirm: true,   // quem confirma é a clínica, ao criar
      user_metadata: { papel: "rh", empresa },
    });
    if (cErr || !criado?.user) {
      return json({ error: "Não consegui criar o acesso: " +
                           (cErr?.message ?? "erro desconhecido") }, 500);
    }

    const { error: tErr } = await admin.from("trein_rh").insert({
      id: criado.user.id, nome, email,
      empresa_cnpj: cnpj, empresa_nome: empresa,
      criado_por: ud.user.email ?? null,
    });
    if (tErr) {
      // desfaz a conta: conta de Auth sem linha na nossa tabela é uma
      // conta que entra e não enxerga nada, e ninguém entenderia por quê
      await admin.auth.admin.deleteUser(criado.user.id);
      return json({ error: "Não consegui gravar o acesso: " + tErr.message }, 500);
    }

    return json({ ok: true, email, senha, nome, empresa, cnpj });
  }

  // ---- ligar e desligar ---------------------------------------------
  if (acao === "ativar" || acao === "desativar") {
    const id = String(body?.id ?? "");
    if (!id) return json({ error: "Falta dizer qual acesso." }, 400);
    const { error } = await admin.from("trein_rh")
      .update({ ativo: acao === "ativar" }).eq("id", id);
    if (error) return json({ error: error.message }, 500);
    return json({ ok: true });
  }

  return json({ error: "Ação desconhecida." }, 400);
});
