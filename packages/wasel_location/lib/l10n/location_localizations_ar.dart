// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'location_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class LocationLocalizationsAr extends LocationLocalizations {
  LocationLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get settings => 'الإعدادات';

  @override
  String get enable => 'تمكين';

  @override
  String get locationPermissionRequired => 'إذن الموقع مطلوب';

  @override
  String get locationPermissionRequiredMessage =>
      'يرجى تمكين إذن الموقع للوصول إلى هذه الميزة.';

  @override
  String get turnOnLocation => 'شغّل الموقع حتى نلگه مكانك';

  @override
  String get locationServiceOff =>
      'خدمة الموقع مطفّية، شغّلها حتى نگدر نوصل لموقعك';

  @override
  String get locationPermissionMissing => 'ما نگدر نوصل لموقعك بدون إذن الموقع';

  @override
  String get locationNotFound => 'ما گدرنا نلگه موقعك، جرّب مرة ثانية';

  @override
  String get locationError => 'صار خطأ وإحنا ندوّر على موقعك';

  @override
  String get addressSeparator => '، ';
}
