import 'package:flutter/material.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/features/home/ui/screens/home_screen.dart';
import 'package:driver/features/splash/ui/screens/splash_screen.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      // TODO(Phase 4): wire AppRoutes.auth / register to the driver auth screens.

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
