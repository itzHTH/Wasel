import 'package:driver/core/const/app_driver_consts.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    RouteRemoteService(dotenv.get(AppDriverConsts.routeAPIKeyName));
