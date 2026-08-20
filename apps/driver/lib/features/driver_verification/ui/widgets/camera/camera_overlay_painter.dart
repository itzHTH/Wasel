import 'package:flutter/material.dart';
import 'package:wasel_core/theme/palettes/alert_tokens.dart';

enum CutoutShape { oval, rect }

class CameraOverlayPainter extends CustomPainter {
  final Color borderColor;
  final CutoutShape shape;

  final double widthFactor;

  final double aspectRatio;

  final double verticalCenterFactor;

  const CameraOverlayPainter({
    required this.borderColor,
    this.shape = CutoutShape.oval,
    this.widthFactor = 0.72,
    this.aspectRatio = 1.3,
    this.verticalCenterFactor = 0.42,
  });

  Rect _cutoutRect(Size size) {
    final width = size.width * widthFactor;
    final height = width * aspectRatio;
    return Rect.fromCenter(
      center: Offset(size.width / 2, size.height * verticalCenterFactor),
      width: width,
      height: height,
    );
  }

  Path _cutoutPath(Rect rect) {
    final path = Path();
    if (shape == CutoutShape.oval) {
      path.addOval(rect);
    } else {
      path.addRRect(RRect.fromRectXY(rect, 16, 16));
    }
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = _cutoutRect(size);
    final cutout = _cutoutPath(rect);

    // Dim everything except the cutout.
    final dim = Path.combine(
      PathOperation.difference,
      Path()..addRect(Offset.zero & size),
      cutout,
    );
    canvas.drawPath(
      dim,
      Paint()..color = AlertTokens.scrim.withValues(alpha: 0.6),
    );

    // Border ring around the cutout.
    canvas.drawPath(
      cutout,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = borderColor,
    );
  }

  @override
  bool shouldRepaint(CameraOverlayPainter oldDelegate) =>
      oldDelegate.borderColor != borderColor ||
      oldDelegate.shape != shape ||
      oldDelegate.widthFactor != widthFactor ||
      oldDelegate.aspectRatio != aspectRatio ||
      oldDelegate.verticalCenterFactor != verticalCenterFactor;
}
