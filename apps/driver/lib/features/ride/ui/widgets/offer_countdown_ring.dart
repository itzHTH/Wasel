import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

/// Ring that drains as an offer expires.
///
/// Deliberately holds no timer — [remaining] is driven by the ride
/// controller's countdown so the ring and the accept button can never drift
/// apart.
class OfferCountdownRing extends StatelessWidget {
  const OfferCountdownRing({
    super.key,
    required this.total,
    required this.remaining,
  });

  final Duration total;
  final Duration remaining;

  /// Below this share of the window the ring turns red.
  static const _urgentFraction = 0.25;

  @override
  Widget build(BuildContext context) {
    final totalMs = total.inMilliseconds;
    final progress = totalMs <= 0
        ? 0.0
        : (remaining.inMilliseconds / totalMs).clamp(0.0, 1.0);
    final color = progress <= _urgentFraction
        ? AppColor.alertError500
        : AppColor.primary500;
    final size = AppDimens.icon48;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(
          progress: progress,
          color: color,
          strokeWidth: AppDimens.space4,
        ),
        child: Center(
          child: Text(
            '${remaining.inSeconds}',
            style: AppTextStyles.font14Secondary900SemiBold.copyWith(
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final double strokeWidth;

  static const _startAngle = -math.pi / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;

    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = AppColor.neutral200;

    canvas.drawCircle(center, radius, track);

    if (progress <= 0) return;

    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = color;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      _startAngle,
      -2 * math.pi * progress,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth;
}
