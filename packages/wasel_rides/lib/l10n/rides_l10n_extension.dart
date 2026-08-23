import 'package:flutter/widgets.dart';
import 'package:wasel_rides/l10n/rides_localizations.dart';

/// Shorthand for the generated RidesLocalizations lookup, matching the
/// `context.colors` / `context.styles` convention used across the apps.
extension RidesL10nX on BuildContext {
  RidesLocalizations get ridesL10n => RidesLocalizations.of(this);
}
