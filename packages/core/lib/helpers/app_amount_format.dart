import 'package:intl/intl.dart' show NumberFormat;

const _currencySymbols = {'IQD': 'د.ع'};

/// Formats a money amount the one way the Wasel apps display money.
String formatAmount(double amount) =>
    NumberFormat.decimalPattern('ar').format(amount);

String currencySymbolOf(String currency) =>
    _currencySymbols[currency] ?? currency;

String formatAmountWithCurrency(double amount, {String currency = 'IQD'}) =>
    '${formatAmount(amount)} ${currencySymbolOf(currency)}';
