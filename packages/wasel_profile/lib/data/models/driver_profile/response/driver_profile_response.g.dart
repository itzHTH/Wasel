// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverProfileResponse _$DriverProfileResponseFromJson(
  Map<String, dynamic> json,
) => DriverProfileResponse(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  email: json['email'] as String,
  phoneNumber: json['phoneNumber'] as String,
  profilePictureUrl: json['profilePictureUrl'] as String?,
  averageRating: doubleFromJson(json['averageRating']),
  totalReviews: intFromJson(json['totalReviews']),
  approvalStatus: driverApprovalStatusFromJson(json['approvalStatus']),
  city: json['city'] as String?,
  address: json['address'] as String?,
  balance: doubleFromJson(json['balance']),
);

Map<String, dynamic> _$DriverProfileResponseToJson(
  DriverProfileResponse instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'profilePictureUrl': instance.profilePictureUrl,
  'averageRating': instance.averageRating,
  'totalReviews': instance.totalReviews,
  'approvalStatus': driverApprovalStatusToJson(instance.approvalStatus),
  'city': instance.city,
  'address': instance.address,
  'balance': instance.balance,
};
