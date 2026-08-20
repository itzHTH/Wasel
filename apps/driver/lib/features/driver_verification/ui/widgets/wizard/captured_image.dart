import 'dart:typed_data';

import 'package:camera/camera.dart' show XFile;
import 'package:flutter/material.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

class CapturedImage extends StatefulWidget {
  final XFile file;
  final BoxFit fit;

  const CapturedImage({super.key, required this.file, this.fit = BoxFit.cover});

  @override
  State<CapturedImage> createState() => _CapturedImageState();
}

class _CapturedImageState extends State<CapturedImage> {
  // Read the bytes once; rebuilding the sheet must not re-trigger the read
  // (a fresh future each build resets the FutureBuilder and flickers).
  late Future<Uint8List> _bytes = widget.file.readAsBytes();

  @override
  void didUpdateWidget(CapturedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.file.path != widget.file.path) {
      _bytes = widget.file.readAsBytes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _bytes,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(color: context.colors.neutral100);
        }
        return Image.memory(snapshot.data!, fit: widget.fit);
      },
    );
  }
}
