import 'package:flutter/widgets.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';
import 'package:wasel_auth/l10n/auth_localizations.dart';

/// Shorthand for the generated AuthLocalizations lookup, matching the
/// `context.colors` / `context.styles` convention used across the apps.
extension AuthL10nX on BuildContext {
  AuthLocalizations get authL10n => AuthLocalizations.of(this);
}

/// Localizations for code that has no BuildContext — repositories, notifiers
/// and helpers. Reads the same active locale the widget tree does.
AuthLocalizations get authL10nNow =>
    lookupAuthLocalizations(AppLocalizationController.currentLocale);
