/* =====================================================================
   Português / English — a troca de idioma do site

   COMO FUNCIONA, E POR QUE ASSIM
   ------------------------------
   O site é estático, hospedado no GitHub Pages, com 35 páginas. Manter
   uma cópia inglesa de cada uma seria manter DOIS sites: toda correção de
   telefone, preço ou texto teria de ser feita duas vezes, e um dia as
   duas versões divergem — sempre divergem.

   Então a página continua sendo uma só, em português, e a troca acontece
   no navegador: percorremos os nós de texto e trocamos cada um pelo
   equivalente do dicionário.

   POR QUE NÓ DE TEXTO, E NÃO FRASE INTEIRA
   "Agende sua <b>consulta</b>" parece uma frase, mas no DOM são dois nós:
   "Agende sua " e "consulta". O dicionário é gerado a partir dos MESMOS
   nós que este código percorre, então chave e busca falam a mesma língua.

   O QUE ISTO NÃO FAZ
   O Google indexa só a versão portuguesa: para o buscador, a página é a
   que veio do servidor. Quem precisa de SEO em inglês precisa de páginas
   separadas em /en/. Isto aqui atende o visitante, não o buscador.
   ===================================================================== */
(function () {
  'use strict';

  var CHAVE = 'cmh-idioma';
  var IDIOMAS = { pt: 'Português', en: 'English' };

  // localStorage falha em janela anônima de alguns navegadores, e uma
  // exceção aqui deixaria a página inteira sem JavaScript.
  function lembrado() {
    try { return localStorage.getItem(CHAVE); } catch (e) { return null; }
  }
  function lembrar(v) {
    try { localStorage.setItem(CHAVE, v); } catch (e) { /* paciência */ }
  }

  var atual = lembrado() === 'en' ? 'en' : 'pt';
  var DIC = window.CMH_EN || {};

  // O DICIONÁRIO SÓ DESCE QUANDO ALGUÉM PEDE INGLÊS.
  // São 103 KB. Carregá-lo em toda página faria a esmagadora maioria dos
  // visitantes — que lê em português — pagar por um arquivo que nunca vai
  // usar, em cada página, muitas vezes num 4G de canteiro de obra.
  // `document.currentScript` só vale enquanto este arquivo está sendo
  // avaliado; dentro de uma função, mais tarde, ele já é null. Por isso o
  // endereço é guardado agora — é dele que sai o caminho do dicionário,
  // que assim funciona tanto na raiz quanto em /treinamento/.
  var EU = (document.currentScript && document.currentScript.src) || 'js/idioma.js';

  var carregando = null;
  function carregarDicionario() {
    if (window.CMH_EN) { DIC = window.CMH_EN; return Promise.resolve(); }
    if (carregando) return carregando;
    carregando = new Promise(function (pronto) {
      var s = document.createElement('script');
      s.src = EU.replace(/idioma\.js.*$/, 'traducao-en.js');
      s.onload = function () { DIC = window.CMH_EN || {}; pronto(); };
      s.onerror = function () { pronto(); };   // sem dicionário, fica em pt
      document.head.appendChild(s);
    });
    return carregando;
  }

  // Guarda o português original de cada nó na primeira troca. Sem isso,
  // voltar para o português seria traduzir de volta — e tradução de volta
  // não é a mesma coisa: dois textos diferentes podem ter virado o mesmo
  // inglês, e aí um deles nunca mais voltaria ao que era.
  var ORIGINAL = new WeakMap();

  var PULA = { SCRIPT: 1, STYLE: 1, NOSCRIPT: 1, CODE: 1, PRE: 1, TEXTAREA: 1 };

  function trocarNo(no, paraIngles) {
    var texto = no.nodeValue;
    var limpo = texto.trim();
    if (limpo.length < 2) return;

    if (paraIngles) {
      var en = DIC[limpo];
      if (!en) return;
      if (!ORIGINAL.has(no)) ORIGINAL.set(no, texto);
      // preserva os espaços das pontas: eles separam a palavra do que vem
      // colado, e comê-los junta "Agende sua" com "consulta"
      no.nodeValue = texto.replace(limpo, en);
    } else if (ORIGINAL.has(no)) {
      no.nodeValue = ORIGINAL.get(no);
    }
  }

  var ATRIBUTOS = ['placeholder', 'title', 'alt', 'aria-label'];

  function trocarAtributos(el, paraIngles) {
    for (var i = 0; i < ATRIBUTOS.length; i++) {
      var a = ATRIBUTOS[i];
      if (!el.hasAttribute(a)) continue;
      var v = el.getAttribute(a);
      var guarda = 'data-pt-' + a;
      if (paraIngles) {
        var en = DIC[v.trim()];
        if (!en) continue;
        if (!el.hasAttribute(guarda)) el.setAttribute(guarda, v);
        el.setAttribute(a, en);
      } else if (el.hasAttribute(guarda)) {
        el.setAttribute(a, el.getAttribute(guarda));
      }
    }
  }

  function aplicar(raiz, paraIngles) {
    var passeio = document.createTreeWalker(
      raiz, NodeFilter.SHOW_TEXT | NodeFilter.SHOW_ELEMENT, {
        acceptNode: function (no) {
          if (no.nodeType === 1) {
            return PULA[no.tagName] ? NodeFilter.FILTER_REJECT
                                    : NodeFilter.FILTER_ACCEPT;
          }
          return NodeFilter.FILTER_ACCEPT;
        }
      });
    var no;
    while ((no = passeio.nextNode())) {
      if (no.nodeType === 3) trocarNo(no, paraIngles);
      else trocarAtributos(no, paraIngles);
    }
  }

  function trocar(idioma) {
    atual = idioma === 'en' ? 'en' : 'pt';
    lembrar(atual);
    document.documentElement.lang = atual === 'en' ? 'en' : 'pt-BR';
    desenharBotao();          // o rotulo muda na hora, sem esperar a rede
    if (atual === 'en') { carregarDicionario().then(pintar); }
    else { pintar(); }
  }

  function pintar() {
    aplicar(document.body, atual === 'en');

    // o <title> não está no body e não é nó de texto comum
    if (atual === 'en' && DIC[document.title.trim()]) {
      if (!document.body.dataset.ptTitle) {
        document.body.dataset.ptTitle = document.title;
      }
      document.title = DIC[document.title.trim()];
    } else if (document.body.dataset.ptTitle) {
      document.title = document.body.dataset.ptTitle;
    }
    desenharBotao();
  }

  // ---------------------------------------------------------- o seletor
  function desenharBotao() {
    var alvo = document.getElementById('cmh-idioma');
    if (!alvo) return;
    alvo.innerHTML =
      '<button type="button" class="lang__abre" aria-haspopup="listbox" ' +
        'aria-expanded="false">' +
        '<svg viewBox="0 0 24 24" width="15" height="15" fill="none" ' +
          'stroke="currentColor" stroke-width="2" aria-hidden="true">' +
          '<circle cx="12" cy="12" r="9"/><path d="M3 12h18"/>' +
          '<path d="M12 3a15 15 0 0 1 0 18a15 15 0 0 1 0-18"/></svg>' +
        '<span>' + (atual === 'en' ? 'EN' : 'PT') + '</span>' +
      '</button>' +
      '<ul class="lang__menu" role="listbox">' +
        Object.keys(IDIOMAS).map(function (k) {
          return '<li role="option" data-idioma="' + k + '"' +
            (k === atual ? ' aria-selected="true" class="on"' : '') + '>' +
            IDIOMAS[k] + (k === atual ? ' <span>✓</span>' : '') + '</li>';
        }).join('') +
      '</ul>';

    var abre = alvo.querySelector('.lang__abre');
    var menu = alvo.querySelector('.lang__menu');
    abre.addEventListener('click', function (ev) {
      ev.stopPropagation();
      var aberto = alvo.classList.toggle('aberto');
      abre.setAttribute('aria-expanded', aberto ? 'true' : 'false');
    });
    menu.querySelectorAll('[data-idioma]').forEach(function (li) {
      li.addEventListener('click', function () {
        alvo.classList.remove('aberto');
        trocar(li.dataset.idioma);
      });
    });

    // O "clicar fora fecha" é registrado UMA VEZ, e não a cada desenho.
    // Esta função roda de novo a cada troca de idioma; sem a trava, cada
    // troca deixava mais um ouvinte no documento, todos fazendo a mesma
    // coisa — e nenhum deles ia embora.
    if (!desenharBotao.ligado) {
      desenharBotao.ligado = true;
      document.addEventListener('click', function () {
        var caixa = document.getElementById('cmh-idioma');
        if (caixa) caixa.classList.remove('aberto');
      });
    }
  }

  // Conteúdo que nasce depois (carrossel, cards vindos do banco, listas
  // desenhadas por JavaScript) não passou pela troca inicial. Em vez de
  // pedir para cada página avisar, observamos o documento.
  function observar() {
    if (!window.MutationObserver) return;
    var pendente = null;
    new MutationObserver(function (mudancas) {
      if (atual !== 'en' || !window.CMH_EN) return;
      clearTimeout(pendente);
      pendente = setTimeout(function () {
        for (var i = 0; i < mudancas.length; i++) {
          var m = mudancas[i];
          for (var j = 0; j < m.addedNodes.length; j++) {
            var n = m.addedNodes[j];
            if (n.nodeType === 1) aplicar(n, true);
            else if (n.nodeType === 3) trocarNo(n, true);
          }
        }
      }, 80);
    }).observe(document.body, { childList: true, subtree: true });
  }

  function comecar() {
    desenharBotao();
    if (atual === 'en') trocar('en');   // busca o dicionario e repinta
    observar();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', comecar);
  } else {
    comecar();
  }

  window.CMH_IDIOMA = { trocar: trocar, atual: function () { return atual; } };
})();
