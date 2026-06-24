import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:driver/features/auth/ui/providers/login/login_provider.dart';
import 'package:driver/features/auth/ui/widgets/common/auth_header.dart';
import 'package:driver/features/auth/ui/widgets/common/auth_primary_button.dart';
import 'package:driver/features/auth/ui/widgets/login/login_form.dart';

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
          .login(_emailCtrl.text.trim(), _passCtrl.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    _loginListener(context);

    return Scaffold(
      backgroundColor: AppColor.neutral0,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthHeader(title: 'سجّل دخولك كسائق'),
                SizedBox(height: AppDimens.space32),

                // Login Form
                LoginForm(
                  formKey: _formKey,
                  emailCtrl: _emailCtrl,
                  passCtrl: _passCtrl,
                ),
                SizedBox(height: AppDimens.space24),

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

                // Navigate to Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ليس لديك حساب؟ ',
                      style: AppTextStyles.font14Neutral400Regular,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.register),
                      child: Text(
                        'إنشاء حساب',
                        style: AppTextStyles.font14Primary500SemiBold,
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
          AppRoutes.home,
          (route) => false,
        );
      }
    });
  }
}
