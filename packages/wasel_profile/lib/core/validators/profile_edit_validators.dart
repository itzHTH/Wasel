import 'package:wasel_core/helpers/app_validators.dart';
import 'package:wasel_profile/l10n/profile_localizations.dart';

class ProfileEditValidators {
  const ProfileEditValidators._();

  static String? name(
    String? value, {
    required String fieldLabel,
    required ProfileLocalizations l10n,
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return l10n.fieldRequired(fieldLabel);

    return AppValidators.name(trimmed) == null
        ? null
        : l10n.fieldTooShort(fieldLabel);
  }

  static String? phoneNumber(String? value, ProfileLocalizations l10n) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return l10n.phoneRequired;

    return AppValidators.phone(trimmed) == null ? null : l10n.phoneLength;
  }
}
