import 'dart:ui' as ui;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_marker_icon_provider.g.dart';

@Riverpod(keepAlive: true)
Future<BitmapDescriptor> mapMarkerIcon(
  Ref ref,
  String assetPath, {
  double logicalSize = 56,
}) async {
  final dpr = ui.PlatformDispatcher.instance.views.first.devicePixelRatio;
  final info = await vg.loadPicture(SvgAssetLoader(assetPath), null);
  final scale = (logicalSize * dpr) / info.size.longestSide;

  final recorder = ui.PictureRecorder();
  ui.Canvas(recorder)
    ..scale(scale)
    ..drawPicture(info.picture);
  final picture = recorder.endRecording();

  final image = await picture.toImage(
    (info.size.width * scale).ceil(),
    (info.size.height * scale).ceil(),
  );
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

  info.picture.dispose();
  picture.dispose();
  image.dispose();

  return BitmapDescriptor.bytes(bytes!.buffer.asUint8List(), imagePixelRatio: dpr);
}
