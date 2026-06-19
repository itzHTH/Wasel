// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: unused_element
CompleteRegistrationRequest _$CompleteRegistrationRequestFromJson(
  Map<String, dynamic> json,
) => CompleteRegistrationRequest(
  registrationToken: json['registrationToken'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  phone: json['phone'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$CompleteRegistrationRequestToJson(
  CompleteRegistrationRequest instance,
) => <String, dynamic>{
  'registrationToken': instance.registrationToken,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'phone': instance.phone,
  'password': instance.password,
};
