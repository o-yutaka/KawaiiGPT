# NEAR Test Matrix

## Security
- [ ] anon cannot read location_sessions
- [ ] authenticated cannot read location_sessions
- [ ] service_role-only location access
- [ ] nearby RPC emits no raw coordinates
- [ ] blocked users cannot discover each other
- [ ] non-members cannot read conversations
- [ ] non-members cannot insert messages

## Realtime
- [ ] messages realtime subscription respects RLS
- [ ] NOW realtime subscription respects RLS
- [ ] location_sessions absent from realtime publication

## Product
- [ ] closest-first deterministic ordering
- [ ] 10-minute cutoff
- [ ] expired NOW hidden
- [ ] Recent Here coarse labels only
- [ ] Connection state transitions

## Client
- [ ] onboarding
- [ ] permission denied state
- [ ] offline state
- [ ] reconnect
- [ ] touch effect does not block scroll/tap
- [ ] chat send/receive

## Monetization
- [ ] ad labels visible
- [ ] frequency cap
- [ ] affiliate disclosure
- [ ] no raw GPS in ad/affiliate payload

No production release until Cloud and real-device checks pass.
