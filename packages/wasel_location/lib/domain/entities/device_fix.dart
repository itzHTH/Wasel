import 'package:wasel_location/domain/entities/geo_point.dart';

/// A single reading from the device's location sensors.
///
/// This is the domain's stand-in for geolocator's `Position`, and it exists so
/// that `Position` never escapes the data layer. Today both apps pass `Position`
/// straight into providers, widgets and camera controllers, which is what makes
/// the GPS paths impossible to unit test — you cannot construct a fake reading
/// without dragging in the plugin's platform channel.
///
/// Only the fields the apps actually consume are modelled: the driver reads
/// [heading] and [speed] to rotate the car marker, everything else reads the
/// coordinate. Fields geolocator reports but nothing uses (altitude, floor,
/// isMocked, …) are left out on purpose — they can be added when a caller needs
/// them rather than carried speculatively.
class DeviceFix {
  /// Where the device is.
  final GeoPoint point;

  /// Direction of travel in degrees clockwise from true north.
  ///
  /// Negative when the platform cannot determine it. Callers must treat a
  /// negative value as "unknown" rather than as a bearing of zero — pointing a
  /// car marker due north because the sensor had nothing to say is a visible
  /// bug, and it is why [isHeadingUsable] exists.
  final double heading;

  /// Ground speed in metres per second.
  final double speed;

  /// Radius of 68% confidence around [point], in metres.
  final double accuracy;

  /// When the platform took the reading.
  final DateTime? timestamp;

  const DeviceFix({
    required this.point,
    this.heading = -1,
    this.speed = 0,
    this.accuracy = 0,
    this.timestamp,
  });

  double get latitude => point.latitude;

  double get longitude => point.longitude;

  /// Whether [heading] is worth rotating a marker by.
  ///
  /// A stationary device reports a heading that jitters wildly, so a minimum
  /// speed is required before the value is trusted. The 1 m/s floor is carried
  /// over from the driver app's `DriverHeading`, which arrived at it against
  /// real devices — keeping the same threshold means the extraction does not
  /// change how the car marker behaves on the road.
  bool get isHeadingUsable => heading >= 0 && speed >= minimumHeadingSpeed;

  /// Metres per second below which [heading] is treated as noise.
  static const double minimumHeadingSpeed = 1.0;

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
