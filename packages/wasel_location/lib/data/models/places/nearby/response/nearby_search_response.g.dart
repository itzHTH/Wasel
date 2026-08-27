// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NearbySearchResponse _$NearbySearchResponseFromJson(
  Map<String, dynamic> json,
) => _NearbySearchResponse(
  places:
      (json['places'] as List<dynamic>?)
          ?.map((e) => NearbyPlace.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <NearbyPlace>[],
);

Map<String, dynamic> _$NearbySearchResponseToJson(
  _NearbySearchResponse instance,
) => <String, dynamic>{'places': instance.places};

_NearbyPlace _$NearbyPlaceFromJson(Map<String, dynamic> json) => _NearbyPlace(
  id: json['id'] as String?,
  displayName: json['displayName'] == null
      ? null
      : NearbyDisplayName.fromJson(json['displayName'] as Map<String, dynamic>),
  formattedAddress: json['formattedAddress'] as String?,
);

Map<String, dynamic> _$NearbyPlaceToJson(_NearbyPlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'formattedAddress': instance.formattedAddress,
    };

_NearbyDisplayName _$NearbyDisplayNameFromJson(Map<String, dynamic> json) =>
    _NearbyDisplayName(text: json['text'] as String?);

Map<String, dynamic> _$NearbyDisplayNameToJson(_NearbyDisplayName instance) =>
    <String, dynamic>{'text': instance.text};
