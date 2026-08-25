# NEAR Wave 2 — execution contract

## Parallel tracks

### A. Cloud
- Link Supabase Cloud project.
- Push `0001_near_core.sql` through `0004_*`.
- Record migration status.

### B. Security
- anon: no raw location read.
- authenticated: no raw location read.
- service_role: server-only location access.
- `nearby_users()` returns distance/activity/recent label only.
- `supabase_realtime` contains messages + now_posts, never location_sessions.

### C. Chat
- Conversation membership gates message read/write.
- Realtime subscription is scoped to conversation IDs.
- External contact exchange stays behind mutual connection state.

### D. NOW
- Authenticated read only.
- Expired posts excluded by policy.
- Server cleanup removes expired records.

### E. Device location
- Device obtains location only after explicit permission.
- Send location to private backend boundary.
- Never serialize latitude/longitude into public profile/discovery DTOs.
- Discovery uses server-side proximity calculation.

### F. UX
- Closest First.
- 10-minute discovery radius.
- Recent Here uses coarse temporal/area wording.
- Touch World remains lightweight and non-blocking.

## Gate

No claim of production readiness until Cloud migration, RLS tests, raw GPS leak tests, Realtime tests and real-device location tests pass.
