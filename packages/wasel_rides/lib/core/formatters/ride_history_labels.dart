import 'package:wasel_rides/l10n/rides_localizations.dart';

/// Date and time labels for the ride history list.
class RideHistoryLabels {
  const RideHistoryLabels._();

  static String _month(RidesLocalizations l10n, int month) => switch (month) {
    1 => l10n.month1,
    2 => l10n.month2,
    3 => l10n.month3,
    4 => l10n.month4,
    5 => l10n.month5,
    6 => l10n.month6,
    7 => l10n.month7,
    8 => l10n.month8,
    9 => l10n.month9,
    10 => l10n.month10,
    11 => l10n.month11,
    _ => l10n.month12,
  };

  /// [weekday] follows DateTime.weekday, where Monday is 1.
  static String _weekday(RidesLocalizations l10n, int weekday) =>
      switch (weekday) {
        1 => l10n.weekday1,
        2 => l10n.weekday2,
        3 => l10n.weekday3,
        4 => l10n.weekday4,
        5 => l10n.weekday5,
        6 => l10n.weekday6,
        _ => l10n.weekday7,
      };

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static String dayLabel(
    RidesLocalizations l10n,
    DateTime when, {
    DateTime? now,
  }) {
    final today = now ?? DateTime.now();
    if (isSameDay(when, today)) return l10n.today;

    final yesterday = today.subtract(const Duration(days: 1));
    if (isSameDay(when, yesterday)) return l10n.yesterday;

    final month = _month(l10n, when.month);

    if (when.year == today.year) {
      return l10n.dayWithWeekday(_weekday(l10n, when.weekday), when.day, month);
    }

    return l10n.dayWithYear(when.day, month, when.year);
  }

  static String fullDateLabel(RidesLocalizations l10n, DateTime when) =>
      l10n.fullDate(
        _weekday(l10n, when.weekday),
        when.day,
        _month(l10n, when.month),
        when.year,
      );

  static String timeLabel(RidesLocalizations l10n, DateTime when) {
    final hour = when.hour % 12 == 0 ? 12 : when.hour % 12;
    final meridiem = when.hour < 12 ? l10n.timeAm : l10n.timePm;

    return l10n.timeOfDay(
      hour,
      when.minute.toString().padLeft(2, '0'),
      meridiem,
    );
  }
}
