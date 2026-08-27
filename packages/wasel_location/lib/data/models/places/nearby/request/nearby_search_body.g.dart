// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_search_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NearbySearchBody _$NearbySearchBodyFromJson(Map<String, dynamic> json) =>
    _NearbySearchBody(
      languageCode: json['languageCode'] as String,
      maxResultCount: (json['maxResultCount'] as num).toInt(),
      rankPreference: json['rankPreference'] as String,
      locationRestriction: NearbyLocationRestriction.fromJson(
        json['locationRestriction'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$NearbySearchBodyToJson(_NearbySearchBody instance) =>
    <String, dynamic>{
      'languageCode': instance.languageCode,
      'maxResultCount': instance.maxResultCount,
      'rankPreference': instance.rankPreference,
      'locationRestriction': instance.locationRestriction,
    };

_NearbyLocationRestriction _$NearbyLocationRestrictionFromJson(
  Map<String, dynamic> json,
) => _NearbyLocationRestriction(
  circle: AutocompleteCircle.fromJson(json['circle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NearbyLocationRestrictionToJson(
  _NearbyLocationRestriction instance,
) => <String, dynamic>{'circle': instance.circle};
