import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_payments/data/models/tokenize_card/request/tokenize_card_request.dart';
import 'package:wasel_payments/domain/repos/base_payments_repo.dart';

class TokenizeCardUseCase
    extends CancellableUseCase<ApiResults<String?>, TokenizeCardRequest> {
  final BasePaymentsRepo _paymentsRepo;

  TokenizeCardUseCase(this._paymentsRepo);

  @override
  Future<ApiResults<String?>> execute(
    TokenizeCardRequest params,
    CancelToken cancelToken,
  ) {
    return _paymentsRepo.tokenizeCard(params, cancelToken: cancelToken);
  }
}
