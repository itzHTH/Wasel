import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasal/features/ride/domain/entities/request_ride.dart';

part 'request_ride_response.g.dart';

@JsonSerializable()
class RequestRideResponse {
  @JsonKey(name: "data")
  final String rideId;

  RequestRideResponse({required this.rideId});

  Map<String, dynamic> toJson() => _$RequestRideResponseToJson(this);

  factory RequestRideResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestRideResponseFromJson(json);

  RequestRide toEntity() {
    return RequestRide(id: rideId);
  }
}
