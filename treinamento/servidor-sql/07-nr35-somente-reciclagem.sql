-- =====================================================================
--  NR-35: fora do catálogo EaD, exceto a reciclagem
--
--  Rode DEPOIS do 02. Pode rodar mais de uma vez.
--
--  POR QUE
--  -------
--  A Portaria MTE nº 1.259, de 15 de julho de 2026, alterou a NR-35: o
--  treinamento INICIAL não pode mais ser feito a distância, nem em EaD nem
--  em semipresencial. Como esta plataforma é 100% EaD, o inicial sai do
--  catálogo.
--
--  A reciclagem (periódico) CONTINUA permitida em EaD — a Portaria não
--  mexeu nessa parte. Por isso ela fica, com o nome dizendo claramente o
--  que é: vender "NR-35" sem qualificar é o caminho para alguém comprar
--  achando que é o inicial.
--
--  A Portaria deu prazo de 1 ano para as empresas adequarem os iniciais
--  que já foram feitos em EaD.
-- =====================================================================

-- 1) o inicial sai de circulação. Desativar, e não apagar: se alguém já
--    comprou, o histórico e o certificado dele têm de continuar existindo.
update public.trein_curso
   set ativo = false,
       subtitulo = 'Indisponível em EaD — Portaria MTE 1.259/2026'
 where codigo = 'NR-35';

-- 2) entra a reciclagem, que segue permitida a distância
insert into public.trein_curso
  (codigo, titulo, subtitulo, carga_horaria, validade_meses, nota_minima,
   descricao, ordem)
values
  ('NR-35-REC', 'Trabalho em altura (reciclagem)',
   'Periódico, permitido em EaD', 8, 24, 70,
   'Reciclagem periódica da NR-35, para quem já fez o treinamento inicial '
   'presencial. O inicial não é oferecido a distância, conforme a Portaria '
   'MTE 1.259/2026.', 1)
on conflict (codigo) do update set
  titulo        = excluded.titulo,
  subtitulo     = excluded.subtitulo,
  descricao     = excluded.descricao,
  carga_horaria = excluded.carga_horaria,
  ativo         = true;

-- Confira o que o site vai mostrar:
select codigo, titulo, carga_horaria, ativo
  from public.trein_curso
 order by ativo desc, ordem;
