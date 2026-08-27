// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reverse_geocoding_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReverseGeocodingResponse _$ReverseGeocodingResponseFromJson(
  Map<String, dynamic> json,
) => _ReverseGeocodingResponse(
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => GeocodingResult.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <GeocodingResult>[],
  status: json['status'] as String?,
);

Map<String, dynamic> _$ReverseGeocodingResponseToJson(
  _ReverseGeocodingResponse instance,
) => <String, dynamic>{'results': instance.results, 'status': instance.status};

_GeocodingResult _$GeocodingResultFromJson(Map<String, dynamic> json) =>
    _GeocodingResult(
      addressComponents:
          (json['address_components'] as List<dynamic>?)
              ?.map((e) => AddressComponent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AddressComponent>[],
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    );

Map<String, dynamic> _$GeocodingResultToJson(_GeocodingResult instance) =>
    <String, dynamic>{
      'address_components': instance.addressComponents,
      'types': instance.types,
    };

_AddressComponent _$AddressComponentFromJson(Map<String, dynamic> json) =>
    _AddressComponent(
      longName: json['long_name'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    );

Map<String, dynamic> _$AddressComponentToJson(_AddressComponent instance) =>
    <String, dynamic>{'long_name': instance.longName, 'types': instance.types};
