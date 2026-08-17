import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_auth/data/models/register/complete_registration/request/complete_registration_request.dart';
import 'package:wasel_auth/data/models/register/initiate_registeration/request/initiate_registeration_request.dart';
import 'package:wasel_auth/data/models/login/request/login_request.dart';
import 'package:wasel_auth/data/models/register/verify_otp/request/verify_otp_request.dart';
import 'package:wasel_auth/data/models/reset_password/forgot_password/request/forgot_password_request.dart';
import 'package:wasel_auth/data/models/reset_password/set_new_password/request/reset_password_request.dart';
import 'package:wasel_auth/data/models/reset_password/verify_reset_otp/request/verify_reset_otp_request.dart';
import 'package:wasel_auth/domain/entities/login.dart';
import 'package:wasel_auth/domain/entities/initiate_registeration.dart';
import 'package:wasel_auth/domain/entities/verify_otp.dart';
import 'package:wasel_auth/domain/entities/complete_registration.dart';
import 'package:wasel_auth/domain/entities/forgot_password.dart';
import 'package:wasel_auth/domain/entities/logout.dart';
import 'package:wasel_auth/domain/entities/reset_password.dart';
import 'package:wasel_auth/domain/entities/verify_reset_otp.dart';

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

  Future<ApiResults<ForgotPassword>> forgotPassword(
    ForgotPasswordRequest request, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<VerifyResetOtp>> verifyResetOtp(
    VerifyResetOtpRequest request, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<ResetPassword>> resetPassword(
    ResetPasswordRequest request, {
    CancelToken? cancelToken,
  });
}
