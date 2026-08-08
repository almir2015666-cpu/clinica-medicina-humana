/* ============================================================
   Clínica Medicina Humana — interações
   ============================================================ */
(function () {
  'use strict';

  /* ---- Header shrink on scroll ---- */
  const header = document.getElementById('header');
  const hero = document.getElementById('hero');
  const onScroll = () => {
    // vira a barra sólida logo com um scroll pequeno (como a referência)
    if (window.scrollY > 40) header.classList.add('scrolled');
    else header.classList.remove('scrolled');
  };
  window.addEventListener('scroll', onScroll, { passive: true });
  onScroll();

  /* ---- Mobile menu ---- */
  const hamburger = document.getElementById('hamburger');
  const nav = document.getElementById('nav');
  const closeMenu = () => {
    hamburger.classList.remove('active');
    nav.classList.remove('open');
    document.body.style.overflow = '';
  };
  hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('active');
    nav.classList.toggle('open');
    document.body.style.overflow = nav.classList.contains('open') ? 'hidden' : '';
  });

  // Botao X para fechar a gaveta (mobile)
  const navClose = document.createElement('button');
  navClose.className = 'nav__close';
  navClose.setAttribute('aria-label', 'Fechar menu');
  navClose.innerHTML = '&times;';
  navClose.addEventListener('click', closeMenu);
  nav.appendChild(navClose);

  // Accordion for mega menus on mobile
  document.querySelectorAll('.has-mega > .nav__link').forEach((btn) => {
    btn.addEventListener('click', (e) => {
      if (window.innerWidth <= 1024) {
        e.preventDefault();
        btn.parentElement.classList.toggle('open-sub');
      }
    });
  });

  // Fecha o menu ao clicar em qualquer link (mobile)
  nav.querySelectorAll('a').forEach((a) => {
    a.addEventListener('click', closeMenu);
  });

  /* ---- Scroll reveal (IntersectionObserver) ---- */
  const reveals = document.querySelectorAll('.reveal');
  if ('IntersectionObserver' in window) {
    const io = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry, i) => {
          if (entry.isIntersecting) {
            // stagger siblings inside a grid
            const siblings = entry.target.parentElement
              ? Array.from(entry.target.parentElement.querySelectorAll('.reveal'))
              : [];
            const idx = siblings.indexOf(entry.target);
            entry.target.style.transitionDelay = (idx > -1 ? Math.min(idx, 5) * 0.08 : 0) + 's';
            entry.target.classList.add('in');
            io.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.12, rootMargin: '0px 0px -8% 0px' }
    );
    reveals.forEach((el) => io.observe(el));
  } else {
    reveals.forEach((el) => el.classList.add('in'));
  }

  /* ---- Animated counters ---- */
  const counters = document.querySelectorAll('[data-count]');
  const runCounter = (el) => {
    const target = +el.getAttribute('data-count');
    const dur = 1600;
    let start = null;
    const step = (ts) => {
      if (!start) start = ts;
      const p = Math.min((ts - start) / dur, 1);
      const eased = 1 - Math.pow(1 - p, 3);
      el.textContent = Math.round(eased * target);
      if (p < 1) requestAnimationFrame(step);
      else el.textContent = target;
    };
    requestAnimationFrame(step);
  };
  if ('IntersectionObserver' in window) {
    const cio = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            runCounter(entry.target);
            cio.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.6 }
    );
    counters.forEach((el) => cio.observe(el));
  }

  /* ---- Parallax on hero + band ---- */
  const parallaxEls = document.querySelectorAll('[data-parallax]');
  let ticking = false;
  const applyParallax = () => {
    parallaxEls.forEach((el) => {
      const speed = parseFloat(el.getAttribute('data-parallax'));
      const rect = el.parentElement.getBoundingClientRect();
      const offset = (rect.top + rect.height / 2 - window.innerHeight / 2) * speed;
      el.style.transform = 'translate3d(0,' + offset.toFixed(1) + 'px,0)';
    });
    ticking = false;
  };
  const requestParallax = () => {
    if (!ticking) {
      requestAnimationFrame(applyParallax);
      ticking = true;
    }
  };
  const reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  if (!reduced) {
    window.addEventListener('scroll', requestParallax, { passive: true });
    window.addEventListener('resize', requestParallax);
    applyParallax();
  }

  /* ---- Hero carousel ---- */
  const slides = Array.prototype.slice.call(document.querySelectorAll('.hero .slide'));
  if (slides.length > 1) {
    let idx = 0;
    let timer = null;
    const DUR = 3500;
    const track = document.getElementById('heroTrack');
    const go = (n) => {
      slides[idx].classList.remove('is-active');
      idx = (n + slides.length) % slides.length;
      slides[idx].classList.add('is-active');
      if (track) track.style.transform = 'translateX(-' + (idx * 100) + '%)';
    };
    const next = () => go(idx + 1);
    const prev = () => go(idx - 1);
    const play = () => { stop(); timer = setInterval(next, DUR); };
    const stop = () => { if (timer) { clearInterval(timer); timer = null; } };

    const btnNext = document.getElementById('heroNext');
    const btnPrev = document.getElementById('heroPrev');
    if (btnNext) btnNext.addEventListener('click', () => { next(); play(); });
    if (btnPrev) btnPrev.addEventListener('click', () => { prev(); play(); });

    const heroEl = document.getElementById('hero');
    if (heroEl) {
      heroEl.addEventListener('mouseenter', stop);
      heroEl.addEventListener('mouseleave', play);
    }
    play();

    // exposto para pausar o carrossel enquanto houver modal por cima
    window.__cmhHero = { play: play, stop: stop };
  }

  /* ---- Widget de acessibilidade ---- */
  (function () {
    if (document.getElementById('a11yFab')) return;
    var ACC = '<svg viewBox="0 0 24 24" width="26" height="26" fill="currentColor" aria-hidden="true"><circle cx="12" cy="3.6" r="2.1"/><path d="M20 8.4c-.1.5-.6.9-1.1.8-1.6-.2-3.2-.6-3.9-.8V21a1 1 0 0 1-2 0v-5h-1v5a1 1 0 0 1-2 0V8.4c-.7.2-2.3.6-3.9.8-.5.1-1-.3-1.1-.8-.1-.6.3-1.1.8-1.2 2-.3 4.3-.9 4.3-.9.3-.1.6-.1.9-.1h.9c.3 0 .6 0 .9.1 0 0 2.3.6 4.3.9.6.1 1 .6.9 1.2z"/></svg>';

    var fab = document.createElement('button');
    fab.id = 'a11yFab'; fab.className = 'a11y-fab'; fab.setAttribute('aria-label', 'Acessibilidade'); fab.innerHTML = ACC;
    var fx = document.createElement('div'); fx.className = 'a11y-fx';
    var overlay = document.createElement('div'); overlay.className = 'a11y-overlay';
    var readbar = document.createElement('div'); readbar.className = 'a11y-readbar';
    var panel = document.createElement('aside'); panel.className = 'a11y-panel2';

    var S = {
      eye: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7-10-7-10-7z"/><circle cx="12" cy="12" r="3"/></svg>',
      palette: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><circle cx="8.5" cy="9.5" r="1.1" fill="currentColor" stroke="none"/><circle cx="15.5" cy="9.5" r="1.1" fill="currentColor" stroke="none"/><circle cx="12" cy="15" r="1.1" fill="currentColor" stroke="none"/></svg>',
      bolt: '<svg viewBox="0 0 24 24" fill="currentColor" stroke="none"><path d="M13 2L4 14h6l-1 8 9-12h-6l1-8z"/></svg>',
      focus: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><circle cx="12" cy="12" r="3"/><path d="M5 8V5h3M19 8V5h-3M5 16v3h3M19 16v3h-3"/></svg>',
      book: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"><path d="M4 5a2 2 0 0 1 2-2h6v18H6a2 2 0 0 1-2-2z"/><path d="M20 5a2 2 0 0 0-2-2h-6v18h6a2 2 0 0 0 2-2z"/></svg>',
      typeA: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 20l6-15 6 15M8.5 14h7"/></svg>',
      droplet: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 3s6 6.5 6 11a6 6 0 0 1-12 0c0-4.5 6-11 6-11z"/></svg>',
      compass: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M16 8l-2 6-6 2 2-6 6-2z"/></svg>',
      contrast: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 3a9 9 0 0 0 0 18z" fill="currentColor"/></svg>',
      gray: '<svg viewBox="0 0 24 24" fill="currentColor" stroke="none"><circle cx="12" cy="12" r="8"/></svg>',
      link: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M9 13a5 5 0 0 0 7 0l2-2a5 5 0 0 0-7-7l-1 1"/><path d="M15 11a5 5 0 0 0-7 0l-2 2a5 5 0 0 0 7 7l1-1"/></svg>',
      cursor: '<svg viewBox="0 0 24 24" fill="currentColor" stroke="none"><path d="M5 3l6 17 2.4-6.6L20 11 5 3z"/></svg>',
      ruler: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"><rect x="2" y="8" width="20" height="8" rx="1"/><path d="M6 8v3M10 8v4M14 8v3M18 8v4"/></svg>',
      pause: '<svg viewBox="0 0 24 24" fill="currentColor" stroke="none"><rect x="6" y="5" width="4" height="14" rx="1"/><rect x="14" y="5" width="4" height="14" rx="1"/></svg>',
      zoom: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4-4M11 8v6M8 11h6"/></svg>',
      hand: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"><path d="M8 11V6a1.5 1.5 0 0 1 3 0v4M11 10V4.5a1.5 1.5 0 0 1 3 0V10M14 10.5V7a1.5 1.5 0 0 1 3 0v6a6 6 0 0 1-6 6 5 5 0 0 1-4-2l-2.5-3.4a1.5 1.5 0 0 1 2.4-1.8L8 13"/></svg>',
      lines: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M4 6h16M4 12h11M4 18h16"/></svg>'
    };
    function prof(a, t, d, ic) { return '<button class="a11y-card" data-a="' + a + '"><span class="ic">' + ic + '</span><span><b>' + t + '</b><small>' + d + '</small></span></button>'; }
    function tile(a, l, ic) { return '<button class="a11y-tile" data-a="' + a + '"><span class="ic">' + ic + '</span>' + l + '</button>'; }
    function acc(id, ic, t, d, open) { return '<button class="a11y-acc' + (open ? ' open' : '') + '" data-acc="' + id + '"><span class="a11y-acc-ic">' + ic + '</span><span class="a11y-acc-txt"><b>' + t + '</b><small>' + d + '</small></span><span class="a11y-acc-ch">⌄</span></button>'; }
    panel.innerHTML =
      '<div class="a11y-top"><strong>Acessibilidade</strong><span class="a11y-top-btns"><button data-a="reset">↺ Restaurar</button><button class="a11y-close" aria-label="Fechar">✕</button></span></div>' +
      '<div class="a11y-sec">' +
        acc('1', ACC, 'Perfis de Acessibilidade', 'Baixa Visão, Daltonismo, Epilepsia, TDAH, Dislexia', true) +
        '<div class="a11y-accbody open" data-body="1">' +
          prof('p-baixavisao', 'Baixa Visão', 'Aumenta fonte e contraste', S.eye) +
          prof('p-daltonismo', 'Daltonismo', 'Remove cores (tons de cinza)', S.palette) +
          prof('p-epilepsia', 'Epilepsia', 'Para as animações', S.bolt) +
          prof('p-tdah', 'TDAH / Foco', 'Guia de leitura', S.focus) +
          prof('p-dislexia', 'Dislexia', 'Texto legível e espaçado', S.book) +
        '</div>' +
        acc('2', S.typeA, 'Ajustes de Texto', 'Tamanho da fonte', false) +
        '<div class="a11y-accbody" data-body="2"><div class="a11y-grid"><button class="a11y-tile" data-a="font-">A−</button><button class="a11y-tile" data-a="font0">A</button><button class="a11y-tile" data-a="font+">A+</button></div></div>' +
        acc('3', S.droplet, 'Ajustes de Cores', 'Contraste, tons de cinza e links', false) +
        '<div class="a11y-accbody" data-body="3"><div class="a11y-grid">' + tile('contrast', 'Alto contraste', S.contrast) + tile('gray', 'Tons de cinza', S.gray) + tile('links', 'Destacar links', S.link) + '</div></div>' +
        acc('4', S.compass, 'Navegação e Conteúdo', 'Cursor, leitura, zoom e Libras', false) +
        '<div class="a11y-accbody" data-body="4"><div class="a11y-grid">' + tile('bigcursor', 'Cursor grande', S.cursor) + tile('readguide', 'Guia de leitura', S.ruler) + tile('noanim', 'Parar animações', S.pause) + tile('font+', 'Zoom', S.zoom) + tile('libras', 'Libras', S.hand) + tile('dyslexia', 'Modo leitura', S.lines) + '</div></div>' +
      '</div>' +
      '<div class="a11y-foot">Recursos de acessibilidade — Clínica Medicina Humana</div>';

    document.body.appendChild(fx);
    document.body.appendChild(overlay);
    document.body.appendChild(readbar);
    document.body.appendChild(panel);
    document.body.appendChild(fab);

    fab.addEventListener('click', function () { overlay.classList.add('open'); panel.classList.add('open'); });
    overlay.addEventListener('click', function () { overlay.classList.remove('open'); panel.classList.remove('open'); });

    var font = 0;
    var CLS = { contrast: 'a11y-contrast', gray: 'a11y-gray', links: 'a11y-links', bigcursor: 'a11y-bigcursor', readguide: 'a11y-readguide', noanim: 'a11y-noanim', dyslexia: 'a11y-dyslexia' };
    function setFont() { document.documentElement.style.fontSize = (100 + font * 10) + '%'; }
    function updateFx() {
      var f = '';
      if (document.body.classList.contains('a11y-gray')) f += ' grayscale(1)';
      if (document.body.classList.contains('a11y-contrast')) f += ' contrast(1.45)';
      f = f.trim();
      fx.style.backdropFilter = f; fx.style.webkitBackdropFilter = f;
    }
    function sync() {
      panel.querySelectorAll('[data-a]').forEach(function (el) {
        var a = el.getAttribute('data-a');
        if (CLS[a]) el.classList.toggle('on', document.body.classList.contains(CLS[a]));
      });
    }
    function reset() {
      Object.keys(CLS).forEach(function (k) { document.body.classList.remove(CLS[k]); });
      panel.querySelectorAll('.a11y-card.on').forEach(function (c) { c.classList.remove('on'); });
      font = 0; setFont(); updateFx(); sync();
    }

    panel.addEventListener('click', function (e) {
      var acc = e.target.closest('[data-acc]');
      if (acc) {
        var bd = panel.querySelector('[data-body="' + acc.getAttribute('data-acc') + '"]');
        if (bd) { bd.classList.toggle('open'); acc.classList.toggle('open'); }
        return;
      }
      if (e.target.closest('.a11y-close')) { overlay.classList.remove('open'); panel.classList.remove('open'); return; }
      var b = e.target.closest('[data-a]'); if (!b) return;
      var a = b.getAttribute('data-a');
      if (a === 'reset') { reset(); return; }
      if (a === 'font+') { font = Math.min(font + 1, 5); setFont(); return; }
      if (a === 'font-') { font = Math.max(font - 1, -2); setFont(); return; }
      if (a === 'font0') { font = 0; setFont(); return; }
      if (a === 'libras') { loadVLibras(); return; }
      if (a.indexOf('p-') === 0) {
        var bundles = { 'p-baixavisao': ['a11y-contrast', 'a11y-bigcursor'], 'p-daltonismo': ['a11y-gray'], 'p-epilepsia': ['a11y-noanim'], 'p-tdah': ['a11y-readguide'], 'p-dislexia': ['a11y-dyslexia'] };
        var bundle = bundles[a];
        var allOn = bundle.every(function (c) { return document.body.classList.contains(c); });
        bundle.forEach(function (c) { document.body.classList.toggle(c, !allOn); });
        b.classList.toggle('on', !allOn);
        if (a === 'p-baixavisao') { font = allOn ? 0 : 2; setFont(); }
        updateFx(); sync(); return;
      }
      if (CLS[a]) { document.body.classList.toggle(CLS[a]); updateFx(); sync(); }
    });

    document.addEventListener('mousemove', function (e) {
      if (document.body.classList.contains('a11y-readguide')) readbar.style.top = (e.clientY - 22) + 'px';
    });

    function loadVLibras() {
      if (window.__vlibrasLoaded) return;
      window.__vlibrasLoaded = true;
      var box = document.createElement('div');
      box.setAttribute('vw', ''); box.className = 'enabled';
      box.innerHTML = '<div vw-access-button class="active"></div><div vw-plugin-wrapper><div class="vw-plugin-top-wrapper"></div></div>';
      document.body.appendChild(box);
      var s = document.createElement('script');
      s.src = 'https://vlibras.gov.br/app/vlibras-plugin.js';
      s.onload = function () { try { new window.VLibras.Widget('https://vlibras.gov.br/app'); } catch (e) {} };
      document.body.appendChild(s);
    }
  })();

  /* ============================================================
     Aviso de abertura — retomada do atendimento assistencial
     Aparece uma vez por sessao, em qualquer pagina de entrada.
     Para rever durante os testes: acrescente ?aviso=1 na URL.
     ============================================================ */
  (function () {
    var CHAVE = 'cmh-aviso-assistencial-v1';
    var forcar = /[?&]aviso=1/.test(window.location.search);

    try {
      if (!forcar && sessionStorage.getItem(CHAVE) === 'visto') return;
    } catch (e) { /* sessionStorage bloqueado: mostra assim mesmo */ }

    // Titulo escrito letra a letra, em ritmo continuo.
    var TITULO = [
      { texto: 'Estamos de volta com o ', forte: false },
      { texto: 'Assistencial', forte: true }
    ];
    var TITULO_TXT = 'Estamos de volta com o Assistencial';
    var VEL = 42; // ms por caractere

    var semMovimento = window.matchMedia('(prefers-reduced-motion: reduce)').matches ||
                       document.body.classList.contains('a11y-noanim');

    var wrap = document.createElement('div');
    wrap.className = 'aviso';
    wrap.id = 'avisoAssistencial';
    wrap.setAttribute('role', 'dialog');
    wrap.setAttribute('aria-modal', 'true');
    wrap.setAttribute('aria-label', 'Comunicado: ' + TITULO_TXT);
    wrap.innerHTML =
      '<div class="aviso__fundo"></div>' +
      '<div class="aviso__caixa">' +
        '<button class="aviso__x" type="button" aria-label="Fechar aviso">&times;</button>' +
        '<div class="aviso__corpo">' +
          '<img class="aviso__logo" src="assets/logo.png" alt="Clínica Medicina Humana" ' +
               'onerror="this.style.display=\'none\'" />' +
          '<span class="aviso__tag">Comunicado</span>' +
          '<h2 class="aviso__titulo" aria-hidden="true"></h2>' +
          '<div class="aviso__divisor" aria-hidden="true"></div>' +
          '<p class="aviso__texto aviso__pos" style="--d:.10s">' +
            'Informamos que o atendimento assistencial da Clínica Medicina Humana ' +
            'está novamente disponível. Nossa equipe segue à disposição para cuidar ' +
            'de você e da sua família.' +
          '</p>' +
          '<div class="aviso__acoes aviso__pos" style="--d:.24s">' +
            '<button class="aviso__btn" type="button" data-fechar>Entendi</button>' +
          '</div>' +
        '</div>' +
      '</div>';

    document.body.appendChild(wrap);

    var titulo = wrap.querySelector('.aviso__titulo');
    var timers = [];
    var quadro = 0;
    function agendar(fn, ms) { timers.push(setTimeout(fn, ms)); }

    // Monta o titulo completo de uma vez. Cada letra vira um span
    // transparente; os espacos ficam como texto solto para a quebra de
    // linha ser exatamente a final desde o primeiro quadro.
    var letras = [];
    TITULO.forEach(function (seg) {
      var destino = titulo;
      if (seg.forte) {
        destino = document.createElement('strong');
        titulo.appendChild(destino);
      }
      for (var k = 0; k < seg.texto.length; k++) {
        var ch = seg.texto.charAt(k);
        if (ch === ' ') { destino.appendChild(document.createTextNode(' ')); continue; }
        var s = document.createElement('span');
        s.className = 'aviso__l';
        s.textContent = ch;
        destino.appendChild(s);
        letras.push(s);
      }
    });

    var fechado = false;
    function fechar() {
      if (fechado) return;
      fechado = true;
      timers.forEach(clearTimeout);
      if (quadro) cancelAnimationFrame(quadro);
      try { sessionStorage.setItem(CHAVE, 'visto'); } catch (e) {}
      wrap.classList.remove('is-vis');
      wrap.classList.add('is-saindo');
      document.removeEventListener('keydown', onTecla);
      // devolve o carrossel do hero
      if (window.__cmhHero) { try { window.__cmhHero.play(); } catch (e) {} }
      setTimeout(function () {
        wrap.remove();
        document.body.classList.remove('aviso-aberto');
      }, 400);
    }
    function onTecla(e) { if (e.key === 'Escape') fechar(); }

    wrap.querySelector('.aviso__x').addEventListener('click', fechar);
    wrap.querySelector('[data-fechar]').addEventListener('click', fechar);
    wrap.querySelector('.aviso__fundo').addEventListener('click', fechar);
    document.addEventListener('keydown', onTecla);

    // Deixa o titulo pronto de uma vez. Rede de seguranca para quando a
    // escrita nao comeca ou trava no meio — requestAnimationFrame nao roda
    // com a aba em segundo plano, e as fontes podem demorar. Melhor o titulo
    // aparecer inteiro do que ficar invisivel.
    function acenderTudo() {
      if (fechado || wrap.classList.contains('is-escrito')) return;
      if (quadro) { cancelAnimationFrame(quadro); quadro = 0; }
      letras.forEach(function (L) {
        L.classList.add('is-on');
        L.classList.remove('is-caret', 'is-caret-ini');
      });
      wrap.classList.add('is-escrito');
    }

    // Acende uma letra por vez. Nenhum no e criado ou removido durante a
    // escrita — so muda a cor —, por isso nao ha reflow nem engasgo.
    function escrever() {
      var i = 0;
      var proximo = 0;
      var atual = null;

      // cursor piscando a esquerda da 1a letra, antes de comecar
      if (letras.length) letras[0].classList.add('is-caret-ini');

      function frame(ts) {
        if (fechado) return;
        if (!proximo) proximo = ts;

        while (i < letras.length && ts >= proximo) {
          var L = letras[i];
          if (i === 0) L.classList.remove('is-caret-ini');
          if (atual) atual.classList.remove('is-caret');
          L.classList.add('is-on', 'is-caret');
          atual = L;
          i++;
          proximo += VEL;
        }

        if (i < letras.length) quadro = requestAnimationFrame(frame);
        else concluir();
      }
      quadro = requestAnimationFrame(frame);
    }

    function concluir() {
      agendar(function () {
        wrap.classList.add('is-escrito');
        var btn = wrap.querySelector('.aviso__btn');
        agendar(function () {
          try { btn.focus({ preventScroll: true }); } catch (e) {}
        }, 600);
      }, 260);
    }

    agendar(function () {
      document.body.classList.add('aviso-aberto');
      wrap.classList.add('is-on');
      // congela o carrossel: fundo parado deixa o desfoque barato de repintar
      if (window.__cmhHero) { try { window.__cmhHero.stop(); } catch (e) {} }

      // 'is-vis' precisa entrar de forma sincrona. Se dependesse de
      // requestAnimationFrame, uma aba aberta em segundo plano nao receberia
      // a classe e o modal ficaria invisivel porem cobrindo a tela, travando
      // rolagem e cliques. O reflow abaixo faz a transicao valer sem rAF.
      void wrap.offsetWidth;
      wrap.classList.add('is-vis');

      if (semMovimento) {
        wrap.classList.add('is-ligada');
        acenderTudo();
        return;
      }

      // a peca entra em foco -> o conteudo acende. Sem rAF aqui de proposito:
      // precisa valer mesmo com a aba em segundo plano.
      agendar(function () { wrap.classList.add('is-ligada'); }, 300);

      // A escrita normal termina por volta de 2,5s. Passando disso, algo
      // travou: mostra o titulo inteiro. Nao faz nada se ja terminou.
      agendar(acenderTudo, 4200);

      // So escreve depois que as fontes estao prontas: um swap do Poppins 700
      // no meio da animacao remontaria a linha e causaria engasgo.
      agendar(function () {
        if (fechado) return;
        if (document.fonts && document.fonts.ready) {
          document.fonts.ready.then(function () {
            if (!fechado) escrever();
          })['catch'](function () { if (!fechado) escrever(); });
        } else {
          escrever();
        }
      }, 980);
    }, 400);
  })();
})();
