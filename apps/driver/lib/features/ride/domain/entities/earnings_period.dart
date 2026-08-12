class EarningsPeriod {
  const EarningsPeriod({this.start, this.end});

  /// Midnight this morning up to now
  factory EarningsPeriod.today() {
    final now = DateTime.now();
    return EarningsPeriod(
      start: DateTime(now.year, now.month, now.day),
      end: now,
    );
  }

  final DateTime? start;
  final DateTime? end;
}
