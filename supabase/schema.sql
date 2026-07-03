-- ============================================================
--  aritra-maxxing · Supabase schema
--  Run this in your Supabase project → SQL Editor → New query.
--  FIRST replace the two email placeholders below (lines marked ⬅).
-- ============================================================

-- 1. One shared document. The whole workspace lives in `data` (JSONB).
create table if not exists public.workspace (
  id          text primary key default 'main',
  data        jsonb not null default '{}'::jsonb,
  updated_at  timestamptz not null default now(),
  updated_by  text
);

-- seed the single row the app reads/writes
insert into public.workspace (id, data) values ('main', '{}'::jsonb)
on conflict (id) do nothing;

-- 2. Lock the table down.
alter table public.workspace enable row level security;

-- 3. Policies — both may READ, only the editor (Aritra) may WRITE.
--    >>> Replace these two emails with the exact ones you'll log in with. <<<
--    (Use the same emails when you create the two users in Authentication.)
drop policy if exists "read for both"        on public.workspace;
drop policy if exists "write for editor only" on public.workspace;

create policy "read for both" on public.workspace
  for select to authenticated
  using ( (auth.jwt() ->> 'email') in (
    'aritra@example.com',      -- ⬅ EDITOR (Aritra)
    'pratyushch9@gmail.com'    -- ⬅ ADMIN  (you)
  ));

create policy "write for editor only" on public.workspace
  for update to authenticated
  using      ( (auth.jwt() ->> 'email') = 'aritra@example.com' )   -- ⬅ EDITOR only
  with check ( (auth.jwt() ->> 'email') = 'aritra@example.com' );  -- ⬅ EDITOR only

-- 4. Live sync — push row changes to both connected browsers.
alter publication supabase_realtime add table public.workspace;
