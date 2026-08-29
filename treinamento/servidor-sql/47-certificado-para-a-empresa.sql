-- =====================================================================
--  O RH PASSA A PODER PUXAR O CERTIFICADO DA EQUIPE
--
--  Rode DEPOIS do 46. Pode rodar mais de uma vez.
--
--  O PROBLEMA
--  O certificado só abre para o próprio aluno, logado. Faz sentido para o
--  aluno e não faz para a empresa: quem guarda o documento numa pasta por
--  anos, e quem o mostra ao auditor, é o RH. Hoje ele precisa pedir a
--  cada trabalhador que baixe e reenvie, um por um.
--
--  A REGRA
--  O RH puxa o certificado de quem está na turma DELE, e de mais ninguém.
--  Quem decide isso é o login, e não o navegador: a função confere que o
--  CNPJ do cupom daquela matrícula é o CNPJ do RH que está pedindo.
--
--  POR QUE O CPF SAI INTEIRO AQUI
--  Na lista da turma ele é mascarado, porque lá o RH só precisa
--  reconhecer a pessoa. No certificado ele sai inteiro porque É O
--  DOCUMENTO: certificado de NR sem CPF completo não vale numa
--  fiscalização, e é a própria empresa que já tem esse dado na folha de
--  pagamento.
-- =====================================================================

create or replace function public.trein_certificado_da_empresa(p_codigo text)
returns table (
  codigo                text,
  nome                  text,
  cpf                   text,
  empresa               text,
  curso_titulo          text,
  curso_codigo          text,
  titulo_certificado    text,
  conteudo_programatico text,
  carga_horaria         int,
  emitido_em            timestamptz,
  valido_ate            date
)
language plpgsql stable security definer set search_path = public as $$
declare
  v_rh public.trein_rh%rowtype;
begin
  select * into v_rh from public.trein_rh where id = auth.uid();
  if not found or not v_rh.ativo then
    raise exception 'SEM_ACESSO';
  end if;

  return query
  select ce.codigo, ce.nome, ce.cpf, cu.empresa,
         ce.curso_titulo, c.codigo,
         c.titulo_certificado, c.conteudo_programatico,
         ce.carga_horaria, ce.emitido_em, ce.valido_ate
    from public.trein_certificado ce
    join public.trein_matricula m on m.id = ce.matricula_id
    join public.trein_cupom cu on cu.id = m.cupom_id
    join public.trein_curso c on c.id = m.curso_id
   where ce.codigo = p_codigo
     -- O AMARRE ESTA AQUI. Sem esta linha, qualquer RH logado puxaria o
     -- certificado de qualquer empresa, bastando ter o codigo, que e
     -- justamente o que aparece impresso no papel.
     and regexp_replace(coalesce(cu.empresa_cnpj, ''), '\D', '', 'g')
       = v_rh.empresa_cnpj;
end;
$$;
revoke execute on function public.trein_certificado_da_empresa(text) from public;
grant execute on function public.trein_certificado_da_empresa(text) to authenticated;

-- =====================================================================
--  Confira
-- =====================================================================
select p.proname,
       has_function_privilege('anon', p.oid, 'execute')          as anon_executa,
       has_function_privilege('authenticated', p.oid, 'execute') as logado_executa
  from pg_proc p join pg_namespace n on n.oid = p.pronamespace
 where n.nspname = 'public' and p.proname = 'trein_certificado_da_empresa';
-- anon_executa tem de vir `false`, e logado_executa `true`.
