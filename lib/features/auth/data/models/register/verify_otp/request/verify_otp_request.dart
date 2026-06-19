import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request.g.dart';

@JsonSerializable()
class VerifyOtpRequest {
  String sessionToken;
  String otpCode;

  VerifyOtpRequest({required this.sessionToken, required this.otpCode});

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);
}
