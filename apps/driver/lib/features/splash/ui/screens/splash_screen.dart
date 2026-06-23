import 'package:flutter/material.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

/// Placeholder driver splash. Phase 4 will add the real auth/session gating
/// (check stored token -> home or auth) mirroring the rider splash.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    });
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
