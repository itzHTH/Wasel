import 'package:driver/features/ride/data/models/foreground/foreground_notification_arg.dart';
import 'package:driver/features/ride/data/services/driver_foreground_service.dart';
import 'package:driver/features/ride/domain/entities/foreground_status.dart';
import 'package:driver/features/ride/domain/repo/base_driver_foreground_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/api_error_reason.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';

part 'driver_foreground_repo.g.dart';

class DriverForegroundRepo implements BaseDriverForegroundRepo {
  DriverForegroundRepo(this._service);

  final IDriverForegroundService _service;

  @override
  Future<ForegroundStatus> ensureReady() => _service.ensureReady();

  @override
  Future<bool> ensureUnrestricted() => _service.ensureUnrestricted();

  @override
  Future<ApiResults<void>> startService(
    ForegroundNotificationArg notification,
  ) => _run(() => _service.startService(notification));

  @override
  Future<ApiResults<void>> updateNotification(
    ForegroundNotificationArg notification,
  ) => _run(() => _service.updateService(notification));

  @override
  Future<ApiResults<void>> stopService() => _run(_service.stopService);

  @override
  Future<bool> isRunning() => _service.isRunning;

  Future<ApiResults<void>> _run(Future<void> Function() action) async {
    try {
      await action();
      return ApiResults.success(null);
    } catch (_) {
      return ApiResults.failure(
        ErrorHandler.reason(ApiErrorReason.foregroundServiceUnavailable),
      );
    }
  }
}

@riverpod
DriverForegroundRepo driverForegroundRepo(Ref ref) {
  final service = ref.watch(driverForegroundServiceProvider);
  return DriverForegroundRepo(service);
}
