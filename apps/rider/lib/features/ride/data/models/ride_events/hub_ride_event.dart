import 'package:freezed_annotation/freezed_annotation.dart';

part 'hub_ride_event.freezed.dart';

@freezed
sealed class HubRideEvent with _$HubRideEvent {
  const factory HubRideEvent.accepted({
    required String rideId,
    required String driverId,
    required String message,
  }) = RideAccepted;

  const factory HubRideEvent.driverMoved(LatLngDto position) = DriverMoved;

  const factory HubRideEvent.driverArrived({
    required String rideId,
    required String message,
  }) = DriverArrived;

  const factory HubRideEvent.started({
    required String rideId,
    required String message,
  }) = RideStarted;

  const factory HubRideEvent.completed({
    required String rideId,
    required String message,
  }) = RideCompleted;

  const factory HubRideEvent.cancelled({String? message}) = RideCancelled;
}

@freezed
abstract class LatLngDto with _$LatLngDto {
  const factory LatLngDto({required double lat, required double lng}) =
      _LatLngDto;
}
