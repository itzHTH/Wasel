import 'package:dio/dio.dart';
import 'package:wasal/core/networking/api_results.dart';
import 'package:wasal/features/auth/data/models/register/complete_registration/request/complete_registration_request.dart';
import 'package:wasal/features/auth/data/models/register/initiate_registeration/request/initiate_registeration_request.dart';
import 'package:wasal/features/auth/data/models/login/request/login_request.dart';
import 'package:wasal/features/auth/data/models/register/verify_otp/request/verify_otp_request.dart';
import 'package:wasal/features/auth/domain/entities/login.dart';
import 'package:wasal/features/auth/domain/entities/initiate_registeration.dart';
import 'package:wasal/features/auth/domain/entities/verify_otp.dart';
import 'package:wasal/features/auth/domain/entities/complete_registration.dart';
import 'package:wasal/features/auth/domain/entities/logout.dart';

abstract class BaseAuthRepo {
  Future<ApiResults<Login>> login(
    LoginRequest loginRequest, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<InitiateRegisteration>> initiateRegistration(
    InitiateRegisterationRequest request, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<VerifyOtp>> verifyOtp(
    VerifyOtpRequest request, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<CompleteRegistration>> completeRegistration(
    CompleteRegistrationRequest request, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<Logout>> logout({CancelToken? cancelToken});
}
