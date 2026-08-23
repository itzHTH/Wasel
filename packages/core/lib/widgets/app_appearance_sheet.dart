import 'package:flutter/material.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_theme_mode_switch.dart';

/// Bottom sheet holding the Light / Dark / System control.
Future<void> showAppAppearanceSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    builder: (context) => Padding(
      padding: EdgeInsets.fromLTRB(
        AppDimens.space16,
        AppDimens.space16,
        AppDimens.space16,
        AppDimens.space32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: AppDimens.icon48,
              height: AppDimens.space4,
              decoration: BoxDecoration(
                color: context.colors.neutral200,
                borderRadius: BorderRadius.circular(AppDimens.radiusPill),
              ),
            ),
          ),
          SizedBox(height: AppDimens.space24),
          Text(
            context.coreL10n.appearance,
            style: context.styles.font20Secondary900Bold,
          ),
          SizedBox(height: AppDimens.space8),
          Text(
            context.coreL10n.appearanceSheetDescription,
            style: context.styles.font14Neutral400Regular,
          ),
          SizedBox(height: AppDimens.space24),
          const AppThemeModeSwitch(),
        ],
      ),
    ),
  );
}

/// The active mode, for the trailing label on the appearance menu tile.
String appThemeModeLabel(BuildContext context, ThemeMode mode) =>
    switch (mode) {
      ThemeMode.light => context.coreL10n.themeLight,
      ThemeMode.dark => context.coreL10n.themeDark,
      ThemeMode.system => context.coreL10n.themeSystem,
    };
