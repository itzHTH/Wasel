import 'package:dio/dio.dart';
import 'package:wasal/core/const/app_constants.dart';
import 'package:wasal/core/helpers/app_local_cache.dart';
import 'package:wasal/core/networking/api_results.dart';
import 'package:wasal/core/networking/errors/error_handler.dart';
import 'package:wasal/features/auth/data/models/login/request/login_request.dart';
import 'package:wasal/features/auth/data/models/login/response/login_response.dart';
import 'package:wasal/features/auth/data/services/auth_api_service.dart';
import 'package:wasal/features/auth/domain/repo/base_auth_repo.dart';

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
}
