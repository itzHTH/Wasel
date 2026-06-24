import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';

/// Cutout shape for the camera overlay — oval for the selfie, rect for
/// documents (kept for reuse even though documents currently use ML Kit's own
/// scanner UI).
enum CutoutShape { oval, rect }

/// Dims the full camera surface and punches a transparent cutout in the centre
/// with a coloured border ring. The ring colour is driven by the screen
/// (e.g. green once the face is aligned).
class CameraOverlayPainter extends CustomPainter {
  final Color borderColor;
  final CutoutShape shape;

  /// Cutout width as a fraction of the available width.
  final double widthFactor;

  /// Cutout height / width.
  final double aspectRatio;

  /// Vertical centre as a fraction of the available height.
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
      Paint()..color = AppColor.secondary900.withValues(alpha: 0.6),
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
