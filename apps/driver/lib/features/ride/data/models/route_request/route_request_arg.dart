import 'package:driver/features/ride/domain/entities/geo_point.dart';

class RouteRequestArg {
  final GeoPoint origin;
  final GeoPoint destination;

  const RouteRequestArg({required this.origin, required this.destination});
}
