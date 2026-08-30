import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

/// The animated brand lockup both splashes share. [onCompleted] fires when the
/// sequence lands, so a fast redirect never cuts the branding off mid-animation.
class AppSplashBranding extends StatefulWidget {
  const AppSplashBranding({
    super.key,
    required this.logoAsset,
    required this.label,
    required this.onCompleted,
  });

  final String logoAsset;
  final String label;
  final VoidCallback onCompleted;

  @override
  State<AppSplashBranding> createState() => _AppSplashBrandingState();
}

class _AppSplashBrandingState extends State<AppSplashBranding>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _labelOpacity;
  late final Animation<Offset> _labelSlide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _logoScale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    _labelOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.85, curve: Curves.easeIn),
      ),
    );

    _labelSlide = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.45, 0.9, curve: Curves.easeOutCubic),
          ),
        );

    _controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) widget.onCompleted();
      })
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FadeTransition(
          opacity: _logoOpacity,
          child: ScaleTransition(
            scale: _logoScale,
            child: SvgPicture.asset(
              widget.logoAsset,
              height: AppDimens.icon100,
            ),
          ),
        ),
        const SizedBox(height: 10),
        FadeTransition(
          opacity: _labelOpacity,
          child: SlideTransition(
            position: _labelSlide,
            child: Text(
              widget.label,
              style: context.styles.displayLarge().copyWith(
                color: context.colors.secondary900,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
