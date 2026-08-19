import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_payments/domain/entities/wallet_balance.dart';
import 'package:wasel_payments/domain/repos/base_payments_repo.dart';

class GetRiderWalletBalanceUseCase
    extends CancellableUseCase<ApiResults<WalletBalance>, void> {
  final BasePaymentsRepo _paymentsRepo;

  GetRiderWalletBalanceUseCase(this._paymentsRepo);

  @override
  Future<ApiResults<WalletBalance>> execute(
    void params,
    CancelToken cancelToken,
  ) {
    return _paymentsRepo.getRiderWalletBalance(cancelToken: cancelToken);
  }
}
