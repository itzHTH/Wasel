import 'dart:io';

import 'package:driver/features/ride/data/models/foreground/foreground_notification_arg.dart';
import 'package:driver/features/ride/data/services/driver_foreground_helper.dart';
import 'package:driver/features/ride/domain/entities/foreground_service_exception.dart';
import 'package:driver/features/ride/domain/entities/foreground_status.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'driver_foreground_service.g.dart';

abstract class IDriverForegroundService {
  Future<ForegroundStatus> ensureReady();
  Future<bool> ensureUnrestricted();
  Future<void> startService(ForegroundNotificationArg notification);
  Future<void> updateService(ForegroundNotificationArg notification);
  Future<void> stopService();
  Future<bool> get isRunning;
}

class DriverForegroundService implements IDriverForegroundService {
  static const _channelId = 'driver_shift';
  static const _iconMetaData =
      'com.zimiru.wasel.driver.service.NOTIFICATION_ICON';

  final bool _isAndroid = Platform.isAndroid;

  bool _initialized = false;

  @override
  Future<bool> get isRunning => FlutterForegroundTask.isRunningService;

  @override
  Future<ForegroundStatus> ensureReady() async {
    if (!_isAndroid) return ForegroundStatus.unsupported;

    var permission = await FlutterForegroundTask.checkNotificationPermission();

    if (permission == NotificationPermission.denied) {
      permission = await FlutterForegroundTask.requestNotificationPermission();
    }

    return switch (permission) {
      NotificationPermission.granted => ForegroundStatus.ready,
      NotificationPermission.permanently_denied =>
        ForegroundStatus.notificationsBlocked,
      _ => ForegroundStatus.notificationsDenied,
    };
  }

  @override
  Future<bool> ensureUnrestricted() async {
    if (!_isAndroid) return true;
    if (await FlutterForegroundTask.isIgnoringBatteryOptimizations) return true;

    return FlutterForegroundTask.requestIgnoreBatteryOptimization();
  }

  @override
  Future<void> startService(ForegroundNotificationArg notification) async {
    if (!_isAndroid) return;
    _initialize(notification);
    if (await isRunning) return updateService(notification);

    final result = await FlutterForegroundTask.startService(
      serviceTypes: [ForegroundServiceTypes.location],
      notificationTitle: notification.title,
      notificationText: notification.body,
      notificationIcon: const NotificationIcon(metaDataName: _iconMetaData),
      callback: startShiftCallback,
    );

    if (result is! ServiceRequestFailure) return;
    if (result.error is ServiceAlreadyStartedException) {
      return updateService(notification);
    }

    throw ForegroundServiceException(result.error);
  }

  @override
  Future<void> updateService(ForegroundNotificationArg notification) async {
    if (!_isAndroid) return;
    _initialize(notification);
    if (!await isRunning) return;

    _throwUnlessStopped(
      await FlutterForegroundTask.updateService(
        notificationTitle: notification.title,
        notificationText: notification.body,
        notificationIcon: const NotificationIcon(metaDataName: _iconMetaData),
      ),
    );
  }

  @override
  Future<void> stopService() async {
    if (!_isAndroid || !await isRunning) return;

    _throwUnlessStopped(await FlutterForegroundTask.stopService());
  }

  void _throwUnlessStopped(ServiceRequestResult result) {
    if (result is! ServiceRequestFailure) return;
    if (result.error is ServiceNotStartedException) return;

    throw ForegroundServiceException(result.error);
  }

  void _initialize(ForegroundNotificationArg notification) {
    if (_initialized) return;
    _initialized = true;

    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: _channelId,
        channelName: notification.channelName,
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
      ),
      iosNotificationOptions: const IOSNotificationOptions(),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.nothing(),
        allowWakeLock: true,
        allowWifiLock: true,
        autoRunOnBoot: false,
        autoRunOnMyPackageReplaced: false,
      ),
    );
  }
}

@riverpod
IDriverForegroundService driverForegroundService(Ref ref) =>
    DriverForegroundService();
