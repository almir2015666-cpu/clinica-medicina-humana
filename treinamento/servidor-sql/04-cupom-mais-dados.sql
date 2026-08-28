-- =====================================================================
--  Mais dados no cupom: pessoa física, contato e controle da venda
--
--  Rode DEPOIS do 01-esquema.sql, no SQL Editor.
--  Pode rodar mais de uma vez: o `if not exists` ignora o que já existe.
--
--  POR QUE ESTAS COLUNAS
--  ---------------------
--  O cupom nasceu pensando só em empresa. Mas há venda para pessoa física
--  — o trabalhador autônomo que precisa do NR-35 para entrar na obra —, e
--  aí não há CNPJ. Daí `tipo_pessoa` e um `documento` único, que guarda o
--  CNPJ ou o CPF conforme o caso.
--
--  O resto é o que faltava para o cupom servir de registro da venda: por
--  onde mandar o código (e-mail e WhatsApp), quanto foi cobrado, se já
--  pagou e o número da nota. Sem isso, saber "quanto vendemos de curso
--  este mês" exigiria cruzar o cupom com outra planilha à mão.
-- =====================================================================

alter table public.trein_cupom
  -- PJ | PF. Muda o rótulo na tela e o documento que se cobra.
  add column if not exists tipo_pessoa     text not null default 'PJ',
  -- CNPJ ou CPF, só dígitos. Substitui o empresa_cnpj, que só servia para PJ.
  add column if not exists documento       text,
  add column if not exists email           text,
  add column if not exists telefone        text,
  -- quanto foi cobrado por este cupom, no total
  add column if not exists valor           numeric(10,2),
  -- não liberar antes de receber é decisão de vocês; aqui só fica o registro
  add column if not exists pago            boolean not null default false,
  add column if not exists forma_pagamento text,
  add column if not exists nota_fiscal     text;

-- o que já existia em empresa_cnpj passa a viver em documento
update public.trein_cupom
   set documento = empresa_cnpj
 where documento is null and empresa_cnpj is not null;

-- acha o cliente pelo documento sem varrer a tabela inteira
create index if not exists idx_trein_cupom_doc on public.trein_cupom(documento);

comment on column public.trein_cupom.empresa_cnpj is
  'Não usar. Substituída por documento (CNPJ ou CPF). Mantida só para não '
  'quebrar cupom antigo.';

-- Confira:
select codigo, tipo_pessoa, empresa, documento, valor, pago
  from public.trein_cupom order by criado_em desc limit 10;
