import 'package:json_annotation/json_annotation.dart';
import 'package:wasel_payments/domain/entities/wallet_balance.dart';

part 'wallet_balance_response.g.dart';

@JsonSerializable()
class WalletBalanceResponse {
  final double balance;

  WalletBalanceResponse({required this.balance});

  factory WalletBalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletBalanceResponseFromJson(json["data"] as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$WalletBalanceResponseToJson(this);

  WalletBalance toEntity() => WalletBalance(balance: balance);
}
