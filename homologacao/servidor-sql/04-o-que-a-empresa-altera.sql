-- =====================================================================
--  HOMOLOGAÇÃO — o que a empresa pode alterar depois de enviar
--
--  RODE DEPOIS do 01-esquema.sql, do 02-cpf-e-historico.sql e do
--  03-colaboradores.sql. Cole inteiro no SQL Editor do Supabase e clique
--  em Run. Pode rodar de novo: é "create or replace", e nada é apagado.
--
--  O QUE MUDA
--  ----------
--  Depois que o atestado foi enviado, o RH da empresa só altera quatro
--  coisas: o TIPO de atestado, o MÉDICO que assinou, a ENTIDADE onde foi
--  emitido e a CID. Mais a observação dele e os anexos, que são recado e
--  documento, e não dado do atestado.
--
--  Quem é a pessoa, de qual filial ela é, o dia em que o atestado
--  começou, a hora e quantos dias ele tem passam a ser CONGELADOS no
--  lançamento. O servidor devolve o valor antigo, calado, como já fazia
--  com o parecer e com o nome da empresa.
--
--  POR QUE NO BANCO, SE A TELA JÁ NÃO OFERECE
--  ------------------------------------------
--  Porque a tela é uma página que roda no computador da empresa, e
--  qualquer pessoa com o login dela pode mandar um pedido direto ao
--  servidor sem passar pela tela. Uma regra que só existe no navegador é
--  uma regra que existe enquanto ninguém tentar. Esta aqui existe do
--  lado de cá.
--
--  E o motivo dela não é desconfiança: é que a clínica LÊ o atestado e
--  dá um parecer sobre o que leu. Se o período pudesse mudar depois, o
--  "Aprovado" de ontem passaria a valer para um atestado diferente do
--  que foi aprovado, e ninguém veria a troca. Errou o dia, a quantidade
--  de dias ou a pessoa? O caminho é a clínica devolver o processo, e
--  não a empresa corrigir por cima.
--
--  O MÉDICO DA CLÍNICA NÃO É ATINGIDO: ele continua podendo corrigir o
--  que lê, porque é ele quem confere o papel.
--
--  A função vem INTEIRA, como manda a casa: "create or replace" parcial
--  não existe, e quem ler isto daqui a um ano tem de ver a regra toda
--  num arquivo só. Em relação ao 02 mudam dois blocos, marcados abaixo.
-- =====================================================================

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

  -- >>> BLOCO NOVO 1: O FATO LANÇADO NÃO SE REESCREVE <<<
  --
  -- Vem antes de tudo o mais de propósito: o `fim` é recalculado logo
  -- abaixo a partir do início e dos dias, e a filial é conferida em
  -- seguida. Os dois têm de enxergar os valores restaurados, e não os
  -- que chegaram no pedido.
  --
  -- O gatilho dos colaboradores (03) já passou por aqui e pode ter
  -- reescrito cpf, nome, matrícula e filial com o que o cadastro diz
  -- HOJE. Num processo que já existe isso também não vale: o atestado
  -- guarda a pessoa como ela estava no dia do lançamento, senão mudar a
  -- filial de alguém no cadastro reescreveria o passado dela.
  if tg_op = 'UPDATE' and not medico then
    new.cpf         := old.cpf;
    new.chapa       := old.chapa;
    new.nome        := old.nome;
    new.filial      := old.filial;
    new.inicio      := old.inicio;
    new.hora_inicio := old.hora_inicio;
    new.dias        := old.dias;
    -- o responsável pelo abono é da clínica, e nunca foi da empresa
    new.responsavel := old.responsavel;
  end if;

  -- a data fim sai das outras duas, sempre — nunca do que a tela manda
  new.fim := new.inicio + (new.dias - 1);
  new.atualizado_em := now();

  -- A FILIAL TEM DE SER UMA DAS CADASTRADAS, quando a empresa tem filiais
  -- cadastradas (quem lança é o RH; o CNPJ vem da conta dele). Empresa
  -- sem filial nenhuma cadastrada continua livre.
  --
  -- >>> BLOCO NOVO 2: SÓ SE CONFERE QUANDO A FILIAL MUDA <<<
  -- Com o congelamento acima, num update do RH a filial é sempre a
  -- mesma do lançamento. Conferi-la de novo quebraria um reenvio
  -- legítimo no único caso em que ela pode ter deixado de valer: a
  -- clínica desligou aquela filial no cadastro depois do lançamento. O
  -- processo antigo não tem culpa disso.
  if not medico
     and (tg_op = 'INSERT' or new.filial is distinct from old.filial)
     and exists (select 1 from public.homol_filial f
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
    -- o carimbo do parecer só se refaz quando a DECISÃO muda (veio do 02)
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


-- ---------------------------------------------------------- conferência
--  1. a regra nova está de pé
select proname,
       (prosrc like '%new.inicio%:= old.inicio%') as congela_o_fato,
       (prosrc like '%new.filial is distinct from old.filial%') as filial_so_quando_muda
  from pg_proc where proname = 'homol_processo_regras';

--  2. o gatilho continua único e nos dois momentos (insert e update)
select tgname, tgenabled
  from pg_trigger
 where tgrelid = 'public.homol_processo'::regclass
   and not tgisinternal
 order by tgname;

--  3. processos que tiveram data ou dias alterados depois do parecer
--     (o passivo de antes desta regra; daqui para a frente a lista para
--      de crescer)
select processo_id, quem_nome, quando, oque
  from public.homol_evento
 where comentario = false
   and oque like 'ALTERADO DEPOIS DO PARECER%'
   and (oque like '%Início:%' or oque like '%Dias:%' or oque like '%Hora:%')
 order by quando desc
 limit 20;
