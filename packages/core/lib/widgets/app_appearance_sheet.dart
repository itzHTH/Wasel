import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_theme_mode_switch.dart';

/// Bottom sheet holding the Light / Dark / System control.
Future<void> showAppAppearanceSheet(
  BuildContext context, {
  String title = 'المظهر',
  String description = 'اختر مظهر التطبيق أو اتركه يتبع إعدادات جهازك.',
}) {
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
          Text(title, style: context.styles.font20Secondary900Bold),
          SizedBox(height: AppDimens.space8),
          Text(description, style: context.styles.font14Neutral400Regular),
          SizedBox(height: AppDimens.space24),
          const AppThemeModeSwitch(),
        ],
      ),
    ),
  );
}

/// The active mode, for the trailing label on the appearance menu tile.
String appThemeModeLabel(ThemeMode mode) => switch (mode) {
  ThemeMode.light => 'فاتح',
  ThemeMode.dark => 'داكن',
  ThemeMode.system => 'النظام',
};
