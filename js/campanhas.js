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
      texto: 'Janeiro é o mês de olhar para a saúde mental e emocional. Cansaço constante, ' +
             'ansiedade e uma tristeza que não passa merecem atenção: conversar com um ' +
             'profissional é o primeiro passo.',
      link: 'especialidades.html'
    },
    2: {
      nome: 'Fevereiro Roxo e Laranja', cor: '#6b3fa0', tinta: '#ffffff',
      frase: 'Conscientização sobre lúpus, fibromialgia, Alzheimer e leucemia.',
      texto: 'Fevereiro chama atenção para o lúpus, a fibromialgia e o Alzheimer (roxo) e para ' +
             'a leucemia (laranja). Sintomas que não passam merecem avaliação médica: quanto ' +
             'antes o diagnóstico, melhor o acompanhamento.'
    },
    3: {
      nome: 'Março Lilás', cor: '#8a55b3', tinta: '#ffffff',
      frase: 'Prevenção do câncer do colo do útero: faça o preventivo.',
      texto: 'O câncer do colo do útero é um dos que mais podem ser prevenidos: a vacina contra ' +
             'o HPV e o exame preventivo, na frequência que o seu médico indicar, fazem toda a ' +
             'diferença.',
      link: 'especialidades.html'
    },
    4: {
      nome: 'Abril Verde', cor: '#2e7d4f', tinta: '#ffffff',
      frase: 'Segurança e saúde no trabalho: prevenir acidentes e doenças ocupacionais é cuidar de pessoas.',
      texto: 'Abril é o mês da segurança e da saúde no trabalho. Exames ocupacionais em dia, PGR ' +
             'atualizado e equipe treinada são a base para prevenir acidentes e doenças ' +
             'ocupacionais.',
      link: 'medicina-ocupacional.html'
    },
    5: {
      nome: 'Maio Amarelo', cor: '#f7c600', tinta: '#2b2400',
      frase: 'Atenção pela vida no trânsito.',
      texto: 'Maio é o mês de atenção pela vida no trânsito. Respeite os limites de velocidade, ' +
             'use cinto e capacete e não dirija depois de beber. Para quem dirige a trabalho, ' +
             'exames em dia também são segurança.'
    },
    6: {
      nome: 'Junho Vermelho', cor: '#c62828', tinta: '#ffffff',
      frase: 'Doe sangue, doe vida.',
      texto: 'Junho é o mês de incentivo à doação de sangue. Uma única doação pode ajudar várias ' +
             'pessoas. Procure o hemocentro da sua região e confira quem pode doar.'
    },
    7: {
      nome: 'Julho Amarelo', cor: '#f7c600', tinta: '#2b2400',
      frase: 'Prevenção das hepatites virais: faça o teste e mantenha a vacina em dia.',
      texto: 'Muitas hepatites virais passam anos sem dar sintomas. Fazer o teste, manter a ' +
             'vacinação em dia e não compartilhar objetos cortantes são formas simples de se ' +
             'proteger.',
      link: 'exames.html'
    },
    8: {
      nome: 'Agosto Dourado', cor: '#c9a227', tinta: '#2b2100',
      frase: 'Incentivo ao aleitamento materno.',
      texto: 'Agosto é o mês de incentivo ao aleitamento materno. O leite materno protege o bebê ' +
             'e fortalece o vínculo com a mãe. Apoiar quem amamenta, em casa e no trabalho, faz ' +
             'parte desse cuidado.'
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
      texto: 'O câncer de mama tem mais chance de cura quando é descoberto cedo. Conheça o seu ' +
             'corpo, converse com o seu médico e faça os exames na frequência indicada para a ' +
             'sua idade.',
      link: 'exames.html'
    },
    11: {
      nome: 'Novembro Azul', cor: '#1565c0', tinta: '#ffffff',
      frase: 'Saúde do homem e prevenção do câncer de próstata.',
      texto: 'Novembro é o mês da saúde do homem. Check-up em dia, pressão, glicose e colesterol ' +
             'sob controle e a conversa com o médico sobre a prevenção do câncer de próstata ' +
             'fazem parte do cuidado.',
      link: 'exames.html'
    },
    12: {
      nome: 'Dezembro Vermelho', cor: '#c62828', tinta: '#ffffff',
      frase: 'Prevenção do HIV/aids e de outras ISTs: faça o teste.',
      texto: 'Dezembro é o mês de prevenção do HIV/aids e de outras ISTs. O teste é simples e ' +
             'rápido, e o tratamento, quando começa cedo, garante qualidade de vida. Use ' +
             'preservativo e faça o teste.',
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

  /* ---- laço ao lado do logo ---- */
  var marca = header && header.querySelector('.brand');
  if (marca) {
    var fita = document.createElement('span');
    fita.className = 'brand__laco';
    fita.title = c.nome;
    fita.innerHTML = laco(c.laco || c.cor, 'rgba(0,0,0,.28)');
    marca.appendChild(fita);
  }

  /* ---- faixa grande "Campanha do mês" na home, abaixo dos cards ---- */
  var servicos = document.getElementById('servicos');
  if (servicos) {
    var texto = c.texto || (c.slide && c.slide.texto) || c.frase;
    var banda = document.createElement('section');
    banda.className = 'banda-campanha';
    banda.setAttribute('aria-label', 'Campanha do mês: ' + c.nome);
    banda.innerHTML =
      '<div class="container banda-campanha__in">' +
        '<div class="banda-campanha__laco">' + laco(c.laco || c.cor, 'rgba(0,0,0,.18)') + '</div>' +
        '<div class="banda-campanha__txt">' +
          '<span class="banda-campanha__selo">Campanha do mês</span>' +
          '<h2>' + c.nome + '</h2>' +
          '<p>' + texto + '</p>' +
          '<div class="banda-campanha__acoes">' +
            (c.ajuda ? '<a class="banda-campanha__btn" href="' + c.ajuda.link + '" aria-label="' +
                       c.ajuda.rotulo + '">' + c.ajuda.texto + '</a>' : '') +
            (c.link ? '<a class="banda-campanha__link" href="' + c.link + '">' +
                      (c.slide ? c.slide.cta : 'Saiba mais') + ' →</a>' : '') +
          '</div>' +
        '</div>' +
      '</div>';
    servicos.parentNode.insertBefore(banda, servicos.nextSibling);
  }

  /* ---- rodapé: fio na cor do mês e o nome da campanha ---- */
  var rodape = document.querySelector('.footer');
  if (rodape) {
    rodape.classList.add('footer--campanha');
    var linha = rodape.querySelector('.footer__bottom-inner');
    if (linha) {
      var nota = document.createElement('span');
      nota.className = 'footer__campanha';
      nota.innerHTML = laco(c.laco || c.cor, 'rgba(0,0,0,.28)') +
        (c.link ? '<a href="' + c.link + '">' + c.nome + '</a>' : c.nome) +
        (c.ajuda ? ' · <a href="' + c.ajuda.link + '">' + c.ajuda.texto + '</a>' : '');
      linha.appendChild(nota);
    }
  }
})();
