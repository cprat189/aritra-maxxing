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

## 2.5. Fix Auth URL redirects
Dashboard → **Authentication** → **URL Configuration**:

- **Site URL:** `https://cprat189.github.io/aritra-maxxing/`
- **Redirect URLs:** add `https://cprat189.github.io/aritra-maxxing/`

If this is still set to `http://localhost:3000`, email login links will open a dead localhost page before the app can load.

If users already exist but login says the account is not confirmed, open each user in **Authentication → Users** and confirm the email, or run the PowerShell finisher from the repo root with your Supabase `service_role` key:

```powershell
.\scripts\supabase-finish-setup.ps1 `
  -ServiceRoleKey "YOUR_SERVICE_ROLE_KEY" `
  -AritraEmail "aritra@real-email.com" `
  -AritraPassword "TEMP_PASSWORD_FOR_ARITRA" `
  -AdminPassword "TEMP_PASSWORD_FOR_PRATYUSH"
```

## 3. Run the schema
Dashboard → **SQL Editor** → **New query** → paste all of [`schema.sql`](./schema.sql).
Your admin email (`pratyushch9@gmail.com`) is already filled in. Then **Run**.

## 4. Set Aritra's email in the app
Open [`../index.html`](../index.html), find the `CONFIG` block near the top of the `<script>`, and optionally set `editorEmail` to Aritra's real email. If left blank, any non-admin authenticated user is treated as the editor in the UI; database RLS still blocks the admin from writing.

## Done
Open `index.html` and log in with the account you created in step 2. The app already talks to Supabase Auth, reads/writes the shared `workspace` row, and subscribes to realtime — Aritra edits, your Oversight screen updates live. No `service_role` key is ever used; the public `anon` key + RLS is what protects the data.

Sendable link:

```text
https://cprat189.github.io/aritra-maxxing/
```
