// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RideController)
final rideControllerProvider = RideControllerProvider._();

final class RideControllerProvider
    extends $NotifierProvider<RideController, DriverRideState> {
  RideControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideControllerHash();

  @$internal
  @override
  RideController create() => RideController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DriverRideState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DriverRideState>(value),
    );
  }
}

String _$rideControllerHash() => r'ee64e96fbd63539e7ac9e52e5602db3806649e0c';

abstract class _$RideController extends $Notifier<DriverRideState> {
  DriverRideState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DriverRideState, DriverRideState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DriverRideState, DriverRideState>,
              DriverRideState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
