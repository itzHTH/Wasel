import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hub_ride_events.freezed.dart';

@freezed
sealed class HubRideEvent with _$HubRideEvent {
  const factory HubRideEvent.receiveRideRequest({
    required String rideId,
    required LatLngDto position,
    required LatLngDto dropPosition,
    required double calculatedPrice,
    required String paymentMethod,
    required String riderName,
    required String riderPhone,
    required String message,
  }) = ReceiveRideRequest;

  const factory HubRideEvent.hideRideRequest(String rideId) = HideRideRequest;

  const factory HubRideEvent.profileReviewed({
    required bool isApproved,
    required String message,
  }) = ProfileReviewed;

  const factory HubRideEvent.cancelled({String? message}) = RideCancelled;
}

extension HubRideEventX on HubRideEvent {
  DriverRideEvent toEntity() => switch (this) {
    ProfileReviewed(:final isApproved, :final message) =>
      DriverRideEvent.profileReviewed(isApproved: isApproved, message: message),

    HideRideRequest(:final rideId) => DriverRideEvent.hideRideRequest(rideId),

    ReceiveRideRequest(
      :final rideId,
      :final position,
      :final dropPosition,
      :final calculatedPrice,
      :final paymentMethod,
      :final riderName,
      :final riderPhone,
      :final message,
    ) =>
      DriverRideEvent.receiveRideRequest(
        rideId: rideId,
        position: position.toEntity(),
        dropPosition: dropPosition.toEntity(),
        calculatedPrice: calculatedPrice,
        paymentMethod: paymentMethod,
        riderName: riderName,
        riderPhone: riderPhone,
        message: message,
      ),

    RideCancelled(:final message) => DriverRideEvent.cancelled(
      message: message,
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
