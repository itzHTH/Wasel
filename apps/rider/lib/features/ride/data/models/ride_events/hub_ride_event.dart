import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasal/features/ride/domain/entities/geo_point.dart';
import 'package:wasal/features/ride/domain/entities/ride_event.dart';

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

extension HubRideEventX on HubRideEvent {
  RideEvent toEntity() => switch (this) {
    DriverMoved(:final position) => RideEvent.driverMoved(position.toEntity()),

    DriverArrived(:final rideId, :final message) => RideEvent.driverArrived(
      rideId: rideId,
      message: message,
    ),

    RideStarted(:final rideId, :final message) => RideEvent.started(
      rideId: rideId,
      message: message,
    ),

    RideCompleted(:final rideId, :final message) => RideEvent.completed(
      rideId: rideId,
      message: message,
    ),

    RideCancelled(:final message) => RideEvent.cancelled(message: message),

    RideAccepted() => throw UnimplementedError(
      'accepted enrichment happens in RideRepo (needs REST)',
    ),
  };
}

@freezed
abstract class LatLngDto with _$LatLngDto {
  const factory LatLngDto({required double lat, required double lng}) =
      _LatLngDto;
}

extension LatLngDtoX on LatLngDto {
  GeoPoint toEntity() => GeoPoint(latitude: lat, longitude: lng);
}
