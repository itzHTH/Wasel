import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/rejection_banner.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/wizard_progress.dart';

/// Wizard header: an optional rejection banner above the step-progress bar.
/// Only the progress bar rebuilds, driven by [currentStep].
class WizardHeader extends StatelessWidget {
  final ValueListenable<int> currentStep;
  final List<String> stepTitles;
  final String? rejectionReason;

  const WizardHeader({
    super.key,
    required this.currentStep,
    required this.stepTitles,
    this.rejectionReason,
  });

  @override
  Widget build(BuildContext context) {
    final hPadding = AppDimens.screenHPadding;
    return Column(
      children: [
        if (rejectionReason != null)
          Padding(
            padding: EdgeInsets.fromLTRB(
              hPadding,
              AppDimens.space16,
              hPadding,
              0,
            ),
            child: RejectionBanner(reason: rejectionReason!),
          ),
        Padding(
          padding: EdgeInsets.fromLTRB(hPadding, AppDimens.space16, hPadding, 0),
          child: ValueListenableBuilder<int>(
            valueListenable: currentStep,
            builder: (context, step, _) => WizardProgress(
              currentStep: step,
              stepTitle: stepTitles[step],
            ),
          ),
        ),
      ],
    );
  }
}
