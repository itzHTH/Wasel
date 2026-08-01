// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_driver_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitDriverProfileResponse _$SubmitDriverProfileResponseFromJson(
  Map<String, dynamic> json,
) => SubmitDriverProfileResponse(
  message: json['data'] as String,
  succeeded: json['succeeded'] as bool,
);

Map<String, dynamic> _$SubmitDriverProfileResponseToJson(
  SubmitDriverProfileResponse instance,
) => <String, dynamic>{
  'data': instance.message,
  'succeeded': instance.succeeded,
};
