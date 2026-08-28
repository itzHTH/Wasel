import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasal/features/ride/domain/entities/driver_profile.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_rides/domain/entities/active_ride.dart';

part 'ride_event.freezed.dart';

@freezed
sealed class RideEvent with _$RideEvent {
  const factory RideEvent.accepted({
    required String rideId,
    required DriverProfile driver,
    GeoPoint? driverPosition,
  }) = RideAccepted;

  const factory RideEvent.driverMoved(GeoPoint position) = DriverMoved;

  const factory RideEvent.driverArrived({
    required String rideId,
    required String message,
  }) = DriverArrived;

  const factory RideEvent.started({
    required String rideId,
    required String message,
  }) = RideStarted;

  const factory RideEvent.completed({
    required String rideId,
    required String message,
  }) = RideCompleted;

  const factory RideEvent.cancelled({String? message}) = RideCancelled;

  const factory RideEvent.driverDisconnected({
    required String rideId,
    required String message,
  }) = DriverDisconnected;

  const factory RideEvent.statusSync(ActiveRide? ride) = RideStatusSync;
}
