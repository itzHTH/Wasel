import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/domain/entities/driver_profile.dart';
import 'package:wasal/features/ride/domain/entities/ride_event.dart';
import 'package:wasal/features/ride/domain/usecases/reconnect_to_ride_use_case.dart';
import 'package:wasal/features/ride/domain/usecases/watch_ride_use_case.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_state.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_price/ride_price_provider.dart';
import 'package:wasal/features/ride/ride_di_providers.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_location/wasel_location.dart';
import 'package:wasel_rides/domain/entities/active_ride.dart';
import 'package:wasel_rides/domain/usecases/get_active_ride_use_case.dart';
import 'package:wasel_rides/presentation/providers/rides_di_providers.dart';

part 'ride_controller.g.dart';

@Riverpod(keepAlive: true)
class RideController extends _$RideController {
  StreamSubscription<RideEvent>? _rideHub;

  String? _trackedRideId;

  int _recovery = 0;

  String? _hydratedRideId;

  late WatchRideUseCase _watchRide;
  late ReconnectToRideUseCase _reconnect;
  late GetActiveRideUseCase _getActiveRide;

  @override
  RideState build() {
    _watchRide = ref.watch(watchRideUseCaseProvider);
    _reconnect = ref.watch(reconnectToRideUseCaseProvider);
    _getActiveRide = ref.watch(getActiveRideUseCaseProvider);

    ref.onDispose(_getActiveRide.cancel);
    ref.onDispose(_stopTracking);

    unawaited(Future.microtask(() => _recover(reportFailure: true)));

    return const RideState(isRecovering: true);
  }

  void startTracking(String rideId) {
    if (rideId.isEmpty) return;

    state = state.copyWith(
      trackedRideId: rideId,
      stage: RideStage.searching,
      isRecovering: false,
      isDriverDisconnected: false,
      error: null,
      recoveryError: null,
    );
    _listen(rideId);
  }

  Future<void> refreshFromBackend() => _recover(reportFailure: false);

  Future<void> retryRecovery() => _recover(reportFailure: true);

  void clearRide() {
    _stopTracking();
    _recovery++;
    _hydratedRideId = null;
    state = const RideState();
  }

  Future<void> _recover({required bool reportFailure}) async {
    final recovery = ++_recovery;

    state = state.copyWith(isRecovering: true, recoveryError: null);

    final result = await _getActiveRide.call(null);

    if (!ref.mounted || recovery != _recovery) return;

    result.when(
      failure: (error) {
        if (error.isCancelled) return;

        state = (!reportFailure || state.hasActiveRide)
            ? state.copyWith(isRecovering: false)
            : state.copyWith(
                isRecovering: false,
                recoveryError: errorMessageOf(error),
              );
      },
      success: (ride) {
        _applySnapshot(ride, isRecovering: false);

        final rideId = state.ride?.rideId;
        if (rideId == null) return;

        if (_trackedRideId == rideId && _rideHub != null) {
          unawaited(_rejoin(rideId));
          return;
        }

        _listen(rideId);
        unawaited(_rejoin(rideId));
      },
    );
  }

  Future<void> _rejoin(String rideId) async {
    await _reconnect.call(rideId);
  }

  void _listen(String rideId) {
    _stopTracking();
    _trackedRideId = rideId;

    _rideHub = _watchRide.call(rideId).listen(_onEvent);
  }

  void _stopTracking() {
    _rideHub?.cancel();
    _rideHub = null;
    _trackedRideId = null;
  }

  void _hydrateRideDetails(ActiveRide ride) {
    if (_hydratedRideId == ride.rideId) return;
    _hydratedRideId = ride.rideId;

    ref
        .read(rideDraftProvider.notifier)
        .hydrateFrom(
          LatLng(ride.pickupLatitude, ride.pickupLongitude),
          LatLng(ride.dropoffLatitude, ride.dropoffLongitude),
        );

    if (ride.calculatedPrice > 0) {
      ref
          .read(ridePriceEstimateProvider.notifier)
          .adoptFare(ride.calculatedPrice);
    }
  }

  void _onEvent(RideEvent event) {
    if (!ref.mounted) return;

    switch (event) {
      case RideAccepted(:final driver, :final driverPosition):
        state = state.copyWith(
          driver: driver,
          driverPosition: driverPosition ?? state.driverPosition,
          stage: RideStage.accepted,
          isDriverDisconnected: false,
        );

      case DriverMoved(:final position):
        state = state.copyWith(
          driverPosition: position,
          isDriverDisconnected: false,
        );

      case DriverArrived():
        state = state.copyWith(stage: RideStage.arrived);

      case RideStarted():
        state = state.copyWith(stage: RideStage.inProgress);

      case RideCompleted():
        state = state.copyWith(stage: RideStage.completed);

      case RideCancelled(:final message):
        state = state.copyWith(stage: RideStage.cancelled, error: message);

      case DriverDisconnected():
        state = state.copyWith(isDriverDisconnected: true);

      case RideStatusSync(:final ride):
        _applySnapshot(ride, isRecovering: false);
    }
  }

  void _applySnapshot(ActiveRide? ride, {required bool isRecovering}) {
    if (ride == null || (ride.status?.isTerminal ?? false)) {
      _stopTracking();
      _recovery++;
      _hydratedRideId = null;
      state = RideState(
        stage: ride == null
            ? RideStage.idel
            : RideStage.fromStatus(ride.status),
        isRecovering: isRecovering,
      );
      return;
    }

    _hydrateRideDetails(ride);

    state = state.copyWith(
      ride: ride,
      trackedRideId: ride.rideId,
      stage: RideStage.fromStatus(ride.status),
      driver: _driverOf(ride) ?? state.driver,
      driverPosition: _positionOf(ride) ?? state.driverPosition,
      isRecovering: isRecovering,
      isDriverDisconnected: false,
      error: null,
      recoveryError: null,
    );
  }

  static DriverProfile? _driverOf(ActiveRide ride) {
    if (!ride.hasDriver) return null;

    return DriverProfile(
      id: ride.driverId!,
      name: ride.driverName ?? '',
      phoneNumber: ride.driverPhone,
      plateNumber: ride.vinNumber,
      carModel: ride.vehicleModel,
      vehicleYear: ride.vehicleYear?.toString(),
    );
  }

  static GeoPoint? _positionOf(ActiveRide ride) => ride.hasDriverPosition
      ? GeoPoint(
          latitude: ride.driverLatitude!,
          longitude: ride.driverLongitude!,
        )
      : null;
}
