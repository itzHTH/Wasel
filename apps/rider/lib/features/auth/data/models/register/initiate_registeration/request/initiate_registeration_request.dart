import 'package:json_annotation/json_annotation.dart';

part 'initiate_registeration_request.g.dart';

@JsonSerializable()
class InitiateRegisterationRequest {
  final String email;

  InitiateRegisterationRequest({required this.email});

  Map<String, dynamic> toJson() => _$InitiateRegisterationRequestToJson(this);
}
