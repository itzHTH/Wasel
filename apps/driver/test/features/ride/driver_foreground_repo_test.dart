import 'package:driver/features/ride/data/models/foreground/foreground_notification_arg.dart';
import 'package:driver/features/ride/data/models/foreground/ride_alert_arg.dart';
import 'package:driver/features/ride/data/repos/driver_foreground_repo.dart';
import 'package:driver/features/ride/data/services/driver_foreground_service.dart';
import 'package:driver/features/ride/data/services/ride_alert_service.dart';
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

class _FakeAlertService implements IRideAlertService {
  _FakeAlertService({this.error});

  final Object? error;

  RideAlertArg? shown;
  int clearCalls = 0;

  @override
  Future<void> showOffer(RideAlertArg alert) async {
    shown = alert;
    if (error != null) throw error!;
  }

  @override
  Future<void> clearOffer() async {
    clearCalls++;
    if (error != null) throw error!;
  }
}

DriverForegroundRepo _repo(
  _FakeForegroundService service, [
  _FakeAlertService? alerts,
]) => DriverForegroundRepo(service, alerts ?? _FakeAlertService());

const _alert = RideAlertArg(
  channelName: 'طلبات الرحلات',
  channelDescription: 'تنبيه صوتي عند وصول طلب رحلة جديد',
  title: 'طلب رحلة جديد',
  body: 'افتح التطبيق وقبل الطلب',
);

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
      final repo = _repo(service);

      final result = await repo.startService(_notification);

      expect(result, isA<Success<void>>());
      expect(service.seenNotification, same(_notification));
    });

    test('catches a service failure at the boundary', () async {
      final repo = _repo(_FakeForegroundService(
          error: const ForegroundServiceException('denied')),
      );

      final result = await repo.startService(_notification);

      expect(result, isA<Failure<void>>());
      expect(_reasonOf(result), ApiErrorReason.foregroundServiceUnavailable);
    });

    test('catches an unexpected error the same way', () async {
      final repo = _repo(_FakeForegroundService(error: StateError('boom')),
      );

      expect(await repo.startService(_notification), isA<Failure<void>>());
    });
  });

  group('stopService', () {
    test('reports success', () async {
      final service = _FakeForegroundService(running: true);
      final repo = _repo(service);

      expect(await repo.stopService(), isA<Success<void>>());
      expect(service.stopCalls, 1);
    });

    test('catches a service failure at the boundary', () async {
      final repo = _repo(_FakeForegroundService(error: const ForegroundServiceException(null)),
      );

      final result = await repo.stopService();

      expect(_reasonOf(result), ApiErrorReason.foregroundServiceUnavailable);
    });
  });

  group('updateNotification', () {
    test('forwards the notification and reports success', () async {
      final service = _FakeForegroundService(running: true);
      final repo = _repo(service);

      expect(
        await repo.updateNotification(_notification),
        isA<Success<void>>(),
      );
      expect(service.seenNotification, same(_notification));
    });
  });

  group('pass-through reads', () {
    test('ensureReady returns the platform status unchanged', () async {
      final repo = _repo(_FakeForegroundService(status: ForegroundStatus.notificationsBlocked));

      expect(await repo.ensureReady(), ForegroundStatus.notificationsBlocked);
    });

    test('ensureUnrestricted returns the platform answer', () async {
      final repo = _repo(_FakeForegroundService(unrestricted: false));

      expect(await repo.ensureUnrestricted(), isFalse);
    });

    test('isRunning returns the platform answer', () async {
      final repo = _repo(_FakeForegroundService(running: true));

      expect(await repo.isRunning(), isTrue);
    });
  });

  group('use cases', () {
    test('EnsureForegroundReadyUseCase delegates to the repo', () async {
      final useCase = EnsureForegroundReadyUseCase(
        _repo(_FakeForegroundService(status: ForegroundStatus.unsupported)),
      );

      expect(await useCase.call(null), ForegroundStatus.unsupported);
    });

    test('StartForegroundServiceUseCase carries the failure through', () async {
      final useCase = StartForegroundServiceUseCase(
        _repo(_FakeForegroundService(
            error: const ForegroundServiceException('denied')),
        ),
      );

      expect(await useCase.call(_notification), isA<Failure<void>>());
    });

    test('StopForegroundServiceUseCase carries the success through', () async {
      final useCase = StopForegroundServiceUseCase(
        _repo(_FakeForegroundService(running: true)),
      );

      expect(await useCase.call(null), isA<Success<void>>());
    });
  });
  group('offer alerts', () {
    test('forwards the alert and reports success', () async {
      final alerts = _FakeAlertService();
      final repo = _repo(_FakeForegroundService(), alerts);

      expect(await repo.alertOffer(_alert), isA<Success<void>>());
      expect(alerts.shown, same(_alert));
    });

    test('catches an alert failure at the boundary', () async {
      final repo = _repo(
        _FakeForegroundService(),
        _FakeAlertService(error: StateError('no channel')),
      );

      final result = await repo.alertOffer(_alert);

      expect(_reasonOf(result), ApiErrorReason.foregroundServiceUnavailable);
    });

    test('clearing the alert reaches the platform', () async {
      final alerts = _FakeAlertService();
      final repo = _repo(_FakeForegroundService(), alerts);

      expect(await repo.clearOfferAlert(), isA<Success<void>>());
      expect(alerts.clearCalls, 1);
    });
  });
}
