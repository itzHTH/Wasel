# Driver Verification — Feature Spec (implementation boundary)

> **Status: NOT IMPLEMENTED.** This folder is a scaffold only — empty layered
> directories, a single placeholder screen (`VerificationPlaceholderScreen`),
> and this spec. The feature itself is the owner's to build. Do not treat the
> placeholder as a starting implementation.

After a driver completes registration, they must submit verification documents
and vehicle details, then wait for a back-office decision before they can use
the app. There is **no FCM** — the app **polls** the verification status.

## Flow

```
register/login  ─▶  verification (upload form)
                        │  submit
                        ▼
                     pending  ──poll──▶  approved  ─▶  home
                        ▲                 rejected  ─▶  upload form (re-submit)
                        └──────────────────────────────┘
```

1. Driver lands on the upload form (entry point: `AppRoutes.driverVerification`).
2. Driver fills vehicle fields + picks the four images, submits (multipart POST).
3. App shows **pending** and polls the status endpoint (GET) on an interval.
4. **approved** → navigate to home. **rejected** → back to the upload form to
   re-submit (surface the rejection reason if the API returns one).

## Upload request — multipart/form-data

Binary file parts:

| Field              | Type   | Notes                          |
| ------------------ | ------ | ------------------------------ |
| `LicenseFrontImage`| binary | Driver's license — front       |
| `LicenseBackImage` | binary | Driver's license — back        |
| `SelfieImage`      | binary | Selfie for identity match      |
| `VehicleImage`     | binary | Photo of the vehicle           |

String parts:

| Field          | Type   | Notes                    |
| -------------- | ------ | ------------------------ |
| `VehicleModel` | string | e.g. "Toyota Corolla"    |
| `VehicleYear`  | string | e.g. "2020"              |
| `VinNumber`    | string | Vehicle VIN              |

## Status polling — GET

Returns one of: `pending` | `approved` | `rejected`
(plus an optional human-readable reason when `rejected`).

## Endpoints

Not defined here — leave as `// TODO(me): driver endpoint` constants in
`wasel_core` `ApiConstants` and fill them from the backend. Do not invent URLs.

## Architecture notes (when implementing)

- Follow the project layering: `data/` (models grouped per action with
  `request/` + `response/`, Retrofit `@RestApi` service, repo impl) →
  `domain/` (entities, abstract `BaseDriverVerificationRepo`, use cases
  extending `CancellableUseCase`) → `ui/` (Riverpod `@riverpod` notifiers,
  screens, widgets).
- A **generic multipart helper** is worth adding to `wasel_core` (the rider may
  reuse it later) rather than hand-rolling `FormData` in the service.
- Map response models → entities via `toEntity()`; never leak data models into
  the UI. Errors flow through `ApiResults` / `ErrorHandler` like the rest of the
  app.
- Polling: an `AsyncNotifier` with a timer (cancel on dispose) is the simplest
  fit; do not add FCM.
