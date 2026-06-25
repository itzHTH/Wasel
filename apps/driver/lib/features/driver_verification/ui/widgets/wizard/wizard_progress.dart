import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

/// Top-of-wizard step indicator: three segmented bars + a "step X of 3" label
/// and the current step's title.
class WizardProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String stepTitle;

  const WizardProgress({
    super.key,
    required this.currentStep,
    required this.stepTitle,
    this.totalSteps = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(totalSteps, (index) {
            final isActive = index <= currentStep;
            return Expanded(
              child: Container(
                height: AppDimens.space4,
                margin: EdgeInsetsDirectional.only(
                  end: index == totalSteps - 1 ? 0 : AppDimens.space8,
                ),
                decoration: BoxDecoration(
                  color: isActive ? AppColor.primary500 : AppColor.neutral200,
                  borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: AppDimens.space12),
        Text(
          'الخطوة ${currentStep + 1} من $totalSteps',
          style: AppTextStyles.font12Neutral400Regular,
        ),
        SizedBox(height: AppDimens.space4),
        Text(stepTitle, style: AppTextStyles.font20Secondary900Bold),
      ],
    );
  }
}
