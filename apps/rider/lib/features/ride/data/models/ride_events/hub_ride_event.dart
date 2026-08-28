import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasal/features/ride/domain/entities/ride_event.dart';
import 'package:wasel_rides/domain/entities/active_ride.dart';

part 'hub_ride_event.freezed.dart';

@freezed
sealed class HubRideEvent with _$HubRideEvent {
  const factory HubRideEvent.accepted({
    required String rideId,
    required String driverId,
    required String message,
    LatLngDto? driverPosition,
    String? driverName,
    String? driverProfilePictureUrl,
    String? vehicleModel,
    String? vehicleYear,
    String? vinNumber,
    String? phoneNumber,
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

  const factory HubRideEvent.driverDisconnected({
    required String rideId,
    required String message,
  }) = DriverDisconnected;

  const factory HubRideEvent.statusSync(ActiveRide? ride) = RideStatusSync;
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

    DriverDisconnected(:final rideId, :final message) =>
      RideEvent.driverDisconnected(rideId: rideId, message: message),

    RideStatusSync(:final ride) => RideEvent.statusSync(ride),

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
