import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

/// Pulsing radar shown while the driver is online and waiting for an offer.
///
/// Stateful only to own the [AnimationController] — repaints come from
/// [AnimatedBuilder], never from `setState`.
class SearchingRadar extends StatefulWidget {
  const SearchingRadar({super.key});

  @override
  State<SearchingRadar> createState() => _SearchingRadarState();
}

class _SearchingRadarState extends State<SearchingRadar>
    with SingleTickerProviderStateMixin {
  static const _period = Duration(milliseconds: 2400);

  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: _period,
  )..repeat();

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = AppDimens.icon48;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (context, child) => CustomPaint(
          painter: _RadarPainter(
            phase: _pulse.value,
            coreRadius: AppDimens.icon18 / 2,
          ),
        ),
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  const _RadarPainter({required this.phase, required this.coreRadius});

  final double phase;
  final double coreRadius;

  /// Rings in flight at once, evenly spread across the cycle.
  static const _ringCount = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    final maxRadius = math.min(size.width, size.height) / 2;

    for (var i = 0; i < _ringCount; i++) {
      final t = (phase + i / _ringCount) % 1;
      final radius = coreRadius + (maxRadius - coreRadius) * t;
      final ring = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = AppDimens.space4 / 2
        ..color = AppColor.primary500.withValues(alpha: (1 - t) * 0.6);

      canvas.drawCircle(center, radius, ring);
    }

    canvas.drawCircle(
      center,
      coreRadius,
      Paint()..color = AppColor.primary500,
    );
  }

  @override
  bool shouldRepaint(_RadarPainter oldDelegate) =>
      oldDelegate.phase != phase || oldDelegate.coreRadius != coreRadius;
}
