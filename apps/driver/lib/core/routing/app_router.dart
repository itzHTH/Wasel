import 'package:flutter/material.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/features/auth/ui/screens/login_screen.dart';
import 'package:driver/features/auth/ui/screens/register_screen.dart';
import 'package:driver/features/driver_verification/ui/screens/verification_placeholder_screen.dart';
import 'package:driver/features/home/ui/screens/home_screen.dart';
import 'package:driver/features/splash/ui/screens/splash_screen.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.auth:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case AppRoutes.driverVerification:
        return MaterialPageRoute(
          builder: (_) => const VerificationPlaceholderScreen(),
        );

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
