import 'package:flutter/widgets.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';
import 'package:wasel_location/l10n/location_localizations.dart';

/// Shorthand for the generated LocationLocalizations lookup, matching the
/// `context.colors` / `context.styles` convention used across the apps.
extension LocationL10nX on BuildContext {
  LocationLocalizations get locationL10n => LocationLocalizations.of(this);
}

/// Localizations for code that has no BuildContext — repositories, notifiers
/// and helpers. Reads the same active locale the widget tree does.
LocationLocalizations get locationL10nNow =>
    lookupLocationLocalizations(AppLocalizationController.currentLocale);
