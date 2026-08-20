import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';

/// Segmented progress bar for multi-step wizards.
class AppStepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const AppStepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'الخطوة ${currentStep + 1} من $totalSteps',
      child: ExcludeSemantics(
        child: Row(
          children: List.generate(totalSteps, (index) {
            final isFilled = index <= currentStep;
            return Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  end: index == totalSteps - 1 ? 0 : AppDimens.space8,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: isFilled
                        ? context.colors.primary500
                        : context.colors.neutral200,
                    borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
