import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/helpers/session_store.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_auth/data/models/logout/request/logout_request.dart';
import 'package:wasel_auth/data/models/register/complete_registration/request/complete_registration_request.dart';
import 'package:wasel_auth/data/models/register/complete_registration/response/complete_registration_response.dart';
import 'package:wasel_auth/data/models/register/initiate_registeration/request/initiate_registeration_request.dart';
import 'package:wasel_auth/data/models/register/initiate_registeration/response/initiate_registeration_response.dart';
import 'package:wasel_auth/data/models/login/request/login_request.dart';
import 'package:wasel_auth/data/models/login/response/login_response.dart';
import 'package:wasel_auth/data/models/register/verify_otp/request/verify_otp_request.dart';
import 'package:wasel_auth/data/models/register/verify_otp/response/verify_otp_respons.dart';
import 'package:wasel_auth/data/models/reset_password/forgot_password/request/forgot_password_request.dart';
import 'package:wasel_auth/data/models/reset_password/forgot_password/response/forgot_password_response.dart';
import 'package:wasel_auth/data/models/reset_password/set_new_password/request/reset_password_request.dart';
import 'package:wasel_auth/data/models/reset_password/set_new_password/response/reset_password_response.dart';
import 'package:wasel_auth/data/models/reset_password/verify_reset_otp/request/verify_reset_otp_request.dart';
import 'package:wasel_auth/data/models/reset_password/verify_reset_otp/response/verify_reset_otp_response.dart';
import 'package:wasel_auth/auth_user_type.dart';
import 'package:wasel_auth/data/services/auth_api_service.dart';
import 'package:wasel_auth/domain/entities/complete_registration.dart';
import 'package:wasel_auth/domain/entities/forgot_password.dart';
import 'package:wasel_auth/domain/entities/initiate_registeration.dart';
import 'package:wasel_auth/domain/entities/login.dart';
import 'package:wasel_auth/domain/entities/logout.dart';
import 'package:wasel_auth/domain/entities/reset_password.dart';
import 'package:wasel_auth/domain/entities/verify_otp.dart';
import 'package:wasel_auth/domain/entities/verify_reset_otp.dart';
import 'package:wasel_auth/domain/repo/base_auth_repo.dart';

part 'auth_repo.g.dart';

class AuthRepo implements BaseAuthRepo {
  final AuthApiService _authApiService;

  /// Selects the role-specific registration endpoints (rider vs driver).
  final AuthUserType _userType;

  AuthRepo(this._authApiService, this._userType);

  @override
  Future<ApiResults<Login>> login(
    LoginRequest loginRequest, {
    CancelToken? cancelToken,
  }) async {
    try {
      final LoginResponse response = await _authApiService.login(
        loginRequest,
        cancelToken: cancelToken,
      );

      await SessionStore.save(
        token: response.token,
        refreshToken: response.refreshToken,
        refreshTokenExpiration: response.refreshTokenExpiration,
      );

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<InitiateRegisteration>> initiateRegistration(
    InitiateRegisterationRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final InitiateRegisterationResponse response = await _authApiService
          .initiateRegistration(
            _userType.path,
            request,
            cancelToken: cancelToken,
          );

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<VerifyOtp>> verifyOtp(
    VerifyOtpRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final VerifyOtpResponse response = await _authApiService.verifyOtp(
        _userType.path,
        request,
        cancelToken: cancelToken,
      );

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<CompleteRegistration>> completeRegistration(
    CompleteRegistrationRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final CompleteRegistrationResponse response = await _authApiService
          .completeRegistration(
            _userType.path,
            request,
            cancelToken: cancelToken,
          );

      await SessionStore.save(
        token: response.token,
        refreshToken: response.refreshToken,
        refreshTokenExpiration: response.refreshTokenExpiration,
      );

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<Logout>> logout({CancelToken? cancelToken}) async {
    try {
      final refreshToken = await SessionStore.readRefreshToken() ?? '';
      final response = await _authApiService.logout(
        LogoutRequest(refreshToken: refreshToken),
        cancelToken: cancelToken,
      );

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    } finally {
      // Signing out locally must not depend on the revoke call succeeding.
      await SessionStore.clear();
    }
  }

  @override
  Future<ApiResults<ForgotPassword>> forgotPassword(
    ForgotPasswordRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final ForgotPasswordResponse response = await _authApiService
          .forgotPassword(request, cancelToken: cancelToken);

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<VerifyResetOtp>> verifyResetOtp(
    VerifyResetOtpRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final VerifyResetOtpResponse response = await _authApiService
          .verifyResetOtp(request, cancelToken: cancelToken);

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResults<ResetPassword>> resetPassword(
    ResetPasswordRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final ResetPasswordResponse response = await _authApiService
          .resetPassword(request, cancelToken: cancelToken);

      return ApiResults.success(response.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }
}

@riverpod
AuthRepo authRepo(Ref ref) {
  final authApiService = ref.watch(authApiServiceProvider);
  final userType = ref.watch(authUserTypeProvider);
  return AuthRepo(authApiService, userType);
}
