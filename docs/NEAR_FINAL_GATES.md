# NEAR Final Gates

## Code-complete candidates
- Client domain/services/repositories
- Onboarding/profile/nearby/chat/NOW/connection/safety shells
- server-side proximity RPC
- Realtime publication contract
- moderation/audit/flags
- monetization primitives
- analytics/deep-link contracts
- CI build/analyze/test pipeline

## Environment gates
These cannot be truthfully marked green until executed against the real environment:

1. Supabase Cloud login/link.
2. Cloud migration push.
3. Cloud RLS verification with anon/authenticated/service-role contexts.
4. Cloud raw-GPS leak test.
5. Real Realtime Chat/NOW round-trip.
6. Real device location permission and upload.
7. Android release build/signing.
8. iOS build/signing/distribution.

## Release gate
No production release is declared until every environment gate is green.
