import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

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
          style: context.styles.headline(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppDimens.space8),
        Text.rich(
          TextSpan(
            text: context.l10n.authHeaderTagline,
            style: context.styles.body(color: context.colors.neutral400),
            children: [
              TextSpan(
                text: context.l10n.brandName,
                style: context.styles
                    .body(color: context.colors.neutral400)
                    .copyWith(
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
