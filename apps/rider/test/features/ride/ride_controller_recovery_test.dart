import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasal/features/ride/domain/entities/ride_event.dart';
import 'package:wasal/features/ride/domain/repo/base_ride_repo.dart';
import 'package:wasal/features/ride/domain/usecases/reconnect_to_ride_use_case.dart';
import 'package:wasal/features/ride/domain/usecases/watch_ride_use_case.dart';
import 'package:wasal/features/ride/ride_di_providers.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_lifecycle_observer.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_state.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_rides/domain/entities/active_ride.dart';
import 'package:wasel_rides/domain/entities/ride_status.dart';
import 'package:wasel_rides/domain/repos/base_active_ride_repo.dart';
import 'package:wasel_rides/domain/usecases/get_active_ride_use_case.dart';
import 'package:wasel_rides/presentation/providers/rides_di_providers.dart';

class _UnusedRideRepo implements BaseRideRepo {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _UnusedActiveRideRepo implements BaseActiveRideRepo {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _FakeGetActiveRide extends GetActiveRideUseCase {
  _FakeGetActiveRide(this.result) : super(_UnusedActiveRideRepo());

  ApiResults<ActiveRide?> result;
  int calls = 0;

  @override
  Future<ApiResults<ActiveRide?>> execute(
    void params,
    CancelToken token,
  ) async {
    calls++;
    return result;
  }
}

/// Feeds hub events by hand, standing in for the SignalR stream.
class _FakeWatchRide extends WatchRideUseCase {
  _FakeWatchRide() : super(_UnusedRideRepo());

  final _controller = StreamController<RideEvent>.broadcast();
  String? watchedRideId;

  @override
  Stream<RideEvent> call(String rideId) {
    watchedRideId = rideId;
    return _controller.stream;
  }

  void emit(RideEvent event) => _controller.add(event);
}

class _FakeReconnect extends ReconnectToRideUseCase {
  _FakeReconnect() : super(_UnusedRideRepo());

  final rejoined = <String>[];

  @override
  Future<bool> call(String rideId) async {
    rejoined.add(rideId);
    return true;
  }
}

ActiveRide _ride({
  String id = 'ride-1',
  RideStatus? status = RideStatus.accepted,
  double? driverLat,
  double? driverLng,
}) => ActiveRide(
  rideId: id,
  status: status,
  pickupLatitude: 33.3152,
  pickupLongitude: 44.3661,
  dropoffLatitude: 33.2989,
  dropoffLongitude: 44.4009,
  calculatedPrice: 7500,
  driverId: 'driver-1',
  driverName: 'Kareem Ahmed',
  driverPhone: '+9647709876543',
  vehicleModel: 'Kia Cerato',
  vehicleYear: 2021,
  driverLatitude: driverLat,
  driverLongitude: driverLng,
);

void main() {
  late _FakeWatchRide watch;
  late _FakeReconnect reconnect;
  late _FakeGetActiveRide getActiveRide;

  ProviderContainer containerFor(ApiResults<ActiveRide?> active) {
    watch = _FakeWatchRide();
    reconnect = _FakeReconnect();
    getActiveRide = _FakeGetActiveRide(active);

    final container = ProviderContainer(
      overrides: [
        getActiveRideUseCaseProvider.overrideWithValue(getActiveRide),
        watchRideUseCaseProvider.overrideWithValue(watch),
        reconnectToRideUseCaseProvider.overrideWithValue(reconnect),
      ],
    );
    addTearDown(container.dispose);
    container.listen(rideControllerProvider, (_, _) {});
    return container;
  }

  /// Recovery is kicked off unawaited from build(), so the state under test is
  /// the one that lands after the microtask queue drains.
  Future<void> settle() => Future<void>.delayed(Duration.zero);

  test('holds the hub chain open for as long as the ride is tracked', () async {
    // Regression: the use cases were resolved with `ref.read`, which hands back
    // the instance without holding its auto-disposed chain — use case → repo →
    // hub datasource → SignalR client. The chain tore itself down on the next
    // tick and stopped the socket mid-negotiation, so every ReconnectToRide
    // timed out against a hub that was already gone.
    //
    // overrideWithValue cannot catch this: those overrides never dispose.
    // These keep real auto-dispose semantics.
    var watchDisposed = false;
    var reconnectDisposed = false;

    final watchRide = _FakeWatchRide();
    final container = ProviderContainer(
      overrides: [
        getActiveRideUseCaseProvider.overrideWithValue(
          _FakeGetActiveRide(ApiResults.success(_ride())),
        ),
        watchRideUseCaseProvider.overrideWith((ref) {
          ref.onDispose(() => watchDisposed = true);
          return watchRide;
        }),
        reconnectToRideUseCaseProvider.overrideWith((ref) {
          ref.onDispose(() => reconnectDisposed = true);
          return _FakeReconnect();
        }),
      ],
    );
    addTearDown(container.dispose);
    container.listen(rideControllerProvider, (_, _) {});

    await settle();

    expect(container.read(rideControllerProvider).hasActiveRide, isTrue);
    expect(watchDisposed, isFalse);
    expect(reconnectDisposed, isFalse);
  });

  group('cold start', () {
    test('rebuilds the ride the backend says is live', () async {
      final container = containerFor(ApiResults.success(_ride()));

      await settle();
      final state = container.read(rideControllerProvider);

      expect(state.isRecovering, isFalse);
      expect(state.stage, RideStage.accepted);
      expect(state.ride?.rideId, 'ride-1');
      expect(state.driver?.name, 'Kareem Ahmed');
    });

    test(
      're-joins the ride group so the server resumes pushing to it',
      () async {
        final container = containerFor(ApiResults.success(_ride()));

        await settle();

        expect(watch.watchedRideId, 'ride-1');
        expect(reconnect.rejoined, ['ride-1']);
        expect(container.read(rideControllerProvider).hasActiveRide, isTrue);
      },
    );

    test('holds the map behind the gate until the backend answers', () async {
      final container = containerFor(ApiResults.success(_ride()));

      // Before the read lands there is no answer yet, so the map stays gated —
      // a rider mid-trip must never see the draft flash past first.
      expect(container.read(rideControllerProvider).isAwaitingRecovery, isTrue);

      await settle();

      expect(
        container.read(rideControllerProvider).isAwaitingRecovery,
        isFalse,
      );
    });

    test('keeps the gate up with a retry when the read fails', () async {
      // There is no answer to show, so falling through to the map would put a
      // "where to?" draft in front of a rider who may well have a ride.
      final container = containerFor(
        ApiResults.failure(ErrorHandler.message('offline')),
      );

      await settle();
      final state = container.read(rideControllerProvider);

      expect(state.isAwaitingRecovery, isTrue);
      expect(state.isRecovering, isFalse);
      expect(state.recoveryError, isNotNull);
    });

    test('lifts the gate once a retry succeeds', () async {
      final container = containerFor(
        ApiResults.failure(ErrorHandler.message('offline')),
      );
      await settle();

      getActiveRide.result = ApiResults.success(_ride());
      await container.read(rideControllerProvider.notifier).retryRecovery();
      await settle();

      final state = container.read(rideControllerProvider);
      expect(state.isAwaitingRecovery, isFalse);
      expect(state.recoveryError, isNull);
      expect(state.stage, RideStage.accepted);
    });

    test('shows the default map when there is no ride', () async {
      final container = containerFor(const ApiResults.success(null));

      await settle();
      final state = container.read(rideControllerProvider);

      expect(state.stage, RideStage.idel);
      expect(state.hasActiveRide, isFalse);
      expect(state.isRecovering, isFalse);
      expect(reconnect.rejoined, isEmpty);
    });

    test('does not re-join a ride that came back already finished', () async {
      // Regression: the ride id was read off the payload rather than off the
      // state the snapshot produced, so a terminal ride was cleared and then
      // immediately re-subscribed and re-joined.
      final container = containerFor(
        ApiResults.success(_ride(status: RideStatus.completed)),
      );

      await settle();

      expect(reconnect.rejoined, isEmpty);
      expect(watch.watchedRideId, isNull);
      expect(container.read(rideControllerProvider).ride, isNull);
    });

    test(
      'carries the driver position through when the driver is online',
      () async {
        final container = containerFor(
          ApiResults.success(_ride(driverLat: 33.3201, driverLng: 44.3710)),
        );

        await settle();
        final position = container.read(rideControllerProvider).driverPosition;

        expect(position?.latitude, 33.3201);
        expect(position?.longitude, 44.3710);
      },
    );
  });

  group('RideStatusSync', () {
    test('clears local state once the ride is completed', () async {
      final container = containerFor(ApiResults.success(_ride()));
      await settle();

      watch.emit(RideEvent.statusSync(_ride(status: RideStatus.completed)));
      await settle();

      final state = container.read(rideControllerProvider);
      expect(state.stage, RideStage.completed);
      expect(state.ride, isNull);
      expect(state.driver, isNull);
    });

    test('clears local state once the ride is cancelled', () async {
      final container = containerFor(ApiResults.success(_ride()));
      await settle();

      watch.emit(RideEvent.statusSync(_ride(status: RideStatus.cancelled)));
      await settle();

      final state = container.read(rideControllerProvider);
      expect(state.stage, RideStage.cancelled);
      expect(state.ride, isNull);
    });

    test('clears local state when the snapshot is null', () async {
      final container = containerFor(ApiResults.success(_ride()));
      await settle();

      watch.emit(const RideEvent.statusSync(null));
      await settle();

      final state = container.read(rideControllerProvider);
      expect(state.stage, RideStage.idel);
      expect(state.hasActiveRide, isFalse);
      expect(state.ride, isNull);
    });

    test(
      'rebuilds the stage from the snapshot, overriding what we believed',
      () async {
        final container = containerFor(ApiResults.success(_ride()));
        await settle();

        watch.emit(RideEvent.statusSync(_ride(status: RideStatus.inProgress)));
        await settle();

        expect(
          container.read(rideControllerProvider).stage,
          RideStage.inProgress,
        );
      },
    );
  });

  group('startTracking', () {
    test('exposes the ride id before any snapshot has arrived', () async {
      // The cancel button reads this. A ride accepted seconds ago has an id and
      // nothing else, and must still be cancellable.
      final container = containerFor(const ApiResults.success(null));
      await settle();

      container.read(rideControllerProvider.notifier).startTracking('ride-9');

      final state = container.read(rideControllerProvider);
      expect(state.rideId, 'ride-9');
      expect(state.ride, isNull);
      expect(state.stage, RideStage.searching);
    });

    test(
      'prefers the snapshot id once the backend describes the trip',
      () async {
        final container = containerFor(ApiResults.success(_ride()));
        await settle();

        expect(container.read(rideControllerProvider).rideId, 'ride-1');
      },
    );
  });

  group('clearRide', () {
    test('drops the ride without re-reading or re-gating', () async {
      // The completion event already told us the trip is over. Re-reading would
      // put the recovery loader back over a rider who has just finished one.
      final container = containerFor(ApiResults.success(_ride()));
      await settle();
      expect(getActiveRide.calls, 1);

      container.read(rideControllerProvider.notifier).clearRide();
      await settle();

      final state = container.read(rideControllerProvider);
      expect(state.stage, RideStage.idel);
      expect(state.ride, isNull);
      expect(state.isAwaitingRecovery, isFalse);
      expect(getActiveRide.calls, 1);
    });
  });

  group('DriverDisconnected', () {
    test('raises the overlay without touching the ride status', () async {
      final container = containerFor(ApiResults.success(_ride()));
      await settle();

      watch.emit(
        const RideEvent.driverDisconnected(rideId: 'ride-1', message: 'lost'),
      );
      await settle();

      final state = container.read(rideControllerProvider);
      expect(state.isDriverDisconnected, isTrue);
      // The whole point: a transport drop is not a business event.
      expect(state.stage, RideStage.accepted);
      expect(state.ride?.rideId, 'ride-1');
    });

    test('clears once the driver reports a position again', () async {
      final container = containerFor(ApiResults.success(_ride()));
      await settle();

      watch.emit(
        const RideEvent.driverDisconnected(rideId: 'ride-1', message: 'lost'),
      );
      await settle();
      watch.emit(RideEvent.statusSync(_ride()));
      await settle();

      expect(
        container.read(rideControllerProvider).isDriverDisconnected,
        isFalse,
      );
    });
  });

  group('refreshFromBackend', () {
    test('stops watching the foreground once the ride screen is gone', () async {
      // The observer is the only thing that can wake a kept-alive controller.
      // Outliving the screen, it would keep re-reading the ride endpoint after a
      // sign-out — unauthenticated, and into the next account's session.
      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      final container = containerFor(ApiResults.success(_ride()));
      await settle();

      final screen = container.listen(rideLifecycleObserverProvider, (_, _) {});
      await settle();
      final before = getActiveRide.calls;

      screen.close();
      await settle();

      binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await settle();

      expect(getActiveRide.calls, before);
    });

    test('re-reads the ride when the app returns to the foreground', () async {
      final container = containerFor(ApiResults.success(_ride()));
      await settle();
      expect(getActiveRide.calls, 1);

      getActiveRide.result = ApiResults.success(
        _ride(status: RideStatus.inProgress),
      );
      await container
          .read(rideControllerProvider.notifier)
          .refreshFromBackend();

      expect(getActiveRide.calls, 2);
      expect(
        container.read(rideControllerProvider).stage,
        RideStage.inProgress,
      );
    });

    test('keeps a ride already on screen when the re-read fails', () async {
      // The socket is still the live channel. Blanking a running trip because
      // one resume-time poll could not reach the network would be worse than
      // showing state a few seconds stale.
      final container = containerFor(ApiResults.success(_ride()));
      await settle();

      getActiveRide.result = ApiResults.failure(
        ErrorHandler.message('offline'),
      );
      await container
          .read(rideControllerProvider.notifier)
          .refreshFromBackend();

      final state = container.read(rideControllerProvider);
      expect(state.stage, RideStage.accepted);
      expect(state.ride?.rideId, 'ride-1');
      expect(state.isRecovering, isFalse);
    });

    test(
      'lets a failed resume read go rather than trapping the rider',
      () async {
        // The rider did nothing but reopen the app. The loader is fair while the
        // read runs, but turning its failure into a blocking retry would scold
        // them for the network — the socket is still the live channel.
        final container = containerFor(const ApiResults.success(null));
        await settle();

        getActiveRide.result = ApiResults.failure(
          ErrorHandler.message('offline'),
        );
        await container
            .read(rideControllerProvider.notifier)
            .refreshFromBackend();

        final state = container.read(rideControllerProvider);
        expect(state.hasActiveRide, isFalse);
        expect(state.recoveryError, isNull);
        expect(state.isAwaitingRecovery, isFalse);
      },
    );

    test('raises the loader while a resume read is in flight', () async {
      // Coming back to a card that may be minutes stale, with no sign the app
      // is checking, reads as a frozen screen.
      final container = containerFor(ApiResults.success(_ride()));
      await settle();
      expect(container.read(rideControllerProvider).isRecovering, isFalse);

      final inFlight = container
          .read(rideControllerProvider.notifier)
          .refreshFromBackend();

      expect(container.read(rideControllerProvider).isRecovering, isTrue);

      await inFlight;
      await settle();

      expect(container.read(rideControllerProvider).isRecovering, isFalse);
    });

    test('re-gates with a retry only when the opening read fails', () async {
      final container = containerFor(const ApiResults.success(null));
      await settle();

      getActiveRide.result = ApiResults.failure(
        ErrorHandler.message('offline'),
      );
      await container.read(rideControllerProvider.notifier).retryRecovery();

      final state = container.read(rideControllerProvider);
      expect(state.recoveryError, isNotNull);
      expect(state.isAwaitingRecovery, isTrue);
    });

    test('never gates a running trip behind a failed re-read', () async {
      // Resume-time re-reads happen under a live trip; throwing the map behind
      // a full-screen loader because the network blipped would be worse than
      // showing state a few seconds stale.
      final container = containerFor(ApiResults.success(_ride()));
      await settle();

      getActiveRide.result = ApiResults.failure(
        ErrorHandler.message('offline'),
      );
      await container
          .read(rideControllerProvider.notifier)
          .refreshFromBackend();
      await settle();

      final state = container.read(rideControllerProvider);
      expect(state.isAwaitingRecovery, isFalse);
      expect(state.recoveryError, isNull);
      expect(state.stage, RideStage.accepted);
    });
  });
}
