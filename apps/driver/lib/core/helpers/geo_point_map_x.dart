import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:wasel_core/wasel_core.dart';

/// Lifts a domain point onto the map package's type at the UI edge, so the
/// entity itself stays free of Google Maps.
extension GeoPointMapX on GeoPoint {
  LatLng toLatLng() => LatLng(latitude, longitude);
}
