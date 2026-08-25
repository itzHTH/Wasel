import 'package:dio/dio.dart';
import 'package:driver/features/driver_earnings/data/models/driver_balance/driver_balance_response.dart';
import 'package:driver/features/driver_earnings/data/models/driver_earnings/driver_earnings_response.dart';
import 'package:driver/features/driver_earnings/data/repos/driver_earnings_repo.dart';
import 'package:driver/features/driver_earnings/data/services/driver_earnings_api_service.dart';
import 'package:driver/features/driver_earnings/domain/entities/earnings_period.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/api_error_reason.dart';

/// Answers with whatever the test hands it, so the repo's mapping and error
/// boundary can be exercised without a socket.
class _FakeEarningsApi implements DriverEarningsApiService {
  _FakeEarningsApi({this.earnings, this.balance, this.error});

  final DriverEarningsResponse? earnings;
  final DriverBalanceResponse? balance;
  final Object? error;

  DateTime? seenStartDate;
  DateTime? seenEndDate;

  @override
  Future<DriverEarningsResponse> getDriverEarnings({
    DateTime? startDate,
    DateTime? endDate,
    CancelToken? cancelToken,
  }) async {
    seenStartDate = startDate;
    seenEndDate = endDate;
    if (error != null) throw error!;
    return earnings!;
  }

  @override
  Future<DriverBalanceResponse> getDriverWalletBalance({
    CancelToken? cancelToken,
  }) async {
    if (error != null) throw error!;
    return balance!;
  }
}

DioException _dioError(DioExceptionType type) => DioException(
  requestOptions: RequestOptions(path: '/api/v1/DriverEarnings/overview'),
  type: type,
);

void main() {
  group('getDriverEarnings', () {
    test('maps a successful response onto the entity', () async {
      final api = _FakeEarningsApi(
        earnings: DriverEarningsResponse(
          completedRides: 7,
          totalEarnings: 84500,
          onlineMinutes: 315,
          canCashOut: true,
        ),
      );

      final result = await DriverEarningsRepo(
        api,
      ).getDriverEarnings(EarningsPeriod.forRange(EarningsRange.today));

      final earnings = (result as Success).data;
      expect(earnings.completedRides, 7);
      expect(earnings.totalEarnings, 84500);
      expect(earnings.onlineMinutes, 315);
      expect(earnings.canCashOut, isTrue);
    });

    test('passes the period through as the query window', () async {
      final api = _FakeEarningsApi(
        earnings: DriverEarningsResponse(
          completedRides: 0,
          totalEarnings: 0,
          onlineMinutes: 0,
          canCashOut: false,
        ),
      );
      final period = EarningsPeriod.forRange(
        EarningsRange.last7Days,
        now: DateTime(2026, 3, 15, 14, 30),
      );

      await DriverEarningsRepo(api).getDriverEarnings(period);

      expect(api.seenStartDate, period.start);
      expect(api.seenEndDate, period.end);
    });

    test('catches a transport failure at the boundary', () async {
      final api = _FakeEarningsApi(
        error: _dioError(DioExceptionType.connectionTimeout),
      );

      final result = await DriverEarningsRepo(
        api,
      ).getDriverEarnings(EarningsPeriod.today());

      expect(result, isA<Failure>());
      expect(
        (result as Failure).error.apiErrorModel.reason,
        ApiErrorReason.timeout,
      );
    });

    test('reports a cancelled request as cancelled', () async {
      final api = _FakeEarningsApi(error: _dioError(DioExceptionType.cancel));

      final result = await DriverEarningsRepo(
        api,
      ).getDriverEarnings(EarningsPeriod.today());

      expect((result as Failure).error.isCancelled, isTrue);
    });
  });

  group('getDriverWalletBalance', () {
    test('maps a successful response onto the entity', () async {
      final api = _FakeEarningsApi(
        balance: DriverBalanceResponse(balance: -12500.5),
      );

      final result = await DriverEarningsRepo(api).getDriverWalletBalance();

      // Drivers carry cash-ride debt, so a negative balance is a real answer.
      expect((result as Success).data.balance, -12500.5);
    });

    test('catches a transport failure at the boundary', () async {
      final api = _FakeEarningsApi(
        error: _dioError(DioExceptionType.badCertificate),
      );

      final result = await DriverEarningsRepo(api).getDriverWalletBalance();

      expect(result, isA<Failure>());
    });
  });
}
