import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

/// Driver auth header. Mirrors the rider header layout but with driver-facing
/// copy ("وَصَل سائق").
class AuthHeader extends StatelessWidget {
  final String title;

  const AuthHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppDimens.space24),
        Text(
          title,
          style: context.styles.font24Secondary900Bold,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppDimens.space8),
        Text.rich(
          TextSpan(
            text: 'انضم إلى أسطول ',
            style: context.styles.font14Neutral400Regular,
            children: [
              TextSpan(
                text: 'وَصَل سائق',
                style: context.styles.font14Neutral400Regular.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.colors.secondary900,
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
