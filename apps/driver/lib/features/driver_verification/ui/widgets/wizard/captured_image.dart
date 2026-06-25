import 'dart:typed_data';

import 'package:camera/camera.dart' show XFile;
import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';

class CapturedImage extends StatelessWidget {
  final XFile file;
  final BoxFit fit;

  const CapturedImage({super.key, required this.file, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: file.readAsBytes(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(color: AppColor.neutral100);
        }
        return Image.memory(snapshot.data!, fit: fit);
      },
    );
  }
}
