import 'package:driver/features/driver_earnings/data/repos/driver_earnings_repo.dart';
import 'package:driver/features/driver_earnings/domain/use_case/get_driver_balance_use_case.dart';
import 'package:driver/features/driver_earnings/domain/use_case/get_driver_earnings_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'driver_earnings_di_providers.g.dart';

@riverpod
GetDriverEarningsUseCase getDriverEarningsUseCase(Ref ref) {
  final repo = ref.watch(driverEarningsRepoProvider);
  return GetDriverEarningsUseCase(repo);
}

@riverpod
GetDriverBalanceUseCase getDriverBalanceUseCase(Ref ref) {
  final repo = ref.watch(driverEarningsRepoProvider);
  return GetDriverBalanceUseCase(repo);
}
