import 'dart:async';

import 'package:driver/features/ride/data/models/ride_events/hub_ride_events.dart';
import 'package:driver/features/ride/data/services/ride_api_service.dart';
import 'package:driver/features/ride/data/services/ride_hub_data_source.dart';
import 'package:driver/features/ride/ui/providers/driver_location_broadcaster.dart';
import 'package:driver/features/ride/ui/providers/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class FakeHub implements IRideHubDataSource {
  final controllers = <StreamController<HubRideEvent>>[];
  final updates = <List<Object?>>[];
  bool failUpdate = false;

  @override
  Stream<HubRideEvent> get events {
    final controller = StreamController<HubRideEvent>.broadcast();
    controllers.add(controller);
    return controller.stream;
  }

  @override
  Future<void> connect({required String jwt}) async {}

  @override
  Future<void> disconnect() async {}

  @override
  Future<void> dispose() async {}

  @override
  Future<void> updateLocation(double lat, double lng, String? rideId) async {
    updates.add([lat, lng, rideId]);
    if (failUpdate) throw Exception('hub not ready');
  }
}

class FakeApi implements RideApiService {
  @override
  dynamic noSuchMethod(Invocation invocation) => Future<void>.value();
}

class FakeGeolocator extends GeolocatorPlatform
    with MockPlatformInterfaceMixin {
  FakeGeolocator({
    this.serviceEnabled = true,
    this.permission = LocationPermission.whileInUse,
    this.permissionAfterRequest,
  });

  bool serviceEnabled;
  LocationPermission permission;
  LocationPermission? permissionAfterRequest;
  int requestCount = 0;
  int streamCount = 0;
  final positions = StreamController<Position>.broadcast();

  @override
  Future<bool> isLocationServiceEnabled() async => serviceEnabled;

  @override
  Future<LocationPermission> checkPermission() async => permission;

  @override
  Future<LocationPermission> requestPermission() async {
    requestCount++;
    return permissionAfterRequest ?? permission;
  }

  @override
  Stream<Position> getPositionStream({LocationSettings? locationSettings}) {
    streamCount++;
    return positions.stream;
  }
}

Position fixAt(double lat, double lng) => Position(
  latitude: lat,
  longitude: lng,
  timestamp: DateTime.utc(2026),
  accuracy: 5,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
);

ProviderContainer harness(FakeHub hub) {
  final container = ProviderContainer(
    overrides: [
      rideHubServiceProvider.overrideWithValue(hub),
      rideApiServiceProvider.overrideWithValue(FakeApi()),
    ],
  );
  addTearDown(container.dispose);
  container.listen(rideControllerProvider, (_, _) {});
  container.listen(rideActionControllerProvider, (_, _) {});
  container.listen(driverLocationBroadcasterProvider, (_, _) {});
  return container;
}

Future<void> settle() => Future<void>.delayed(const Duration(milliseconds: 50));

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('plugins.it_nomads.com/flutter_secure_storage'),
      (call) async => call.method == 'read' ? 'fake-jwt' : null,
    );
  });

  test('1. offline opens no stream and asks for no permission', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final container = harness(FakeHub());

    await settle();

    expect(container.read(rideControllerProvider).stage, DriverStage.offline);
    expect(geo.streamCount, 0);
    expect(geo.requestCount, 0);
  });

  test('2. online forwards each fix to the hub with a null rideId', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();
    expect(geo.streamCount, 1);

    geo.positions.add(fixAt(33.31, 44.36));
    await settle();

    expect(hub.updates, [
      [33.31, 44.36, null],
    ]);
    expect(container.read(rideActionControllerProvider).hasError, isFalse);
  });

  test('3. moving emits further updates', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();

    geo.positions.add(fixAt(33.31, 44.36));
    await settle();
    geo.positions.add(fixAt(33.32, 44.37));
    await settle();

    expect(hub.updates, [
      [33.31, 44.36, null],
      [33.32, 44.37, null],
    ]);
  });

  test('4. going offline stops the stream', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();
    geo.positions.add(fixAt(33.31, 44.36));
    await settle();

    container.read(rideControllerProvider.notifier).goOffline();
    await settle();

    expect(geo.positions.hasListener, isFalse);

    geo.positions.add(fixAt(33.40, 44.40));
    await settle();

    expect(hub.updates.length, 1);
  });

  test('5. denied permission reports a failure and opens no stream', () async {
    final geo = FakeGeolocator(
      permission: LocationPermission.denied,
      permissionAfterRequest: LocationPermission.denied,
    );
    GeolocatorPlatform.instance = geo;
    final container = harness(FakeHub());

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();

    expect(geo.requestCount, 1);
    expect(geo.streamCount, 0);
    expect(container.read(rideActionControllerProvider).hasError, isTrue);
  });

  test('5b. disabled location service reports and opens no stream', () async {
    final geo = FakeGeolocator(serviceEnabled: false);
    GeolocatorPlatform.instance = geo;
    final container = harness(FakeHub());

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();

    expect(geo.streamCount, 0);
    expect(geo.requestCount, 0);
    expect(container.read(rideActionControllerProvider).hasError, isTrue);
  });

  test('6. a failed hub invoke keeps broadcasting alive', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final hub = FakeHub()..failUpdate = true;
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();

    geo.positions.add(fixAt(33.31, 44.36));
    await settle();
    hub.failUpdate = false;
    geo.positions.add(fixAt(33.32, 44.37));
    await settle();

    expect(hub.updates.length, 2);
    expect(geo.positions.hasListener, isTrue);
    expect(container.read(rideControllerProvider).stage, DriverStage.online);
  });

  testWidgets('7. a standing driver keeps broadcasting the last fix', (
    tester,
  ) async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await tester.pump(const Duration(milliseconds: 50));

    geo.positions.add(fixAt(33.31, 44.36));
    await tester.pump(const Duration(milliseconds: 50));
    expect(hub.updates.length, 1);

    await tester.pump(const Duration(seconds: 30));

    expect(hub.updates.length, 4);
    expect(hub.updates.last, [33.31, 44.36, null]);

    container.read(rideControllerProvider.notifier).goOffline();
    await tester.pump(const Duration(milliseconds: 50));
  });

  testWidgets('8. going offline stops the heartbeat', (tester) async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await tester.pump(const Duration(milliseconds: 50));
    geo.positions.add(fixAt(33.31, 44.36));
    await tester.pump(const Duration(milliseconds: 50));

    container.read(rideControllerProvider.notifier).goOffline();
    await tester.pump(const Duration(seconds: 30));

    expect(hub.updates.length, 1);
  });

  testWidgets('9. a failed invoke is retried by the next tick', (tester) async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final hub = FakeHub()..failUpdate = true;
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await tester.pump(const Duration(milliseconds: 50));
    geo.positions.add(fixAt(33.31, 44.36));
    await tester.pump(const Duration(milliseconds: 50));
    expect(hub.updates.length, 1);

    hub.failUpdate = false;
    await tester.pump(const Duration(seconds: 10));

    expect(hub.updates.length, 2);
    expect(hub.updates.last, [33.31, 44.36, null]);

    container.read(rideControllerProvider.notifier).goOffline();
    await tester.pump(const Duration(milliseconds: 50));
  });
}
