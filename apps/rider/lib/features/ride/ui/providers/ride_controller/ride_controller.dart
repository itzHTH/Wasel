import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/domain/entities/ride_event.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_state.dart';
import 'package:wasal/features/ride/ride_di_providers.dart';

part 'ride_controller.g.dart';

@riverpod
class RideController extends _$RideController {
  StreamSubscription<RideEvent>? _rideHub;

  @override
  RideState build() {
    // The tracking connection is for the ride we just requested; join it by id
    // right after connecting so the server keeps the socket open.
    final rideId = ref.watch(requestRideControllerProvider).value?.id;
    final usecase = ref.watch(watchRideUseCaseProvider);
    _rideHub = usecase.call(rideId ?? '').listen(_onEvent);

    ref.onDispose(() => _rideHub?.cancel());

    return RideState(stage: RideStage.searching);
  }

  void _onEvent(RideEvent event) {
    state = switch (event) {
      RideAccepted(:final driver, :final driverPosition) => state.copyWith(
        driver: driver,
        driverPosition: driverPosition ?? state.driverPosition,
        stage: RideStage.accepted,
      ),

      DriverMoved(:final position) => state.copyWith(driverPosition: position),

      DriverArrived() => state.copyWith(stage: RideStage.arrived),

      RideStarted() => state.copyWith(stage: RideStage.inProgress),

      RideCompleted() => state.copyWith(stage: RideStage.completed),

      RideCancelled(:final message) => state.copyWith(
        stage: RideStage.cancelled,
        error: message,
      ),
    };
  }
}
