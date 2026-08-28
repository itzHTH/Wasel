import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasel_rides/domain/entities/active_ride.dart';
import 'package:wasel_rides/domain/entities/ride_status.dart';

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

extension RideStatusStage on RideStatus {
  DriverStage? get driverStage => switch (this) {
    RideStatus.accepted => DriverStage.heading,
    RideStatus.arrived => DriverStage.arrived,
    RideStatus.inProgress => DriverStage.inProgress,
    RideStatus.pending || RideStatus.completed || RideStatus.cancelled => null,
  };
}

@freezed
abstract class DriverRideState with _$DriverRideState {
  const factory DriverRideState({
    @Default(DriverStage.offline) DriverStage stage,
    @Default(DriverConnectionState.idle) DriverConnectionState connection,
    ReceiveRideRequest? ride,
    @Default(0) int secondsLeft,
    ActiveRide? activeRide,

    @Default(false) bool isRecovering,
  }) = _DriverRideState;

  const DriverRideState._();

  String? get rideId => ride?.rideId ?? activeRide?.rideId;
  ReceiveRideRequest? get currentRide => ride ?? activeRide?.toOffer();
}
