import 'package:flutter/foundation.dart';

class AppConstants {
  static const String appName = 'Wasel';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Taxi Client App';

  // Local Cache Keys
  static const String tokenKey = 'token';
  static const String refreshTokenKey = 'refreshToken';
  static const String refreshTokenExpirationKey = 'refreshTokenExpiration';
  static const String isFirstTimeKey = 'isFirstTime';
  static const String themeModeKey = 'themeMode';

  static const List<String> sessionKeys = [
    tokenKey,
    refreshTokenKey,
    refreshTokenExpirationKey,
  ];

  static const bool isDebug = kDebugMode;
}
