import 'package:json_annotation/json_annotation.dart';
import 'package:wasel_core/networking/errors/api_error_reason.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  bool? succeeded;
  String? message;
  dynamic data;
  Map<String, List<String>>? errors;

  /// Set for failures decided on the device; never parsed from or sent to the
  /// API, which describes its own failures in [message] and [errors].
  @JsonKey(includeFromJson: false, includeToJson: false)
  ApiErrorReason? reason;

  ApiErrorModel({
    this.succeeded,
    this.message,
    this.data,
    this.errors,
    this.reason,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
}
