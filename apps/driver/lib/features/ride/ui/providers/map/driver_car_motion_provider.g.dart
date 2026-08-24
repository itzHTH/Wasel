// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_car_motion_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The animated position and heading of the driver's own car.

@ProviderFor(driverCarMotion)
final driverCarMotionProvider = DriverCarMotionProvider._();

/// The animated position and heading of the driver's own car.

final class DriverCarMotionProvider
    extends $FunctionalProvider<VehicleMotion, VehicleMotion, VehicleMotion>
    with $Provider<VehicleMotion> {
  /// The animated position and heading of the driver's own car.
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

String _$driverCarMotionHash() => r'c4d7e82d0bb235694dad97353d58772dadf96057';
