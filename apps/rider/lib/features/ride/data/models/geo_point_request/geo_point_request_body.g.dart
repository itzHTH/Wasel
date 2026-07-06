// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'geo_point_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
