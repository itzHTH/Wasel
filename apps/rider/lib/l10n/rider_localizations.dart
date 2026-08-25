import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'rider_localizations_ar.dart';
import 'rider_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of RiderLocalizations
/// returned by `RiderLocalizations.of(context)`.
///
/// Applications need to include `RiderLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/rider_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: RiderLocalizations.localizationsDelegates,
///   supportedLocales: RiderLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the RiderLocalizations.supportedLocales
/// property.
abstract class RiderLocalizations {
  RiderLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static RiderLocalizations of(BuildContext context) {
    return Localizations.of<RiderLocalizations>(context, RiderLocalizations)!;
  }

  static const LocalizationsDelegate<RiderLocalizations> delegate =
      _RiderLocalizationsDelegate();

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

  /// Stylised brand wordmark shown in the auth header
  ///
  /// In ar, this message translates to:
  /// **'وَصَل'**
  String get brandName;

  /// Auth header lead-in that runs into the brand wordmark; keeps its trailing space
  ///
  /// In ar, this message translates to:
  /// **'احصل على تجربة رائعة مع '**
  String get authHeaderTagline;

  /// Headline above the login form
  ///
  /// In ar, this message translates to:
  /// **'اطلب تكسي في أي وقت'**
  String get loginTagline;

  /// Headline above the registration form
  ///
  /// In ar, this message translates to:
  /// **'اطلب تكسي في أي وقت'**
  String get registerTagline;

  /// Divider label above the social sign-in buttons
  ///
  /// In ar, this message translates to:
  /// **'أو سجل باستخدام'**
  String get orSignUpWith;

  /// Default label of the Google button in the social section
  ///
  /// In ar, this message translates to:
  /// **'التسجيل باستخدام جوجل'**
  String get signUpWithGoogle;

  /// Google button label on the registration screen
  ///
  /// In ar, this message translates to:
  /// **'سجل باستخدام جوجل'**
  String get registerWithGoogle;

  /// Google button label on the login screen
  ///
  /// In ar, this message translates to:
  /// **'سجّل الدخول باستخدام جوجل'**
  String get loginWithGoogle;

  /// App bar title of the profile screen
  ///
  /// In ar, this message translates to:
  /// **'حسابي'**
  String get myAccount;

  /// Menu tile that opens the profile details screen
  ///
  /// In ar, this message translates to:
  /// **'الملف الشخصي'**
  String get profileDetails;

  /// Menu tile that opens the ride history screen
  ///
  /// In ar, this message translates to:
  /// **'سجل الرحلات'**
  String get rideHistory;

  /// Logout menu tile, and the confirm action of its dialog
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// Body of the logout confirmation dialog
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من تسجيل الخروج من حسابك؟'**
  String get logoutConfirmMessage;

  /// Generic failure shown when requesting a ride errors without a message
  ///
  /// In ar, this message translates to:
  /// **'تعذّر إرسال الطلب، حاول مرة أخرى'**
  String get requestRideFailed;

  /// Shown when signing out does not succeed
  ///
  /// In ar, this message translates to:
  /// **'فشل تسجيل الخروج'**
  String get logoutFailed;

  /// App bar title of the profile edit screen
  ///
  /// In ar, this message translates to:
  /// **'تعديل الملف الشخصي'**
  String get editProfile;

  /// Error state on the profile screens
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحميل بيانات الملف الشخصي'**
  String get profileLoadFailed;

  /// Action that opens the profile edit screen
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get edit;

  /// Fallback name when the rider has none set
  ///
  /// In ar, this message translates to:
  /// **'مستخدم وَصَل'**
  String get defaultUserName;

  /// Label of the wallet balance row
  ///
  /// In ar, this message translates to:
  /// **'الرصيد'**
  String get balance;

  /// Iraqi dinar symbol appended to fares
  ///
  /// In ar, this message translates to:
  /// **'د.ع'**
  String get currencyIqd;

  /// Trip distance with its unit
  ///
  /// In ar, this message translates to:
  /// **'{value} كم'**
  String distanceKm(String value);

  /// Raw coordinates shown before a place name resolves
  ///
  /// In ar, this message translates to:
  /// **'{lat}، {lng}'**
  String coordinatePair(String lat, String lng);

  /// Prompt on the destination picker
  ///
  /// In ar, this message translates to:
  /// **'وين تريد تروح؟'**
  String get whereToGo;

  /// Prompt on the pickup picker
  ///
  /// In ar, this message translates to:
  /// **'حدّد نقطة الانطلاق'**
  String get setPickup;

  /// Confirms the chosen dropoff
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الوجهة'**
  String get confirmDestination;

  /// Confirms the chosen pickup
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الانطلاق'**
  String get confirmPickup;

  /// Leading label of the pickup row
  ///
  /// In ar, this message translates to:
  /// **'من'**
  String get fromLabel;

  /// Leading label of the dropoff row
  ///
  /// In ar, this message translates to:
  /// **'إلى'**
  String get toLabel;

  /// Pickup point label
  ///
  /// In ar, this message translates to:
  /// **'الانطلاق'**
  String get pickupLabel;

  /// Destination label
  ///
  /// In ar, this message translates to:
  /// **'الوجهة'**
  String get destinationLabel;

  /// Fare estimate label
  ///
  /// In ar, this message translates to:
  /// **'الأجرة التقديرية'**
  String get estimatedFare;

  /// Trip distance label
  ///
  /// In ar, this message translates to:
  /// **'المسافة'**
  String get distanceLabel;

  /// Payment method row label
  ///
  /// In ar, this message translates to:
  /// **'طريقة الدفع'**
  String get paymentMethodLabel;

  /// Submits the ride request
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الطلب'**
  String get confirmRequest;

  /// Asks the rider to review before confirming
  ///
  /// In ar, this message translates to:
  /// **'تأكدلي من التفاصيل'**
  String get checkDetails;

  /// Cancels an in-flight ride request
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الطلب'**
  String get cancelRequest;

  /// Shown while matching a driver
  ///
  /// In ar, this message translates to:
  /// **'نبحث عن كابتن قريب...'**
  String get searchingForCaptain;

  /// Reassurance shown while matching
  ///
  /// In ar, this message translates to:
  /// **'خليك على الخط، راح نلگه لك كابتن بأسرع وقت'**
  String get stayOnline;

  /// Status once a driver accepts
  ///
  /// In ar, this message translates to:
  /// **'الكابتن بالطريق إلك'**
  String get captainOnWay;

  /// Status once the driver is at pickup
  ///
  /// In ar, this message translates to:
  /// **'الكابتن وصل — اطلع اله'**
  String get captainArrived;

  /// Hint for spotting the vehicle
  ///
  /// In ar, this message translates to:
  /// **'دور على السيارة برقم اللوحة'**
  String get findCarByPlate;

  /// Calls the captain
  ///
  /// In ar, this message translates to:
  /// **'اتصال'**
  String get call;

  /// Messages the captain
  ///
  /// In ar, this message translates to:
  /// **'رسالة'**
  String get message;

  /// Shown after the ride is cancelled
  ///
  /// In ar, this message translates to:
  /// **'انلغت الرحلة'**
  String get rideCancelled;

  /// Shown when the driver declines
  ///
  /// In ar, this message translates to:
  /// **'اعتذر الكابتن عن الرحلة، جرب مرة ثانية'**
  String get captainDeclined;

  /// Shown at the end of a ride
  ///
  /// In ar, this message translates to:
  /// **'وصلت بالسلامة'**
  String get arrivedSafely;

  /// Shown when the ride starts
  ///
  /// In ar, this message translates to:
  /// **'رحلة موفقة'**
  String get haveAGoodTrip;

  /// Title of the rating sheet
  ///
  /// In ar, this message translates to:
  /// **'شلون كانت رحلتك؟'**
  String get howWasYourRide;

  /// Hint of the review note field
  ///
  /// In ar, this message translates to:
  /// **'اكتب ملاحظاتك (اختياري)'**
  String get writeNotesOptional;

  /// Returns to the home screen
  ///
  /// In ar, this message translates to:
  /// **'العودة للرئيسية'**
  String get backToHome;

  /// Title of the trip summary
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الرحلة'**
  String get rideDetails;

  /// Fallback name when the driver has none
  ///
  /// In ar, this message translates to:
  /// **'سائق وصل'**
  String get waselDriverName;

  /// Guard when rating without a ride
  ///
  /// In ar, this message translates to:
  /// **'ما موجودة رحلة نقيمها'**
  String get noRideToRate;

  /// Guard when cancelling without a ride
  ///
  /// In ar, this message translates to:
  /// **'ما موجودة رحلة نلغيها'**
  String get noRideToCancel;

  /// Shown when the cancel request fails or the server refuses it
  ///
  /// In ar, this message translates to:
  /// **'ما گدرنا نلغي الرحلة، جرّب مرة ثانية'**
  String get cancelRideFailed;

  /// Guard when cancelling a ride that has already started
  ///
  /// In ar, this message translates to:
  /// **'ما تگدر تلغي رحلة بديت بيها'**
  String get cannotCancelInProgress;

  /// Title of the card form
  ///
  /// In ar, this message translates to:
  /// **'بيانات البطاقة'**
  String get cardDetails;

  /// Card number field label
  ///
  /// In ar, this message translates to:
  /// **'رقم البطاقة'**
  String get cardNumber;

  /// Card number field hint
  ///
  /// In ar, this message translates to:
  /// **'أدخل رقم البطاقة'**
  String get enterCardNumber;

  /// Card number validation error
  ///
  /// In ar, this message translates to:
  /// **'رقم البطاقة 16 رقمًا'**
  String get cardNumberLength;

  /// Expiry field label
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الانتهاء'**
  String get expiryDate;

  /// Expiry field hint
  ///
  /// In ar, this message translates to:
  /// **'أدخل تاريخ الانتهاء'**
  String get enterExpiryDate;

  /// Expiry format validation error
  ///
  /// In ar, this message translates to:
  /// **'الصيغة MM/YY'**
  String get expiryFormat;

  /// Expiry month validation error
  ///
  /// In ar, this message translates to:
  /// **'شهر غير صحيح'**
  String get invalidMonth;

  /// Expiry validation error
  ///
  /// In ar, this message translates to:
  /// **'البطاقة منتهية'**
  String get cardExpired;

  /// CVV field hint
  ///
  /// In ar, this message translates to:
  /// **'أدخل الرمز'**
  String get enterCvv;

  /// CVV validation error
  ///
  /// In ar, this message translates to:
  /// **'من 3 إلى 4 أرقام'**
  String get cvvLength;

  /// Submits the card form
  ///
  /// In ar, this message translates to:
  /// **'حفظ البطاقة'**
  String get saveCard;

  /// Driver ETA while en route
  ///
  /// In ar, this message translates to:
  /// **'الكابتن يوصل خلال {minutes} دقائق'**
  String captainEtaMinutes(String minutes);

  /// Trip ETA to the destination
  ///
  /// In ar, this message translates to:
  /// **'الوصول خلال {minutes} دقائق تقريباً'**
  String arrivalEtaMinutes(String minutes);
}

class _RiderLocalizationsDelegate
    extends LocalizationsDelegate<RiderLocalizations> {
  const _RiderLocalizationsDelegate();

  @override
  Future<RiderLocalizations> load(Locale locale) {
    return SynchronousFuture<RiderLocalizations>(
      lookupRiderLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_RiderLocalizationsDelegate old) => false;
}

RiderLocalizations lookupRiderLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return RiderLocalizationsAr();
    case 'en':
      return RiderLocalizationsEn();
  }

  throw FlutterError(
    'RiderLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
