import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

class AppInfoCard extends StatelessWidget {
  const AppInfoCard({
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

    return Container(
      padding: EdgeInsets.all(AppDimens.space16),
      decoration: BoxDecoration(
        color: AppColor.neutral0,
        borderRadius: BorderRadius.circular(AppDimens.radius16),
        border: Border.all(color: AppColor.neutral200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppDimens.space8),
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
