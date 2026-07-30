import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasal/features/ride/domain/entities/cancel_ride.dart';

part 'cancel_ride_response.g.dart';

@JsonSerializable()
class CancelRideResponse {
  @JsonKey(name: "data")
  final bool isCancelled;

  CancelRideResponse({required this.isCancelled});

  Map<String, dynamic> toJson() => _$CancelRideResponseToJson(this);

  factory CancelRideResponse.fromJson(Map<String, dynamic> json) =>
      _$CancelRideResponseFromJson(json);

  CancelRide toEntity() {
    return CancelRide(isCancelled: isCancelled);
  }
}
