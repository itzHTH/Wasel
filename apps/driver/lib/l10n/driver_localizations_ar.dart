// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'driver_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class DriverLocalizationsAr extends DriverLocalizations {
  DriverLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get brandName => 'وَصَل سائق';

  @override
  String get authHeaderTagline => 'انضم إلى أسطول ';

  @override
  String get loginTagline => 'سجّل دخولك كسائق';

  @override
  String get registerTagline => 'أنشئ حساب سائق';

  @override
  String get city => 'المدينة';

  @override
  String get enterCity => 'أدخل مدينتك';

  @override
  String get address => 'العنوان';

  @override
  String get enterAddress => 'أدخل عنوانك';

  @override
  String get myAccount => 'حسابي';

  @override
  String get profileDetails => 'الملف الشخصي';

  @override
  String get rideHistory => 'سجل الرحلات';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get logoutConfirmMessage => 'هل أنت متأكد من تسجيل الخروج من حسابك؟';

  @override
  String get todayEarnings => 'أرباح اليوم';

  @override
  String get todayRides => 'رحلات اليوم';

  @override
  String get todayOnlineTime => 'مدة الاتصال اليوم';

  @override
  String get rating => 'التقييم';

  @override
  String get online => 'متصل';

  @override
  String get offline => 'غير متصل';

  @override
  String get youAreOffline => 'إنت غير متصل';

  @override
  String get noRequestsWhileOffline => 'ما راح توصلك طلبات وإنت غير متصل';

  @override
  String get startAcceptingRides => 'ابدأ استلام الرحلات';

  @override
  String get stopAcceptingRides => 'إيقاف الاستلام';

  @override
  String get stayInBusyArea => 'خليك بمكان زحمة حتى توصلك طلبات أكثر';

  @override
  String get searchingForRequests => 'دا ندوّر على طلبات';

  @override
  String get connecting => 'دا نتصل...';

  @override
  String get connectingToServer => 'دا نتصل بالخادم';

  @override
  String get reconnecting => 'دا نعيد الاتصال...';

  @override
  String get oneMomentConnecting => 'ثانية وحدة، دا نكمل الاتصال';

  @override
  String get disconnected => 'انقطع الاتصال';

  @override
  String get serverDisconnected => 'انقطع الاتصال بالخادم';

  @override
  String get noServerConnection => 'ماكو اتصال بالخادم، موقعك ما يوصل للتوزيع';

  @override
  String get noServerResponse => 'ما وصل رد من الخادم، حاول مرة ثانية';

  @override
  String get checkYourConnection => 'تحقق من اتصالك بالإنترنت ثم أعد المحاولة.';

  @override
  String get locationServiceOffDriver =>
      'خدمة الموقع مطفّية، شغّلها حتى نگدر نبعث موقعك';

  @override
  String get cannotSendLocation => 'ما نگدر نبعث موقعك بدون إذن الموقع';

  @override
  String get cannotDetermineLocation =>
      'ما نگدر نحدد موقعك، تأكد من إشارة الـ GPS';

  @override
  String get cannotDrawRoute => 'ما نگدر نرسم الطريق';

  @override
  String get noLocationNoRoute => 'ماكو موقع، ما نگدر نرسم الطريق';

  @override
  String get newRequest => 'وصلك طلب جديد';

  @override
  String get requestReceived => 'وصلك طلب';

  @override
  String get acceptRequest => 'قبول الطلب';

  @override
  String get onWayToPickup => 'بالطريق لنقطة الانطلاق';

  @override
  String get onWayToRider => 'بالطريق للراكب';

  @override
  String get arrivedAtPickup => 'وصلت لنقطة الانطلاق';

  @override
  String get arrived => 'وصلت';

  @override
  String get waitingForRider => 'بانتظار الراكب';

  @override
  String get waitForRiderThenStart => 'انتظر الراكب يركب وبعدين ابدأ الرحلة';

  @override
  String get startRide => 'ابدأ الرحلة';

  @override
  String get rideInProgress => 'الرحلة جارية';

  @override
  String get rideOngoing => 'رحلة جارية';

  @override
  String get endRide => 'إنهاء الرحلة';

  @override
  String get rideFinished => 'خلصت الرحلة';

  @override
  String get cancelRide => 'إلغاء الرحلة';

  @override
  String get backToRequests => 'رجوع للطلبات';

  @override
  String get pickupPoint => 'نقطة الانطلاق';

  @override
  String get dropoffPoint => 'نقطة الوصول';

  @override
  String get collectFareFromRider => 'اجمع الأجرة من الراكب';

  @override
  String get switchToCash => 'تحويل إلى نقدي';

  @override
  String get switchToCashConfirm => 'تحويل الرحلة إلى الدفع نقدًا وإنهاؤها؟';

  @override
  String get paymentCollectFailed => 'تعذّر تحصيل الدفع';

  @override
  String get statusUpdateFailed => 'تعذّر تحديث الحالة، حاول مجدداً.';

  @override
  String get phoneUnavailable => 'رقم الهاتف غير متوفر';

  @override
  String get waselDriverName => 'سائق وَصَل';

  @override
  String get driverVerification => 'توثيق السائق';

  @override
  String get next => 'التالي';

  @override
  String get previous => 'السابق';

  @override
  String get personalPhoto => 'الصورة الشخصية';

  @override
  String get selfiePhoto => 'صورة شخصية';

  @override
  String get takeClearSelfie => 'التقط صورة شخصية واضحة لمطابقة هويتك.';

  @override
  String get placeFaceInFrame => 'ضع وجهك داخل الإطار';

  @override
  String get driverLicense => 'رخصة القيادة';

  @override
  String get licenseFront => 'الوجه الأمامي للرخصة';

  @override
  String get licenseBack => 'الوجه الخلفي للرخصة';

  @override
  String get photographLicense =>
      'صوّر رخصة القيادة من الأمام والخلف داخل الإطار.';

  @override
  String get placeLicenseInFrame => 'ضع الرخصة داخل الإطار';

  @override
  String get vehicleData => 'بيانات المركبة';

  @override
  String get vehiclePhoto => 'صورة المركبة';

  @override
  String get photographVehicle => 'صوّر مركبتك وأدخل بياناتها.';

  @override
  String get placeVehicleInFrame => 'صوّر المركبة داخل الإطار';

  @override
  String get vehicleModel => 'موديل المركبة';

  @override
  String get vehicleModelExample => 'مثال: Toyota Corolla';

  @override
  String get manufactureYear => 'سنة الصنع';

  @override
  String get manufactureYearExample => 'مثال: 2020';

  @override
  String get plateNumber => 'رقم اللوحه';

  @override
  String get plateNumberExample => '234244 C / 342134 ب';

  @override
  String get capture => 'التقاط';

  @override
  String get captureWithCamera => 'التقاط بالكاميرا';

  @override
  String get chooseFromGalleryDriver => 'اختيار من المعرض';

  @override
  String get retake => 'إعادة الالتقاط';

  @override
  String get confirmPhoto => 'تأكيد الصورة';

  @override
  String get ensurePhotoClear => 'تأكد أن الصورة واضحة ومقروءة قبل المتابعة.';

  @override
  String get captureFailed => 'تعذّر الالتقاط، حاول مجدداً';

  @override
  String get cameraStartFailed => 'تعذّر تشغيل الكاميرا';

  @override
  String get noCameraAvailable => 'لا توجد كاميرا متاحة';

  @override
  String get cameraPermissionRequired => 'إذن الكاميرا مطلوب';

  @override
  String get cameraPermissionMessage =>
      'نحتاج إذن الكاميرا لالتقاط الصورة. فعّله من الإعدادات.';

  @override
  String get uploadingDocuments => 'جارٍ رفع المستندات…';

  @override
  String get documentsUploaded => 'تم رفع المستندات بنجاح';

  @override
  String get uploadFailed => 'تعذّر رفع المستندات';

  @override
  String get pleaseWaitDontClose => 'يرجى الانتظار وعدم إغلاق التطبيق.';

  @override
  String get backToForm => 'العودة للنموذج';

  @override
  String get discard => 'تجاهل';

  @override
  String get underReview => 'قيد المراجعة';

  @override
  String get pendingStatus => 'قيد الانتظار';

  @override
  String get approved => 'موثّق';

  @override
  String get rejected => 'مرفوض';

  @override
  String get requestUnderReview => 'طلبك قيد المراجعة';

  @override
  String get reviewingDocuments =>
      'نقوم بمراجعة مستنداتك، وعادةً ما يستغرق ذلك حتى ٢٤ ساعة.';

  @override
  String get willNotifyResult => 'سيتم مراجعة طلبك وإشعارك بالنتيجة.';

  @override
  String get stillUnderReview =>
      'لا يزال طلبك قيد المراجعة، سنخبرك فور تحديث الحالة.';

  @override
  String get previousRequestRejected =>
      'تم رفض طلبك السابق، يرجى مراجعة بياناتك وإعادة الإرسال.';

  @override
  String get infoRejected =>
      'تم رفض معلوماتك ، يرجى مراجعة بياناتك وإعادة الإرسال.';

  @override
  String get statusCheckFailed => 'تعذّر التحقق من حالة طلبك';

  @override
  String get verifyingAccount => 'جارٍ التحقق من حسابك وبعض المعلومات …';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get profileLoadFailed => 'تعذّر تحميل بيانات الملف الشخصي';

  @override
  String get balance => 'الرصيد';

  @override
  String get edit => 'تعديل';

  @override
  String get editPhoneOnlyDriver =>
      'يمكنك تعديل رقم هاتفك فقط. لتغيير اسمك أو بيانات مركبتك تواصل مع الدعم.';

  @override
  String get currencyIqd => 'د.ع';

  @override
  String riderEtaMinutes(String minutes) {
    return 'توصل خلال $minutes دقائق';
  }

  @override
  String distanceKm(String value) {
    return '$value كم';
  }

  @override
  String coordinatePair(String lat, String lng) {
    return '$lat، $lng';
  }

  @override
  String durationHoursMinutes(String hours, String minutes) {
    return '$hours س $minutes د';
  }

  @override
  String durationHours(String hours) {
    return '$hours س';
  }

  @override
  String durationMinutes(String minutes) {
    return '$minutes د';
  }

  @override
  String get earnings => 'الأرباح';

  @override
  String get totalEarnings => 'إجمالي الأرباح';

  @override
  String get periodToday => 'اليوم';

  @override
  String get periodLast7Days => 'آخر 7 أيام';

  @override
  String get periodLast30Days => 'آخر 30 يوماً';

  @override
  String get completedRidesLabel => 'الرحلات المكتملة';

  @override
  String get onlineTimeLabel => 'وقت الاتصال';

  @override
  String get cashOut => 'سحب الأرباح';

  @override
  String get cashOutUnavailableHint => 'لا توجد أرباح متاحة للسحب حالياً.';

  @override
  String get cashOutSoonTitle => 'السحب قريباً';

  @override
  String get cashOutSoonMessage =>
      'سحب الأرباح إلى حسابك قيد التجهيز، وسنخبرك فور توفره.';

  @override
  String get restoringRide => 'يتم إعداد بيئة الاتصال';

  @override
  String get shiftChannelName => 'وضع القيادة';

  @override
  String get shiftOnlineTitle => 'انت متصل هسه';

  @override
  String get shiftOnlineBody => 'جاي ندورلك طلبات';

  @override
  String get shiftOnTripTitle => 'الرحله الك';

  @override
  String get shiftOnTripBody => 'مبروك الرحله يا بطل !';

  @override
  String get shiftReconnectingTitle => 'دا نعيد الاتصال';

  @override
  String get shiftReconnectingBody => 'ما تجيك طلبات لحد ما يرجع الاتصال';

  @override
  String get notificationsRequiredForShift =>
      'فعّل الإشعارات حتى توصلك الطلبات وانت خارج التطبيق';

  @override
  String get offerChannelName => 'طلبات الرحلات';

  @override
  String get offerChannelDescription => 'تنبيه صوتي عند وصول طلب رحلة جديد';

  @override
  String get offerAlertTitle => 'طلب رحلة جديد';

  @override
  String get offerAlertBody => 'افتح التطبيق واقبل الطلب قبل ما ينتهي الوقت!';
}
