import 'package:wasel_payments/domain/entities/payment_blocker.dart';
import 'package:wasel_payments/domain/entities/payment_method.dart';
import 'package:wasel_payments/l10n/payments_localizations.dart';

/// Display copy for the payment vocabulary. Kept out of the entities so the
/// domain layer carries no user-facing text.
extension PaymentMethodLabel on PaymentMethod {
  String label(PaymentsLocalizations l10n) => switch (this) {
    PaymentMethod.cash => l10n.paymentMethodCash,
    PaymentMethod.card => l10n.paymentMethodCard,
    PaymentMethod.wallet => l10n.paymentMethodWallet,
    PaymentMethod.unknown => l10n.paymentMethodUnknown,
  };
}

extension PaymentBlockerMessage on PaymentBlocker {
  String message(PaymentsLocalizations l10n) => switch (this) {
    PaymentBlocker.missingCard => l10n.addCardBeforeConfirming,
    PaymentBlocker.insufficientWallet => l10n.walletBalanceTooLow,
  };
}
