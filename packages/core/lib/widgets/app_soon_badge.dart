import 'package:flutter/material.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

class AppSoonBadge extends StatelessWidget {
  const AppSoonBadge({super.key, this.label});

  /// Defaults to the shared "soon" wording; a localized default is not a
  /// constant, so it is resolved at build time.
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
        vertical: AppDimens.space4,
      ),
      decoration: BoxDecoration(
        color: context.colors.neutral100,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
      child: Text(
        label ?? context.coreL10n.soon,
        style: context.styles.font12Neutral600SemiBold,
      ),
    );
  }
}
