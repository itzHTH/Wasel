/// Rolling windows, so no assumption is made about which day the week starts.
enum EarningsRange { today, last7Days, last30Days }

class EarningsPeriod {
  const EarningsPeriod({this.start, this.end});

  factory EarningsPeriod.today() =>
      EarningsPeriod.forRange(EarningsRange.today);

  /// [now] is injectable so the boundaries can be asserted without a clock.
  factory EarningsPeriod.forRange(EarningsRange range, {DateTime? now}) {
    final end = now ?? DateTime.now();

    final daysBack = switch (range) {
      EarningsRange.today => 0,
      EarningsRange.last7Days => 6,
      EarningsRange.last30Days => 29,
    };

    // Calendar arithmetic rather than a Duration, so the window cannot drift
    // across a DST change.
    final start = DateTime(end.year, end.month, end.day - daysBack);

    // UTC, because a local DateTime reaches the server as an ISO string with
    // no offset and is read there as UTC — shifting the window by the driver's
    // own timezone.
    return EarningsPeriod(start: start.toUtc(), end: end.toUtc());
  }

  final DateTime? start;
  final DateTime? end;
}
