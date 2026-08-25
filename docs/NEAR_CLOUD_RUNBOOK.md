# NEAR Cloud runbook

This is the only manual gate requiring the project owner's Supabase credentials.

```bash
supabase login
supabase link --project-ref <PROJECT_REF>
supabase db push
```

Then run the verification suite against the Cloud project using two non-privileged test accounts and one server-side service-role context.

Required assertions:

1. `anon` cannot select from `location_sessions`.
2. `authenticated` cannot select from `location_sessions`.
3. Public discovery cannot return `latitude` or `longitude`.
4. `nearby_users()` returns only `user_id`, `distance_m`, `activity`, `recent_label`.
5. A conversation member can read/write its messages.
6. A non-member cannot read another conversation's messages.
7. `now_posts` hides expired rows.
8. `location_sessions` is not in `supabase_realtime` publication.
9. `messages` and `now_posts` are in `supabase_realtime`.
10. Service-role cleanup removes expired location/NOW rows.

Do not mark the Cloud gate green from local SQL parsing alone.
