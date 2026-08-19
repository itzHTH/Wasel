import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/dio/dio_factory.dart';
import 'package:wasel_payments/data/repos/payments_repo.dart';
import 'package:wasel_payments/data/services/payments_api_service.dart';
import 'package:wasel_payments/domain/repos/base_payments_repo.dart';
import 'package:wasel_payments/domain/usecases/get_rider_wallet_balance_use_case.dart';
import 'package:wasel_payments/domain/usecases/tokenize_card_use_case.dart';

part 'payments_di_providers.g.dart';

@riverpod
PaymentsApiService paymentsApiService(Ref ref) {
  final dio = ref.watch(dioFactoryProvider);
  return PaymentsApiService(dio);
}

@riverpod
BasePaymentsRepo paymentsRepo(Ref ref) {
  final paymentsApiService = ref.watch(paymentsApiServiceProvider);
  return PaymentsRepo(paymentsApiService);
}

@riverpod
TokenizeCardUseCase tokenizeCardUseCase(Ref ref) {
  final paymentsRepo = ref.watch(paymentsRepoProvider);
  return TokenizeCardUseCase(paymentsRepo);
}

@riverpod
GetRiderWalletBalanceUseCase getRiderWalletBalanceUseCase(Ref ref) {
  final paymentsRepo = ref.watch(paymentsRepoProvider);
  return GetRiderWalletBalanceUseCase(paymentsRepo);
}
