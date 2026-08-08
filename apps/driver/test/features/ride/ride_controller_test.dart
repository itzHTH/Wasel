import 'dart:async';

import 'package:driver/features/ride/data/models/ride_events/hub_ride_events.dart';
import 'package:driver/features/ride/data/services/ride_api_service.dart';
import 'package:driver/features/ride/data/services/ride_hub_data_source.dart';
import 'package:driver/features/ride/ui/providers/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeHub implements IRideHubDataSource {
  FakeHub({this.failOnConnect = false});

  final bool failOnConnect;
  int connectCount = 0;
  int disconnectCount = 0;
  final controllers = <StreamController<HubRideEvent>>[];

  @override
  Stream<HubRideEvent> get events {
    final controller = StreamController<HubRideEvent>.broadcast();
    controllers.add(controller);
    return controller.stream;
  }

  @override
  Future<void> connect({required String jwt}) async {
    connectCount++;
    if (failOnConnect) throw const SocketFailure();
  }

  @override
  Future<void> disconnect() async => disconnectCount++;

  @override
  Future<void> dispose() async {}

  @override
  Future<void> updateLocation(double lat, double lng, String? rideId) async {}
}

class SocketFailure implements Exception {
  const SocketFailure();
  @override
  String toString() => 'no network';
}

class FakeApi implements RideApiService {
  final calls = <Symbol>[];
  bool fail = false;

  @override
  dynamic noSuchMethod(Invocation invocation) {
    calls.add(invocation.memberName);
    return fail
        ? Future<void>.error(const SocketFailure())
        : Future<void>.value();
  }
}

HubRideEvent offerEvent({String rideId = 'ride-1'}) =>
    HubRideEvent.receiveRideRequest(
      rideId: rideId,
      position: const LatLngDto(lat: 33.3152, lng: 44.3661),
      dropPosition: const LatLngDto(lat: 33.325, lng: 44.375),
      calculatedPrice: 7500,
      paymentMethod: 'Cash',
      message: 'طلب جديد',
    );

ProviderContainer harness(FakeHub hub, [FakeApi? api]) {
  final container = ProviderContainer(
    overrides: [
      rideHubServiceProvider.overrideWithValue(hub),
      rideApiServiceProvider.overrideWithValue(api ?? FakeApi()),
    ],
  );
  addTearDown(container.dispose);
  container.listen(rideControllerProvider, (_, _) {});
  container.listen(rideActionControllerProvider, (_, _) {});
  return container;
}

Future<void> settle() => Future<void>.delayed(const Duration(milliseconds: 50));

Future<ProviderContainer> withOffer(FakeHub hub, FakeApi api) async {
  final container = harness(hub, api);
  container.read(rideControllerProvider.notifier).goOnline();
  await settle();
  hub.controllers.last.add(offerEvent());
  await settle();
  return container;
}

Future<ProviderContainer> atStage(
  FakeHub hub,
  FakeApi api,
  DriverStage stage,
) async {
  final container = await withOffer(hub, api);
  final notifier = container.read(rideControllerProvider.notifier);

  await notifier.acceptOffer();
  if (stage != DriverStage.heading) await notifier.markArrived();
  if (stage != DriverStage.heading && stage != DriverStage.arrived) {
    await notifier.startRide();
  }
  if (stage == DriverStage.completed) await notifier.completeRide();

  api.calls.clear();
  return container;
}

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('plugins.it_nomads.com/flutter_secure_storage'),
      (call) async => call.method == 'read' ? 'fake-jwt' : null,
    );
  });

  test('1. connected: goOnline stays online with no error', () async {
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(container.read(rideControllerProvider).stage, DriverStage.online);
    expect(container.read(rideActionControllerProvider).hasError, isFalse);
    expect(hub.connectCount, 1);
  });

  test('2. offline: goOnline snaps back to offline and reports', () async {
    final hub = FakeHub(failOnConnect: true);
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(container.read(rideControllerProvider).stage, DriverStage.offline);
    expect(container.read(rideActionControllerProvider).hasError, isTrue);
    expect(
      container.read(rideActionControllerProvider).error.toString(),
      'no network',
    );
  });

  test('2b. stream closing early also snaps back to offline', () async {
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(container.read(rideControllerProvider).stage, DriverStage.online);

    await hub.controllers.last.close();
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(container.read(rideControllerProvider).stage, DriverStage.offline);
    expect(container.read(rideActionControllerProvider).hasError, isTrue);
  });

  test('3. on then off leaves offline and disconnects', () async {
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await Future<void>.delayed(const Duration(milliseconds: 50));
    container.read(rideControllerProvider.notifier).goOffline();
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(container.read(rideControllerProvider).stage, DriverStage.offline);
    expect(container.read(rideActionControllerProvider).hasError, isFalse);
    expect(hub.disconnectCount, 1);
  });

  test('4. rapid toggling leaves one live subscription and no error', () async {
    final hub = FakeHub();
    final container = harness(hub);
    final notifier = container.read(rideControllerProvider.notifier);

    for (var i = 0; i < 6; i++) {
      notifier.goOnline();
      notifier.goOffline();
    }
    notifier.goOnline();
    await Future<void>.delayed(const Duration(milliseconds: 100));

    expect(container.read(rideControllerProvider).stage, DriverStage.online);
    expect(container.read(rideActionControllerProvider).hasError, isFalse);
    expect(hub.controllers.where((c) => c.hasListener).length, 1);
  });

  test('5. an offer moves the stage to offerReceived and keeps it', () async {
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();

    hub.controllers.last.add(offerEvent());
    await settle();

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.offerReceived);
    expect(state.ride?.rideId, 'ride-1');
    expect(state.ride?.position.latitude, 33.3152);
    expect(state.ride?.dropPosition.longitude, 44.375);
    expect(state.ride?.calculatedPrice, 7500);
    expect(state.ride?.paymentMethod, 'Cash');
    expect(state.secondsLeft, 30);
  });

  test('6. hideRideRequest clears the offer and returns to online', () async {
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();
    hub.controllers.last.add(offerEvent());
    await settle();

    hub.controllers.last.add(const HubRideEvent.hideRideRequest('ride-1'));
    await settle();

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.online);
    expect(state.ride, isNull);
  });

  test('6b. hideRideRequest without an offer changes nothing', () async {
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();

    hub.controllers.last.add(const HubRideEvent.hideRideRequest('ride-9'));
    await settle();

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.online);
    expect(state.ride, isNull);
  });

  test('7. cancelled clears the offer and returns to online', () async {
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();
    hub.controllers.last.add(offerEvent());
    await settle();

    hub.controllers.last.add(const HubRideEvent.cancelled(message: 'ألغي'));
    await settle();

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.online);
    expect(state.ride, isNull);
  });

  test('8. profileReviewed leaves a pending offer untouched', () async {
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();
    hub.controllers.last.add(offerEvent());
    await settle();

    hub.controllers.last.add(
      const HubRideEvent.profileReviewed(isApproved: true, message: ''),
    );
    await settle();

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.offerReceived);
    expect(state.ride?.rideId, 'ride-1');
  });

  test(
    '9. acceptOffer calls accept and moves to heading, keeping the ride',
    () async {
      final hub = FakeHub();
      final api = FakeApi();
      final container = await withOffer(hub, api);

      await container.read(rideControllerProvider.notifier).acceptOffer();

      final state = container.read(rideControllerProvider);
      expect(state.stage, DriverStage.heading);
      expect(state.ride?.rideId, 'ride-1');
      expect(api.calls, [#acceptRide]);
      expect(container.read(rideActionControllerProvider).hasError, isFalse);
    },
  );

  test('9b. a failed accept leaves the offer on screen', () async {
    final hub = FakeHub();
    final api = FakeApi()..fail = true;
    final container = await withOffer(hub, api);

    await container.read(rideControllerProvider.notifier).acceptOffer();

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.offerReceived);
    expect(state.ride?.rideId, 'ride-1');
    expect(container.read(rideActionControllerProvider).hasError, isTrue);
  });

  test('10. rejectOffer clears locally and calls no endpoint', () async {
    final hub = FakeHub();
    final api = FakeApi();
    final container = harness(hub, api);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();
    hub.controllers.last.add(offerEvent());
    await settle();

    container.read(rideControllerProvider.notifier).rejectOffer();
    await settle();

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.online);
    expect(state.ride, isNull);
    expect(api.calls, isEmpty);
  });

  test('11. going offline while an offer is up drops the offer', () async {
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();
    hub.controllers.last.add(offerEvent());
    await settle();

    container.read(rideControllerProvider.notifier).goOffline();
    await settle();

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.offline);
    expect(state.ride, isNull);
  });

  test('12. markArrived calls arrive and moves to arrived', () async {
    final api = FakeApi();
    final container = await atStage(FakeHub(), api, DriverStage.heading);

    await container.read(rideControllerProvider.notifier).markArrived();

    expect(container.read(rideControllerProvider).stage, DriverStage.arrived);
    expect(api.calls, [#arriveAtDestination]);
  });

  test('13. a failed arrive keeps the stage at heading', () async {
    final api = FakeApi();
    final container = await atStage(FakeHub(), api, DriverStage.heading);
    api.fail = true;

    await container.read(rideControllerProvider.notifier).markArrived();

    expect(container.read(rideControllerProvider).stage, DriverStage.heading);
    expect(container.read(rideActionControllerProvider).hasError, isTrue);
  });

  test('14. startRide calls start and moves to inProgress', () async {
    final api = FakeApi();
    final container = await atStage(FakeHub(), api, DriverStage.arrived);

    await container.read(rideControllerProvider.notifier).startRide();

    expect(
      container.read(rideControllerProvider).stage,
      DriverStage.inProgress,
    );
    expect(api.calls, [#startRide]);
  });

  test('15. a failed start keeps the stage at arrived', () async {
    final api = FakeApi();
    final container = await atStage(FakeHub(), api, DriverStage.arrived);
    api.fail = true;

    await container.read(rideControllerProvider.notifier).startRide();

    expect(container.read(rideControllerProvider).stage, DriverStage.arrived);
    expect(container.read(rideActionControllerProvider).hasError, isTrue);
  });

  test('16. completeRide calls complete and moves to completed', () async {
    final api = FakeApi();
    final container = await atStage(FakeHub(), api, DriverStage.inProgress);

    await container.read(rideControllerProvider.notifier).completeRide();

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.completed);
    expect(state.ride?.rideId, 'ride-1');
    expect(api.calls, [#completeRide]);
  });

  test('17. a failed complete keeps the stage at inProgress', () async {
    final api = FakeApi();
    final container = await atStage(FakeHub(), api, DriverStage.inProgress);
    api.fail = true;

    await container.read(rideControllerProvider.notifier).completeRide();

    expect(
      container.read(rideControllerProvider).stage,
      DriverStage.inProgress,
    );
    expect(container.read(rideActionControllerProvider).hasError, isTrue);
  });

  test('18. cancelRide calls cancel and drops the ride', () async {
    final api = FakeApi();
    final container = await atStage(FakeHub(), api, DriverStage.arrived);

    await container.read(rideControllerProvider.notifier).cancelRide();

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.online);
    expect(state.ride, isNull);
    expect(api.calls, [#driverCancelRide]);
  });

  test('18b. cancelRide during inProgress makes no call', () async {
    final api = FakeApi();
    final container = await atStage(FakeHub(), api, DriverStage.inProgress);

    await container.read(rideControllerProvider.notifier).cancelRide();

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.inProgress);
    expect(state.ride?.rideId, 'ride-1');
    expect(api.calls, isEmpty);
    expect(container.read(rideActionControllerProvider).hasError, isFalse);
  });

  test('19. a failed cancel keeps the ride', () async {
    final api = FakeApi();
    final container = await atStage(FakeHub(), api, DriverStage.heading);
    api.fail = true;

    await container.read(rideControllerProvider.notifier).cancelRide();

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.heading);
    expect(state.ride?.rideId, 'ride-1');
    expect(container.read(rideActionControllerProvider).hasError, isTrue);
  });

  test('20. dismissCompleted returns to online with no call', () async {
    final api = FakeApi();
    final container = await atStage(FakeHub(), api, DriverStage.completed);

    container.read(rideControllerProvider.notifier).dismissCompleted();
    await settle();

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.online);
    expect(state.ride, isNull);
    expect(api.calls, isEmpty);
  });

  test('21. hideRideRequest during heading keeps the ride', () async {
    final hub = FakeHub();
    final api = FakeApi();
    final container = await atStage(hub, api, DriverStage.heading);

    hub.controllers.last.add(const HubRideEvent.hideRideRequest('ride-1'));
    await settle();

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.heading);
    expect(state.ride?.rideId, 'ride-1');
  });

  test('22. cancelled during inProgress returns to online', () async {
    final hub = FakeHub();
    final api = FakeApi();
    final container = await atStage(hub, api, DriverStage.inProgress);

    hub.controllers.last.add(const HubRideEvent.cancelled(message: 'ألغي'));
    await settle();

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.online);
    expect(state.ride, isNull);
  });

  testWidgets('23. the offer expires after 30 seconds with no call', (
    tester,
  ) async {
    final hub = FakeHub();
    final api = FakeApi();
    final container = harness(hub, api);

    container.read(rideControllerProvider.notifier).goOnline();
    await tester.pump(const Duration(milliseconds: 50));
    hub.controllers.last.add(offerEvent());
    await tester.pump(const Duration(milliseconds: 50));
    expect(container.read(rideControllerProvider).secondsLeft, 30);

    await tester.pump(const Duration(seconds: 10));
    expect(container.read(rideControllerProvider).secondsLeft, 20);

    await tester.pump(const Duration(seconds: 20));

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.online);
    expect(state.ride, isNull);
    expect(state.secondsLeft, 0);
    expect(api.calls, isEmpty);
  });

  testWidgets('24. accepting stops the countdown', (tester) async {
    final hub = FakeHub();
    final api = FakeApi();
    final container = harness(hub, api);

    container.read(rideControllerProvider.notifier).goOnline();
    await tester.pump(const Duration(milliseconds: 50));
    hub.controllers.last.add(offerEvent());
    await tester.pump(const Duration(seconds: 5));
    expect(container.read(rideControllerProvider).secondsLeft, 25);

    await container.read(rideControllerProvider.notifier).acceptOffer();
    await tester.pump(const Duration(seconds: 40));

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.heading);
    expect(state.ride?.rideId, 'ride-1');
    expect(state.secondsLeft, 25);
  });

  testWidgets('25. a second offer restarts the countdown at 30', (
    tester,
  ) async {
    final hub = FakeHub();
    final api = FakeApi();
    final container = harness(hub, api);

    container.read(rideControllerProvider.notifier).goOnline();
    await tester.pump(const Duration(milliseconds: 50));
    hub.controllers.last.add(offerEvent());
    await tester.pump(const Duration(seconds: 10));
    expect(container.read(rideControllerProvider).secondsLeft, 20);

    hub.controllers.last.add(const HubRideEvent.hideRideRequest('ride-1'));
    await tester.pump(const Duration(milliseconds: 50));
    expect(container.read(rideControllerProvider).secondsLeft, 0);

    hub.controllers.last.add(offerEvent(rideId: 'ride-2'));
    await tester.pump(const Duration(milliseconds: 50));
    expect(container.read(rideControllerProvider).secondsLeft, 30);

    await tester.pump(const Duration(seconds: 5));

    final state = container.read(rideControllerProvider);
    expect(state.stage, DriverStage.offerReceived);
    expect(state.ride?.rideId, 'ride-2');
    expect(state.secondsLeft, 25);

    container.read(rideControllerProvider.notifier).goOffline();
    await tester.pump(const Duration(milliseconds: 50));
  });
}
