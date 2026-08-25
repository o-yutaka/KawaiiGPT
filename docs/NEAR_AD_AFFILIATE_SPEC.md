# NEAR Ads / Affiliate Contract

## Principle
Monetization must not expose raw location or private chat content to advertisers.

## Ad slots
- nearby_feed_native
- now_feed_native
- chat_list_native
- profile_native

Every sponsored unit is clearly labeled.

## Targeting
Use consented, privacy-safe signals such as coarse city, selected interests and contextual page category. Do not use precise location history as an advertiser-facing identifier.

## Affiliate
Store:
- offer_id
- campaign_id
- anonymous attribution id
- timestamp
- conversion status

Disclose affiliate relationships and allow users to control relevant personalization where required.

## Frequency
Implement per-user frequency caps and suppression after repeated dismissals.
