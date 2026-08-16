import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/app_profile_avatar.dart';

class AppEditableAvatar extends StatelessWidget {
  const AppEditableAvatar({super.key, this.photoUrl, this.size, this.onTap});

  final String? photoUrl;
  final double? size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final onTap = this.onTap;

    final badge = Container(
      padding: EdgeInsets.all(AppDimens.space8),
      decoration: BoxDecoration(
        color: AppColor.primary500,
        shape: BoxShape.circle,
        border: Border.all(color: AppColor.neutral0, width: 2),
      ),
      child: Icon(
        Icons.photo_camera_rounded,
        size: AppDimens.icon18,
        color: AppColor.neutral0,
      ),
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppProfileAvatar(photoUrl: photoUrl, size: size),
        PositionedDirectional(
          bottom: 0,
          end: 0,
          child: onTap == null
              ? badge
              : InkWell(
                  onTap: onTap,
                  customBorder: const CircleBorder(),
                  child: badge,
                ),
        ),
      ],
    );
  }
}
