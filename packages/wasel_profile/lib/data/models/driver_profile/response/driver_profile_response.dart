import 'package:json_annotation/json_annotation.dart';
import 'package:wasel_profile/data/models/json_num_converters.dart';
import 'package:wasel_profile/domain/entities/driver_approval_status.dart';
import 'package:wasel_profile/domain/entities/driver_profile.dart';

part 'driver_profile_response.g.dart';

@JsonSerializable()
class DriverProfileResponse {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? profilePictureUrl;

  @JsonKey(fromJson: doubleFromJson)
  final double averageRating;

  @JsonKey(fromJson: intFromJson)
  final int totalReviews;

  @JsonKey(
    fromJson: driverApprovalStatusFromJson,
    toJson: driverApprovalStatusToJson,
  )
  final DriverApprovalStatus approvalStatus;

  final String? city;
  final String? address;

  @JsonKey(fromJson: doubleFromJson)
  final double balance;

  DriverProfileResponse({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.profilePictureUrl,
    required this.averageRating,
    required this.totalReviews,
    required this.approvalStatus,
    this.city,
    this.address,
    required this.balance,
  });

  factory DriverProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverProfileResponseFromJson(json['data'] as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$DriverProfileResponseToJson(this);

  DriverProfile toEntity() {
    return DriverProfile(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      profilePictureUrl: profilePictureUrl,
      averageRating: averageRating,
      totalReviews: totalReviews,
      approvalStatus: approvalStatus,
      city: city,
      address: address,
      balance: balance,
    );
  }
}
