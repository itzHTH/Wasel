// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_ride_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewRideResponse _$ReviewRideResponseFromJson(Map<String, dynamic> json) =>
    ReviewRideResponse(
      succeeded: json['succeeded'] as bool? ?? false,
      isReviewed: json['data'] as bool?,
    );

Map<String, dynamic> _$ReviewRideResponseToJson(ReviewRideResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'data': instance.isReviewed,
    };
