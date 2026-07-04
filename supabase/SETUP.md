# Supabase setup (≈10 min, one time)

This gives you and Aritra **real accounts** and **live-synced shared data**, with the repo staying private. Real row-level security means the admin literally *can't* write, not just "the UI hides the button."

## 1. Create a free project
1. Go to **supabase.com** → sign in → **New project**.
2. Name it `aritra-maxxing`, set a database password (save it), pick a region near Georgia (e.g. `us-east`).
3. Wait ~2 min for it to provision.

## 2. Create the two users
Dashboard → **Authentication** → **Users** → **Add user** → *Create new user*:
- Editor: Aritra's email + a password → **check "Auto Confirm User"**.
- Admin: your email + a password → **check "Auto Confirm User"**.

> "Auto Confirm" matters — without it, login is blocked pending email verification.

## 3. Run the schema
Dashboard → **SQL Editor** → **New query** → paste all of [`schema.sql`](./schema.sql).
**Before running**, replace `aritra@example.com` (3 spots, marked ⬅) with Aritra's real email. Your admin email (`pratyushch9@gmail.com`) is already filled in. Then **Run**.

## 4. Set Aritra's email in the app
Open [`../index.html`](../index.html), find the `CONFIG` block near the top of the `<script>`, and set `editorEmail` to the same email you used above. (URL, anon key, and `adminEmail` are already wired.)

## Done
Open `index.html` and log in with the account you created in step 2. The app already talks to Supabase Auth, reads/writes the shared `workspace` row, and subscribes to realtime — Aritra edits, your Oversight screen updates live. No `service_role` key is ever used; the public `anon` key + RLS is what protects the data.
