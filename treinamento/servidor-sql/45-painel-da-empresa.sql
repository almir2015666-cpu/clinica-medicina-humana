-- =====================================================================
--  O PAINEL DO RH DA EMPRESA CLIENTE
--
--  Rode quando quiser. Pode rodar mais de uma vez.
--
--  O PROBLEMA QUE ELE RESOLVE
--  Hoje quem enxerga o andamento é só a clínica. O RH da empresa que
--  comprou fica ligando para perguntar quem já terminou, e descobre que
--  alguém não fez quando o auditor pergunta pelo certificado.
--
--  QUEM ENTRA, E COMO
--  O RH não tem conta e não vai ter: uma senha a mais é uma senha a
--  esquecer, e conta para cliente é cadastro para manter. Ele usa o que
--  já está na mão dele, o CÓDIGO DO CUPOM que a clínica enviou.
--
--  O QUE O CÓDIGO ABRE, E O QUE NÃO ABRE
--  Ele abre a turma DAQUELE cupom, e nada mais. Não existe listagem
--  geral, não dá para pedir outra empresa, e o código de uma empresa não
--  serve para a outra.
--
--  E ele mostra menos do que a clínica vê, de propósito:
--    - CPF sai mascarado;
--    - nota da reprovação não aparece, nem quantas tentativas foram;
--    - o RH precisa saber quem está pendente, e não humilhar ninguém.
--
--  SOBRE A FORÇA DO CÓDIGO
--  Aqui o código funciona como senha, e senha curta se adivinha. Os
--  códigos gerados pelo SistemaCMH têm três blocos, o que torna a
--  tentativa por força bruta impraticável na prática. Ainda assim, quem
--  tiver o código vê a turma: ele deve ser tratado como o documento que
--  é, e não colado em grupo de WhatsApp aberto.
-- =====================================================================

create or replace function public.trein_turma_do_cupom(p_codigo text)
returns table (
  empresa        text,
  aluno          text,
  cpf_masc       text,
  curso          text,
  codigo_curso   text,
  carga_horaria  int,
  situacao       text,
  aulas_feitas   int,
  aulas_total    int,
  expira_em      date,
  certificado    text,
  emitido_em     date
)
language plpgsql stable security definer set search_path = public as $$
declare
  v_cupom public.trein_cupom%rowtype;
begin
  -- Espaço e caixa não podem separar quem tem o código de quem não tem:
  -- o RH copia de um PDF e cola com espaço no fim mais vezes do que não.
  select * into v_cupom
    from public.trein_cupom
   where upper(regexp_replace(codigo, '\s', '', 'g'))
       = upper(regexp_replace(coalesce(p_codigo, ''), '\s', '', 'g'));

  if not found then
    raise exception 'CUPOM_NAO_ENCONTRADO';
  end if;

  return query
  select
    v_cupom.empresa,
    al.nome,
    -- 074.421.955-80 vira 074.***.***-80: sobra o suficiente para o RH
    -- reconhecer de quem se trata na folha de pagamento, e não o
    -- suficiente para virar cadastro de terceiro.
    case when length(regexp_replace(al.cpf, '\D', '', 'g')) = 11
         then substr(regexp_replace(al.cpf, '\D', '', 'g'), 1, 3)
              || '.***.***-'
              || substr(regexp_replace(al.cpf, '\D', '', 'g'), 10, 2)
         else '***' end,
    c.titulo,
    c.codigo,
    c.carga_horaria,
    case
      when ce.id is not null and m.expira_em < current_date then 'Aprovado, vencido'
      when ce.id is not null                                then 'Aprovado'
      when m.cancelada                                      then 'Cancelado'
      when m.expira_em < current_date                       then 'Prazo vencido'
      when coalesce(feitas.q, 0) = 0                        then 'Não começou'
      when coalesce(feitas.q, 0) >= coalesce(tot.q, 0)
       and coalesce(tot.q, 0) > 0                           then 'Aulas concluídas, falta a prova'
      else 'Em andamento'
    end,
    coalesce(feitas.q, 0)::int,
    coalesce(tot.q, 0)::int,
    m.expira_em,
    ce.codigo,
    ce.emitido_em::date
  from public.trein_resgate r
  join public.trein_aluno al on al.id = r.aluno_id
  join public.trein_matricula m on m.aluno_id = al.id and m.cupom_id = v_cupom.id
  join public.trein_curso c on c.id = m.curso_id
  left join public.trein_certificado ce on ce.matricula_id = m.id
  left join lateral (
    select count(*) as q from public.trein_aula a where a.curso_id = c.id
  ) tot on true
  left join lateral (
    select count(*) as q from public.trein_progresso p
     where p.matricula_id = m.id and p.concluida
  ) feitas on true
  where r.cupom_id = v_cupom.id
  order by al.nome, c.ordem;
end;
$$;

-- `anon` executa de propósito: o RH não tem login, e é o código que
-- autoriza. A função não aceita "me dê tudo": sem um código válido, ela
-- levanta exceção antes de chegar na consulta.
revoke execute on function public.trein_turma_do_cupom(text) from public;
grant execute on function public.trein_turma_do_cupom(text) to anon, authenticated;

-- =====================================================================
--  Confira
-- =====================================================================
-- (a) A função existe e está liberada para quem não tem login.
select p.proname,
       has_function_privilege('anon', p.oid, 'execute') as anon_executa
  from pg_proc p join pg_namespace n on n.oid = p.pronamespace
 where n.nspname = 'public' and p.proname = 'trein_turma_do_cupom';

-- (b) Código inexistente tem de dar erro, e não lista vazia. Se esta
--     linha devolver alguma coisa em vez de erro, me avise.
--     (Rode separado: ela FALHA de propósito.)
-- select * from public.trein_turma_do_cupom('NAO-EXISTE-ESTE');

-- (c) Um cupom de verdade, para ver o formato. Troque pelo seu.
-- select * from public.trein_turma_do_cupom('COLE-UM-CODIGO-AQUI');
