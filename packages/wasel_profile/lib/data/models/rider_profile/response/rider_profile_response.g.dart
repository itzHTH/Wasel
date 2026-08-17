// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiderProfileResponse _$RiderProfileResponseFromJson(
  Map<String, dynamic> json,
) => RiderProfileResponse(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  email: json['email'] as String,
  phoneNumber: json['phoneNumber'] as String,
  profilePictureUrl: json['profilePictureUrl'] as String?,
  balance: doubleFromJson(json['balance']),
);

Map<String, dynamic> _$RiderProfileResponseToJson(
  RiderProfileResponse instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'profilePictureUrl': instance.profilePictureUrl,
  'balance': instance.balance,
};
