// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_history_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RideHistoryItemResponse _$RideHistoryItemResponseFromJson(
  Map<String, dynamic> json,
) => RideHistoryItemResponse(
  requestedDate: json['requestedDate'] as String?,
  requestedTime: json['requestedTime'] as String?,
  price: doubleFromJson(json['price']),
  status: json['status'] as String?,
);
