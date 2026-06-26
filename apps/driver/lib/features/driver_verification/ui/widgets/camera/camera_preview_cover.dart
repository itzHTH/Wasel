import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewCover extends StatelessWidget {
  final CameraController controller;

  const CameraPreviewCover({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final previewSize = controller.value.previewSize;
    if (previewSize == null) return CameraPreview(controller);
    return ClipRect(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: previewSize.height,
          height: previewSize.width,
          child: CameraPreview(controller),
        ),
      ),
    );
  }
}
