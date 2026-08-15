import 'package:wasel_location/domain/entities/geo_point.dart';

/// The two endpoints of a route to draw.
class RouteRequest {
  final GeoPoint origin;
  final GeoPoint destination;

  const RouteRequest({required this.origin, required this.destination});

  //! Did'nt use freezed because we in domain layer , freezed is not pure dart and freezed is not supported in domain layer
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
