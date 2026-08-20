# CLAUDE.md

<!--
Golden Test: "Would removing this rule cause Claude to make mistakes?"
If not — cut it. Don't restate defaults Claude already knows.
-->

---

# Section A — General Engineering Rules

## 1) Architecture & Separation of Concerns (YOU MUST FOLLOW)
- Follow the project's architecture layer boundaries strictly: presentation → domain → data
- Never bypass layers or mix responsibilities
- UI/presentation layer has ZERO business logic — only rendering, interaction, and state observation
- Business logic lives in the domain layer
- Data access (APIs, databases, storage) lives in the data layer
- Do not introduce new abstractions or patterns without justification

## 2) Shared Code (IMPORTANT)
- Any reusable logic, utility, constant, extension, or helper used in 2+ places goes in `core/`
- Check `core/` before creating new shared code — never duplicate across features

## 3) Error Handling
- Errors flow cleanly across layers — never skip layers
- Handle null, empty, loading, and error states explicitly — no silent failures
- Catch errors at the boundary (data layer), not deep inside business logic

## 4) Change Discipline
- Make the smallest change that solves the problem
- Fix root causes, not symptoms
- Don't refactor unrelated code unless explicitly requested
- Never break existing functionality, APIs, flows, or UX unless explicitly instructed
- Read relevant code before modifying it — state assumptions when unclear

## 5) Dependencies
- Don't add new packages without justification
- Any new package must be: latest stable, well-maintained, production-grade

## 6) Security
- Never hardcode secrets, tokens, or credentials
- Never log sensitive information
- Validate all external and API input
- Proactively flag security risks when spotted

## 7) Testing
- Write tests for domain and data layer logic
- Bug fixes must include a reproducing test
- Tests must be deterministic — no flaky or timing-dependent tests
- One behavior per test case

## 8) Workflow (Mandatory)
- Before creating any new feature → invoke the `/flutter-feature` skill first for scaffolding and architecture reference
- Before marking any task done → run the `/flutter-code-review` skill
- After task approved → use the `@git-expert` agent for branch, commit, and PR output

## 9) Agents — Proactively Suggest (YOU MUST FOLLOW)
You MUST proactively suggest the appropriate agent when the situation matches. Do not wait for the user to ask.

- `@debugger` — When a bug, crash, error, or unexpected behavior is encountered
- `@code-reviewer` — After `/flutter-code-review` passes, ALWAYS suggest running `@code-reviewer` for a deeper independent review before proceeding to PR
- `@test-writer` — OPT-IN ONLY (exception to the proactive rule above). Do NOT suggest or run it automatically. If code changes lack tests, you may ASK ONCE whether to run it, and invoke it only after the user explicitly confirms.
- `@git-expert` — When it's time to create a branch, commit, or PR. Also for merge conflicts, rebases, or any complex git situation

---

# Section B — Flutter / Dart Specific Rules (`wasal`)

<!--
Follow official Dart style guide, Effective Dart, and flutter_lints defaults.
Rules below only cover things that OVERRIDE defaults or encode project decisions.
These rules describe how `wasal` is actually built — keep them in sync with the code.
-->

## 1) State Management — Riverpod
- Use **Riverpod** (`flutter_riverpod` + `riverpod_annotation`, `@riverpod` codegen) for feature and application state — not Bloc/Cubit, Provider, or GetX
- Notifier / AsyncNotifier classes depend ONLY on use cases — never directly on repositories or data sources
- Use `AsyncValue` to represent loading / data / error UI states
- Screens read state via `ConsumerWidget` / `ConsumerStatefulWidget`
- `setState` is allowed ONLY for local ephemeral UI state (e.g., toggles, form focus) — never for business logic; keep it scoped to the smallest widget
- Reference pattern: `features/auth/ui/providers/login/login_provider.dart`

## 2) Code Generation — Required
- This project relies on **`build_runner`** code generation — do NOT hand-write what is generated:
  - **Freezed** for sealed unions (e.g. `ApiResults`)
  - **`@JsonSerializable`** (`json_serializable`) for data models
  - **`@riverpod`** (`riverpod_generator`) for providers and DI
  - **`@RestApi`** (`retrofit_generator`) for API services
- After editing any annotated class, run: `dart run build_runner build --delete-conflicting-outputs`
- Never hand-edit generated files (`*.g.dart`, `*.freezed.dart`)

## 3) Domain Layer Purity
- Domain layer must have ZERO Flutter imports — no `package:flutter/...` in any file under `domain/`
- Known pragmatic exception: `CancellableUseCase` imports Dio's `CancelToken` solely for request cancellation

## 4) Feature Folder Structure
- `features/{feature}/data/` — `models/` (grouped per action with `request/` + `response/`), `repo/` (impl of the abstract repo), `services/` (Retrofit `@RestApi`)
- `features/{feature}/domain/` — `entities/` (plain Dart classes), `repo/` (abstract `Base{Feature}Repo`), `usecases/`
- `features/{feature}/ui/` — `providers/`, `screens/`, `widgets/`
- Conceptual layering stays presentation (`ui/`) → domain → data

## 5) Error Handling Contract
- Data layer: catch exceptions and map via `ErrorHandler.handle(e)` → `ApiResults.failure(...)` (`core/networking/errors/error_handler.dart`, `api_error_model.dart`)
- Domain + data: return `ApiResults<T>` — a Freezed `Success` / `Failure` union in `core/networking/api_results.dart`
- UI: pattern-match `result.when(success:, failure:)` and map to `AsyncValue` / user-friendly messages

## 6) Dependency Injection — Riverpod
- **Riverpod providers ARE the service locator** — do NOT use `get_it`
- DI factory providers compose the graph: `dioFactoryProvider` → `authApiServiceProvider` → `authRepoProvider` → use-case providers (`auth_use_case_providers.dart`)
- Resolve dependencies via `ref.watch` / `ref.read` — never instantiate manually

## 7) Networking & Use Cases
- **Dio + Retrofit**; base Dio config lives in `core/networking/dio_factory.dart`
- API endpoints are centralized in `core/networking/api_constants.dart` (flavor-aware `baseUrl` via `FlavorConfig`)
- Use cases extend `CancellableUseCase` (`core/usecase/`) to support Dio `CancelToken` cancellation
- Map response models → domain entities via `toEntity()` — never leak data models past the data layer

## 8) Routing
- Current routing uses `core/routing/app_router.dart` `onGenerateRoute` + `AppRoutes` names (`app_routes_name.dart`) + `NavigationExtension`
- `go_router` is the **planned** router (migration later) — keep new routes migration-friendly

## 9) Build Method Discipline (IMPORTANT)
- Prefer `const` constructors wherever possible
- NEVER create `TextEditingController`, `AnimationController`, `FocusNode`, or other expensive objects inside `build()`
- Avoid heavy work inside `build()` methods
- Dispose controllers and focus nodes in `StatefulWidget.dispose()`
- Prefer small, composed widgets to minimize rebuild scope
- Use `Consumer` / `ref.watch(provider.select(...))` on the smallest widget that needs the state — never at the top of the tree

## 10) Theming & Localization
- Colors and text styles are theme-scoped: use `context.colors.<token>` and `context.styles.<style>` (from `theme_context_extension.dart`) — the static `AppColor` class is gone
- Each app injects its brand at the root `ProviderScope` via `appBrandProvider`; palettes live in `packages/core/lib/theme/palettes/`
- New tokens go in `AppColorsExtension` (`app_colors_extension.dart`) with a value for BOTH brands and BOTH brightnesses — never a raw `Color(0x…)` at a call site
- Use `AppDimens` (flutter_screenutil `.r/.h/.w`) and `AppTheme` — never hardcode sizes
- Both apps support light/dark/system; the mode is persisted and restored before `runApp`. Anything drawn outside the widget tree (map overlays, `CustomPainter`) must take resolved colors as parameters
- App is RTL (Arabic). Localization is not yet wired; the planned approach is **Flutter's built-in localization** (`flutter_localizations` + `intl` / `gen_l10n`), NOT `easy_localization` (currently declared but unused, to be removed when localization is implemented)

## graphify

This project has a knowledge graph at graphify-out/ with god nodes, community structure, and cross-file relationships.

Rules:
- For codebase questions, first run `graphify query "<question>"` when graphify-out/graph.json exists. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts. These return a scoped subgraph, usually much smaller than GRAPH_REPORT.md or raw grep output.
- If graphify-out/wiki/index.md exists, use it for broad navigation instead of raw source browsing.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying code, run `graphify update .` to keep the graph current (AST-only, no API cost).
