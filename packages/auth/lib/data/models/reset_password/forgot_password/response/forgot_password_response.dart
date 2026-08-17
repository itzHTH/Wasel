import 'package:json_annotation/json_annotation.dart';
import 'package:wasel_auth/domain/entities/forgot_password.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  @JsonKey(name: "data")
  final String? resetToken;

  ForgotPasswordResponse({required this.resetToken});

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  // `data` is nullable so a token-less 200 is malformed, not success.
  ForgotPassword toEntity() {
    final token = resetToken;
    if (token == null || token.isEmpty) {
      throw const FormatException('forgot-password returned no reset token');
    }
    return ForgotPassword(resetToken: token);
  }
}
