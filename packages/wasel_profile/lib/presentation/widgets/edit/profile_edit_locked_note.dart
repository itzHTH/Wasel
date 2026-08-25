import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

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
        color: context.colors.alertInfo100,
        borderRadius: BorderRadius.circular(AppDimens.radius12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: AppDimens.icon18,
            color: context.colors.alertInfo500,
          ),
          SizedBox(width: AppDimens.space8),
          Expanded(
            child: Text(
              message,
              style: context.styles
                  .caption(
                    weight: FontWeight.w600,
                    color: context.colors.neutral600,
                  )
                  .copyWith(color: context.colors.alertInfo500),
            ),
          ),
        ],
      ),
    );
  }
}
