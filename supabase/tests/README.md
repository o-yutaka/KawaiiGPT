# NEAR Cloud verification suite

This directory contains the production verification checklist for the Supabase Cloud gate.

Required order:
1. Apply migrations to the linked Cloud project.
2. Run RLS role checks for anon/authenticated/service_role.
3. Prove raw latitude/longitude cannot be selected by client roles.
4. Prove authorized conversation members can read/write messages and non-members cannot.
5. Prove NOW expiry is enforced.
6. Enable Realtime only for messages/now_posts after the RLS gate passes.

No test may treat a local mock as Cloud verification.
