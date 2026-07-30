// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_component.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddressComponent _$AddressComponentFromJson(Map<String, dynamic> json) =>
    _AddressComponent(
      longText: json['longText'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      languageCode: json['languageCode'] as String?,
    );

Map<String, dynamic> _$AddressComponentToJson(_AddressComponent instance) =>
    <String, dynamic>{
      'longText': instance.longText,
      'types': instance.types,
      'languageCode': instance.languageCode,
    };
