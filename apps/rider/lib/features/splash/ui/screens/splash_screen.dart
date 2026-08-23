import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasel_core/helpers/session_store.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_splash_branding.dart';
import 'package:wasal/core/consts/app_icons.dart';
import 'package:wasal/core/routing/app_routes_name.dart';

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
      hasSession ? AppRoutes.ride : AppRoutes.auth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.splashBackground,
      body: Center(
        child: AppSplashBranding(
          logoAsset: AppIcons.logo,
          label: context.l10n.brandName,
          onCompleted: _handleIsAuthenticatedUser,
        ),
      ),
    );
  }
}
