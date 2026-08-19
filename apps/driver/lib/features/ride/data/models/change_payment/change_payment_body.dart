import 'package:json_annotation/json_annotation.dart';

part 'change_payment_body.g.dart';

@JsonSerializable()
class ChangePaymentBody {
  final int newPaymentMethod;

  ChangePaymentBody({required this.newPaymentMethod});

  factory ChangePaymentBody.fromJson(Map<String, dynamic> json) =>
      _$ChangePaymentBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePaymentBodyToJson(this);
}
