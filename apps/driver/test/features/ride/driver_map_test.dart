import 'dart:async';

import 'package:driver/features/ride/data/models/ride_events/hub_ride_events.dart';
import 'package:driver/features/ride/data/services/ride_api_service.dart';
import 'package:driver/features/ride/data/services/ride_hub_data_source.dart';
import 'package:driver/features/ride/ui/providers/location/driver_heading_provider.dart';
import 'package:driver/features/ride/ui/providers/map/driver_markers_provider.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:wasel_core/wasel_core.dart';

class FakeHub implements IRideHubDataSource {
  final controllers = <StreamController<HubRideEvent>>[];

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
  Future<void> updateLocation(double lat, double lng, String? rideId) async {}
}

class FakeApi implements RideApiService {
  @override
  dynamic noSuchMethod(Invocation invocation) => Future<void>.value();
}

class FakeGeolocator extends GeolocatorPlatform
    with MockPlatformInterfaceMixin {
  FakeGeolocator({this.lastKnown});

  int streamCount = 0;
  final positions = StreamController<Position>.broadcast();
  final Position? lastKnown;

  @override
  Future<Position?> getLastKnownPosition({
    bool forceLocationManager = false,
  }) async => lastKnown;

  @override
  Future<bool> isLocationServiceEnabled() async => true;

  @override
  Future<LocationPermission> checkPermission() async =>
      LocationPermission.whileInUse;

  @override
  Future<LocationPermission> requestPermission() async =>
      LocationPermission.whileInUse;

  @override
  Stream<Position> getPositionStream({LocationSettings? locationSettings}) {
    streamCount++;
    return positions.stream;
  }
}

Position fixAt(
  double lat,
  double lng, {
  double heading = 0,
  double speed = 0,
}) => Position(
  latitude: lat,
  longitude: lng,
  timestamp: DateTime.utc(2026),
  accuracy: 5,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: heading,
  headingAccuracy: 0,
  speed: speed,
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

  test('1. a moving fix sets the heading', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final container = harness(FakeHub());
    container.listen(driverHeadingProvider, (_, _) {});

    geo.positions.add(fixAt(33.31, 44.36, heading: 90, speed: 8));
    await settle();

    expect(container.read(driverHeadingProvider), 90);
  });

  test('2. a standing fix keeps the last heading', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final container = harness(FakeHub());
    container.listen(driverHeadingProvider, (_, _) {});

    geo.positions.add(fixAt(33.31, 44.36, heading: 90, speed: 8));
    await settle();

    geo.positions.add(fixAt(33.31, 44.36, heading: 200, speed: 0));
    await settle();

    expect(container.read(driverHeadingProvider), 90);
  });

  test('3. a negative heading keeps the last heading', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final container = harness(FakeHub());
    container.listen(driverHeadingProvider, (_, _) {});

    geo.positions.add(fixAt(33.31, 44.36, heading: 90, speed: 8));
    await settle();

    geo.positions.add(fixAt(33.31, 44.36, heading: -1, speed: 8));
    await settle();

    expect(container.read(driverHeadingProvider), 90);
  });

  test('4. offline marks the driver at the cached fix with no stream', () async {
    final geo = FakeGeolocator(lastKnown: fixAt(33.31, 44.36, heading: 90));
    GeolocatorPlatform.instance = geo;
    final container = harness(FakeHub());
    container.listen(driverMarkersProvider, (_, _) {});

    await settle();

    final markers = container.read(driverMarkersProvider);
    expect(markers.length, 1);
    expect(markers.first.position, const LatLng(33.31, 44.36));

    // The cached fix carries a stale heading, so the car points north instead.
    expect(markers.first.rotation, 0);
    expect(geo.streamCount, 0);
  });

  test('4b. offline with no cached fix holds no marker', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final container = harness(FakeHub());
    container.listen(driverMarkersProvider, (_, _) {});

    await settle();

    expect(container.read(driverMarkersProvider), isEmpty);
    expect(geo.streamCount, 0);
  });

  test('5. online marks the driver at the last fix with its heading', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final container = harness(FakeHub());
    container.listen(driverMarkersProvider, (_, _) {});

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();

    geo.positions.add(fixAt(33.31, 44.36, heading: 45, speed: 8));
    await settle();

    final markers = container.read(driverMarkersProvider);
    expect(markers.length, 1);

    final marker = markers.first;
    expect(marker.markerId, const MarkerId('driver'));
    expect(marker.position, const LatLng(33.31, 44.36));
    expect(marker.rotation, 45);
    expect(marker.flat, isTrue);
    expect(marker.anchor, const Offset(0.5, 0.5));
  });

  test(
    '6. going offline falls back to the cached fix and closes the stream',
    () async {
      final geo = FakeGeolocator(lastKnown: fixAt(31.99, 44.31));
      GeolocatorPlatform.instance = geo;
      final container = harness(FakeHub());
      container.listen(driverMarkersProvider, (_, _) {});

      container.read(rideControllerProvider.notifier).goOnline();
      await settle();
      geo.positions.add(fixAt(33.31, 44.36, heading: 45, speed: 8));
      await settle();
      expect(
        container.read(driverMarkersProvider).first.position,
        const LatLng(33.31, 44.36),
      );

      container.read(rideControllerProvider.notifier).goOffline();
      await settle();

      final markers = container.read(driverMarkersProvider);
      expect(markers.length, 1);
      expect(markers.first.position, const LatLng(31.99, 44.31));
      expect(geo.positions.hasListener, isFalse);
    },
  );
}
