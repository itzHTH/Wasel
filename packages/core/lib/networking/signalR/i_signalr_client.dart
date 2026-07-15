enum SignalRStatus { disconnected, connecting, connected, reconnecting }

abstract class ISignalRClient {
  SignalRStatus get status;
  Stream<SignalRStatus> get statusStream;

  Future<void> connect({required String jwt});
  Future<void> disconnect();

  void on(String methodName, void Function(List<Object?>? args) handler);
  void off(String methodName);

  Future<Object?> invoke(String methodName, {List<Object>? args = const []});

  void onReconnected(void Function() callback);
}
