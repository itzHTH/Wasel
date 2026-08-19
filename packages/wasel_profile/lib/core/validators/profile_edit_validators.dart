import 'package:wasel_core/helpers/app_validators.dart';

/// Arabic-facing validation for the profile edit form.
class ProfileEditValidators {
  const ProfileEditValidators._();

  static String? name(String? value, {required String fieldLabel}) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return '$fieldLabel مطلوب';

    return AppValidators.name(trimmed) == null
        ? null
        : '$fieldLabel يجب أن لا يقل عن حرفين';
  }

  static String? phoneNumber(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'رقم الهاتف مطلوب';

    return AppValidators.phone(trimmed) == null
        ? null
        : 'رقم الهاتف يجب أن يتكون من ١١ رقماً';
  }
}
