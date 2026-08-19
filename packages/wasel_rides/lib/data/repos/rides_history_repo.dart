import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_core/networking/paged/paged_list.dart';
import 'package:wasel_rides/data/services/rides_api_service.dart';
import 'package:wasel_rides/domain/entities/ride_history_entry.dart';
import 'package:wasel_rides/domain/repos/base_rides_history_repo.dart';

class RidesHistoryRepo implements BaseRidesHistoryRepo {
  final RidesApiService _ridesApiService;

  RidesHistoryRepo(this._ridesApiService);

  @override
  Future<ApiResults<PagedList<RideHistoryEntry>>> getRideHistory({
    required int pageNumber,
    required int pageSize,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _ridesApiService.getRideHistory(
        pageNumber: pageNumber,
        pageSize: pageSize,
        cancelToken: cancelToken,
      );

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }
}
