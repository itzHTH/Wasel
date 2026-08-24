import 'package:flutter/material.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/feedback/app_loading.dart';
import 'package:wasel_core/widgets/avatar/app_profile_avatar.dart';

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
        color: context.colors.primary500,
        shape: BoxShape.circle,
        border: Border.all(color: context.colors.elementBackground, width: 2),
      ),
      child: Icon(
        Icons.photo_camera_rounded,
        size: AppDimens.icon18,
        color: context.colors.onPrimary,
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
                color: context.colors.scrim.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AppInlineLoading(
                  size: resolvedSize / 3,
                  color: context.colors.onScrim,
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
      label: context.coreL10n.changeProfilePicture,
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
