import 'package:driver/features/ride/data/models/foreground/foreground_notification_arg.dart';
import 'package:driver/features/ride/domain/entities/foreground_status.dart';
import 'package:wasel_core/networking/api_results.dart';

abstract class BaseDriverForegroundRepo {
  Future<ForegroundStatus> ensureReady();
  Future<bool> ensureUnrestricted();
  Future<ApiResults<void>> startService(ForegroundNotificationArg notification);
  Future<ApiResults<void>> updateNotification(
    ForegroundNotificationArg notification,
  );
  Future<ApiResults<void>> stopService();
  Future<bool> isRunning();
}
