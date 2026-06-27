import 'package:driver/features/driver_verification/domain/entities/verification_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_verification_status_response.g.dart';

@JsonSerializable()
class GetVerificationStatusResponse {
  int data;
  String message;

  GetVerificationStatusResponse({required this.data, required this.message});

  factory GetVerificationStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$GetVerificationStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetVerificationStatusResponseToJson(this);

  VerificationStatus toEntity() {
    return VerificationStatus(
      message: message,
      status: enVerificationStatus.fromCode(data),
    );
  }
}
