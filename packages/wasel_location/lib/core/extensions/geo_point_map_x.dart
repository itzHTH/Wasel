import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasel_location/domain/entities/device_fix.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';

/// Lifts domain coordinates onto the map package's type at the UI edge.
extension GeoPointMapX on GeoPoint {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

extension DeviceFixMapX on DeviceFix {
  LatLng toLatLng() => LatLng(latitude, longitude);
}
