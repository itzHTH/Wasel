import 'package:intl/intl.dart';

abstract final class RideFormatters {
  static final _grouped = NumberFormat.decimalPattern('en');

  static const _currencySymbols = {'IQD': 'د.ع'};

  static String fare(String amount, {String currency = 'IQD'}) {
    final symbol = _currencySymbols[currency] ?? currency;
    final parsed = num.tryParse(amount);
    final formatted = parsed == null ? amount : _grouped.format(parsed);
    return '$formatted $symbol';
  }

  static String distance(String km) {
    final parsed = double.tryParse(km);
    final formatted = parsed == null ? km : parsed.toStringAsFixed(1);
    return '$formatted كم';
  }
}
