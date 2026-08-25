import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/ride/ride_search_motion.dart';

/// The brand mark waiting on background work — rings breaking off the logo on
/// the same heartbeat the search radar uses, so a wait reads as the app
/// thinking rather than as a stalled spinner.
class AppBrandPulse extends StatefulWidget {
  const AppBrandPulse({
    super.key,
    required this.logoAsset,
    this.size,
    this.color,
  });

  /// The app's own brand mark; each app passes its own.
  final String logoAsset;

  final double? size;
  final Color? color;

  @override
  State<AppBrandPulse> createState() => _AppBrandPulseState();
}

class _AppBrandPulseState extends State<AppBrandPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: RideSearchMotion.pulsePeriod,
    )..repeat();
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size ?? AppDimens.brandPulse;
    // Resolved here rather than in the painter, which sits outside the tree.
    final color = widget.color ?? context.colors.primary500;

    return ExcludeSemantics(
      child: SizedBox.square(
        dimension: size,
        child: AnimatedBuilder(
          animation: _pulse,
          // The logo is passed through rather than rebuilt on every frame.
          child: SvgPicture.asset(
            widget.logoAsset,
            width: size * _logoFraction,
            height: size * _logoFraction,
          ),
          builder: (context, child) {
            final breath = (1 - math.sin(2 * math.pi * _pulse.value)) / 2;

            return CustomPaint(
              painter: _BrandPulsePainter(phase: _pulse.value, color: color),
              child: Center(
                child: Transform.scale(
                  scale: 1 - _breathDepth * breath,
                  child: child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// How much of the canvas the mark itself takes up, leaving the rest for rings.
const _logoFraction = 0.42;

/// How far the mark shrinks at the bottom of its breath.
const _breathDepth = 0.06;

class _BrandPulsePainter extends CustomPainter {
  const _BrandPulsePainter({required this.phase, required this.color});

  final double phase;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    final maxRadius = math.min(size.width, size.height) / 2;
    final haloRadius = maxRadius * _logoFraction * 1.6;
    final strokeWidth = maxRadius / 14;

    // A soft disc so the mark sits on the brand rather than on the background.
    canvas.drawCircle(
      center,
      haloRadius,
      Paint()..color = color.withValues(alpha: _haloAlpha),
    );

    for (var i = 0; i < RideSearchMotion.ringCount; i++) {
      final t = (phase + i / RideSearchMotion.ringCount) % 1;
      final eased = RideSearchMotion.expansionCurve.transform(t);
      final radius =
          haloRadius + (maxRadius - haloRadius - strokeWidth) * eased;

      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..color = color.withValues(
            alpha: (1 - t) * RideSearchMotion.peakRingAlpha,
          ),
      );
    }
  }

  @override
  bool shouldRepaint(_BrandPulsePainter oldDelegate) =>
      oldDelegate.phase != phase || oldDelegate.color != color;
}

/// Tint behind the mark: present enough to read as brand, light enough to keep
/// the logo legible on it in both themes.
const _haloAlpha = 0.12;
