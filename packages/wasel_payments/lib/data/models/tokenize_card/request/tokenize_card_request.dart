import 'package:json_annotation/json_annotation.dart';

part 'tokenize_card_request.g.dart';

@JsonSerializable()
class TokenizeCardRequest {
  final String cardNumber;
  final String expiryMonth;
  final String expiryYear;
  final String cvv;

  TokenizeCardRequest({
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvv,
  });

  factory TokenizeCardRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenizeCardRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TokenizeCardRequestToJson(this);
}
