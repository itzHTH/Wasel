import 'package:json_annotation/json_annotation.dart';
import 'package:wasal/features/auth/domain/entities/initiate_registeration.dart';

part 'initiate_registeration_response.g.dart';

@JsonSerializable()
class InitiateRegisterationResponse {
  @JsonKey(name: "data")
  final String registerToken;

  InitiateRegisterationResponse({required this.registerToken});

  Map<String, dynamic> toJson() => _$InitiateRegisterationResponseToJson(this);

  factory InitiateRegisterationResponse.fromJson(Map<String, dynamic> json) =>
      _$InitiateRegisterationResponseFromJson(json);

  InitiateRegisteration toEntity() {
    return InitiateRegisteration(registerToken: registerToken);
  }
}
