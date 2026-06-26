import 'package:dio/dio.dart';
import 'package:driver/core/const/driver_api_consts.dart';
import 'package:driver/features/driver_verification/data/models/get_verification_status/response/get_verification_status_response.dart';
import 'package:retrofit/retrofit.dart';

part 'verify_api_service.g.dart';

@RestApi()
abstract class VerifyApiService {
  factory VerifyApiService(Dio dio, {String? baseUrl}) =>
      _VerifyApiService(dio, baseUrl: baseUrl);

  @GET(DriverApiConsts.getVerificationStatus)
  Future<GetVerificationStatusResponse> getVerificationStatus({
    @CancelRequest() CancelToken? cancelToken,
  });
}
