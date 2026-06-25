import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:driver/features/driver_verification/ui/widgets/camera/camera_overlay_painter.dart';
import 'package:driver/features/driver_verification/ui/widgets/camera/camera_preview_cover.dart';
import 'package:driver/features/driver_verification/ui/widgets/camera/guidance_text.dart';
import 'package:driver/features/driver_verification/ui/widgets/camera/manual_capture_button.dart';

class CameraCaptureView extends StatelessWidget {
  final CameraController controller;
  final CutoutShape cutoutShape;
  final double widthFactor;
  final double aspectRatio;
  final String guidanceText;
  final ValueListenable<bool> isCapturing;
  final VoidCallback onCapture;
  final VoidCallback onClose;

  const CameraCaptureView({
    super.key,
    required this.controller,
    required this.cutoutShape,
    required this.widthFactor,
    required this.aspectRatio,
    required this.guidanceText,
    required this.isCapturing,
    required this.onCapture,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Cover-fit camera preview.
        CameraPreviewCover(controller: controller),

        // Dim + framing cutout + ring.
        CustomPaint(
          painter: CameraOverlayPainter(
            borderColor: AppColor.neutral0,
            shape: cutoutShape,
            widthFactor: widthFactor,
            aspectRatio: aspectRatio,
          ),
        ),

        // Close button (top-start in RTL).
        SafeArea(
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Padding(
              padding: EdgeInsets.all(AppDimens.space8),
              child: IconButton(
                icon: const Icon(Icons.close, color: AppColor.neutral0),
                onPressed: onClose,
              ),
            ),
          ),
        ),

        // Static guidance pill.
        Align(
          alignment: const Alignment(0, 0.45),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
            child: GuidanceText(message: guidanceText),
          ),
        ),

        // Manual shutter.
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: AppDimens.space40),
              child: ValueListenableBuilder<bool>(
                valueListenable: isCapturing,
                builder: (context, capturing, _) => ManualCaptureButton(
                  onPressed: capturing ? null : onCapture,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
