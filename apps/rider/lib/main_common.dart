import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';
import 'package:wasel_core/theme/app_map_style.dart';
import 'package:wasel_core/helpers/app_navigation.dart';
import 'package:wasel_core/networking/interceptors/auth_interceptor.dart';
import 'package:wasal/core/observers/logger_observer.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasal/firebase_options.dart';
import 'package:wasel_core/flavors/flavors_config.dart';
import 'package:wasel_core/theme/providers/theme_mode_provider.dart';
import 'package:wasal/wasal_app.dart';

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

  // The shared auth interceptor (wasel_core) is app-agnostic; tell it how this
  // app should react to a non-refreshable session (forced logout → auth screen).
  // The whole stack is dropped so no authed screen stays reachable via back.
  AuthInterceptor.onSessionExpired = () => AppNavigation.maybeNavigator
      ?.pushNamedAndRemoveUntil(AppRoutes.auth, (route) => false);

  // Restored before the first frame so a cold start never flashes the wrong
  // theme
  final themeMode = await ThemeModeController.restore();
  await AppMapStyle.preload();

  final locale = await AppLocalizationController.restore();

  runApp(
    ProviderScope(
      // Provider lifecycle logging in debug builds only; release stays silent.
      observers: kDebugMode ? const [LoggerObserver()] : const [],
      overrides: [
        initialThemeModeProvider.overrideWithValue(themeMode),
        initialLocaleProvider.overrideWithValue(locale),
      ],
      child: const WasalApp(),
    ),
  );
}
