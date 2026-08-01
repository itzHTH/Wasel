import 'package:flutter/foundation.dart' show ValueListenable, ValueGetter;
import 'package:flutter/material.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/wizard_bottom_bar.dart';

class WizardFooter extends StatelessWidget {
  final Listenable gate;
  final ValueListenable<int> currentStep;
  final int stepCount;
  final ValueGetter<bool> isNextEnabled;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const WizardFooter({
    super.key,
    required this.gate,
    required this.currentStep,
    required this.stepCount,
    required this.isNextEnabled,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: gate,
      builder: (context, _) => WizardBottomBar(
        showBack: currentStep.value > 0,
        isLastStep: currentStep.value == stepCount - 1,
        isNextEnabled: isNextEnabled(),
        onBack: onBack,
        onNext: onNext,
      ),
    );
  }
}
