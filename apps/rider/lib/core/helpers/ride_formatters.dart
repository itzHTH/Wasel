import 'package:intl/intl.dart';
import 'package:wasal/l10n/rider_localizations.dart';

abstract final class RideFormatters {
  static final _grouped = NumberFormat.decimalPattern('en');

  static String fare(
    RiderLocalizations l10n,
    num amount, {
    String currency = 'IQD',
  }) {
    final symbol = currency == 'IQD' ? l10n.currencyIqd : currency;
    return '${_grouped.format(amount)} $symbol';
  }

  static String distance(RiderLocalizations l10n, String km) {
    final parsed = double.tryParse(km);
    final formatted = parsed == null ? km : parsed.toStringAsFixed(1);
    return l10n.distanceKm(formatted);
  }

  static String coordinates(
    RiderLocalizations l10n,
    double latitude,
    double longitude,
  ) => l10n.coordinatePair(
    latitude.toStringAsFixed(5),
    longitude.toStringAsFixed(5),
  );
}
