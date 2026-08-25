# NEAR Pricing & Trial v1

Pricing target: deliberately a little below the mainstream Japanese matching-app monthly range while keeping enough value to avoid bargain positioning. Current market references show roughly ¥2,200+ for Tinder Plus, around ¥3,200/month for Bumble Premium, and roughly ¥3,600–¥4,100/month for several Japanese services depending on plan/payment method. Prices vary by account, platform and promotion, so final store prices are configurable rather than hard-coded. citeturn0search0turn0search2turn0search13

## Free
- Account/profile
- Nearby / 10-minute world
- Basic chat
- NOW viewing/posting
- Connection
- Safety tools
- Ads may appear

## NEAR Plus
- Target: ¥1,980/month
- 3 months: ¥5,280 (¥1,760/month)
- 12 months: ¥17,760 (¥1,480/month)
- Ad-free
- Expanded discovery controls
- Recent Here expanded window
- Profile customization
- Monthly visibility boost

## NEAR Boost
- ¥480 one-time
- 30-minute visibility boost
- Strict frequency cap
- Never reveals exact location

## NEAR Premium
- Target: ¥2,980/month
- 3 months: ¥7,980 (¥2,660/month)
- 12 months: ¥25,800 (¥2,150/month)
- Plus features
- More visibility credits
- Advanced discovery filters
- Private mode
- Premium profile effects

## Trial / experience-first model
No forced paywall immediately after onboarding.

### New-user experience
- First 3 days: Plus-level discovery experience with ads.
- One free 24-hour Premium preview after the first meaningful activation event (first chat or first Connection), once per account.
- First Boost: free, limited to one use during onboarding week.
- After the trial, core chat and discovery remain usable for free.

## Gender pricing
The core product remains free for women as the planned acquisition/density strategy, with ads where appropriate. Premium optional features can exist for everyone; eligibility and pricing must follow applicable platform rules and local law.

## Internationalization
Do not hard-code JPY into business logic. Use a country pricing table with local currency, store product IDs, taxes and promotional overrides.

## Revenue principles
- Never sell precise location history.
- Do not make messaging pay-to-use in the core experience.
- Ads are clearly labeled and frequency capped.
- Affiliate offers are disclosed and attribution is privacy-minimized.
- Pricing can be remotely configured through feature flags/config, without app binary changes.
