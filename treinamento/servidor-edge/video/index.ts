// =====================================================================
//  Edge Function: video
//
//  Assina os links do Cloudflare R2, onde os videos das aulas passam a
//  morar.
//
//  POR QUE SAIU DO STORAGE DO SUPABASE
//  -----------------------------------
//  Nao foi capricho: e o preco de ENTREGAR. Guardar video custa centavos
//  em qualquer lugar; entregar e o que pesa, e o Supabase cobra por GB
//  saido. Com mil alunos assistindo, a conta chega a milhares de reais
//  por mes.
//
//  O R2 nao cobra saida. Nenhuma. Vinte GB de aula custam cerca de trinta
//  centavos de dolar por mes, e esse numero NAO muda se assistirem dez ou
//  dez mil pessoas.
//
//  O QUE ESTA FUNCAO FAZ, E O QUE ELA NAO FAZ
//  ------------------------------------------
//  O video NUNCA passa por aqui. Ela so assina um endereco temporario e
//  devolve; o navegador fala direto com o R2. Passar o arquivo por dentro
//  da funcao seria pagar duas vezes pela mesma transferencia e estourar
//  qualquer limite de tempo de execucao.
//
//  AS CHAVES DO R2 SO EXISTEM AQUI
//  Elas dao acesso de escrita ao balde inteiro. Ficam nos segredos da
//  funcao, no painel do Supabase, e nunca no admin.html, que e um arquivo
//  que qualquer pessoa baixa do site.
//
//  SEGREDOS QUE ELA PRECISA
//    R2_CONTA        - o Account ID do Cloudflare
//    R2_BALDE        - o nome do bucket
//    R2_CHAVE_ID     - Access Key ID
//    R2_CHAVE_SECRETA- Secret Access Key
//
//  Deploy: Supabase > Edge Functions > nome: video
// =====================================================================
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { AwsClient } from "https://esm.sh/aws4fetch@1.0.20";

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

// Quanto tempo cada link vive.
//
// O de assistir e curto de proposito: ele e a unica coisa entre o video e
// quem quiser copiar o endereco e mandar para o mundo. Quatro horas cobrem
// a aula mais longa com folga, e um link vazado morre no mesmo dia.
const VER_SEGUNDOS = 4 * 60 * 60;
// O de enviar precisa aguentar arquivo grande em conexao ruim.
const ENVIAR_SEGUNDOS = 2 * 60 * 60;

function faltando(nome: string) {
  return json({ error: `Falta o segredo ${nome} na função. Configure em ` +
                       `Edge Functions > video > Secrets.` }, 500);
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  if (req.method !== "POST") return json({ error: "Método não permitido" }, 405);

  const conta = Deno.env.get("R2_CONTA");
  const balde = Deno.env.get("R2_BALDE");
  const chaveId = Deno.env.get("R2_CHAVE_ID");
  const segredo = Deno.env.get("R2_CHAVE_SECRETA");
  if (!conta) return faltando("R2_CONTA");
  if (!balde) return faltando("R2_BALDE");
  if (!chaveId) return faltando("R2_CHAVE_ID");
  if (!segredo) return faltando("R2_CHAVE_SECRETA");

  const url = Deno.env.get("SUPABASE_URL")!;
  const admin = createClient(url, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!);

  const token = (req.headers.get("Authorization") ?? "").replace("Bearer ", "");
  const { data: ud } = await admin.auth.getUser(token);
  if (!ud?.user) return json({ error: "Entre com a sua conta." }, 401);

  let body: any = null;
  try { body = await req.json(); } catch { return json({ error: "JSON inválido" }, 400); }
  const acao = String(body?.acao ?? "");

  const r2 = new AwsClient({
    accessKeyId: chaveId,
    secretAccessKey: segredo,
    service: "s3",
    region: "auto",
  });
  const base = `https://${conta}.r2.cloudflarestorage.com/${balde}`;

  // Assina o endereco e devolve so a URL. `signQuery` poe a assinatura na
  // propria URL, que e o que permite o navegador usar sem cabecalho.
  async function assinar(chave: string, metodo: string, segundos: number) {
    const alvo = new URL(`${base}/${chave.split("/").map(encodeURIComponent).join("/")}`);
    alvo.searchParams.set("X-Amz-Expires", String(segundos));
    const assinado = await r2.sign(
      new Request(alvo.toString(), { method: metodo }),
      { aws: { signQuery: true } },
    );
    return assinado.url;
  }

  // ---- enviar: so a equipe -------------------------------------------
  if (acao === "enviar") {
    // A conferencia e no banco, pela MESMA funcao que o admin usa. Assim,
    // liberar o modulo para mais alguem no SistemaCMH passa a valer aqui
    // na hora, sem republicar nada.
    const comoEle = createClient(url, Deno.env.get("SUPABASE_ANON_KEY")!, {
      global: { headers: { Authorization: `Bearer ${token}` } },
    });
    const { data: ehEquipe, error: erroEquipe } = await comoEle.rpc("trein_is_equipe");
    if (erroEquipe) {
      return json({ error: "Não consegui conferir a sua permissão agora." }, 503);
    }
    if (!ehEquipe) return json({ error: "Sem permissão para enviar vídeo." }, 403);

    const curso = String(body?.curso_id ?? "");
    if (!/^[0-9a-f-]{36}$/i.test(curso)) {
      return json({ error: "Curso inválido." }, 400);
    }
    // A extensao e limpa aqui tambem, e nao so na tela: o nome do arquivo
    // vem do computador de quem envia, e vira parte de um endereco.
    const ext = String(body?.ext ?? "mp4").toLowerCase()
      .replace(/[^a-z0-9]/g, "").slice(0, 5) || "mp4";
    const chave = `cursos/${curso}/${crypto.randomUUID()}.${ext}`;

    return json({
      chave,
      url: await assinar(chave, "PUT", ENVIAR_SEGUNDOS),
      expira_em: ENVIAR_SEGUNDOS,
    });
  }

  // ---- assistir: aluno com matricula valida, ou a equipe --------------
  if (acao === "assistir") {
    const chave = String(body?.chave ?? "").replace(/^\/+/, "");
    // Sem esta conferencia, alguem logado pediria "../outro-balde/qualquer
    // coisa" e a funcao assinaria de bom grado.
    if (!/^cursos\/[0-9a-f-]{36}\/[0-9a-f-]{36}\.[a-z0-9]{1,5}$/i.test(chave)) {
      return json({ error: "Vídeo inválido." }, 400);
    }

    const comoEle = createClient(url, Deno.env.get("SUPABASE_ANON_KEY")!, {
      global: { headers: { Authorization: `Bearer ${token}` } },
    });
    const { data: ehEquipe } = await comoEle.rpc("trein_is_equipe");

    if (!ehEquipe) {
      // QUEM PODE VER E O BANCO QUE DIZ, e nao a tela.
      //
      // `trein_pode_ver` ja e a regra usada em todo o resto: matricula do
      // proprio aluno, nao cancelada e dentro do prazo. Repetir a regra
      // aqui em TypeScript criaria uma segunda versao dela, e as duas
      // divergiriam no primeiro ajuste.
      const curso = chave.split("/")[1];
      const { data: pode, error } = await comoEle.rpc("trein_pode_ver", {
        p_curso: curso,
      });
      if (error) {
        return json({ error: "Não consegui conferir o seu acesso agora." }, 503);
      }
      if (!pode) {
        return json({ error: "Este curso não está liberado para você." }, 403);
      }
    }

    return json({
      url: await assinar(chave, "GET", VER_SEGUNDOS),
      expira_em: VER_SEGUNDOS,
    });
  }

  // ---- apagar: so a equipe -------------------------------------------
  if (acao === "apagar") {
    const comoEle = createClient(url, Deno.env.get("SUPABASE_ANON_KEY")!, {
      global: { headers: { Authorization: `Bearer ${token}` } },
    });
    const { data: ehEquipe } = await comoEle.rpc("trein_is_equipe");
    if (!ehEquipe) return json({ error: "Sem permissão." }, 403);

    const chave = String(body?.chave ?? "").replace(/^\/+/, "");
    if (!/^cursos\/[0-9a-f-]{36}\/[0-9a-f-]{36}\.[a-z0-9]{1,5}$/i.test(chave)) {
      return json({ error: "Vídeo inválido." }, 400);
    }
    const resp = await r2.fetch(
      `${base}/${chave.split("/").map(encodeURIComponent).join("/")}`,
      { method: "DELETE" },
    );
    // 404 tambem e sucesso: o objetivo era nao existir mais.
    if (!resp.ok && resp.status !== 404) {
      return json({ error: `O R2 recusou apagar (erro ${resp.status}).` }, 502);
    }
    return json({ ok: true });
  }

  return json({ error: "Ação desconhecida." }, 400);
});
