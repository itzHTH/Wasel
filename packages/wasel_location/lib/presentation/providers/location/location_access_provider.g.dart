// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_access_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// **What it does:** owns the app's location-permission state — whether the app
/// may read the device position right now — and exposes the one action that can
/// change it.
///
/// **Data flow:**
/// - *Reads* the current permission through `deviceLocationRepoProvider`
///   (geolocator's `checkPermission`, mapped to the tri-state [LocationAccess]).
/// - *Writes* by delegating the prompt to `wasel_core`'s `ensurePermission`
///   gate, which owns the "permanently denied → offer app settings" dialog.
/// - *Exposes* `AsyncValue<LocationAccess>` to the UI: banners watch it to
///   decide whether to nag, and `recenterController` reads it before spending
///   battery on a fix.
///
/// **Why `AsyncNotifier` (`@Riverpod(keepAlive: true)` over a class):**
/// - It needs an *action* (`request`), which rules out a plain `FutureProvider`
///   — those are read-only and can only be re-run wholesale by invalidation.
/// - Its initial value comes from an `await`ed platform call, which rules out a
///   synchronous `Notifier`. `AsyncNotifier` gives the loading state for free
///   and lets the UI render something honest during that first read.
/// - `keepAlive` because permission is a device-wide fact, not screen state.
///   Letting it dispose when the last widget unmounts would re-query the
///   platform on every navigation, and briefly re-render as loading each time.
///
/// **Why two permission plugins touch this:** deliberate split of
/// responsibilities. `permission_handler` is used only for the *interaction* —
/// it is what `ensurePermission` is built on and what can deep-link into app
/// settings. Geolocator is used for the *authoritative read*, because it
/// reports location-specific states that `permission_handler` flattens.

@ProviderFor(LocationAccessController)
final locationAccessControllerProvider = LocationAccessControllerProvider._();

/// **What it does:** owns the app's location-permission state — whether the app
/// may read the device position right now — and exposes the one action that can
/// change it.
///
/// **Data flow:**
/// - *Reads* the current permission through `deviceLocationRepoProvider`
///   (geolocator's `checkPermission`, mapped to the tri-state [LocationAccess]).
/// - *Writes* by delegating the prompt to `wasel_core`'s `ensurePermission`
///   gate, which owns the "permanently denied → offer app settings" dialog.
/// - *Exposes* `AsyncValue<LocationAccess>` to the UI: banners watch it to
///   decide whether to nag, and `recenterController` reads it before spending
///   battery on a fix.
///
/// **Why `AsyncNotifier` (`@Riverpod(keepAlive: true)` over a class):**
/// - It needs an *action* (`request`), which rules out a plain `FutureProvider`
///   — those are read-only and can only be re-run wholesale by invalidation.
/// - Its initial value comes from an `await`ed platform call, which rules out a
///   synchronous `Notifier`. `AsyncNotifier` gives the loading state for free
///   and lets the UI render something honest during that first read.
/// - `keepAlive` because permission is a device-wide fact, not screen state.
///   Letting it dispose when the last widget unmounts would re-query the
///   platform on every navigation, and briefly re-render as loading each time.
///
/// **Why two permission plugins touch this:** deliberate split of
/// responsibilities. `permission_handler` is used only for the *interaction* —
/// it is what `ensurePermission` is built on and what can deep-link into app
/// settings. Geolocator is used for the *authoritative read*, because it
/// reports location-specific states that `permission_handler` flattens.
final class LocationAccessControllerProvider
    extends $AsyncNotifierProvider<LocationAccessController, LocationAccess> {
  /// **What it does:** owns the app's location-permission state — whether the app
  /// may read the device position right now — and exposes the one action that can
  /// change it.
  ///
  /// **Data flow:**
  /// - *Reads* the current permission through `deviceLocationRepoProvider`
  ///   (geolocator's `checkPermission`, mapped to the tri-state [LocationAccess]).
  /// - *Writes* by delegating the prompt to `wasel_core`'s `ensurePermission`
  ///   gate, which owns the "permanently denied → offer app settings" dialog.
  /// - *Exposes* `AsyncValue<LocationAccess>` to the UI: banners watch it to
  ///   decide whether to nag, and `recenterController` reads it before spending
  ///   battery on a fix.
  ///
  /// **Why `AsyncNotifier` (`@Riverpod(keepAlive: true)` over a class):**
  /// - It needs an *action* (`request`), which rules out a plain `FutureProvider`
  ///   — those are read-only and can only be re-run wholesale by invalidation.
  /// - Its initial value comes from an `await`ed platform call, which rules out a
  ///   synchronous `Notifier`. `AsyncNotifier` gives the loading state for free
  ///   and lets the UI render something honest during that first read.
  /// - `keepAlive` because permission is a device-wide fact, not screen state.
  ///   Letting it dispose when the last widget unmounts would re-query the
  ///   platform on every navigation, and briefly re-render as loading each time.
  ///
  /// **Why two permission plugins touch this:** deliberate split of
  /// responsibilities. `permission_handler` is used only for the *interaction* —
  /// it is what `ensurePermission` is built on and what can deep-link into app
  /// settings. Geolocator is used for the *authoritative read*, because it
  /// reports location-specific states that `permission_handler` flattens.
  LocationAccessControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationAccessControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationAccessControllerHash();

  @$internal
  @override
  LocationAccessController create() => LocationAccessController();
}

String _$locationAccessControllerHash() =>
    r'9f9e9043bfc0a733765a243ffaf91ca00ffda1b3';

/// **What it does:** owns the app's location-permission state — whether the app
/// may read the device position right now — and exposes the one action that can
/// change it.
///
/// **Data flow:**
/// - *Reads* the current permission through `deviceLocationRepoProvider`
///   (geolocator's `checkPermission`, mapped to the tri-state [LocationAccess]).
/// - *Writes* by delegating the prompt to `wasel_core`'s `ensurePermission`
///   gate, which owns the "permanently denied → offer app settings" dialog.
/// - *Exposes* `AsyncValue<LocationAccess>` to the UI: banners watch it to
///   decide whether to nag, and `recenterController` reads it before spending
///   battery on a fix.
///
/// **Why `AsyncNotifier` (`@Riverpod(keepAlive: true)` over a class):**
/// - It needs an *action* (`request`), which rules out a plain `FutureProvider`
///   — those are read-only and can only be re-run wholesale by invalidation.
/// - Its initial value comes from an `await`ed platform call, which rules out a
///   synchronous `Notifier`. `AsyncNotifier` gives the loading state for free
///   and lets the UI render something honest during that first read.
/// - `keepAlive` because permission is a device-wide fact, not screen state.
///   Letting it dispose when the last widget unmounts would re-query the
///   platform on every navigation, and briefly re-render as loading each time.
///
/// **Why two permission plugins touch this:** deliberate split of
/// responsibilities. `permission_handler` is used only for the *interaction* —
/// it is what `ensurePermission` is built on and what can deep-link into app
/// settings. Geolocator is used for the *authoritative read*, because it
/// reports location-specific states that `permission_handler` flattens.

abstract class _$LocationAccessController
    extends $AsyncNotifier<LocationAccess> {
  FutureOr<LocationAccess> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LocationAccess>, LocationAccess>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LocationAccess>, LocationAccess>,
              AsyncValue<LocationAccess>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
