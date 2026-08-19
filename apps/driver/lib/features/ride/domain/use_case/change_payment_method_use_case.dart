import 'package:dio/dio.dart';
import 'package:driver/features/ride/data/models/change_payment/change_payment_arg.dart';
import 'package:driver/features/ride/domain/repos/ride_repo.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';

class ChangePaymentMethodUseCase
    extends CancellableUseCase<ApiResults<void>, ChangePaymentArg> {
  final BaseRideRepo _baseRideRepo;

  ChangePaymentMethodUseCase(this._baseRideRepo);

  @override
  Future<ApiResults<void>> execute(
    ChangePaymentArg params,
    CancelToken cancelToken,
  ) {
    return _baseRideRepo.changePaymentMethod(params);
  }
}
