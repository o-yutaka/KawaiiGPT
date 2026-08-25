# NEAR API Contract v0.1

## Public discovery
`nearby_users(lat, lon, radius_m=1000, limit=50)` is authenticated-only and returns:
- user_id
- distance_m
- activity
- recent_label

Never return latitude/longitude.

## Chat
Client operations:
- list conversations for current user
- create conversation with explicit target user
- read messages only when current user is a member
- insert messages only when current user is a member

## NOW
Client operations:
- create a NOW post owned by current user
- read non-expired posts allowed by policy
- react/report
- delete own post

## Connection
State machine:
`NONE -> REQUESTED -> MUTUAL -> EXTERNAL_CONTACT_UNLOCKED`

External contact details are never automatically revealed.

## Error contract
Use stable machine-readable error codes:
`AUTH_REQUIRED`, `FORBIDDEN`, `NOT_FOUND`, `RATE_LIMITED`, `EXPIRED`, `BLOCKED`, `VALIDATION_ERROR`.
