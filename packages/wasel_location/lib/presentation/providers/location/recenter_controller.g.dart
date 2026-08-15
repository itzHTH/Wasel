// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recenter_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// **What it does:** implements the "my location" action — ensure permission,
/// obtain a position, fly the map camera to it — and publishes enough state for
/// a button to render itself.
///
/// **Data flow:**
/// - *Reads* permission from `locationAccessControllerProvider`, a live fix from
///   [deviceLocationProvider] when one is already flowing, and otherwise a cold
///   fix from `getCurrentLocationUseCaseProvider`.
/// - *Writes* to the map through `mapControllerHolderProvider`'s
///   `animateCamera`.
/// - *Exposes* [RecenterState] to `MyLocationButton` (landing in step 5) and
///   `myLocationEnabled` to whichever widget builds the `AppMap`.
///
/// **Why `Notifier` (`@riverpod` over a class) and not `AsyncNotifier`:** the
/// state here is not "a value being loaded" — it is a small UI machine with an
/// in-flight flag and a last-failure slot, whose result is a *side effect* (the
/// camera moved) rather than data anyone reads. Modelling it as `AsyncValue`
/// would misrepresent that: there is no `data` to hold, and an `AsyncError`
/// would leave the button stuck in an error state that nothing clears. A plain
/// synchronous `Notifier` with an explicit `build()` default says exactly what
/// this is.
///
/// **Why auto-dispose:** this is per-screen interaction state. When the map is
/// gone, an in-flight flag and a stale failure should go with it — carrying them
/// to the next screen would show a spinner or an error nobody triggered.
///
/// **Why the live-fix fast path exists:** the driver app already holds an open
/// position stream whenever it is online, so asking the platform for a *fresh*
/// high-accuracy fix would spend seconds and battery re-deriving something
/// already in memory. Reading [deviceLocationProvider] first collapses the
/// driver's case to an instant camera move, while the rider — which holds no
/// stream on the booking screen — falls through to the cold-fix path. One
/// controller, both behaviours, no branching by app.

@ProviderFor(RecenterController)
final recenterControllerProvider = RecenterControllerProvider._();

/// **What it does:** implements the "my location" action — ensure permission,
/// obtain a position, fly the map camera to it — and publishes enough state for
/// a button to render itself.
///
/// **Data flow:**
/// - *Reads* permission from `locationAccessControllerProvider`, a live fix from
///   [deviceLocationProvider] when one is already flowing, and otherwise a cold
///   fix from `getCurrentLocationUseCaseProvider`.
/// - *Writes* to the map through `mapControllerHolderProvider`'s
///   `animateCamera`.
/// - *Exposes* [RecenterState] to `MyLocationButton` (landing in step 5) and
///   `myLocationEnabled` to whichever widget builds the `AppMap`.
///
/// **Why `Notifier` (`@riverpod` over a class) and not `AsyncNotifier`:** the
/// state here is not "a value being loaded" — it is a small UI machine with an
/// in-flight flag and a last-failure slot, whose result is a *side effect* (the
/// camera moved) rather than data anyone reads. Modelling it as `AsyncValue`
/// would misrepresent that: there is no `data` to hold, and an `AsyncError`
/// would leave the button stuck in an error state that nothing clears. A plain
/// synchronous `Notifier` with an explicit `build()` default says exactly what
/// this is.
///
/// **Why auto-dispose:** this is per-screen interaction state. When the map is
/// gone, an in-flight flag and a stale failure should go with it — carrying them
/// to the next screen would show a spinner or an error nobody triggered.
///
/// **Why the live-fix fast path exists:** the driver app already holds an open
/// position stream whenever it is online, so asking the platform for a *fresh*
/// high-accuracy fix would spend seconds and battery re-deriving something
/// already in memory. Reading [deviceLocationProvider] first collapses the
/// driver's case to an instant camera move, while the rider — which holds no
/// stream on the booking screen — falls through to the cold-fix path. One
/// controller, both behaviours, no branching by app.
final class RecenterControllerProvider
    extends $NotifierProvider<RecenterController, RecenterState> {
  /// **What it does:** implements the "my location" action — ensure permission,
  /// obtain a position, fly the map camera to it — and publishes enough state for
  /// a button to render itself.
  ///
  /// **Data flow:**
  /// - *Reads* permission from `locationAccessControllerProvider`, a live fix from
  ///   [deviceLocationProvider] when one is already flowing, and otherwise a cold
  ///   fix from `getCurrentLocationUseCaseProvider`.
  /// - *Writes* to the map through `mapControllerHolderProvider`'s
  ///   `animateCamera`.
  /// - *Exposes* [RecenterState] to `MyLocationButton` (landing in step 5) and
  ///   `myLocationEnabled` to whichever widget builds the `AppMap`.
  ///
  /// **Why `Notifier` (`@riverpod` over a class) and not `AsyncNotifier`:** the
  /// state here is not "a value being loaded" — it is a small UI machine with an
  /// in-flight flag and a last-failure slot, whose result is a *side effect* (the
  /// camera moved) rather than data anyone reads. Modelling it as `AsyncValue`
  /// would misrepresent that: there is no `data` to hold, and an `AsyncError`
  /// would leave the button stuck in an error state that nothing clears. A plain
  /// synchronous `Notifier` with an explicit `build()` default says exactly what
  /// this is.
  ///
  /// **Why auto-dispose:** this is per-screen interaction state. When the map is
  /// gone, an in-flight flag and a stale failure should go with it — carrying them
  /// to the next screen would show a spinner or an error nobody triggered.
  ///
  /// **Why the live-fix fast path exists:** the driver app already holds an open
  /// position stream whenever it is online, so asking the platform for a *fresh*
  /// high-accuracy fix would spend seconds and battery re-deriving something
  /// already in memory. Reading [deviceLocationProvider] first collapses the
  /// driver's case to an instant camera move, while the rider — which holds no
  /// stream on the booking screen — falls through to the cold-fix path. One
  /// controller, both behaviours, no branching by app.
  RecenterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recenterControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recenterControllerHash();

  @$internal
  @override
  RecenterController create() => RecenterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecenterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecenterState>(value),
    );
  }
}

String _$recenterControllerHash() =>
    r'2c4499b0d934464d9bdd4f045b6e3cc9d0a93937';

/// **What it does:** implements the "my location" action — ensure permission,
/// obtain a position, fly the map camera to it — and publishes enough state for
/// a button to render itself.
///
/// **Data flow:**
/// - *Reads* permission from `locationAccessControllerProvider`, a live fix from
///   [deviceLocationProvider] when one is already flowing, and otherwise a cold
///   fix from `getCurrentLocationUseCaseProvider`.
/// - *Writes* to the map through `mapControllerHolderProvider`'s
///   `animateCamera`.
/// - *Exposes* [RecenterState] to `MyLocationButton` (landing in step 5) and
///   `myLocationEnabled` to whichever widget builds the `AppMap`.
///
/// **Why `Notifier` (`@riverpod` over a class) and not `AsyncNotifier`:** the
/// state here is not "a value being loaded" — it is a small UI machine with an
/// in-flight flag and a last-failure slot, whose result is a *side effect* (the
/// camera moved) rather than data anyone reads. Modelling it as `AsyncValue`
/// would misrepresent that: there is no `data` to hold, and an `AsyncError`
/// would leave the button stuck in an error state that nothing clears. A plain
/// synchronous `Notifier` with an explicit `build()` default says exactly what
/// this is.
///
/// **Why auto-dispose:** this is per-screen interaction state. When the map is
/// gone, an in-flight flag and a stale failure should go with it — carrying them
/// to the next screen would show a spinner or an error nobody triggered.
///
/// **Why the live-fix fast path exists:** the driver app already holds an open
/// position stream whenever it is online, so asking the platform for a *fresh*
/// high-accuracy fix would spend seconds and battery re-deriving something
/// already in memory. Reading [deviceLocationProvider] first collapses the
/// driver's case to an instant camera move, while the rider — which holds no
/// stream on the booking screen — falls through to the cold-fix path. One
/// controller, both behaviours, no branching by app.

abstract class _$RecenterController extends $Notifier<RecenterState> {
  RecenterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RecenterState, RecenterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RecenterState, RecenterState>,
              RecenterState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
