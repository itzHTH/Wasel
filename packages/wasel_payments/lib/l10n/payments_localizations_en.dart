// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'payments_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class PaymentsLocalizationsEn extends PaymentsLocalizations {
  PaymentsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get paymentMethodCash => 'Cash';

  @override
  String get paymentMethodCard => 'Card';

  @override
  String get paymentMethodWallet => 'Wallet';

  @override
  String get paymentMethodUnknown => 'Not selected';

  @override
  String get addCardBeforeConfirming =>
      'Add a card before confirming your ride';

  @override
  String get walletBalanceTooLow =>
      'Your wallet balance doesn\'t cover this ride';

  @override
  String get cardVerificationFailed => 'We couldn\'t verify your card';
}
