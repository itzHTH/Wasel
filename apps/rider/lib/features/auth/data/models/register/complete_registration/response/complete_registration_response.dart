import 'package:json_annotation/json_annotation.dart';
import 'package:wasal/features/auth/domain/entities/complete_registration.dart';

part 'complete_registration_response.g.dart';

@JsonSerializable()
class CompleteRegistrationResponse {
  final bool isAuthenticated;
  final String? userName;
  final String email;
  final List<String> roles;
  final String token;
  final DateTime expiresOn;
  final String refreshToken;
  final DateTime refreshTokenExpiration;

  CompleteRegistrationResponse({
    required this.isAuthenticated,
    required this.userName,
    required this.email,
    required this.roles,
    required this.token,
    required this.expiresOn,
    required this.refreshToken,
    required this.refreshTokenExpiration,
  });

  factory CompleteRegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$CompleteRegistrationResponseFromJson(
        json['data'] as Map<String, dynamic>,
      );

  Map<String, dynamic> toJson() => _$CompleteRegistrationResponseToJson(this);

  CompleteRegistration toEntity() {
    return CompleteRegistration(
      isAuthenticated: isAuthenticated,
      userName: userName,
      email: email,
    );
  }
}
