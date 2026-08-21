import 'dart:ui' show Offset;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasel_location/core/const/app_map_defaults.dart';
import 'package:wasel_location/presentation/animation/models/vehicle_pose.dart';

/// Draws an animated vehicle as a map marker.
///
/// The centred anchor is what makes the marker spin in place rather than swing
/// around its tip, and `flat` lays it on the map plane so the rotation reads as
/// the car's heading.
extension VehiclePoseMapX on VehiclePose {
  Marker toMarker({
    MarkerId id = AppMapDefaults.vehicleMarkerId,
    BitmapDescriptor? icon,
  }) => Marker(
    markerId: id,
    position: LatLng(latitude, longitude),
    rotation: bearing,
    icon: icon ?? BitmapDescriptor.defaultMarker,
    anchor: const Offset(0.5, 0.5),
    flat: true,
  );
}
