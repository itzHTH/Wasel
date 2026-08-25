import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_rides/data/models/ride_history/response/ride_history_item_response.dart';

/// Asserted as instants rather than wall-clock components, so the expectations
/// hold on any machine's timezone.
void main() {
  RideHistoryItemResponse item(String? date, String? time) =>
      RideHistoryItemResponse(
        requestedDate: date,
        requestedTime: time,
        price: 2500,
        status: 'ملغية',
      );

  group('requestedAt', () {
    test('recomposes the split UTC instant', () {
      // Regression: the halves were rebuilt on a local wall clock, so a ride
      // logged at 01:04 UTC displayed as 01:04 local — three hours early in
      // Baghdad.
      final entry = item('2026-08-25T00:00:00Z', '01:04:55.2695600').toEntity();

      expect(entry.requestedAt.toUtc(), DateTime.utc(2026, 8, 25, 1, 4, 55));
    });

    test('is handed back in local time for display', () {
      final entry = item('2026-08-25T00:00:00Z', '01:04:55').toEntity();

      expect(entry.requestedAt.isUtc, isFalse);
    });

    test('rolls into the next local day when the UTC time is late', () {
      // 22:30 UTC on the 24th is 01:30 on the 25th in Baghdad, so the entry
      // must not be grouped under the previous day.
      final entry = item('2026-08-24T00:00:00Z', '22:30:00').toEntity();

      expect(entry.requestedAt.toUtc(), DateTime.utc(2026, 8, 24, 22, 30));
    });

    test('carries a day-prefixed TimeSpan through', () {
      final entry = item('2026-08-25T00:00:00Z', '1.02:00:00').toEntity();

      expect(entry.requestedAt.toUtc(), DateTime.utc(2026, 8, 26, 2));
    });

    test('falls back to the date alone when the time is unparseable', () {
      final entry = item('2026-08-25T00:00:00Z', 'not-a-timespan').toEntity();

      expect(entry.requestedAt.toUtc(), DateTime.utc(2026, 8, 25));
    });

    test('falls back to the epoch when the date is missing', () {
      expect(
        item(null, '01:04:55').toEntity().requestedAt,
        DateTime.fromMillisecondsSinceEpoch(0),
      );
    });
  });
}
