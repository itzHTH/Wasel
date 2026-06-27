import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

/// Compresses captured images before upload to keep multipart request bodies
/// small (avoids server `413 Request Entity Too Large`).
class AppImageCompressor {
  // Private constructor — this class only exposes static helpers.
  AppImageCompressor._();

  /// Compresses [source] to a JPEG, scaled so neither side is below
  /// [maxSide]px (aspect ratio preserved) at the given [quality] (0–100).
  ///
  /// Returns the compressed file. If the platform can't compress the image
  /// (or it fails), the original [source] is returned unchanged.
  static Future<File> compress(
    File source, {
    int maxSide = 1600,
    int quality = 75,
  }) async {
    final dir = source.parent.path;
    final name = source.uri.pathSegments.last;
    final target = '$dir/cmp_$name.jpg';

    final result = await FlutterImageCompress.compressAndGetFile(
      source.path,
      target,
      minWidth: maxSide,
      minHeight: maxSide,
      quality: quality,
      format: CompressFormat.jpeg,
    );

    return result == null ? source : File(result.path);
  }
}
