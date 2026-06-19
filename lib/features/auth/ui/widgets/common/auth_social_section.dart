import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wasal/core/theme/app_color.dart';
import 'package:wasal/core/theme/app_dimens.dart';
import 'package:wasal/core/theme/app_text_styles.dart';

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
        const Expanded(
          child: Divider(color: AppColor.neutral200, thickness: 1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            'أو سجل باستخدام',
            style: AppTextStyles.font12Neutral400Regular,
          ),
        ),
        const Expanded(
          child: Divider(color: AppColor.neutral200, thickness: 1),
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
          color: AppColor.neutral0,
          borderRadius: BorderRadius.circular(AppDimens.radiusPill),
          border: Border.all(color: AppColor.neutral200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/google_logo.svg'),
            SizedBox(width: 10.w),
            Text(label, style: AppTextStyles.font14Secondary500Medium),
          ],
        ),
      ),
    );
  }
}
