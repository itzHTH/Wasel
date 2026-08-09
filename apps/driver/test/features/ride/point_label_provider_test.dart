import 'package:dio/dio.dart';
import 'package:driver/features/ride/data/repos/geocoding_repo.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:driver/features/ride/domain/repos/geocoding_repo.dart';
import 'package:driver/features/ride/ui/providers/location/point_label_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/wasel_core.dart';

class FakeGeocodingRepo implements BaseGeocodingRepo {
  FakeGeocodingRepo({this.fail = false});

  final calls = <GeoPoint>[];
  bool fail;

  @override
  Future<ApiResults<String>> labelFor(
    GeoPoint point, {
    CancelToken? cancelToken,
  }) async {
    calls.add(point);

    if (fail) {
      return ApiResults.failure(ErrorHandler.handle(Exception('boom')));
    }

    return ApiResults.success('شارع ${calls.length}');
  }
}

const _pickup = GeoPoint(latitude: 33.3152, longitude: 44.3661);
const _dropoff = GeoPoint(latitude: 33.3402, longitude: 44.4009);

ProviderContainer harness(FakeGeocodingRepo repo) {
  final container = ProviderContainer(
    overrides: [geocodingRepoProvider.overrideWithValue(repo)],
  );
  addTearDown(container.dispose);
  return container;
}

/// Watches [point] until the lookup stops loading, so the retries decide the
/// timing instead of a fixed sleep.
Future<AsyncValue<String>> settled(
  ProviderContainer container,
  GeoPoint point,
) async {
  container.listen(pointLabelProvider(point), (_, _) {});
  final deadline = DateTime.now().add(const Duration(seconds: 5));

  while (DateTime.now().isBefore(deadline)) {
    final state = container.read(pointLabelProvider(point));
    if (!state.isLoading) return state;
    await Future<void>.delayed(const Duration(milliseconds: 20));
  }

  fail('pointLabelProvider never settled');
}

void main() {
  test('1. a point resolves to its street name', () async {
    final repo = FakeGeocodingRepo();
    final container = harness(repo);

    final label = await container.read(pointLabelProvider(_pickup).future);

    expect(label, 'شارع 1');
    expect(repo.calls, [_pickup]);
  });

  test('2. the same point is looked up once, however many cards read it', () async {
    final repo = FakeGeocodingRepo();
    final container = harness(repo);

    // The offer card, then the drive-to-rider card, then the trip card.
    for (var read = 0; read < 3; read++) {
      await container.read(pointLabelProvider(_pickup).future);
    }

    expect(repo.calls.length, 1, reason: 'the family caches per coordinate');
  });

  test('3. pickup and drop-off are looked up separately', () async {
    final repo = FakeGeocodingRepo();
    final container = harness(repo);

    await container.read(pointLabelProvider(_pickup).future);
    await container.read(pointLabelProvider(_dropoff).future);

    expect(repo.calls, [_pickup, _dropoff]);
  });

  test('4. a failure surfaces so the card can fall back to coordinates', () async {
    final repo = FakeGeocodingRepo(fail: true);
    final container = harness(repo);

    // Watched the way the card watches it, rather than awaited: the retries
    // hand the provider a new future each round.
    final state = await settled(container, _pickup);

    expect(state.hasError, isTrue);
    expect(state.error, isA<ErrorHandler>());
    expect(repo.calls.length, 3, reason: 'the first try plus two retries');
  });
}
