# NEAR Analytics Contract

Events are product telemetry, not a location-history database.

Core events:
- app_open
- onboarding_complete
- location_permission_result
- nearby_view
- nearest_profile_open
- chat_started
- message_sent
- now_view
- now_post_created
- connection_requested
- connection_mutual
- report_created
- block_created
- invite_created
- invite_activated
- ad_impression
- ad_click
- affiliate_click
- purchase_started
- purchase_completed

Location rule: event payloads must use coarse area/city identifiers where needed; never send raw latitude/longitude to analytics.

Primary funnels:
`install -> onboarding -> nearby_view -> chat_started -> connection_mutual`

Safety metrics are monitored alongside growth metrics: report rate, block rate, abuse rate and retention after first contact.
