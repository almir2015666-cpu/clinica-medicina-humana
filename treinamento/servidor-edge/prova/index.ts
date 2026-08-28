// =====================================================================
//  Edge Function: prova
//
//  Serve a prova e corrige. Duas ações num arquivo só:
//    { acao: "pegar",    matricula_id }              -> as perguntas
//    { acao: "corrigir", matricula_id, respostas }   -> a nota
//
//  POR QUE ISTO NÃO PODE VIVER NO NAVEGADOR
//  ----------------------------------------
//  A tabela de questões guarda qual alternativa é a certa. Se o site
//  buscasse as perguntas direto, a resposta viajaria junto — e bastaria
//  abrir a aba de rede para gabaritar. Por isso a RLS proíbe qualquer
//  leitura da tabela pelo navegador, e só esta função (com service role)
//  enxerga o gabarito. O que sai daqui são as alternativas embaralhadas,
//  sem dizer qual é a boa.
//
//  Deploy: Supabase > Edge Functions > nome: prova
// =====================================================================
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};
const json = (b: unknown, s = 200) =>
  new Response(JSON.stringify(b), { status: s, headers: { ...cors, "Content-Type": "application/json" } });

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  if (req.method !== "POST") return json({ error: "Método não permitido" }, 405);

  const URL = Deno.env.get("SUPABASE_URL")!;
  const SERVICE = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
  const ANON = Deno.env.get("SUPABASE_ANON_KEY")!;

  // quem está pedindo tem de estar logado como aluno
  const chamador = createClient(URL, ANON, {
    global: { headers: { Authorization: req.headers.get("Authorization") ?? "" } },
  });
  const { data: ud } = await chamador.auth.getUser();
  if (!ud?.user) return json({ error: "Entre com o seu CPF para fazer a prova." }, 401);

  const admin = createClient(URL, SERVICE);

  let body: any;
  try { body = await req.json(); } catch { return json({ error: "JSON inválido" }, 400); }
  const matricula = String(body?.matricula_id ?? "");
  if (!matricula) return json({ error: "Falta dizer qual curso." }, 400);

  // A matrícula é DELE e está no prazo? Conferir aqui, e não confiar no
  // que o site mandou: o id da matrícula vem do navegador.
  const { data: mat } = await admin
    .from("trein_matricula")
    .select("id,aluno_id,curso_id,cancelada,expira_em,trein_curso(titulo,nota_minima)")
    .eq("id", matricula).maybeSingle();

  if (!mat || mat.aluno_id !== ud.user.id) {
    return json({ error: "Esse curso não é seu." }, 403);
  }
  if (mat.cancelada) return json({ error: "Esse curso foi cancelado." }, 403);
  const hoje = new Date().toISOString().slice(0, 10);
  if (String(mat.expira_em) < hoje) {
    return json({ error: "O seu acesso a este curso venceu. Procure o RH da sua empresa." }, 403);
  }

  const curso: any = mat.trein_curso ?? {};
  const notaMinima = Number(curso.nota_minima ?? 70);

  // ---------------------------------------------------------------- pegar
  if (body?.acao === "pegar") {
    const { data: qs } = await admin
      .from("trein_questao")
      .select("id,enunciado,alternativas,ordem")
      .eq("curso_id", mat.curso_id).order("ordem");

    if (!qs || !qs.length) {
      return json({ error: "A prova deste curso ainda não foi cadastrada. " +
                           "Fale com a nossa equipe." }, 404);
    }
    // as alternativas vão SEM o campo `correta` — ele nem é lido acima
    return json({
      curso: curso.titulo ?? "",
      nota_minima: notaMinima,
      questoes: qs.map((q: any) => ({
        id: q.id, enunciado: q.enunciado, alternativas: q.alternativas,
      })),
    });
  }

  // ------------------------------------------------------------- corrigir
  if (body?.acao === "corrigir") {
    const respostas: any[] = Array.isArray(body?.respostas) ? body.respostas : [];
    const { data: qs } = await admin
      .from("trein_questao")
      .select("id,correta").eq("curso_id", mat.curso_id);

    if (!qs || !qs.length) return json({ error: "Prova não cadastrada." }, 404);

    const gabarito = new Map(qs.map((q: any) => [q.id, q.correta]));
    const dadas = new Map(respostas.map((r: any) => [String(r.questao_id), r.escolha]));

    let acertos = 0;
    for (const [id, certa] of gabarito) {
      if (Number(dadas.get(String(id))) === Number(certa)) acertos++;
    }
    const total = gabarito.size;
    const nota = Math.round((acertos / total) * 100);
    const aprovado = nota >= notaMinima;

    // guarda TODAS as tentativas, e não só a última: numa fiscalização o
    // que vale é poder mostrar o histórico
    await admin.from("trein_tentativa").insert({
      matricula_id: matricula, acertos, total, nota, aprovado,
    });

    // quantas vezes já tentou, para a tela poder dizer
    const { count } = await admin
      .from("trein_tentativa")
      .select("id", { count: "exact", head: true })
      .eq("matricula_id", matricula);

    return json({
      acertos, total, nota, aprovado,
      nota_minima: notaMinima,
      tentativas: count ?? 1,
      // não devolvemos quais errou: com o gabarito na mão, refazer a prova
      // vira decorar. Quem não passou revê a aula e tenta de novo.
    });
  }

  return json({ error: "Ação desconhecida." }, 400);
});
