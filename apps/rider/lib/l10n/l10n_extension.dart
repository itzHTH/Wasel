import 'package:flutter/widgets.dart';
import 'package:wasal/l10n/rider_localizations.dart';

/// Shorthand for the generated RiderLocalizations lookup, matching the
/// `context.colors` / `context.styles` convention used across the apps.
extension RiderL10nX on BuildContext {
  RiderLocalizations get l10n => RiderLocalizations.of(this);
}
