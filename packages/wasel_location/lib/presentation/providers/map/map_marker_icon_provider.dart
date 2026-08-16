import 'dart:ui' as ui;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_marker_icon_provider.g.dart';

/// Converts an SVG asset into a [BitmapDescriptor] for Google Maps markers.
//
//? - Uses a family provider keyed by `assetPath` and `logicalSize` to cache
//?   the expensive SVG-to-Bitmap rasterization process (decodes once per icon).
//
//? - Scales the drawing using the device's pixel ratio for crisp Retina/High-DPI rendering.
//
//? - Manually disposes Native graphics memory (Picture, Image) to prevent
//?   OOM (Out Of Memory) crashes during rapid map interactions.
//
//? - Fails gracefully by returning `null`, allowing callers to fall back to
//?   the default Google Maps red pin rather than crashing the UI.
@Riverpod(keepAlive: true)
Future<BitmapDescriptor?> mapMarkerIcon(
  Ref ref,
  String assetPath, {
  double logicalSize = 56,
}) async {
  final dpr = ui
      .PlatformDispatcher
      .instance
      .views
      .first
      .devicePixelRatio; // get Device pixel ratio
  final info = await vg.loadPicture(
    SvgAssetLoader(assetPath),
    null,
  ); // Load the SVG
  final scale =
      (logicalSize * dpr) /
      info.size.longestSide; // Scale the SVG to the logical size

  final recorder = ui.PictureRecorder(); // Create a canvas to draw the SVG

  ui.Canvas(recorder)
    ..scale(scale) // Scale the canvas to the device pixel ratio
    ..drawPicture(info.picture); // Draw the SVG on the canvas

  final picture = recorder.endRecording(); // Get the canvas as a picture

  final image = await picture.toImage(
    // Convert the picture to an image
    (info.size.width * scale).ceil(),
    (info.size.height * scale).ceil(),
  );

  // Convert the image to a byte array
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

  // Released eagerly rather than left to the GC: these hold native memory that
  // Dart's collector has no pressure signal for, and a map redrawing markers can
  // allocate them faster than a finaliser would free them.
  info.picture.dispose();
  picture.dispose();
  image.dispose();

  // Return null if the image is empty (could be a missing asset, or a bad SVG)
  if (bytes == null) return null;

  return BitmapDescriptor.bytes(
    bytes.buffer.asUint8List(),
    imagePixelRatio: dpr,
  );
}
