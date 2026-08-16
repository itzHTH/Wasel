import 'package:wasel_location/domain/entities/geo_point.dart';

/// A single reading from the device's location sensors.
/// This is the domain's stand-in for geolocator's `Position`
class DeviceFix {
  final GeoPoint point;

  /// Direction of travel in degrees clockwise from true north.
  final double heading;

  /// Ground speed (in metres) per second.
  final double speed;

  /// Radius of 68% confidence around [point], in metres.
  final double accuracy;

  /// When the platform took the reading.
  final DateTime? timestamp;

  const DeviceFix({
    required this.point,
    this.heading = -1, // -1 means "unknown" in geolocator's `Position`
    this.speed = 0,
    this.accuracy = 0,
    this.timestamp,
  });

  double get latitude => point.latitude;
  double get longitude => point.longitude;

  /// Metres per second below which [heading] is treated as noise.
  static const double minimumHeadingSpeed = 1.0;

  /// Whether [heading] is worth rotating a marker by.
  /// A stationary device reports a heading that //! jitters wildly,
  /// so a minimum speed is required before the value is trusted.
  bool get isHeadingUsable => heading >= 0 && speed >= minimumHeadingSpeed;

  //! Did'nt use freezed because we in domain layer , freezed is not pure dart and freezed is not supported in domain layer
  @override
  bool operator ==(Object other) =>
      other is DeviceFix &&
      other.point == point &&
      other.heading == heading &&
      other.speed == speed &&
      other.accuracy == accuracy &&
      other.timestamp == timestamp;

  @override
  int get hashCode => Object.hash(point, heading, speed, accuracy, timestamp);

  @override
  String toString() => 'DeviceFix($point, heading: $heading, speed: $speed)';
}
