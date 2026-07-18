-- =====================================================================
--  Clínica Medicina Humana — Sistema de Resultados de Exames
--  Esquema do banco (Supabase / Postgres) + regras de segurança (RLS)
--  Rode este script no Supabase: SQL Editor > New query > Run
-- =====================================================================

create extension if not exists "uuid-ossp";

-- ---------------------------------------------------------------------
-- Perfis de pacientes (1:1 com auth.users). O login é feito via
-- Supabase Auth; aqui guardamos os dados de identificação (CPF, nome).
-- ---------------------------------------------------------------------
create table if not exists public.pacientes (
  id         uuid primary key references auth.users(id) on delete cascade,
  cpf        text unique not null,
  nome       text not null,
  telefone   text,
  criado_em  timestamptz not null default now()
);

-- ---------------------------------------------------------------------
-- Equipe da clínica (quem pode subir resultados). Um usuário só é admin
-- se estiver aqui — nunca dependa do front-end pra isso.
-- ---------------------------------------------------------------------
create table if not exists public.admins (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  criado_em  timestamptz not null default now()
);

-- ---------------------------------------------------------------------
-- Resultados de exames (o PDF em si fica no Storage privado; aqui só o
-- caminho e os metadados).
-- ---------------------------------------------------------------------
create table if not exists public.resultados (
  id           uuid primary key default uuid_generate_v4(),
  paciente_id  uuid not null references public.pacientes(id) on delete cascade,
  titulo       text not null,
  descricao    text,
  data_exame   date,
  arquivo_path text not null,           -- ex.: "<paciente_id>/hemograma-2026-07.pdf"
  criado_em    timestamptz not null default now()
);
create index if not exists idx_resultados_paciente on public.resultados(paciente_id);

-- ---------------------------------------------------------------------
-- Função auxiliar: o usuário logado é admin?  (security definer p/ ler
-- a tabela admins sem esbarrar na própria RLS)
-- ---------------------------------------------------------------------
create or replace function public.is_admin()
returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.admins a where a.user_id = auth.uid());
$$;

-- =====================================================================
--  Row Level Security  (o coração da proteção: cada paciente só enxerga
--  os PRÓPRIOS dados; a equipe enxerga tudo)
-- =====================================================================
alter table public.pacientes  enable row level security;
alter table public.resultados enable row level security;
alter table public.admins     enable row level security;

-- pacientes: cada um vê só o próprio; admin gerencia todos
drop policy if exists pac_sel_self on public.pacientes;
create policy pac_sel_self on public.pacientes
  for select using (id = auth.uid() or public.is_admin());
drop policy if exists pac_admin_all on public.pacientes;
create policy pac_admin_all on public.pacientes
  for all using (public.is_admin()) with check (public.is_admin());

-- resultados: paciente vê os próprios; admin gerencia
drop policy if exists res_sel_self on public.resultados;
create policy res_sel_self on public.resultados
  for select using (paciente_id = auth.uid() or public.is_admin());
drop policy if exists res_admin_all on public.resultados;
create policy res_admin_all on public.resultados
  for all using (public.is_admin()) with check (public.is_admin());

-- admins: só admin lê a lista
drop policy if exists adm_sel on public.admins;
create policy adm_sel on public.admins
  for select using (public.is_admin());

-- =====================================================================
--  Storage: bucket privado "resultados"
--  (crie o bucket PRIVADO pelo painel Storage antes de rodar as policies)
--  Arquivos ficam em "<paciente_id>/arquivo.pdf". O paciente só lê a
--  própria pasta; só admin escreve. Downloads via URL assinada temporária.
-- =====================================================================
drop policy if exists res_read on storage.objects;
create policy res_read on storage.objects
  for select using (
    bucket_id = 'resultados'
    and ( public.is_admin() or (storage.foldername(name))[1] = auth.uid()::text )
  );

drop policy if exists res_write on storage.objects;
create policy res_write on storage.objects
  for insert with check ( bucket_id = 'resultados' and public.is_admin() );

drop policy if exists res_modify on storage.objects;
create policy res_modify on storage.objects
  for update using ( bucket_id = 'resultados' and public.is_admin() )
  with check ( bucket_id = 'resultados' and public.is_admin() );

drop policy if exists res_delete on storage.objects;
create policy res_delete on storage.objects
  for delete using ( bucket_id = 'resultados' and public.is_admin() );
