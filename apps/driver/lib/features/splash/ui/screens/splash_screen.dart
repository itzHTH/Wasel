import 'package:flutter/material.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:wasel_core/const/app_constants.dart';
import 'package:wasel_core/helpers/app_local_cache.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

/// Driver splash. After a short branding delay it gates on the stored session:
/// a valid token + refresh token -> home, otherwise -> auth.
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
    final token = await AppLocalCache.getSecuredString(AppConstants.tokenKey);
    final refreshToken = await AppLocalCache.getSecuredString(
      AppConstants.refreshTokenKey,
    );

    if (!mounted) return;

    final isLoggedIn =
        token != null &&
        token.isNotEmpty &&
        refreshToken != null &&
        refreshToken.isNotEmpty;

    Navigator.pushReplacementNamed(
      context,
      isLoggedIn ? AppRoutes.home : AppRoutes.auth,
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
