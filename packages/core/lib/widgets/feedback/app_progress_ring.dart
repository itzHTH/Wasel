import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

class AppProgressRing extends StatelessWidget {
  const AppProgressRing({
    super.key,
    required this.progress,
    required this.size,
    this.child,
  });

  /// 0..1. Values outside the range are clamped.
  final double progress;

  final double size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _ProgressRingPainter(
          progress: progress.clamp(0.0, 1.0),
          track: context.colors.neutral100,
          fill: context.colors.primary500,
          strokeWidth: size / 16,
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  const _ProgressRingPainter({
    required this.progress,
    required this.track,
    required this.fill,
    required this.strokeWidth,
  });

  final double progress;
  final Color track;
  final Color fill;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;
    final circle = Rect.fromCircle(center: rect.center, radius: radius);

    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(rect.center, radius, stroke..color = track);

    // From twelve o'clock, so a partial ring reads as a gauge.
    canvas.drawArc(
      circle,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      stroke..color = fill,
    );
  }

  @override
  bool shouldRepaint(_ProgressRingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.track != track ||
      oldDelegate.fill != fill ||
      oldDelegate.strokeWidth != strokeWidth;
}
