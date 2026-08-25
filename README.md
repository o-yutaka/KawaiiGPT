# NEAR

**Local Real-Time Social World**

KawaiiGPT is being repurposed as the NEAR prototype/development base.

NEAR core:

- **Closest First** — show the nearest active person first.
- **10-Minute World** — the user's local social world is centered on a 10-minute discovery radius.
- **Recent Here** — safe recent-presence discovery such as “5分前にこの周辺”.
- **NOW** — short-lived, location-aware social posts.
- **Chat** — move from discovery to conversation in one action.
- **Connection** — mutual relationship state before optional external contact sharing.
- **Touch World** — lightweight pointer-following glow, particles, motion and haptics on supported clients.
- **Safety First** — raw GPS is never a public client field; location is aggregated/limited before discovery.

## Current prototype

The repository now contains a **zero-dependency Python local prototype** for the first UX slice.

```text
Open
  ↓
Nearby
  ↓
Closest First
  ↓
Touch World
  ↓
Profile / Chat
  ↓
Recent Here
  ↓
NOW
```

Start on Windows/macOS/Linux with Python 3:

```bash
python install.py
```

Or:

```bash
python kawai.py
```

Then open:

```text
http://127.0.0.1:8787
```

Health check:

```text
http://127.0.0.1:8787/health
```

## Docker policy

**Docker is not required and is not part of the NEAR architecture.**

The target production architecture is:

```text
Flutter / Dart client
        ↓
Supabase Cloud
  ├─ PostgreSQL
  ├─ Auth
  ├─ Realtime
  ├─ Storage
  └─ Edge Functions
```

The current local prototype intentionally uses only the Python standard library. It does not create a local database and does not depend on Docker.

## Directory intent

```text
near_app.py      local prototype server + mobile-first UX slice
near_core.py     domain models + closest-first ranking primitives
kawai.py         compatibility launcher, now starts NEAR
install.py       Docker-free NEAR launcher
requirements.txt zero third-party dependencies for the prototype
```

## Important privacy rule

The public client domain models do **not** expose raw latitude/longitude. Production location flows must use a privacy boundary such as:

```text
raw device location
  ↓
private service location
  ↓
aggregation / precision reduction
  ↓
Nearby / Recent Here
```

Never expose a user's raw GPS coordinates to another user.

## Development order

1. Finish the local UX vertical slice.
2. Establish Supabase Cloud schema and RLS.
3. Port Nearby/Chat/NOW to Supabase Realtime.
4. Add real device location with privacy aggregation.
5. Add Recent Here safety gates.
6. Add push notifications, analytics and admin.
7. Add Premium / Ads / Affiliate only after the social core is stable.

## Status

`NEAR prototype — Wave 1 foundation`

This repository is a development base. The local prototype uses representative data for UI validation; it does not claim those users or locations are real.
