import 'package:json_annotation/json_annotation.dart';

part 'tokenize_card_response.g.dart';

@JsonSerializable()
class TokenizeCardResponse {
  @JsonKey(name: "data")
  final String? token;

  TokenizeCardResponse({this.token});

  factory TokenizeCardResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenizeCardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenizeCardResponseToJson(this);

  String? toEntity() => token;
}
