/* =====================================================================
   HOMOLOGAÇÃO DE ATESTADOS — a barra lateral (a "casca" das telas)

   Uma só, usada pela lista, pela ficha e pelos relatórios: quem entra
   vê sempre as mesmas divisões, no mesmo lugar, e sabe onde está.

   AS DIVISÕES DEPENDEM DE QUEM ENTROU, porque o trabalho é outro:
     RH da empresa  -> Processos (em aberto, finalizados, novo atestado)
                       e Relatórios
     Dr. Everaldo   -> Avaliação (para aprovar, já avaliados). Relatório
                       de empresa não é assunto dele, e não aparece.

   Cada página diz quem ela é em <body data-pagina="...">; a lista diz
   também a aba, pelo endereço (painel.html?aba=finalizado), para o item
   certo ficar marcado e o link poder ser guardado nos favoritos.
   ===================================================================== */
(function () {
  "use strict";
  var H = window.Homologacao;
  var S = H && H.sessao();
  if (!S) return;                         // a página já está voltando para a porta
  var MEDICO = S.tipo === "medico";

  var CSS = [
    "body.com-lateral{display:grid!important;grid-template-columns:252px minmax(0,1fr);min-height:100vh}",
    ".lateral{position:sticky;top:0;height:100vh;display:flex;flex-direction:column;gap:1.1rem;",
    "  background:linear-gradient(180deg,#0a2e5c 0%,#0b4a8a 100%);color:#fff;padding:1.1rem .9rem 1rem;",
    "  overflow-y:auto;z-index:60}",
    ".lateral__marca{display:flex;align-items:center;gap:.6rem;text-decoration:none;color:#fff;padding:.2rem .4rem}",
    ".lateral__marca img{height:34px;filter:brightness(0) invert(1)}",
    ".lateral__marca span{font:600 .95rem/1.2 'Poppins',sans-serif}",
    ".lateral__marca small{display:block;font:400 .72rem 'Inter',sans-serif;opacity:.75}",
    ".lateral__grupo{display:flex;flex-direction:column;gap:.15rem}",
    ".lateral__titulo{font:600 .68rem 'Poppins',sans-serif;letter-spacing:.1em;text-transform:uppercase;",
    "  color:rgba(255,255,255,.55);padding:0 .6rem .3rem}",
    ".lateral a.item,.lateral button.item{display:flex;align-items:center;gap:.65rem;width:100%;border:none;",
    "  background:none;color:rgba(255,255,255,.86);text-decoration:none;cursor:pointer;text-align:left;",
    "  font:500 .92rem 'Inter',sans-serif;padding:.62rem .7rem;border-radius:10px;transition:background .15s,color .15s}",
    ".lateral .item:hover{background:rgba(255,255,255,.1);color:#fff}",
    ".lateral .item.on{background:#fff;color:#0a2e5c;font-weight:600}",
    ".lateral .item.on svg{color:#1290e0}",
    ".lateral .item svg{flex:0 0 auto;opacity:.95}",
    ".lateral .item--novo{background:rgba(111,205,245,.16);color:#fff;font-weight:600}",
    ".lateral .item--novo:hover{background:rgba(111,205,245,.28)}",
    ".lateral__pe{margin-top:auto;border-top:1px solid rgba(255,255,255,.14);padding-top:.9rem;",
    "  display:flex;flex-direction:column;gap:.5rem}",
    ".lateral__quem{display:flex;align-items:center;gap:.6rem;padding:0 .4rem}",
    ".lateral__avatar{flex:0 0 36px;height:36px;border-radius:50%;background:rgba(255,255,255,.16);",
    "  display:grid;place-items:center;font:600 .82rem 'Poppins',sans-serif}",
    ".lateral__quem b{display:block;font:600 .86rem 'Inter',sans-serif;line-height:1.25}",
    ".lateral__quem small{display:block;font-size:.74rem;opacity:.7;line-height:1.3}",
    ".casca-principal{min-width:0;display:flex;flex-direction:column;min-height:100vh}",
    ".casca-barra,.casca-fundo{display:none}",
    // a lista, a ficha e os relatórios são a coluna 2; nada mais entra na grade
    ".casca-principal{grid-column:2;grid-row:1}",
    ".lateral{grid-column:1;grid-row:1}",
    "@media(max-width:900px){",
    "  body.com-lateral{grid-template-columns:1fr}",
    "  .casca-principal{grid-column:1}",
    "  .lateral{position:fixed;left:0;top:0;bottom:0;width:272px;transform:translateX(-100%);",
    "    transition:transform .22s;box-shadow:0 0 40px rgba(0,0,0,.3)}",
    "  body.lateral-aberta .lateral{transform:none}",
    "  .casca-fundo{display:none;position:fixed;inset:0;background:rgba(10,30,55,.45);z-index:55}",
    "  body.lateral-aberta .casca-fundo{display:block}",
    "  .casca-barra{display:flex;align-items:center;gap:.7rem;position:sticky;top:0;z-index:50;",
    "    background:#0a2e5c;color:#fff;padding:.6rem .8rem}",
    "  .casca-barra button{border:none;background:rgba(255,255,255,.14);color:#fff;border-radius:9px;",
    "    width:40px;height:40px;display:grid;place-items:center;cursor:pointer}",
    "  .casca-barra span{font:600 .95rem 'Poppins',sans-serif}",
    "}",
    "@media print{.lateral,.casca-barra{display:none!important}body.com-lateral{display:block!important}}"
  ].join("\n");

  var ICO = {
    fila: '<path d="M4 6h16M4 12h16M4 18h10"/>',
    feito: '<path d="M20 6 9 17l-5-5"/>',
    mais: '<path d="M12 5v14M5 12h14"/>',
    grafico: '<path d="M4 20V10M10 20V4M16 20v-7M22 20H2"/>',
    busca: '<circle cx="11" cy="11" r="7"/><path d="m20 20-3.2-3.2"/>',
    sair: '<path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><path d="m16 17 5-5-5-5"/><path d="M21 12H9"/>',
    ajuda: '<circle cx="12" cy="12" r="10"/><path d="M9.1 9a3 3 0 1 1 4.2 2.7c-.8.4-1.3 1-1.3 1.9"/><path d="M12 17h.01"/>',
    menu: '<path d="M4 6h16M4 12h16M4 18h16"/>'
  };
  function ico(n) {
    return '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" ' +
      'stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">' + ICO[n] + "</svg>";
  }

  var pagina = document.body.getAttribute("data-pagina") || "";
  var aba = new URLSearchParams(location.search).get("aba") || "aberto";
  var novo = /[?&]novo=1/.test(location.search);

  var grupos = MEDICO ? [
    {titulo: "Avaliação", itens: [
      {id: "aberto", rot: "Para aprovar", href: "painel.html?aba=aberto", ico: "fila"},
      {id: "finalizado", rot: "Já avaliados", href: "painel.html?aba=finalizado", ico: "busca"}
    ]}
  ] : [
    {titulo: "Processos", itens: [
      {id: "novo", rot: "Novo atestado", href: "processo.html?novo=1", ico: "mais", cls: "item--novo"},
      {id: "aberto", rot: "Em aberto", href: "painel.html?aba=aberto", ico: "fila"},
      {id: "finalizado", rot: "Finalizados", href: "painel.html?aba=finalizado", ico: "feito"}
    ]},
    {titulo: "Análises", itens: [
      {id: "relatorios", rot: "Relatórios", href: "relatorios.html", ico: "grafico"}
    ]}
  ];

  function ativo(id) {
    if (pagina === "relatorios") return id === "relatorios";
    if (pagina === "processo") return novo && id === "novo";
    if (pagina === "painel") return id === aba;
    return false;
  }
  function esc(t) { return String(t || "").replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;"); }
  function iniciais(n) {
    var p = String(n || "?").replace(/^(dr|dra)\.?\s+/i, "").split(/\s+/).filter(Boolean);
    return ((p[0] || "?").charAt(0) + (p.length > 1 ? p[p.length - 1].charAt(0) : "")).toUpperCase();
  }

  var estilo = document.createElement("style");
  estilo.textContent = CSS;
  document.head.appendChild(estilo);

  var lateral = document.createElement("aside");
  lateral.className = "lateral";
  lateral.setAttribute("aria-label", "Menu");
  lateral.innerHTML =
    '<a class="lateral__marca" href="painel.html"><img src="../assets/logo.png" alt="" onerror="this.style.display=\'none\'" />' +
    "<span>Homologação<small>de atestados</small></span></a>" +
    grupos.map(function (g) {
      return '<nav class="lateral__grupo"><div class="lateral__titulo">' + g.titulo + "</div>" +
        g.itens.map(function (i) {
          return '<a class="item ' + (i.cls || "") + (ativo(i.id) ? " on" : "") + '" data-item="' + i.id + '" href="' +
            i.href + '"' + (ativo(i.id) ? ' aria-current="page"' : "") + ">" + ico(i.ico) + "<span>" + i.rot + "</span></a>";
        }).join("") + "</nav>";
    }).join("") +
    '<div class="lateral__pe">' +
    '<div class="lateral__quem"><div class="lateral__avatar">' + esc(iniciais(S.nome)) + "</div><div><b>" + esc(S.nome) +
    "</b><small>" + esc(MEDICO ? (S.registro || "Diretor médico") : S.empresa) + "</small></div></div>" +
    '<button class="item" type="button" id="cascaSair">' + ico("sair") + "<span>Sair</span></button></div>";

  var fundo = document.createElement("div");
  fundo.className = "casca-fundo";
  var barra = document.createElement("div");
  barra.className = "casca-barra";
  barra.innerHTML = '<button type="button" aria-label="Abrir o menu">' + ico("menu") + "</button><span>" +
    (MEDICO ? "Avaliação de atestados" : "Homologação de atestados") + "</span>";

  // tudo o que a página já tinha vai para a coluna da direita
  var principal = document.createElement("div");
  principal.className = "casca-principal";
  while (document.body.firstChild) principal.appendChild(document.body.firstChild);
  principal.insertBefore(barra, principal.firstChild);
  document.body.appendChild(lateral);
  document.body.appendChild(fundo);
  document.body.appendChild(principal);
  document.body.classList.add("com-lateral");

  barra.querySelector("button").addEventListener("click", function () { document.body.classList.add("lateral-aberta"); });
  fundo.addEventListener("click", function () { document.body.classList.remove("lateral-aberta"); });
  document.getElementById("cascaSair").addEventListener("click", function () {
    H.sair().then(function () { location.href = "index.html"; });
  });

  // a lista troca de aba sem recarregar: ela avisa aqui para o item certo ficar marcado
  window.Casca = {
    marcar: function (id) {
      Array.prototype.forEach.call(lateral.querySelectorAll(".item[data-item]"), function (a) {
        var on = a.getAttribute("data-item") === id;
        a.classList.toggle("on", on);
        if (on) a.setAttribute("aria-current", "page"); else a.removeAttribute("aria-current");
      });
    }
  };
})();
