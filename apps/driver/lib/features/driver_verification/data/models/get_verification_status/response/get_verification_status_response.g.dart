// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_verification_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVerificationStatusResponse _$GetVerificationStatusResponseFromJson(
  Map<String, dynamic> json,
) => GetVerificationStatusResponse(
  data: (json['data'] as num).toInt(),
  message: json['message'] as String,
);

Map<String, dynamic> _$GetVerificationStatusResponseToJson(
  GetVerificationStatusResponse instance,
) => <String, dynamic>{'data': instance.data, 'message': instance.message};
