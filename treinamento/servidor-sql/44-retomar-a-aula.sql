-- =====================================================================
--  A AULA PASSA A CONTINUAR DE ONDE PAROU
--
--  Rode quando quiser. Pode rodar mais de uma vez.
--
--  O QUE MUDA PARA O ALUNO
--  Sair da página deixa de fazer a aula recomeçar do zero. Quem assistiu
--  35 dos 40 minutos e perdeu a conexão volta aos 35, e não aos 0.
--
--  O QUE PRECISOU MUDAR NO SERVIDOR
--  Enquanto a aula recomeçava sempre, `segundos_vistos` era só um número
--  de tela: mesmo que alguém escrevesse um valor enorme, a aula reiniciava
--  na próxima abertura e a conclusão continuava presa ao tempo real.
--
--  Com a retomada, esse número passa a decidir ONDE o vídeo começa. E aí
--  ele vira um alvo: bastaria gravar `segundos_vistos` alto uma vez para
--  o vídeo abrir perto do fim, e esperar o relógio correr sem assistir.
--
--  A trava nova é uma frase só: NINGUÉM ASSISTE MAIS SEGUNDOS DO QUE O
--  RELÓGIO ANDOU. O progresso não pode crescer mais rápido que o tempo
--  real, e o excesso é aparado em vez de recusado, para não quebrar a
--  sessão de quem está assistindo direito.
-- =====================================================================

create or replace function public.trein_progresso_confere()
returns trigger
language plpgsql security definer set search_path = public as $$
declare
  v_curso_da_matricula uuid;
  v_curso_da_aula      uuid;
  v_duracao            int;
  v_antes              int;
  v_inicio             timestamptz;
  v_ultimo             timestamptz;
  v_teto               int;
begin
  select m.curso_id into v_curso_da_matricula
    from public.trein_matricula m where m.id = new.matricula_id;

  select a.curso_id, a.duracao_seg into v_curso_da_aula, v_duracao
    from public.trein_aula a where a.id = new.aula_id;

  if v_curso_da_aula is distinct from v_curso_da_matricula then
    raise exception 'AULA_DE_OUTRO_CURSO';
  end if;

  select p.segundos_vistos, p.iniciado_em, p.atualizado_em
    into v_antes, v_inicio, v_ultimo
    from public.trein_progresso p
   where p.matricula_id = new.matricula_id and p.aula_id = new.aula_id;

  -- o relógio do aluno não volta
  if v_antes is not null and new.segundos_vistos < v_antes then
    new.segundos_vistos := v_antes;
  end if;

  -- a hora de início é do servidor e nunca é reescrita pelo cliente
  new.iniciado_em := coalesce(v_inicio, now());
  new.atualizado_em := now();

  -- NINGUÉM ASSISTE MAIS SEGUNDOS DO QUE O RELÓGIO ANDOU.
  --
  -- O progresso só pode crescer o tanto de tempo que passou de verdade
  -- desde a última gravação. Com 60 segundos de tolerância, que cobrem
  -- folgado o intervalo entre gravações e qualquer diferença de relógio.
  --
  -- Aparar em vez de recusar é de propósito: quem está assistindo direito
  -- nunca chega perto deste teto, e quem tentar forçar simplesmente não
  -- ganha o crédito, sem levar erro na cara no meio da aula.
  if v_antes is not null then
    v_teto := v_antes
            + ceil(extract(epoch from (now() - coalesce(v_ultimo, v_inicio))))::int
            + 60;
    if new.segundos_vistos > v_teto then
      new.segundos_vistos := v_teto;
    end if;
  elsif new.segundos_vistos > 60 then
    -- primeira gravação desta aula: não existe passado para creditar
    new.segundos_vistos := 60;
  end if;

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

-- =====================================================================
--  Confira
-- =====================================================================
-- A função tem de aparecer com a trava nova.
select proname,
       pg_get_functiondef(oid) like '%v_teto%' as apara_o_excesso,
       pg_get_functiondef(oid) like '%AULA_RAPIDA_DEMAIS%' as confere_o_tempo_real
  from pg_proc
 where proname = 'trein_progresso_confere';

-- E o gatilho continua ligado na tabela.
select tgname, tgenabled
  from pg_trigger
 where tgrelid = 'public.trein_progresso'::regclass and not tgisinternal;
