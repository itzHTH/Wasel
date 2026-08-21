import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Camera defaults shared by every Wasel map — one service area (Iraq) for all
/// apps, so the rider and the driver always open on the same view.
class AppMapDefaults {
  const AppMapDefaults._();

  static const LatLng initialTarget = LatLng(33.3152, 44.3661);

  static const double initialZoom = 14.5;

  static const MinMaxZoomPreference zoomRange = MinMaxZoomPreference(10, 20);

  static const MarkerId vehicleMarkerId = MarkerId('driver');

  static final LatLngBounds serviceBounds = LatLngBounds(
    southwest: const LatLng(29.0, 38.8),
    northeast: const LatLng(37.4, 48.6),
  );
}
