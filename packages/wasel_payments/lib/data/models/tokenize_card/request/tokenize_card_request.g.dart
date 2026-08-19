// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokenize_card_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenizeCardRequest _$TokenizeCardRequestFromJson(Map<String, dynamic> json) =>
    TokenizeCardRequest(
      cardNumber: json['cardNumber'] as String,
      expiryMonth: json['expiryMonth'] as String,
      expiryYear: json['expiryYear'] as String,
      cvv: json['cvv'] as String,
    );

Map<String, dynamic> _$TokenizeCardRequestToJson(
  TokenizeCardRequest instance,
) => <String, dynamic>{
  'cardNumber': instance.cardNumber,
  'expiryMonth': instance.expiryMonth,
  'expiryYear': instance.expiryYear,
  'cvv': instance.cvv,
};
