import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

/// The `ApiResponse<T>` envelope for endpoints whose payload we do not read.
@JsonSerializable(createToJson: false)
class BaseResponse {
  @JsonKey(defaultValue: true)
  final bool succeeded;

  final String? message;

  const BaseResponse({required this.succeeded, this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);
}
