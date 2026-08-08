import 'dart:async';

import 'package:driver/features/ride/data/models/ride_events/hub_ride_events.dart';
import 'package:driver/features/ride/data/services/ride_api_service.dart';
import 'package:driver/features/ride/data/services/ride_hub_data_source.dart';
import 'package:driver/features/ride/ui/providers/device_location_provider.dart';
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
    this.lastKnown,
    this.currentFix,
  });

  bool serviceEnabled;
  LocationPermission permission;
  LocationPermission? permissionAfterRequest;

  /// Seed fixes. Both null means neither call can produce one, which is how
  /// the pre-existing cases keep exercising the stream alone.
  Position? lastKnown;
  Position? currentFix;

  int requestCount = 0;
  int streamCount = 0;
  int currentFixCount = 0;
  final positions = StreamController<Position>.broadcast();

  @override
  Future<Position?> getLastKnownPosition({
    bool forceLocationManager = false,
  }) async => lastKnown;

  @override
  Future<Position> getCurrentPosition({LocationSettings? locationSettings}) async {
    currentFixCount++;
    final fix = currentFix;
    if (fix == null) throw const LocationServiceDisabledException();
    return fix;
  }

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

  test('2. online forwards each fix to the hub with an empty rideId', () async {
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
      [33.31, 44.36, ''],
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
      [33.31, 44.36, ''],
      [33.32, 44.37, ''],
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
    expect(hub.updates.last, [33.31, 44.36, '']);

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
    expect(hub.updates.last, [33.31, 44.36, '']);

    container.read(rideControllerProvider.notifier).goOffline();
    await tester.pump(const Duration(milliseconds: 50));
  });

  test('10. an accepted ride is carried in every broadcast', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();
    hub.controllers.last.add(
      HubRideEvent.receiveRideRequest(
        rideId: 'ride-1',
        position: const LatLngDto(lat: 33.3152, lng: 44.3661),
        dropPosition: const LatLngDto(lat: 33.325, lng: 44.375),
        calculatedPrice: 7500,
        paymentMethod: 'Cash',
        message: 'طلب جديد',
      ),
    );
    await settle();

    geo.positions.add(fixAt(33.31, 44.36));
    await settle();
    expect(hub.updates.last, [33.31, 44.36, '']);

    await container.read(rideControllerProvider.notifier).acceptOffer();
    geo.positions.add(fixAt(33.32, 44.37));
    await settle();

    expect(hub.updates.last, [33.32, 44.37, 'ride-1']);

    final notifier = container.read(rideControllerProvider.notifier);
    await notifier.markArrived();
    await notifier.startRide();
    geo.positions.add(fixAt(33.33, 44.38));
    await settle();

    expect(hub.updates.last, [33.33, 44.38, 'ride-1']);

    await notifier.completeRide();
    notifier.dismissCompleted();
    geo.positions.add(fixAt(33.34, 44.39));
    await settle();

    expect(hub.updates.last, [33.34, 44.39, '']);
  });

  test('11. every consumer shares one gps stream', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final container = harness(FakeHub());

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();
    expect(geo.streamCount, 1);

    final reader = container.listen(deviceLocationProvider, (_, _) {});
    await settle();

    expect(geo.streamCount, 1);
    expect(geo.positions.hasListener, isTrue);

    container.read(rideControllerProvider.notifier).goOffline();
    await settle();
    expect(geo.positions.hasListener, isTrue);

    reader.close();
    await settle();

    expect(geo.positions.hasListener, isFalse);
  });

  test('12. three failed broadcasts in a row reach the driver', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final hub = FakeHub()..failUpdate = true;
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();

    geo.positions.add(fixAt(33.31, 44.36));
    await settle();
    expect(container.read(rideActionControllerProvider).hasError, isFalse);

    geo.positions.add(fixAt(33.32, 44.37));
    await settle();
    expect(container.read(rideActionControllerProvider).hasError, isFalse);

    geo.positions.add(fixAt(33.33, 44.38));
    await settle();

    expect(container.read(rideActionControllerProvider).hasError, isTrue);
    expect(
      container.read(rideActionControllerProvider).error.toString(),
      'ماكو اتصال بالخادم، موقعك ما يوصل للتوزيع',
    );
    expect(geo.positions.hasListener, isTrue);
  });

  test('13. a success resets the failure count', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final hub = FakeHub()..failUpdate = true;
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();

    geo.positions.add(fixAt(33.31, 44.36));
    await settle();
    geo.positions.add(fixAt(33.32, 44.37));
    await settle();

    hub.failUpdate = false;
    geo.positions.add(fixAt(33.33, 44.38));
    await settle();

    hub.failUpdate = true;
    geo.positions.add(fixAt(33.34, 44.39));
    await settle();
    geo.positions.add(fixAt(33.35, 44.40));
    await settle();

    expect(container.read(rideActionControllerProvider).hasError, isFalse);
  });

  test('a stationary driver still reaches dispatch from the last known fix', () async {
    final geo = FakeGeolocator(lastKnown: fixAt(33.31, 44.36));
    GeolocatorPlatform.instance = geo;
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();

    // The stream never fires: the driver has not moved the distance filter.
    expect(hub.updates, [
      [33.31, 44.36, ''],
    ]);
    expect(container.read(rideActionControllerProvider).hasError, isFalse);
  });

  test('a stationary driver with no cached fix falls back to a live one', () async {
    final geo = FakeGeolocator(currentFix: fixAt(33.40, 44.40));
    GeolocatorPlatform.instance = geo;
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();

    expect(geo.currentFixCount, 1);
    expect(hub.updates, [
      [33.40, 44.40, ''],
    ]);
  });

  test('the seed never overwrites a fix the stream already delivered', () async {
    final geo = FakeGeolocator(lastKnown: fixAt(33.31, 44.36));
    GeolocatorPlatform.instance = geo;
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();
    geo.positions.add(fixAt(33.50, 44.50));
    await settle();

    expect(hub.updates.last, [33.50, 44.50, '']);
  });

  test('going offline before the seed lands broadcasts nothing', () async {
    final geo = FakeGeolocator(lastKnown: fixAt(33.31, 44.36));
    GeolocatorPlatform.instance = geo;
    final hub = FakeHub();
    final container = harness(hub);

    container.read(rideControllerProvider.notifier).goOnline();
    container.read(rideControllerProvider.notifier).goOffline();
    await settle();

    expect(hub.updates, isEmpty);
  });
}
