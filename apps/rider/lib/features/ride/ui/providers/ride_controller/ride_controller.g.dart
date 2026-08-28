// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The rider's view of the current ride.
///
/// The backend owns this state; nothing here is authoritative. On every entry
/// point — cold start, app resume, socket reconnect — the ride is re-read from
/// the server and this state is rebuilt from the answer.
///
/// Kept alive so a screen rebuild does not re-run recovery. `RideTrackingCards`
/// invalidates it when a ride ends, which is what returns it to idle.

@ProviderFor(RideController)
final rideControllerProvider = RideControllerProvider._();

/// The rider's view of the current ride.
///
/// The backend owns this state; nothing here is authoritative. On every entry
/// point — cold start, app resume, socket reconnect — the ride is re-read from
/// the server and this state is rebuilt from the answer.
///
/// Kept alive so a screen rebuild does not re-run recovery. `RideTrackingCards`
/// invalidates it when a ride ends, which is what returns it to idle.
final class RideControllerProvider
    extends $NotifierProvider<RideController, RideState> {
  /// The rider's view of the current ride.
  ///
  /// The backend owns this state; nothing here is authoritative. On every entry
  /// point — cold start, app resume, socket reconnect — the ride is re-read from
  /// the server and this state is rebuilt from the answer.
  ///
  /// Kept alive so a screen rebuild does not re-run recovery. `RideTrackingCards`
  /// invalidates it when a ride ends, which is what returns it to idle.
  RideControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideControllerProvider',
        isAutoDispose: false,
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

String _$rideControllerHash() => r'69cbc5f19d130f694ee8a6f9161fe671d7f4c1c6';

/// The rider's view of the current ride.
///
/// The backend owns this state; nothing here is authoritative. On every entry
/// point — cold start, app resume, socket reconnect — the ride is re-read from
/// the server and this state is rebuilt from the answer.
///
/// Kept alive so a screen rebuild does not re-run recovery. `RideTrackingCards`
/// invalidates it when a ride ends, which is what returns it to idle.

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
