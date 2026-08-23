import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'rides_localizations_ar.dart';
import 'rides_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of RidesLocalizations
/// returned by `RidesLocalizations.of(context)`.
///
/// Applications need to include `RidesLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/rides_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: RidesLocalizations.localizationsDelegates,
///   supportedLocales: RidesLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the RidesLocalizations.supportedLocales
/// property.
abstract class RidesLocalizations {
  RidesLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static RidesLocalizations of(BuildContext context) {
    return Localizations.of<RidesLocalizations>(context, RidesLocalizations)!;
  }

  static const LocalizationsDelegate<RidesLocalizations> delegate =
      _RidesLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// App bar title of the ride history screen
  ///
  /// In ar, this message translates to:
  /// **'سجل الرحلات'**
  String get rideHistoryTitle;

  /// Footer shown when the ride history list is fully paged in
  ///
  /// In ar, this message translates to:
  /// **'لا مزيد من الرحلات'**
  String get noMoreRides;

  /// Title of the empty ride history state
  ///
  /// In ar, this message translates to:
  /// **'لا توجد رحلات بعد'**
  String get noRidesYet;

  /// Body of the empty ride history state
  ///
  /// In ar, this message translates to:
  /// **'ستظهر هنا رحلاتك المكتملة والملغاة فور انتهائها.'**
  String get noRidesYetDescription;

  /// Status chip for a completed ride
  ///
  /// In ar, this message translates to:
  /// **'مكتملة'**
  String get rideStatusCompleted;

  /// Status chip for a cancelled ride
  ///
  /// In ar, this message translates to:
  /// **'ملغاة'**
  String get rideStatusCancelled;

  /// Status chip when the ride status is not recognised
  ///
  /// In ar, this message translates to:
  /// **'غير معروفة'**
  String get rideStatusUnknown;

  /// Label of the date row on a ride history card
  ///
  /// In ar, this message translates to:
  /// **'التاريخ'**
  String get rideDate;

  /// Label of the request time row on a ride history card
  ///
  /// In ar, this message translates to:
  /// **'وقت الطلب'**
  String get rideRequestTime;

  /// Label of the fare row on a ride history card
  ///
  /// In ar, this message translates to:
  /// **'قيمة الرحلة'**
  String get rideFare;

  /// Month 1 name, Levantine Arabic as used in Iraq
  ///
  /// In ar, this message translates to:
  /// **'كانون الثاني'**
  String get month1;

  /// Month 2 name, Levantine Arabic as used in Iraq
  ///
  /// In ar, this message translates to:
  /// **'شباط'**
  String get month2;

  /// Month 3 name, Levantine Arabic as used in Iraq
  ///
  /// In ar, this message translates to:
  /// **'آذار'**
  String get month3;

  /// Month 4 name, Levantine Arabic as used in Iraq
  ///
  /// In ar, this message translates to:
  /// **'نيسان'**
  String get month4;

  /// Month 5 name, Levantine Arabic as used in Iraq
  ///
  /// In ar, this message translates to:
  /// **'أيار'**
  String get month5;

  /// Month 6 name, Levantine Arabic as used in Iraq
  ///
  /// In ar, this message translates to:
  /// **'حزيران'**
  String get month6;

  /// Month 7 name, Levantine Arabic as used in Iraq
  ///
  /// In ar, this message translates to:
  /// **'تموز'**
  String get month7;

  /// Month 8 name, Levantine Arabic as used in Iraq
  ///
  /// In ar, this message translates to:
  /// **'آب'**
  String get month8;

  /// Month 9 name, Levantine Arabic as used in Iraq
  ///
  /// In ar, this message translates to:
  /// **'أيلول'**
  String get month9;

  /// Month 10 name, Levantine Arabic as used in Iraq
  ///
  /// In ar, this message translates to:
  /// **'تشرين الأول'**
  String get month10;

  /// Month 11 name, Levantine Arabic as used in Iraq
  ///
  /// In ar, this message translates to:
  /// **'تشرين الثاني'**
  String get month11;

  /// Month 12 name, Levantine Arabic as used in Iraq
  ///
  /// In ar, this message translates to:
  /// **'كانون الأول'**
  String get month12;

  /// Weekday name, 1 = Monday per DateTime.weekday
  ///
  /// In ar, this message translates to:
  /// **'الإثنين'**
  String get weekday1;

  /// Weekday name, 2 = Monday per DateTime.weekday
  ///
  /// In ar, this message translates to:
  /// **'الثلاثاء'**
  String get weekday2;

  /// Weekday name, 3 = Monday per DateTime.weekday
  ///
  /// In ar, this message translates to:
  /// **'الأربعاء'**
  String get weekday3;

  /// Weekday name, 4 = Monday per DateTime.weekday
  ///
  /// In ar, this message translates to:
  /// **'الخميس'**
  String get weekday4;

  /// Weekday name, 5 = Monday per DateTime.weekday
  ///
  /// In ar, this message translates to:
  /// **'الجمعة'**
  String get weekday5;

  /// Weekday name, 6 = Monday per DateTime.weekday
  ///
  /// In ar, this message translates to:
  /// **'السبت'**
  String get weekday6;

  /// Weekday name, 7 = Monday per DateTime.weekday
  ///
  /// In ar, this message translates to:
  /// **'الأحد'**
  String get weekday7;

  /// Day header for rides taken today
  ///
  /// In ar, this message translates to:
  /// **'اليوم'**
  String get today;

  /// Day header for rides taken yesterday
  ///
  /// In ar, this message translates to:
  /// **'أمس'**
  String get yesterday;

  /// Morning meridiem marker
  ///
  /// In ar, this message translates to:
  /// **'ص'**
  String get timeAm;

  /// Afternoon meridiem marker
  ///
  /// In ar, this message translates to:
  /// **'م'**
  String get timePm;

  /// Day header inside the current year
  ///
  /// In ar, this message translates to:
  /// **'{weekday} {day} {month}'**
  String dayWithWeekday(String weekday, int day, String month);

  /// Day header for a previous year
  ///
  /// In ar, this message translates to:
  /// **'{day} {month} {year}'**
  String dayWithYear(int day, String month, int year);

  /// Full date on a ride card; note the locale-specific comma
  ///
  /// In ar, this message translates to:
  /// **'{weekday}، {day} {month} {year}'**
  String fullDate(String weekday, int day, String month, int year);

  /// Clock time with meridiem marker
  ///
  /// In ar, this message translates to:
  /// **'{hour}:{minute} {meridiem}'**
  String timeOfDay(int hour, String minute, String meridiem);
}

class _RidesLocalizationsDelegate
    extends LocalizationsDelegate<RidesLocalizations> {
  const _RidesLocalizationsDelegate();

  @override
  Future<RidesLocalizations> load(Locale locale) {
    return SynchronousFuture<RidesLocalizations>(
      lookupRidesLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_RidesLocalizationsDelegate old) => false;
}

RidesLocalizations lookupRidesLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return RidesLocalizationsAr();
    case 'en':
      return RidesLocalizationsEn();
  }

  throw FlutterError(
    'RidesLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
