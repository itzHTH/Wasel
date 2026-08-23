import 'package:wasel_payments/l10n/payments_l10n_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_payments/domain/usecases/tokenize_card_use_case.dart';
import 'package:wasel_payments/data/models/tokenize_card/request/tokenize_card_request.dart';
import 'package:wasel_payments/presentation/providers/payments_di_providers.dart';

part 'tokenize_card_provider.g.dart';

/// Holds the payment token only. Card details are never stored: they live in
/// the form's controllers and are gone once the sheet is disposed.
@Riverpod(keepAlive: true)
class TokenizeCardController extends _$TokenizeCardController {
  // Not late final: reset() re-runs build() on this same notifier instance,
  // and watching keeps one use case alive so cancel reaches the live request.
  late TokenizeCardUseCase _useCase;

  @override
  FutureOr<String?> build() {
    _useCase = ref.watch(tokenizeCardUseCaseProvider);
    ref.onDispose(_useCase.cancel);
    return null;
  }

  Future<void> tokenize({
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String cvv,
  }) async {
    if (state.isLoading) return;

    state = const AsyncValue.loading();

    final ApiResults<String?> result;
    try {
      result = await _useCase.call(
        TokenizeCardRequest(
          cardNumber: cardNumber,
          expiryMonth: expiryMonth,
          expiryYear: expiryYear,
          cvv: cvv,
        ),
      );
    } catch (error, stackTrace) {
      // Without this the state would stay loading and the sheet would sit
      // on a spinner with nothing to explain it.
      if (ref.mounted) {
        state = AsyncValue.error(
          errorMessageOf(
            ErrorHandler.handle(error),
            fallback: paymentsL10nNow.cardVerificationFailed,
          ),
          stackTrace,
        );
      }
      return;
    }

    if (!ref.mounted) return;

    state = result.when(
      failure: (error) => AsyncValue.error(
        errorMessageOf(error, fallback: paymentsL10nNow.cardVerificationFailed),
        StackTrace.current,
      ),
      success: (token) => token == null
          ? AsyncValue.error(
              paymentsL10nNow.cardVerificationFailed,
              StackTrace.current,
            )
          : AsyncValue.data(token),
    );
  }

  /// Drops any in-flight request along with the state, so a sheet reopened
  /// after a dismissal never inherits a spinner or a stale error.
  void reset() {
    _useCase.cancel();
    ref.invalidateSelf();
  }
}
