/* =====================================================================
   HOMOLOGAÇÃO DE ATESTADOS — os dados (Supabase)

   Um arquivo só, usado pelas quatro telas (porta, lista, ficha e
   relatórios). As telas não sabem de onde os dados vêm: pedem aqui, e
   aqui se fala com o Supabase.

   QUEM DECIDE É O BANCO. Nada do que está aqui é "segurança": a tela
   pode ser adulterada por qualquer um. Quem vê o quê, quem pode dar o
   parecer e o que o parecer faz com o processo são regras do banco
   (servidor-sql/01-esquema.sql). Este arquivo só pede e traduz.

   QUEM ENTRA
     RH da empresa -> e-mail + senha que a clínica enviou (conta criada
                      pelo SistemaCMH a partir do contrato assinado)
     Dr. Everaldo  -> o MESMO usuário e senha do SistemaCMH; o que dá a
                      ele o papel de médico é a categoria "Diretor médico"
   ===================================================================== */
(function () {
  "use strict";

  /* PRÉVIA LOCAL. Aberto pelo servidor local (127.0.0.1), o site usa os
     dados de exemplo do dados-demo.js, para dar para ver as telas do RH
     e do médico sem mexer no banco de verdade. Para testar contra o
     Supabase no próprio computador, acrescente ?real=1 ao endereço.
     No site publicado, esta linha nunca é verdadeira. */
  if (/^(127\.0\.0\.1|localhost)$/.test(location.hostname) && !/[?&]real=1/.test(location.search)) {
    document.write('<script src="dados-demo.js"><\/script>');
    return;
  }

  var CHAVE_SESSAO = "cmh_homologacao_sessao_v2";
  var BALDE = "homologacao";
  // o mesmo domínio que o SistemaCMH usa para transformar "usuário" em
  // e-mail de login (app.py, DOMINIO_LOGIN)
  var DOMINIO_SISTEMA = "orcamentos.clinicamedicinahumana.com.br";
  var TETO_ANEXO = 10 * 1048576;   // o mesmo limite do balde, no banco

  var sb = window.supabase.createClient(window.SUPA.url, window.SUPA.key);

  /* ---------- as tabelas fixas ---------- */

  // Os mesmos tipos, na mesma ordem e com os mesmos códigos, do sistema
  // que o RH das empresas já usa — para ninguém ter de reaprender.
  var TIPOS = [
    ["1", "REQ.AFAST. POR ACIDENTE DE TRABALHO"],
    ["2", "REQ. AFAST. POR AUXILIO DOENÇA"],
    ["3", "LICENÇA MATERNIDADE"],
    ["4", "ATESTADO - ( ATÉ 15 DIAS )"],
    ["5", "DOAÇÃO DE SANGUE"],
    ["6", "ATESTADO DE COMPARECIMENTO"],
    ["7", "ACOMPANHAMENTO"],
    ["8", "ATESTADO MEDICO MAIS DE 15 DIAS"],
    ["9", "ATESTADO MEDICO INTERNAÇÃO"],
    ["10", "ATESTADO ACIDENTE DE TRABALHO"]
  ].map(function (t) { return {codigo: t[0], nome: t[1]}; });

  // Quem homologa. O CRM é o que a clínica já usa para assinar ASO.
  var RESPONSAVEIS = [
    {codigo: "6276", nome: "DR. EVERALDO BARBOSA RIBEIRO FILHO",
     registro: "CRM-BA 6276", funcao: "Diretor médico, homologação"}
  ];

  var ORGAOS = ["CRM", "CRO", "CRP", "COREN", "CREFITO", "CRFa", "CRN", "CRF", "CRBM"];
  var UFS = ["AC","AL","AM","AP","BA","CE","DF","ES","GO","MA","MG","MS","MT","PA","PB",
             "PE","PI","PR","RJ","RN","RO","RR","RS","SC","SE","SP","TO"];

  /* ---------- utilidades ---------- */
  function soDigitos(t) { return String(t || "").replace(/\D/g, ""); }

  /* O CPF é quem identifica o colaborador (ver o 03-cpf-...sql). Aqui a
     conta dos dois dígitos verificadores: é ela que separa um CPF de um
     número de onze algarismos digitado errado, e é por isso que a
     matrícula não servia — matrícula não tem como conferir.

     Os repetidos ("111.111.111-11") passam na conta dos dígitos e são
     recusados à parte: são os que a pessoa escreve quando não tem o
     documento à mão e quer seguir assim mesmo. */
  function cpfValido(t) {
    var c = soDigitos(t), i, soma, resto;
    if (c.length !== 11 || /^(\d)\1{10}$/.test(c)) return false;
    for (var passo = 0; passo < 2; passo++) {
      soma = 0;
      for (i = 0; i < 9 + passo; i++) soma += Number(c[i]) * (10 + passo - i);
      resto = (soma * 10) % 11;
      if (resto === 10) resto = 0;
      if (resto !== Number(c[9 + passo])) return false;
    }
    return true;
  }
  function cpfBonito(t) {
    var c = soDigitos(t);
    if (c.length !== 11) return String(t || "");
    return c.slice(0, 3) + "." + c.slice(3, 6) + "." + c.slice(6, 9) + "-" + c.slice(9);
  }
  function semAcento(t) { return String(t || "").normalize("NFD").replace(/[̀-ͯ]/g, ""); }

  /* O banco devolve os erros das regras como "CODIGO: frase". A frase é
     para gente; o código fica para quem for investigar. */
  function traduzirErro(e, padrao) {
    var m = String((e && (e.message || e.error_description || e.error)) || "");
    if (/JWT|expired|not authenticated|permission denied/i.test(m)) {
      return "Sua sessão acabou. Entre de novo.";
    }
    var regra = m.match(/^[A-Z_]+:\s*(.+)$/);
    if (regra) return regra[1].charAt(0).toUpperCase() + regra[1].slice(1) + ".";
    if (/Failed to fetch|NetworkError|network/i.test(m)) {
      return "Sem conexão com o servidor. Confira a internet e tente de novo. Nada foi perdido.";
    }
    return padrao || ("Não deu certo: " + m);
  }

  /* ---------- sessão ----------
     O login de verdade quem guarda é o próprio Supabase. Aqui fica só uma
     cópia de QUEM é a pessoa (papel, nome, empresa), para as telas
     saberem na hora o que mostrar, sem esperar a rede. */
  function sessao() {
    try { var t = localStorage.getItem(CHAVE_SESSAO); return t ? JSON.parse(t) : null; }
    catch (e) { return null; }
  }
  function guardarSessao(s) {
    try {
      if (s) localStorage.setItem(CHAVE_SESSAO, JSON.stringify(s));
      else localStorage.removeItem(CHAVE_SESSAO);
    } catch (e) { /* segue */ }
  }

  function paraEmail(usuario) {
    var u = String(usuario || "").trim();
    if (u.indexOf("@") >= 0) return u.toLowerCase();
    // usuário do SistemaCMH: a mesma conversão do programa
    return semAcento(u).toLowerCase().replace(/\s+/g, "") + "@" + DOMINIO_SISTEMA;
  }

  function entrar(usuario, senha) {
    return sb.auth.signInWithPassword({email: paraEmail(usuario), password: senha})
      .then(function (r) {
        if (r.error) {
          if (/invalid|credentials/i.test(r.error.message)) {
            return {ok: false, recado: "Usuário ou senha não conferem."};
          }
          return {ok: false, recado: traduzirErro(r.error)};
        }
        return sb.rpc("homol_quem_sou").then(function (q) {
          var eu = q.data && q.data[0];
          if (q.error || !eu) {
            // entrou no Supabase, mas não é da homologação (aluno, equipe
            // sem a categoria, conta desligada): sai de novo
            return sb.auth.signOut().then(function () {
              return {ok: false, recado: q.error
                ? traduzirErro(q.error, "Não consegui conferir o seu acesso. Tente de novo.")
                : "Este acesso não está liberado para a homologação, ou foi desligado. " +
                  "Fale com a clínica pelo (71) 3493-7220."};
            });
          }
          var s = {
            id: r.data.user.id,
            tipo: eu.papel === "medico" ? "medico" : "empresa",
            nome: eu.nome, empresa: eu.empresa_nome || "", cnpj: eu.empresa_cnpj || "",
            registro: eu.registro || ""
          };
          guardarSessao(s);
          sb.rpc("homol_entrou").then(function () {}, function () {});
          return {ok: true, sessao: s};
        });
      }, function (e) { return {ok: false, recado: traduzirErro(e)}; });
  }
  function sair() {
    guardarSessao(null);
    return sb.auth.signOut().then(function () {}, function () {});
  }
  function nomeDeQuem() { var s = sessao(); return s ? s.nome : ""; }

  /* Fora da porta, sem login de verdade não há tela: se a sessão do
     Supabase acabou (ou nunca existiu neste navegador), volta para a
     porta em vez de mostrar uma lista vazia com cara de "nada lançado". */
  if (!/\/homologacao\/(index\.html)?$/.test(location.pathname)) {
    sb.auth.getSession().then(function (r) {
      if (!r.data || !r.data.session) {
        guardarSessao(null);
        location.replace("index.html");
      }
    });
  }

  /* ---------- tradução banco <-> tela ---------- */
  function daLinha(r) {
    return {
      id: String(r.id), processo: String(r.id),
      empresa: r.empresa_nome, empresaCnpj: r.empresa_cnpj,
      requisitante: r.requisitante || "", cpf: r.cpf || "",
      chapa: r.chapa || "", nome: r.nome, filial: r.filial || "",
      inicio: r.inicio, horaInicio: String(r.hora_inicio || "08:00").slice(0, 5),
      fim: r.fim, dias: r.dias,
      tipo: r.tipo, medico: r.medico, entidade: r.entidade, cid: r.cid, responsavel: r.responsavel,
      observacoes: r.observacoes || "",
      parecer: r.parecer, parecerObs: r.parecer_obs || "", parecerPor: r.parecer_por || "", parecerEm: r.parecer_em || "",
      situacao: r.situacao, atividade: r.atividade,
      abertura: r.abertura, criadoPor: r.criado_por_nome || "",
      anexos: (r.homol_anexo || []).map(anexoDaLinha),
      historico: []
    };
  }
  function anexoDaLinha(a) {
    var s = sessao();
    return {codigo: String(a.id), nome: a.nome, tipo: a.tipo, tamanho: a.tamanho,
      versao: a.versao || 1000, quem: a.quem_nome || "", quando: a.quando,
      atividade: a.atividade || "", caminho: a.caminho,
      meu: !!(s && a.quem_id && a.quem_id === s.id)};
  }
  function paraLinha(p, medico) {
    var l = {
      /* O CPF vai SÓ COM OS DÍGITOS. A máscara é da tela; no banco ele é
         chave de busca, e "123.456.789-01" e "12345678901" seriam duas
         pessoas diferentes na hora de juntar o histórico. */
      cpf: soDigitos(p.cpf) || null,
      /* A MATRÍCULA CONTINUA INDO, mesmo não sendo mais pedida: processo
         antigo tem matrícula, e gravar null aqui apagaria do registro o
         único número que aquela empresa usava quando ele foi aberto. */
      chapa: String(p.chapa || "").trim() || null,
      nome: String(p.nome || "").trim().toUpperCase(),
      filial: p.filial || null, inicio: p.inicio, hora_inicio: p.horaInicio || "08:00",
      dias: Number(p.dias) || 1, fim: p.fim || p.inicio,
      tipo: p.tipo || null, medico: p.medico || null, entidade: p.entidade || null,
      cid: p.cid || null, responsavel: p.responsavel || null,
      observacoes: p.observacoes || null
    };
    if (medico) { l.parecer = p.parecer; l.parecer_obs = p.parecerObs || null; }
    return l;
  }

  /* ---------- processos ---------- */
  var COLUNAS_LISTA = "id,empresa_cnpj,empresa_nome,requisitante,cpf,chapa,nome,filial,inicio," +
    "hora_inicio,dias,fim,tipo,medico,entidade,cid,responsavel,observacoes,parecer,parecer_obs," +
    "parecer_por,parecer_em,situacao,atividade,abertura,criado_por_nome,homol_anexo(id,nome,tipo,tamanho,caminho)";

  // Tudo, em páginas de mil: o servidor não entrega mais que isso de uma
  // vez, e a lista pararia calada no milésimo processo.
  function listarProcessos() {
    var todos = [], passo = 1000;
    function pagina(de) {
      return sb.from("homol_processo").select(COLUNAS_LISTA)
        .order("id", {ascending: false}).range(de, de + passo - 1)
        .then(function (r) {
          if (r.error) throw new Error(traduzirErro(r.error, "Não consegui carregar a lista."));
          todos = todos.concat(r.data.map(daLinha));
          return r.data.length === passo ? pagina(de + passo) : todos;
        });
    }
    return pagina(0);
  }

  function obterProcesso(id) {
    var n = Number(id);
    if (!n) return Promise.resolve(null);
    return Promise.all([
      sb.from("homol_processo").select(COLUNAS_LISTA.replace(",homol_anexo(id,nome,tipo,tamanho,caminho)", ""))
        .eq("id", n).maybeSingle(),
      sb.from("homol_evento").select("quando,quem_nome,oque,comentario")
        .eq("processo_id", n).order("quando", {ascending: true}).order("id", {ascending: true}),
      sb.from("homol_anexo").select("id,nome,tipo,tamanho,caminho,versao,quem_id,quem_nome,quando,atividade")
        .eq("processo_id", n).order("id", {ascending: true})
    ]).then(function (rs) {
      if (rs[0].error) throw new Error(traduzirErro(rs[0].error));
      if (!rs[0].data) return null;       // não existe, ou não é da empresa dele
      var p = daLinha(rs[0].data);
      p.historico = (rs[1].data || []).map(function (e) {
        return {quando: e.quando, quem: e.quem_nome || "", oque: e.oque, comentario: e.comentario};
      });
      p.anexos = (rs[2].data || []).map(anexoDaLinha);
      return p;
    });
  }

  /* As filiais que a clínica cadastrou para a empresa de quem entrou (o
     banco só devolve as dela). Lista vazia = empresa sem filial
     cadastrada, e o campo fica livre. */
  function listarFiliais() {
    return sb.from("homol_filial").select("nome").eq("ativo", true).order("nome").then(function (r) {
      if (r.error) throw new Error(traduzirErro(r.error, "Não consegui ler as filiais."));
      return r.data.map(function (f) { return f.nome; });
    });
  }

  /* O histórico do paciente: os outros atestados da MESMA pessoa na
     MESMA empresa. É o que o médico precisa para ver recorrência e a
     regra dos 60 dias.

     CASA PELO CPF, e cai na matrícula quando não há CPF. O CPF é da
     pessoa e a matrícula é do emprego: enquanto os processos antigos
     não forem corrigidos, os dois caminhos convivem, e um processo com
     CPF encontra tanto os outros com o MESMO CPF quanto os antigos que
     têm a mesma matrícula — senão o histórico de quem já estava no
     sistema recomeçaria do zero no dia em que o CPF entrou.

     SEMPRE PRESO À EMPRESA. Atestado é dado de saúde, e o RH da empresa
     B não vê o que a pessoa apresentou na empresa A — nem sendo a mesma
     pessoa, nem sendo as duas clientes da clínica. Quem vê tudo é o
     médico, e é a política do banco que decide isso; este `.eq` está
     aqui para a busca não depender só dela. */
  function historicoDoColaborador(p) {
    if (!p || !p.empresaCnpj) return Promise.resolve([]);
    var cpf = soDigitos(p.cpf), chapa = String(p.chapa || "").trim();
    if (!cpf && !chapa) return Promise.resolve([]);
    var quem = [];
    if (cpf) quem.push("cpf.eq." + cpf);
    if (chapa) quem.push("chapa.eq." + chapa);
    return sb.from("homol_processo")
      .select(COLUNAS_LISTA.replace(",homol_anexo(id,nome,tipo,tamanho,caminho)", ""))
      .eq("empresa_cnpj", p.empresaCnpj).or(quem.join(","))
      .neq("id", Number(p.id) || 0)
      .order("inicio", {ascending: false}).limit(200)
      .then(function (r) {
        if (r.error) throw new Error(traduzirErro(r.error, "Não consegui ler o histórico do colaborador."));
        return r.data.map(daLinha);
      });
  }

  function processoEmBranco() {
    var s = sessao();
    return {
      id: "", processo: "", empresa: s ? s.empresa : "", requisitante: s ? s.nome : "",
      cpf: "", chapa: "", nome: "", filial: "", inicio: "", horaInicio: "08:00", fim: "", dias: 1,
      tipo: null, medico: null, entidade: null, cid: null, responsavel: RESPONSAVEIS[0],
      observacoes: "", parecer: "Pendente", parecerObs: "", situacao: "aberto",
      atividade: "Rascunho", abertura: new Date().toISOString(), criadoPor: s ? s.nome : "",
      anexos: [], historico: []
    };
  }

  /* Gravar. O que o parecer faz com o processo (finalizar, devolver à
     empresa) é o banco que decide — ver o gatilho homol_processo_regras. */
  function salvarProcesso(p) {
    var s = sessao();
    if (!s) return Promise.resolve({ok: false, recado: "Sua sessão acabou. Entre de novo."});
    var medico = s.tipo === "medico";
    var linha = paraLinha(p, medico);

    if (p.id) {
      return sb.from("homol_processo").update(linha).eq("id", Number(p.id)).select("id").maybeSingle()
        .then(function (r) {
          if (r.error) return {ok: false, recado: traduzirErro(r.error)};
          if (!r.data) return {ok: false, recado: "Este processo não pode mais ser alterado por você " +
            "(ele já foi finalizado, ou não é da sua empresa)."};
          return obterProcesso(p.id).then(function (np) { return {ok: true, processo: np}; });
        });
    }

    // novo: grava o processo, depois sobe os arquivos que esperavam
    return sb.from("homol_processo").insert(linha).select("id").single().then(function (r) {
      if (r.error) return {ok: false, recado: traduzirErro(r.error)};
      var id = r.data.id;
      var pendentes = (p.anexos || []).filter(function (a) { return a._arquivo; });
      return pendentes.reduce(function (cadeia, a) {
        return cadeia.then(function (falhas) {
          return subir(id, a._arquivo).then(function (e) { return e ? falhas.concat(a.nome) : falhas; });
        });
      }, Promise.resolve([])).then(function (falhas) {
        return obterProcesso(id).then(function (np) {
          return {ok: true, processo: np, aviso: falhas.length
            ? "O processo foi enviado, mas não consegui anexar: " + falhas.join(", ") +
              ". Abra a aba Anexos e tente de novo." : ""};
        });
      });
    });
  }

  /* ---------- anexos ---------- */
  function nomeSeguro(n) {
    return semAcento(n).replace(/[^\w.\-]+/g, "_").replace(/_+/g, "_").slice(-80) || "arquivo";
  }
  // Sobe um arquivo e grava a ficha dele. Devolve null (deu certo) ou o erro.
  function subir(processoId, arquivo) {
    if (arquivo.size > TETO_ANEXO) return Promise.resolve("maior que 10 MB");
    var caminho = processoId + "/" + Date.now() + "-" + nomeSeguro(arquivo.name);
    return sb.storage.from(BALDE).upload(caminho, arquivo, {contentType: arquivo.type, upsert: false})
      .then(function (u) {
        if (u.error) return traduzirErro(u.error);
        return sb.from("homol_anexo").insert({
          processo_id: Number(processoId), nome: arquivo.name, tipo: arquivo.type,
          tamanho: arquivo.size, caminho: caminho
        }).then(function (r) {
          if (!r.error) return null;
          // a ficha não entrou: o arquivo solto no balde não serve a ninguém
          sb.storage.from(BALDE).remove([caminho]);
          return traduzirErro(r.error);
        });
      });
  }
  // `arquivo` é o File que a pessoa escolheu
  function anexar(id, arquivo) {
    return subir(id, arquivo).then(function (erro) {
      if (erro) return {ok: false, recado: "Não consegui anexar " + arquivo.name + ": " + erro};
      return obterProcesso(id).then(function (p) { return {ok: true, processo: p}; });
    });
  }
  function tirarAnexo(id, codigo) {
    return sb.from("homol_anexo").delete().eq("id", Number(codigo)).select("caminho").maybeSingle()
      .then(function (r) {
        if (r.error || !r.data) return {ok: false, recado: r.error ? traduzirErro(r.error)
          : "Só quem anexou pode tirar, e só enquanto o processo está aberto."};
        return sb.storage.from(BALDE).remove([r.data.caminho]).then(function () {
          return obterProcesso(id).then(function (p) { return {ok: true, processo: p}; });
        });
      });
  }
  // Ficha de um arquivo escolhido que ainda não subiu (atestado novo)
  function novoAnexo(arquivo) {
    return {codigo: "", versao: 1000, nome: arquivo.name, tipo: arquivo.type, tamanho: arquivo.size,
      quem: nomeDeQuem(), quando: "", atividade: "Início", _arquivo: arquivo, meu: true};
  }
  /* O endereço para abrir ou baixar. O balde é PRIVADO: o link vale 5
     minutos, e só é dado a quem pode ver o processo. */
  function urlAnexo(a, baixar) {
    if (a._arquivo) return Promise.resolve(URL.createObjectURL(a._arquivo));
    return sb.storage.from(BALDE).createSignedUrl(a.caminho, 300, baixar ? {download: a.nome} : undefined)
      .then(function (r) {
        if (r.error) throw new Error(traduzirErro(r.error, "Não consegui abrir o arquivo."));
        return r.data.signedUrl;
      });
  }

  /* ---------- comentários ---------- */
  function comentar(id, texto) {
    return sb.from("homol_evento").insert({processo_id: Number(id), oque: String(texto).trim(), comentario: true})
      .then(function (r) {
        if (r.error) return {ok: false, recado: traduzirErro(r.error, "Não consegui gravar o comentário.")};
        return obterProcesso(id).then(function (p) { return {ok: true, processo: p}; });
      });
  }

  /* ---------- entidades e profissionais ---------- */
  function listarTudo(tabela, colunas, ordem) {
    return sb.from(tabela).select(colunas).order(ordem).limit(5000).then(function (r) {
      if (r.error) throw new Error(traduzirErro(r.error));
      return r.data.map(function (x) { x.codigo = String(x.codigo); return x; });
    });
  }
  function listarEntidades() { return listarTudo("homol_entidade", "codigo,nome,fantasia,cnpj,cidade,uf", "nome"); }
  function listarProfissionais() { return listarTudo("homol_profissional", "codigo,nome,registro,orgao,uf,numero", "nome"); }

  function criarEntidade(e) {
    var cnpj = soDigitos(e.cnpj) || null;
    return sb.from("homol_entidade").insert({nome: e.nome, fantasia: e.fantasia || null, cnpj: cnpj,
      cidade: e.cidade || null, uf: e.uf || null}).select("codigo,nome,fantasia,cnpj,cidade,uf").single()
      .then(function (r) {
        if (!r.error) { r.data.codigo = String(r.data.codigo); return {ok: true, entidade: r.data}; }
        if (r.error.code === "23505" && cnpj) {        // já existe: devolve a que existe
          return sb.from("homol_entidade").select("codigo,nome,fantasia,cnpj,cidade,uf").eq("cnpj", cnpj).single()
            .then(function (j) {
              if (j.data) j.data.codigo = String(j.data.codigo);
              return {ok: false, recado: "Esta entidade já está cadastrada: " + (j.data ? j.data.nome : ""),
                      entidade: j.data || null};
            });
        }
        return {ok: false, recado: traduzirErro(r.error)};
      });
  }
  function criarProfissional(pr) {
    var numero = String(pr.numero || "").trim();
    var campos = {nome: pr.nome, orgao: pr.orgao, uf: pr.uf, numero: numero,
                  registro: pr.orgao + " " + pr.uf + " " + numero};
    return sb.from("homol_profissional").insert(campos).select("codigo,nome,registro,orgao,uf,numero").single()
      .then(function (r) {
        if (!r.error) { r.data.codigo = String(r.data.codigo); return {ok: true, profissional: r.data}; }
        if (r.error.code === "23505") {
          return sb.from("homol_profissional").select("codigo,nome,registro,orgao,uf,numero")
            .eq("orgao", pr.orgao).eq("uf", pr.uf).eq("numero", numero).single()
            .then(function (j) {
              if (j.data) j.data.codigo = String(j.data.codigo);
              return {ok: false, recado: "Este profissional já está cadastrado: " + (j.data ? j.data.nome : ""),
                      profissional: j.data || null};
            });
        }
        return {ok: false, recado: traduzirErro(r.error)};
      });
  }

  /* ---------- CNPJ na Receita ----------
     Duas fontes públicas e gratuitas, uma de reserva da outra. Nenhuma
     precisa de chave, e as duas aceitam chamada direto do navegador. */
  function buscarCNPJ(cnpj) {
    var n = soDigitos(cnpj);
    function brasilapi() {
      return fetch("https://brasilapi.com.br/api/cnpj/v1/" + n).then(function (r) {
        if (r.status === 404) throw {naoExiste: true};
        if (!r.ok) throw new Error("brasilapi " + r.status);
        return r.json();
      }).then(function (j) {
        return {nome: j.razao_social, fantasia: j.nome_fantasia || "", cidade: j.municipio || "",
                uf: j.uf || "", situacao: j.descricao_situacao_cadastral || ""};
      });
    }
    function cnpjws() {
      return fetch("https://publica.cnpj.ws/cnpj/" + n).then(function (r) {
        if (r.status === 404) throw {naoExiste: true};
        if (!r.ok) throw new Error("cnpj.ws " + r.status);
        return r.json();
      }).then(function (j) {
        var est = j.estabelecimento || {};
        return {nome: j.razao_social, fantasia: est.nome_fantasia || "",
                cidade: (est.cidade && est.cidade.nome) || "", uf: (est.estado && est.estado.sigla) || "",
                situacao: est.situacao_cadastral || ""};
      });
    }
    return brasilapi().catch(function (e) {
      if (e && e.naoExiste) throw e;
      return cnpjws();
    });
  }

  /* ---------- CID-10 (DATASUS, completa) ----------
     Só é baixada quando alguém abre a busca de CID: é 1 MB, e a maioria
     das visitas não precisa dela. */
  var cidPromessa = null;
  function listarCID() {
    if (!cidPromessa) {
      cidPromessa = fetch("cid10.json").then(function (r) { return r.json(); })
        .then(function (j) { return j.cid.map(function (c) { return {codigo: c[0], nome: c[1]}; }); })
        .catch(function (e) { cidPromessa = null; throw e; });
    }
    return cidPromessa;
  }

  window.Homologacao = {
    TIPOS: TIPOS, RESPONSAVEIS: RESPONSAVEIS, ORGAOS: ORGAOS, UFS: UFS, TETO_ANEXO: TETO_ANEXO,
    sessao: sessao, entrar: entrar, sair: sair, nomeDeQuem: nomeDeQuem,
    listarProcessos: listarProcessos, obterProcesso: obterProcesso,
    historicoDoColaborador: historicoDoColaborador, listarFiliais: listarFiliais,
    processoEmBranco: processoEmBranco, salvarProcesso: salvarProcesso,
    comentar: comentar, anexar: anexar, tirarAnexo: tirarAnexo, novoAnexo: novoAnexo, urlAnexo: urlAnexo,
    listarEntidades: listarEntidades, criarEntidade: criarEntidade,
    listarProfissionais: listarProfissionais, criarProfissional: criarProfissional,
    buscarCNPJ: buscarCNPJ, listarCID: listarCID, soDigitos: soDigitos,
    cpfValido: cpfValido, cpfBonito: cpfBonito
  };
})();
