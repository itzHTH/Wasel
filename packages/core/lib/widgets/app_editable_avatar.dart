import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/app_loading.dart';
import 'package:wasel_core/widgets/app_profile_avatar.dart';

class AppEditableAvatar extends StatelessWidget {
  const AppEditableAvatar({
    super.key,
    this.photoUrl,
    this.size,
    this.onTap,
    this.isLoading = false,
  });

  final String? photoUrl;
  final double? size;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final resolvedSize = size ?? AppDimens.icon48;
    final onTap = isLoading ? null : this.onTap;

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

    final avatar = Stack(
      clipBehavior: Clip.none,
      children: [
        AppProfileAvatar(photoUrl: photoUrl, size: resolvedSize),
        if (isLoading)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColor.secondary900.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AppInlineLoading(
                  size: resolvedSize / 3,
                  color: AppColor.neutral0,
                ),
              ),
            ),
          ),
        PositionedDirectional(bottom: 0, end: 0, child: badge),
      ],
    );

    if (onTap == null) return avatar;

    return Semantics(
      button: true,
      label: 'تغيير الصورة الشخصية',
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: avatar,
        ),
      ),
    );
  }
}
