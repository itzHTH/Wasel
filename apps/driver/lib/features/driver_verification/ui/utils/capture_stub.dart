import 'dart:ui' as ui;

import 'package:camera/camera.dart' show XFile;
import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';

/// TEMPORARY (Phase 2 only). Generates a placeholder capture so the card states
/// and the preview/retake flow can be exercised before the real camera exists.
///
/// Phase 3 (documents) and Phase 4 (selfie) replace every call to this with the
/// camera screen, which returns a real [XFile]. Delete this file then.
Future<XFile> generateStubCapture(String label) async {
  const width = 600;
  const height = 378; // ~1.586:1 card aspect

  final recorder = ui.PictureRecorder();
  final canvas = Canvas(
    recorder,
    Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
  );

  canvas.drawRect(
    Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    Paint()..color = AppColor.secondary500,
  );

  final textPainter = TextPainter(
    text: TextSpan(
      text: label,
      style: const TextStyle(
        color: AppColor.neutral0,
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
    ),
    textAlign: TextAlign.center,
    textDirection: TextDirection.rtl,
  )..layout(maxWidth: width - 48);
  textPainter.paint(
    canvas,
    Offset((width - textPainter.width) / 2, (height - textPainter.height) / 2),
  );

  final image = await recorder.endRecording().toImage(width, height);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();

  return XFile.fromData(
    byteData!.buffer.asUint8List(),
    mimeType: 'image/png',
    name: 'stub_capture.png',
  );
}
