import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasel_auth/wasel_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/helpers/app_validators.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/forms/app_field_icon.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasal/features/auth/ui/providers/register/register_provider.dart';
import 'package:wasal/features/auth/ui/widgets/common/auth_header.dart';
import 'package:wasel_core/widgets/forms/app_labeled_field.dart';
import 'package:wasal/features/auth/ui/widgets/common/auth_social_section.dart';

class RegisterEmailPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final VoidCallback onSubmit;

  const RegisterEmailPage({
    super.key,
    required this.formKey,
    required this.emailCtrl,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: AppDimens.space16),
            AuthHeader(title: context.l10n.registerTagline),
            SizedBox(height: AppDimens.space32),

            // Email field
            Form(
              key: formKey,
              child: AppLabeledFormField(
                label: context.authL10n.email,
                hintText: context.authL10n.enterEmail,
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                validator: AppValidators.email,
                prefixIcon: const AppFieldIcon(Icons.email_outlined),
              ),
            ),
            SizedBox(height: AppDimens.space24),

            // Submit
            Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(registerProvider);
                return AuthPrimaryButton(
                  isLoading: state.isLoading,
                  label: context.authL10n.createAccount,
                  onPressed: onSubmit,
                );
              },
            ),
            SizedBox(height: AppDimens.space24),

            AuthSocialSection(googleLabel: context.l10n.registerWithGoogle),
            SizedBox(height: AppDimens.space24),

            // Navigate to Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.authL10n.alreadyHaveAccount,
                  style: context.styles.bodyMuted(),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    context.authL10n.login,
                    style: context.styles.bodyBrand(),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimens.space32),
          ],
        ),
      ),
    );
  }
}
