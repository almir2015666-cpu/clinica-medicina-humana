/* =====================================================================
   HOMOLOGAÇÃO DE ATESTADOS — os dados

   Um arquivo só, usado pelas três telas (porta, lista e ficha do
   processo). HOJE É DEMONSTRAÇÃO: tudo mora no navegador de quem está
   testando (localStorage). Isso já deixa o caminho inteiro funcionar —
   a empresa lança, o Dr. Everaldo dá o parecer, a empresa vê o
   resultado — desde que as duas pessoas usem o MESMO navegador.

   QUANDO O SERVIDOR EXISTIR, SÓ ESTE ARQUIVO MUDA. Cada função daqui
   vira uma chamada ao Supabase (tabelas + login de verdade); as telas
   não sabem, nem precisam saber, de onde os dados vêm. Por isso todas
   as funções já devolvem Promise, mesmo sem precisar hoje.
   ===================================================================== */
(function () {
  "use strict";

  var CHAVE = "cmh_homologacao_demo_v2";
  var CHAVE_SESSAO = "cmh_homologacao_sessao_v1";

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

  // Quem homologa. O CRM é o que a clínica já usa para assinar ASO
  // (Orcamentos/pcmso_textos.py, lista EXAMINADORES).
  var RESPONSAVEIS = [
    {codigo: "6276", nome: "DR. EVERALDO BARBOSA RIBEIRO FILHO",
     registro: "CRM-BA 6276", funcao: "Médico do trabalho — homologação"}
  ];

  var ORGAOS = ["CRM", "CRO", "CRP", "COREN", "CREFITO", "CRFa", "CRN", "CRF", "CRBM"];
  var UFS = ["AC","AL","AM","AP","BA","CE","DF","ES","GO","MA","MG","MS","MT","PA","PB",
             "PE","PI","PR","RJ","RN","RO","RR","RS","SC","SE","SP","TO"];

  /* ---------- as contas de demonstração ----------
     A senha NÃO fica conferida aqui quando o servidor existir: quem
     confere é o Supabase Auth. Estas duas contas só existem para a
     demonstração poder ser vista pelos dois lados. */
  var CONTAS_DEMO = {
    "empresa":  {tipo: "empresa", nome: "RH — Empresa de exemplo", empresa: "EMPRESA DE EXEMPLO LTDA"},
    "everaldo": {tipo: "medico",  nome: "Dr. Everaldo Barbosa Ribeiro Filho", registro: "CRM-BA 6276"}
  };

  /* ---------- guardar e ler ---------- */
  var memoria = null;            // se o navegador não deixar guardar nada
  function ler() {
    if (memoria) return memoria;
    try {
      var t = localStorage.getItem(CHAVE);
      if (t) { memoria = JSON.parse(t); return memoria; }
    } catch (e) { /* segue com a semente */ }
    memoria = semente();
    gravar();
    return memoria;
  }
  function gravar() {
    try { localStorage.setItem(CHAVE, JSON.stringify(memoria)); return true; }
    catch (e) { return false; }   // cheio (anexo grande) ou bloqueado
  }
  function copia(o) { return JSON.parse(JSON.stringify(o)); }
  function agora() { return new Date().toISOString(); }
  function dois(n) { return (n < 10 ? "0" : "") + n; }
  function iso(d) { return d.getFullYear() + "-" + dois(d.getMonth() + 1) + "-" + dois(d.getDate()); }

  /* ---------- a semente: exemplo, repetível ---------- */
  function semente() {
    var s = 20260101;
    function sorte(teto) {
      s = (s * 9301 + 49297) % 233280;
      return Math.floor(s / 233280 * teto);
    }
    var primeiros = ["Ana Carolina","Jefferson","Fernanda","Daniela","Laíza","Marcelo",
      "Vagner","Tatiane","Ednaldo","Kemelly","Terezinha","Antônio Carlos","Djanir",
      "Joanderson","Erick","Simone","Rafael","Patrícia","Gilberto","Luciana","Everton",
      "Márcia","Wesley","Juliana","Rodrigo","Adriana","Fábio","Camila"];
    var sobrenomes = ["dos Santos","de Souza","Oliveira","da Silva","Pereira","Bispo",
      "Conceição","Nascimento","Ferreira","Almeida","Rodrigues","Carvalho","Barbosa",
      "Lima","Araújo","Machado","Teixeira","Moreira"];
    var requisitantes = ["Ana Carolina Bispo","Jefferson Rodrigues","Fernanda Lescaut",
      "Daniela Nascimento","Laíza Roberto","Marcos Vinícius Lima"];
    var abertas = ["Clínica avalia atestado","Clínica avalia atestado","Aguardando documento"];
    var filiais = ["Matriz — Camaçari","Filial Polo","Filial Candeias","Filial Salvador"];
    var empresas = ["EMPRESA DE EXEMPLO LTDA","EMPRESA DE EXEMPLO LTDA",
                    "INDÚSTRIA MODELO S.A.","CONSTRUTORA EXEMPLAR LTDA"];

    var entidades = [
      {codigo: "00001", nome: "HOSPITAL DE EXEMPLO", cnpj: "", fantasia: "HOSPITAL DE EXEMPLO"},
      {codigo: "00002", nome: "CLÍNICA MODELO DE SAÚDE", cnpj: "", fantasia: "CLÍNICA MODELO"},
      {codigo: "00003", nome: "UPA DE EXEMPLO", cnpj: "", fantasia: "UPA DE EXEMPLO"},
      {codigo: "00004", nome: "CENTRO ODONTOLÓGICO EXEMPLO", cnpj: "", fantasia: "ODONTO EXEMPLO"}
    ];
    var profissionais = [
      {codigo: "1", nome: "MÉDICO DE EXEMPLO UM", registro: "CRM 10001", orgao: "CRM", uf: "BA"},
      {codigo: "2", nome: "MÉDICA DE EXEMPLO DOIS", registro: "CRM 10002", orgao: "CRM", uf: "BA"},
      {codigo: "3", nome: "DENTISTA DE EXEMPLO", registro: "CRO 20003", orgao: "CRO", uf: "BA"},
      {codigo: "4", nome: "MÉDICO DE EXEMPLO QUATRO", registro: "CRM 10004", orgao: "CRM", uf: "RJ"}
    ];
    var cids = [["J11","Influenza [gripe] devida a vírus não identificado"],
      ["M54.5","Dor lombar baixa"],["A09","Diarréia e gastroenterite de origem infecciosa presumível"],
      ["K08.8","Outros transtornos especificados dos dentes e das estruturas de sustentação"],
      ["S93.4","Entorse e distensão do tornozelo"],["J03.9","Amigdalite aguda não especificada"]];

    var processos = [];
    for (var i = 0; i < 186; i++) {
      var dias = [1,2,3,3,5,7,10,14,15,20,30][sorte(11)];
      var d = new Date(2025, 7 + sorte(14), 1 + sorte(28));
      var fim = new Date(d.getTime() + (dias - 1) * 86400000);
      var finalizado = sorte(10) < 6;
      var aprovado = sorte(10) < 8;
      var tipo = TIPOS[dias > 15 ? 7 : 3];
      var completo = finalizado || sorte(3) > 0;
      var numero = String(720000 + sorte(160000));
      var abertura = new Date(d.getTime() + (1 + sorte(3)) * 86400000 + 8 * 3600000);
      var p = {
        id: numero, processo: numero,
        empresa: empresas[sorte(empresas.length)],
        requisitante: requisitantes[sorte(requisitantes.length)],
        chapa: "00010" + String(10000 + sorte(9000)),
        nome: (primeiros[sorte(primeiros.length)] + " " + sobrenomes[sorte(sobrenomes.length)] +
               " " + sobrenomes[sorte(sobrenomes.length)]).toUpperCase(),
        filial: filiais[sorte(filiais.length)],
        inicio: iso(d), horaInicio: "08:00", fim: iso(fim), dias: dias,
        tipo: tipo,
        medico: completo ? profissionais[sorte(profissionais.length)] : null,
        entidade: completo ? entidades[sorte(entidades.length)] : null,
        cid: null,
        responsavel: RESPONSAVEIS[0],
        observacoes: "",
        parecer: finalizado ? (aprovado ? "Aprovado" : "Reprovado") : "Pendente",
        parecerObs: finalizado && !aprovado ? "Atestado sem assinatura legível do profissional." : "",
        situacao: finalizado ? "finalizado" : "aberto",
        atividade: finalizado ? (aprovado ? "Homologado" : "Não homologado") : abertas[sorte(abertas.length)],
        abertura: abertura.toISOString(),
        criadoPor: requisitantes[sorte(requisitantes.length)],
        anexos: [],
        historico: []
      };
      p.cid = completo ? (function () { var c = cids[sorte(cids.length)]; return {codigo: c[0], nome: c[1]}; })() : null;
      p.historico.push({quando: p.abertura, quem: p.criadoPor, oque: "Processo aberto e enviado à clínica"});
      if (finalizado) {
        p.historico.push({quando: new Date(abertura.getTime() + 26 * 3600000).toISOString(),
          quem: "Dr. Everaldo Barbosa Ribeiro Filho",
          oque: "Parecer: " + p.parecer + (p.parecerObs ? " — " + p.parecerObs : "")});
      }
      processos.push(p);
    }
    /* Dois casos montados de propósito, para os alertas do relatório
       aparecerem na demonstração: a mesma dor lombar três vezes em 50
       dias (regra dos 60 dias do INSS) e alguém com atestados curtos
       repetidos (recorrência). */
    var hoje = new Date(); hoje.setHours(0, 0, 0, 0);
    function antes(dias) { return iso(new Date(hoje.getTime() - dias * 86400000)); }
    [["0001019001", "JOSÉ CARLOS DE JESUS SANTOS", "Filial Polo", [[70, 6, "M54.5"], [45, 5, "M54.2"], [22, 7, "M54.5"]]],
     ["0001019002", "PRISCILA ALVES NUNES", "Matriz — Camaçari", [[80, 1, "J11"], [52, 2, "A09"], [31, 1, "J03.9"], [10, 1, "J11"]]]
    ].forEach(function (c, ci) {
      c[3].forEach(function (a, ai) {
        var ini = antes(a[0]), fim = iso(new Date(new Date(ini + "T00:00:00").getTime() + (a[1] - 1) * 86400000));
        var n = String(900100 + ci * 10 + ai);
        var cidNome = {"M54.5": "Dor lombar baixa", "M54.2": "Cervicalgia", "J11": cids[0][1],
                       "A09": cids[2][1], "J03.9": cids[5][1]}[a[2]];
        var ab = new Date(new Date(ini + "T08:00:00").getTime() + 86400000).toISOString();
        processos.push({id: n, processo: n, empresa: "EMPRESA DE EXEMPLO LTDA", requisitante: "Ana Carolina Bispo",
          chapa: c[0], nome: c[1], filial: c[2], inicio: ini, horaInicio: "08:00", fim: fim, dias: a[1],
          tipo: TIPOS[3], medico: profissionais[ai % 2], entidade: entidades[ai % 3], cid: {codigo: a[2], nome: cidNome},
          responsavel: RESPONSAVEIS[0], observacoes: "", parecer: "Aprovado", parecerObs: "",
          situacao: "finalizado", atividade: "Homologado", abertura: ab, criadoPor: "Ana Carolina Bispo", anexos: [],
          historico: [{quando: ab, quem: "Ana Carolina Bispo", oque: "Processo aberto e enviado à clínica"},
                      {quando: ab, quem: "Dr. Everaldo Barbosa Ribeiro Filho", oque: "Parecer: Aprovado"}]});
      });
    });
    return {processos: processos, entidades: entidades, profissionais: profissionais};
  }

  /* ---------- sessão ---------- */
  function sessao() {
    try { var t = sessionStorage.getItem(CHAVE_SESSAO); return t ? JSON.parse(t) : null; }
    catch (e) { return null; }
  }
  function entrar(usuario, senha) {
    var u = String(usuario || "").trim().toLowerCase();
    var conta = CONTAS_DEMO[u];
    if (!conta || senha !== "demo") {
      return Promise.resolve({ok: false});
    }
    try { sessionStorage.setItem(CHAVE_SESSAO, JSON.stringify(conta)); } catch (e) { /* segue */ }
    return Promise.resolve({ok: true, sessao: conta});
  }
  function sair() {
    try { sessionStorage.removeItem(CHAVE_SESSAO); } catch (e) { /* segue */ }
  }
  function nomeDeQuem() { var s = sessao(); return s ? s.nome : "—"; }

  /* ---------- processos ----------
     A EMPRESA SÓ VÊ OS DELA; o médico vê todos. No servidor, essa regra
     mora no banco (RLS), e não aqui — aqui é só para a demonstração se
     comportar igual. */
  function podeVer(p) {
    var s = sessao();
    if (!s) return false;
    return s.tipo === "medico" || p.empresa === s.empresa;
  }
  function listarProcessos() {
    return Promise.resolve(copia(ler().processos.filter(podeVer)));
  }
  function obterProcesso(id) {
    var p = ler().processos.filter(function (x) { return x.id === String(id); })[0];
    return Promise.resolve(p && podeVer(p) ? copia(p) : null);
  }
  function novoNumero() {
    var maior = 0;
    ler().processos.forEach(function (p) { maior = Math.max(maior, Number(p.processo) || 0); });
    return String(maior + 1);
  }
  function processoEmBranco() {
    var s = sessao();
    var n = novoNumero();
    return {
      id: "", processo: n, empresa: s ? s.empresa : "", requisitante: s ? s.nome : "",
      chapa: "", nome: "", filial: "", inicio: "", horaInicio: "08:00", fim: "", dias: 1,
      tipo: null, medico: null, entidade: null, cid: null, responsavel: RESPONSAVEIS[0],
      observacoes: "", parecer: "Pendente", parecerObs: "", situacao: "aberto",
      atividade: "Rascunho", abertura: agora(), criadoPor: s ? s.nome : "", anexos: [], historico: []
    };
  }

  /* Gravar: a empresa envia; o médico dá o parecer.
     O QUE O PARECER FAZ, AUTOMATICAMENTE:
       Aprovado  -> finalizado, "Homologado"
       Reprovado -> finalizado, "Não homologado"
       Pendente  -> continua aberto, "Aguardando documento" (a empresa
                    vê o recado do médico e completa) */
  function salvarProcesso(p) {
    var s = sessao();
    if (!s) return Promise.resolve({ok: false, recado: "Sua sessão acabou. Entre de novo."});
    var banco = ler();
    var antes = banco.processos.filter(function (x) { return x.id === p.id; })[0];
    var novo = copia(p);
    var quem = s.nome;
    // anexos que esperavam o envio ganham data agora
    (novo.anexos || []).forEach(function (a) { if (!a.quando) { a.quando = agora(); a.quem = quem; } });

    if (s.tipo === "medico") {
      if (novo.parecer === "Aprovado") { novo.situacao = "finalizado"; novo.atividade = "Homologado"; }
      else if (novo.parecer === "Reprovado") { novo.situacao = "finalizado"; novo.atividade = "Não homologado"; }
      else { novo.situacao = "aberto"; novo.atividade = "Aguardando documento"; }
      novo.historico.push({quando: agora(), quem: quem,
        oque: "Parecer: " + novo.parecer + (novo.parecerObs ? " — " + novo.parecerObs : "")});
    } else {
      // a empresa não mexe no parecer, nem por engano
      if (antes) { novo.parecer = antes.parecer; novo.parecerObs = antes.parecerObs; }
      novo.situacao = "aberto";
      novo.atividade = "Clínica avalia atestado";
      novo.historico.push({quando: agora(), quem: quem,
        oque: antes ? "Processo corrigido e reenviado à clínica" : "Processo aberto e enviado à clínica"});
    }

    if (antes) {
      banco.processos[banco.processos.indexOf(antes)] = novo;
    } else {
      novo.id = novo.processo;
      banco.processos.unshift(novo);
    }
    if (!gravar()) {
      return Promise.resolve({ok: false, recado: "O navegador não deixou guardar — " +
        "provavelmente o anexo é grande demais para a demonstração. Tente um arquivo menor."});
    }
    return Promise.resolve({ok: true, processo: copia(novo)});
  }

  /* ---------- comentários e anexos: gravam NA HORA ----------
     Não esperam o "Enviar" nem mudam a situação do processo — como no
     sistema de origem. Cada um deixa uma linha no histórico. */
  function acharParaMexer(id) {
    var p = ler().processos.filter(function (x) { return x.id === String(id); })[0];
    return p && podeVer(p) ? p : null;
  }
  function comentar(id, texto) {
    var p = acharParaMexer(id), s = sessao();
    if (!p || !s) return Promise.resolve({ok: false, recado: "Não foi possível comentar."});
    p.historico.push({quando: agora(), quem: s.nome, oque: String(texto).trim(), comentario: true});
    if (!gravar()) return Promise.resolve({ok: false, recado: "O navegador não deixou guardar."});
    return Promise.resolve({ok: true, processo: copia(p)});
  }
  function anexar(id, arquivo) {
    var p = acharParaMexer(id), s = sessao();
    if (!p || !s) return Promise.resolve({ok: false, recado: "Não foi possível anexar."});
    var a = novoAnexo(arquivo, p.atividade);
    p.anexos.push(a);
    p.historico.push({quando: a.quando, quem: s.nome, oque: "Anexou o arquivo " + a.nome});
    if (!gravar()) {
      p.anexos.pop(); p.historico.pop();
      return Promise.resolve({ok: false, recado: "Não coube — na demonstração o navegador guarda pouco. Tente um arquivo menor."});
    }
    return Promise.resolve({ok: true, processo: copia(p)});
  }
  function tirarAnexo(id, codigo) {
    var p = acharParaMexer(id), s = sessao();
    if (!p || !s) return Promise.resolve({ok: false});
    var a = p.anexos.filter(function (x) { return x.codigo === codigo; })[0];
    if (!a) return Promise.resolve({ok: false});
    p.anexos.splice(p.anexos.indexOf(a), 1);
    p.historico.push({quando: agora(), quem: s.nome, oque: "Tirou o arquivo " + a.nome});
    gravar();
    return Promise.resolve({ok: true, processo: copia(p)});
  }
  var seqAnexo = 0;
  function novoAnexo(arquivo, atividade) {
    var s = sessao();
    return {codigo: String(Date.now()).slice(-7) + (seqAnexo++ % 10), versao: 1000,
      nome: arquivo.nome, tipo: arquivo.tipo, tamanho: arquivo.tamanho, dados: arquivo.dados,
      quem: s ? s.nome : "", quando: agora(), atividade: atividade || "Início"};
  }

  /* ---------- entidades e profissionais ---------- */
  function listarEntidades() { return Promise.resolve(copia(ler().entidades)); }
  function listarProfissionais() { return Promise.resolve(copia(ler().profissionais)); }
  function proximoCodigo(lista, largura) {
    var maior = 0;
    lista.forEach(function (x) { maior = Math.max(maior, Number(x.codigo) || 0); });
    var c = String(maior + 1);
    while (c.length < largura) c = "0" + c;
    return c;
  }
  function soDigitos(t) { return String(t || "").replace(/\D/g, ""); }

  function criarEntidade(e) {
    var banco = ler();
    var cnpj = soDigitos(e.cnpj);
    if (cnpj) {
      var ja = banco.entidades.filter(function (x) { return soDigitos(x.cnpj) === cnpj; })[0];
      if (ja) return Promise.resolve({ok: false, recado: "Esta entidade já está cadastrada: " + ja.nome, entidade: copia(ja)});
    }
    var nova = {codigo: proximoCodigo(banco.entidades, 5), nome: String(e.nome).toUpperCase(),
      fantasia: String(e.fantasia || "").toUpperCase(), cnpj: cnpj,
      cidade: e.cidade || "", uf: e.uf || ""};
    banco.entidades.push(nova);
    gravar();
    return Promise.resolve({ok: true, entidade: copia(nova)});
  }
  function criarProfissional(pr) {
    var banco = ler();
    var numero = String(pr.numero || "").trim();
    var registro = pr.orgao + " " + pr.uf + " " + numero;
    var ja = banco.profissionais.filter(function (x) {
      return x.orgao === pr.orgao && x.uf === pr.uf && soDigitos(x.registro) === soDigitos(numero);
    })[0];
    if (ja) return Promise.resolve({ok: false, recado: "Este profissional já está cadastrado: " + ja.nome, profissional: copia(ja)});
    var novo = {codigo: proximoCodigo(banco.profissionais, 1), nome: String(pr.nome).toUpperCase(),
      registro: registro, orgao: pr.orgao, uf: pr.uf};
    banco.profissionais.push(novo);
    gravar();
    return Promise.resolve({ok: true, profissional: copia(novo)});
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

  function zerarDemonstracao() {
    try { localStorage.removeItem(CHAVE); } catch (e) { /* segue */ }
    memoria = null;
  }

  window.Homologacao = {
    TIPOS: TIPOS, RESPONSAVEIS: RESPONSAVEIS, ORGAOS: ORGAOS, UFS: UFS,
    sessao: sessao, entrar: entrar, sair: sair, nomeDeQuem: nomeDeQuem,
    listarProcessos: listarProcessos, obterProcesso: obterProcesso,
    processoEmBranco: processoEmBranco, salvarProcesso: salvarProcesso,
    comentar: comentar, anexar: anexar, tirarAnexo: tirarAnexo, novoAnexo: novoAnexo,
    listarEntidades: listarEntidades, criarEntidade: criarEntidade,
    listarProfissionais: listarProfissionais, criarProfissional: criarProfissional,
    buscarCNPJ: buscarCNPJ, listarCID: listarCID, soDigitos: soDigitos,
    zerarDemonstracao: zerarDemonstracao
  };
})();
