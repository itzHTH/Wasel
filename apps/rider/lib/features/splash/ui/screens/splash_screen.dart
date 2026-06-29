import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wasel_core/const/app_constants.dart';
import 'package:wasel_core/extensions/navigation_extension.dart';
import 'package:wasel_core/helpers/app_local_cache.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _iconScale;
  late final Animation<double> _iconOpacity;
  late final Animation<double> _textOpacity;
  late final Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _iconScale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _iconOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.85, curve: Curves.easeIn),
      ),
    );

    _textSlide = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.45, 0.9, curve: Curves.easeOutCubic),
          ),
        );

    _controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          handleIsAuthenticatedUser();
        }
      })
      ..forward();
  }

  void handleIsAuthenticatedUser() async {
    final token = await AppLocalCache.getSecuredString(AppConstants.tokenKey);
    final refreshToken = await AppLocalCache.getSecuredString(
      AppConstants.refreshTokenKey,
    );

    if (token != null && refreshToken != null) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.ride);
    } else {
      if (!mounted) return;
      context.pushReplacementNamed(AppRoutes.auth);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary900,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _iconOpacity,
              child: ScaleTransition(
                scale: _iconScale,
                child: SvgPicture.asset("assets/icons/wasel-icon.svg"),
              ),
            ),
            const SizedBox(height: 10),
            FadeTransition(
              opacity: _textOpacity,
              child: SlideTransition(
                position: _textSlide,
                child: Text("وَصَل", style: AppTextStyles.font48Neutral0Bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
