import 'package:wasel_payments/domain/entities/payment_blocker.dart';
import 'package:wasel_payments/domain/entities/payment_method.dart';

/// Decides whether a ride may be requested with the chosen payment method, so
/// the selector and the request itself can never disagree about it.
abstract final class PaymentEligibilityPolicy {
  static bool requiresCard(PaymentMethod method, String? token) =>
      method == PaymentMethod.card && token == null;

  static PaymentBlocker? blockerFor({
    required PaymentMethod method,
    String? token,
    double? balance,
    num? fare,
  }) {
    if (requiresCard(method, token)) return PaymentBlocker.missingCard;

    if (method != PaymentMethod.wallet) return null;

    // A figure we could not read is not a balance of zero: leave the server as
    // the authority rather than blocking the rider on what we failed to fetch.
    if (balance == null || fare == null) return null;

    return balance < fare ? PaymentBlocker.insufficientWallet : null;
  }
}
