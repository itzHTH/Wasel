import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

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
                  color: isActive
                      ? context.colors.primary500
                      : context.colors.neutral200,
                  borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: AppDimens.space12),
        Text(
          context.coreL10n.stepOfSteps(currentStep + 1, totalSteps),
          style: context.styles.captionMuted(),
        ),
        SizedBox(height: AppDimens.space4),
        Text(stepTitle, style: context.styles.title()),
      ],
    );
  }
}
