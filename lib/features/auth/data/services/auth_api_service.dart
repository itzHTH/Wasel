import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wasal/core/networking/api_constants.dart';
import 'package:wasal/features/auth/data/models/initiate_registeration/request/initiate_registeration_request.dart';
import 'package:wasal/features/auth/data/models/initiate_registeration/response/initiate_registeration_response.dart';
import 'package:wasal/features/auth/data/models/login/request/login_request.dart';
import 'package:wasal/features/auth/data/models/login/response/login_response.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String? baseUrl}) =>
      _AuthApiService(dio, baseUrl: baseUrl);

  @POST(ApiConstants.login)
  Future<LoginResponse> login(
    @Body() LoginRequest loginRequest, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(ApiConstants.initiateRegistration)
  Future<InitiateRegisterationResponse> initiateRegistration(
    @Body() InitiateRegisterationRequest request, {
    @CancelRequest() CancelToken? cancelToken,
  });
}
