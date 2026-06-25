import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSkip;

  const AuthHeader({super.key, required this.title, this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppDimens.space24),
        Text(
          title,
          style: AppTextStyles.font24Secondary900Bold,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppDimens.space8),
        Text.rich(
          TextSpan(
            text: 'احصل على تجربة رائعة مع ',
            style: AppTextStyles.font14Neutral400Regular,
            children: [
              TextSpan(
                text: 'وَصَل',
                style: AppTextStyles.font14Neutral400Regular.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.secondary900,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
