import 'package:driver/l10n/driver_localizations.dart';

/// Driver-side mirror of the rider's `RideFormatters`.
///
/// Signatures match the rider's 1:1 so the two can later collapse into a
/// single shared helper. The grouping is done without `intl` because the
/// driver app does not depend on it.
abstract final class RideFormatters {
  static final _groupSeparator = RegExp(r'(\d)(?=(\d{3})+$)');

  static String fare(
    DriverLocalizations l10n,
    String amount, {
    String currency = 'IQD',
  }) {
    final symbol = currency == 'IQD' ? l10n.currencyIqd : currency;
    final parsed = num.tryParse(amount);
    final formatted = parsed == null ? amount : _group(parsed);
    return '$formatted $symbol';
  }

  /// Reads a count of minutes back as "2h 35m", dropping the half that is
  /// zero so short shifts stay short to read.
  static String onlineDuration(DriverLocalizations l10n, num minutes) {
    final total = minutes.round();
    final hours = total ~/ 60;
    final remainder = total % 60;

    if (hours == 0) return l10n.durationMinutes('$remainder');
    if (remainder == 0) return l10n.durationHours('$hours');
    return l10n.durationHoursMinutes('$hours', '$remainder');
  }

  static String distance(DriverLocalizations l10n, String km) {
    final parsed = double.tryParse(km);
    final formatted = parsed == null ? km : parsed.toStringAsFixed(1);
    return l10n.distanceKm(formatted);
  }

  static String coordinates(
    DriverLocalizations l10n,
    double latitude,
    double longitude,
  ) => l10n.coordinatePair(
    latitude.toStringAsFixed(5),
    longitude.toStringAsFixed(5),
  );

  static String _group(num value) {
    final rounded = value.round().abs().toString();
    final grouped = rounded.replaceAllMapped(
      _groupSeparator,
      (match) => '${match[1]},',
    );
    return value.isNegative ? '-$grouped' : grouped;
  }
}
