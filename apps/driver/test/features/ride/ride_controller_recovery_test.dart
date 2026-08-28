import 'dart:async';

import 'package:dio/dio.dart';
import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:driver/features/ride/domain/entities/ride_connection_status.dart';
import 'package:driver/features/ride/domain/repo/base_ride_repo.dart';
import 'package:driver/features/ride/domain/use_case/complete_ride_use_case.dart';
import 'package:driver/features/ride/domain/use_case/reconnect_to_ride_use_case.dart';
import 'package:driver/features/ride/domain/use_case/watch_ride_connection_use_case.dart';
import 'package:driver/features/ride/domain/use_case/watch_ride_event_use_case.dart';
import 'package:driver/features/ride/ride_di_providers.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
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
  Future<ApiResults<ActiveRide?>> execute(void params, CancelToken token) async {
    calls++;
    return result;
  }
}

class _FakeWatchEvents extends WatchRideEventUseCase {
  _FakeWatchEvents() : super(_UnusedRideRepo());

  final _controller = StreamController<DriverRideEvent>.broadcast();

  @override
  Stream<DriverRideEvent> call(void params) => _controller.stream;

  void emit(DriverRideEvent event) => _controller.add(event);
}

class _FakeWatchConnection extends WatchRideConnectionUseCase {
  _FakeWatchConnection() : super(_UnusedRideRepo());

  final _controller = StreamController<RideConnectionStatus>.broadcast();

  @override
  Stream<RideConnectionStatus> call(void params) => _controller.stream;

  void emit(RideConnectionStatus status) => _controller.add(status);
}

class _FakeCompleteRide extends CompleteRideUseCase {
  _FakeCompleteRide() : super(_UnusedRideRepo());

  @override
  Future<ApiResults<void>> execute(String params, CancelToken token) async =>
      const ApiResults.success(null);
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
  RideStatus? status = RideStatus.inProgress,
}) => ActiveRide(
  rideId: id,
  status: status,
  pickupLatitude: 33.3152,
  pickupLongitude: 44.3661,
  dropoffLatitude: 33.2989,
  dropoffLongitude: 44.4009,
  calculatedPrice: 7500,
  paymentMethod: 'Cash',
  riderName: 'Ali Hassan',
  riderPhone: '+9647701234567',
);

void main() {
  late _FakeGetActiveRide getActiveRide;
  late _FakeWatchEvents events;
  late _FakeWatchConnection connection;
  late _FakeReconnect reconnect;

  ProviderContainer containerFor(ApiResults<ActiveRide?> active) {
    getActiveRide = _FakeGetActiveRide(active);
    events = _FakeWatchEvents();
    connection = _FakeWatchConnection();
    reconnect = _FakeReconnect();

    final container = ProviderContainer(
      overrides: [
        getActiveRideUseCaseProvider.overrideWithValue(getActiveRide),
        watchRideEventUseCaseProvider.overrideWithValue(events),
        watchRideConnectionUseCaseProvider.overrideWithValue(connection),
        reconnectToRideUseCaseProvider.overrideWithValue(reconnect),
        completeRideUseCaseProvider.overrideWithValue(_FakeCompleteRide()),
      ],
    );
    addTearDown(container.dispose);
    container.listen(rideControllerProvider, (_, _) {});
    return container;
  }

  Future<void> settle() async {
    for (var i = 0; i < 5; i++) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  group('status mapping', () {
    test('maps each live status onto the stage that drives it', () {
      expect(RideStatus.accepted.driverStage, DriverStage.heading);
      expect(RideStatus.arrived.driverStage, DriverStage.arrived);
      expect(RideStatus.inProgress.driverStage, DriverStage.inProgress);
    });

    test('ignores a ride that is not this driver to drive', () {
      for (final status in [
        RideStatus.pending,
        RideStatus.completed,
        RideStatus.cancelled,
      ]) {
        expect(status.driverStage, isNull, reason: '$status');
      }
    });
  });

  group('cold start', () {
    test('comes back holding the trip the backend still assigns', () async {
      final container = containerFor(ApiResults.success(_ride()));

      await settle();
      final state = container.read(rideControllerProvider);

      expect(state.isRecovering, isFalse);
      expect(state.stage, DriverStage.inProgress);
      expect(state.rideId, 'ride-1');
    });

    test('re-casts the snapshot into the offer the cards render', () async {
      final container = containerFor(ApiResults.success(_ride()));

      await settle();
      final offer = container.read(rideControllerProvider).currentRide;

      expect(offer, isNotNull);
      expect(offer!.rideId, 'ride-1');
      expect(offer.calculatedPrice, 7500);
      expect(offer.paymentMethod, 'Cash');
      expect(offer.riderName, 'Ali Hassan');
      expect(offer.position.latitude, 33.3152);
      expect(offer.dropPosition.longitude, 44.4009);
    });

    test('stays offline when there is no ride', () async {
      final container = containerFor(const ApiResults.success(null));

      await settle();
      final state = container.read(rideControllerProvider);

      expect(state.stage, DriverStage.offline);
      expect(state.activeRide, isNull);
      expect(state.isRecovering, isFalse);
    });

    test('does not strand the driver on a spinner when the poll fails', () async {
      final container = containerFor(
        ApiResults.failure(ErrorHandler.message('offline')),
      );

      await settle();

      expect(container.read(rideControllerProvider).isRecovering, isFalse);
    });
  });

  group('reconnect', () {
    test('re-joins the ride group once the socket reports connected', () async {
      final container = containerFor(ApiResults.success(_ride()));
      await settle();

      connection.emit(RideConnectionStatus.connected);
      await settle();

      expect(reconnect.rejoined, contains('ride-1'));
      expect(
        container.read(rideControllerProvider).stage,
        DriverStage.inProgress,
      );
    });

    test('does not re-join when there is no ride in hand', () async {
      containerFor(const ApiResults.success(null));
      await settle();

      connection.emit(RideConnectionStatus.connected);
      await settle();

      expect(reconnect.rejoined, isEmpty);
    });
  });

  group('RideStatusSync', () {
    test('rebuilds the stage from the snapshot', () async {
      final container = containerFor(
        ApiResults.success(_ride(status: RideStatus.accepted)),
      );
      await settle();
      expect(container.read(rideControllerProvider).stage, DriverStage.heading);

      events.emit(
        DriverRideEvent.statusSync(_ride(status: RideStatus.arrived)),
      );
      await settle();

      expect(container.read(rideControllerProvider).stage, DriverStage.arrived);
    });

    test('clears the trip once it is completed', () async {
      final container = containerFor(ApiResults.success(_ride()));
      await settle();

      events.emit(
        DriverRideEvent.statusSync(_ride(status: RideStatus.completed)),
      );
      await settle();

      final state = container.read(rideControllerProvider);
      expect(state.activeRide, isNull);
      expect(state.currentRide, isNull);
    });

    test('leaves a completed card for the driver to dismiss', () async {
      final container = containerFor(ApiResults.success(_ride()));
      await settle();

      final controller = container.read(rideControllerProvider.notifier);
      expect(await controller.completeRide(), CompletionOutcome.completed);

      getActiveRide.result = const ApiResults.success(null);
      await controller.refreshFromBackend();
      await settle();

      final state = container.read(rideControllerProvider);
      expect(state.stage, DriverStage.completed);
      expect(state.currentRide, isNotNull);
    });

    test('clears the trip when the snapshot is null', () async {
      final container = containerFor(ApiResults.success(_ride()));
      await settle();

      events.emit(const DriverRideEvent.statusSync(null));
      await settle();

      expect(container.read(rideControllerProvider).activeRide, isNull);
    });
  });

  test('a silent resume read never reconnects the hub behind the driver', () async {
    final container = containerFor(const ApiResults.success(null));
    await settle();
    expect(container.read(rideControllerProvider).stage, DriverStage.offline);

    getActiveRide.result = ApiResults.success(_ride());
    await container.read(rideControllerProvider.notifier).refreshFromBackend();
    await settle();

    expect(container.read(rideControllerProvider).rideId, 'ride-1');
    expect(reconnect.rejoined, isEmpty);
  });

  test('re-reads the ride when the app returns to the foreground', () async {
    final container = containerFor(
      ApiResults.success(_ride(status: RideStatus.accepted)),
    );
    await settle();
    expect(getActiveRide.calls, 1);

    getActiveRide.result = ApiResults.success(
      _ride(status: RideStatus.inProgress),
    );
    await container.read(rideControllerProvider.notifier).refreshFromBackend();
    await settle();

    expect(getActiveRide.calls, 2);
    expect(
      container.read(rideControllerProvider).stage,
      DriverStage.inProgress,
    );
  });
  group('a pending offer survives recovery', () {
    test('resuming with no active ride leaves the offer standing', () async {
      final container = containerFor(const ApiResults.success(null));
      await settle();

      final notifier = container.read(rideControllerProvider.notifier);
      await notifier.goOnline();
      connection.emit(RideConnectionStatus.connected);
      await settle();

      events.emit(
        const ReceiveRideRequest(
          rideId: 'offer-1',
          position: GeoPoint(latitude: 33.3152, longitude: 44.3661),
          dropPosition: GeoPoint(latitude: 33.2989, longitude: 44.4009),
          calculatedPrice: 7500,
          paymentMethod: 'Cash',
          riderName: 'Ali Hassan',
          riderPhone: '+9647701234567',
          message: '',
        ),
      );
      await settle();
      expect(
        container.read(rideControllerProvider).stage,
        DriverStage.offerReceived,
      );

      await notifier.refreshFromBackend();
      await settle();

      final state = container.read(rideControllerProvider);
      expect(state.stage, DriverStage.offerReceived);
      expect(state.ride?.rideId, 'offer-1');
      expect(state.secondsLeft, greaterThan(0));
      expect(state.isRecovering, isFalse);
    });

    test('an expired offer is still cleared by recovery', () async {
      final container = containerFor(const ApiResults.success(null));
      await settle();

      final notifier = container.read(rideControllerProvider.notifier);
      await notifier.goOnline();
      connection.emit(RideConnectionStatus.connected);
      await settle();

      notifier.rejectOffer();
      await notifier.refreshFromBackend();
      await settle();

      expect(
        container.read(rideControllerProvider).stage,
        isNot(DriverStage.offerReceived),
      );
    });
  });
}
