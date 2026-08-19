import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_payments/domain/entities/wallet_balance.dart';
import 'package:wasel_payments/presentation/providers/payments_di_providers.dart';

part 'rider_wallet_balance_provider.g.dart';

Duration? _noRetry(int retryCount, Object error) => null;

@Riverpod(keepAlive: true, retry: _noRetry)
class RiderWalletBalanceController extends _$RiderWalletBalanceController {
  @override
  FutureOr<WalletBalance> build() async {
    final useCase = ref.read(getRiderWalletBalanceUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(null);

    return result.when(
      success: (balance) => balance,
      failure: (error) => throw error,
    );
  }

  void refresh() => ref.invalidateSelf();
}
