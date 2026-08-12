// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_geocoding_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoogleGeocodingResponse _$GoogleGeocodingResponseFromJson(
  Map<String, dynamic> json,
) => _GoogleGeocodingResponse(
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => GeocodeResult.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <GeocodeResult>[],
);

Map<String, dynamic> _$GoogleGeocodingResponseToJson(
  _GoogleGeocodingResponse instance,
) => <String, dynamic>{'results': instance.results};

_GeocodeResult _$GeocodeResultFromJson(Map<String, dynamic> json) =>
    _GeocodeResult(
      addressComponents:
          (json['addressComponents'] as List<dynamic>?)
              ?.map((e) => AddressComponent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AddressComponent>[],
    );

Map<String, dynamic> _$GeocodeResultToJson(_GeocodeResult instance) =>
    <String, dynamic>{'addressComponents': instance.addressComponents};
