import 'package:json_annotation/json_annotation.dart';

part 'complete_registration_request.g.dart';

@JsonSerializable(createFactory: false)
class CompleteRegistrationRequest {
  final String registerToken;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String password;

  CompleteRegistrationRequest({
    required this.registerToken,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$CompleteRegistrationRequestToJson(this);
}
