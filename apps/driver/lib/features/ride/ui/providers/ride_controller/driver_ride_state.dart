import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_ride_state.freezed.dart';

enum DriverStage {
  offline,
  online,
  offerReceived,
  heading,
  arrived,
  inProgress,
  completed,
}

enum DriverConnectionState { idle, connecting, reconnecting, dropped }

@freezed
abstract class DriverRideState with _$DriverRideState {
  const factory DriverRideState({
    @Default(DriverStage.offline) DriverStage stage,
    @Default(DriverConnectionState.idle) DriverConnectionState connection,
    ReceiveRideRequest? ride,
    @Default(0) int secondsLeft,
  }) = _DriverRideState;
}
