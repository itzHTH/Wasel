import 'package:json_annotation/json_annotation.dart';
import 'package:wasel_auth/domain/entities/logout.dart';

part 'logout_response.g.dart';

@JsonSerializable()
class LogoutResponse {
  @JsonKey(name: 'data', defaultValue: false)
  bool success;

  LogoutResponse({this.success = true});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LogoutResponseToJson(this);

  Logout toEntity() {
    return Logout(success: success);
  }
}
