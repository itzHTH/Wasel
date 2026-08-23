// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'rides_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class RidesLocalizationsEn extends RidesLocalizations {
  RidesLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get rideHistoryTitle => 'Ride history';

  @override
  String get noMoreRides => 'No more rides';

  @override
  String get noRidesYet => 'No rides yet';

  @override
  String get noRidesYetDescription =>
      'Your completed and cancelled rides will appear here as soon as they finish.';

  @override
  String get rideStatusCompleted => 'Completed';

  @override
  String get rideStatusCancelled => 'Cancelled';

  @override
  String get rideStatusUnknown => 'Unknown';

  @override
  String get rideDate => 'Date';

  @override
  String get rideRequestTime => 'Requested at';

  @override
  String get rideFare => 'Fare';

  @override
  String get month1 => 'January';

  @override
  String get month2 => 'February';

  @override
  String get month3 => 'March';

  @override
  String get month4 => 'April';

  @override
  String get month5 => 'May';

  @override
  String get month6 => 'June';

  @override
  String get month7 => 'July';

  @override
  String get month8 => 'August';

  @override
  String get month9 => 'September';

  @override
  String get month10 => 'October';

  @override
  String get month11 => 'November';

  @override
  String get month12 => 'December';

  @override
  String get weekday1 => 'Monday';

  @override
  String get weekday2 => 'Tuesday';

  @override
  String get weekday3 => 'Wednesday';

  @override
  String get weekday4 => 'Thursday';

  @override
  String get weekday5 => 'Friday';

  @override
  String get weekday6 => 'Saturday';

  @override
  String get weekday7 => 'Sunday';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get timeAm => 'AM';

  @override
  String get timePm => 'PM';

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
    return '$weekday, $day $month $year';
  }

  @override
  String timeOfDay(int hour, String minute, String meridiem) {
    return '$hour:$minute $meridiem';
  }
}
