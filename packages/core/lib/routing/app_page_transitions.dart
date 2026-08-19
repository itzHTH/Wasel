import 'package:flutter/material.dart';

class AppPageTransitions {
  AppPageTransitions._();

  static const Duration _forward = Duration(milliseconds: 320);
  static const Duration _reverse = Duration(milliseconds: 260);

  /// Fade combined with a short directional slide. The slide follows the
  /// ambient Directionality, so it reads correctly in the Arabic RTL layout.
  static Route<T> sharedAxis<T>(
    Widget page, {
    RouteSettings? settings,
    Offset beginOffset = const Offset(0.06, 0),
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: _forward,
      reverseTransitionDuration: _reverse,
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: beginOffset,
              end: Offset.zero,
            ).animate(curved),
            textDirection: Directionality.of(context),
            child: child,
          ),
        );
      },
    );
  }
}
