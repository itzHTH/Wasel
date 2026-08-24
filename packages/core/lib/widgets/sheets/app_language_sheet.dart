import 'package:flutter/material.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:wasel_core/localization/app_local_type.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/settings/app_language_switch.dart';

/// Bottom sheet holding the Arabic / English control.
Future<void> showAppLanguageSheet(BuildContext context) {
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
            context.coreL10n.language,
            style: context.styles.font20Secondary900Bold,
          ),
          SizedBox(height: AppDimens.space8),
          Text(
            context.coreL10n.languageSheetDescription,
            style: context.styles.font14Neutral400Regular,
          ),
          SizedBox(height: AppDimens.space24),
          const AppLanguageSwitch(),
        ],
      ),
    ),
  );
}

/// The active language, for the trailing label on the language menu tile.
/// Each language names itself, so this reads correctly in either direction.
String appLocaleLabel(Locale locale) => AppLocaleType.values
    .firstWhere(
      (type) => type.code == locale.languageCode,
      orElse: () => AppLocaleType.arabic,
    )
    .name;
