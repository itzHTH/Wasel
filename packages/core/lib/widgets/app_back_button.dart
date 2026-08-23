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
    // The arrow points back the way the reader came, which flips with the
    // text direction now that direction follows the locale.
    final isRtl = Directionality.of(context) == TextDirection.rtl;

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
              shape: BoxShape.circle,
              border: Border.all(color: context.colors.neutral200, width: 1.5),
            ),
            child: Icon(
              isRtl ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded,
              size: AppDimens.icon20,
              color: context.colors.secondary900,
            ),
          ),
        ),
      ),
    );
  }
}
