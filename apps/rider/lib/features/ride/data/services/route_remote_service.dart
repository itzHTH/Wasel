import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/core/consts/app_rider_consts.dart';
import 'package:wasal/features/ride/domain/entities/geo_point.dart';

part 'route_remote_service.g.dart';

class RouteRemoteService {
  RouteRemoteService(String apiKey)
    : _polylinePoints = PolylinePoints(apiKey: apiKey);

  final PolylinePoints _polylinePoints;

  Future<List<GeoPoint>> fetchRoute(
    GeoPoint origin,
    GeoPoint destination,
  ) async {
    final response = await _polylinePoints.getRouteBetweenCoordinatesV2(
      request: RoutesApiRequest(
        origin: PointLatLng(origin.latitude, origin.longitude),
        destination: PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving,
        responseFieldMask: 'routes.polyline.encodedPolyline',
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

@riverpod
RouteRemoteService routeRemoteService(Ref ref) =>
    RouteRemoteService(dotenv.get(AppRiderConsts.routeAPIKeyName));
