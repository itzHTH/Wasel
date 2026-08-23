import 'package:flutter/widgets.dart';
import 'package:wasel_profile/l10n/profile_localizations.dart';

/// Shorthand for the generated ProfileLocalizations lookup, matching the
/// `context.colors` / `context.styles` convention used across the apps.
extension ProfileL10nX on BuildContext {
  ProfileLocalizations get profileL10n => ProfileLocalizations.of(this);
}
