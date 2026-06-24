import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

/// Boundary placeholder for the driver verification feature.
///
/// The real feature (document upload + status polling) is intentionally not
/// implemented here — see README_SPEC.md in this feature folder for the
/// contract. This screen only exists so the route compiles and is reachable.
class VerificationPlaceholderScreen extends StatelessWidget {
  const VerificationPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.neutral0,
      appBar: AppBar(title: const Text('توثيق السائق')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified_user_outlined,
                size: AppDimens.icon20 * 3,
                color: AppColor.neutral400,
              ),
              SizedBox(height: AppDimens.space16),
              Text(
                'TODO: توثيق السائق',
                style: AppTextStyles.font24Secondary900Bold,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
