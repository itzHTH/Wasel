import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:intl/intl.dart' show NumberFormat;

/// Formats a money amount the one way the Wasel apps display money.
String formatAmount(double amount) =>
    NumberFormat.decimalPattern('ar').format(amount);

/// Only IQD has a symbol of its own; anything else shows its code.
String _currencySymbolOf(String currency) =>
    currency == 'IQD' ? coreL10nNow.currencyIqd : currency;

String formatAmountWithCurrency(double amount, {String currency = 'IQD'}) =>
    '${formatAmount(amount)} ${_currencySymbolOf(currency)}';
