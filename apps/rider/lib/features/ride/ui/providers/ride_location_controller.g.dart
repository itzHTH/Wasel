// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_location_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RideLocationController)
final rideLocationControllerProvider = RideLocationControllerProvider._();

final class RideLocationControllerProvider
    extends $NotifierProvider<RideLocationController, RideLocationState> {
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
  RideLocationController create() => RideLocationController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RideLocationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RideLocationState>(value),
    );
  }
}

String _$rideLocationControllerHash() =>
    r'dda6b2640554247133419c502c6b3ddf8d7e368c';

abstract class _$RideLocationController extends $Notifier<RideLocationState> {
  RideLocationState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RideLocationState, RideLocationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RideLocationState, RideLocationState>,
              RideLocationState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
