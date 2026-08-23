import 'package:flutter/widgets.dart';
import 'package:driver/l10n/driver_localizations.dart';

/// Shorthand for the generated DriverLocalizations lookup, matching the
/// `context.colors` / `context.styles` convention used across the apps.
extension DriverL10nX on BuildContext {
  DriverLocalizations get l10n => DriverLocalizations.of(this);
}
