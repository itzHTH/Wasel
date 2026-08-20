import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:driver/features/auth/ui/widgets/common/auth_primary_button.dart';

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
        color: context.colors.neutral0,
        border: Border(
          top: BorderSide(color: context.colors.neutral100, width: 1),
        ),
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
                SizedBox(
                  width: 110.w,
                  child: _BackButton(onTap: onBack),
                ),
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
          side: BorderSide(color: context.colors.neutral200, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusPill),
          ),
        ),
        child: Text('السابق', style: context.styles.font14Secondary900SemiBold),
      ),
    );
  }
}
