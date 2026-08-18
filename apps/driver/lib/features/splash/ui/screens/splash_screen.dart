import 'package:flutter/material.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:wasel_core/helpers/session_store.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

/// Driver splash. After a short branding delay it gates on the stored session:
/// an unexpired token + refresh token -> home, otherwise -> auth.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), _handleIsAuthenticatedUser);
  }

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
      backgroundColor: AppColor.secondary900,
      body: Center(
        child: Text("وَصَل سائق", style: AppTextStyles.font48Neutral0Bold),
      ),
    );
  }
}
