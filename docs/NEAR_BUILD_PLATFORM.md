# NEAR Build Platform

Primary Windows path: Flutter + Nowa + Supabase Cloud.

Nowa is Flutter-based and currently documents cloud iOS builds/TestFlight without requiring a Mac, while allowing source export. This keeps the existing NEAR Flutter work reusable. EAS remains a secondary option if a React Native/Expo spike is later useful.

## Policy
- Do not migrate the main NEAR codebase merely for tooling convenience.
- Keep Flutter as the canonical application source.
- Use Nowa as a Windows-friendly visual/build path where useful.
- Use cloud iOS builds; Apple Developer credentials remain required for signing/distribution.
- Keep Supabase Cloud as the backend.

## Release path
Windows -> Flutter/Nowa -> cloud build -> TestFlight / Google Play.

## Spike
If Nowa is adopted, import/export a small NEAR vertical slice first: onboarding -> nearby -> chat -> NOW. Compare generated code, build reliability, source ownership, performance, and integration effort before migrating anything larger.
