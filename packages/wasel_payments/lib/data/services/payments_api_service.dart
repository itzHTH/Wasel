import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wasel_payments/core/const/payments_api_const.dart';
import 'package:wasel_payments/data/models/tokenize_card/request/tokenize_card_request.dart';
import 'package:wasel_payments/data/models/tokenize_card/response/tokenize_card_response.dart';
import 'package:wasel_payments/data/models/wallet_balance/response/wallet_balance_response.dart';

part 'payments_api_service.g.dart';

@RestApi()
abstract class PaymentsApiService {
  factory PaymentsApiService(Dio dio, {String? baseUrl}) =>
      _PaymentsApiService(dio, baseUrl: baseUrl);

  @POST(PaymentsApiConst.tokenize)
  Future<TokenizeCardResponse> tokenizeCard(
    @Body() TokenizeCardRequest request, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET(PaymentsApiConst.riderWalletBalance)
  Future<WalletBalanceResponse> getRiderWalletBalance({
    @CancelRequest() CancelToken? cancelToken,
  });
}
