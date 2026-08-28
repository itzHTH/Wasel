import 'package:flutter_test/flutter_test.dart';
import 'package:wasal/core/consts/ride_hub_methods.dart';
import 'package:wasal/features/ride/data/services/ride_hub_datasource.dart';
import 'package:wasel_core/networking/signalR/i_signalr_client.dart';

class _FakeSignalRClient implements ISignalRClient {
  final reconnectCallbacks = <void Function()>[];
  final invocations = <String>[];
  int connects = 0;

  @override
  Future<void> connect() async => connects++;

  @override
  void onReconnected(void Function() callback) =>
      reconnectCallbacks.add(callback);

  @override
  Future<Object?> invoke(String methodName, {List<Object>? args = const []}) {
    invocations.add(methodName);
    return Future.value();
  }

  @override
  void on(String methodName, void Function(List<Object?>? args) handler) {}

  @override
  void off(String methodName) {}

  @override
  Future<void> disconnect() async {}

  @override
  SignalRStatus get status => SignalRStatus.connected;

  @override
  Stream<SignalRStatus> get statusStream => const Stream.empty();
}

void main() {
  test('hooks the socket for reconnects once, however often it is asked to '
      'connect', () async {
    final client = _FakeSignalRClient();
    final datasource = RideHubDatasource(client);
    addTearDown(datasource.dispose);

    await datasource.connect();
    await datasource.connect();
    await datasource.connect();

    expect(client.reconnectCallbacks, hasLength(1));
  });

  test(
    're-joins the ride the rider is on when the socket comes back',
    () async {
      final client = _FakeSignalRClient();
      final datasource = RideHubDatasource(client);
      addTearDown(datasource.dispose);

      await datasource.connect();
      await datasource.reconnectToRide('ride-1');
      client.invocations.clear();

      client.reconnectCallbacks.single();
      await Future<void>.delayed(Duration.zero);

      expect(client.invocations, [RideHubMethods.reconnectToRide]);
    },
  );

  test('stays quiet on a reconnect when no ride is being tracked', () async {
    final client = _FakeSignalRClient();
    final datasource = RideHubDatasource(client);
    addTearDown(datasource.dispose);

    await datasource.connect();
    client.reconnectCallbacks.single();
    await Future<void>.delayed(Duration.zero);

    expect(client.invocations, isEmpty);
  });
}
