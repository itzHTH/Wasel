import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_auth/auth_user_type.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/driver_app.dart';
import 'package:driver/firebase_options.dart';
import 'package:wasel_core/wasel_core.dart';

void mainCommon({
  required Flavor flavor,
  required String appName,
  required String baseUrl,
}) async {
  FlavorConfig(flavor: flavor, appName: appName, baseUrl: baseUrl);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // The shared auth interceptor (wasel_core) is app-agnostic, but the app-specific navigation is injected here.
  AuthInterceptor.onSessionExpired = () =>
      AppNavigation.pushReplacementNamed(AppRoutes.auth);

  // Point the shared registration flow at the driver endpoints. This single
  runApp(
    ProviderScope(
      overrides: [authUserTypeProvider.overrideWithValue(AuthUserType.driver)],
      child: const DriverApp(),
    ),
  );
}
