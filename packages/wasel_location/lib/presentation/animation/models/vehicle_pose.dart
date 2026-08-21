import 'package:wasel_location/domain/entities/geo_point.dart';

/// Where a vehicle sits and which way it faces — the pair a marker needs.
class VehiclePose {
  final GeoPoint point;

  /// Degrees clockwise from north.
  final double bearing;

  const VehiclePose({required this.point, required this.bearing});

  /// The pose of a vehicle that has not reported a position yet.
  static const VehiclePose unknown = VehiclePose(
    point: GeoPoint(latitude: 0, longitude: 0),
    bearing: 0,
  );

  double get latitude => point.latitude;
  double get longitude => point.longitude;

  @override
  bool operator ==(Object other) =>
      other is VehiclePose && other.point == point && other.bearing == bearing;

  @override
  int get hashCode => Object.hash(point, bearing);

  @override
  String toString() => 'VehiclePose($point, bearing: $bearing)';
}
