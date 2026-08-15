// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// **What it does:** publishes a live feed of the device's position, one event
/// per meaningful movement.
///
/// **Data flow:** `watchDeviceLocationUseCaseProvider` → `deviceLocationRepo` →
/// `DeviceLocationService` → the OS. Emits domain [DeviceFix] values, never
/// geolocator's `Position`. Consumed by everything that has to follow the user:
/// the driver's camera, the car marker, the location broadcaster, and route
/// drawing from the current position.
///
/// **Why `StreamProvider` (a `@riverpod` function returning `Stream`):**
/// - The underlying data source is genuinely push-based. Modelling it as a
///   `FutureProvider` that callers re-invalidate would turn a continuous feed
///   into polling, and polling GPS is the most expensive thing this app can do.
/// - Riverpod converts the stream into `AsyncValue` automatically, so the three
///   states the UI actually cares about — waiting for the first fix, streaming,
///   or errored — arrive without any hand-written state class. A stream error
///   surfaces as `AsyncError` carrying our `LocationException`, so consumers can
///   pattern-match on the reason.
/// - **`.value` semantics are the real reason.** `AsyncValue` retains the last
///   emitted fix across a transient error, so a car marker keeps its position
///   through a tunnel instead of vanishing and snapping back.
///
/// **Why auto-dispose (no `keepAlive`):** this is the single most important
/// lifecycle decision in the package. The platform stream stays open exactly as
/// long as this provider has listeners, so when the last consumer goes away the
/// GPS hardware is released. Marking it `keepAlive` would leave the sensors
/// running for the life of the process and drain the battery of every idle
/// driver. Multiple simultaneous watchers still share *one* OS subscription,
/// because they all share this one provider.

@ProviderFor(deviceLocation)
final deviceLocationProvider = DeviceLocationProvider._();

/// **What it does:** publishes a live feed of the device's position, one event
/// per meaningful movement.
///
/// **Data flow:** `watchDeviceLocationUseCaseProvider` → `deviceLocationRepo` →
/// `DeviceLocationService` → the OS. Emits domain [DeviceFix] values, never
/// geolocator's `Position`. Consumed by everything that has to follow the user:
/// the driver's camera, the car marker, the location broadcaster, and route
/// drawing from the current position.
///
/// **Why `StreamProvider` (a `@riverpod` function returning `Stream`):**
/// - The underlying data source is genuinely push-based. Modelling it as a
///   `FutureProvider` that callers re-invalidate would turn a continuous feed
///   into polling, and polling GPS is the most expensive thing this app can do.
/// - Riverpod converts the stream into `AsyncValue` automatically, so the three
///   states the UI actually cares about — waiting for the first fix, streaming,
///   or errored — arrive without any hand-written state class. A stream error
///   surfaces as `AsyncError` carrying our `LocationException`, so consumers can
///   pattern-match on the reason.
/// - **`.value` semantics are the real reason.** `AsyncValue` retains the last
///   emitted fix across a transient error, so a car marker keeps its position
///   through a tunnel instead of vanishing and snapping back.
///
/// **Why auto-dispose (no `keepAlive`):** this is the single most important
/// lifecycle decision in the package. The platform stream stays open exactly as
/// long as this provider has listeners, so when the last consumer goes away the
/// GPS hardware is released. Marking it `keepAlive` would leave the sensors
/// running for the life of the process and drain the battery of every idle
/// driver. Multiple simultaneous watchers still share *one* OS subscription,
/// because they all share this one provider.

final class DeviceLocationProvider
    extends
        $FunctionalProvider<AsyncValue<DeviceFix>, DeviceFix, Stream<DeviceFix>>
    with $FutureModifier<DeviceFix>, $StreamProvider<DeviceFix> {
  /// **What it does:** publishes a live feed of the device's position, one event
  /// per meaningful movement.
  ///
  /// **Data flow:** `watchDeviceLocationUseCaseProvider` → `deviceLocationRepo` →
  /// `DeviceLocationService` → the OS. Emits domain [DeviceFix] values, never
  /// geolocator's `Position`. Consumed by everything that has to follow the user:
  /// the driver's camera, the car marker, the location broadcaster, and route
  /// drawing from the current position.
  ///
  /// **Why `StreamProvider` (a `@riverpod` function returning `Stream`):**
  /// - The underlying data source is genuinely push-based. Modelling it as a
  ///   `FutureProvider` that callers re-invalidate would turn a continuous feed
  ///   into polling, and polling GPS is the most expensive thing this app can do.
  /// - Riverpod converts the stream into `AsyncValue` automatically, so the three
  ///   states the UI actually cares about — waiting for the first fix, streaming,
  ///   or errored — arrive without any hand-written state class. A stream error
  ///   surfaces as `AsyncError` carrying our `LocationException`, so consumers can
  ///   pattern-match on the reason.
  /// - **`.value` semantics are the real reason.** `AsyncValue` retains the last
  ///   emitted fix across a transient error, so a car marker keeps its position
  ///   through a tunnel instead of vanishing and snapping back.
  ///
  /// **Why auto-dispose (no `keepAlive`):** this is the single most important
  /// lifecycle decision in the package. The platform stream stays open exactly as
  /// long as this provider has listeners, so when the last consumer goes away the
  /// GPS hardware is released. Marking it `keepAlive` would leave the sensors
  /// running for the life of the process and drain the battery of every idle
  /// driver. Multiple simultaneous watchers still share *one* OS subscription,
  /// because they all share this one provider.
  DeviceLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceLocationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceLocationHash();

  @$internal
  @override
  $StreamProviderElement<DeviceFix> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DeviceFix> create(Ref ref) {
    return deviceLocation(ref);
  }
}

String _$deviceLocationHash() => r'bb1197427c01edc04f67d097ec7fa33b7a750213';

/// **What it does:** exposes just the coordinate of the latest fix.
///
/// **Data flow:** derived from [deviceLocationProvider]; exposes `GeoPoint?` to
/// any consumer that needs a position but not heading, speed or accuracy.
///
/// **Why a separate derived provider:** rebuild scope. A moving vehicle emits a
/// new [DeviceFix] whenever *any* field changes — heading and speed jitter
/// constantly even when the coordinate is stable — so a widget that only draws a
/// point would rebuild on every one of those. This provider recomputes just as
/// often, but recomputing is cheap and Riverpod only notifies listeners when the
/// *output* changes. Because [GeoPoint] has value equality, an unchanged
/// coordinate compares equal and the rebuild stops here instead of propagating
/// into the widget tree.
///
/// Null while the first fix is still being acquired, or after an error with no
/// previously retained value.

@ProviderFor(currentPoint)
final currentPointProvider = CurrentPointProvider._();

/// **What it does:** exposes just the coordinate of the latest fix.
///
/// **Data flow:** derived from [deviceLocationProvider]; exposes `GeoPoint?` to
/// any consumer that needs a position but not heading, speed or accuracy.
///
/// **Why a separate derived provider:** rebuild scope. A moving vehicle emits a
/// new [DeviceFix] whenever *any* field changes — heading and speed jitter
/// constantly even when the coordinate is stable — so a widget that only draws a
/// point would rebuild on every one of those. This provider recomputes just as
/// often, but recomputing is cheap and Riverpod only notifies listeners when the
/// *output* changes. Because [GeoPoint] has value equality, an unchanged
/// coordinate compares equal and the rebuild stops here instead of propagating
/// into the widget tree.
///
/// Null while the first fix is still being acquired, or after an error with no
/// previously retained value.

final class CurrentPointProvider
    extends $FunctionalProvider<GeoPoint?, GeoPoint?, GeoPoint?>
    with $Provider<GeoPoint?> {
  /// **What it does:** exposes just the coordinate of the latest fix.
  ///
  /// **Data flow:** derived from [deviceLocationProvider]; exposes `GeoPoint?` to
  /// any consumer that needs a position but not heading, speed or accuracy.
  ///
  /// **Why a separate derived provider:** rebuild scope. A moving vehicle emits a
  /// new [DeviceFix] whenever *any* field changes — heading and speed jitter
  /// constantly even when the coordinate is stable — so a widget that only draws a
  /// point would rebuild on every one of those. This provider recomputes just as
  /// often, but recomputing is cheap and Riverpod only notifies listeners when the
  /// *output* changes. Because [GeoPoint] has value equality, an unchanged
  /// coordinate compares equal and the rebuild stops here instead of propagating
  /// into the widget tree.
  ///
  /// Null while the first fix is still being acquired, or after an error with no
  /// previously retained value.
  CurrentPointProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentPointProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentPointHash();

  @$internal
  @override
  $ProviderElement<GeoPoint?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GeoPoint? create(Ref ref) {
    return currentPoint(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GeoPoint? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GeoPoint?>(value),
    );
  }
}

String _$currentPointHash() => r'f9e878b3b5004ca2b1cc6437fbd85c10ca99f2fe';
