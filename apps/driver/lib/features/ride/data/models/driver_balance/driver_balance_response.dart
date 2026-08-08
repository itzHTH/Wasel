import 'package:driver/features/ride/domain/entities/driver_balance.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_balance_response.g.dart';

@JsonSerializable()
class DriverBalanceResponse {
  final double balance;

  DriverBalanceResponse({required this.balance});

  factory DriverBalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverBalanceResponseFromJson(json["data"] as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$DriverBalanceResponseToJson(this);

  toEntity() {
    return DriverBalance(balance: balance);
  }
}
