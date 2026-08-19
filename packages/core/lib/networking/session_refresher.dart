import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wasel_core/const/app_constants.dart';
import 'package:wasel_core/helpers/session_store.dart';
import 'package:wasel_core/networking/api_constants.dart';

/// Trades the stored refresh token for a new session, and clears the session
/// when it cannot.
class SessionRefresher {
  SessionRefresher({Dio? plainDio}) : _plainDio = plainDio ?? _buildPlainDio();

  static final SessionRefresher instance = SessionRefresher();

  /// Registered once per app at startup — this package knows no routes.
  static void Function()? onSessionExpired;

  static const String _tokenField = 'token';
  static const String _refreshTokenField = 'refreshToken';
  static const String _refreshTokenExpirationField = 'refreshTokenExpiration';

  /// Carries no AuthInterceptor, so a 401 here cannot re-enter one.
  /// Bodies stay unlogged because the refresh call trades live tokens.
  final Dio _plainDio;

  Future<String?>? _refreshFuture;

  bool _isLoggingOut = false;

  static Dio _buildPlainDio() =>
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
            requestBody: false,
            responseBody: false,
            error: true,
            compact: true,
          ),
        );

  /// Concurrent 401s share one in-flight refresh.
  Future<String?> refresh() => _refreshFuture ??= _performRefresh()
      .whenComplete(() => _refreshFuture = null);

  /// Re-arms [forceLogout] so a later sign-in can expire the way this one did.
  void armLogout() => _isLoggingOut = false;

  /// Clears the session and fires [onSessionExpired].
  Future<void> forceLogout() async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;
    await SessionStore.clear();
    onSessionExpired?.call();
  }

  /// Refreshes the token and returns the new one.
  Future<String?> _performRefresh() async {
    final refreshToken = await SessionStore.readRefreshToken();
    if (refreshToken == null) return null;

    final response = await _plainDio.post(
      ApiConstants.refreshToken,
      data: {'token': refreshToken},
    );
    if (response.statusCode != 200) return null;

    final payload = response.data;
    final data = payload is Map ? payload['data'] : null;
    if (data is! Map) return null;

    final token = _nonEmpty(data[_tokenField]);
    final newRefreshToken = _nonEmpty(data[_refreshTokenField]);
    if (token == null || newRefreshToken == null) return null;

    final expiration = _nonEmpty(data[_refreshTokenExpirationField]);

    await SessionStore.save(
      token: token,
      refreshToken: newRefreshToken,
      refreshTokenExpiration: expiration == null
          ? null
          : DateTime.tryParse(expiration),
    );

    return token;
  }

  /// Returns the first non-empty string, or null if none.
  static String? _nonEmpty(Object? value) =>
      value is String && value.isNotEmpty ? value : null;
}
