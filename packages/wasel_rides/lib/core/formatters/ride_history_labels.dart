class RideHistoryLabels {
  const RideHistoryLabels._();

  static const List<String> _months = [
    'كانون الثاني',
    'شباط',
    'آذار',
    'نيسان',
    'أيار',
    'حزيران',
    'تموز',
    'آب',
    'أيلول',
    'تشرين الأول',
    'تشرين الثاني',
    'كانون الأول',
  ];

  /// Indexed by DateTime.weekday (Monday == 1).
  static const List<String> _weekdays = [
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد',
  ];

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static String dayLabel(DateTime when, {DateTime? now}) {
    final today = now ?? DateTime.now();
    if (isSameDay(when, today)) return 'اليوم';

    final yesterday = today.subtract(const Duration(days: 1));
    if (isSameDay(when, yesterday)) return 'أمس';

    final month = _months[when.month - 1];

    if (when.year == today.year) {
      return '${_weekdays[when.weekday - 1]} ${when.day} $month';
    }

    return '${when.day} $month ${when.year}';
  }

  static String fullDateLabel(DateTime when) =>
      '${_weekdays[when.weekday - 1]}، ${when.day} '
      '${_months[when.month - 1]} ${when.year}';

  static String timeLabel(DateTime when) {
    final hour = when.hour % 12 == 0 ? 12 : when.hour % 12;
    final meridiem = when.hour < 12 ? 'ص' : 'م';

    return '$hour:${when.minute.toString().padLeft(2, '0')} $meridiem';
  }
}
