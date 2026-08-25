import 'package:dio/dio.dart';
import 'package:driver/features/driver_earnings/domain/entities/driver_balance.dart';
import 'package:driver/features/driver_earnings/domain/entities/driver_earnings.dart';
import 'package:driver/features/driver_earnings/domain/entities/earnings_period.dart';
import 'package:wasel_core/networking/api_results.dart';

abstract class BaseDriverEarningsRepo {
  Future<ApiResults<DriverEarnings>> getDriverEarnings(
    EarningsPeriod period, {
    CancelToken? cancelToken,
  });

  Future<ApiResults<DriverBalance>> getDriverWalletBalance({
    CancelToken? cancelToken,
  });
}
