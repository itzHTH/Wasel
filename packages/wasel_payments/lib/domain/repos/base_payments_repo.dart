import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_payments/data/models/tokenize_card/request/tokenize_card_request.dart';
import 'package:wasel_payments/domain/entities/wallet_balance.dart';

abstract class BasePaymentsRepo {
  Future<ApiResults<String?>> tokenizeCard(
    TokenizeCardRequest request, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<WalletBalance>> getRiderWalletBalance({
    CancelToken? cancelToken,
  });
}
