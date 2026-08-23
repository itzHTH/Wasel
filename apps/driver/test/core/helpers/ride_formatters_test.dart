import 'package:driver/core/helpers/ride_formatters.dart';
import 'package:driver/l10n/driver_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // The formatter now takes its copy from the ARB, so the assertions run
  // against the Arabic bundle they were written for.
  final l10n = lookupDriverLocalizations(const Locale('ar'));

  group('RideFormatters.fare', () {
    test('appends the symbol mapped to the currency code', () {
      expect(RideFormatters.fare(l10n, '12500'), '12,500 د.ع');
    });

    test('honours a currency passed by the caller', () {
      expect(RideFormatters.fare(l10n, '12500', currency: 'IQD'), '12,500 د.ع');
    });

    test('passes an unmapped currency code through verbatim', () {
      expect(RideFormatters.fare(l10n, '1200', currency: 'USD'), '1,200 USD');
    });

    test('groups thousands', () {
      expect(RideFormatters.fare(l10n, '1000000'), '1,000,000 د.ع');
      expect(RideFormatters.fare(l10n, '999'), '999 د.ع');
    });

    test('keeps the sign on a negative amount', () {
      expect(RideFormatters.fare(l10n, '-1500'), '-1,500 د.ع');
    });

    test('returns unparseable input unchanged, still with the symbol', () {
      expect(RideFormatters.fare(l10n, '—'), '— د.ع');
    });
  });

  group('RideFormatters.onlineDuration', () {
    test('drops the hours when the shift is under an hour', () {
      expect(RideFormatters.onlineDuration(l10n, 35), '35 د');
    });

    test('drops the minutes on a whole hour', () {
      expect(RideFormatters.onlineDuration(l10n, 120), '2 س');
    });

    test('keeps both halves otherwise', () {
      expect(RideFormatters.onlineDuration(l10n, 155), '2 س 35 د');
    });
  });

  group('RideFormatters in English', () {
    final en = lookupDriverLocalizations(const Locale('en'));

    test('swaps the currency symbol', () {
      expect(RideFormatters.fare(en, '12500'), '12,500 IQD');
    });

    test('swaps the duration units', () {
      expect(RideFormatters.onlineDuration(en, 155), '2h 35m');
    });
  });
}
