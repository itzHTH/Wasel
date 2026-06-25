import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/helpers/app_navigation.dart';
import 'package:wasel_core/networking/interceptors/auth_interceptor.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasal/firebase_options.dart';
import 'package:wasel_core/flavors/flavors_config.dart';
import 'package:wasal/wasal_app.dart';

void mainCommon({
  required Flavor flavor,
  required String appName,
  required String baseUrl,
}) async {
  FlavorConfig(flavor: flavor, appName: appName, baseUrl: baseUrl);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // The shared auth interceptor (wasel_core) is app-agnostic; tell it how this
  // app should react to a non-refreshable session (forced logout → auth screen).
  AuthInterceptor.onSessionExpired = () =>
      AppNavigation.pushReplacementNamed(AppRoutes.auth);

  runApp(const ProviderScope(child: WasalApp()));
}
