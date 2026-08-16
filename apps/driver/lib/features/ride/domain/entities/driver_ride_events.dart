import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_ride_events.freezed.dart';

@freezed
sealed class DriverRideEvent with _$DriverRideEvent {
  const factory DriverRideEvent.receiveRideRequest({
    required String rideId,
    required GeoPoint position,
    required GeoPoint dropPosition,
    required double calculatedPrice,
    required String paymentMethod,
    required String riderName,
    required String riderPhone,
    required String message,
  }) = ReceiveRideRequest;

  const factory DriverRideEvent.hideRideRequest(String rideId) =
      HideRideRequest;

  const factory DriverRideEvent.profileReviewed({
    required bool isApproved,
    required String message,
  }) = ProfileReviewed;

  const factory DriverRideEvent.cancelled({String? message}) = RideCancelled;
}
