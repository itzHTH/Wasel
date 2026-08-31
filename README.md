# Wasal — وَصَل

A Flutter taxi client app for booking rides within local governorates.

> 🚧 Currently under development

---

## About

**Wasal** is a Flutter app for passengers to request taxi rides within their governorate. Built with modern technologies to deliver a smooth and reliable experience.

## Tech Stack

- **Flutter** — UI
- **Riverpod** — State management
- **Retrofit + Dio** — API communication
- **SignalR** — Real-time driver tracking
- **Google Maps** — Maps & geolocation
- **Firebase Messaging** — Push notifications
- **Go Router** — Navigation

## Status

- [ ] OTP login
- [ ] Map & location selection
- [ ] Ride booking
- [ ] Real-time driver tracking
- [ ] Ride rating

---

## Environment setup

Every value that varies by environment is passed at build time via
`--dart-define-from-file` and read through `AppEnv`
(`packages/core/lib/config/app_env.dart`). No URL or key is hardcoded in Dart.

There are two layers of env files. The root file holds the backend, so pointing
the apps at a different backend (a local Docker instance, say) is a one-file
change. Each app keeps its own Google keys, because their values differ.

```
env.prod.json                      BASE_URL, HUB_URL          (git-ignored)
env.dev.json                       BASE_URL, HUB_URL          (git-ignored)
apps/rider/env.keys.json           SEARCH_API_KEY, ROUTES_API_KEY   (git-ignored)
apps/driver/env.keys.json          SEARCH_API_KEY, ROUTES_API_KEY   (git-ignored)
```

### First-time setup

```bash
cp env.example.json env.prod.json
cp env.example.json env.dev.json
cp apps/rider/env.keys.example.json  apps/rider/env.keys.json
cp apps/driver/env.keys.example.json apps/driver/env.keys.json
# fill in the values, then:
melos run run:rider     # or: melos run run:driver
```

Or run directly, from inside the app directory:

```bash
flutter run --flavor production -t lib/main_prod.dart \
  --dart-define-from-file=../../env.prod.json \
  --dart-define-from-file=env.keys.json
```

`AppEnv.ensureConfigured()` runs as the first statement of `main()` and throws
if any value is missing, naming the missing keys. It throws rather than asserts,
so a release build fails the same way a debug build does.

### Shorebird: pass the same env files at patch time as at release time

`--dart-define` values are compile-time constants baked into the binary. A patch
built with different env files carries URLs that do not match the release
running on testers' devices.

```bash
shorebird release android --flavor production -t lib/main_prod.dart \
  --artifact apk -- --dart-define-from-file=../../env.prod.json \
                    --dart-define-from-file=env.keys.json

shorebird patch android --flavor production -t lib/main_prod.dart \
  --track staging -- --dart-define-from-file=../../env.prod.json \
                     --dart-define-from-file=env.keys.json
```

The `melos run shorebird:*` scripts already pass the matching pair.

### A note on the Google keys

A `--dart-define` value is embedded in the binary and can be recovered from a
shipped build, exactly as the previous bundled `.env` could. The protection is
restricting each key by app and API in the Cloud Console, not hiding it.

The native Maps SDK keys are a separate mechanism and are not part of this:
they are consumed by Gradle and Swift, so they stay in
`apps/*/android/local.properties` and `apps/*/ios/Flutter/*.xcconfig`
(both git-ignored).

---

*Client app — Flutter | Backend: .NET*
