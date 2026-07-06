// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimate_ride_price_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstimateRidePriceResponse _$EstimateRidePriceResponseFromJson(
  Map<String, dynamic> json,
) => EstimateRidePriceResponse(
  estimatedPrice: json['estimatedPrice'] as String,
  distanceInKm: json['distanceInKm'] as String,
  currency: json['currency'] as String,
);

Map<String, dynamic> _$EstimateRidePriceResponseToJson(
  EstimateRidePriceResponse instance,
) => <String, dynamic>{
  'estimatedPrice': instance.estimatedPrice,
  'distanceInKm': instance.distanceInKm,
  'currency': instance.currency,
};
