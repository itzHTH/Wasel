import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/paged/paged_list.dart';
import 'package:wasel_rides/domain/entities/ride_history_entry.dart';

abstract class BaseRidesHistoryRepo {
  Future<ApiResults<PagedList<RideHistoryEntry>>> getRideHistory({
    required int pageNumber,
    required int pageSize,
    CancelToken? cancelToken,
  });
}
