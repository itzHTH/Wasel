import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_location/wasel_location.dart';
import 'package:wasal/features/ride/domain/entities/request_ride.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_state.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_state.dart';
import 'package:wasal/features/ride/ui/providers/tracking/search_radius_circles_provider.dart';

class _SentRequestRideController extends RequestRideController {
  @override
  FutureOr<RequestRide?> build() => RequestRide(id: 'ride-1');
}

ProviderContainer _containerFor(RideStage stage) => ProviderContainer(
  overrides: [
    requestRideControllerProvider.overrideWith(_SentRequestRideController.new),
    rideControllerProvider.overrideWithValue(RideState(stage: stage)),
    rideDraftProvider.overrideWithValue(
      const RideDraftState(
        stage: PickingStage.done,
        pickup: LatLng(33.3152, 44.3661),
      ),
    ),
  ],
);

Circle _circleOf(ProviderContainer container) =>
    container.read(searchRadiusCirclesProvider).single;

List<Circle> _pulseSamples(ProviderContainer container, FakeAsync async) {
  final samples = <Circle>[];
  for (var tick = 0; tick < 40; tick++) {
    async.elapse(const Duration(milliseconds: 50));
    samples.add(_circleOf(container));
  }
  return samples;
}

Matcher _oscillatesAround(double radius) => predicate<List<Circle>>((samples) {
  if (samples.any((circle) => circle.radius != radius)) return false;

  final fills = samples.map((circle) => circle.fillColor.a).toSet();
  final strokes = samples.map((circle) => circle.strokeColor.a).toSet();

  return fills.length > 1 && strokes.length > 1;
}, 'holds a ${radius}m radius while its opacity oscillates');

void main() {
  test('radius eases to the first 2km step instead of snapping', () {
    fakeAsync((async) {
      final container = _containerFor(RideStage.searching);
      final sub = container.listen(searchRadiusCirclesProvider, (_, _) {});
      addTearDown(container.dispose);

      expect(sub.read().single.radius, 0);

      async.elapse(const Duration(milliseconds: 400));
      final midway = _circleOf(container).radius;
      expect(midway, greaterThan(0));
      expect(midway, lessThan(2000));

      async.elapse(const Duration(milliseconds: 500));
      expect(_circleOf(container).radius, 2000);
    });
  });

  test('grows 2km each minute and caps at 10km', () {
    fakeAsync((async) {
      final container = _containerFor(RideStage.searching);
      container.listen(searchRadiusCirclesProvider, (_, _) {});
      addTearDown(container.dispose);

      async.elapse(const Duration(seconds: 61));
      expect(_circleOf(container).radius, 4000);

      async.elapse(const Duration(seconds: 60));
      expect(_circleOf(container).radius, 6000);

      async.elapse(const Duration(minutes: 10));
      expect(_circleOf(container).radius, 10000);
    });
  });

  test('pulses the opacity between steps, keeping the radius fixed', () {
    fakeAsync((async) {
      final container = _containerFor(RideStage.searching);
      container.listen(searchRadiusCirclesProvider, (_, _) {});
      addTearDown(container.dispose);

      async.elapse(const Duration(seconds: 1));
      expect(_circleOf(container).radius, 2000);
      expect(_pulseSamples(container, async), _oscillatesAround(2000));
    });
  });

  test('keeps pulsing indefinitely once the radius caps', () {
    fakeAsync((async) {
      final container = _containerFor(RideStage.searching);
      container.listen(searchRadiusCirclesProvider, (_, _) {});
      addTearDown(container.dispose);

      async.elapse(const Duration(minutes: 5));
      expect(_circleOf(container).radius, 10000);
      expect(_pulseSamples(container, async), _oscillatesAround(10000));

      async.elapse(const Duration(minutes: 30));
      expect(_circleOf(container).radius, 10000);
      expect(_pulseSamples(container, async), _oscillatesAround(10000));
    });
  });

  test('clears the circle and its timers when the stage leaves searching', () {
    fakeAsync((async) {
      final container = _containerFor(RideStage.accepted);
      container.listen(searchRadiusCirclesProvider, (_, _) {});
      addTearDown(container.dispose);

      expect(container.read(searchRadiusCirclesProvider), isEmpty);

      async.elapse(const Duration(minutes: 5));
      expect(container.read(searchRadiusCirclesProvider), isEmpty);
      expect(async.pendingTimers, isEmpty);
    });
  });
}
