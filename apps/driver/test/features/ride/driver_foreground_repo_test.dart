import 'package:driver/features/ride/data/models/foreground/foreground_notification_arg.dart';
import 'package:driver/features/ride/data/repos/driver_foreground_repo.dart';
import 'package:driver/features/ride/data/services/driver_foreground_service.dart';
import 'package:driver/features/ride/domain/entities/foreground_service_exception.dart';
import 'package:driver/features/ride/domain/entities/foreground_status.dart';
import 'package:driver/features/ride/domain/use_case/ensure_foreground_ready_use_case.dart';
import 'package:driver/features/ride/domain/use_case/start_foreground_service_use_case.dart';
import 'package:driver/features/ride/domain/use_case/stop_foreground_service_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/api_error_reason.dart';

/// Stands in for the platform adapter, so the repo's error boundary can be
/// exercised without a foreground service.
class _FakeForegroundService implements IDriverForegroundService {
  _FakeForegroundService({
    this.status = ForegroundStatus.ready,
    this.unrestricted = true,
    this.running = false,
    this.error,
  });

  final ForegroundStatus status;
  final bool unrestricted;
  final bool running;
  final Object? error;

  ForegroundNotificationArg? seenNotification;
  int stopCalls = 0;

  @override
  Future<ForegroundStatus> ensureReady() async => status;

  @override
  Future<bool> ensureUnrestricted() async => unrestricted;

  @override
  Future<bool> get isRunning async => running;

  @override
  Future<void> startService(ForegroundNotificationArg notification) async {
    seenNotification = notification;
    if (error != null) throw error!;
  }

  @override
  Future<void> updateService(ForegroundNotificationArg notification) async {
    seenNotification = notification;
    if (error != null) throw error!;
  }

  @override
  Future<void> stopService() async {
    stopCalls++;
    if (error != null) throw error!;
  }
}

const _notification = ForegroundNotificationArg(
  channelName: 'وضع القيادة',
  title: 'متصل',
  body: 'بانتظار الطلبات',
);

ApiErrorReason? _reasonOf(ApiResults<void> result) {
  ApiErrorReason? reason;
  result.when(
    success: (_) {},
    failure: (error) => reason = error.apiErrorModel.reason,
  );
  return reason;
}

void main() {
  group('startService', () {
    test('reports success and forwards the notification untouched', () async {
      final service = _FakeForegroundService();
      final repo = DriverForegroundRepo(service);

      final result = await repo.startService(_notification);

      expect(result, isA<Success<void>>());
      expect(service.seenNotification, same(_notification));
    });

    test('catches a service failure at the boundary', () async {
      final repo = DriverForegroundRepo(
        _FakeForegroundService(
          error: const ForegroundServiceException('denied'),
        ),
      );

      final result = await repo.startService(_notification);

      expect(result, isA<Failure<void>>());
      expect(_reasonOf(result), ApiErrorReason.foregroundServiceUnavailable);
    });

    test('catches an unexpected error the same way', () async {
      final repo = DriverForegroundRepo(
        _FakeForegroundService(error: StateError('boom')),
      );

      expect(await repo.startService(_notification), isA<Failure<void>>());
    });
  });

  group('stopService', () {
    test('reports success', () async {
      final service = _FakeForegroundService(running: true);
      final repo = DriverForegroundRepo(service);

      expect(await repo.stopService(), isA<Success<void>>());
      expect(service.stopCalls, 1);
    });

    test('catches a service failure at the boundary', () async {
      final repo = DriverForegroundRepo(
        _FakeForegroundService(error: const ForegroundServiceException(null)),
      );

      final result = await repo.stopService();

      expect(_reasonOf(result), ApiErrorReason.foregroundServiceUnavailable);
    });
  });

  group('updateNotification', () {
    test('forwards the notification and reports success', () async {
      final service = _FakeForegroundService(running: true);
      final repo = DriverForegroundRepo(service);

      expect(
        await repo.updateNotification(_notification),
        isA<Success<void>>(),
      );
      expect(service.seenNotification, same(_notification));
    });
  });

  group('pass-through reads', () {
    test('ensureReady returns the platform status unchanged', () async {
      final repo = DriverForegroundRepo(
        _FakeForegroundService(status: ForegroundStatus.notificationsBlocked),
      );

      expect(await repo.ensureReady(), ForegroundStatus.notificationsBlocked);
    });

    test('ensureUnrestricted returns the platform answer', () async {
      final repo = DriverForegroundRepo(
        _FakeForegroundService(unrestricted: false),
      );

      expect(await repo.ensureUnrestricted(), isFalse);
    });

    test('isRunning returns the platform answer', () async {
      final repo = DriverForegroundRepo(_FakeForegroundService(running: true));

      expect(await repo.isRunning(), isTrue);
    });
  });

  group('use cases', () {
    test('EnsureForegroundReadyUseCase delegates to the repo', () async {
      final useCase = EnsureForegroundReadyUseCase(
        DriverForegroundRepo(
          _FakeForegroundService(status: ForegroundStatus.unsupported),
        ),
      );

      expect(await useCase.call(null), ForegroundStatus.unsupported);
    });

    test('StartForegroundServiceUseCase carries the failure through', () async {
      final useCase = StartForegroundServiceUseCase(
        DriverForegroundRepo(
          _FakeForegroundService(
            error: const ForegroundServiceException('denied'),
          ),
        ),
      );

      expect(await useCase.call(_notification), isA<Failure<void>>());
    });

    test('StopForegroundServiceUseCase carries the success through', () async {
      final useCase = StopForegroundServiceUseCase(
        DriverForegroundRepo(_FakeForegroundService(running: true)),
      );

      expect(await useCase.call(null), isA<Success<void>>());
    });
  });
}
