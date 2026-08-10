import 'package:driver/features/ride/domain/entities/driver_earnings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_earnings_response.g.dart';

@JsonSerializable()
class DriverEarningsResponse {
  final int completedRides;
  final num totalEarnings;
  final num onlineMinutes;
  final bool canCashOut;

  DriverEarningsResponse({
    required this.completedRides,
    required this.totalEarnings,
    required this.onlineMinutes,
    required this.canCashOut,
  });

  factory DriverEarningsResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverEarningsResponseFromJson(json["data"] as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$DriverEarningsResponseToJson(this);

  DriverEarnings toEntity() {
    return DriverEarnings(
      completedRides: completedRides,
      totalEarnings: totalEarnings,
      onlineMinutes: onlineMinutes,
      canCashOut: canCashOut,
    );
  }
}
