import 'package:wasel_auth/wasel_auth.dart';
import 'package:driver/features/driver_earnings/ui/screens/driver_earnings_screen.dart';
import 'package:driver/features/driver_verification/ui/screens/verification_wizard_screen.dart';
import 'package:driver/features/profile/ui/screens/profile_details_screen.dart';
import 'package:driver/features/profile/ui/screens/profile_edit_screen.dart';
import 'package:driver/features/profile/ui/screens/profile_screen.dart';
import 'package:driver/features/ride/ui/screens/ride_screen.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/routing/app_page_transitions.dart';
import 'package:wasel_rides/presentation/screens/ride_history_screen.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/features/auth/ui/screens/login_screen.dart';
import 'package:driver/features/auth/ui/screens/register_screen.dart';
import 'package:driver/features/driver_verification/ui/screens/verification_gate_screen.dart';
import 'package:driver/features/splash/ui/screens/splash_screen.dart';

import 'package:wasel_core/widgets/feedback/app_error_screen.dart';

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
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(doneRoute: AppRoutes.auth),
        );

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

      case AppRoutes.profileEdit:
        return AppPageTransitions.sharedAxis(
          const ProfileEditScreen(),
          settings: settings,
        );

      case AppRoutes.rideHistory:
        return AppPageTransitions.sharedAxis(
          const RideHistoryScreen(),
          settings: settings,
        );

      case AppRoutes.earnings:
        return AppPageTransitions.sharedAxis(
          const DriverEarningsScreen(),
          settings: settings,
        );

      case AppRoutes.error:
        return MaterialPageRoute(builder: (_) => AppErrorScreen());

      default:
        return MaterialPageRoute(builder: (_) => AppErrorScreen());
    }
  }
}
