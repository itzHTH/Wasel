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
    extends $NotifierProvider<RideController, RideState> {
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
  Override overrideWithValue(RideState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RideState>(value),
    );
  }
}

String _$rideControllerHash() => r'9c1ba1634c87f078b0245091a1a7ffabd8701106';

abstract class _$RideController extends $Notifier<RideState> {
  RideState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RideState, RideState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RideState, RideState>,
              RideState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
