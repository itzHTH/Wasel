import 'package:driver/features/driver_earnings/domain/entities/driver_balance.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_balance_response.g.dart';

@JsonSerializable(createToJson: false)
class DriverBalanceResponse {
  DriverBalanceResponse({required this.balance});

  factory DriverBalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverBalanceResponseFromJson(json["data"] as Map<String, dynamic>);

  final double balance;

  DriverBalance toEntity() => DriverBalance(balance: balance);
}
