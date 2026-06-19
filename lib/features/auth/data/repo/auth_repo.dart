import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/core/const/app_constants.dart';
import 'package:wasal/core/helpers/app_local_cache.dart';
import 'package:wasal/core/networking/api_results.dart';
import 'package:wasal/core/networking/errors/error_handler.dart';
import 'package:wasal/features/auth/data/models/register/complete_registration/request/complete_registration_request.dart';
import 'package:wasal/features/auth/data/models/register/complete_registration/response/complete_registration_response.dart';
import 'package:wasal/features/auth/data/models/register/initiate_registeration/request/initiate_registeration_request.dart';
import 'package:wasal/features/auth/data/models/register/initiate_registeration/response/initiate_registeration_response.dart';
import 'package:wasal/features/auth/data/models/login/request/login_request.dart';
import 'package:wasal/features/auth/data/models/login/response/login_response.dart';
import 'package:wasal/features/auth/data/models/register/verify_otp/request/verify_otp_request.dart';
import 'package:wasal/features/auth/data/models/register/verify_otp/response/verify_otp_respons.dart';
import 'package:wasal/features/auth/data/services/auth_api_service.dart';
import 'package:wasal/features/auth/domain/repo/base_auth_repo.dart';

part 'auth_repo.g.dart';

class AuthRepo implements BaseAuthRepo {
  final AuthApiService _authApiService;

  AuthRepo(this._authApiService);

  @override
  Future<ApiResults<LoginResponse>> login(
    LoginRequest loginRequest, {
    CancelToken? cancelToken,
  }) async {
    try {
      final LoginResponse response = await _authApiService.login(
        LoginRequest(
          email: loginRequest.email,
          password: loginRequest.password,
        ),
        cancelToken: cancelToken,
      );

      // Store the token and refresh token securely in local cache
      AppLocalCache.setSecuredString(AppConstants.tokenKey, response.token);
      AppLocalCache.setSecuredString(
        AppConstants.refreshTokenKey,
        response.refreshToken,
      );

      return ApiResults.success(response);
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<InitiateRegisterationResponse>> initiateRegistration(
    InitiateRegisterationRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final InitiateRegisterationResponse response = await _authApiService
          .initiateRegistration(request, cancelToken: cancelToken);

      return ApiResults.success(response);
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<VerifyOtpResponse>> verifyOtp(
    VerifyOtpRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final VerifyOtpResponse response = await _authApiService.verifyOtp(
        request,
        cancelToken: cancelToken,
      );

      return ApiResults.success(response);
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<CompleteRegistrationResponse>> completeRegistration(
    CompleteRegistrationRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final CompleteRegistrationResponse response = await _authApiService
          .completeRegistration(request, cancelToken: cancelToken);

      // Store the token and refresh token securely in local cache
      AppLocalCache.setSecuredString(AppConstants.tokenKey, response.token);
      AppLocalCache.setSecuredString(
        AppConstants.refreshTokenKey,
        response.refreshToken,
      );

      return ApiResults.success(response);
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }
}

@riverpod
AuthRepo authRepo(Ref ref) {
  final authApiService = ref.watch(authApiServiceProvider);
  return AuthRepo(authApiService);
}
