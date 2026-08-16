// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A continuous feed of the device's location.
//
//? - Uses StreamProvider to naturally handle push-based GPS updates.
//
//? - Auto-dispose ensures the OS location stream is closed and hardware
//?   is released the moment all UI listeners are gone (Battery Saver).
//
//? - Riverpod's [AsyncValue] gracefully holds the last known `.value`
//?   during transient errors (e.g., entering a tunnel).

@ProviderFor(deviceLocation)
final deviceLocationProvider = DeviceLocationProvider._();

/// A continuous feed of the device's location.
//
//? - Uses StreamProvider to naturally handle push-based GPS updates.
//
//? - Auto-dispose ensures the OS location stream is closed and hardware
//?   is released the moment all UI listeners are gone (Battery Saver).
//
//? - Riverpod's [AsyncValue] gracefully holds the last known `.value`
//?   during transient errors (e.g., entering a tunnel).

final class DeviceLocationProvider
    extends
        $FunctionalProvider<AsyncValue<DeviceFix>, DeviceFix, Stream<DeviceFix>>
    with $FutureModifier<DeviceFix>, $StreamProvider<DeviceFix> {
  /// A continuous feed of the device's location.
  //
  //? - Uses StreamProvider to naturally handle push-based GPS updates.
  //
  //? - Auto-dispose ensures the OS location stream is closed and hardware
  //?   is released the moment all UI listeners are gone (Battery Saver).
  //
  //? - Riverpod's [AsyncValue] gracefully holds the last known `.value`
  //?   during transient errors (e.g., entering a tunnel).
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

/// Derives just the coordinates from the location feed.
//
// Acts as a rebuild shield: //? prevents UI widgets that only need the coordinate
//? from needlessly rebuilding when only the heading or speed jitter.

@ProviderFor(currentPoint)
final currentPointProvider = CurrentPointProvider._();

/// Derives just the coordinates from the location feed.
//
// Acts as a rebuild shield: //? prevents UI widgets that only need the coordinate
//? from needlessly rebuilding when only the heading or speed jitter.

final class CurrentPointProvider
    extends $FunctionalProvider<GeoPoint?, GeoPoint?, GeoPoint?>
    with $Provider<GeoPoint?> {
  /// Derives just the coordinates from the location feed.
  //
  // Acts as a rebuild shield: //? prevents UI widgets that only need the coordinate
  //? from needlessly rebuilding when only the heading or speed jitter.
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
