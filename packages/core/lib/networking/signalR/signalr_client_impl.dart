import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:wasel_core/networking/api_constants.dart';
import 'package:wasel_core/networking/signalR/i_signalr_client.dart';

part 'signalr_client_impl.g.dart';

class SignalrClientImpl implements ISignalRClient {
  SignalrClientImpl(this._baseUrl);
  final String? _baseUrl;

  HubConnection? _hubConnection;
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
  Future<void> connect({required String hubPath, required String jwt}) async {
    if (_hubConnection != null) return;

    _hubConnection = HubConnectionBuilder()
        .withUrl(
          '$_baseUrl/$hubPath',
          options: HttpConnectionOptions(accessTokenFactory: () async => jwt),
        )
        .withAutomaticReconnect(retryDelays: [0, 2000, 5000, 10000])
        .build();

    // Set up event handlers for connection lifecycle events
    _hubConnection!
      ..onreconnecting(({error}) => _setStatus(SignalRStatus.reconnecting))
      ..onreconnected(({connectionId}) => _setStatus(SignalRStatus.connected))
      ..onclose(({error}) => _setStatus(SignalRStatus.disconnected));

    _setStatus(SignalRStatus.connecting);
    await _hubConnection!.start();
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
    _hubConnection?.on(methodName, handler);
  }

  @override
  void off(String methodName) {
    _hubConnection?.off(methodName);
  }

  @override
  Future<Object?> invoke(
    String methodName, {
    List<Object>? args = const [],
  }) async {
    return _hubConnection!.invoke(methodName, args: args);
  }

  @override
  void onReconnected(void Function() callback) {
    _hubConnection?.onreconnected(({connectionId}) => callback());
  }
}

@riverpod
ISignalRClient signalRClient(Ref ref) {
  return SignalrClientImpl(ApiConstants.baseUrl);
}
