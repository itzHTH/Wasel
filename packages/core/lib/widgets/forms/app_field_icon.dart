import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

/// The leading icon every labelled form field across both apps draws: the
/// neutral tint and 20pt size were repeated at each call site.
class AppFieldIcon extends StatelessWidget {
  const AppFieldIcon(this.icon, {super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) => Icon(
    icon,
    color: context.colors.neutral400,
    size: AppDimens.icon20,
  );
}
