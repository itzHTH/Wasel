import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_payments/data/models/tokenize_card/request/tokenize_card_request.dart';
import 'package:wasel_payments/data/services/payments_api_service.dart';
import 'package:wasel_payments/domain/entities/wallet_balance.dart';
import 'package:wasel_payments/domain/repos/base_payments_repo.dart';

class PaymentsRepo implements BasePaymentsRepo {
  final PaymentsApiService _paymentsApiService;

  PaymentsRepo(this._paymentsApiService);

  @override
  Future<ApiResults<String?>> tokenizeCard(
    TokenizeCardRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _paymentsApiService.tokenizeCard(
        request,
        cancelToken: cancelToken,
      );

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<WalletBalance>> getRiderWalletBalance({
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _paymentsApiService.getRiderWalletBalance(
        cancelToken: cancelToken,
      );

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }
}
