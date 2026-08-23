import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_auth/auth_user_type.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/driver_app.dart';
import 'package:driver/firebase_options.dart';
import 'package:wasel_core/theme/app_map_style.dart';
import 'package:wasel_core/wasel_core.dart';

void mainCommon({
  required Flavor flavor,
  required String appName,
  required String baseUrl,
}) async {
  FlavorConfig(flavor: flavor, appName: appName, baseUrl: baseUrl);
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // The shared auth interceptor (wasel_core) is app-agnostic, but the app-specific navigation is injected here.
  // The whole stack is dropped so no authed screen stays reachable via back.
  AuthInterceptor.onSessionExpired = () => AppNavigation.maybeNavigator
      ?.pushNamedAndRemoveUntil(AppRoutes.auth, (route) => false);

  // Restored before the first frame so a cold start never flashes the wrong
  // theme — AppLocalCache has no synchronous read.
  final themeMode = await ThemeModeController.restore();
  await AppMapStyle.preload();

  final locale = await AppLocalizationController.restore();

  runApp(
    ProviderScope(
      overrides: [
        // Points the shared registration flow at the driver endpoints, and the
        // shared theme at the driver palette.
        authUserTypeProvider.overrideWithValue(AuthUserType.driver),
        appBrandProvider.overrideWithValue(AppBrand.driver),
        initialThemeModeProvider.overrideWithValue(themeMode),
        initialLocaleProvider.overrideWithValue(locale),
      ],
      child: const DriverApp(),
    ),
  );
}
