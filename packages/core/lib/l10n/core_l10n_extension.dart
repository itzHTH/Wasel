import 'package:flutter/widgets.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';
import 'package:wasel_core/l10n/core_localizations.dart';

/// Shorthand for the generated CoreLocalizations lookup, matching the
/// `context.colors` / `context.styles` convention used across the apps.
extension CoreL10nX on BuildContext {
  CoreLocalizations get coreL10n => CoreLocalizations.of(this);
}

/// Localizations for code that has no BuildContext — repositories, notifiers
/// and helpers. Reads the same active locale the widget tree does.
CoreLocalizations get coreL10nNow =>
    lookupCoreLocalizations(AppLocalizationController.currentLocale);
