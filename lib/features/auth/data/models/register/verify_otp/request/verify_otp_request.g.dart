// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpRequest _$VerifyOtpRequestFromJson(Map<String, dynamic> json) =>
    VerifyOtpRequest(
      sessionToken: json['sessionToken'] as String,
      otpCode: json['otpCode'] as String,
    );

Map<String, dynamic> _$VerifyOtpRequestToJson(VerifyOtpRequest instance) =>
    <String, dynamic>{
      'sessionToken': instance.sessionToken,
      'otpCode': instance.otpCode,
    };
