import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasal/features/ride/domain/entities/driver_profile.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_rides/domain/entities/active_ride.dart';
import 'package:wasel_rides/domain/entities/ride_status.dart';

part 'ride_state.freezed.dart';

enum RideStage {
  idel,
  searching,
  accepted,
  arrived,
  inProgress,
  completed,
  cancelled;

  static RideStage fromStatus(RideStatus? status) => switch (status) {
    RideStatus.pending => RideStage.searching,
    RideStatus.accepted => RideStage.accepted,
    RideStatus.arrived => RideStage.arrived,
    RideStatus.inProgress => RideStage.inProgress,
    RideStatus.completed => RideStage.completed,
    RideStatus.cancelled => RideStage.cancelled,
    null => RideStage.searching,
  };
}

@freezed
abstract class RideState with _$RideState {
  const factory RideState({
    @Default(RideStage.idel) RideStage stage,
    DriverProfile? driver,
    GeoPoint? driverPosition,

    ActiveRide? ride,

    String? trackedRideId,

    @Default(false) bool isRecovering,

    String? recoveryError,

    @Default(false) bool isDriverDisconnected,
    @Default(false) bool isLoading,
    String? error,
  }) = _RideState;

  const RideState._();

  bool get hasActiveRide => stage != RideStage.idel;

  String? get rideId => ride?.rideId ?? trackedRideId;

  bool get isAwaitingRecovery => isRecovering || recoveryError != null;
}
