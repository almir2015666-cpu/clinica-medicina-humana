-- =====================================================================
--  PRAZO VENCIDO ENCERRA O ACESSO, TAMBÉM NA APOSTILA
--
--  Rode DEPOIS do 33. Pode rodar mais de uma vez.
--
--  Por que este arquivo existe
--  ---------------------------
--  O resto do sistema já tratava vencimento como fim de acesso: as aulas,
--  o vídeo no Storage, a prova e a emissão do certificado conferem
--  `expira_em >= current_date` desde o 01 e o 20.
--
--  A apostila foi a exceção, e foi de propósito: escrevi no 33 que quem já
--  estudou podia continuar consultando o material. A clínica decidiu o
--  contrário — vencido não entra, e ponto. O acesso é o que se vende, com
--  prazo; deixar uma porta aberta faz o prazo parecer sugestão.
--
--  Uma exceção fica: `cancelada` continua barrando na hora, e vencimento
--  passa a barrar igual. As duas viram a mesma coisa para o aluno.
-- =====================================================================

create or replace function public.trein_apostila(p_matricula uuid)
returns table (codigo text, titulo text, carga_horaria int, apostila text)
language plpgsql stable security definer set search_path = public as $$
declare
  v_mat public.trein_matricula%rowtype;
begin
  select * into v_mat from public.trein_matricula where id = p_matricula;

  -- `is distinct from` e não `<>`: sem login `auth.uid()` é NULL, e em SQL
  -- `x <> NULL` não é falso, é NULL — a comparação não barraria ninguém.
  if not found or v_mat.aluno_id is distinct from auth.uid() then
    raise exception 'MATRICULA_INVALIDA';
  end if;
  if v_mat.cancelada then
    raise exception 'MATRICULA_CANCELADA';
  end if;
  if v_mat.expira_em < current_date then
    raise exception 'MATRICULA_VENCIDA';
  end if;

  return query
    select c.codigo, c.titulo, c.carga_horaria, c.apostila
      from public.trein_curso c
     where c.id = v_mat.curso_id;
end;
$$;
revoke execute on function public.trein_apostila(uuid) from public;
grant execute on function public.trein_apostila(uuid) to authenticated;

-- =====================================================================
--  Confira
-- =====================================================================
-- Deve listar TRÊS linhas e, na coluna `olha_o_prazo`, `true` nas três. Se
-- alguma vier `false`, aquela porta ainda abre para vencido; se vierem
-- menos de três linhas, algum arquivo anterior não rodou.
--
-- (A prova não aparece aqui porque não é função do banco: é a Edge
-- Function `prova`, que confere o prazo em TypeScript, no próprio arquivo.)
select p.proname as funcao,
       pg_get_functiondef(p.oid) like '%expira_em%' as olha_o_prazo
  from pg_proc p
  join pg_namespace n on n.oid = p.pronamespace
 where n.nspname = 'public'
   and p.proname in ('trein_pode_ver', 'trein_apostila',
                     'trein_emitir_certificado')
 order by p.proname;

-- E quantas matrículas o vencimento passa a fechar hoje.
select count(*) filter (where expira_em >= current_date) as no_prazo,
       count(*) filter (where expira_em <  current_date) as vencidas,
       count(*) filter (where cancelada)                 as canceladas
  from public.trein_matricula;
