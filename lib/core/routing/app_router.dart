import 'package:flutter/material.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasal/features/auth/ui/screens/auth_screen.dart';
import 'package:wasal/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:wasal/features/home/ui/screens/home_screen.dart';
import 'package:wasal/features/splash/ui/screens/splash_screen.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.auth:
        return MaterialPageRoute(builder: (_) => const AuthScreen());

      case AppRoutes.otpVerification:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            email: args['email'] ?? '',
            registrationToken: args['registrationToken'] ?? '',
          ),
        );

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
