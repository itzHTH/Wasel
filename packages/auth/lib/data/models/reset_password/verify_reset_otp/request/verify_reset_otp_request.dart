import 'package:json_annotation/json_annotation.dart';

part 'verify_reset_otp_request.g.dart';

@JsonSerializable(createFactory: false)
class VerifyResetOtpRequest {
  final String resetToken;
  final String otpCode;

  VerifyResetOtpRequest({required this.resetToken, required this.otpCode});

  Map<String, dynamic> toJson() => _$VerifyResetOtpRequestToJson(this);
}
