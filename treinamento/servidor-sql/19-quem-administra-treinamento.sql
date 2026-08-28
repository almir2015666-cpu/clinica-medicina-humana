-- =====================================================================
--  QUEM PODE ADMINISTRAR O TREINAMENTO
--
--  Rode no SQL Editor. Pode rodar mais de uma vez.
--
--  COMO ESTAVA, E POR QUE ISSO É DEMAIS
--  ------------------------------------
--  A `trein_is_equipe()` dizia sim para:
--    (a) QUALQUER usuário ativo do SistemaCMH, e
--    (b) QUALQUER pessoa da tabela `admins`.
--
--  Os dois são largos demais. Em (a), a recepcionista que só lança
--  orçamento entrava no admin do treinamento e podia apagar o vídeo de um
--  curso inteiro. Em (b), `admins` é a equipe da ÁREA MÉDICA/resultados —
--  outra equipe, outro sistema, que não tem nada que administrar curso.
--
--  Nenhum dos dois era uma decisão: era o que sobrou de quando isto foi
--  escrito e ainda não existia lugar para escolher.
--
--  COMO FICA
--  ---------
--  Quem decide é você, no SistemaCMH, em Usuários -> a marcação
--  "Treinamentos" de cada pessoa. É a MESMA marcação que já libera o
--  módulo dentro do programa: quem pode abrir o módulo administra o site,
--  quem não pode não entra. Um lugar só para decidir, e não dois que
--  discordam.
--
--  O administrador do SistemaCMH (`admin = true`) continua entrando sem
--  marcação nenhuma — é a mesma regra do `modulos_do_usuario()` no
--  programa, onde o administrador abre todos os módulos. Se não fosse
--  assim, uma marcação esquecida trancaria você para fora do seu próprio
--  sistema.
--
--  A `admins` sai. Se um dia alguém de lá precisar, o caminho é criar o
--  acesso dela no SistemaCMH e marcar Treinamentos — e aí fica registrado
--  quem deu, em vez de acontecer por tabela vizinha.
-- =====================================================================

-- ANTES DE TROCAR: veja quem tem acesso hoje, e quem terá depois.
-- Rode este bloco primeiro e confira se ninguém que precisa fica de fora.
select u.usuario,
       u.nome,
       u.cargo,
       u.admin,
       u.ativo,
       u.modulos,
       case
         when not u.ativo                              then 'NAO (inativo)'
         when u.admin                                  then 'SIM (administrador)'
         when 'treinamento' = any(u.modulos)                then 'SIM (modulo marcado)'
         else                                               'NAO — marque Treinamentos em Usuarios'
       end as depois_desta_mudanca
  from public.orc_usuarios u
 order by u.admin desc, u.ativo desc, u.usuario;

-- E quem entrava só por estar na `admins` (equipe da área médica):
-- estes PERDEM o acesso ao admin do treinamento.
select a.user_id, 'perde o acesso ao treinamento' as aviso
  from public.admins a
 where not exists (select 1 from public.orc_usuarios u where u.id = a.user_id);

-- =====================================================================
--  A troca
-- =====================================================================
create or replace function public.trein_is_equipe()
returns boolean
language sql stable security definer set search_path = public as $$
  select exists (
    select 1 from public.orc_usuarios u
     where u.id = auth.uid()
       and u.ativo
       and (u.admin or 'treinamento' = any(u.modulos))
  );
$$;

-- A COLUNA `modulos` É text[], NÃO jsonb.
--
-- A primeira versão deste arquivo usava `u.modulos ? 'treinamento'`, que é
-- o operador do jsonb, e o Postgres recusou com "operator does not exist:
-- text[] ? unknown". Em array de texto quem responde "está na lista?" é o
-- `= any(...)`.
--
-- Foi bom ter dado erro: se o operador existisse para os dois tipos e
-- devolvesse falso, ninguém teria acesso ao treinamento e a causa levaria
-- horas para ser achada. Erro barulhento é melhor que erro calado.

-- =====================================================================
--  Confira DEPOIS de rodar
-- =====================================================================
-- Esta lista é a resposta para "quem tem acesso ao treinamento".
-- Guarde-a: é o que você mostra se alguém perguntar quem mexeu num vídeo.
select u.usuario, u.nome, u.cargo,
       case when u.admin then 'administrador' else 'modulo marcado' end as porque
  from public.orc_usuarios u
 where u.ativo
   and (u.admin or 'treinamento' = any(u.modulos))
 order by u.admin desc, u.usuario;
