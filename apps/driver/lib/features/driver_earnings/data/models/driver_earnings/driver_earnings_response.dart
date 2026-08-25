import 'package:driver/features/driver_earnings/domain/entities/driver_earnings.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_earnings_response.g.dart';

@JsonSerializable(createToJson: false)
class DriverEarningsResponse {
  DriverEarningsResponse({
    required this.completedRides,
    required this.totalEarnings,
    required this.onlineMinutes,
    required this.canCashOut,
  });

  /// Unwraps the `ApiResponse<T>` envelope; only `data` is ours.
  factory DriverEarningsResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverEarningsResponseFromJson(json["data"] as Map<String, dynamic>);

  final int completedRides;
  final num totalEarnings;
  final num onlineMinutes;
  final bool canCashOut;

  DriverEarnings toEntity() {
    return DriverEarnings(
      completedRides: completedRides,
      totalEarnings: totalEarnings,
      onlineMinutes: onlineMinutes,
      canCashOut: canCashOut,
    );
  }
}
