import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:wasel_location/core/const/location_api_const.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';

/// Google Routes API, reached through `flutter_polyline_points`.
class RouteRemoteService {
  RouteRemoteService(String apiKey)
    : _polylinePoints = PolylinePoints(apiKey: apiKey);

  final PolylinePoints _polylinePoints;

  /// Decoded points of the driving route between [origin] and [destination].
  Future<List<GeoPoint>> fetchRoute(
    GeoPoint origin,
    GeoPoint destination,
  ) async {
    final response = await _polylinePoints.getRouteBetweenCoordinatesV2(
      request: RoutesApiRequest(
        origin: PointLatLng(origin.latitude, origin.longitude),
        destination: PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving,
        responseFieldMask: LocationApiConst.routesFieldMask,
      ),
    );

    final points = response.routes.isEmpty
        ? const <PointLatLng>[]
        : (response.routes.first.polylinePoints ?? const <PointLatLng>[]);

    return points
        .map((p) => GeoPoint(latitude: p.latitude, longitude: p.longitude))
        .toList();
  }
}
