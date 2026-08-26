import 'package:flutter/material.dart';
import 'package:wasel_core/widgets/feedback/app_snack_bar.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasel_auth/wasel_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_prompt_row.dart';
import 'package:wasal/features/auth/ui/providers/login/login_provider.dart';
import 'package:wasal/features/auth/ui/widgets/common/auth_header.dart';
import 'package:wasal/features/auth/ui/widgets/common/auth_social_section.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .read(loginProvider.notifier)
          .login(_emailCtrl.text.trim(), _passCtrl.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    _loginListener(context);

    return Scaffold(
      backgroundColor: context.colors.neutral0,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                AuthHeader(title: context.l10n.loginTagline),
                SizedBox(height: AppDimens.space32),

                // Login Form
                LoginForm(
                  formKey: _formKey,
                  emailCtrl: _emailCtrl,
                  passCtrl: _passCtrl,
                ),
                SizedBox(height: AppDimens.space8),

                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.resetPassword),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimens.space12,
                      ),
                      child: Text(
                        context.authL10n.forgotPassword,
                        style: context.styles.bodyBrand(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppDimens.space16),

                // Submit Button
                Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(loginProvider);
                    return AuthPrimaryButton(
                      isLoading: state.isLoading,
                      label: context.authL10n.login,
                      onPressed: _handleSubmit,
                    );
                  },
                ),
                SizedBox(height: AppDimens.space24),

                AuthSocialSection(googleLabel: context.l10n.loginWithGoogle),
                SizedBox(height: AppDimens.space24),

                AppPromptRow(
                  message: context.authL10n.noAccount,
                  actionLabel: context.authL10n.createAccount,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.register),
                ),
                SizedBox(height: AppDimens.space48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginListener(BuildContext context) {
    ref.listen(loginProvider, (previous, next) {
      // A request in flight carries the PREVIOUS error forward, because
      // Riverpod copies the old state onto AsyncLoading. Reporting it here
      // replays the last failure for the whole round trip.
      if (next.isLoading) return;

      if (next.hasError) {
        // The raw object would put a DioException in front of the user.
        AppSnackBar.showError(context, errorMessageOf(next.error!));
      } else if (next.value != null) {
        // No message for the in-flight state: the button already carries it,
        // and a second snackbar per attempt is what backed the queue up.
        AppSnackBar.show(context, context.authL10n.loginSuccess);
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.ride,
          (route) => false,
        );
      }
    });
  }
}
