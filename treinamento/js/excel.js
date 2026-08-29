/* =====================================================================
   PLANILHA DE VERDADE, MONTADA NO NAVEGADOR

   Gera um .xlsx que o Excel abre com abas, cabeçalho fixo, largura de
   coluna e formato de data. Sem biblioteca, sem servidor, sem nada
   saindo da máquina de quem clicou.

   POR QUE NÃO CSV
   CSV é o caminho fácil e é o que estraga a entrega. No Excel em
   português, ele abre tudo numa coluna só (o separador esperado é ponto e
   vírgula, não vírgula), acento vira caractere quebrado sem BOM, CPF com
   zero à esquerda perde o zero, e data vira texto ou vira a data errada.
   O RH abre, vê aquilo e conclui que o sistema é ruim.

   POR QUE ISTO É POSSÍVEL SEM BIBLIOTECA
   .xlsx é um ZIP com alguns arquivos XML dentro. O ZIP é escrito aqui em
   modo "armazenado", sem compressão: são poucos KB, e compressão exigiria
   um deflate inteiro em troca de nada.

   É o mesmo caminho que o SistemaCMH já usa para gerar Word sem depender
   de biblioteca nenhuma.
   ===================================================================== */
(function (raiz) {
  'use strict';

  // ------------------------------------------------------------ CRC32
  // O ZIP exige o CRC de cada arquivo. A tabela é montada uma vez.
  var TABELA = (function () {
    var t = new Uint32Array(256), c, i, k;
    for (i = 0; i < 256; i++) {
      c = i;
      for (k = 0; k < 8; k++) c = (c & 1) ? (0xEDB88320 ^ (c >>> 1)) : (c >>> 1);
      t[i] = c >>> 0;
    }
    return t;
  })();

  function crc32(bytes) {
    var c = 0xFFFFFFFF;
    for (var i = 0; i < bytes.length; i++) {
      c = TABELA[(c ^ bytes[i]) & 0xFF] ^ (c >>> 8);
    }
    return (c ^ 0xFFFFFFFF) >>> 0;
  }

  function bytesDe(texto) {
    return new TextEncoder().encode(texto);
  }

  // ------------------------------------------------------------- ZIP
  function zipar(arquivos) {
    var partes = [], central = [], deslocamento = 0;

    arquivos.forEach(function (a) {
      var nome = bytesDe(a.nome);
      var dados = bytesDe(a.conteudo);
      var crc = crc32(dados);

      var local = new DataView(new ArrayBuffer(30));
      local.setUint32(0, 0x04034b50, true);   // assinatura
      local.setUint16(4, 20, true);           // versão necessária
      local.setUint16(6, 0x0800, true);       // nomes em UTF-8
      local.setUint16(8, 0, true);            // método: armazenado
      local.setUint16(10, 0, true);           // hora
      local.setUint16(12, 0x2821, true);      // data (fixa, e de propósito:
                                              // ver o comentário abaixo)
      local.setUint32(14, crc, true);
      local.setUint32(18, dados.length, true);
      local.setUint32(22, dados.length, true);
      local.setUint16(26, nome.length, true);
      local.setUint16(28, 0, true);

      partes.push(new Uint8Array(local.buffer), nome, dados);

      var dir = new DataView(new ArrayBuffer(46));
      dir.setUint32(0, 0x02014b50, true);
      dir.setUint16(4, 20, true);
      dir.setUint16(6, 20, true);
      dir.setUint16(8, 0x0800, true);
      dir.setUint16(10, 0, true);
      dir.setUint16(12, 0, true);
      dir.setUint16(14, 0x2821, true);
      dir.setUint32(16, crc, true);
      dir.setUint32(20, dados.length, true);
      dir.setUint32(24, dados.length, true);
      dir.setUint16(28, nome.length, true);
      dir.setUint16(38, 0, true);
      dir.setUint32(42, deslocamento, true);
      central.push(new Uint8Array(dir.buffer), nome);

      deslocamento += 30 + nome.length + dados.length;
    });

    var tamanhoCentral = central.reduce(function (t, p) { return t + p.length; }, 0);
    var fim = new DataView(new ArrayBuffer(22));
    fim.setUint32(0, 0x06054b50, true);
    fim.setUint16(8, arquivos.length, true);
    fim.setUint16(10, arquivos.length, true);
    fim.setUint32(12, tamanhoCentral, true);
    fim.setUint32(16, deslocamento, true);

    return new Blob(partes.concat(central, [new Uint8Array(fim.buffer)]),
                    { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
  }

  // ------------------------------------------------------------- XML
  function esc(t) {
    return String(t == null ? '' : t)
      .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      // Caractere de controle não existe em XML: um único deles no meio de
      // um nome e o Excel recusa o arquivo inteiro dizendo apenas que ele
      // está corrompido. Some antes de entrar.
      .replace(/[\x00-\x08\x0B\x0C\x0E-\x1F]/g, '');
  }

  function coluna(n) {          // 1 -> A, 27 -> AA
    var s = '';
    while (n > 0) {
      var r = (n - 1) % 26;
      s = String.fromCharCode(65 + r) + s;
      n = Math.floor((n - 1) / 26);
    }
    return s;
  }

  // Data para o número que o Excel entende (dias desde 1899-12-30).
  function serialData(iso) {
    var p = String(iso || '').slice(0, 10).split('-');
    if (p.length !== 3) return null;
    var d = Date.UTC(Number(p[0]), Number(p[1]) - 1, Number(p[2]));
    if (isNaN(d)) return null;
    return Math.round(d / 86400000) + 25569;
  }

  /* Monta uma aba.
     `colunas` é [{titulo, largura, tipo}] com tipo 'texto' ou 'data'.
     `linhas` é um array de arrays, na mesma ordem das colunas. */
  function aba(colunas, linhas) {
    var larguras = colunas.map(function (c, i) {
      return '<col min="' + (i + 1) + '" max="' + (i + 1) + '" width="' +
             (c.largura || 18) + '" customWidth="1"/>';
    }).join('');

    var cabecalho = '<row r="1" ht="22" customHeight="1">' +
      colunas.map(function (c, i) {
        return '<c r="' + coluna(i + 1) + '1" s="1" t="inlineStr">' +
               '<is><t>' + esc(c.titulo) + '</t></is></c>';
      }).join('') + '</row>';

    var corpo = linhas.map(function (linha, li) {
      var r = li + 2;
      return '<row r="' + r + '">' + linha.map(function (valor, ci) {
        var ref = coluna(ci + 1) + r;
        if (colunas[ci] && colunas[ci].tipo === 'data') {
          var n = serialData(valor);
          if (n === null) return '<c r="' + ref + '" s="2"/>';
          return '<c r="' + ref + '" s="3"><v>' + n + '</v></c>';
        }
        return '<c r="' + ref + '" s="2" t="inlineStr"><is><t>' +
               esc(valor) + '</t></is></c>';
      }).join('') + '</row>';
    }).join('');

    var ultima = coluna(colunas.length) + (linhas.length + 1);
    return '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' +
      '<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">' +
      // A primeira linha fica congelada: rolando uma lista de trinta
      // pessoas sem isso, o RH perde de vista o que é cada coluna.
      '<sheetViews><sheetView workbookViewId="0">' +
      '<pane ySplit="1" topLeftCell="A2" activePane="bottomLeft" state="frozen"/>' +
      '</sheetView></sheetViews>' +
      '<sheetFormatPr defaultRowHeight="15"/>' +
      '<cols>' + larguras + '</cols>' +
      '<sheetData>' + cabecalho + corpo + '</sheetData>' +
      // O filtro automático em cima: o RH clica e filtra por situação sem
      // precisar saber montar filtro no Excel.
      '<autoFilter ref="A1:' + ultima + '"/>' +
      '</worksheet>';
  }

  var ESTILOS = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' +
    '<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">' +
    '<numFmts count="1"><numFmt numFmtId="164" formatCode="dd/mm/yyyy"/></numFmts>' +
    '<fonts count="2">' +
      '<font><sz val="11"/><name val="Calibri"/></font>' +
      '<font><b/><sz val="11"/><color rgb="FFFFFFFF"/><name val="Calibri"/></font>' +
    '</fonts>' +
    '<fills count="3">' +
      '<fill><patternFill patternType="none"/></fill>' +
      '<fill><patternFill patternType="gray125"/></fill>' +
      '<fill><patternFill patternType="solid">' +
        '<fgColor rgb="FF0A2E5C"/><bgColor indexed="64"/></patternFill></fill>' +
    '</fills>' +
    '<borders count="2">' +
      '<border><left/><right/><top/><bottom/><diagonal/></border>' +
      '<border><left/><right/><top/>' +
        '<bottom style="thin"><color rgb="FFDDE3EA"/></bottom><diagonal/></border>' +
    '</borders>' +
    '<cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs>' +
    '<cellXfs count="4">' +
      '<xf xfId="0"/>' +
      '<xf xfId="0" fontId="1" fillId="2" borderId="0" applyFont="1" applyFill="1" applyAlignment="1">' +
        '<alignment vertical="center"/></xf>' +
      '<xf xfId="0" borderId="1" applyBorder="1" applyAlignment="1">' +
        '<alignment vertical="center" wrapText="1"/></xf>' +
      '<xf xfId="0" numFmtId="164" borderId="1" applyNumberFormat="1" applyBorder="1" ' +
        'applyAlignment="1"><alignment horizontal="center" vertical="center"/></xf>' +
    '</cellXfs>' +
    // Sem `cellStyles` o arquivo abre, mas os leitores avisam que a
    // planilha nao tem estilo padrao. Excel releva; outros programas
    // mostram o aviso ao usuario, e aviso numa planilha entregue ao
    // cliente parece defeito.
    '<cellStyles count="1">' +
      '<cellStyle name="Normal" xfId="0" builtinId="0"/>' +
    '</cellStyles>' +
    '</styleSheet>';

  /* Gera e baixa a planilha.
     `abas` é [{nome, colunas, linhas}]. */
  function baixar(nomeArquivo, abas) {
    var arquivos = [];

    arquivos.push({
      nome: '[Content_Types].xml',
      conteudo: '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' +
        '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">' +
        '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>' +
        '<Default Extension="xml" ContentType="application/xml"/>' +
        '<Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>' +
        '<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>' +
        abas.map(function (_, i) {
          return '<Override PartName="/xl/worksheets/sheet' + (i + 1) +
                 '.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>';
        }).join('') +
        '</Types>'
    });

    arquivos.push({
      nome: '_rels/.rels',
      conteudo: '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' +
        '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">' +
        '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>' +
        '</Relationships>'
    });

    arquivos.push({
      nome: 'xl/workbook.xml',
      conteudo: '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' +
        '<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" ' +
        'xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">' +
        '<sheets>' + abas.map(function (a, i) {
          // O Excel recusa nome de aba com : \ / ? * [ ] ou com mais de 31
          // caracteres, e recusa o arquivo INTEIRO por causa disso.
          var nome = String(a.nome).replace(/[:\\\/?*\[\]]/g, ' ').slice(0, 31);
          return '<sheet name="' + esc(nome) + '" sheetId="' + (i + 1) +
                 '" r:id="rId' + (i + 1) + '"/>';
        }).join('') + '</sheets></workbook>'
    });

    arquivos.push({
      nome: 'xl/_rels/workbook.xml.rels',
      conteudo: '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' +
        '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">' +
        abas.map(function (_, i) {
          return '<Relationship Id="rId' + (i + 1) +
                 '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet' +
                 (i + 1) + '.xml"/>';
        }).join('') +
        '<Relationship Id="rId' + (abas.length + 1) +
        '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>' +
        '</Relationships>'
    });

    arquivos.push({ nome: 'xl/styles.xml', conteudo: ESTILOS });

    abas.forEach(function (a, i) {
      arquivos.push({
        nome: 'xl/worksheets/sheet' + (i + 1) + '.xml',
        conteudo: aba(a.colunas, a.linhas)
      });
    });

    var blob = zipar(arquivos);
    var url = URL.createObjectURL(blob);
    var a = document.createElement('a');
    a.href = url;
    a.download = nomeArquivo;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    // Sem revogar, o arquivo fica preso na memória do navegador até a aba
    // ser fechada. Com o RH exportando várias vezes, isso se acumula.
    setTimeout(function () { URL.revokeObjectURL(url); }, 2000);
  }

  raiz.Planilha = { baixar: baixar };
})(window);
