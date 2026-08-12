import 'package:wasel_location/domain/entities/geo_point.dart';

/// The two endpoints of a route to draw.
///
/// Replaces the rider app's `GeoPointRequestBody`, which carried the same four
/// numbers as strings and forced the repo to `double.parse` them back — a round
/// trip that could throw on malformed input in the data layer, far from anything
/// able to report it. Typed [GeoPoint]s make that failure mode unrepresentable.
///
/// `GeoPointRequestBody` itself stays in the rider app: it is also the wire
/// format for ride pricing and ride requests, which are ride-domain API bodies
/// rather than routing concerns.
class RouteRequest {
  final GeoPoint origin;
  final GeoPoint destination;

  const RouteRequest({required this.origin, required this.destination});

  @override
  bool operator ==(Object other) =>
      other is RouteRequest &&
      other.origin == origin &&
      other.destination == destination;

  @override
  int get hashCode => Object.hash(origin, destination);

  @override
  String toString() => 'RouteRequest($origin -> $destination)';
}
