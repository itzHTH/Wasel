// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_car_motion_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The animated position and heading of the driver's own car.
///
/// The animator and the stream that feeds it share one provider on purpose: a
/// separate feeder could outlive its animator, and an animator disposed mid
/// glide would be rebuilt with no history and snap.

@ProviderFor(driverCarMotion)
final driverCarMotionProvider = DriverCarMotionProvider._();

/// The animated position and heading of the driver's own car.
///
/// The animator and the stream that feeds it share one provider on purpose: a
/// separate feeder could outlive its animator, and an animator disposed mid
/// glide would be rebuilt with no history and snap.

final class DriverCarMotionProvider
    extends $FunctionalProvider<VehicleMotion, VehicleMotion, VehicleMotion>
    with $Provider<VehicleMotion> {
  /// The animated position and heading of the driver's own car.
  ///
  /// The animator and the stream that feeds it share one provider on purpose: a
  /// separate feeder could outlive its animator, and an animator disposed mid
  /// glide would be rebuilt with no history and snap.
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

String _$driverCarMotionHash() => r'3d1e8ef1c944326f4910c53e1c8c6f02ba888d06';
