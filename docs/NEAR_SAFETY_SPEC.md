# NEAR Safety Specification

## Location
- Never expose raw latitude/longitude to another client.
- Public discovery uses server-calculated distance and coarse temporal labels.
- Do not expose movement history, routes, home/work inference, or exact historical coordinates.
- Location retention must be bounded by expiry.

## User controls
- Block removes discovery and messaging visibility in both directions.
- Report creates a moderation event without exposing reporter identity to the reported user.
- Account deletion removes or anonymizes associated social/location data according to retention policy.

## Contact exchange
External contact details are not available on first contact. Exchange is unlocked only after mutual Connection and explicit user action.

## Abuse controls
- Rate-limit discovery, messages, reports, and connection requests.
- Detect spam patterns server-side.
- Maintain an auditable moderation event trail.
- Never use safety scoring to silently reveal private user information.

## Minor safety
Age gating and age-appropriate discovery policies are mandatory before public launch. Unknown-adult/minor interactions must be restricted by policy and enforced server-side.

## Privacy
Personalized advertising must use consent and platform/privacy controls where required. Precise location is not used as a public identifier.
