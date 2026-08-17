import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:driver/features/auth/ui/widgets/common/auth_primary_button.dart';
import 'package:driver/features/auth/ui/widgets/reset_password/password_page/new_password_form.dart';
import 'package:wasel_auth/presentation/providers/reset_password/reset_password_controller.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_core/widgets/app_back_button.dart';
import 'package:wasel_core/widgets/app_inline_error.dart';

class CreateNewPasswordPage extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPassCtrl;
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  final VoidCallback onExpiredRestart;

  const CreateNewPasswordPage({
    super.key,
    required this.formKey,
    required this.passwordCtrl,
    required this.confirmPassCtrl,
    required this.onSubmit,
    required this.onBack,
    required this.onExpiredRestart,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(resetPasswordControllerProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppDimens.space24),
          AppBackButton(onTap: onBack),
          SizedBox(height: AppDimens.space24),

          Text(
            'كلمة مرور جديدة',
            style: AppTextStyles.font24Secondary900Bold,
          ),
          SizedBox(height: AppDimens.space8),
          Text(
            'اختر كلمة مرور جديدة لحسابك',
            style: AppTextStyles.font14Neutral400Regular,
          ),
          SizedBox(height: AppDimens.space32),

          NewPasswordForm(
            formKey: formKey,
            passwordCtrl: passwordCtrl,
            confirmPassCtrl: confirmPassCtrl,
          ),
          AppInlineError(message: state.fieldError),
          SizedBox(height: AppDimens.space32),

          if (state.tokenExpired)
            TextButton(
              onPressed: onExpiredRestart,
              child: Text(
                'طلب رمز جديد',
                style: AppTextStyles.font14Primary500SemiBold,
              ),
            )
          else
            AuthPrimaryButton(
              label: 'إعادة تعيين كلمة المرور',
              onPressed: state.isSubmitting ? null : onSubmit,
              isLoading: state.isSubmitting,
            ),
          SizedBox(height: AppDimens.space32),
        ],
      ),
    );
  }
}
