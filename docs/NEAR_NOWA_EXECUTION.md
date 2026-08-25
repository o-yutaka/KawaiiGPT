# NEAR × Nowa — Windows-first execution

## Decision
Use Nowa as an optional Windows-first Flutter builder/deployment surface. GitHub remains the source of truth; NEAR's Flutter source remains portable.

## Why
- Nowa supports real Flutter source code and full code download.
- Existing GitHub Flutter projects can be cloned into Nowa Cloud.
- Supabase and RevenueCat integrations are available.
- iOS builds can run in Nowa's cloud and be delivered to TestFlight without a Mac.

## Workflow

Windows PC
→ GitHub `near-rewrite-v1`
→ Nowa Cloud project
→ inspect/refine NEAR UI
→ connect Supabase Cloud
→ run/test
→ cloud iOS build
→ TestFlight

Android uses the same Flutter project and produces APK/AAB.

## Rule
Nowa is not a hard dependency. If it ever becomes a bottleneck, export the Flutter source and continue with standard Flutter tooling. No vendor lock-in.

## First Nowa slice
1. Onboarding
2. Nearby / Closest First
3. Chat
4. NOW
5. Touch World
6. Supabase adapter

## Acceptance
- Same repository remains buildable outside Nowa.
- No Nowa-specific runtime dependency.
- No Docker dependency.
- Raw GPS remains server-side only.
- Cloud RLS/leak tests remain mandatory.
