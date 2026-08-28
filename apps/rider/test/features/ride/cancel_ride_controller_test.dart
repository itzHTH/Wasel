import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasal/features/ride/domain/entities/cancel_ride.dart';
import 'package:wasal/features/ride/domain/repo/base_ride_repo.dart';
import 'package:wasal/features/ride/domain/usecases/cancel_ride_use_case.dart';
import 'package:wasal/features/ride/ride_di_providers.dart';
import 'package:wasal/features/ride/ui/providers/cancel_ride/cancel_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_state.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_rides/domain/entities/active_ride.dart';
import 'package:wasel_rides/domain/entities/ride_status.dart';

class _UnusedRepo implements BaseRideRepo {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

/// Records what the real use case hands the repo, so a dropped cancel token
/// shows up here rather than as a request nothing can abort.
class _RecordingRepo implements BaseRideRepo {
  CancelToken? seenToken;

  @override
  Future<ApiResults<CancelRide>> cancelRide(
    String rideId, {
    CancelToken? cancelToken,
  }) async {
    seenToken = cancelToken;
    return ApiResults.success(CancelRide(isCancelled: true));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _FakeCancelUseCase extends CancelRideUseCase {
  _FakeCancelUseCase(this.result) : super(_UnusedRepo());

  final ApiResults<CancelRide> result;
  CancelToken? seenToken;

  @override
  Future<ApiResults<CancelRide>> execute(
    String params,
    CancelToken cancelToken,
  ) async {
    seenToken = cancelToken;
    return result;
  }
}

class _StubRideController extends RideController {
  _StubRideController(this.stage, {this.snapshot = true});

  final RideStage stage;

  final bool snapshot;

  @override
  RideState build() => RideState(
    stage: stage,
    trackedRideId: 'ride-1',
    ride: snapshot
        ? const ActiveRide(
            rideId: 'ride-1',
            status: RideStatus.pending,
            pickupLatitude: 33.3152,
            pickupLongitude: 44.3661,
            dropoffLatitude: 33.2989,
            dropoffLongitude: 44.4009,
          )
        : null,
  );
}

ProviderContainer _container(
  _FakeCancelUseCase useCase, {
  RideStage stage = RideStage.searching,
  bool snapshot = true,
}) {
  final container = ProviderContainer(
    overrides: [
      cancelRideUseCaseProvider.overrideWithValue(useCase),
      rideControllerProvider.overrideWith(
        () => _StubRideController(stage, snapshot: snapshot),
      ),
    ],
  );
  addTearDown(container.dispose);
  // Nothing else listens in a unit test, and the controller auto-disposes the
  // moment its last listener leaves — which would swallow the state it sets.
  container.listen(cancelRideControllerProvider, (_, _) {});
  return container;
}

void main() {
  test('a cancelled ride lands in data so the UI can reset', () async {
    final useCase = _FakeCancelUseCase(
      ApiResults.success(CancelRide(isCancelled: true)),
    );
    final container = _container(useCase);

    await container.read(cancelRideControllerProvider.notifier).cancelRide();

    expect(
      container.read(cancelRideControllerProvider).value?.isCancelled,
      isTrue,
    );
  });

  test('cancels a ride requested moments ago, before any snapshot', () async {
    final useCase = _FakeCancelUseCase(
      ApiResults.success(CancelRide(isCancelled: true)),
    );
    final container = _container(useCase, snapshot: false);

    await container.read(cancelRideControllerProvider.notifier).cancelRide();

    expect(
      container.read(cancelRideControllerProvider).value?.isCancelled,
      isTrue,
    );
  });

  test('a rejected cancellation does not sit in loading forever', () async {
    final useCase = _FakeCancelUseCase(
      ApiResults.success(CancelRide(isCancelled: false)),
    );
    final container = _container(useCase);

    await container.read(cancelRideControllerProvider.notifier).cancelRide();

    final state = container.read(cancelRideControllerProvider);
    expect(
      state.isLoading,
      isFalse,
      reason: 'the card would keep showing its searching radar forever',
    );
    expect(
      state.hasError,
      isTrue,
      reason: 'the rider must be told the ride could not be cancelled',
    );
  });

  test(
    'a failed cancellation surfaces an error, not a stuck spinner',
    () async {
      final useCase = _FakeCancelUseCase(
        ApiResults.failure(ErrorHandler.message('boom')),
      );
      final container = _container(useCase);

      await container.read(cancelRideControllerProvider.notifier).cancelRide();

      final state = container.read(cancelRideControllerProvider);
      expect(state.isLoading, isFalse);
      expect(state.hasError, isTrue);
    },
  );

  test(
    'cancelling an in-progress ride reports why instead of doing nothing',
    () async {
      final useCase = _FakeCancelUseCase(
        ApiResults.success(CancelRide(isCancelled: true)),
      );
      final container = _container(useCase, stage: RideStage.inProgress);

      await container.read(cancelRideControllerProvider.notifier).cancelRide();

      final state = container.read(cancelRideControllerProvider);
      expect(state.isLoading, isFalse);
      expect(
        state.hasError,
        isTrue,
        reason: 'a silent return leaves the button looking broken',
      );
    },
  );

  test('the use case forwards its cancel token to the repo', () async {
    final repo = _RecordingRepo();

    await CancelRideUseCase(repo).call('ride-1');

    expect(
      repo.seenToken,
      isNotNull,
      reason: 'without the token in flight, cancelling the request is a no-op',
    );
  });
}
