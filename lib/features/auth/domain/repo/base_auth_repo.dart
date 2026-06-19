import 'package:dio/dio.dart';
import 'package:wasal/core/networking/api_results.dart';
import 'package:wasal/features/auth/data/models/register/complete_registration/request/complete_registration_request.dart';
import 'package:wasal/features/auth/data/models/register/complete_registration/response/complete_registration_response.dart';
import 'package:wasal/features/auth/data/models/register/initiate_registeration/request/initiate_registeration_request.dart';
import 'package:wasal/features/auth/data/models/register/initiate_registeration/response/initiate_registeration_response.dart';
import 'package:wasal/features/auth/data/models/login/request/login_request.dart';
import 'package:wasal/features/auth/data/models/login/response/login_response.dart';
import 'package:wasal/features/auth/data/models/register/verify_otp/request/verify_otp_request.dart';
import 'package:wasal/features/auth/data/models/register/verify_otp/response/verify_otp_respons.dart';

abstract class BaseAuthRepo {
  Future<ApiResults<LoginResponse>> login(
    LoginRequest loginRequest, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<InitiateRegisterationResponse>> initiateRegistration(
    InitiateRegisterationRequest request, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<VerifyOtpResponse>> verifyOtp(
    VerifyOtpRequest request, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<CompleteRegistrationResponse>> completeRegistration(
    CompleteRegistrationRequest request, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<void>> logout(
    String refreshToken, {
    CancelToken? cancelToken,
  });
}
