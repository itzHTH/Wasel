import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

/// Explains why some fields are locked, so the greyed-out rows read as a
/// deliberate policy rather than a broken form.
class ProfileEditLockedNote extends StatelessWidget {
  const ProfileEditLockedNote({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.space12),
      decoration: BoxDecoration(
        color: AppColor.alertInfo100,
        borderRadius: BorderRadius.circular(AppDimens.radius12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: AppDimens.icon18,
            color: AppColor.alertInfo500,
          ),
          SizedBox(width: AppDimens.space8),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.font12Neutral600SemiBold.copyWith(
                color: AppColor.alertInfo500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
