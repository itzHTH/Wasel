import 'dart:math' as math;

import 'package:wasel_location/domain/entities/geo_point.dart';

/// The movement maths behind a smoothly animated vehicle marker.
class GeoInterpolation {
  GeoInterpolation._();

  /// Mean Earth radius (IUGG), in metres.
  static const double earthRadiusMeters = 6371008.8;

  /// The smallest signed rotation that carries from onto to, in (-180, 180].
  static double bearingDelta(double from, double to) {
    final delta = (to - from + 180) % 360 - 180;
    return delta == -180 ? 180 : delta;
  }

  /// Folds any angle into [0, 360).
  static double normalizeBearing(double degrees) => degrees % 360;

  /// from rotated t of the way to to along the shorter arc.
  static double lerpBearing(double from, double to, double t) =>
      normalizeBearing(from + bearingDelta(from, to) * t);

  /// The forward azimuth from [from] to [to], in degrees clockwise from north.
  static double initialBearing(GeoPoint from, GeoPoint to) {
    final phi1 = _radians(from.latitude);
    final phi2 = _radians(to.latitude);
    final deltaLambda = _radians(to.longitude - from.longitude);

    final y = math.sin(deltaLambda) * math.cos(phi2);
    final x =
        math.cos(phi1) * math.sin(phi2) -
        math.sin(phi1) * math.cos(phi2) * math.cos(deltaLambda);

    return normalizeBearing(_degrees(math.atan2(y, x)));
  }

  /// The point [t] of the way from [from] to [to].
  static GeoPoint lerpPoint(GeoPoint from, GeoPoint to, double t) => GeoPoint(
    latitude: from.latitude + (to.latitude - from.latitude) * t,
    longitude: from.longitude + (to.longitude - from.longitude) * t,
  );

  /// Great-circle distance between [a] and [b], in metres.
  static double distanceBetween(GeoPoint a, GeoPoint b) {
    final phi1 = _radians(a.latitude);
    final phi2 = _radians(b.latitude);
    final deltaPhi = _radians(b.latitude - a.latitude);
    final deltaLambda = _radians(b.longitude - a.longitude);

    final h =
        math.sin(deltaPhi / 2) * math.sin(deltaPhi / 2) +
        math.cos(phi1) *
            math.cos(phi2) *
            math.sin(deltaLambda / 2) *
            math.sin(deltaLambda / 2);

    return 2 * earthRadiusMeters * math.asin(math.min(1, math.sqrt(h)));
  }

  static double _radians(double degrees) => degrees * math.pi / 180;

  static double _degrees(double radians) => radians * 180 / math.pi;
}
