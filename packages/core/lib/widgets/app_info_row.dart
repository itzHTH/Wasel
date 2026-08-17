import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

class AppInfoRow extends StatelessWidget {
  const AppInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueTextDirection,
    this.emptyPlaceholder = 'غير محدد',
    this.trailing,
  });

  final IconData icon;
  final String label;
  final String? value;
  final TextDirection? valueTextDirection;
  final String emptyPlaceholder;
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
              color: AppColor.primary100,
              borderRadius: BorderRadius.circular(AppDimens.radius12),
            ),
            child: Icon(
              icon,
              size: AppDimens.icon20,
              color: AppColor.primary500,
            ),
          ),
          SizedBox(width: AppDimens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: AppTextStyles.font12Neutral400Regular),
                SizedBox(height: AppDimens.space4),
                Text(
                  hasValue ? value : emptyPlaceholder,
                  textDirection: hasValue ? valueTextDirection : null,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: hasValue
                      ? AppTextStyles.font14Secondary900SemiBold
                      : AppTextStyles.font14Neutral400Regular,
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
