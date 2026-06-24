import 'package:json_annotation/json_annotation.dart';

part 'complete_registration_request.g.dart';

@JsonSerializable(createFactory: false)
class CompleteRegistrationRequest {
  final String registerToken;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String password;

  /// Driver-only fields. The rider app leaves them null, in which case they are
  /// omitted from the payload entirely (see [JsonKey.includeIfNull]).
  @JsonKey(includeIfNull: false)
  final String? city;
  @JsonKey(includeIfNull: false)
  final String? address;

  CompleteRegistrationRequest({
    required this.registerToken,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.password,
    this.city,
    this.address,
  });

  Map<String, dynamic> toJson() => _$CompleteRegistrationRequestToJson(this);
}
