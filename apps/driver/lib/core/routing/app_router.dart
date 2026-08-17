import 'package:driver/features/driver_verification/ui/screens/verification_wizard_screen.dart';
import 'package:driver/features/profile/ui/screens/profile_details_screen.dart';
import 'package:driver/features/profile/ui/screens/profile_screen.dart';
import 'package:driver/features/ride/ui/screens/ride_screen.dart';
import 'package:flutter/material.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/features/auth/ui/screens/login_screen.dart';
import 'package:driver/features/auth/ui/screens/register_screen.dart';
import 'package:driver/features/auth/ui/screens/reset_password_screen.dart';
import 'package:driver/features/driver_verification/ui/screens/verification_gate_screen.dart';
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

      case AppRoutes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      case AppRoutes.driverVerificationGate:
        return MaterialPageRoute(
          builder: (_) => const VerificationGateScreen(),
        );

      case AppRoutes.driverVerificationWizard:
        return MaterialPageRoute(
          builder: (_) => const VerificationWizardScreen(),
        );

      case AppRoutes.ride:
        return MaterialPageRoute(builder: (_) => const RideScreen());

      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case AppRoutes.profileDetails:
        return MaterialPageRoute(builder: (_) => const ProfileDetailsScreen());

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
