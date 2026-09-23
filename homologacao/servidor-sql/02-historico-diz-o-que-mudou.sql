-- =====================================================================
--  HOMOLOGAÇÃO — o histórico deixa de repetir, e passa a dizer O QUÊ
--
--  Rode UMA VEZ no SQL Editor do Supabase. Pode rodar de novo.
--  Depende do 01-esquema.sql.
--
--  DOIS DEFEITOS, UM GATILHO SÓ
--  ----------------------------
--  1. O HISTÓRICO REPETIA. O `homol_processo_historico` gravava um evento
--     em TODO update, mesmo quando nada tinha mudado. Salvar o mesmo
--     parecer duas vezes — e dá, porque o botão volta a ficar clicável —
--     enchia a linha do tempo de "Parecer: Pendente" iguais, um debaixo
--     do outro. Quem abrisse o processo depois não sabia se o médico
--     mudara de ideia duas vezes ou se era a tela a duplicar.
--
--  2. ALTERAR UM PROCESSO JÁ DECIDIDO NÃO DEIXAVA RASTRO ÚTIL. A empresa
--     consegue corrigir a matrícula, o nome, as datas e os dias DEPOIS de
--     o médico ter aprovado — e o histórico dizia só "Processo corrigido
--     e reenviado à clínica". O parecer continuava "Aprovado", agora
--     sobre outros dados, e não havia como saber o que tinha mudado.
--
--     Num atestado isso não é detalhe: mudar de 7 para 17 dias depois do
--     aprovado troca a conta do afastamento, e mudar a CID troca a regra
--     dos 60 dias. O médico assinou uma coisa e ficou outra no lugar.
--
--  O QUE ESTE ARQUIVO FAZ
--  ----------------------
--  a) update que não muda nada NÃO grava evento;
--  b) update que muda um campo grava "Campo: de X para Y", um por linha;
--  c) se o processo JÁ TINHA PARECER e os dados do atestado mudaram, o
--     evento começa com "ALTERADO DEPOIS DO PARECER" — é o que a pessoa
--     que abrir o processo precisa ver primeiro.
--
--  NÃO BLOQUEIA A ALTERAÇÃO, e é de propósito. Erro de digitação na
--  matrícula existe e tem de poder ser corrigido; o que não pode é ser
--  corrigido em silêncio. Bloquear levaria a empresa a abrir um processo
--  novo para o mesmo atestado, e aí o histórico do colaborador — que já
--  casa por matrícula — ficaria pior ainda.
-- =====================================================================

create or replace function public.homol_processo_historico()
returns trigger
language plpgsql security definer set search_path = public as $$
declare
  quem    text := coalesce(public.homol_meu_nome(), 'Sistema');
  txt     text;
  mudou   text[] := '{}';
  decidido boolean;
  -- Cada comparação usa `is distinct from`, e não `<>`: nulo `<>` seja o
  -- que for dá nulo, e um campo que sai do vazio para preenchido é
  -- justamente uma das mudanças que mais interessa ver.
begin
  if tg_op = 'INSERT' then
    insert into public.homol_evento (processo_id, quem_id, quem_nome, oque,
                                     comentario)
    values (new.id, auth.uid(), quem,
            'Processo aberto e enviado à clínica', false);
    return null;
  end if;

  -- O PARECER TEM LINHA PRÓPRIA: é a decisão, e não uma alteração de
  -- dado. Só conta quando o carimbo muda — salvar o mesmo parecer de
  -- novo não carimba nada, e por isso não repete.
  if new.parecer_em is distinct from old.parecer_em then
    insert into public.homol_evento (processo_id, quem_id, quem_nome, oque,
                                     comentario)
    values (new.id, auth.uid(), quem,
            'Parecer: ' || new.parecer ||
            coalesce('. Motivo: ' || nullif(btrim(new.parecer_obs), ''), ''),
            false);
    return null;
  end if;

  -- O QUE MUDOU, campo a campo. Só os que a empresa preenche: os
  -- carimbos (atualizado_em, atividade) mudam sozinhos e não são
  -- alteração de ninguém.
  if new.chapa is distinct from old.chapa then
    mudou := mudou || ('Matrícula: ' || coalesce(old.chapa, '(vazio)') ||
                       ' → ' || coalesce(new.chapa, '(vazio)'));
  end if;
  if new.nome is distinct from old.nome then
    mudou := mudou || ('Nome: ' || coalesce(old.nome, '(vazio)') ||
                       ' → ' || coalesce(new.nome, '(vazio)'));
  end if;
  if new.filial is distinct from old.filial then
    mudou := mudou || ('Filial: ' || coalesce(old.filial, '(vazio)') ||
                       ' → ' || coalesce(new.filial, '(vazio)'));
  end if;
  if new.inicio is distinct from old.inicio then
    mudou := mudou || ('Início: ' || to_char(old.inicio, 'DD/MM/YYYY') ||
                       ' → ' || to_char(new.inicio, 'DD/MM/YYYY'));
  end if;
  if new.hora_inicio is distinct from old.hora_inicio then
    mudou := mudou || ('Hora: ' || to_char(old.hora_inicio, 'HH24:MI') ||
                       ' → ' || to_char(new.hora_inicio, 'HH24:MI'));
  end if;
  if new.dias is distinct from old.dias then
    mudou := mudou || ('Dias: ' || old.dias || ' → ' || new.dias);
  end if;
  if new.tipo is distinct from old.tipo then
    mudou := mudou || ('Tipo de atestado: ' ||
                       coalesce(old.tipo ->> 'nome', '(vazio)') || ' → ' ||
                       coalesce(new.tipo ->> 'nome', '(vazio)'));
  end if;
  if new.cid is distinct from old.cid then
    mudou := mudou || ('CID: ' ||
                       coalesce(old.cid ->> 'codigo', '(vazio)') || ' → ' ||
                       coalesce(new.cid ->> 'codigo', '(vazio)'));
  end if;
  if new.entidade is distinct from old.entidade then
    mudou := mudou || ('Entidade: ' ||
                       coalesce(old.entidade ->> 'nome', '(vazio)') || ' → ' ||
                       coalesce(new.entidade ->> 'nome', '(vazio)'));
  end if;
  if new.medico is distinct from old.medico then
    mudou := mudou || ('Médico: ' ||
                       coalesce(old.medico ->> 'nome', '(vazio)') || ' → ' ||
                       coalesce(new.medico ->> 'nome', '(vazio)'));
  end if;
  if new.observacoes is distinct from old.observacoes then
    mudou := mudou || 'Observações da empresa alteradas';
  end if;

  -- NADA MUDOU: NADA SE ESCREVE.
  --
  -- É esta linha que faz o histórico parar de encher de eventos iguais
  -- quando alguém salva duas vezes seguidas.
  if array_length(mudou, 1) is null then
    return null;
  end if;

  -- JÁ TINHA PARECER? Então isto é alteração DEPOIS da decisão, e o
  -- aviso vem na frente — é o que quem abrir o processo tem de ver
  -- primeiro, antes de confiar no "Aprovado" que está na tela.
  decidido := old.parecer_em is not null;
  txt := case when decidido
              then 'ALTERADO DEPOIS DO PARECER (' || old.parecer || '): '
              else 'Processo corrigido e reenviado à clínica: ' end
         || array_to_string(mudou, '; ');

  insert into public.homol_evento (processo_id, quem_id, quem_nome, oque,
                                   comentario)
  values (new.id, auth.uid(), quem, left(txt, 4000), false);
  return null;
end;
$$;

-- O gatilho em si não muda: continua `after insert or update`, apontando
-- para esta função. Recriado só para o caso de o 01 não ter sido rodado
-- nesta ordem.
drop trigger if exists trg_homol_processo_historico on public.homol_processo;
create trigger trg_homol_processo_historico
  after insert or update on public.homol_processo
  for each row execute function public.homol_processo_historico();


-- ---------------------------------------------------------- conferência
--  1. a função existe e já sabe falar de alteração depois do parecer
select proname,
       (prosrc like '%ALTERADO DEPOIS DO PARECER%') as avisa_alteracao,
       (prosrc like '%array_length(mudou, 1) is null%') as nao_repete
  from pg_proc where proname = 'homol_processo_historico';

--  2. quantos processos já têm evento repetido hoje (o passivo)
select processo_id, oque, count(*) as vezes
  from public.homol_evento
 where comentario = false
 group by processo_id, oque
having count(*) > 1
 order by vezes desc
 limit 20;
