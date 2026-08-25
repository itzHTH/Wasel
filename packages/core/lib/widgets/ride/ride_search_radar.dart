import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/ride/ride_search_motion.dart';

/// The pulsing radar shown while a search is running — the rider looking for a
/// captain, the captain waiting for an offer. It carries the same motion as the
/// rider map's expanding search radius: rings grow on [RideSearchMotion
/// .expansionCurve] while the core breathes on a sine.
///
/// Stateful only to own the [AnimationController] — repaints come from
/// [AnimatedBuilder], never from `setState`.
class RideSearchRadar extends StatefulWidget {
  const RideSearchRadar({super.key, this.size, this.color});

  final double? size;
  final Color? color;

  @override
  State<RideSearchRadar> createState() => _RideSearchRadarState();
}

class _RideSearchRadarState extends State<RideSearchRadar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: RideSearchMotion.pulsePeriod,
  )..repeat();

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size ?? AppDimens.icon40;
    final color = widget.color ?? context.colors.primary500;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (context, child) => CustomPaint(
          painter: _RadarPainter(phase: _pulse.value, color: color),
        ),
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  const _RadarPainter({required this.phase, required this.color});

  final double phase;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    final maxRadius = math.min(size.width, size.height) / 2;
    final coreRadius = maxRadius / 2.5;
    final strokeWidth = maxRadius / 10;

    for (var i = 0; i < RideSearchMotion.ringCount; i++) {
      final t = (phase + i / RideSearchMotion.ringCount) % 1;
      final eased = RideSearchMotion.expansionCurve.transform(t);
      final radius =
          coreRadius + (maxRadius - coreRadius - strokeWidth) * eased;
      final ring = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = color.withValues(
          alpha: (1 - t) * RideSearchMotion.peakRingAlpha,
        );

      canvas.drawCircle(center, radius, ring);
    }

    final breath = (1 - math.sin(2 * math.pi * phase)) / 2;
    final core = Paint()
      ..color = color.withValues(
        alpha: 1 - RideSearchMotion.coreAlphaSwing * breath,
      );

    canvas.drawCircle(center, coreRadius, core);
  }

  @override
  bool shouldRepaint(_RadarPainter oldDelegate) =>
      oldDelegate.phase != phase || oldDelegate.color != color;
}
