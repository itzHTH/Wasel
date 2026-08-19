// ignore: depend_on_referenced_packages
import 'package:logging/logging.dart';
import 'package:signalr_netcore/errors.dart';
import 'package:signalr_netcore/ihub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:wasel_core/networking/session_refresher.dart';

/// The hub's answer to `AuthInterceptor`: negotiation carries the same bearer
/// as every REST call, so a 401 here refreshes the session and replays.
class RefreshingSignalRHttpClient extends SignalRHttpClient {
  RefreshingSignalRHttpClient({
    Logger? logger,
    SessionRefresher? refresher,
    SignalRHttpClient? inner,
  }) : _inner = inner ?? WebSupportingHttpClient(logger),
       _refresher = refresher ?? SessionRefresher.instance;

  /// Every verb funnels through `send`, so wrapping it covers negotiation and
  /// the long-polling/SSE sends alike.
  final SignalRHttpClient _inner;
  final SessionRefresher _refresher;

  @override
  Future<SignalRHttpResponse> send(SignalRHttpRequest request) async {
    try {
      return await _inner.send(request);
    } on HttpError catch (e) {
      if (e.statusCode != 401) rethrow;

      // A refresh that throws is a transport failure, not a rejected session;
      // reconnects run on flaky links, so let the retry loop have another go
      // rather than signing the user out.
      final token = await _refresher.refresh();

      if (token == null) {
        await _refresher.forceLogout();
        rethrow;
      }

      final headers = request.headers ??= MessageHeaders();
      headers.setHeaderValue(
        MessageHeaders.AuthorizationHeaderName,
        'Bearer $token',
      );

      // One replay, never a loop: a second 401 is the retry policy's problem.
      return _inner.send(request);
    }
  }
}
