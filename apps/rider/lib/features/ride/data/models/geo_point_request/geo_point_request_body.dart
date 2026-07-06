import 'package:freezed_annotation/freezed_annotation.dart';

part 'geo_point_request_body.g.dart';

@JsonSerializable()
class GeoPointRequestBody {
  final String pickupLat;
  final String pickupLng;
  final String dropoffLat;
  final String dropoffLng;

  GeoPointRequestBody({
    required this.pickupLat,
    required this.pickupLng,
    required this.dropoffLat,
    required this.dropoffLng,
  });

  Map<String, dynamic> toJson() => _$GeoPointRequestBodyToJson(this);
}
