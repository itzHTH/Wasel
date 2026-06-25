import 'package:camera/camera.dart'
    show XFile, CameraLensDirection, ResolutionPreset;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;
import 'package:driver/features/driver_verification/ui/screens/camera_capture_screen.dart';
import 'package:driver/features/driver_verification/ui/widgets/camera/camera_overlay_painter.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/capture_preview_sheet.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/capture_source_sheet.dart';

/// Capture orchestration for the verification wizard, kept out of the widget
/// tree. The `capture*` helpers return the chosen [XFile] (or null on
/// cancel/deny); [captureInto] adds the preview-confirm step and fills the slot.

/// Runs [capture], shows the preview-confirm sheet, and writes the result into
/// [slot] only on an explicit confirm. A cancel / retake / dismiss leaves
/// [slot] untouched.
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

/// Pushes the manual camera screen with the given framing and returns the
/// captured file (or null if the user backs out / denies the permission).
Future<XFile?> _pushCamera(
  BuildContext context, {
  required CutoutShape cutoutShape,
  required CameraLensDirection lens,
  required String guidance,
  ResolutionPreset resolution = ResolutionPreset.high,
}) {
  return Navigator.of(context).push<XFile>(
    MaterialPageRoute(
      builder: (_) => CameraCaptureScreen(
        cutoutShape: cutoutShape,
        lensDirection: lens,
        guidanceText: guidance,
        resolution: resolution,
      ),
    ),
  );
}
