import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasal/features/auth/ui/providers/login/login_provider.dart';
import 'package:wasal/features/auth/ui/widgets/common/auth_header.dart';
import 'package:wasal/features/auth/ui/widgets/common/auth_primary_button.dart';
import 'package:wasal/features/auth/ui/widgets/common/auth_social_section.dart';
import 'package:wasal/features/auth/ui/widgets/login/login_form.dart';

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
                const AuthHeader(title: 'اطلب تكسي في أي وقت'),
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
                        'نسيت كلمة المرور؟',
                        style: context.styles.font14Primary500SemiBold,
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
                      label: 'تسجيل الدخول',
                      onPressed: _handleSubmit,
                    );
                  },
                ),
                SizedBox(height: AppDimens.space24),

                const AuthSocialSection(
                  googleLabel: 'سجّل الدخول باستخدام جوجل',
                ),
                SizedBox(height: AppDimens.space24),

                // Navigate to Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ليس لديك حساب؟ ',
                      style: context.styles.font14Neutral400Regular,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.register),
                      child: Text(
                        'إنشاء حساب',
                        style: context.styles.font14Primary500SemiBold,
                      ),
                    ),
                  ],
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
    ref.listen(loginProvider.select((state) => state), (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      } else if (next.isLoading) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('جاري تسجيل الدخول...')));
      } else if (next.value != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('تم تسجيل الدخول بنجاح')));
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.ride,
          (route) => false,
        );
      }
    });
  }
}
