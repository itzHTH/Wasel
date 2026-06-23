import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_constants.dart';
import 'package:wasel_core/networking/dio_factory.dart';
import 'package:wasal/features/auth/data/models/logout/request/logout_request.dart';
import 'package:wasal/features/auth/data/models/logout/response/logout_response.dart';
import 'package:wasal/features/auth/data/models/register/complete_registration/request/complete_registration_request.dart';
import 'package:wasal/features/auth/data/models/register/complete_registration/response/complete_registration_response.dart';
import 'package:wasal/features/auth/data/models/register/initiate_registeration/request/initiate_registeration_request.dart';
import 'package:wasal/features/auth/data/models/register/initiate_registeration/response/initiate_registeration_response.dart';
import 'package:wasal/features/auth/data/models/login/request/login_request.dart';
import 'package:wasal/features/auth/data/models/login/response/login_response.dart';
import 'package:wasal/features/auth/data/models/register/verify_otp/request/verify_otp_request.dart';
import 'package:wasal/features/auth/data/models/register/verify_otp/response/verify_otp_respons.dart';

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

  @POST(ApiConstants.verifyOtp)
  Future<VerifyOtpResponse> verifyOtp(
    @Body() VerifyOtpRequest request, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(ApiConstants.completeRegistration)
  Future<CompleteRegistrationResponse> completeRegistration(
    @Body() CompleteRegistrationRequest request, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(ApiConstants.revokeToken)
  Future<LogoutResponse> logout(
    @Body() LogoutRequest request, {
    @CancelRequest() CancelToken? cancelToken,
  });
}

@riverpod
AuthApiService authApiService(Ref ref) {
  final dio = ref.watch(dioFactoryProvider);
  return AuthApiService(dio, baseUrl: ApiConstants.baseUrl);
}
