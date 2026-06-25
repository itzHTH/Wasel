import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

class AppHeaderWithLogo extends StatelessWidget {
  const AppHeaderWithLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/icons/wasel-icon.svg",
          height: AppDimens.icon36,
        ),
        SizedBox(width: AppDimens.space8),
        Text("وَصَل", style: AppTextStyles.font24Secondary900Bold),
      ],
    );
  }
}
