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
