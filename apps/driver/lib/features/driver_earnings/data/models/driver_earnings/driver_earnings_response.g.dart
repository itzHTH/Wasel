// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_earnings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverEarningsResponse _$DriverEarningsResponseFromJson(
  Map<String, dynamic> json,
) => DriverEarningsResponse(
  completedRides: (json['completedRides'] as num).toInt(),
  totalEarnings: json['totalEarnings'] as num,
  onlineMinutes: json['onlineMinutes'] as num,
  canCashOut: json['canCashOut'] as bool,
);
