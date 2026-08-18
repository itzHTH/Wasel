import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasal/features/ride/domain/entities/review_ride.dart';

part 'review_ride_response.g.dart';

@JsonSerializable()
class ReviewRideResponse {
  @JsonKey(name: "succeeded", defaultValue: false)
  final bool succeeded;

  @JsonKey(name: "data")
  final bool? isReviewed;

  ReviewRideResponse({required this.succeeded, this.isReviewed});

  Map<String, dynamic> toJson() => _$ReviewRideResponseToJson(this);

  factory ReviewRideResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewRideResponseFromJson(json);

  ReviewRide toEntity() {
    return ReviewRide(isReviewed: isReviewed ?? succeeded);
  }
}
