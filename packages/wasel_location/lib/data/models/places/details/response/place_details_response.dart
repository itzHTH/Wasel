import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';

part 'place_details_response.freezed.dart';
part 'place_details_response.g.dart';

@freezed
abstract class PlaceDetailsResponse with _$PlaceDetailsResponse {
  const factory PlaceDetailsResponse({PlaceLocation? location}) =
      _PlaceDetailsResponse;

  factory PlaceDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailsResponseFromJson(json);
}

@freezed
abstract class PlaceLocation with _$PlaceLocation {
  const factory PlaceLocation({double? latitude, double? longitude}) =
      _PlaceLocation;

  factory PlaceLocation.fromJson(Map<String, dynamic> json) =>
      _$PlaceLocationFromJson(json);
}

extension PlaceDetailsResponseX on PlaceDetailsResponse {
  GeoPoint? toPoint() {
    final latitude = location?.latitude;
    final longitude = location?.longitude;
    if (latitude == null || longitude == null) return null;
    return GeoPoint(latitude: latitude, longitude: longitude);
  }
}
