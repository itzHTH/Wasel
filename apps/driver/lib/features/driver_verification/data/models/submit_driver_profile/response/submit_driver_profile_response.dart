import 'package:driver/features/driver_verification/domain/entities/submit_driver_profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submit_driver_profile_response.g.dart';

@JsonSerializable()
class SubmitDriverProfileResponse {
  @JsonKey(name: "data")
  String message;
  bool succeeded;

  SubmitDriverProfileResponse({required this.message, required this.succeeded});

  factory SubmitDriverProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$SubmitDriverProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitDriverProfileResponseToJson(this);

  SubmitDriverProfile toEntity() =>
      SubmitDriverProfile(message: message, succeeded: succeeded);
}
