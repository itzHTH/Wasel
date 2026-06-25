import 'dart:io' show Platform;

import 'package:camera/camera.dart' show XFile;
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';

/// Launches Google ML Kit's document scanner — a full-screen Play Services flow
/// that handles edge detection, auto-capture, cropping and cleanup, then returns
/// a single captured page.
///
/// Returns the captured image, or `null` if the user cancelled, the platform is
/// unsupported (iOS is deferred — Android-only for now), or scanning failed.
/// The scanner provides its own camera UI, so no [CameraController] / preview is
/// built here and no CAMERA permission is needed.
Future<XFile?> scanDocumentImage() async {
  // ML Kit document scanner is Android-only at the moment; iOS is deferred.
  if (!Platform.isAndroid) return null;

  final scanner = DocumentScanner(
    options: DocumentScannerOptions(
      documentFormats: const {DocumentFormat.jpeg},
      mode: ScannerMode.full,
      pageLimit: 1,
      isGalleryImport: false,
    ),
  );

  try {
    final result = await scanner.scanDocument();
    final images = result.images;
    if (images == null || images.isEmpty) return null;
    return XFile(images.first);
  } catch (e) {
    // Cancellation surfaces as a platform error; treat any failure as "no
    // capture" so the wizard simply leaves the slot unchanged.
    debugPrint('Document scan cancelled/failed: $e');
    return null;
  } finally {
    await scanner.close();
  }
}
