import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'payments_localizations_ar.dart';
import 'payments_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of PaymentsLocalizations
/// returned by `PaymentsLocalizations.of(context)`.
///
/// Applications need to include `PaymentsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/payments_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: PaymentsLocalizations.localizationsDelegates,
///   supportedLocales: PaymentsLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the PaymentsLocalizations.supportedLocales
/// property.
abstract class PaymentsLocalizations {
  PaymentsLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static PaymentsLocalizations of(BuildContext context) {
    return Localizations.of<PaymentsLocalizations>(
      context,
      PaymentsLocalizations,
    )!;
  }

  static const LocalizationsDelegate<PaymentsLocalizations> delegate =
      _PaymentsLocalizationsDelegate();

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

  /// Cash payment method label
  ///
  /// In ar, this message translates to:
  /// **'نقدي'**
  String get paymentMethodCash;

  /// Card payment method label
  ///
  /// In ar, this message translates to:
  /// **'بطاقة'**
  String get paymentMethodCard;

  /// Wallet payment method label
  ///
  /// In ar, this message translates to:
  /// **'المحفظة'**
  String get paymentMethodWallet;

  /// Shown when no payment method is selected
  ///
  /// In ar, this message translates to:
  /// **'غير محدد'**
  String get paymentMethodUnknown;

  /// Blocks confirming a ride while no card is on file
  ///
  /// In ar, this message translates to:
  /// **'أضف بطاقة قبل تأكيد الطلب'**
  String get addCardBeforeConfirming;

  /// Blocks confirming a ride when the wallet cannot cover the fare
  ///
  /// In ar, this message translates to:
  /// **'رصيد المحفظة لا يكفي لهذه الرحلة'**
  String get walletBalanceTooLow;

  /// Shown when card tokenization fails
  ///
  /// In ar, this message translates to:
  /// **'تعذّر التحقق من البطاقة'**
  String get cardVerificationFailed;
}

class _PaymentsLocalizationsDelegate
    extends LocalizationsDelegate<PaymentsLocalizations> {
  const _PaymentsLocalizationsDelegate();

  @override
  Future<PaymentsLocalizations> load(Locale locale) {
    return SynchronousFuture<PaymentsLocalizations>(
      lookupPaymentsLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_PaymentsLocalizationsDelegate old) => false;
}

PaymentsLocalizations lookupPaymentsLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return PaymentsLocalizationsAr();
    case 'en':
      return PaymentsLocalizationsEn();
  }

  throw FlutterError(
    'PaymentsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
