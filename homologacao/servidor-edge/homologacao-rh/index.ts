// =====================================================================
//  Edge Function: homologacao-rh
//
//  Cria, refaz a senha, liga e desliga o acesso do RH da empresa cliente
//  à HOMOLOGAÇÃO DE ATESTADOS (clinicamedicinahumana.com.br/homologacao).
//
//  É IRMÃ DA FUNÇÃO `rh` DO TREINAMENTO, E NÃO A MESMA
//  O RH que manda atestado não é, necessariamente, o que acompanha curso.
//  As contas daqui moram em homol_conta, a permissão é o módulo
//  "Homologação" do SistemaCMH, e nada aqui toca em trein_rh.
//
//  POR QUE ISTO NÃO PODE VIVER NO PROGRAMA NEM NO SITE
//  Criar usuário no Auth exige a chave de serviço, que abre o banco
//  inteiro. Ela mora aqui, no servidor — e nunca no SistemaCMH, que vira
//  .exe em todo computador da clínica.
//
//  QUEM PODE CHAMAR
//  Só quem está logado no SistemaCMH com o módulo "Homologação" marcado
//  (ou é administrador). A conferência é no banco, pela homol_is_equipe:
//  liberar o módulo para mais alguém vale aqui na hora, sem republicar.
//
//  Deploy: Supabase > Edge Functions > nome: homologacao-rh, com "Verify
//  JWT" MARCADO (quem chama é sempre alguém logado no SistemaCMH). Se o
//  painel der outro slug, troque FUNCAO_HOMOLOGACAO no homologacao_nucleo.py.
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
// trocado cria um acesso que nunca vai enxergar processo nenhum.
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

// 14 caracteres do gerador criptográfico, sem os pares que se confundem
// lidos ao telefone ou copiados de um papel: I e l, O e 0, S e 5.
function senhaNova(): string {
  const letras = "ABCDEFGHJKLMNPQRTUVWXYZabcdefghijkmnpqrstuvwxyz23456789";
  const n = new Uint32Array(14);
  crypto.getRandomValues(n);
  return Array.from(n, (x) => letras[x % letras.length]).join("");
}

function dataValida(s: unknown): string | null {
  const t = String(s ?? "").trim();
  return /^\d{4}-\d{2}-\d{2}$/.test(t) ? t : null;
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

  const comoEle = createClient(url, Deno.env.get("SUPABASE_ANON_KEY")!, {
    global: { headers: { Authorization: `Bearer ${token}` } },
  });
  const { data: ehEquipe, error: erroEquipe } = await comoEle.rpc("homol_is_equipe");
  if (erroEquipe) {
    return json({ error: "Não consegui conferir a sua permissão agora. " +
                         "Rodou o 01-esquema.sql da homologação? Tente de novo." }, 503);
  }
  if (!ehEquipe) {
    return json({ error: "Só quem tem o módulo Homologação liberado no " +
                         "SistemaCMH pode criar acesso de empresa." }, 403);
  }
  const quemPediu = ud.user.email ?? null;

  let body: any = null;
  try { body = await req.json(); } catch { return json({ error: "JSON inválido" }, 400); }
  const acao = String(body?.acao ?? "");

  // ---- criar ou refazer a senha -------------------------------------
  if (acao === "criar" || acao === "nova_senha") {
    const email = String(body?.email ?? "").trim().toLowerCase();
    if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) {
      return json({ error: "E-mail inválido." }, 400);
    }

    const { data: jaTem } = await admin
      .from("homol_conta").select("id,nome,empresa_nome").eq("email", email)
      .maybeSingle();

    if (acao === "nova_senha") {
      if (!jaTem) return json({ error: "Não existe acesso da homologação com esse e-mail." }, 404);
      const senha = senhaNova();
      const { error } = await admin.auth.admin.updateUserById(jaTem.id, { password: senha });
      if (error) return json({ error: "Não consegui trocar a senha: " + error.message }, 500);
      await admin.from("homol_conta").update({ ativo: true }).eq("id", jaTem.id);
      return json({ ok: true, email, senha, nome: jaTem.nome, empresa: jaTem.empresa_nome, refeita: true });
    }

    if (jaTem) {
      return json({ error: "Já existe um acesso da homologação com esse e-mail. " +
                           "Use \"Gerar nova senha\" em vez de criar outro." }, 409);
    }

    const nome = String(body?.nome ?? "").trim();
    const cnpj = digitos(body?.empresa_cnpj);
    const empresa = String(body?.empresa_nome ?? "").trim();
    const contrato = String(body?.contrato_numero ?? "").trim() || null;
    const valeAte = dataValida(body?.vale_ate);
    if (nome.length < 3) return json({ error: "Diga o nome de quem vai usar o acesso." }, 400);
    if (!cnpjValido(cnpj)) return json({ error: "CNPJ inválido." }, 400);
    if (!empresa) return json({ error: "Falta o nome da empresa." }, 400);

    const senha = senhaNova();
    let id: string | null = null;
    let senhaDevolvida: string | null = senha;
    let reaproveitada = false;

    const { data: criado, error: cErr } = await admin.auth.admin.createUser({
      email,
      password: senha,
      email_confirm: true,           // quem confirma é a clínica, ao criar
      user_metadata: { papel: "rh_homologacao", empresa },
    });

    if (criado?.user) {
      id = criado.user.id;
    } else if (/already|registered|exists/i.test(cErr?.message ?? "")) {
      // O E-MAIL JÁ ENTRA EM OUTRA PARTE DO SITE. Se for o RH do
      // Treinamento, a mesma pessoa ganha também a homologação, com a
      // MESMA senha de lá — criar uma segunda conta com o mesmo e-mail
      // não é possível no Auth, e trocar a senha dela aqui a trancaria
      // do lado de fora do Treinamento sem aviso.
      // Qualquer outra conta (aluno, equipe da clínica) é recusada: não se
      // sequestra a conta de ninguém.
      const { data: doTrein } = await admin
        .from("trein_rh").select("id").eq("email", email).maybeSingle();
      if (!doTrein) {
        return json({ error: "Esse e-mail já é usado por outra conta do site " +
                             "(aluno ou equipe). Use outro e-mail para o RH." }, 409);
      }
      id = doTrein.id;
      senhaDevolvida = null;
      reaproveitada = true;
    } else {
      return json({ error: "Não consegui criar o acesso: " +
                           (cErr?.message ?? "erro desconhecido") }, 500);
    }

    const { error: tErr } = await admin.from("homol_conta").insert({
      id, nome, email, empresa_cnpj: cnpj, empresa_nome: empresa,
      contrato_numero: contrato, vale_ate: valeAte, criado_por: quemPediu,
    });
    if (tErr) {
      // desfaz a conta nova: conta de Auth sem linha na nossa tabela entra
      // e não enxerga nada, e ninguém entenderia por quê
      if (!reaproveitada && id) await admin.auth.admin.deleteUser(id);
      return json({ error: "Não consegui gravar o acesso: " + tErr.message }, 500);
    }

    return json({ ok: true, id, email, senha: senhaDevolvida, nome, empresa, cnpj,
                  contrato, reaproveitada });
  }

  // ---- ligar e desligar ---------------------------------------------
  if (acao === "ativar" || acao === "desativar") {
    const id = String(body?.id ?? "");
    if (!id) return json({ error: "Falta dizer qual acesso." }, 400);
    const { error } = await admin.from("homol_conta")
      .update({ ativo: acao === "ativar" }).eq("id", id);
    if (error) return json({ error: error.message }, 500);
    return json({ ok: true });
  }

  return json({ error: "Ação desconhecida." }, 400);
});
