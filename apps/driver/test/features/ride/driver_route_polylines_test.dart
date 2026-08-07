import 'dart:async';

import 'package:driver/features/ride/data/models/ride_events/hub_ride_events.dart';
import 'package:driver/features/ride/data/models/route_request/route_request_arg.dart';
import 'package:driver/features/ride/data/repos/route_repo.dart';
import 'package:driver/features/ride/data/services/ride_api_service.dart';
import 'package:driver/features/ride/data/services/ride_hub_data_source.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:driver/features/ride/domain/repos/route_repo.dart';
import 'package:driver/features/ride/ui/providers/driver_markers_provider.dart';
import 'package:driver/features/ride/ui/providers/driver_route_polylines_provider.dart';
import 'package:driver/features/ride/ui/providers/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
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

class FakeRouteRepo implements BaseRouteRepo {
  final requests = <RouteRequestArg>[];
  bool fail = false;

  @override
  Future<ApiResults<List<GeoPoint>>> getRoute(
    RouteRequestArg routeRequestArg,
  ) async {
    requests.add(routeRequestArg);

    if (fail) {
      return ApiResults.failure(ErrorHandler.handle(Exception('no route')));
    }

    return ApiResults.success(const [
      GeoPoint(latitude: 33.31, longitude: 44.36),
      GeoPoint(latitude: 33.32, longitude: 44.37),
    ]);
  }
}

class ThrowingRouteRepo implements BaseRouteRepo {
  @override
  Future<ApiResults<List<GeoPoint>>> getRoute(
    RouteRequestArg routeRequestArg,
  ) => throw Exception('boom');
}

class FakeGeolocator extends GeolocatorPlatform
    with MockPlatformInterfaceMixin {
  final positions = StreamController<Position>.broadcast();

  @override
  Future<bool> isLocationServiceEnabled() async => true;

  @override
  Future<LocationPermission> checkPermission() async =>
      LocationPermission.whileInUse;

  @override
  Future<LocationPermission> requestPermission() async =>
      LocationPermission.whileInUse;

  @override
  Stream<Position> getPositionStream({LocationSettings? locationSettings}) =>
      positions.stream;
}

Position fixAt(double lat, double lng) => Position(
  latitude: lat,
  longitude: lng,
  timestamp: DateTime.utc(2026),
  accuracy: 5,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 90,
  headingAccuracy: 0,
  speed: 8,
  speedAccuracy: 0,
);

HubRideEvent offerEvent() => HubRideEvent.receiveRideRequest(
  rideId: 'ride-1',
  position: const LatLngDto(lat: 33.3152, lng: 44.3661),
  dropPosition: const LatLngDto(lat: 33.325, lng: 44.375),
  calculatedPrice: 7500,
  paymentMethod: 'Cash',
  message: 'طلب جديد',
);

ProviderContainer harness(FakeHub hub, FakeRouteRepo repo) {
  final container = ProviderContainer(
    overrides: [
      rideHubServiceProvider.overrideWithValue(hub),
      rideApiServiceProvider.overrideWithValue(FakeApi()),
      routeRepoProvider.overrideWithValue(repo),
    ],
  );
  addTearDown(container.dispose);
  container.listen(rideControllerProvider, (_, _) {});
  container.listen(rideActionControllerProvider, (_, _) {});
  container.listen(driverMarkersProvider, (_, _) {});
  container.listen(driverRoutePolylinesProvider, (_, _) {});
  return container;
}

Future<void> settle() => Future<void>.delayed(const Duration(milliseconds: 50));

Future<ProviderContainer> online(
  FakeHub hub,
  FakeRouteRepo repo,
  FakeGeolocator geo,
) async {
  final container = harness(hub, repo);
  container.read(rideControllerProvider.notifier).goOnline();
  await settle();

  geo.positions.add(fixAt(33.30, 44.35));
  await settle();

  hub.controllers.last.add(offerEvent());
  await settle();

  return container;
}

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('plugins.it_nomads.com/flutter_secure_storage'),
      (call) async => call.method == 'read' ? 'fake-jwt' : null,
    );
    GeolocatorPlatform.instance = FakeGeolocator();
  });

  test('1. heading draws the driver to the pickup', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final repo = FakeRouteRepo();
    final container = await online(FakeHub(), repo, geo);

    await container.read(rideControllerProvider.notifier).acceptOffer();
    await settle();

    expect(repo.requests.length, 1);
    expect(repo.requests.single.origin.latitude, 33.30);
    expect(repo.requests.single.origin.longitude, 44.35);
    expect(repo.requests.single.destination.latitude, 33.3152);
    expect(repo.requests.single.destination.longitude, 44.3661);

    final polylines = container.read(driverRoutePolylinesProvider).value;
    expect(polylines?.length, 1);
    expect(polylines?.single.polylineId, const PolylineId('driver_route'));
    expect(polylines?.single.points.length, 2);
  });

  test('2. in progress draws the pickup to the dropoff', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final repo = FakeRouteRepo();
    final container = await online(FakeHub(), repo, geo);
    final notifier = container.read(rideControllerProvider.notifier);

    await notifier.acceptOffer();
    await notifier.markArrived();
    await settle();
    repo.requests.clear();

    await notifier.startRide();
    await settle();

    expect(repo.requests.length, 1);
    expect(repo.requests.single.origin.latitude, 33.3152);
    expect(repo.requests.single.destination.latitude, 33.325);
    expect(container.read(driverRoutePolylinesProvider).value?.length, 1);
  });

  test('3. arrived draws no line and asks for no route', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final repo = FakeRouteRepo();
    final container = await online(FakeHub(), repo, geo);
    final notifier = container.read(rideControllerProvider.notifier);

    await notifier.acceptOffer();
    await settle();
    repo.requests.clear();

    await notifier.markArrived();
    await settle();

    expect(repo.requests, isEmpty);
    expect(container.read(driverRoutePolylinesProvider).value, isEmpty);
  });

  test('4. online with no ride draws no line', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final repo = FakeRouteRepo();
    final container = harness(FakeHub(), repo);

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();

    expect(repo.requests, isEmpty);
    expect(container.read(driverRoutePolylinesProvider).value, isEmpty);
  });

  test('5. a failed fetch draws no line and surfaces the failure', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final repo = FakeRouteRepo()..fail = true;
    final container = await online(FakeHub(), repo, geo);

    await container.read(rideControllerProvider.notifier).acceptOffer();
    await settle();

    expect(repo.requests.length, 1);
    expect(container.read(driverRoutePolylinesProvider).value, isEmpty);
    expect(container.read(rideActionControllerProvider).hasError, isTrue);
    expect(
      container.read(rideActionControllerProvider).error,
      isA<RouteUnavailableException>(),
    );
  });

  test('6. moving while heading does not refetch the route', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final repo = FakeRouteRepo();
    final container = await online(FakeHub(), repo, geo);

    await container.read(rideControllerProvider.notifier).acceptOffer();
    await settle();
    expect(repo.requests.length, 1);

    geo.positions.add(fixAt(33.31, 44.36));
    await settle();
    geo.positions.add(fixAt(33.312, 44.362));
    await settle();

    expect(repo.requests.length, 1);
    expect(container.read(driverRoutePolylinesProvider).value?.length, 1);
  });

  test('7. completing the ride drops the line', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final repo = FakeRouteRepo();
    final container = await online(FakeHub(), repo, geo);
    final notifier = container.read(rideControllerProvider.notifier);

    await notifier.acceptOffer();
    await notifier.markArrived();
    await notifier.startRide();
    await settle();
    expect(container.read(driverRoutePolylinesProvider).value?.length, 1);

    await notifier.completeRide();
    await settle();

    expect(container.read(rideControllerProvider).stage, DriverStage.completed);
    expect(container.read(driverRoutePolylinesProvider).value, isEmpty);
  });

  testWidgets('8. a fix that never arrives times out', (tester) async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final repo = FakeRouteRepo();
    final hub = FakeHub();
    final container = harness(hub, repo);

    container.read(rideControllerProvider.notifier).goOnline();
    await tester.pump(const Duration(milliseconds: 50));
    hub.controllers.last.add(offerEvent());
    await tester.pump(const Duration(milliseconds: 50));

    unawaited(container.read(rideControllerProvider.notifier).acceptOffer());
    await tester.pump(const Duration(milliseconds: 50));
    expect(container.read(driverRoutePolylinesProvider).isLoading, isTrue);

    await tester.pump(const Duration(seconds: 9));

    expect(repo.requests, isEmpty);
    expect(container.read(driverRoutePolylinesProvider).value, isEmpty);
    expect(container.read(driverRoutePolylinesProvider).hasError, isFalse);
    expect(
      container.read(rideActionControllerProvider).error,
      isA<RouteUnavailableException>(),
    );
  });

  test('9. a thrown route call is reported, not swallowed', () async {
    final geo = FakeGeolocator();
    GeolocatorPlatform.instance = geo;
    final hub = FakeHub();
    final container = ProviderContainer(
      overrides: [
        rideHubServiceProvider.overrideWithValue(hub),
        rideApiServiceProvider.overrideWithValue(FakeApi()),
        routeRepoProvider.overrideWithValue(ThrowingRouteRepo()),
      ],
    );
    addTearDown(container.dispose);
    container.listen(rideControllerProvider, (_, _) {});
    container.listen(rideActionControllerProvider, (_, _) {});
    container.listen(driverMarkersProvider, (_, _) {});
    container.listen(driverRoutePolylinesProvider, (_, _) {});

    container.read(rideControllerProvider.notifier).goOnline();
    await settle();
    geo.positions.add(fixAt(33.30, 44.35));
    await settle();
    hub.controllers.last.add(offerEvent());
    await settle();

    await container.read(rideControllerProvider.notifier).acceptOffer();
    await settle();

    expect(container.read(driverRoutePolylinesProvider).value, isEmpty);
    expect(container.read(driverRoutePolylinesProvider).hasError, isFalse);
    expect(
      container.read(rideActionControllerProvider).error,
      isA<RouteUnavailableException>(),
    );
  });
}
