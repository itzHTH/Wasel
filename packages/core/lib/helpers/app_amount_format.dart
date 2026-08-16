import 'package:intl/intl.dart' show NumberFormat;

/// Formats a money amount the one way the Wasel apps display money.
String formatAmount(double amount) =>
    NumberFormat.decimalPattern('ar').format(amount);
