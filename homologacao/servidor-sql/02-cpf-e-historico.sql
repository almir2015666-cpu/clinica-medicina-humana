-- =====================================================================
--  HOMOLOGAÇÃO — o CPF no lugar da matrícula, e o histórico que explica
--
--  ESTE É O ÚNICO ARQUIVO A RODAR depois do 01-esquema.sql. Ele traz
--  duas coisas que antes estavam separadas:
--
--    1. o colaborador passa a ser identificado pelo CPF;
--    2. o histórico do processo para de repetir e passa a dizer O QUÊ
--       mudou, campo a campo, avisando quando alguém altera um processo
--       que JÁ tinha parecer.
--
--  Cole INTEIRO no SQL Editor do Supabase e clique em Run. Pode rodar de
--  novo: tudo aqui é "if not exists" ou "create or replace", e nada é
--  apagado.
--
--  POR QUE TROCAR A MATRÍCULA PELO CPF
--  -----------------------------------
--  A matrícula é o número que a EMPRESA dá ao empregado. Ela serve
--  enquanto ele fica na mesma empresa — e deixa de servir exatamente
--  quando mais se precisa dela:
--
--  * o mesmo colaborador sai de uma empresa e entra noutra do grupo, e
--    vira uma pessoa nova: o histórico de atestados dele recomeça do
--    zero, e a regra dos 60 dias passa a contar de novo;
--  * empresas diferentes repetem matrícula ("00010" existe em todas), e
--    quem lê o relatório não sabe se é a mesma pessoa;
--  * matrícula se redigita errado e ninguém percebe, porque não há
--    dígito para conferir. O CPF tem.
--
--  O CPF é da PESSOA, não do emprego. É o que casa o atestado de hoje
--  com o de oito meses atrás.
--
--  O QUE ESTE ARQUIVO NÃO FAZ, DE PROPÓSITO
--  ----------------------------------------
--  Não renomeia a coluna `chapa` nem apaga o que está nela. A
--  homologação já roda com dados reais, e lá dentro há matrícula de
--  gente de verdade: renomear a coluna transformaria "00010023" em
--  "CPF 00010023", que é um CPF que não existe. A `chapa` fica onde
--  está, só deixa de ser obrigatória — processo novo nasce com CPF, e
--  processo antigo continua mostrando a matrícula que tem.
--
--  O CPF É OPCIONAL NO BANCO pelo mesmo motivo: se fosse `not null`,
--  nenhuma linha antiga poderia ser corrigida (um update numa delas
--  falharia por causa de um campo que não existia quando ela nasceu). A
--  obrigação de preencher está na tela, onde dá para explicar.
-- =====================================================================

alter table public.homol_processo
  add column if not exists cpf text;

-- A MATRÍCULA DEIXA DE SER OBRIGATÓRIA. Ela continua existindo e
-- continua aparecendo nos processos que a têm; o que muda é que o
-- processo novo não precisa mais dela.
alter table public.homol_processo
  alter column chapa drop not null;

-- ONZE DÍGITOS, quando vier. Não é a validação do dígito verificador —
-- essa é da tela, que sabe avisar a quem está digitando. Aqui é a
-- peneira que impede o lixo óbvio de entrar: "123", "a definir", o nome
-- da pessoa no campo errado.
alter table public.homol_processo
  drop constraint if exists homol_processo_cpf_11;
alter table public.homol_processo
  add constraint homol_processo_cpf_11
  check (cpf is null or cpf ~ '^[0-9]{11}$') not valid;

-- `not valid` de propósito: vale para tudo que entrar de agora em
-- diante e não reprova as linhas que já estão lá (que têm cpf nulo e
-- passariam, mas a tabela tem dados reais e uma validação completa
-- trancaria a tabela por um tempo à toa).

-- O ÍNDICE É (empresa, cpf) e não (cpf): a busca do histórico SEMPRE
-- passa pelo CNPJ da empresa — ver a nota sobre dados sensíveis abaixo.
create index if not exists idx_homol_proc_cpf
  on public.homol_processo (empresa_cnpj, cpf);


-- ---------------------------------------------------------------------
--  O HISTÓRICO DO COLABORADOR CONTINUA PRESO À EMPRESA
--
--  Não há nada a fazer aqui, e isto é uma DECISÃO, não um esquecimento:
--  a política `homol_proc_ler` já limita o RH ao CNPJ dele, e é assim
--  que fica. O CPF casa a mesma pessoa ao longo do tempo DENTRO da
--  empresa; ele não abre o atestado que ela tirou no emprego anterior.
--
--  Atestado é dado de saúde. O RH da empresa B não pode ver o que o
--  colaborador apresentou na empresa A, mesmo sendo a mesma pessoa e
--  mesmo as duas sendo clientes da clínica. Quem vê tudo é o médico,
--  que já via — e para ele o CPF melhora o que ele enxerga sem mudar
--  quem enxerga o quê.
-- ---------------------------------------------------------------------


-- O CPF CURTO que o histórico usa. Vem ANTES da função que o chama, e
-- não depois: é a ordem em que o arquivo roda. Função à parte porque a
-- mesma máscara serve a qualquer outro lugar que precise citar o CPF
-- sem escrevê-lo inteiro.
create or replace function public.homol_cpf_curto(p text)
returns text
language sql immutable set search_path = public as $$
  select case
           when p is null or length(btrim(p)) = 0 then null
           when p ~ '^[0-9]{11}$'
             then '***.' || substr(p, 4, 3) || '.' || substr(p, 7, 3) || '-**'
           else '(inválido)'
         end;
$$;


-- ---------------------------------------------------------------------
--  O HISTÓRICO DO PROCESSO PASSA A FALAR DO CPF
--
--  A função vem INTEIRA, e não só a parte nova: é a regra da casa. Um
--  "create or replace" parcial não existe em Postgres, e quem for ler
--  daqui a um ano precisa ver a função toda num arquivo só, e não
--  remontá-la de três pedaços espalhados.
--
--  Em relação ao 02, muda uma coisa: entra o CPF na lista de campos
--  vigiados, e a matrícula continua lá — processo antigo ainda pode ter
--  a matrícula corrigida, e isso tem de deixar rastro igual.
-- ---------------------------------------------------------------------
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
  --
  -- O CPF SAI MASCARADO no histórico ("***.456.789-**"). O histórico é
  -- lido por mais gente do que a ficha, e para saber QUE o CPF mudou
  -- bastam os dígitos do meio; o documento inteiro está no campo, para
  -- quem tem de ver o campo.
  if new.cpf is distinct from old.cpf then
    mudou := mudou || ('CPF: ' || coalesce(public.homol_cpf_curto(old.cpf), '(vazio)') ||
                       ' → ' || coalesce(public.homol_cpf_curto(new.cpf), '(vazio)'));
  end if;
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

-- ---------------------------------------------------------------------
--  O PARECER SÓ SE CARIMBA QUANDO A DECISÃO MUDA
--
--  O DEFEITO QUE ISTO FECHA, visto na tela: clicar duas, cinco, onze
--  vezes em "Salvar parecer" enchia o histórico de "Parecer: Aprovado"
--  iguais, todos no mesmo minuto. Quem abrisse o processo depois não
--  sabia se o médico mudara de ideia onze vezes ou se era a tela a
--  duplicar.
--
--  A causa NÃO estava no gatilho do histórico — ele já só escreve
--  quando `parecer_em` muda. Estava aqui: este gatilho carimbava
--  `parecer_em := now()` em TODO update do médico, mesmo quando ele
--  salvava exatamente o mesmo parecer. O carimbo mudava sozinho, e o
--  histórico, obediente, registrava.
--
--  Agora o carimbo só é refeito quando o parecer OU o motivo mudam. Um
--  segundo clique no mesmo parecer passa a não mexer em nada — e nada
--  mexido é nada escrito.
--
--  A função vem inteira, como manda a casa; em relação ao 01 muda só o
--  bloco do carimbo, marcado abaixo.
-- ---------------------------------------------------------------------
create or replace function public.homol_processo_regras()
returns trigger
language plpgsql security definer set search_path = public as $$
declare
  eu       public.homol_conta;
  medico   boolean := public.homol_eh_medico();
  meu_nome text    := public.homol_meu_nome();
begin
  select * into eu from public.homol_eu();
  if eu.id is null and not medico then
    raise exception 'SEM_ACESSO: esta conta não tem acesso à homologação';
  end if;

  -- a data fim sai das outras duas, sempre — nunca do que a tela manda
  new.fim := new.inicio + (new.dias - 1);
  new.atualizado_em := now();

  -- A FILIAL TEM DE SER UMA DAS CADASTRADAS, quando a empresa tem filiais
  -- cadastradas (quem lança é o RH; o CNPJ vem da conta dele). Empresa
  -- sem filial nenhuma cadastrada continua livre.
  if not medico and exists (select 1 from public.homol_filial f
                             where f.empresa_cnpj = eu.empresa_cnpj and f.ativo) then
    if not exists (select 1 from public.homol_filial f
                    where f.empresa_cnpj = eu.empresa_cnpj and f.ativo
                      and f.nome = coalesce(new.filial, '')) then
      raise exception 'FILIAL_INVALIDA: escolha uma das filiais cadastradas pela clínica';
    end if;
  end if;

  if tg_op = 'INSERT' then
    if eu.id is null then
      raise exception 'SO_RH_LANCA: quem lança atestado é o RH da empresa';
    end if;
    new.empresa_cnpj    := eu.empresa_cnpj;
    new.empresa_nome    := eu.empresa_nome;
    new.requisitante    := eu.nome;
    new.criado_por      := eu.id;
    new.criado_por_nome := eu.nome;
    new.abertura        := now();
    new.parecer         := 'Pendente';
    new.parecer_obs     := null;
    new.parecer_por     := null;
    new.parecer_em      := null;
    new.situacao        := 'aberto';
    new.atividade       := 'Clínica avalia atestado';
    return new;
  end if;

  -- UPDATE: o que ninguém muda
  new.id              := old.id;
  new.empresa_cnpj    := old.empresa_cnpj;
  new.empresa_nome    := old.empresa_nome;
  new.requisitante    := old.requisitante;
  new.abertura        := old.abertura;
  new.criado_por      := old.criado_por;
  new.criado_por_nome := old.criado_por_nome;

  if medico then
    -- O PARECER DECIDE O PROCESSO, sozinho:
    --   Aprovado  -> finalizado, "Homologado"
    --   Reprovado -> finalizado, "Não homologado"
    --   Pendente  -> volta à empresa, "Aguardando documento"
    if new.parecer in ('Pendente', 'Reprovado') and coalesce(btrim(new.parecer_obs), '') = '' then
      raise exception 'FALTA_MOTIVO: diga à empresa o que falta, ou por que foi reprovado';
    end if;
    if new.parecer = 'Aprovado' and (new.tipo is null or new.medico is null
                                     or new.entidade is null or new.responsavel is null) then
      raise exception 'FALTA_CAMPO: para aprovar, preencha tipo, médico, entidade e responsável';
    end if;
    new.situacao    := case when new.parecer = 'Pendente' then 'aberto' else 'finalizado' end;
    new.atividade   := case new.parecer when 'Aprovado'  then 'Homologado'
                                        when 'Reprovado' then 'Não homologado'
                                        else 'Aguardando documento' end;
    -- >>> O QUE MUDA EM RELAÇÃO AO 01 <<<
    -- Só carimba quando a DECISÃO muda. Salvar o mesmo parecer, com o
    -- mesmo motivo, não é uma decisão nova: é o mesmo clique de novo.
    if new.parecer is distinct from old.parecer
       or coalesce(btrim(new.parecer_obs), '')
          is distinct from coalesce(btrim(old.parecer_obs), '') then
      new.parecer_por := meu_nome;
      new.parecer_em  := now();
    else
      new.parecer_por := old.parecer_por;
      new.parecer_em  := old.parecer_em;
    end if;
  else
    -- o RH corrige e reenvia; o parecer não é dele, nem por engano
    if old.situacao = 'finalizado' then
      raise exception 'FINALIZADO: processo finalizado não se altera';
    end if;
    new.parecer     := old.parecer;
    new.parecer_obs := old.parecer_obs;
    new.parecer_por := old.parecer_por;
    new.parecer_em  := old.parecer_em;
    new.situacao    := 'aberto';
    new.atividade   := 'Clínica avalia atestado';
  end if;
  return new;
end;
$$;
drop trigger if exists trg_homol_processo_regras on public.homol_processo;
create trigger trg_homol_processo_regras
  before insert or update on public.homol_processo
  for each row execute function public.homol_processo_regras();


-- O gatilho do histórico não muda: continua `after insert or update`,
-- apontando para a função acima. Recriado só para o caso de o 01 e o 02
-- não terem sido rodados nesta ordem.
drop trigger if exists trg_homol_processo_historico on public.homol_processo;
create trigger trg_homol_processo_historico
  after insert or update on public.homol_processo
  for each row execute function public.homol_processo_historico();


-- ---------------------------------------------------------- conferência
--  1. a coluna existe, a matrícula não é mais obrigatória
select column_name, is_nullable, data_type
  from information_schema.columns
 where table_schema = 'public' and table_name = 'homol_processo'
   and column_name in ('cpf', 'chapa')
 order by column_name;

--  2. a função do histórico já fala de CPF
select proname,
       (prosrc like '%homol_cpf_curto%') as mascara_o_cpf,
       (prosrc like '%ALTERADO DEPOIS DO PARECER%') as avisa_alteracao
  from pg_proc where proname = 'homol_processo_historico';

--  3. a máscara faz o que diz
select public.homol_cpf_curto('12345678901') as deve_dar_estrelas,
       public.homol_cpf_curto(null)          as deve_dar_nulo,
       public.homol_cpf_curto('123')         as deve_dar_invalido;

--  4. o parecer só se carimba quando a decisão muda
select proname,
       (prosrc like '%is distinct from old.parecer%') as nao_repete_parecer
  from pg_proc where proname = 'homol_processo_regras';

--  5. pareceres repetidos no histórico (o passivo que ficou)
select processo_id, oque, count(*) as vezes
  from public.homol_evento
 where comentario = false and oque like 'Parecer:%'
 group by processo_id, oque
having count(*) > 1
 order by vezes desc
 limit 10;

--  6. quantos processos já têm CPF, e quantos ainda estão só na matrícula
select count(*) filter (where cpf is not null)  as com_cpf,
       count(*) filter (where cpf is null)      as so_matricula,
       count(*)                                 as total
  from public.homol_processo;
