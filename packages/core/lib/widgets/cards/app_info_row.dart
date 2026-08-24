import 'package:flutter/material.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

class AppInfoRow extends StatelessWidget {
  const AppInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueTextDirection,
    this.emptyPlaceholder,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final String? value;
  final TextDirection? valueTextDirection;
  final String? emptyPlaceholder;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final value = this.value;
    final hasValue = value != null && value.isNotEmpty;
    final trailing = this.trailing;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space16,
        vertical: AppDimens.space12,
      ),
      child: Row(
        children: [
          Container(
            width: AppDimens.icon40,
            height: AppDimens.icon40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colors.primary100,
              borderRadius: BorderRadius.circular(AppDimens.radius12),
            ),
            child: Icon(
              icon,
              size: AppDimens.icon20,
              color: context.colors.primary500,
            ),
          ),
          SizedBox(width: AppDimens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: context.styles.font12Neutral400Regular),
                SizedBox(height: AppDimens.space4),
                Text(
                  hasValue
                      ? value
                      : (emptyPlaceholder ?? context.coreL10n.notSpecified),
                  textDirection: hasValue ? valueTextDirection : null,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: hasValue
                      ? context.styles.font14Secondary900SemiBold
                      : context.styles.font14Neutral400Regular,
                ),
              ],
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: AppDimens.space12),
            trailing,
          ],
        ],
      ),
    );
  }
}
