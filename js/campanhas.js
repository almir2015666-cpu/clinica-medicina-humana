/* ============================================================
   Campanhas mensais de saúde (Janeiro Branco, Setembro Amarelo...)
   O site troca sozinho no dia 1º de cada mês, pelo relógio de
   quem está visitando. Nada para editar na virada do mês.

   O que aparece:
   - faixa na cor da campanha no topo de todas as páginas;
   - slide de abertura na home, SÓ nos meses que tiverem 'slide'.

   >>> Para mudar o texto de um mês, mexa só no CALENDARIO. <<<
   'link' e 'slide' são opcionais: sem link, a faixa não tem
   "Saiba mais"; sem slide, a home fica como está.

   Para ver outro mês durante os testes: ?campanha=10 na URL.
   Este arquivo precisa carregar ANTES do main.js (o carrossel
   da home conta os slides quando o main.js roda).
   ============================================================ */
(function () {
  'use strict';

  var CALENDARIO = {
    1: {
      nome: 'Janeiro Branco', cor: '#eef2f7', tinta: '#0a2e5c', laco: '#ffffff',
      frase: 'Mês de cuidar da saúde mental e emocional.',
      link: 'especialidades.html'
    },
    2: {
      nome: 'Fevereiro Roxo e Laranja', cor: '#6b3fa0', tinta: '#ffffff',
      frase: 'Conscientização sobre lúpus, fibromialgia, Alzheimer e leucemia.'
    },
    3: {
      nome: 'Março Lilás', cor: '#8a55b3', tinta: '#ffffff',
      frase: 'Prevenção do câncer do colo do útero: faça o preventivo.',
      link: 'especialidades.html'
    },
    4: {
      nome: 'Abril Verde', cor: '#2e7d4f', tinta: '#ffffff',
      frase: 'Segurança e saúde no trabalho: prevenir acidentes e doenças ocupacionais é cuidar de pessoas.',
      link: 'medicina-ocupacional.html'
    },
    5: {
      nome: 'Maio Amarelo', cor: '#f7c600', tinta: '#2b2400',
      frase: 'Atenção pela vida no trânsito.'
    },
    6: {
      nome: 'Junho Vermelho', cor: '#c62828', tinta: '#ffffff',
      frase: 'Doe sangue, doe vida.'
    },
    7: {
      nome: 'Julho Amarelo', cor: '#f7c600', tinta: '#2b2400',
      frase: 'Prevenção das hepatites virais: faça o teste e mantenha a vacina em dia.',
      link: 'exames.html'
    },
    8: {
      nome: 'Agosto Dourado', cor: '#c9a227', tinta: '#2b2100',
      frase: 'Incentivo ao aleitamento materno.'
    },
    9: {
      nome: 'Setembro Amarelo', cor: '#f7c600', tinta: '#2b2400',
      frase: 'Falar é a melhor solução.',
      ajuda: { texto: 'Precisa conversar? Ligue 188', curto: 'Ligue 188', link: 'tel:188',
               rotulo: 'Ligar para o CVV, 188, 24 horas e gratuito' },
      link: 'noticia-12.html',
      slide: {
        titulo: 'Setembro Amarelo',
        texto: 'Falar é a melhor solução. Se você está passando por um momento difícil, ' +
               'não enfrente sozinho: o CVV atende 24 horas por dia, de graça, pelo telefone 188.',
        cta: 'Saiba como ajudar'
      }
    },
    10: {
      nome: 'Outubro Rosa', cor: '#d63a74', tinta: '#ffffff',
      frase: 'Prevenção do câncer de mama: faça os seus exames.',
      link: 'exames.html'
    },
    11: {
      nome: 'Novembro Azul', cor: '#1565c0', tinta: '#ffffff',
      frase: 'Saúde do homem e prevenção do câncer de próstata.',
      link: 'exames.html'
    },
    12: {
      nome: 'Dezembro Vermelho', cor: '#c62828', tinta: '#ffffff',
      frase: 'Prevenção do HIV/aids e de outras ISTs: faça o teste.',
      link: 'exames.html'
    }
  };

  var teste = /[?&]campanha=(\d{1,2})/.exec(window.location.search);
  var mes = teste ? +teste[1] : new Date().getMonth() + 1;
  var c = CALENDARIO[mes];
  if (!c) return;

  function laco(fill, stroke) {
    // laço de conscientização: contorno grosso por baixo, fita por cima
    var d = 'M30 52 L14 19 C11 12 14 5 20 5 C26 5 29 12 26 19 L10 52';
    return '<svg class="laco" viewBox="0 0 40 56" aria-hidden="true" fill="none" stroke-linejoin="round">' +
      '<path d="' + d + '" stroke="' + stroke + '" stroke-width="9"/>' +
      '<path d="' + d + '" stroke="' + fill + '" stroke-width="6"/>' +
      '</svg>';
  }

  function rgba(hex, a) {
    var n = parseInt(hex.slice(1), 16);
    return 'rgba(' + (n >> 16) + ',' + ((n >> 8) & 255) + ',' + (n & 255) + ',' + a + ')';
  }

  var root = document.documentElement;
  root.style.setProperty('--camp-cor', c.cor);
  root.style.setProperty('--camp-tinta', c.tinta);

  /* ---- faixa no topo ---- */
  var header = document.getElementById('header');
  if (header) {
    var faixa = document.createElement('div');
    faixa.className = 'faixa-campanha';
    faixa.setAttribute('role', 'region');
    faixa.setAttribute('aria-label', 'Campanha do mês: ' + c.nome);
    faixa.innerHTML =
      '<div class="container faixa-campanha__in">' +
        laco(c.laco || c.cor, c.tinta) +
        '<strong>' + c.nome + '</strong>' +
        '<span class="faixa-campanha__frase">' + c.frase + '</span>' +
        (c.ajuda ? '<a class="faixa-campanha__ajuda" href="' + c.ajuda.link + '" aria-label="' + c.ajuda.rotulo + '">' +
                     '<span class="longo">' + c.ajuda.texto + '</span><span class="curto">' + c.ajuda.curto + '</span></a>' : '') +
        (c.link ? '<a class="faixa-campanha__mais" href="' + c.link + '">Saiba mais</a>' : '') +
      '</div>';
    header.insertBefore(faixa, header.firstChild);
    document.body.classList.add('tem-campanha');
  }

  /* ---- slide de abertura na home ---- */
  var track = document.getElementById('heroTrack');
  if (track && c.slide && c.link) {
    var ativo = track.querySelector('.slide.is-active');
    if (ativo) ativo.classList.remove('is-active');

    var s = document.createElement('article');
    s.className = 'slide slide--campanha is-active';
    s.innerHTML =
      '<div class="slide__bg" style="background:radial-gradient(circle at 76% 46%,' + rgba(c.cor, .5) +
        ',transparent 48%),linear-gradient(135deg,#0a2e5c 0%,#12213a 100%)"></div>' +
      '<div class="slide__decor">' + laco(c.laco || c.cor, 'rgba(0,0,0,.18)') + '</div>' +
      '<div class="container slide__inner">' +
        '<h1 class="slide__title">' + c.slide.titulo + '</h1>' +
        '<p class="slide__text">' + c.slide.texto + '</p>' +
        '<div class="slide__chevrons" aria-hidden="true"><span></span><span></span></div>' +
        '<div class="slide__cta">' +
          '<a href="' + c.link + '" class="btn-hero"><span>' + c.slide.cta + '</span></a>' +
          '<a href="' + c.link + '" class="btn-hero__circle" aria-label="' + c.slide.cta + '"><span>→</span></a>' +
        '</div>' +
      '</div>';
    track.insertBefore(s, track.firstChild);
  }
})();
