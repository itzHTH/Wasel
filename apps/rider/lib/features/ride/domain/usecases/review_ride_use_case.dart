import 'package:dio/dio.dart';
import 'package:wasal/features/ride/data/models/review_ride/request/review_ride_body.dart';
import 'package:wasal/features/ride/domain/entities/review_ride.dart';
import 'package:wasal/features/ride/domain/repo/base_ride_repo.dart';
import 'package:wasel_core/wasel_core.dart';

class ReviewRideParams {
  final String rideId;
  final int rating;
  final String comment;

  const ReviewRideParams({
    required this.rideId,
    required this.rating,
    required this.comment,
  });
}

class ReviewRideUseCase
    extends CancellableUseCase<ApiResults<ReviewRide>, ReviewRideParams> {
  final BaseRideRepo _repo;

  ReviewRideUseCase(this._repo);

  @override
  Future<ApiResults<ReviewRide>> execute(
    ReviewRideParams params,
    CancelToken cancelToken,
  ) {
    return _repo.reviewRide(
      params.rideId,
      ReviewRideBody(rating: params.rating, comment: params.comment),
      cancelToken: cancelToken,
    );
  }
}
