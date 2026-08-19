import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/selected_payment_method_provider.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_payments/presentation/providers/tokenize/tokenize_card_provider.dart';
import 'package:wasel_payments/presentation/providers/wallet/rider_wallet_balance_provider.dart';
import 'package:wasel_auth/domain/usecases/logout_use_case.dart';
import 'package:wasel_auth/providers/auth_use_case_providers.dart';

part 'logout.g.dart';

@riverpod
class Logout extends _$Logout {
  late final LogoutUseCase _useCase;

  @override
  Future<bool> build() async {
    // Held so cancel-on-dispose targets the instance that runs the request.
    _useCase = ref.read(logoutUseCaseProvider);
    ref.onDispose(_useCase.cancel);
    return false; // Initial state is false, indicating not logged out
  }

  /// Always reports the device as signed out: the repo drops the local session
  /// even when revoking the refresh token server-side fails.
  Future<bool> execute() async {
    state = const AsyncValue.loading();

    final result = await _useCase.call(null);

    // These outlive the session otherwise: the ProviderScope sits above the
    // navigator, so the next account would inherit this account's card.
    ref.invalidate(tokenizeCardControllerProvider);
    ref.invalidate(selectedPaymentMethodProvider);
    ref.invalidate(riderWalletBalanceControllerProvider);

    if (!ref.mounted) return true;

    result.when(
      success: (data) => state = AsyncValue.data(data.success),
      failure: (error) =>
          state = AsyncValue.error(errorMessageOf(error), StackTrace.current),
    );

    return true;
  }
}
