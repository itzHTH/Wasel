import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_rides/data/services/rides_api_service.dart';
import 'package:wasel_rides/domain/entities/active_ride.dart';
import 'package:wasel_rides/domain/repos/base_active_ride_repo.dart';

class ActiveRideRepo implements BaseActiveRideRepo {
  final RidesApiService _ridesApiService;

  ActiveRideRepo(this._ridesApiService);

  @override
  Future<ApiResults<ActiveRide?>> getActiveRide({
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _ridesApiService.getActiveRide(
        cancelToken: cancelToken,
      );

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }
}
