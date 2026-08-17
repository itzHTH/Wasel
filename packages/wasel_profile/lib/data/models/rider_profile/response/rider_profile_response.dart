import 'package:json_annotation/json_annotation.dart';
import 'package:wasel_profile/data/models/json_num_converters.dart';
import 'package:wasel_profile/domain/entities/rider_profile.dart';

part 'rider_profile_response.g.dart';

@JsonSerializable()
class RiderProfileResponse {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? profilePictureUrl;

  @JsonKey(fromJson: doubleFromJson)
  final double balance;

  RiderProfileResponse({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.profilePictureUrl,
    required this.balance,
  });

  factory RiderProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$RiderProfileResponseFromJson(json['data'] as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$RiderProfileResponseToJson(this);

  RiderProfile toEntity() {
    return RiderProfile(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      profilePictureUrl: profilePictureUrl,
      balance: balance,
    );
  }
}
