import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

class AuthSocialSection extends StatelessWidget {
  final VoidCallback? onGoogleTap;

  /// Defaults to the generic sign-up wording; screens that need different
  /// copy pass their own, since a localized default is not a constant.
  final String? googleLabel;

  const AuthSocialSection({super.key, this.onGoogleTap, this.googleLabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _DividerRow(),
        SizedBox(height: AppDimens.space16),
        _GoogleButton(
          label: googleLabel ?? context.l10n.signUpWithGoogle,
          onTap: onGoogleTap,
        ),
      ],
    );
  }
}

class _DividerRow extends StatelessWidget {
  const _DividerRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: context.colors.neutral200, thickness: 1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            context.l10n.orSignUpWith,
            style: context.styles.caption(color: context.colors.neutral400),
          ),
        ),
        Expanded(
          child: Divider(color: context.colors.neutral200, thickness: 1),
        ),
      ],
    );
  }
}

class _GoogleButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _GoogleButton({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: AppDimens.buttonHeight,
        decoration: BoxDecoration(
          color: context.colors.neutral0,
          borderRadius: BorderRadius.circular(AppDimens.radiusPill),
          border: Border.all(color: context.colors.neutral200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/google_logo.svg'),
            SizedBox(width: 10.w),
            Text(
              label,
              style: context.styles.body(
                weight: FontWeight.w500,
                color: context.colors.secondary500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
