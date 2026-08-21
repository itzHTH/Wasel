// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_car_motion_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The animated position and heading of the driver's car on the rider's map.
///
/// No heading is passed: the hub sends coordinates only, so [VehicleMotion]
/// derives the bearing from consecutive positions.

@ProviderFor(driverCarMotion)
final driverCarMotionProvider = DriverCarMotionProvider._();

/// The animated position and heading of the driver's car on the rider's map.
///
/// No heading is passed: the hub sends coordinates only, so [VehicleMotion]
/// derives the bearing from consecutive positions.

final class DriverCarMotionProvider
    extends $FunctionalProvider<VehicleMotion, VehicleMotion, VehicleMotion>
    with $Provider<VehicleMotion> {
  /// The animated position and heading of the driver's car on the rider's map.
  ///
  /// No heading is passed: the hub sends coordinates only, so [VehicleMotion]
  /// derives the bearing from consecutive positions.
  DriverCarMotionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverCarMotionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverCarMotionHash();

  @$internal
  @override
  $ProviderElement<VehicleMotion> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VehicleMotion create(Ref ref) {
    return driverCarMotion(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VehicleMotion value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VehicleMotion>(value),
    );
  }
}

String _$driverCarMotionHash() => r'0f948657f662ae3c22691ac44b37d184716e3246';
