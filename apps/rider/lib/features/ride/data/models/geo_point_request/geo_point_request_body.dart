import 'package:freezed_annotation/freezed_annotation.dart';

part 'geo_point_request_body.g.dart';

@JsonSerializable()
class GeoPointRequestBody {
  String pickupLat;
  String pickupLng;
  String dropoffLat;
  String dropoffLng;

  GeoPointRequestBody({
    required this.pickupLat,
    required this.pickupLng,
    required this.dropoffLat,
    required this.dropoffLng,
  });

  Map<String, dynamic> toJson() => _$GeoPointRequestBodyToJson(this);
}
