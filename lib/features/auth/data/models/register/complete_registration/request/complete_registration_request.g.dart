// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteRegistrationRequest _$CompleteRegistrationRequestFromJson(
  Map<String, dynamic> json,
) => CompleteRegistrationRequest(
  registerToken: json['registerToken'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  phoneNumber: json['phoneNumber'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$CompleteRegistrationRequestToJson(
  CompleteRegistrationRequest instance,
) => <String, dynamic>{
  'registerToken': instance.registerToken,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'phoneNumber': instance.phoneNumber,
  'password': instance.password,
};
