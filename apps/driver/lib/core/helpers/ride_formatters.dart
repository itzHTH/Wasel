/// Driver-side mirror of the rider's `RideFormatters`.
///
/// Signatures match the rider's 1:1 so the two can later collapse into a
/// single shared helper. The grouping is done without `intl` because the
/// driver app does not depend on it.
abstract final class RideFormatters {
  static const _currencySymbols = {'IQD': 'د.ع'};

  static final _groupSeparator = RegExp(r'(\d)(?=(\d{3})+$)');

  static String fareWithCurrency(String amount, {String currency = 'IQD'}) {
    final symbol = _currencySymbols[currency] ?? currency;
    final parsed = num.tryParse(amount);
    final formatted = parsed == null ? amount : _group(parsed);
    return '$formatted $symbol';
  }

  static String fare(String amount, {String currency = 'IQD'}) {
    final parsed = num.tryParse(amount);
    final formatted = parsed == null ? amount : _group(parsed);
    return formatted;
  }

  static String distance(String km) {
    final parsed = double.tryParse(km);
    final formatted = parsed == null ? km : parsed.toStringAsFixed(1);
    return '$formatted كم';
  }

  static String coordinates(double latitude, double longitude) =>
      '${latitude.toStringAsFixed(5)}، ${longitude.toStringAsFixed(5)}';

  static String _group(num value) {
    final rounded = value.round().abs().toString();
    final grouped = rounded.replaceAllMapped(
      _groupSeparator,
      (match) => '${match[1]},',
    );
    return value.isNegative ? '-$grouped' : grouped;
  }
}
