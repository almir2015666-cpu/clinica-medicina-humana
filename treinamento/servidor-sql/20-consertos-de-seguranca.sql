-- =====================================================================
--  CONSERTOS DE SEGURANÇA E INTEGRIDADE
--
--  Rode no SQL Editor. Pode rodar mais de uma vez.
--  Rode ANTES de vender o primeiro cupom: dois dos furos abaixo tornam o
--  certificado nominal um documento que não prova nada.
--
--  Vieram de uma revisão feita para achar buraco, não para elogiar. Cada
--  bloco diz o que estava errado e qual era o estrago.
-- =====================================================================


-- =====================================================================
--  1. O CERTIFICADO PASSA A CONGELAR A IDENTIDADE
--
--  O ESTRAGO: `trein_certificado` guardava só o código e a data. Quem
--  conferia o código publicamente lia nome, CPF e empresa AO VIVO da
--  `trein_aluno` — e a política `trein_aluno_upd` deixava o próprio aluno
--  reescrever essas colunas.
--
--  Na prática: um trabalhador resgatava UMA vaga, passava na prova,
--  emitia o certificado e imprimia. Depois trocava o nome e o CPF da
--  própria ficha, imprimia de novo, e repetia. Todas as cópias com o
--  MESMO código, e a página pública mostrando o nome que estivesse no
--  banco naquele instante — ou seja, cada cópia "confere" quando o
--  auditor a valida. Uma conta paga viravam vinte certificados de NR.
--
--  Certificado é um retrato do dia em que foi emitido. Agora ele guarda
--  o próprio retrato.
-- =====================================================================
alter table public.trein_certificado
  add column if not exists nome          text,
  add column if not exists cpf           text,
  add column if not exists empresa       text,
  add column if not exists curso_titulo  text,
  add column if not exists carga_horaria int;

-- os certificados que já existiam recebem o retrato de agora. É o melhor
-- disponível: o de quando foram emitidos ninguém guardou.
update public.trein_certificado ce
   set nome          = coalesce(ce.nome, a.nome),
       cpf           = coalesce(ce.cpf, a.cpf),
       empresa       = coalesce(ce.empresa, a.empresa),
       curso_titulo  = coalesce(ce.curso_titulo, c.titulo),
       carga_horaria = coalesce(ce.carga_horaria, c.carga_horaria)
  from public.trein_matricula m
  join public.trein_aluno a on a.id = m.aluno_id
  join public.trein_curso c on c.id = m.curso_id
 where m.id = ce.matricula_id
   -- a guarda olha TODAS as colunas do retrato, e nao so o nome: uma
   -- execucao interrompida no meio poderia ter gravado o nome e nao o
   -- resto, e "ce.nome is null" nunca mais consertaria isso
   and (ce.nome is null or ce.cpf is null or ce.curso_titulo is null);


-- =====================================================================
--  2. O ALUNO NÃO REESCREVE MAIS A PRÓPRIA IDENTIDADE
--
--  A política antiga dizia `using (id = auth.uid())` e mais nada. RLS
--  escolhe QUAL LINHA pode ser alterada, nunca QUAIS COLUNAS — então
--  "pode editar a própria ficha" era "pode se chamar como quiser".
--
--  Some o UPDATE do aluno. Nome e CPF saem no certificado e não são coisa
--  que a pessoa corrige sozinha: se digitou errado no resgate, quem
--  arruma é a clínica, que vê e registra. O `trein_resgatar` continua
--  gravando normalmente — ele é `security definer` e não passa por RLS.
-- =====================================================================
drop policy if exists trein_aluno_upd on public.trein_aluno;


-- =====================================================================
--  3. EMITIR CERTIFICADO: TRÊS FUROS NUMA FUNÇÃO SÓ
--
--  (a) `v_mat.aluno_id <> auth.uid()` — sem login, `auth.uid()` é NULL, e
--      em SQL `x <> NULL` não é falso: é NULL. `if NULL then` não entra.
--      A checagem de dono SUMIA para quem chamasse sem token. Bastava um
--      `matricula_id` vazado (print de tela, histórico, ticket) para um
--      estranho emitir — ou ler — o certificado alheio.
--
--  (b) Não olhava `cancelada` nem `expira_em`. A empresa estornava o
--      contrato, a clínica cancelava a matrícula, e o aluno emitia assim
--      mesmo: certificado válido, conferível, de um treinamento que não
--      foi pago. Todo o resto do sistema checa esses dois campos; só a
--      emissão não checava.
--
--  (c) `translate(v_codigo, 'OI', '48')` não fazia nada — o código vem de
--      um uuid em hexadecimal, onde nunca há O nem I. A intenção era boa,
--      a linha era decorativa.
-- =====================================================================
create or replace function public.trein_emitir_certificado(p_matricula uuid)
returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  v_mat    public.trein_matricula%rowtype;
  v_curso  public.trein_curso%rowtype;
  v_aluno  public.trein_aluno%rowtype;
  v_cert   public.trein_certificado%rowtype;
  v_codigo text;
begin
  select * into v_mat from public.trein_matricula where id = p_matricula;

  -- `is distinct from` trata NULL como valor: sem login isto é verdadeiro
  -- e a função para aqui, que é o que sempre se quis.
  if not found or v_mat.aluno_id is distinct from auth.uid() then
    raise exception 'MATRICULA_INVALIDA';
  end if;

  -- já existe? devolve o mesmo. Reemitir com código novo invalidaria o
  -- papel que o trabalhador já tem na mão.
  select * into v_cert from public.trein_certificado
   where matricula_id = p_matricula;
  if found then
    return jsonb_build_object('codigo', v_cert.codigo,
                              'emitido_em', v_cert.emitido_em,
                              'valido_ate', v_cert.valido_ate,
                              -- o retrato vai junto: e com ele que a folha
                              -- e impressa, para o papel dizer o mesmo que
                              -- a pagina publica de conferencia
                              'nome', v_cert.nome, 'cpf', v_cert.cpf,
                              'empresa', v_cert.empresa,
                              'curso_titulo', v_cert.curso_titulo,
                              'carga_horaria', v_cert.carga_horaria,
                              'novo', false);
  end if;

  -- Cancelada nunca emite. Vencida também não: o certificado tem de
  -- nascer dentro do prazo que foi pago.
  --
  -- Quem já tem o certificado emitido não é afetado por isto — o retorno
  -- antecipado lá em cima acontece antes, de propósito, para que vencer
  -- não tire de ninguém o documento que já é dele.
  if v_mat.cancelada then
    raise exception 'MATRICULA_CANCELADA';
  end if;
  if v_mat.expira_em < current_date then
    raise exception 'MATRICULA_VENCIDA';
  end if;

  if not exists (select 1 from public.trein_tentativa t
                  where t.matricula_id = p_matricula and t.aprovado) then
    raise exception 'NAO_APROVADO';
  end if;

  select * into v_curso from public.trein_curso where id = v_mat.curso_id;
  select * into v_aluno from public.trein_aluno where id = v_mat.aluno_id;

  -- código curto e conferível. Em hexadecimal não existe letra ambígua,
  -- então não há o que trocar; o `translate` que havia aqui era enfeite.
  v_codigo := upper(
    substr(replace(gen_random_uuid()::text, '-', ''), 1, 4) || '-' ||
    substr(replace(gen_random_uuid()::text, '-', ''), 1, 4) || '-' ||
    substr(replace(gen_random_uuid()::text, '-', ''), 1, 4));

  insert into public.trein_certificado
    (matricula_id, codigo, valido_ate,
     nome, cpf, empresa, curso_titulo, carga_horaria)
  values (p_matricula, v_codigo,
          case when v_curso.validade_meses is not null
               then (current_date + (v_curso.validade_meses || ' months')::interval)::date
          end,
          -- o retrato do dia da emissão
          v_aluno.nome, v_aluno.cpf, v_aluno.empresa,
          v_curso.titulo, v_curso.carga_horaria)
  returning * into v_cert;

  return jsonb_build_object('codigo', v_cert.codigo,
                            'emitido_em', v_cert.emitido_em,
                            'valido_ate', v_cert.valido_ate,
                            'nome', v_cert.nome, 'cpf', v_cert.cpf,
                            'empresa', v_cert.empresa,
                            'curso_titulo', v_cert.curso_titulo,
                            'carga_horaria', v_cert.carga_horaria,
                            'novo', true);
end;
$$;


-- =====================================================================
--  4. A CONFERÊNCIA PÚBLICA LÊ O CERTIFICADO, NÃO A FICHA DO ALUNO
--
--  Com o retrato congelado, mudar a ficha depois não muda mais o que o
--  auditor vê. O `coalesce` cobre certificado antigo que por algum motivo
--  não tenha sido preenchido pelo bloco 1.
-- =====================================================================
create or replace function public.trein_conferir_certificado(p_codigo text)
returns table (nome text, cpf_masc text, empresa text, curso text,
               carga_horaria int, emitido_em timestamptz, valido_ate date)
language sql stable security definer set search_path = public as $$
  select coalesce(ce.nome, a.nome),
         '***.' || substr(coalesce(ce.cpf, a.cpf), 4, 3) || '.' ||
                   substr(coalesce(ce.cpf, a.cpf), 7, 3) || '-**',
         coalesce(ce.empresa, a.empresa),
         coalesce(ce.curso_titulo, c.titulo),
         coalesce(ce.carga_horaria, c.carga_horaria),
         ce.emitido_em, ce.valido_ate
    from public.trein_certificado ce
    join public.trein_matricula m on m.id = ce.matricula_id
    join public.trein_aluno a     on a.id = m.aluno_id
    join public.trein_curso c     on c.id = m.curso_id
   where ce.codigo = upper(trim(p_codigo));
$$;


-- =====================================================================
--  5. ASSISTIR A AULA VOLTA A SER OBRIGATÓRIO
--
--  O ESTRAGO: a trava do vídeo morava toda no navegador. A política de
--  escrita do progresso só perguntava "a matrícula é sua e está no
--  prazo?" — nunca "você assistiu?". Uma linha no console marcava as
--  aulas todas como concluídas, e a prova liberava.
--
--  Para treinamento de NR isso é o risco central do produto: carga
--  horária é justamente o que a fiscalização cobra. Pior, a tela
--  "Acompanhar alunos" lia a MESMA tabela — o painel confirmava a fraude
--  em vez de denunciá-la.
--
--  O gatilho abaixo é a trava de verdade, no banco, onde o navegador não
--  alcança. Três exigências:
--    - a aula tem de ser do curso daquela matrícula;
--    - concluir exige `segundos_vistos` de pelo menos 90% da duração;
--    - o tempo assistido nunca anda para trás (senão bastava zerar e
--      reenviar até achar um número que passasse).
--
--  90%, e não 100%: o `timeupdate` do navegador não bate no último
--  segundo exato, e vídeo re-codificado tem duração com casa decimal.
--  Exigir o número cheio reprovaria quem assistiu tudo.
--
--  Aula sem `duracao_seg` (upload antigo, metadados ilegíveis) passa: é
--  melhor deixar concluir do que prender o aluno num curso que não
--  termina por falha nossa.
-- =====================================================================
-- O RELÓGIO É O DO SERVIDOR, NÃO O NÚMERO QUE O NAVEGADOR MANDA.
--
-- A primeira versão deste gatilho comparava `segundos_vistos` com 90% da
-- duração — e não travava nada. O aluno lê `duracao_seg` na própria tela
-- (a lista de aulas mostra o tempo) e bastava mandar esse número:
--
--     upsert({ segundos_vistos: a.duracao_seg, concluida: true })
--
-- Passava pelos 90% e liberava a prova. Trocar um `true` por um número
-- não é uma trava, é um pedágio.
--
-- O que não se falsifica é o tempo do servidor. A coluna abaixo guarda
-- QUANDO aquela pessoa abriu aquela aula pela primeira vez; concluir exige
-- que tenha passado, no relógio da parede, pelo menos 90% da duração.
-- Quem manda tudo num segundo é recusado, tenha escrito o número que
-- tiver.
alter table public.trein_progresso
  add column if not exists iniciado_em timestamptz;

create or replace function public.trein_progresso_confere()
returns trigger
language plpgsql security definer set search_path = public as $$
declare
  v_curso_da_matricula uuid;
  v_curso_da_aula      uuid;
  v_duracao            int;
  v_antes              int;
  v_inicio             timestamptz;
begin
  select m.curso_id into v_curso_da_matricula
    from public.trein_matricula m where m.id = new.matricula_id;

  select a.curso_id, a.duracao_seg into v_curso_da_aula, v_duracao
    from public.trein_aula a where a.id = new.aula_id;

  if v_curso_da_aula is distinct from v_curso_da_matricula then
    raise exception 'AULA_DE_OUTRO_CURSO';
  end if;

  select p.segundos_vistos, p.iniciado_em into v_antes, v_inicio
    from public.trein_progresso p
   where p.matricula_id = new.matricula_id and p.aula_id = new.aula_id;

  -- o relógio do aluno não volta
  if v_antes is not null and new.segundos_vistos < v_antes then
    new.segundos_vistos := v_antes;
  end if;

  -- a hora de início é do servidor e nunca é reescrita pelo cliente
  new.iniciado_em := coalesce(v_inicio, now());

  if new.concluida and v_duracao is not null and v_duracao > 0 then
    -- 90%, e não 100%: o `timeupdate` do navegador não bate no último
    -- segundo exato, e vídeo recodificado tem duração com casa decimal.
    if new.segundos_vistos < (v_duracao * 0.9) then
      raise exception 'AULA_NAO_ASSISTIDA';
    end if;
    -- e o tempo REAL desde que ele abriu a aula
    if now() - new.iniciado_em < make_interval(secs => v_duracao * 0.9) then
      raise exception 'AULA_RAPIDA_DEMAIS';
    end if;
  end if;

  return new;
end;
$$;

drop trigger if exists trein_progresso_confere_tg on public.trein_progresso;
create trigger trein_progresso_confere_tg
  before insert or update on public.trein_progresso
  for each row execute function public.trein_progresso_confere();


-- =====================================================================
--  6. `revoke ... from anon, authenticated` NÃO REVOGAVA NADA
--
--  O Postgres concede EXECUTE a PUBLIC em toda função nova, e privilégio
--  é aditivo: tirar de `anon` não toca a concessão a PUBLIC, que continua
--  valendo para `anon` e para `authenticated`. A barreira que o
--  01-esquema.sql acreditava ter nunca existiu.
--
--  O revoke certo é `from public`. Depois dele, concede-se de novo, um a
--  um, só para quem deve.
-- =====================================================================
revoke execute on function public.trein_resgatar(text, uuid, text, text, text, text) from public, anon, authenticated;
revoke execute on function public.trein_emitir_certificado(uuid)  from public;
revoke execute on function public.trein_conferir_certificado(text) from public;
revoke execute on function public.trein_espiar_cupom(text)         from public;

-- e agora, de propósito, quem pode o quê:
grant execute on function public.trein_emitir_certificado(uuid)   to authenticated;
grant execute on function public.trein_conferir_certificado(text) to anon, authenticated;
grant execute on function public.trein_espiar_cupom(text)         to anon, authenticated;
grant execute on function public.trein_resgatar(text, uuid, text, text, text, text) to service_role;

-- ATENÇÃO — trein_pode_ver E trein_is_equipe NÃO ENTRAM AQUI, DE PROPÓSITO.
--
-- Uma versão anterior deste arquivo revogava as duas, com a justificativa
-- de que "políticas de RLS rodam como dono e não precisam de grant".
-- ISSO ESTÁ ERRADO, e o erro era capaz de derrubar o site inteiro.
--
-- A expressão de uma política é avaliada com o papel de QUEM FEZ a
-- consulta. Ser `security definer` muda o que a função enxerga por dentro,
-- não quem tem permissão de chamá-la. Sem EXECUTE, toda política que as
-- usa levanta "permission denied for function": trein_curso_publico (a
-- vitrine), trein_aula_lib (as aulas), trein_stor_read (os vídeos) e todas
-- as *_equipe (o admin) — tudo fora do ar de uma vez, e por um revoke que
-- não consertava nada.
grant execute on function public.trein_pode_ver(uuid)  to anon, authenticated;
grant execute on function public.trein_is_equipe()     to anon, authenticated;


-- =====================================================================
--  7. A EQUIPE PRECISA CONSEGUIR APAGAR UM RESGATE
--
--  `trein_resgate` só tinha política de SELECT. Num estorno, a equipe
--  mandava o DELETE, a RLS descartava calada, e a tela dizia "pronto"
--  sem ter feito nada — a vaga continuava consumida.
-- =====================================================================
drop policy if exists trein_resgate_equipe_w on public.trein_resgate;
create policy trein_resgate_equipe_w on public.trein_resgate
  for all using (public.trein_is_equipe()) with check (public.trein_is_equipe());


-- =====================================================================
--  Confira
-- =====================================================================
-- (a) o aluno não tem mais política de UPDATE na própria ficha:
select policyname, cmd from pg_policies
 where schemaname = 'public' and tablename = 'trein_aluno' order by policyname;

-- (b) o gatilho está armado:
select tgname, tgenabled from pg_trigger
 where tgrelid = 'public.trein_progresso'::regclass and not tgisinternal;

-- (c) quem pode chamar o resgate direto (tem de vir VAZIO — só a service
--     role, que não aparece aqui):
select 'trein_resgatar' as funcao, r.rolname
  from pg_roles r
 where r.rolname in ('anon','authenticated','public')
   and has_function_privilege(r.rolname,
       'public.trein_resgatar(text,uuid,text,text,text,text)', 'execute');

-- (d) os certificados já têm o retrato congelado:
select codigo, nome, curso_titulo, emitido_em
  from public.trein_certificado order by emitido_em desc limit 20;
