import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AppBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Semantics(
        button: true,
        label: context.coreL10n.back,
        child: GestureDetector(
          onTap: onTap ?? () => Navigator.pop(context),
          child: Container(
            width: 44.r,
            height: 44.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                context.shape.badgeRadiusFor(44.r),
              ),
              border: Border.all(color: context.colors.neutral200, width: 1.5),
            ),
            // Icons.arrow_back_rounded carries matchTextDirection, so Flutter
            // already mirrors it in RTL. Picking the forward glyph here as
            // well cancelled that out and left the arrow pointing the way the
            // reader is going.
            child: Icon(
              Icons.arrow_back_rounded,
              size: AppDimens.icon20,
              color: context.colors.secondary900,
            ),
          ),
        ),
      ),
    );
  }
}
