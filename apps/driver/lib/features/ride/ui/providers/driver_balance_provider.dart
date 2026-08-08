import 'package:dio/dio.dart';
import 'package:driver/features/ride/ui/providers/ride_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';

part 'driver_balance_provider.g.dart';

@riverpod
class DriverBalanceController extends _$DriverBalanceController {
  @override
  double build() {
    return 0.0;
  }

  void getDriverBalance() async {
    final useCase = ref.read(getDriverBalanceUseCaseProvider);
    final result = await useCase.execute(null, CancelToken());
    result.when(
      success: (data) {
        state = data.balance;
      },
      failure: (error) {
        state = -0.0;
      },
    );
  }
}
