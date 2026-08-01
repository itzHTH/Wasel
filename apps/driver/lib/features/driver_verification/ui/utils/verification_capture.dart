import 'package:camera/camera.dart'
    show XFile, CameraLensDirection, ResolutionPreset;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;
import 'package:driver/features/driver_verification/ui/screens/camera_capture_screen.dart';
import 'package:driver/features/driver_verification/ui/widgets/camera/camera_overlay_painter.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/capture_preview_sheet.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/capture_source_sheet.dart';

Future<void> captureInto(
  BuildContext context,
  ValueNotifier<XFile?> slot,
  Future<XFile?> Function(BuildContext) capture,
) async {
  final file = await capture(context);
  if (file == null || !context.mounted) return;
  final confirmed = await showCapturePreviewSheet(context: context, file: file);
  if (confirmed == true) slot.value = file;
}

// License & selfie are camera-only; the vehicle photo also allows the gallery.

Future<XFile?> captureLicense(BuildContext context) => _pushCamera(
  context,
  cutoutShape: CutoutShape.rect,
  lens: CameraLensDirection.back,
  guidance: 'ضع الرخصة داخل الإطار',
  // Landscape ID-card frame (≈ 85.6×54mm).
  widthFactor: 0.88,
  aspectRatio: 0.63,
);

Future<XFile?> captureSelfie(BuildContext context) => _pushCamera(
  context,
  cutoutShape: CutoutShape.oval,
  lens: CameraLensDirection.front,
  guidance: 'ضع وجهك داخل الإطار',
  resolution: ResolutionPreset.medium,
);

Future<XFile?> captureVehicle(BuildContext context) async {
  final source = await showCaptureSourceSheet(context: context);
  if (source == null || !context.mounted) return null;
  switch (source) {
    case CaptureSource.camera:
      return _pushCamera(
        context,
        cutoutShape: CutoutShape.rect,
        lens: CameraLensDirection.back,
        guidance: 'صوّر المركبة داخل الإطار',
      );
    case CaptureSource.gallery:
      return ImagePicker().pickImage(source: ImageSource.gallery);
  }
}

Future<XFile?> _pushCamera(
  BuildContext context, {
  required CutoutShape cutoutShape,
  required CameraLensDirection lens,
  required String guidance,
  ResolutionPreset resolution = ResolutionPreset.high,
  double widthFactor = 0.72,
  double aspectRatio = 1.3,
}) {
  return Navigator.of(context).push<XFile>(
    MaterialPageRoute(
      builder: (_) => CameraCaptureScreen(
        cutoutShape: cutoutShape,
        lensDirection: lens,
        guidanceText: guidance,
        resolution: resolution,
        widthFactor: widthFactor,
        aspectRatio: aspectRatio,
      ),
    ),
  );
}
