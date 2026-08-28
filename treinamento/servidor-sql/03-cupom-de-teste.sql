-- =====================================================================
--  Um cupom de teste, para conferir se tudo funciona antes de vender
--
--  Rode DEPOIS do 01 e do 02.
--  Supabase > SQL Editor > New query > cole > Run
--
--  Cria o código TESTE-2026 com 3 vagas, valendo para dois cursos. Use no
--  site em /treinamento/entrar.html, aba "Tenho um código", com um CPF
--  qualquer que seja VÁLIDO (o dígito verificador é conferido de verdade).
--
--  Quando terminar de testar, o fim do arquivo mostra como apagar tudo o
--  que o teste criou.
-- =====================================================================

-- 1. o cupom
insert into public.trein_cupom
  (codigo, empresa, contato, quantidade, expira_resgate, acesso_dias,
   observacao, criado_por)
values
  ('TESTE-2026', 'EMPRESA DE TESTE LTDA', 'teste', 3,
   current_date + 90,      -- dá para resgatar por 90 dias
   365,                    -- quem resgatar fica 1 ano com o curso
   'cupom de teste — apagar depois', 'teste')
on conflict (codigo) do update set
  quantidade     = excluded.quantidade,
  expira_resgate = excluded.expira_resgate,
  ativo          = true;

-- 2. quais cursos ele libera
insert into public.trein_cupom_curso (cupom_id, curso_id)
select c.id, k.id
  from public.trein_cupom c
  join public.trein_curso k on k.codigo in ('NR-35', 'NR-06')
 where c.codigo = 'TESTE-2026'
on conflict do nothing;

-- 3. confira
select c.codigo, c.empresa, c.quantidade,
       c.expira_resgate, c.acesso_dias,
       (select count(*) from public.trein_cupom_curso cc where cc.cupom_id = c.id) as cursos,
       (select count(*) from public.trein_resgate  r  where r.cupom_id  = c.id) as ja_resgataram
  from public.trein_cupom c
 where c.codigo = 'TESTE-2026';


-- =====================================================================
--  DEPOIS DO TESTE — apaga o cupom e quem resgatou por ele
--
--  Descomente e rode. O aluno criado no teste continua existindo no Auth;
--  a última linha mostra como achá-lo para apagar pelo painel
--  (Authentication > Users), se quiser limpar de vez.
-- =====================================================================
-- delete from public.trein_cupom where codigo = 'TESTE-2026';
-- select a.cpf, a.nome, a.criado_em from public.trein_aluno a
--  where a.empresa = 'EMPRESA DE TESTE LTDA';
