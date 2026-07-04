# aritra-maxxing 🧭

An **interactive, gated, editable operating console** for Aritra Bhattacharya — UGA Terry College **Management Information Systems ('27)**, minoring in mathematics & astrophysics.

Obsidian-style dark workspace: a left-nav shell, a command palette (`Ctrl/⌘ K`), inline-editable everything, gamified progress (XP · levels · day streak), a drag-and-drop recruiting Kanban, a live constellation graph, per-section notes, and a read-only **accountability dashboard** for his partner.

- Single self-contained `index.html` (plus the Supabase JS client from a CDN). No build step.
- **Real logins + live sync** via [Supabase](https://supabase.com): one shared workspace row, both of you read it, **only Aritra can write** (enforced by row-level security, not just the UI). Edits appear on the other person's screen automatically.

## Logins

| Role | Account | Can do |
|---|---|---|
| **Editor** (Aritra) | his email + password | Full edit — everything, everywhere |
| **Admin** (accountability partner) | your email + password | Read-only oversight of Aritra's live progress |

Two accounts only — the app rejects any other email. Passwords are managed by Supabase Auth (hashed server-side); the repo never stores them.

## Setup (one time)

Everything lives in your Supabase project (URL + anon key are already wired into `index.html`).

1. **Pick the two emails** you'll each log in with. Put them in **two** places:
   - `supabase-setup.sql` → replace `aritra@example.com` in the three RLS policies.
   - `index.html` → the `CONFIG` block near the top of the `<script>`: set `editorEmail` (Aritra) and `adminEmail` (you).
2. **Run the schema:** Supabase dashboard → **SQL Editor** → paste all of `supabase-setup.sql` → **Run**. This creates the `workspace` table, the RLS policies, and turns on realtime.
3. **Turn off email confirmation** (so signup is instant): dashboard → **Authentication → Providers → Email** → disable *"Confirm email"* → save.
4. **Create the two accounts:** open the app, type each email + a password, and click **"First time? Create account"** — once for Aritra, once for you.
5. Done. Aritra edits; your screen updates live.

> The committed `data.json` is only a first-run seed. Once the cloud row exists, it's the source of truth. **Export snapshot** still works as a manual backup.

## What's inside

| Section | What it does |
|---|---|
| Dashboard | Countdowns, KPIs, the constellation graph, "up next" |
| Trajectory | Four phases with checkable, XP-earning tasks |
| Rush · DSP + AKΨ | The two mandatory rushes (+ Beta Alpha Psi) — click status pills to advance |
| Clubs & Orgs | UGA orgs ranked by MIS leverage; check one off when joined |
| Recruiting | Drag-and-drop Kanban: Target → To apply → Applied → Interview → Offer |
| Skills | Matrix with nudge-able progress bars, each ending in a shippable proof |
| Weekly Cadence | Themed operating days |
| Doctrine | Rules of the grind |
| Oversight *(admin)* | Rings, streak, "needs attention", activity feed |

## ⚑ Accuracy

Fields marked **[verify]** — exact rush dates, GPA minimums, some club names — are best-effort placeholders that change year to year. Ground-truth them on the [UGA Involvement Network](https://dawgs.uga.edu/), [Terry College](https://www.terry.uga.edu/), [UGA Career Center](https://career.uga.edu/), and each chapter's Instagram before locking anything in.
