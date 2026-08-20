import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// The Google Maps style JSON for the running app.
class AppMapStyle {
  AppMapStyle._();

  static const _lightAsset = 'assets/map_styles/light.json';
  static const _darkAsset = 'assets/map_styles/dark.json';

  static String? _light;
  static String? _dark;

  static Future<void> preload() async {
    try {
      _light = await rootBundle.loadString(_lightAsset);
      _dark = await rootBundle.loadString(_darkAsset);
    } catch (error, stack) {
      // Never fatal: an unstyled map beats an app that cannot start.
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stack,
          library: 'wasel_core',
          context: ErrorDescription('loading the Google Maps style assets'),
        ),
      );
    }
  }

  /// Null before [preload] completes; `GoogleMap.style` reads that as default.
  static String? of(Brightness brightness) =>
      brightness == Brightness.dark ? _dark : _light;
}
