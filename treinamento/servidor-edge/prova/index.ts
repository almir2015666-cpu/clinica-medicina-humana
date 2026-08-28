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
//  enxerga o gabarito.
//
//  A PROVA É SORTEADA
//  ------------------
//  Cada curso tem um banco de ~40 questões e a prova pega 10. Antes eram
//  10 questões e a prova entregava todas: dois colegas faziam a MESMA
//  prova, e o primeiro a passar ditava as respostas para o turno inteiro.
//
//  O sorteio é GRAVADO na trein_sorteio antes de sair daqui, e a correção
//  usa o que está gravado — nunca o que o navegador devolveu. Sem isso, o
//  aluno pediria a prova várias vezes, juntaria as questões que sabe e
//  mandaria só essas: dez acertos em dez, sem saber o resto.
//
//  E as alternativas também são embaralhadas, por sorteio, com a posição
//  da resposta certa guardada junto. Duas pessoas que tirem a MESMA
//  pergunta veem as alternativas em ordens diferentes — "é a letra C" para
//  de ser uma resposta transmissível.
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

// Embaralhamento de Fisher-Yates, com o sorteio do Deno (crypto).
// Math.random() daria conta aqui, mas é o mesmo gerador em toda a
// instância e não custa nada usar o bom.
function embaralhar<T>(lista: T[]): T[] {
  const a = [...lista];
  for (let i = a.length - 1; i > 0; i--) {
    const j = crypto.getRandomValues(new Uint32Array(1))[0] % (i + 1);
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

// Quanto tempo esperar depois de reprovar, e quantas provas por dia.
// São números de regra da clínica, e não de técnica: ficam aqui em cima,
// nomeados, para quem for mudar não precisar procurar dentro da função.
const ESPERA_MS = 30 * 60 * 1000;
const MAX_POR_DIA = 3;
const FUSO = "America/Bahia";

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
    .select("id,aluno_id,curso_id,cancelada,expira_em,trein_curso(titulo,nota_minima,questoes_por_prova)")
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
  const quantas = Math.max(1, Number(curso.questoes_por_prova ?? 10));

  // ---------------------------------------------------------------- pegar
  if (body?.acao === "pegar") {
    // AS AULAS TÊM DE ESTAR TODAS CONCLUÍDAS.
    // A tela já esconde a prova antes disso, mas a tela é o navegador —
    // quem quisesse pular direto para a prova bastaria chamar esta função.
    const { data: aulas } = await admin
      .from("trein_aula").select("id").eq("curso_id", mat.curso_id);
    const total_aulas = aulas?.length ?? 0;
    if (total_aulas === 0) {
      return json({ error: "As aulas deste curso ainda não foram publicadas." }, 404);
    }
    const { count: feitas } = await admin
      .from("trein_progresso")
      .select("aula_id", { count: "exact", head: true })
      .eq("matricula_id", matricula).eq("concluida", true);
    if ((feitas ?? 0) < total_aulas) {
      return json({ error: "Termine todas as aulas antes de fazer a prova." }, 403);
    }

    // ESPERA DEPOIS DE REPROVAR, E LIMITE POR DIA.
    //
    // Sem isto, quem reprova tenta de novo no segundo seguinte, quantas
    // vezes quiser. O problema nao e a insistencia: e que, tentando sem
    // parar, as questoes COMECAM A REPETIR (sao 10 sorteadas de 150) e a
    // pessoa converge na resposta por eliminacao, sem ter aprendido nada.
    // O certificado sairia valido para quem nao sabe, que e exatamente o
    // que a fiscalizacao procura.
    //
    // A conferencia e AQUI, no servidor, e nao na tela: a tela e o
    // navegador do aluno, e quem quisesse burlar bastaria chamar esta
    // funcao direto.
    const { data: recentes } = await admin
      .from("trein_tentativa")
      .select("feita_em,aprovado")
      .eq("matricula_id", matricula)
      .order("feita_em", { ascending: false })
      .limit(30);

    if (recentes && recentes.length) {
      const agora = Date.now();

      // 1. A espera de 30 minutos, contada da ULTIMA tentativa reprovada.
      const ultima = recentes[0];
      if (!ultima.aprovado) {
        const passou = agora - new Date(ultima.feita_em).getTime();
        const faltam = ESPERA_MS - passou;
        if (faltam > 0) {
          const min = Math.ceil(faltam / 60000);
          return json({
            error: "Reveja as aulas com calma. Você poderá tentar de novo em "
                 + (min === 1 ? "1 minuto." : min + " minutos."),
            espere_segundos: Math.ceil(faltam / 1000),
          }, 429);
        }
      }

      // 2. Tres por dia, contadas no fuso da clinica.
      //
      // Dia do CALENDARIO, e nao "ultimas 24 horas": "voce ja fez tres
      // hoje, tente amanha" e uma frase que qualquer pessoa entende, e
      // "espere ate as 14h37 de amanha" nao e. E o fuso e o da Bahia, e
      // nao o do servidor, senao a virada do dia aconteceria as 21h para
      // quem esta aqui.
      const dia = (d: string) =>
        new Intl.DateTimeFormat("en-CA", { timeZone: FUSO }).format(new Date(d));
      const hoje = new Intl.DateTimeFormat("en-CA", { timeZone: FUSO })
        .format(new Date());
      const feitasHoje = recentes.filter((t) => dia(t.feita_em) === hoje).length;
      if (feitasHoje >= MAX_POR_DIA) {
        return json({
          error: "Você já fez " + MAX_POR_DIA + " provas hoje. Reveja as "
               + "aulas e tente de novo amanhã.",
          espere_ate_amanha: true,
        }, 429);
      }
    }

    const { data: banco } = await admin
      .from("trein_questao")
      .select("id,enunciado,alternativas,correta")
      .eq("curso_id", mat.curso_id);

    if (!banco || !banco.length) {
      return json({ error: "A prova deste curso ainda não foi cadastrada. " +
                           "Fale com a nossa equipe." }, 404);
    }

    // sorteia as questões, e dentro de cada uma sorteia as alternativas.
    // A posição nova da resposta certa vai gravada no sorteio; a que está
    // na tabela não serve mais depois de embaralhar.
    const escolhidas = embaralhar(banco).slice(0, Math.min(quantas, banco.length));

    const paraOAluno: any[] = [];
    const gabarito: number[] = [];
    for (const q of escolhidas) {
      const originais: string[] = Array.isArray(q.alternativas) ? q.alternativas : [];
      const posicoes = embaralhar(originais.map((_, i) => i));
      paraOAluno.push({
        id: q.id,
        enunciado: q.enunciado,
        alternativas: posicoes.map((p) => originais[p]),
      });
      // onde a resposta certa foi parar depois do embaralho
      gabarito.push(posicoes.indexOf(Number(q.correta)));
    }

    // O sorteio anterior que não foi respondido morre aqui. Sem isso, o
    // aluno abriria a prova várias vezes para mapear o banco e depois
    // responderia o sorteio mais fácil.
    await admin.from("trein_sorteio")
      .delete().eq("matricula_id", matricula).eq("usado", false);

    const { error: erroSorteio } = await admin.from("trein_sorteio").insert({
      matricula_id: matricula,
      questoes: escolhidas.map((q: any) => q.id),
      gabarito,
    });
    if (erroSorteio) {
      return json({ error: "Não consegui montar a prova. Tente de novo." }, 500);
    }

    return json({
      curso: curso.titulo ?? "",
      nota_minima: notaMinima,
      questoes: paraOAluno,   // sem `correta`: ele nem entra no objeto
    });
  }

  // ------------------------------------------------------------- corrigir
  if (body?.acao === "corrigir") {
    const respostas: any[] = Array.isArray(body?.respostas) ? body.respostas : [];

    // A PROVA É A QUE FOI SORTEADA, não a que o navegador devolveu.
    const { data: sorteio } = await admin
      .from("trein_sorteio")
      .select("id,questoes,gabarito")
      .eq("matricula_id", matricula).eq("usado", false)
      .order("criado_em", { ascending: false })
      .limit(1).maybeSingle();

    if (!sorteio) {
      return json({ error: "Essa prova já foi corrigida ou expirou. " +
                           "Abra a prova de novo." }, 409);
    }

    // queima o sorteio ANTES de corrigir, e só segue se a queima pegou:
    // dois envios ao mesmo tempo, um deles perde a corrida e para aqui,
    // em vez de gravarem duas tentativas da mesma prova.
    const { data: queimado } = await admin
      .from("trein_sorteio")
      .update({ usado: true })
      .eq("id", sorteio.id).eq("usado", false)
      .select("id").maybeSingle();
    if (!queimado) {
      return json({ error: "Essa prova já foi enviada." }, 409);
    }

    const dadas = new Map(respostas.map((r: any) => [String(r.questao_id), r.escolha]));

    // AS RESPOSTAS SÃO DESTA PROVA?
    //
    // Sem esta conferência, abrir o painel numa segunda aba destruía a
    // prova da primeira: aquele `delete` lá em cima apagava o sorteio
    // aberto, nascia outro, e o envio da aba antiga era corrigido contra
    // um sorteio que ele nunca viu. Nenhum id batia, e o aluno levava um
    // ZERO gravado para sempre no histórico por ter aberto outra aba.
    //
    // Agora, nesse caso, o sorteio novo não é queimado e a pessoa é
    // mandada de volta para refazer — que é chato, mas é honesto.
    const doSorteio = new Set((sorteio.questoes as string[]).map(String));
    const daOutra = respostas.some((r: any) => !doSorteio.has(String(r.questao_id)));
    if (daOutra) {
      await admin.from("trein_sorteio").update({ usado: false }).eq("id", sorteio.id);
      return json({ error: "Esta prova foi reaberta em outra aba. " +
                           "Feche as outras abas e abra a prova de novo." }, 409);
    }

    let acertos = 0;
    (sorteio.questoes as string[]).forEach((qid, i) => {
      // o denominador é o TAMANHO DO SORTEIO. Questão não respondida
      // conta como erro — quem manda meia prova não tira nota cheia.
      if (Number(dadas.get(String(qid))) === Number(sorteio.gabarito[i])) acertos++;
    });

    const total = (sorteio.questoes as string[]).length;
    const nota = Math.round((acertos / total) * 100);
    const aprovado = nota >= notaMinima;

    // guarda TODAS as tentativas, e não só a última: numa fiscalização o
    // que vale é poder mostrar o histórico
    //
    // E O ERRO É CONFERIDO. Se esta gravação falha em silêncio, a tela diz
    // "Aprovado! o seu certificado já está pronto", o aluno clica, e o
    // banco responde NAO_APROVADO — porque a aprovação não existe em lugar
    // nenhum. Ele passou, e o sistema jura que não. Melhor mandar refazer.
    const { error: erroTentativa } = await admin.from("trein_tentativa").insert({
      matricula_id: matricula, acertos, total, nota, aprovado,
    });
    if (erroTentativa) {
      return json({ error: "Corrigi a sua prova, mas não consegui gravar o " +
                           "resultado. Nada foi perdido: abra a prova e envie " +
                           "de novo." }, 500);
    }

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
