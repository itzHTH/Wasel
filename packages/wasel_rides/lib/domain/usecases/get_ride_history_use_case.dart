import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/paged/paged_list.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_rides/domain/entities/ride_history_entry.dart';
import 'package:wasel_rides/domain/repos/base_rides_history_repo.dart';

class RideHistoryPageParams {
  final int pageNumber;
  final int pageSize;

  const RideHistoryPageParams({
    required this.pageNumber,
    required this.pageSize,
  });
}

class GetRideHistoryUseCase
    extends
        CancellableUseCase<
          ApiResults<PagedList<RideHistoryEntry>>,
          RideHistoryPageParams
        > {
  final BaseRidesHistoryRepo _ridesHistoryRepo;

  GetRideHistoryUseCase(this._ridesHistoryRepo);

  @override
  Future<ApiResults<PagedList<RideHistoryEntry>>> execute(
    RideHistoryPageParams params,
    CancelToken cancelToken,
  ) {
    return _ridesHistoryRepo.getRideHistory(
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
      cancelToken: cancelToken,
    );
  }
}
