import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

class AuthSocialSection extends StatelessWidget {
  final VoidCallback? onGoogleTap;
  final String googleLabel;

  const AuthSocialSection({
    super.key,
    this.onGoogleTap,
    this.googleLabel = 'التسجيل باستخدام جوجل',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _DividerRow(),
        SizedBox(height: AppDimens.space16),
        _GoogleButton(label: googleLabel, onTap: onGoogleTap),
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
            'أو سجل باستخدام',
            style: context.styles.font12Neutral400Regular,
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
            Text(label, style: context.styles.font14Secondary500Medium),
          ],
        ),
      ),
    );
  }
}
