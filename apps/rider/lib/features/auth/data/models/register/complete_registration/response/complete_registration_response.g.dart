// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_registration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteRegistrationResponse _$CompleteRegistrationResponseFromJson(
  Map<String, dynamic> json,
) => CompleteRegistrationResponse(
  isAuthenticated: json['isAuthenticated'] as bool,
  userName: json['userName'] as String?,
  email: json['email'] as String,
  roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
  token: json['token'] as String,
  expiresOn: DateTime.parse(json['expiresOn'] as String),
  refreshToken: json['refreshToken'] as String,
  refreshTokenExpiration: DateTime.parse(
    json['refreshTokenExpiration'] as String,
  ),
);

Map<String, dynamic> _$CompleteRegistrationResponseToJson(
  CompleteRegistrationResponse instance,
) => <String, dynamic>{
  'isAuthenticated': instance.isAuthenticated,
  'userName': instance.userName,
  'email': instance.email,
  'roles': instance.roles,
  'token': instance.token,
  'expiresOn': instance.expiresOn.toIso8601String(),
  'refreshToken': instance.refreshToken,
  'refreshTokenExpiration': instance.refreshTokenExpiration.toIso8601String(),
};
