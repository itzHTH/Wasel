import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

class AppMenuTile extends StatelessWidget {
  const AppMenuTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.trailing,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;

    final color = isDestructive
        ? AppColor.alertError500
        : isEnabled
        ? AppColor.secondary900
        : AppColor.neutral400;

    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: AppDimens.space24),
      leading: Icon(icon, size: AppDimens.icon24, color: color),
      title: Text(
        label,
        style: isDestructive
            ? AppTextStyles.font14alertError500SemiBold
            : isEnabled
            ? AppTextStyles.font14Secondary900SemiBold
            : AppTextStyles.font14Neutral400Regular,
      ),
      trailing: trailing,
    );
  }
}
