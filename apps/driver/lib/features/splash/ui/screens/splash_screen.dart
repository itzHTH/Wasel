import 'package:driver/core/const/app_driver_consts.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:wasel_core/helpers/session_store.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_splash_branding.dart';

/// Driver splash. Once the brand lockup lands it gates on the stored session:
/// an unexpired token + refresh token -> home, otherwise -> auth.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _handleIsAuthenticatedUser() async {
    final hasSession = await SessionStore.hasUsableSession();
    if (!hasSession) await SessionStore.clear();

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      hasSession ? AppRoutes.driverVerificationGate : AppRoutes.auth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.splashBackground,
      body: Center(
        child: AppSplashBranding(
          logoAsset: AppDriverConsts.logoIcon,
          label: context.l10n.brandName,
          onCompleted: _handleIsAuthenticatedUser,
        ),
      ),
    );
  }
}
