-- =====================================================================
--  O certificado: conteúdo programático e emissão
--
--  Rode DEPOIS do 01. Pode rodar mais de uma vez.
--
--  O QUE FALTAVA
--  -------------
--  O modelo de certificado da clínica tem DUAS páginas por aluno: a frente
--  (quem fez, qual treinamento, quantas horas, a assinatura) e o verso com
--  o CONTEÚDO PROGRAMÁTICO. O conteúdo é do curso, não do aluno — por isso
--  mora aqui, no catálogo, e não em cada certificado.
--
--  Curso sem conteúdo preenchido sai com uma página só. É de propósito:
--  melhor uma frente correta do que um verso inventado.
-- =====================================================================

alter table public.trein_curso
  -- uma linha por item do programa, separadas por quebra de linha
  add column if not exists conteudo_programatico text,
  -- o nome como sai no certificado, quando for diferente do título curto
  add column if not exists titulo_certificado    text;

-- ---------------------------------------------------------------------
-- O conteúdo do NR-20, tirado do certificado real que a clínica emitiu
-- (Certificado_NR_20_LTI_ASSINADOS). É o único que temos por escrito; os
-- outros ficam em branco até alguém do técnico passar — e o certificado
-- sai só com a frente enquanto isso.
-- ---------------------------------------------------------------------
update public.trein_curso set
  titulo_certificado = 'NR-20 — Segurança e Saúde no Trabalho com Inflamáveis '
                       'e Combustíveis, Módulo Intermediário',
  conteudo_programatico =
'Inflamáveis: características, propriedades, perigos e risco.
Controle coletivo e individual para trabalhos com inflamáveis. EPI e EPC.
Fontes de ignição e seu controle.
Proteção contra incêndio com inflamáveis.
Procedimento em situações de emergência com inflamáveis.
Estudo detalhado da NR-20 e sua interação com outras atividades e normas, incluindo a revisão do item 20.8.8 — trabalhos que possam gerar chamas, calor ou centelhas; em espaços confinados conforme a NR-33, envolvendo isolamento e bloqueio; em locais com risco de queda conforme a NR-35; e com equipamentos elétricos de acordo com a NR-10.
Análise preliminar de riscos e perigos, e permissões de trabalho.
Práticas de prevenção e combate a incêndio.
Práticas de APR, RCP, desmaio, convulsões, fraturas, imobilização, queimaduras, hemorragias, resgate e transporte.
Equipamentos de proteção respiratória.'
where codigo = 'NR-20';

-- ---------------------------------------------------------------------
-- Emite o certificado: confere que a pessoa passou ANTES de gerar.
--
-- Fica no banco, e não no site, porque é o banco que sabe se houve
-- aprovação — deixar o navegador decidir seria deixar o aluno emitir o
-- próprio certificado sem fazer a prova.
--
-- Chamar duas vezes devolve o mesmo certificado, e não um novo: o código
-- impresso no papel que já foi entregue tem de continuar valendo.
-- ---------------------------------------------------------------------
create or replace function public.trein_emitir_certificado(p_matricula uuid)
returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  v_mat    public.trein_matricula%rowtype;
  v_curso  public.trein_curso%rowtype;
  v_cert   public.trein_certificado%rowtype;
  v_codigo text;
begin
  select * into v_mat from public.trein_matricula where id = p_matricula;
  if not found or v_mat.aluno_id <> auth.uid() then
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
                              'novo', false);
  end if;

  if not exists (select 1 from public.trein_tentativa t
                  where t.matricula_id = p_matricula and t.aprovado) then
    raise exception 'NAO_APROVADO';
  end if;

  select * into v_curso from public.trein_curso where id = v_mat.curso_id;

  -- código curto e conferível, sem letra que se confunda com número
  v_codigo := upper(
    substr(replace(gen_random_uuid()::text, '-', ''), 1, 4) || '-' ||
    substr(replace(gen_random_uuid()::text, '-', ''), 1, 4) || '-' ||
    substr(replace(gen_random_uuid()::text, '-', ''), 1, 4));
  v_codigo := translate(v_codigo, 'OI', '48');

  insert into public.trein_certificado (matricula_id, codigo, valido_ate)
  values (p_matricula, v_codigo,
          case when v_curso.validade_meses is not null
               then (current_date + (v_curso.validade_meses || ' months')::interval)::date
          end)
  returning * into v_cert;

  return jsonb_build_object('codigo', v_cert.codigo,
                            'emitido_em', v_cert.emitido_em,
                            'valido_ate', v_cert.valido_ate,
                            'novo', true);
end;
$$;
grant execute on function public.trein_emitir_certificado(uuid) to authenticated;

-- Confira:
select codigo, titulo,
       case when conteudo_programatico is null then 'FALTA o conteúdo'
            else 'ok' end as verso
  from public.trein_curso order by ordem;
