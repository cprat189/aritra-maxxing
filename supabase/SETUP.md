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
**Before running**, replace the email placeholders (4 spots, marked ⬅) with the exact two emails from step 2. Then **Run**.

## 4. Send me two values
Dashboard → **Project Settings** → **API**:
- **Project URL** (looks like `https://abcdefg.supabase.co`)
- **anon public** key (the long one labelled `anon` / `public`)

Paste both to me here, plus **Aritra's email** (so I map it to the editor role in the app).

> The `anon` key is safe to share and safe to ship in the app — it's public by design; RLS is what protects the data. **Never** send the `service_role` key.

## What I do next
I rewire the app's login to Supabase Auth, point persistence at the `workspace` row, subscribe to realtime so you both see live updates, and verify sign-in + read/write/permissions end-to-end. Then you each just open the app and log in with your real account.
