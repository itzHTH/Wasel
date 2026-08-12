import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:wasel_location/data/const/location_api_const.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';

/// Google Routes API, reached through `flutter_polyline_points`.
///
/// The API key arrives by constructor rather than being read from `dotenv` in
/// here, so the service stays a pure function of its inputs and a test can
/// build one without an `.env` file on disk. Resolving the key from the
/// environment is the DI layer's job.
class RouteRemoteService {
  RouteRemoteService(String apiKey)
    : _polylinePoints = PolylinePoints(apiKey: apiKey);

  final PolylinePoints _polylinePoints;

  /// Decoded points of the driving route between [origin] and [destination].
  ///
  /// Returns an empty list when Google has no route to offer; deciding whether
  /// that is an error is left to the repository, which owns the failure
  /// contract.
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
