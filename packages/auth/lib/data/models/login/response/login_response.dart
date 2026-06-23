import 'package:json_annotation/json_annotation.dart';
import 'package:wasel_auth/domain/entities/login.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final bool isAuthenticated;
  final String? userName;
  final String email;
  final List<String> roles;
  final String token;
  final DateTime expiresOn;
  final String refreshToken;
  final DateTime refreshTokenExpiration;

  LoginResponse({
    required this.isAuthenticated,
    required this.userName,
    required this.email,
    required this.roles,
    required this.token,
    required this.expiresOn,
    required this.refreshToken,
    required this.refreshTokenExpiration,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json['data'] as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  Login toEntity() {
    return Login(
      isAuthenticated: isAuthenticated,
      userName: userName,
      email: email,
    );
  }
}
