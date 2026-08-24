import 'package:dio/dio.dart';
import 'package:driver/features/ride/domain/repo/base_ride_repo.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';

class AcceptRideUseCase extends CancellableUseCase<ApiResults<void>, String> {
  final BaseRideRepo _baseRideRepo;

  AcceptRideUseCase(this._baseRideRepo);

  @override
  Future<ApiResults<void>> execute(String params, CancelToken cancelToken) {
    return _baseRideRepo.acceptRide(params);
  }
}
