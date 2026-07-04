-- =====================================================================
--  aritra-maxxing · Supabase setup
--  Run this ONCE in your project: Supabase dashboard → SQL Editor → paste → Run.
--
--  Model: one shared workspace row (JSONB). Both accounts can READ it.
--  Only Aritra (the editor) can WRITE — enforced here by RLS, not just the UI.
--
--  >>> BEFORE RUNNING: replace the two emails below with your real ones. <<<
-- =====================================================================

-- ---- who is who --------------------------------------------------------
--   editor  = Aritra  (full edit)
--   admin   = Pratyush (read-only oversight)
-- These must match the emails you sign up with in the app.
--   EDITOR_EMAIL  ->  aritra@example.com
--   ADMIN_EMAIL   ->  pratyush@example.com
-- ------------------------------------------------------------------------

-- 1. The single shared workspace row
create table if not exists public.workspace (
  id         text primary key default 'main',
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  updated_by text
);

insert into public.workspace (id, data)
values ('main', '{}'::jsonb)
on conflict (id) do nothing;

-- 2. Lock the table down
alter table public.workspace enable row level security;

-- Clean slate if you re-run this
drop policy if exists "read for signed-in users"  on public.workspace;
drop policy if exists "editor can insert"          on public.workspace;
drop policy if exists "editor can update"          on public.workspace;

-- 3a. Anyone signed in (either account) can READ
create policy "read for signed-in users"
  on public.workspace
  for select
  to authenticated
  using (true);

-- 3b. Only Aritra can INSERT  (replace the email!)
create policy "editor can insert"
  on public.workspace
  for insert
  to authenticated
  with check ( lower(auth.jwt() ->> 'email') = lower('aritra@example.com') );

-- 3c. Only Aritra can UPDATE  (replace the email!)
create policy "editor can update"
  on public.workspace
  for update
  to authenticated
  using      ( lower(auth.jwt() ->> 'email') = lower('aritra@example.com') )
  with check ( lower(auth.jwt() ->> 'email') = lower('aritra@example.com') );

-- 4. Turn on live sync (realtime) for the table
alter publication supabase_realtime add table public.workspace;

-- Done. Now create the two accounts (see SETUP in README.md).
