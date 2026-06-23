import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wasel_core/const/app_constants.dart';
import 'package:wasel_core/helpers/app_local_cache.dart';
import 'package:wasel_core/networking/api_constants.dart';

/// Injects the stored access token into every outgoing request and, on a 401,
/// transparently refreshes the session and replays the original request.
///
/// If the refresh fails (expired/invalid refresh token), the stored session is
/// cleared and [onSessionExpired] is invoked so the host app can route the user
/// back to its auth screen.
class AuthInterceptor extends Interceptor {
  /// Called once when the session can no longer be refreshed (forced logout).
  ///
  /// This package is app-agnostic: it does not know about any app's routes or
  /// navigator. Each host app registers its own handler at startup, e.g.
  /// `AuthInterceptor.onSessionExpired = () =>
  ///     AppNavigation.pushReplacementNamed(AppRoutes.auth);`
  static void Function()? onSessionExpired;

  /// Plain Dio used ONLY for the refresh call and for replaying the original
  /// request. It has no [AuthInterceptor], so a 401 here can never re-enter
  /// this interceptor and cause an infinite loop.
  final Dio _plainDio =
      Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        )
        ..interceptors.add(
          PrettyDioLogger(
            enabled: AppConstants.isDebug,
            requestBody: true,
            responseBody: true,
            error: true,
            compact: true,
          ),
        );

  /// Single-flight guard: while a refresh is in progress, all concurrent 401s
  /// await this same future instead of each firing their own refresh (which,
  /// with refresh-token rotation, would invalidate each other).
  Future<String?>? _refreshFuture;

  /// Prevents multiple redirects to the auth screen when several requests fail
  /// at once.
  bool _isLoggingOut = false;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await AppLocalCache.getSecuredString(AppConstants.tokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Only handle 401s. The refresh call runs on [_plainDio] (no
    // AuthInterceptor), so a failed refresh never re-enters here as a 401 —
    // it throws a DioException that is caught by the try/catch below and
    // turned into a forced logout. Hence no need to special-case the refresh
    // path here.
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    try {
      final newAccessToken = await _refreshSession();

      // Refresh failed (no/invalid refresh token) → force logout.
      if (newAccessToken == null) {
        await _forceLogout();
        return handler.next(err);
      }

      // Replay the original request with the new access token.
      final opts = err.requestOptions;
      opts.headers['Authorization'] = 'Bearer $newAccessToken';
      final retried = await _plainDio.fetch(opts);
      return handler.resolve(retried);
    } catch (_) {
      // Refresh threw (e.g. backend returned 401/400 for an expired refresh
      // token) → force logout.
      await _forceLogout();
      return handler.next(err);
    }
  }

  /// Returns the new access token, or `null` if refresh is not possible.
  /// Concurrent callers share the same in-flight future.
  Future<String?> _refreshSession() {
    // a ??= b means: if a is null, set a = b; otherwise leave a alone
    _refreshFuture ??= _performRefresh().whenComplete(
      () => _refreshFuture = null, // reset for next time
    );
    return _refreshFuture!;
  }

  Future<String?> _performRefresh() async {
    final refreshToken = await AppLocalCache.getSecuredString(
      AppConstants.refreshTokenKey,
    );
    if (refreshToken == null || refreshToken.isEmpty) return null;

    final response = await _plainDio.post(
      ApiConstants.refreshToken,
      data: {'token': refreshToken},
    );

    if (response.statusCode == 200) {
      final data = response.data['data'] as Map<String, dynamic>;
      final newAccessToken = data[AppConstants.tokenKey] as String;
      final newRefreshToken = data[AppConstants.refreshTokenKey] as String;

      await AppLocalCache.setSecuredString(
        AppConstants.tokenKey,
        newAccessToken,
      );
      await AppLocalCache.setSecuredString(
        AppConstants.refreshTokenKey,
        newRefreshToken,
      );
      return newAccessToken;
    }
    return null;
  }

  Future<void> _forceLogout() async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;
    await AppLocalCache.clearAllSecuredData();
    onSessionExpired?.call();
  }
}
