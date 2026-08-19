import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wasel_core/const/app_constants.dart';
import 'package:wasel_core/helpers/session_store.dart';
import 'package:wasel_core/networking/api_constants.dart';
import 'package:wasel_core/networking/session_refresher.dart';

/// Attaches the stored access token, and on a 401 refreshes the session and
/// replays the request. When the session cannot be refreshed it is cleared and
/// onSessionExpired fires.
///
/// The refresh itself lives in SessionRefresher, shared with the SignalR hub
/// so both meet a 401 through one in-flight refresh.
class AuthInterceptor extends Interceptor {
  /// plainDio exists for tests; production uses the internal client.
  AuthInterceptor({Dio? plainDio, SessionRefresher? refresher})
    : _plainDio = plainDio ?? _buildPlainDio(),
      _refresher = refresher ?? SessionRefresher.instance;

  /// Registered once per app at startup — this package knows no routes.
  /// Forwards to SessionRefresher so a hub-triggered logout reaches the same
  /// handler the apps already register here.
  static void Function()? get onSessionExpired =>
      SessionRefresher.onSessionExpired;

  static set onSessionExpired(void Function()? callback) =>
      SessionRefresher.onSessionExpired = callback;

  static const String _authorizationHeader = 'Authorization';
  static const String _bearerPrefix = 'Bearer ';

  static const String _epochKey = 'authEpoch';

  /// Carries no AuthInterceptor, so a 401 here cannot re-enter this one.
  final Dio _plainDio;

  final SessionRefresher _refresher;

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
      _refresher.armLogout();
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

      token = rotated ? storedToken : await _refresher.refresh();
    } catch (_) {
      token = null;
    }

    if (token == null) {
      await _refresher.forceLogout();
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
}
