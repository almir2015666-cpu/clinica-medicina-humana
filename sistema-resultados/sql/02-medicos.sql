-- =====================================================================
--  Módulo Médicos — acesso do médico aos resultados dos seus pacientes
--  Rode DEPOIS do 01-esquema.sql
-- =====================================================================

-- Perfil do médico (1:1 com auth.users)
create table if not exists public.medicos (
  id            uuid primary key references auth.users(id) on delete cascade,
  crm           text unique not null,
  nome          text not null,
  especialidade text,
  telefone      text,
  criado_em     timestamptz not null default now()
);

-- Vínculo opcional do resultado com o médico solicitante
alter table public.resultados
  add column if not exists medico_id uuid references public.medicos(id) on delete set null;
create index if not exists idx_resultados_medico on public.resultados(medico_id);

-- É médico?
create or replace function public.is_medico()
returns boolean language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.medicos m where m.id = auth.uid());
$$;

alter table public.medicos enable row level security;

-- médicos: vê o próprio perfil; admin gerencia
drop policy if exists med_sel_self on public.medicos;
create policy med_sel_self on public.medicos
  for select using (id = auth.uid() or public.is_admin());
drop policy if exists med_admin_all on public.medicos;
create policy med_admin_all on public.medicos
  for all using (public.is_admin()) with check (public.is_admin());

-- resultados: médico vê os resultados atribuídos a ele
--  (soma-se às políticas do paciente/admin que já existem — RLS é OR)
drop policy if exists res_sel_medico on public.resultados;
create policy res_sel_medico on public.resultados
  for select using (medico_id = auth.uid());

-- pacientes: médico enxerga os pacientes que têm resultado atribuído a ele
drop policy if exists pac_sel_medico on public.pacientes;
create policy pac_sel_medico on public.pacientes
  for select using (
    exists (select 1 from public.resultados r
            where r.paciente_id = pacientes.id and r.medico_id = auth.uid())
  );

-- storage: médico baixa os PDFs dos resultados atribuídos a ele
drop policy if exists res_read_medico on storage.objects;
create policy res_read_medico on storage.objects
  for select using (
    bucket_id = 'resultados' and exists (
      select 1 from public.resultados r
      where r.arquivo_path = name and r.medico_id = auth.uid()
    )
  );
