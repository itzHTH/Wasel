// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'rides_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class RidesLocalizationsAr extends RidesLocalizations {
  RidesLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get rideHistoryTitle => 'سجل الرحلات';

  @override
  String get noMoreRides => 'لا مزيد من الرحلات';

  @override
  String get noRidesYet => 'لا توجد رحلات بعد';

  @override
  String get noRidesYetDescription =>
      'ستظهر هنا رحلاتك المكتملة والملغاة فور انتهائها.';

  @override
  String get rideStatusCompleted => 'مكتملة';

  @override
  String get rideStatusCancelled => 'ملغاة';

  @override
  String get rideStatusUnknown => 'غير معروفة';

  @override
  String get rideDate => 'التاريخ';

  @override
  String get rideRequestTime => 'وقت الطلب';

  @override
  String get rideFare => 'قيمة الرحلة';

  @override
  String get month1 => 'كانون الثاني';

  @override
  String get month2 => 'شباط';

  @override
  String get month3 => 'آذار';

  @override
  String get month4 => 'نيسان';

  @override
  String get month5 => 'أيار';

  @override
  String get month6 => 'حزيران';

  @override
  String get month7 => 'تموز';

  @override
  String get month8 => 'آب';

  @override
  String get month9 => 'أيلول';

  @override
  String get month10 => 'تشرين الأول';

  @override
  String get month11 => 'تشرين الثاني';

  @override
  String get month12 => 'كانون الأول';

  @override
  String get weekday1 => 'الإثنين';

  @override
  String get weekday2 => 'الثلاثاء';

  @override
  String get weekday3 => 'الأربعاء';

  @override
  String get weekday4 => 'الخميس';

  @override
  String get weekday5 => 'الجمعة';

  @override
  String get weekday6 => 'السبت';

  @override
  String get weekday7 => 'الأحد';

  @override
  String get today => 'اليوم';

  @override
  String get yesterday => 'أمس';

  @override
  String get timeAm => 'ص';

  @override
  String get timePm => 'م';

  @override
  String dayWithWeekday(String weekday, int day, String month) {
    return '$weekday $day $month';
  }

  @override
  String dayWithYear(int day, String month, int year) {
    return '$day $month $year';
  }

  @override
  String fullDate(String weekday, int day, String month, int year) {
    return '$weekday، $day $month $year';
  }

  @override
  String timeOfDay(int hour, String minute, String meridiem) {
    return '$hour:$minute $meridiem';
  }
}
