// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceDetailsResponse _$PlaceDetailsResponseFromJson(
  Map<String, dynamic> json,
) => _PlaceDetailsResponse(
  location: json['location'] == null
      ? null
      : PlaceLocation.fromJson(json['location'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PlaceDetailsResponseToJson(
  _PlaceDetailsResponse instance,
) => <String, dynamic>{'location': instance.location};

_PlaceLocation _$PlaceLocationFromJson(Map<String, dynamic> json) =>
    _PlaceLocation(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PlaceLocationToJson(_PlaceLocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
