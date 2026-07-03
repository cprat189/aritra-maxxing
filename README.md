# aritra-maxxing 🧭

An **interactive, gated, editable operating console** for Aritra Bhattacharya — UGA Terry College **Management Information Systems ('27)**, minoring in mathematics & astrophysics.

Obsidian-style dark workspace: a left-nav shell, a command palette (`Ctrl/⌘ K`), inline-editable everything, gamified progress (XP · levels · day streak), a drag-and-drop recruiting Kanban, a live constellation graph, per-section notes, and a read-only **accountability dashboard** for his partner.

- **Live app:** https://cprat189.github.io/aritra-maxxing/
- Single self-contained `index.html` — no build, no dependencies. Data lives in the browser (localStorage) and syncs via a `data.json` snapshot.

## Logins

| Role | Username | Password | Can do |
|---|---|---|---|
| **Editor** (Aritra) | `aritra` | `godawgs-2027` | Full edit — everything, everywhere |
| **Admin** (accountability partner) | `pratyush` | `northstar-2026` | Read-only oversight of Aritra's live progress |

> ⚠️ **This is a soft gate, not real security.** GitHub Pages is a static host with no server, so the login separates *roles* and adds friction — it does **not** protect secrets. Anyone technical could bypass it by reading the page source. Don't store anything sensitive here. (Passwords are stored as SHA-256 hashes, not plaintext, but that's hygiene, not protection.)

## How "viewable by the partner" works

There's no server, so progress is shared via a snapshot file:

1. Aritra edits freely → autosaves to **his browser** (localStorage).
2. He clicks **Export snapshot** → downloads `data.json` (also copied to clipboard).
3. That `data.json` gets committed to this repo (drag-drop upload in GitHub's web UI works).
4. The admin opens the app and hits **Pull from repo** (or just loads it on a fresh browser) to see the latest.

The committed `data.json` in this repo is also the seed a brand-new browser loads first.

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
