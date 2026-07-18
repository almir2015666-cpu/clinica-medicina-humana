-- =====================================================================
--  Módulo Funcionários (equipe) — papéis, liberação de laudos e auditoria
--  Modelo inspirado em LIS: recepção LANÇA (pendente) e o responsável LIBERA.
--  Rode DEPOIS do 01 e 02.
-- =====================================================================

-- Equipe com papéis: gestor | recepcao | tecnico
create table if not exists public.funcionarios (
  id        uuid primary key references auth.users(id) on delete cascade,
  nome      text not null,
  papel     text not null default 'recepcao' check (papel in ('gestor','recepcao','tecnico')),
  ativo     boolean not null default true,
  criado_em timestamptz not null default now()
);

-- Migra os admins já existentes como GESTORES
insert into public.funcionarios (id, nome, papel)
  select user_id, 'Gestor', 'gestor' from public.admins
  on conflict (id) do nothing;

-- Helpers de permissão
create or replace function public.is_staff() returns boolean
  language sql stable security definer set search_path=public as $$
  select exists(select 1 from public.funcionarios f where f.id=auth.uid() and f.ativo); $$;

create or replace function public.is_gestor() returns boolean
  language sql stable security definer set search_path=public as $$
  select exists(select 1 from public.funcionarios f where f.id=auth.uid() and f.papel='gestor' and f.ativo); $$;

create or replace function public.pode_liberar() returns boolean
  language sql stable security definer set search_path=public as $$
  select exists(select 1 from public.funcionarios f where f.id=auth.uid() and f.papel in ('gestor','tecnico') and f.ativo); $$;

-- is_admin agora significa "gestor" (mantém compatibilidade)
create or replace function public.is_admin() returns boolean
  language sql stable security definer set search_path=public as $$
  select public.is_gestor(); $$;

-- Status + auditoria nos resultados
alter table public.resultados
  add column if not exists status       text not null default 'pendente' check (status in ('pendente','liberado')),
  add column if not exists lancado_por  uuid references public.funcionarios(id),
  add column if not exists liberado_por uuid references public.funcionarios(id),
  add column if not exists liberado_em  timestamptz;

-- Gatilho: registra quem lançou
create or replace function public.trg_lancar() returns trigger
  language plpgsql security definer set search_path=public as $$
  begin if new.lancado_por is null then new.lancado_por := auth.uid(); end if; return new; end $$;
drop trigger if exists resultados_lancar on public.resultados;
create trigger resultados_lancar before insert on public.resultados
  for each row execute function public.trg_lancar();

-- Gatilho: só quem PODE liberar libera; registra quem liberou e quando
create or replace function public.trg_liberar() returns trigger
  language plpgsql security definer set search_path=public as $$
  begin
    if new.status='liberado' and old.status is distinct from new.status then
      if not public.pode_liberar() then raise exception 'Sem permissão para liberar resultados'; end if;
      new.liberado_por := auth.uid(); new.liberado_em := now();
    end if;
    return new;
  end $$;
drop trigger if exists resultados_liberar on public.resultados;
create trigger resultados_liberar before update on public.resultados
  for each row execute function public.trg_liberar();

-- ============================ RLS ============================
alter table public.funcionarios enable row level security;

drop policy if exists func_sel on public.funcionarios;
create policy func_sel on public.funcionarios for select using (id=auth.uid() or public.is_gestor());
drop policy if exists func_gestor on public.funcionarios;
create policy func_gestor on public.funcionarios for all using (public.is_gestor()) with check (public.is_gestor());

-- pacientes / médicos: qualquer funcionário ativo gerencia
drop policy if exists pac_admin_all on public.pacientes;
drop policy if exists pac_staff_all on public.pacientes;
create policy pac_staff_all on public.pacientes for all using (public.is_staff()) with check (public.is_staff());

drop policy if exists med_admin_all on public.medicos;
drop policy if exists med_staff_all on public.medicos;
create policy med_staff_all on public.medicos for all using (public.is_staff()) with check (public.is_staff());

-- resultados: staff gerencia tudo; paciente e médico só veem LIBERADO
drop policy if exists res_admin_all on public.resultados;
drop policy if exists res_staff_all on public.resultados;
create policy res_staff_all on public.resultados for all using (public.is_staff()) with check (public.is_staff());

drop policy if exists res_sel_self on public.resultados;
create policy res_sel_self on public.resultados
  for select using ((paciente_id=auth.uid() and status='liberado') or public.is_staff());

drop policy if exists res_sel_medico on public.resultados;
create policy res_sel_medico on public.resultados
  for select using (medico_id=auth.uid() and status='liberado');

-- storage: staff lê/escreve; paciente e médico só arquivos de resultado LIBERADO
drop policy if exists res_read on storage.objects;
create policy res_read on storage.objects for select using (
  bucket_id='resultados' and (
    public.is_staff()
    or exists (select 1 from public.resultados r where r.arquivo_path=name and r.paciente_id=auth.uid() and r.status='liberado')
  )
);
drop policy if exists res_read_medico on storage.objects;
create policy res_read_medico on storage.objects for select using (
  bucket_id='resultados' and exists (
    select 1 from public.resultados r where r.arquivo_path=name and r.medico_id=auth.uid() and r.status='liberado'
  )
);
drop policy if exists res_write on storage.objects;
create policy res_write on storage.objects for insert with check (bucket_id='resultados' and public.is_staff());
drop policy if exists res_modify on storage.objects;
create policy res_modify on storage.objects for update using (bucket_id='resultados' and public.is_staff()) with check (bucket_id='resultados' and public.is_staff());
drop policy if exists res_delete on storage.objects;
create policy res_delete on storage.objects for delete using (bucket_id='resultados' and public.is_staff());
