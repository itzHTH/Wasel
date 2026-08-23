// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profile_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class ProfileLocalizationsAr extends ProfileLocalizations {
  ProfileLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get editPhoneOnlyNotice =>
      'يمكنك تعديل رقم هاتفك فقط. لتغيير بقية بياناتك تواصل مع الدعم.';

  @override
  String get profileUpdated => 'تم تحديث بياناتك بنجاح';

  @override
  String get avatarUpdated => 'تم تحديث الصورة بنجاح';

  @override
  String get discardChangesTitle => 'تجاهل التعديلات؟';

  @override
  String get discardChangesMessage =>
      'لديك تغييرات لم يتم حفظها. هل تريد الخروج وتجاهلها؟';

  @override
  String get discard => 'تجاهل';

  @override
  String get keepEditing => 'متابعة التعديل';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get enterFirstName => 'أدخل اسمك الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get enterLastName => 'أدخل اسم عائلتك';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get notSpecified => 'غير محدد';

  @override
  String fieldRequired(String field) {
    return '$field مطلوب';
  }

  @override
  String fieldTooShort(String field) {
    return '$field يجب أن لا يقل عن حرفين';
  }

  @override
  String get phoneRequired => 'رقم الهاتف مطلوب';

  @override
  String get phoneLength => 'رقم الهاتف يجب أن يتكون من ١١ رقماً';
}
