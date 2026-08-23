import 'package:flutter/widgets.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';
import 'package:wasel_payments/l10n/payments_localizations.dart';

/// Shorthand for the generated PaymentsLocalizations lookup, matching the
/// `context.colors` / `context.styles` convention used across the apps.
extension PaymentsL10nX on BuildContext {
  PaymentsLocalizations get paymentsL10n => PaymentsLocalizations.of(this);
}

/// Localizations for code that has no BuildContext — repositories, notifiers
/// and helpers. Reads the same active locale the widget tree does.
PaymentsLocalizations get paymentsL10nNow =>
    lookupPaymentsLocalizations(AppLocalizationController.currentLocale);
