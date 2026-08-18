import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_ride_body.g.dart';

@JsonSerializable(createFactory: false)
class ReviewRideBody {
  final int rating;
  final String comment;

  ReviewRideBody({required this.rating, required this.comment});

  Map<String, dynamic> toJson() => _$ReviewRideBodyToJson(this);
}
