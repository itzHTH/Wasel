import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wasel_core/const/app_constants.dart';
import 'package:wasel_core/helpers/session_store.dart';
import 'package:wasel_core/networking/api_constants.dart';

/// Attaches the stored access token, and on a 401 refreshes the session and
/// replays the request. When the session cannot be refreshed it is cleared and
/// onSessionExpired fires.
class AuthInterceptor extends Interceptor {
  /// plainDio exists for tests; production uses the internal client.
  AuthInterceptor({Dio? plainDio}) : _plainDio = plainDio ?? _buildPlainDio();

  /// Registered once per app at startup — this package knows no routes.
  static void Function()? onSessionExpired;

  static const String _authorizationHeader = 'Authorization';
  static const String _bearerPrefix = 'Bearer ';

  static const String _epochKey = 'authEpoch';

  static const String _tokenField = 'token';
  static const String _refreshTokenField = 'refreshToken';
  static const String _refreshTokenExpirationField = 'refreshTokenExpiration';

  /// Carries no AuthInterceptor, so a 401 here cannot re-enter this one.
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

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SessionStore.readToken();
    if (token != null) {
      options.headers[_authorizationHeader] = '$_bearerPrefix$token';
      _isLoggingOut = false;
    }
    options.extra[_epochKey] = SessionStore.epoch;
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) return handler.next(err);

    // Retrying a revoke would send an already-rotated refresh token, leaving
    // the newly issued one live on the server.
    if (err.requestOptions.path.contains(ApiConstants.revokeToken)) {
      return handler.next(err);
    }

    // The session was cleared while this request was in flight, so it belongs
    // to a sign-in that no longer exists and must not be replayed.
    if (err.requestOptions.extra[_epochKey] != SessionStore.epoch) {
      return handler.next(err);
    }

    final storedToken = await SessionStore.readToken();
    final storedRefreshToken = await SessionStore.readRefreshToken();

    if (storedToken == null && storedRefreshToken == null) {
      // to prevent double Navigation
      return handler.next(err);
    }

    String? token;
    try {
      // A concurrent request already rotated the session, so this 401 is stale
      // and replaying beats burning the fresh refresh token.
      final attempted = _bearerOf(err.requestOptions);
      final rotated =
          storedToken != null && attempted != null && attempted != storedToken;

      token = rotated ? storedToken : await _refresh();
    } catch (_) {
      token = null;
    }

    if (token == null) {
      await _forceLogout();
      return handler.next(err);
    }

    // The session is healthy from here, so a failing replay is the endpoint's
    // problem and must not tear it down.
    try {
      final replayed = await _replay(err.requestOptions, token);
      return replayed == null ? handler.next(err) : handler.resolve(replayed);
    } on DioException catch (e) {
      return handler.next(e);
    } catch (_) {
      return handler.next(err);
    }
  }

  /// Returns the token in the Authorization header, or null if not present.
  String? _bearerOf(RequestOptions options) {
    final header = options.headers[_authorizationHeader];
    if (header is! String || !header.startsWith(_bearerPrefix)) return null;
    return header.substring(_bearerPrefix.length);
  }

  /// Replays the request with the new token.
  Future<Response<dynamic>?> _replay(
    RequestOptions options,
    String token,
  ) async {
    // A body already streamed to the socket cannot be resent; only FormData
    // can be rebuilt, so anything else stream-backed is left alone.
    var body = options.data;
    if (body is Stream) return null;
    if (body is FormData) {
      try {
        body = body.clone();
      } catch (_) {
        return null;
      }
    }

    return _plainDio.fetch(
      options.copyWith(
        headers: {
          ...options.headers,
          _authorizationHeader: '$_bearerPrefix$token',
        },
        data: body,
      ),
    );
  }

  /// Concurrent 401s share one in-flight refresh.
  Future<String?> _refresh() => _refreshFuture ??= _performRefresh()
      .whenComplete(() => _refreshFuture = null);

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

  /// Clears the session and fires onSessionExpired.
  Future<void> _forceLogout() async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;
    await SessionStore.clear();
    onSessionExpired?.call();
  }
}
