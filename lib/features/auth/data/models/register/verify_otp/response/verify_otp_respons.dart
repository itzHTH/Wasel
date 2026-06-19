import 'package:json_annotation/json_annotation.dart';
import 'package:wasal/features/auth/domain/entities/verify_otp.dart';

part 'verify_otp_respons.g.dart';

@JsonSerializable()
class VerifyOtpResponse {
  @JsonKey(name: "data")
  final String registerToken;

  VerifyOtpResponse({required this.registerToken});

  Map<String, dynamic> toJson() => _$VerifyOtpResponseToJson(this);

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseFromJson(json);

  VerifyOtp toEntity() {
    return VerifyOtp(registerToken: registerToken);
  }
}
