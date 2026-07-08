import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasal/features/ride/domain/entities/request_ride.dart';

part 'request_ride_response.g.dart';

@JsonSerializable()
class RequestRideResponse {
  final String rideId;

  RequestRideResponse({required this.rideId});

  Map<String, dynamic> toJson() => _$RequestRideResponseToJson(this);

  factory RequestRideResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestRideResponseFromJson(json["data"] as Map<String, dynamic>);

  RequestRide toEntity() {
    return RequestRide(id: rideId);
  }
}
