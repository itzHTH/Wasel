import 'package:driver/features/driver_earnings/domain/entities/earnings_period.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Mid-afternoon, so a start pinned to midnight is visibly different from now.
  final now = DateTime(2026, 3, 15, 14, 30, 45);

  group('EarningsPeriod.forRange', () {
    test('sends UTC instants', () {
      // A local DateTime serialises with no offset and is read as UTC by the
      // server, shifting the whole window by the driver's timezone.
      for (final range in EarningsRange.values) {
        final period = EarningsPeriod.forRange(range, now: now);

        expect(period.start!.isUtc, isTrue, reason: '$range start');
        expect(period.end!.isUtc, isTrue, reason: '$range end');
        expect(period.start!.toIso8601String(), endsWith('Z'));
      }
    });

    test('ends at the given moment for every range', () {
      for (final range in EarningsRange.values) {
        expect(EarningsPeriod.forRange(range, now: now).end, now.toUtc());
      }
    });

    test('today starts at local midnight of the same day', () {
      final period = EarningsPeriod.forRange(EarningsRange.today, now: now);

      expect(period.start, DateTime(2026, 3, 15).toUtc());
    });

    test('last 7 days spans seven calendar days including today', () {
      final period = EarningsPeriod.forRange(EarningsRange.last7Days, now: now);

      expect(period.start, DateTime(2026, 3, 9).toUtc());
    });

    test('last 30 days spans thirty calendar days including today', () {
      final period = EarningsPeriod.forRange(
        EarningsRange.last30Days,
        now: now,
      );

      expect(period.start, DateTime(2026, 2, 14).toUtc());
    });

    test('crosses a month boundary without drifting', () {
      final period = EarningsPeriod.forRange(
        EarningsRange.last7Days,
        now: DateTime(2026, 3, 2, 9),
      );

      expect(period.start, DateTime(2026, 2, 24).toUtc());
    });

    test('crosses a year boundary without drifting', () {
      final period = EarningsPeriod.forRange(
        EarningsRange.last30Days,
        now: DateTime(2026, 1, 10, 9),
      );

      expect(period.start, DateTime(2025, 12, 12).toUtc());
    });
  });

  test('EarningsPeriod.today matches the today range', () {
    final period = EarningsPeriod.today();
    final local = period.end!.toLocal();

    expect(period.start, DateTime(local.year, local.month, local.day).toUtc());
  });
}
