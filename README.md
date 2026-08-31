<div align="center">

  # Wasel — وَصَل
  **Ride-Hailing Platform · Rider & Driver Apps**

  [![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?style=flat&logo=flutter)](https://flutter.dev/)
  [![Backend](https://img.shields.io/badge/Backend-ASP.NET%20Core-512BD4?logo=dotnet)](https://github.com/ENG4CRYO)
  [![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-orange)](https://github.com/)
  [![State Management](https://img.shields.io/badge/State-Riverpod-7209b7)](https://riverpod.dev/)
  [![Monorepo](https://img.shields.io/badge/Monorepo-Melos-1c7ed6)](https://melos.invertase.dev/)
  [![Real-time](https://img.shields.io/badge/Real--time-SignalR-success)](https://dotnet.microsoft.com/apps/aspnet/signalr)

</div>

---

## 🚀 Project Overview

**Wasel** is a two-app ride-hailing platform for intra-governorate trips — a **rider** app for booking and following a trip, and a **driver** app for verification, availability, accepting work, and tracking earnings.

Both apps are built from a single codebase. Most of what they do — networking, authentication, maps, profiles, payments, theming, translations — is written once in shared packages and consumed by both. Only what is genuinely different between a passenger and a driver lives in the apps themselves.

The apps are **Arabic-first and RTL**, with full English support and light/dark themes.

<!-- Drop your cover image here (drag it into the GitHub editor and paste the URL). -->
<img width="1600" alt="wasel flutter" src="docs/screenshots/cover.png" />

> 🚧 Under active development. Not in the stores yet.

---

## 🏗️ Architecture & Design Patterns

The project adopts **Clean Architecture** organized **feature-first**, distributed across a **Melos monorepo**.

### 📂 Monorepo Structure

```
wasel/
├── apps/
│   ├── rider/            passenger app
│   └── driver/           driver app
├── packages/
│   ├── core/             networking, theme, config, shared widgets
│   ├── auth/             login, OTP, registration, session
│   ├── wasel_location/   GPS, geocoding, routing, the map
│   ├── wasel_profile/    rider & driver profiles
│   ├── wasel_payments/   cards, wallet, payment methods
│   └── wasel_rides/      ride history
├── melos.yaml            project scripts
└── pubspec.yaml          workspace root
```

* **Shared by default:** anything two apps could need is written once in `packages/`.
* **Single source of truth:** everything resolves from one lockfile at the root, so both apps can never drift onto different dependency versions.
* **Self-contained features:** each feature is its own module and can be navigated or refactored without touching the rest.

### 🧩 Layered Separation of Concerns

Every feature is organized into three layers, with dependencies pointing one way only:

* **UI:** pure rendering and interaction — no business logic.
* **Domain:** business rules, use cases, and plain entities — no framework code.
* **Data:** APIs, storage, and device access.

*Result:* a change to an API response can never reach a widget without passing through a use case first, and the business rules stay testable in isolation.

---

## ⚙️ Technical Implementation & Engineering Decisions

### 1. State Management (Riverpod)
Adopted **Riverpod** for both state and **dependency injection**, removing the need for a separate service locator.
* **Why?** Providers compose the object graph declaratively, so swapping a real repository for a fake in a test is a one-line override.
* **Mechanism:** `AsyncValue` models loading, data, and error as a single value, and widgets watch the narrowest slice of state they need to avoid unnecessary rebuilds.

### 2. Networking Layer (Dio + Retrofit)
A shared networking layer used by every feature in both apps.
* **Interceptors:** authentication tokens injected automatically, with the active locale attached so server messages return already translated.
* **Error Handling:** exceptions are caught at the data boundary and returned as **values, not thrown** — every repository hands back either a success or a typed failure, so the compiler flags an unhandled error case instead of a user finding it.
* **Resilience:** one token-refresh path shared by REST calls and the real-time connection, so an expiring session mid-trip is refreshed once rather than raced for.

### 3. Real-Time Tracking (SignalR)
Live trip updates run over a **SignalR** hub against the ASP.NET Core backend.
* Driver position, ride status, and offers stream to the client instead of being polled.
* The driver app broadcasts location from a **foreground service**, so tracking survives the app being backgrounded.

### 4. Code Generation
Models, providers, API clients, and unions are generated with `build_runner` (**Freezed**, **json_serializable**, **Riverpod**, **Retrofit**).
* **Why?** It removes hundreds of lines of hand-written boilerplate and makes serialization and DI mistakes compile-time errors rather than runtime ones.

### 5. UI/UX Engineering
* **Two brands, one theme system:** a palette per app means rider and driver look distinct while staying internally consistent. A new color must be defined for both brands in both light and dark, so an unreadable color cannot ship.
* **No first-frame flash:** theme and language are restored *before* the first frame, so a cold start never flashes the wrong colors or text direction.
* **Responsive:** layouts scale across screen sizes and pixel densities; sizes come from a central scale, never hardcoded.
* **Bundled fonts:** typography ships with the app rather than being fetched at runtime — no network dependency and no fallback flash on first launch.

### 6. Configuration & Release Safety
* Nothing environment-specific is hardcoded; config is injected at build time and validated at startup.
* A missing key fails immediately with a message naming exactly which one — **in release builds too**, not just debug.

---

## ✨ Features

<table>
<tr><th align="left">Rider</th><th align="left">Driver</th></tr>
<tr valign="top"><td>

* Phone login and OTP registration
* Place search powered by Google Places
* Ride booking with fare and route preview
* Live driver tracking on the map
* Trip completion, rating, and history
* Profile, payment methods, and wallet

</td><td>

* Phone login and OTP registration
* Document and vehicle verification with in-app camera
* Online/offline availability with background location
* Ride offers, acceptance, and route guidance
* Earnings breakdown and ride history
* Profile and payout details

</td></tr>
</table>

**Shared across both apps:** Arabic and English (RTL-first) · light, dark, and system themes · crash reporting · over-the-air updates.

---

## 🔗 Backend Ecosystem

The backend infrastructure powering this platform was architected and developed by **Mustafa Aqeel**.

It relies on **ASP.NET Core** to manage ride matching, trip lifecycle, payments, and secure authentication, and drives the live tracking layer over **SignalR** — serving as the reliable core for both Wasel mobile clients.

---

## 📸 App Screenshots

<!-- Drag your images into the GitHub editor, then replace the src values below. -->

### Rider

<div align="center">
 <img width="220" alt="rider home" src="docs/screenshots/rider-home.png" />
  &nbsp;&nbsp;
 <img width="220" alt="rider search" src="docs/screenshots/rider-search.png" />
  &nbsp;&nbsp;
 <img width="220" alt="rider tracking" src="docs/screenshots/rider-tracking.png" />
  &nbsp;&nbsp;
 <img width="220" alt="rider completed" src="docs/screenshots/rider-completed.png" />
</div>

### Driver

<div align="center">
 <img width="220" alt="driver home" src="docs/screenshots/driver-home.png" />
  &nbsp;&nbsp;
 <img width="220" alt="driver verification" src="docs/screenshots/driver-verification.png" />
  &nbsp;&nbsp;
 <img width="220" alt="driver ride" src="docs/screenshots/driver-ride.png" />
  &nbsp;&nbsp;
 <img width="220" alt="driver earnings" src="docs/screenshots/driver-earnings.png" />
</div>

---

## 💻 Installation & Setup

This project uses **FVM (Flutter Version Management)** and **Melos** to keep the development environment consistent across the monorepo.

### 1. Prerequisites

```bash
dart pub global activate fvm
dart pub global activate melos
```

> The [Shorebird CLI](https://shorebird.dev) is only needed if you intend to cut releases.

##

### 2. Clone & Configure

#### A. Clone the repository
```bash
git clone https://github.com/itzHTH/Wasel.git
```

#### B. Navigate to the project directory
```bash
cd Wasel
```

#### C. Install the specific Flutter SDK version used in this project
```bash
fvm install
```

#### D. Install dependencies for the whole workspace
```bash
fvm flutter pub get
```

#### E. Create the environment files
```bash
cp env.example.json env.prod.json
cp env.example.json env.dev.json
cp apps/rider/env.keys.example.json  apps/rider/env.keys.json
cp apps/driver/env.keys.example.json apps/driver/env.keys.json
```

#### F. Generate code and translations
```bash
melos run gen
melos run l10n
```
##

### 3. Run the Application

```bash
melos run run:rider     # or: melos run run:driver
```

---

## 🔑 Configuration

Nothing environment-specific is hardcoded. Values are passed at build time and read through `AppEnv`:

```
env.prod.json                BASE_URL, HUB_URL                (git-ignored)
env.dev.json                 BASE_URL, HUB_URL                (git-ignored)
apps/rider/env.keys.json     SEARCH_API_KEY, ROUTES_API_KEY   (git-ignored)
apps/driver/env.keys.json    SEARCH_API_KEY, ROUTES_API_KEY   (git-ignored)
```

The backend URL sits in one root file, so pointing both apps at a different server is a one-file change. Google keys are per-app because their values differ.

Native Maps SDK keys are a separate mechanism and live in `apps/*/android/local.properties` and `apps/*/ios/Flutter/*.xcconfig` (both git-ignored).

### Available Scripts

| Command | What it does |
|---|---|
| `melos run gen` | Run code generation everywhere |
| `melos run l10n` | Regenerate translations |
| `melos run test` | Run all tests |
| `melos run run:rider` / `run:driver` | Run an app |
| `melos run build:rider` / `build:driver` | Build a release bundle |
| `melos run shorebird:release:prod` | Cut a Shorebird release |
| `melos run shorebird:patch:prod` | Push an over-the-air patch |

---

## 🧪 Testing

```bash
melos run test
```

39 test files covering the parts where a bug is expensive and a quick manual check wouldn't catch it: error handling, business rules, and the theme system — including color-contrast checks so a new color can't ship unreadable on one of the two brands. Nothing in the suite depends on real waiting; timers are simulated.

---

## 🚢 Releases

Two GitHub Actions workflows build and ship both apps together.

* **Release** — runs on a version tag (`v1.2.3`), builds each app with its own signing key and config, and sends the result to Firebase App Distribution for testers.
* **Patch** — runs on every push to `main` that touches app or package code, and pushes a Shorebird over-the-air update to devices already on the latest release.

> ⚠️ Patches must be built with the same config files as the release they patch. Config is baked in at build time, so a mismatch silently points the app at the wrong backend.

---

## 🛠️ Tech Stack

* **Framework:** Flutter & Dart
* **State Management:** Riverpod
* **Networking:** Dio + Retrofit
* **Real-time:** SignalR
* **Maps & Location:** Google Maps, Places, Routes, Geolocator
* **Storage:** Shared Preferences, Secure Storage
* **Localization:** Flutter `gen_l10n` (Arabic / English)
* **Monitoring:** Firebase Crashlytics
* **Delivery:** Shorebird OTA, GitHub Actions, Firebase App Distribution
* **Architecture:** Clean Architecture / Feature-First / Melos Monorepo

---

## 🗺️ Roadmap

**Done** — OTP login · place search · ride booking · live tracking · rating and history · profiles · driver verification · earnings · payments and wallet · dark mode · Arabic and English · crash reporting · Android release and OTA pipelines

**Next** — `go_router` migration · iOS release pipeline · push notifications · wider test coverage

---

## 📄 License

© Huthaifa Mohammed. All rights reserved.

The source is published for reading and evaluation. It is not licensed for reuse, redistribution, or derivative works.

---

## 👨‍💻 Developed By

**Huthaifa Mohammed** - *Flutter Developer*

**Mustafa Aqeel** - *Backend Developer* [**Visit Mustafa's Profile**](https://github.com/ENG4CRYO)
