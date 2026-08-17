import 'package:json_annotation/json_annotation.dart';
import 'package:wasel_auth/domain/entities/reset_password.dart';

part 'reset_password_response.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  @JsonKey(name: 'data', defaultValue: false)
  final bool success;

  ResetPasswordResponse({required this.success});

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  ResetPassword toEntity() => ResetPassword(success: success);
}
