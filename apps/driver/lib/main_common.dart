import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart'
    show LocationSettings, LocationAccuracy, AppleSettings, ActivityType;
import 'package:wasel_auth/auth_user_type.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/driver_app.dart';
import 'package:driver/firebase_options.dart';
import 'package:wasel_core/theme/app_map_style.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:wasel_location/data/services/device_location_service.dart';

void mainCommon({
  required Flavor flavor,
  required String appName,
  required String baseUrl,
}) async {
  FlavorConfig(flavor: flavor, appName: appName, baseUrl: baseUrl);
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = (FlutterErrorDetails details) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppNavigation.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        AppRoutes.error,
        (route) => false,
      );
    });
  };

  /// Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppNavigation.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        AppRoutes.error,
        (route) => false,
      );
    });

    return true;
  };
  // The shared auth interceptor (wasel_core) is app-agnostic, but the app-specific navigation is injected here.
  // The whole stack is dropped so no authed screen stays reachable via back.
  AuthInterceptor.onSessionExpired = () => AppNavigation.maybeNavigator
      ?.pushNamedAndRemoveUntil(AppRoutes.auth, (route) => false);

  // Restored before the first frame so a cold start never flashes the wrong
  // theme — AppLocalCache has no synchronous read.
  final themeMode = await ThemeModeController.restore();
  await AppMapStyle.preload();

  final locale = await AppLocalizationController.restore();

  final trackingSettings = (defaultTargetPlatform == TargetPlatform.iOS)
      ? AppleSettings(
          accuracy: LocationAccuracy.high,
          activityType: ActivityType.automotiveNavigation,
          distanceFilter: 10,
          pauseLocationUpdatesAutomatically: false,
          showBackgroundLocationIndicator: true,
        )
      : LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);

  runApp(
    ProviderScope(
      overrides: [
        // Points the shared registration flow at the driver endpoints, and the
        // shared theme at the driver palette.
        authUserTypeProvider.overrideWithValue(AuthUserType.driver),
        appBrandProvider.overrideWithValue(AppBrand.driver),
        initialThemeModeProvider.overrideWithValue(themeMode),
        initialLocaleProvider.overrideWithValue(locale),
        trackingSettingsProvider.overrideWithValue(trackingSettings),
      ],
      child: const DriverApp(),
    ),
  );
}
