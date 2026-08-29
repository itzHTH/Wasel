import 'dart:io';

import 'package:driver/features/ride/data/models/foreground/ride_alert_arg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart'
    hide NotificationVisibility;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ride_alert_service.g.dart';

abstract class IRideAlertService {
  Future<void> showOffer(RideAlertArg alert);
  Future<void> clearOffer();
}

class RideAlertService implements IRideAlertService {
  static const _channelId = 'ride_offer';
  static const _notificationId = 1001;
  static const _icon = 'ic_notification';

  /// Matches RideController.offerSeconds
  static const _offerWindow = Duration(seconds: 30);

  final _plugin = FlutterLocalNotificationsPlugin();

  Future<void>? _initialization;

  @override
  Future<void> showOffer(RideAlertArg alert) async {
    if (!Platform.isAndroid && !Platform.isIOS) return;

    await _initialize();
    debugPrint('🔔 showing offer notification on channel $_channelId');

    await _plugin.show(
      id: _notificationId,
      title: alert.title,
      body: alert.body,
      notificationDetails: NotificationDetails(
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          presentBanner: true,
          presentList: true,
          interruptionLevel: InterruptionLevel.timeSensitive,
        ),
        android: AndroidNotificationDetails(
          _channelId,
          alert.channelName,
          channelDescription: alert.channelDescription,
          icon: _icon,
          importance: Importance.max,
          priority: Priority.high,
          category: AndroidNotificationCategory.call,
          fullScreenIntent: true,
          visibility: NotificationVisibility.public,
          playSound: true,
          audioAttributesUsage: AudioAttributesUsage.alarm,
          enableVibration: true,
          vibrationPattern: Int64List.fromList(const [0, 500, 250, 500]),
          timeoutAfter: _offerWindow.inMilliseconds,
          ticker: alert.title,
        ),
      ),
    );

    // the Android foreground service wakes the screen, but the iOS one does not.
    if (Platform.isAndroid) {
      FlutterForegroundTask.wakeUpScreen();
      debugPrint('🔔 offer notification shown, screen woken');
    }
  }

  @override
  Future<void> clearOffer() async {
    if (_initialization == null) return;

    await _plugin.cancel(id: _notificationId);
  }

  /// Latched only on success, and shared by concurrent callers: a failed
  /// init that stuck would leave the tap handler unregistered for the life of
  /// the process, so every later alert would post but do nothing when tapped.
  Future<void> _initialize() {
    return _initialization ??= _plugin
        .initialize(
          settings: const InitializationSettings(
            android: AndroidInitializationSettings(_icon),
            iOS: DarwinInitializationSettings(
              requestAlertPermission: false,
              requestBadgePermission: false,
              requestSoundPermission: false,
            ),
          ),
          onDidReceiveNotificationResponse: (_) =>
              FlutterForegroundTask.launchApp(),
        )
        .then((_) {})
        .onError((error, stackTrace) {
          _initialization = null;
          Error.throwWithStackTrace(error!, stackTrace);
        });
  }
}

@riverpod
IRideAlertService rideAlertService(Ref ref) => RideAlertService();
