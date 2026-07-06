// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_point_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: unused_element
GeoPointRequestBody _$GeoPointRequestBodyFromJson(Map<String, dynamic> json) =>
    GeoPointRequestBody(
      pickupLat: json['pickupLat'] as String,
      pickupLng: json['pickupLng'] as String,
      dropoffLat: json['dropoffLat'] as String,
      dropoffLng: json['dropoffLng'] as String,
    );

Map<String, dynamic> _$GeoPointRequestBodyToJson(
  GeoPointRequestBody instance,
) => <String, dynamic>{
  'pickupLat': instance.pickupLat,
  'pickupLng': instance.pickupLng,
  'dropoffLat': instance.dropoffLat,
  'dropoffLng': instance.dropoffLng,
};
