import 'dart:async';

import 'package:flutter/foundation.dart';
// logging is a transitive dep of signalr_netcore; adding it to pubspec forces a
// full workspace re-resolve that hits an unrelated test/web_socket_channel
// version conflict, so we rely on the transitive resolution here.
// ignore: depend_on_referenced_packages
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:wasel_core/networking/api_constants.dart';
import 'package:wasel_core/networking/signalR/i_signalr_client.dart';

part 'signalr_client_impl.g.dart';

bool _signalrLogWired = false;
Logger? _debugSignalrLogger() {
  if (!kDebugMode) return null;
  if (!_signalrLogWired) {
    _signalrLogWired = true;
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((r) {
      debugPrint('🪵 SIGNALR ${r.level.name}: ${r.message}');
    });
  }
  return Logger('SignalR');
}

class SignalrClientImpl implements ISignalRClient {
  SignalrClientImpl(this._hubUrl);
  final String _hubUrl;

  /// How long an invoke waits for the hub to settle before giving up. Kept
  /// under the callers' retry cadence so pending invokes cannot stack up.
  static const _connectionWait = Duration(seconds: 8);

  HubConnection? _hubConnection;
  // Handlers registered via [on] before [connect] builds the HubConnection.
  // Without this, `on()` would call `null?.on(...)` .
  final _handlers = <String, void Function(List<Object?>? args)>{};
  final _statusController = StreamController<SignalRStatus>.broadcast();
  SignalRStatus _status = SignalRStatus.disconnected;

  void _setStatus(SignalRStatus s) {
    _status = s;
    _statusController.add(s);
  }

  @override
  SignalRStatus get status => _status;

  @override
  Stream<SignalRStatus> get statusStream => _statusController.stream;

  @override
  Future<void> connect({required String jwt}) async {
    if (_hubConnection != null) return;
    final logger = _debugSignalrLogger();
    final builder = HubConnectionBuilder().withUrl(
      _hubUrl,
      options: HttpConnectionOptions(
        accessTokenFactory: () async => jwt,
        requestTimeout: 15 * 1000, // 15s
        logger: logger,
      ),
    );
    if (logger != null) builder.configureLogging(logger);
    _hubConnection = builder
        .withAutomaticReconnect(retryDelays: [0, 2000, 5000, 10000])
        .build();

    _hubConnection!
      ..onreconnecting(({error}) => _setStatus(SignalRStatus.reconnecting))
      ..onreconnected(({connectionId}) => _setStatus(SignalRStatus.connected))
      ..onclose(({error}) => _setStatus(SignalRStatus.disconnected));

    // Attach handlers registered before the connection object existed, BEFORE
    // start() so no early server push is missed.
    _handlers.forEach(_hubConnection!.on);

    _setStatus(SignalRStatus.connecting);

    try {
      await _hubConnection!.start();
    } catch (_) {
      // Release the connection so the client stays reusable. Without this a
      // failed handshake wedges it at `connecting` forever: the guard at the
      // top of this method turns every later connect() into a no-op, and every
      // invoke then waits out its timeout against a hub that will never come up.
      _hubConnection = null;
      _setStatus(SignalRStatus.disconnected);
      rethrow;
    }

    _setStatus(SignalRStatus.connected);
  }

  @override
  Future<void> disconnect() async {
    _hubConnection?.stop();
    _hubConnection = null;
    _setStatus(SignalRStatus.disconnected);
  }

  @override
  void on(String methodName, void Function(List<Object?>? args) handler) {
    // Remember it so connect() can (re)attach it, and attach now if the
    // connection already exists (registration after connect still works).
    _handlers[methodName] = handler;
    _hubConnection?.on(methodName, handler);
  }

  @override
  void off(String methodName) {
    _handlers.remove(methodName);
    _hubConnection?.off(methodName);
  }

  @override
  Future<Object?> invoke(
    String methodName, {
    List<Object>? args = const [],
  }) async {
    final connection = await _whenConnected();
    return connection.invoke(methodName, args: args);
  }

  Future<HubConnection> _whenConnected() async {
    if (_status != SignalRStatus.connected) {
      // Driven by an explicit subscription rather than firstWhere().timeout():
      // a timeout on the future leaves the underlying stream listener attached,
      // so every invoke that gave up would leak one onto the status controller.
      final connected = Completer<void>();
      final subscription = _statusController.stream.listen((status) {
        if (status == SignalRStatus.connected && !connected.isCompleted) {
          connected.complete();
        }
      });

      try {
        await connected.future.timeout(_connectionWait);
      } finally {
        await subscription.cancel();
      }
    }

    final connection = _hubConnection;
    if (connection == null) {
      throw StateError('SignalR hub connection is unavailable');
    }

    return connection;
  }

  @override
  void onReconnected(void Function() callback) {
    _hubConnection?.onreconnected(({connectionId}) => callback());
  }
}

@riverpod
ISignalRClient signalRClient(Ref ref) {
  return SignalrClientImpl(ApiConstants.hubUrl);
}
