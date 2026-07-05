// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_location_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rideLocationController)
final rideLocationControllerProvider = RideLocationControllerProvider._();

final class RideLocationControllerProvider
    extends
        $FunctionalProvider<
          RideLocationController,
          RideLocationController,
          RideLocationController
        >
    with $Provider<RideLocationController> {
  RideLocationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideLocationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideLocationControllerHash();

  @$internal
  @override
  $ProviderElement<RideLocationController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RideLocationController create(Ref ref) {
    return rideLocationController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RideLocationController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RideLocationController>(value),
    );
  }
}

String _$rideLocationControllerHash() =>
    r'7e41e58e2ac120a495acc2a412dc0732fafd1ed5';
