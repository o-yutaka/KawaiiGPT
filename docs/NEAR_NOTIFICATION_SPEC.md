# NEAR Notification Contract

Notification classes:
- new_message
- connection_request
- connection_accepted
- now_nearby
- moderation_action
- system

Rules:
- No notification contains raw location.
- Do not reveal another user's exact presence to a third party through notification text.
- Respect mute/block state.
- Server controls rate limits and deduplication.
- Push payloads should use opaque IDs and fetch protected content after authentication where possible.
