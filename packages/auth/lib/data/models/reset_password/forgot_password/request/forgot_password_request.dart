import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request.g.dart';

@JsonSerializable(createFactory: false)
class ForgotPasswordRequest {
  final String email;

  ForgotPasswordRequest({required this.email});

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
}
