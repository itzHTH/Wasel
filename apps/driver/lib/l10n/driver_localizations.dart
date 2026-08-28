import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'driver_localizations_ar.dart';
import 'driver_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of DriverLocalizations
/// returned by `DriverLocalizations.of(context)`.
///
/// Applications need to include `DriverLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/driver_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: DriverLocalizations.localizationsDelegates,
///   supportedLocales: DriverLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the DriverLocalizations.supportedLocales
/// property.
abstract class DriverLocalizations {
  DriverLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static DriverLocalizations of(BuildContext context) {
    return Localizations.of<DriverLocalizations>(context, DriverLocalizations)!;
  }

  static const LocalizationsDelegate<DriverLocalizations> delegate =
      _DriverLocalizationsDelegate();

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
  /// **'وَصَل سائق'**
  String get brandName;

  /// Auth header lead-in that runs into the brand wordmark; keeps its trailing space
  ///
  /// In ar, this message translates to:
  /// **'انضم إلى أسطول '**
  String get authHeaderTagline;

  /// Headline above the login form
  ///
  /// In ar, this message translates to:
  /// **'سجّل دخولك كسائق'**
  String get loginTagline;

  /// Headline above the registration form
  ///
  /// In ar, this message translates to:
  /// **'أنشئ حساب سائق'**
  String get registerTagline;

  /// City field label on the driver registration form
  ///
  /// In ar, this message translates to:
  /// **'المدينة'**
  String get city;

  /// City field hint
  ///
  /// In ar, this message translates to:
  /// **'أدخل مدينتك'**
  String get enterCity;

  /// Address field label on the driver registration form
  ///
  /// In ar, this message translates to:
  /// **'العنوان'**
  String get address;

  /// Address field hint
  ///
  /// In ar, this message translates to:
  /// **'أدخل عنوانك'**
  String get enterAddress;

  /// App bar title of the profile screen
  ///
  /// In ar, this message translates to:
  /// **'حسابي'**
  String get myAccount;

  /// Menu tile and screen title
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

  /// Stat tile on the driver home
  ///
  /// In ar, this message translates to:
  /// **'أرباح اليوم'**
  String get todayEarnings;

  /// Stat tile on the driver home
  ///
  /// In ar, this message translates to:
  /// **'رحلات اليوم'**
  String get todayRides;

  /// Stat tile on the driver home
  ///
  /// In ar, this message translates to:
  /// **'مدة الاتصال اليوم'**
  String get todayOnlineTime;

  /// Driver rating stat tile
  ///
  /// In ar, this message translates to:
  /// **'التقييم'**
  String get rating;

  /// Driver is accepting rides
  ///
  /// In ar, this message translates to:
  /// **'متصل'**
  String get online;

  /// Driver is not accepting rides
  ///
  /// In ar, this message translates to:
  /// **'غير متصل'**
  String get offline;

  /// Banner when the driver is offline
  ///
  /// In ar, this message translates to:
  /// **'إنت غير متصل'**
  String get youAreOffline;

  /// Explains the offline state
  ///
  /// In ar, this message translates to:
  /// **'ما راح توصلك طلبات وإنت غير متصل'**
  String get noRequestsWhileOffline;

  /// Goes online
  ///
  /// In ar, this message translates to:
  /// **'ابدأ استلام الرحلات'**
  String get startAcceptingRides;

  /// Goes offline
  ///
  /// In ar, this message translates to:
  /// **'إيقاف الاستلام'**
  String get stopAcceptingRides;

  /// Tip while waiting
  ///
  /// In ar, this message translates to:
  /// **'خليك بمكان زحمة حتى توصلك طلبات أكثر'**
  String get stayInBusyArea;

  /// Shown while waiting for a match
  ///
  /// In ar, this message translates to:
  /// **'دا ندوّر على طلبات'**
  String get searchingForRequests;

  /// Hub connection state
  ///
  /// In ar, this message translates to:
  /// **'دا نتصل...'**
  String get connecting;

  /// Hub connection state
  ///
  /// In ar, this message translates to:
  /// **'دا نتصل بالخادم'**
  String get connectingToServer;

  /// Hub connection state
  ///
  /// In ar, this message translates to:
  /// **'دا نعيد الاتصال...'**
  String get reconnecting;

  /// Hub connection state
  ///
  /// In ar, this message translates to:
  /// **'ثانية وحدة، دا نكمل الاتصال'**
  String get oneMomentConnecting;

  /// Hub connection state
  ///
  /// In ar, this message translates to:
  /// **'انقطع الاتصال'**
  String get disconnected;

  /// Hub connection state
  ///
  /// In ar, this message translates to:
  /// **'انقطع الاتصال بالخادم'**
  String get serverDisconnected;

  /// Hub failure detail
  ///
  /// In ar, this message translates to:
  /// **'ماكو اتصال بالخادم، موقعك ما يوصل للتوزيع'**
  String get noServerConnection;

  /// Hub failure detail
  ///
  /// In ar, this message translates to:
  /// **'ما وصل رد من الخادم، حاول مرة ثانية'**
  String get noServerResponse;

  /// Retry guidance
  ///
  /// In ar, this message translates to:
  /// **'تحقق من اتصالك بالإنترنت ثم أعد المحاولة.'**
  String get checkYourConnection;

  /// Driver location failure
  ///
  /// In ar, this message translates to:
  /// **'خدمة الموقع مطفّية، شغّلها حتى نگدر نبعث موقعك'**
  String get locationServiceOffDriver;

  /// Driver location failure
  ///
  /// In ar, this message translates to:
  /// **'ما نگدر نبعث موقعك بدون إذن الموقع'**
  String get cannotSendLocation;

  /// Driver location failure
  ///
  /// In ar, this message translates to:
  /// **'ما نگدر نحدد موقعك، تأكد من إشارة الـ GPS'**
  String get cannotDetermineLocation;

  /// Route failure
  ///
  /// In ar, this message translates to:
  /// **'ما نگدر نرسم الطريق'**
  String get cannotDrawRoute;

  /// Route failure
  ///
  /// In ar, this message translates to:
  /// **'ماكو موقع، ما نگدر نرسم الطريق'**
  String get noLocationNoRoute;

  /// Incoming ride request
  ///
  /// In ar, this message translates to:
  /// **'وصلك طلب جديد'**
  String get newRequest;

  /// Incoming ride request
  ///
  /// In ar, this message translates to:
  /// **'وصلك طلب'**
  String get requestReceived;

  /// Accepts an incoming ride
  ///
  /// In ar, this message translates to:
  /// **'قبول الطلب'**
  String get acceptRequest;

  /// Ride stage
  ///
  /// In ar, this message translates to:
  /// **'بالطريق لنقطة الانطلاق'**
  String get onWayToPickup;

  /// Ride stage
  ///
  /// In ar, this message translates to:
  /// **'بالطريق للراكب'**
  String get onWayToRider;

  /// Ride stage
  ///
  /// In ar, this message translates to:
  /// **'وصلت لنقطة الانطلاق'**
  String get arrivedAtPickup;

  /// Marks arrival at the pickup point
  ///
  /// In ar, this message translates to:
  /// **'وصلت'**
  String get arrived;

  /// Ride stage
  ///
  /// In ar, this message translates to:
  /// **'بانتظار الراكب'**
  String get waitingForRider;

  /// Guidance at pickup
  ///
  /// In ar, this message translates to:
  /// **'انتظر الراكب يركب وبعدين ابدأ الرحلة'**
  String get waitForRiderThenStart;

  /// Begins the trip
  ///
  /// In ar, this message translates to:
  /// **'ابدأ الرحلة'**
  String get startRide;

  /// Ride stage
  ///
  /// In ar, this message translates to:
  /// **'الرحلة جارية'**
  String get rideInProgress;

  /// Ride stage label
  ///
  /// In ar, this message translates to:
  /// **'رحلة جارية'**
  String get rideOngoing;

  /// Completes the trip
  ///
  /// In ar, this message translates to:
  /// **'إنهاء الرحلة'**
  String get endRide;

  /// Ride stage
  ///
  /// In ar, this message translates to:
  /// **'خلصت الرحلة'**
  String get rideFinished;

  /// Cancels the trip
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الرحلة'**
  String get cancelRide;

  /// Returns to the request list
  ///
  /// In ar, this message translates to:
  /// **'رجوع للطلبات'**
  String get backToRequests;

  /// Pickup point label
  ///
  /// In ar, this message translates to:
  /// **'نقطة الانطلاق'**
  String get pickupPoint;

  /// Dropoff point label
  ///
  /// In ar, this message translates to:
  /// **'نقطة الوصول'**
  String get dropoffPoint;

  /// Cash collection prompt
  ///
  /// In ar, this message translates to:
  /// **'اجمع الأجرة من الراكب'**
  String get collectFareFromRider;

  /// Converts the ride to a cash payment
  ///
  /// In ar, this message translates to:
  /// **'تحويل إلى نقدي'**
  String get switchToCash;

  /// Confirmation dialog
  ///
  /// In ar, this message translates to:
  /// **'تحويل الرحلة إلى الدفع نقدًا وإنهاؤها؟'**
  String get switchToCashConfirm;

  /// Payment failure
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحصيل الدفع'**
  String get paymentCollectFailed;

  /// Ride status failure
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحديث الحالة، حاول مجدداً.'**
  String get statusUpdateFailed;

  /// Shown when the rider has no number
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف غير متوفر'**
  String get phoneUnavailable;

  /// Fallback driver name
  ///
  /// In ar, this message translates to:
  /// **'سائق وَصَل'**
  String get waselDriverName;

  /// Title of the verification flow
  ///
  /// In ar, this message translates to:
  /// **'توثيق السائق'**
  String get driverVerification;

  /// Advances a verification step
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get next;

  /// Returns to the previous verification step
  ///
  /// In ar, this message translates to:
  /// **'السابق'**
  String get previous;

  /// Verification step title
  ///
  /// In ar, this message translates to:
  /// **'الصورة الشخصية'**
  String get personalPhoto;

  /// Verification document label
  ///
  /// In ar, this message translates to:
  /// **'صورة شخصية'**
  String get selfiePhoto;

  /// Verification guidance
  ///
  /// In ar, this message translates to:
  /// **'التقط صورة شخصية واضحة لمطابقة هويتك.'**
  String get takeClearSelfie;

  /// Camera guidance
  ///
  /// In ar, this message translates to:
  /// **'ضع وجهك داخل الإطار'**
  String get placeFaceInFrame;

  /// Verification step title
  ///
  /// In ar, this message translates to:
  /// **'رخصة القيادة'**
  String get driverLicense;

  /// Verification document label
  ///
  /// In ar, this message translates to:
  /// **'الوجه الأمامي للرخصة'**
  String get licenseFront;

  /// Verification document label
  ///
  /// In ar, this message translates to:
  /// **'الوجه الخلفي للرخصة'**
  String get licenseBack;

  /// Verification guidance
  ///
  /// In ar, this message translates to:
  /// **'صوّر رخصة القيادة من الأمام والخلف داخل الإطار.'**
  String get photographLicense;

  /// Camera guidance
  ///
  /// In ar, this message translates to:
  /// **'ضع الرخصة داخل الإطار'**
  String get placeLicenseInFrame;

  /// Verification step title
  ///
  /// In ar, this message translates to:
  /// **'بيانات المركبة'**
  String get vehicleData;

  /// Verification document label
  ///
  /// In ar, this message translates to:
  /// **'صورة المركبة'**
  String get vehiclePhoto;

  /// Verification guidance
  ///
  /// In ar, this message translates to:
  /// **'صوّر مركبتك وأدخل بياناتها.'**
  String get photographVehicle;

  /// Camera guidance
  ///
  /// In ar, this message translates to:
  /// **'صوّر المركبة داخل الإطار'**
  String get placeVehicleInFrame;

  /// Vehicle field label
  ///
  /// In ar, this message translates to:
  /// **'موديل المركبة'**
  String get vehicleModel;

  /// Vehicle model hint
  ///
  /// In ar, this message translates to:
  /// **'مثال: Toyota Corolla'**
  String get vehicleModelExample;

  /// Vehicle field label
  ///
  /// In ar, this message translates to:
  /// **'سنة الصنع'**
  String get manufactureYear;

  /// Vehicle year hint
  ///
  /// In ar, this message translates to:
  /// **'مثال: 2020'**
  String get manufactureYearExample;

  /// Vehicle field label
  ///
  /// In ar, this message translates to:
  /// **'رقم اللوحه'**
  String get plateNumber;

  /// Plate number hint
  ///
  /// In ar, this message translates to:
  /// **'234244 C / 342134 ب'**
  String get plateNumberExample;

  /// Takes the photo
  ///
  /// In ar, this message translates to:
  /// **'التقاط'**
  String get capture;

  /// Image source option
  ///
  /// In ar, this message translates to:
  /// **'التقاط بالكاميرا'**
  String get captureWithCamera;

  /// Image source option
  ///
  /// In ar, this message translates to:
  /// **'اختيار من المعرض'**
  String get chooseFromGalleryDriver;

  /// Discards and retakes the photo
  ///
  /// In ar, this message translates to:
  /// **'إعادة الالتقاط'**
  String get retake;

  /// Accepts the captured photo
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الصورة'**
  String get confirmPhoto;

  /// Photo review guidance
  ///
  /// In ar, this message translates to:
  /// **'تأكد أن الصورة واضحة ومقروءة قبل المتابعة.'**
  String get ensurePhotoClear;

  /// Camera failure
  ///
  /// In ar, this message translates to:
  /// **'تعذّر الالتقاط، حاول مجدداً'**
  String get captureFailed;

  /// Camera failure
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تشغيل الكاميرا'**
  String get cameraStartFailed;

  /// Camera failure
  ///
  /// In ar, this message translates to:
  /// **'لا توجد كاميرا متاحة'**
  String get noCameraAvailable;

  /// Camera permission prompt title
  ///
  /// In ar, this message translates to:
  /// **'إذن الكاميرا مطلوب'**
  String get cameraPermissionRequired;

  /// Camera permission prompt body
  ///
  /// In ar, this message translates to:
  /// **'نحتاج إذن الكاميرا لالتقاط الصورة. فعّله من الإعدادات.'**
  String get cameraPermissionMessage;

  /// Upload progress
  ///
  /// In ar, this message translates to:
  /// **'جارٍ رفع المستندات…'**
  String get uploadingDocuments;

  /// Upload success
  ///
  /// In ar, this message translates to:
  /// **'تم رفع المستندات بنجاح'**
  String get documentsUploaded;

  /// Upload failure
  ///
  /// In ar, this message translates to:
  /// **'تعذّر رفع المستندات'**
  String get uploadFailed;

  /// Upload progress guidance
  ///
  /// In ar, this message translates to:
  /// **'يرجى الانتظار وعدم إغلاق التطبيق.'**
  String get pleaseWaitDontClose;

  /// Returns from the upload screen
  ///
  /// In ar, this message translates to:
  /// **'العودة للنموذج'**
  String get backToForm;

  /// Discards unsaved changes
  ///
  /// In ar, this message translates to:
  /// **'تجاهل'**
  String get discard;

  /// Approval status
  ///
  /// In ar, this message translates to:
  /// **'قيد المراجعة'**
  String get underReview;

  /// Approval status
  ///
  /// In ar, this message translates to:
  /// **'قيد الانتظار'**
  String get pendingStatus;

  /// Approval status
  ///
  /// In ar, this message translates to:
  /// **'موثّق'**
  String get approved;

  /// Approval status
  ///
  /// In ar, this message translates to:
  /// **'مرفوض'**
  String get rejected;

  /// Approval screen title
  ///
  /// In ar, this message translates to:
  /// **'طلبك قيد المراجعة'**
  String get requestUnderReview;

  /// Approval screen body
  ///
  /// In ar, this message translates to:
  /// **'نقوم بمراجعة مستنداتك، وعادةً ما يستغرق ذلك حتى ٢٤ ساعة.'**
  String get reviewingDocuments;

  /// Approval screen body
  ///
  /// In ar, this message translates to:
  /// **'سيتم مراجعة طلبك وإشعارك بالنتيجة.'**
  String get willNotifyResult;

  /// Approval screen body
  ///
  /// In ar, this message translates to:
  /// **'لا يزال طلبك قيد المراجعة، سنخبرك فور تحديث الحالة.'**
  String get stillUnderReview;

  /// Rejection notice
  ///
  /// In ar, this message translates to:
  /// **'تم رفض طلبك السابق، يرجى مراجعة بياناتك وإعادة الإرسال.'**
  String get previousRequestRejected;

  /// Rejection notice
  ///
  /// In ar, this message translates to:
  /// **'تم رفض معلوماتك ، يرجى مراجعة بياناتك وإعادة الإرسال.'**
  String get infoRejected;

  /// Approval failure
  ///
  /// In ar, this message translates to:
  /// **'تعذّر التحقق من حالة طلبك'**
  String get statusCheckFailed;

  /// Splash/loading text
  ///
  /// In ar, this message translates to:
  /// **'جارٍ التحقق من حسابك وبعض المعلومات …'**
  String get verifyingAccount;

  /// Edit screen title
  ///
  /// In ar, this message translates to:
  /// **'تعديل الملف الشخصي'**
  String get editProfile;

  /// Profile error state
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحميل بيانات الملف الشخصي'**
  String get profileLoadFailed;

  /// Wallet balance label
  ///
  /// In ar, this message translates to:
  /// **'الرصيد'**
  String get balance;

  /// Opens the profile edit screen
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get edit;

  /// Notice on the driver profile edit screen
  ///
  /// In ar, this message translates to:
  /// **'يمكنك تعديل رقم هاتفك فقط. لتغيير اسمك أو بيانات مركبتك تواصل مع الدعم.'**
  String get editPhoneOnlyDriver;

  /// Iraqi dinar symbol appended to fares
  ///
  /// In ar, this message translates to:
  /// **'د.ع'**
  String get currencyIqd;

  /// ETA to the rider
  ///
  /// In ar, this message translates to:
  /// **'توصل خلال {minutes} دقائق'**
  String riderEtaMinutes(String minutes);

  /// Trip distance with its unit
  ///
  /// In ar, this message translates to:
  /// **'{value} كم'**
  String distanceKm(String value);

  /// Raw coordinates before a place name resolves
  ///
  /// In ar, this message translates to:
  /// **'{lat}، {lng}'**
  String coordinatePair(String lat, String lng);

  /// Online duration with both parts
  ///
  /// In ar, this message translates to:
  /// **'{hours} س {minutes} د'**
  String durationHoursMinutes(String hours, String minutes);

  /// Online duration, whole hours
  ///
  /// In ar, this message translates to:
  /// **'{hours} س'**
  String durationHours(String hours);

  /// Online duration, minutes only
  ///
  /// In ar, this message translates to:
  /// **'{minutes} د'**
  String durationMinutes(String minutes);

  /// Earnings dashboard title and the profile menu entry that opens it
  ///
  /// In ar, this message translates to:
  /// **'الأرباح'**
  String get earnings;

  /// Label on the earnings dashboard hero card, above the amount
  ///
  /// In ar, this message translates to:
  /// **'إجمالي الأرباح'**
  String get totalEarnings;

  /// Earnings range selector: today only
  ///
  /// In ar, this message translates to:
  /// **'اليوم'**
  String get periodToday;

  /// Earnings range selector: rolling seven-day window
  ///
  /// In ar, this message translates to:
  /// **'آخر 7 أيام'**
  String get periodLast7Days;

  /// Earnings range selector: rolling thirty-day window
  ///
  /// In ar, this message translates to:
  /// **'آخر 30 يوماً'**
  String get periodLast30Days;

  /// Earnings stat card label for the number of completed rides in the selected range
  ///
  /// In ar, this message translates to:
  /// **'الرحلات المكتملة'**
  String get completedRidesLabel;

  /// Earnings stat card label for time spent online in the selected range
  ///
  /// In ar, this message translates to:
  /// **'وقت الاتصال'**
  String get onlineTimeLabel;

  /// Cash-out section heading and button label on the earnings dashboard
  ///
  /// In ar, this message translates to:
  /// **'سحب الأرباح'**
  String get cashOut;

  /// Helper line under a disabled cash-out button explaining why it cannot be tapped
  ///
  /// In ar, this message translates to:
  /// **'لا توجد أرباح متاحة للسحب حالياً.'**
  String get cashOutUnavailableHint;

  /// Title of the dialog shown when cash out is tapped before the transfer flow ships
  ///
  /// In ar, this message translates to:
  /// **'السحب قريباً'**
  String get cashOutSoonTitle;

  /// Body of the cash-out coming-soon dialog
  ///
  /// In ar, this message translates to:
  /// **'سحب الأرباح إلى حسابك قيد التجهيز، وسنخبرك فور توفره.'**
  String get cashOutSoonMessage;

  /// Shown in the blocking loader while the app re-reads the active ride and brings the tracking socket up
  ///
  /// In ar, this message translates to:
  /// **'يتم إعداد بيئة الاتصال'**
  String get restoringRide;
}

class _DriverLocalizationsDelegate
    extends LocalizationsDelegate<DriverLocalizations> {
  const _DriverLocalizationsDelegate();

  @override
  Future<DriverLocalizations> load(Locale locale) {
    return SynchronousFuture<DriverLocalizations>(
      lookupDriverLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_DriverLocalizationsDelegate old) => false;
}

DriverLocalizations lookupDriverLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return DriverLocalizationsAr();
    case 'en':
      return DriverLocalizationsEn();
  }

  throw FlutterError(
    'DriverLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
