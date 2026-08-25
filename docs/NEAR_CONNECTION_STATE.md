# NEAR Connection State Machine

```text
NONE
  ↓ request
REQUESTED
  ├─ reject → NONE
  └─ accept → MUTUAL
                 ↓ explicit unlock
          EXTERNAL_CONTACT_UNLOCKED
```

Rules:
- A user can block from any active state.
- Block removes discovery and messaging visibility in both directions.
- External contact is never automatically shared.
- Unlock requires explicit action by both parties.
- Connection state is independent of precise location.
