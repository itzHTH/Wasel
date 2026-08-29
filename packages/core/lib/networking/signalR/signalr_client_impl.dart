import 'dart:async';

import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:wasel_core/helpers/session_store.dart';
import 'package:wasel_core/networking/api_constants.dart';
import 'package:wasel_core/networking/signalR/i_signalr_client.dart';
import 'package:wasel_core/networking/signalR/refreshing_signalr_http_client.dart';

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

  static const _connectionWait = Duration(seconds: 8);

  static const _stopWait = Duration(seconds: 3);

  HubConnection? _hubConnection;

  final _handlers = <String, void Function(List<Object?>? args)>{};

  final _reconnectedCallbacks = <void Function()>[];

  final _statusController = StreamController<SignalRStatus>.broadcast();

  SignalRStatus _status = SignalRStatus.disconnected;

  int _generation = 0;

  void _setStatus(SignalRStatus s) {
    _status = s;
    _statusController.add(s);
  }

  void _setStatusFor(int generation, SignalRStatus s) {
    if (generation != _generation) return;
    _setStatus(s);
  }

  @override
  SignalRStatus get status => _status;

  @override
  Stream<SignalRStatus> get statusStream => _statusController.stream;

  @override
  Future<void> connect() async {
    if (_hubConnection != null) return;
    final generation = _generation;
    final logger = _debugSignalrLogger();
    final builder = HubConnectionBuilder().withUrl(
      _hubUrl,
      options: HttpConnectionOptions(
        accessTokenFactory: () async => await SessionStore.readToken() ?? '',
        httpClient: RefreshingSignalRHttpClient(logger: logger),
        requestTimeout: 15 * 1000, // 15s
        logger: logger,
      ),
    );

    if (logger != null) builder.configureLogging(logger);

    final connection = builder
        .withAutomaticReconnect(retryDelays: [0, 2000, 10000, 30000])
        .build();

    // Left at the library defaults (30s / 15s) these are tight for a phone
    // whose radio is dozing; a missed ping reads as a dead server.
    connection.serverTimeoutInMilliseconds = 60 * 1000;
    connection.keepAliveIntervalInMilliseconds = 20 * 1000;

    _hubConnection = connection;

    connection
      ..onreconnecting(
        ({error}) => _setStatusFor(generation, SignalRStatus.reconnecting),
      )
      ..onreconnected(
        ({connectionId}) => _setStatusFor(generation, SignalRStatus.connected),
      )
      ..onclose(({error}) {
        if (generation != _generation) return;

        _hubConnection = null;
        _setStatus(SignalRStatus.disconnected);
      });

    _handlers.forEach(connection.on);

    for (final callback in _reconnectedCallbacks) {
      connection.onreconnected(
        ({connectionId}) => _runReconnected(generation, callback),
      );
    }

    _setStatus(SignalRStatus.connecting);

    try {
      await connection.start();
    } catch (_) {
      if (generation == _generation) {
        _hubConnection = null;
        _setStatus(SignalRStatus.disconnected);
      }
      rethrow;
    }

    if (generation != _generation) {
      await connection.stop();
      return;
    }

    debugPrint('🔌 hub connected (state=${connection.state})');

    _setStatus(SignalRStatus.connected);
  }

  @override
  Future<void> disconnect() async {
    final connection = _hubConnection;

    if (connection == null) return;

    _generation++;
    _hubConnection = null;
    _setStatus(SignalRStatus.disconnected);

    try {
      await connection.stop().timeout(_stopWait);
    } catch (_) {
      // Nothing to salvage — this connection is already out of circulation.
    }
  }

  @override
  void on(String methodName, void Function(List<Object?>? args) handler) {
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
    _reconnectedCallbacks.add(callback);
    final generation = _generation;
    _hubConnection?.onreconnected(
      ({connectionId}) => _runReconnected(generation, callback),
    );
  }

  void _runReconnected(int generation, void Function() callback) {
    if (generation != _generation) return;
    callback();
  }
}

@riverpod
ISignalRClient signalRClient(Ref ref) {
  return SignalrClientImpl(ApiConstants.hubUrl);
}
