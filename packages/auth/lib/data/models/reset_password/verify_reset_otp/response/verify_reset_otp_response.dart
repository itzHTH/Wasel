import 'package:json_annotation/json_annotation.dart';
import 'package:wasel_auth/domain/entities/verify_reset_otp.dart';

part 'verify_reset_otp_response.g.dart';

@JsonSerializable()
class VerifyResetOtpResponse {
  @JsonKey(name: "data")
  final String? resetToken;

  VerifyResetOtpResponse({required this.resetToken});

  Map<String, dynamic> toJson() => _$VerifyResetOtpResponseToJson(this);

  factory VerifyResetOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetOtpResponseFromJson(json);

  // `data` is nullable so a token-less 200 is malformed, not success.
  VerifyResetOtp toEntity() {
    final token = resetToken;
    if (token == null || token.isEmpty) {
      throw const FormatException('verify-reset-otp returned no reset token');
    }
    return VerifyResetOtp(resetToken: token);
  }
}
