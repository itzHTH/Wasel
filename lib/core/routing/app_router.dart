import 'package:flutter/material.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasal/features/splash/ui/screens/splash_screen.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
