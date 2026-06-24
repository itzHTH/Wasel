import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:driver/features/auth/ui/widgets/common/auth_primary_button.dart';

/// Persistent wizard footer: an optional secondary "Back" and the primary
/// "Next" action, which becomes "Submit" on the final step. The primary action
/// is disabled (greyed) until the current step's gating is satisfied.
class WizardBottomBar extends StatelessWidget {
  final bool showBack;
  final bool isLastStep;
  final bool isNextEnabled;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const WizardBottomBar({
    super.key,
    required this.showBack,
    required this.isLastStep,
    required this.isNextEnabled,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.neutral0,
        border: Border(top: BorderSide(color: AppColor.neutral100, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.screenHPadding,
            vertical: AppDimens.space16,
          ),
          child: Row(
            children: [
              if (showBack) ...[
                SizedBox(width: 110.w, child: _BackButton(onTap: onBack)),
                SizedBox(width: AppDimens.space12),
              ],
              Expanded(
                child: AuthPrimaryButton(
                  label: isLastStep ? 'إرسال' : 'التالي',
                  onPressed: isNextEnabled ? onNext : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.buttonHeight,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColor.neutral200, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusPill),
          ),
        ),
        child: Text('السابق', style: AppTextStyles.font14Secondary900SemiBold),
      ),
    );
  }
}
