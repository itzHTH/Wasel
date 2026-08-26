import 'package:flutter/material.dart';
import 'package:wasel_auth/wasel_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/helpers/app_validators.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/forms/app_field_icon.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_prompt_row.dart';
import 'package:wasel_core/widgets/buttons/app_back_button.dart';
import 'package:wasel_core/widgets/feedback/app_inline_error.dart';
import 'package:wasel_core/widgets/forms/app_labeled_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final VoidCallback onSubmit;

  const ForgotPasswordPage({
    super.key,
    required this.formKey,
    required this.emailCtrl,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppDimens.space24),
          const AppBackButton(),
          SizedBox(height: AppDimens.space24),

          Text(
            context.authL10n.forgotPassword,
            style: context.styles.headline(),
          ),
          SizedBox(height: AppDimens.space8),
          Text(
            context.authL10n.forgotPasswordDescription,
            style: context.styles.bodyMuted(),
          ),
          SizedBox(height: AppDimens.space32),

          AutofillGroup(
            child: Form(
              key: formKey,
              child: AppLabeledFormField(
                label: context.authL10n.email,
                hintText: context.authL10n.enterEmail,
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                autofillHints: const [
                  AutofillHints.username,
                  AutofillHints.email,
                ],
                validator: AppValidators.email,
                prefixIcon: const AppFieldIcon(Icons.email_outlined),
              ),
            ),
          ),

          Consumer(
            builder: (context, ref, child) {
              final error = ref.watch(
                resetPasswordControllerProvider.select((s) => s.fieldError),
              );
              return AppInlineError(message: error);
            },
          ),
          SizedBox(height: AppDimens.space24),

          Consumer(
            builder: (context, ref, child) {
              final isSubmitting = ref.watch(
                resetPasswordControllerProvider.select((s) => s.isSubmitting),
              );
              return AuthPrimaryButton(
                label: context.authL10n.sendCode,
                onPressed: isSubmitting ? null : onSubmit,
                isLoading: isSubmitting,
              );
            },
          ),
          SizedBox(height: AppDimens.space24),

          AppPromptRow(
            message: context.authL10n.rememberedPassword,
            actionLabel: context.authL10n.login,
            onTap: () => Navigator.pop(context),
          ),
          SizedBox(height: AppDimens.space32),
        ],
      ),
    );
  }
}
