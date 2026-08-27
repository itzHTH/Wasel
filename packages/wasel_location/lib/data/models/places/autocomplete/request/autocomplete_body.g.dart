// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AutocompleteBody _$AutocompleteBodyFromJson(Map<String, dynamic> json) =>
    _AutocompleteBody(
      input: json['input'] as String,
      sessionToken: json['sessionToken'] as String,
      languageCode: json['languageCode'] as String,
      includedRegionCodes: (json['includedRegionCodes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      locationBias: json['locationBias'] == null
          ? null
          : AutocompleteLocationBias.fromJson(
              json['locationBias'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AutocompleteBodyToJson(_AutocompleteBody instance) =>
    <String, dynamic>{
      'input': instance.input,
      'sessionToken': instance.sessionToken,
      'languageCode': instance.languageCode,
      'includedRegionCodes': instance.includedRegionCodes,
      'locationBias': ?instance.locationBias,
    };

_AutocompleteLocationBias _$AutocompleteLocationBiasFromJson(
  Map<String, dynamic> json,
) => _AutocompleteLocationBias(
  circle: AutocompleteCircle.fromJson(json['circle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AutocompleteLocationBiasToJson(
  _AutocompleteLocationBias instance,
) => <String, dynamic>{'circle': instance.circle};

_AutocompleteCircle _$AutocompleteCircleFromJson(Map<String, dynamic> json) =>
    _AutocompleteCircle(
      center: GoogleLatLng.fromJson(json['center'] as Map<String, dynamic>),
      radius: (json['radius'] as num).toDouble(),
    );

Map<String, dynamic> _$AutocompleteCircleToJson(_AutocompleteCircle instance) =>
    <String, dynamic>{'center': instance.center, 'radius': instance.radius};

_GoogleLatLng _$GoogleLatLngFromJson(Map<String, dynamic> json) =>
    _GoogleLatLng(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$GoogleLatLngToJson(_GoogleLatLng instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
