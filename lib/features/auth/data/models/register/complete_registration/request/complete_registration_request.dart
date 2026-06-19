import 'package:json_annotation/json_annotation.dart';

part 'complete_registration_request.g.dart';

@JsonSerializable()
class CompleteRegistrationRequest {
  final String registrationToken;
  final String firstName;
  final String lastName;
  final String phone;
  final String password;

  CompleteRegistrationRequest({
    required this.registrationToken,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$CompleteRegistrationRequestToJson(this);
}
