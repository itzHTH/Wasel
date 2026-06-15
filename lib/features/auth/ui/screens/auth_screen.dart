import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/networking/errors/error_handler.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasal/core/theme/app_color.dart';
import 'package:wasal/core/theme/app_dimens.dart';
import 'package:wasal/features/auth/data/models/login/request/login_request.dart';
import 'package:wasal/features/auth/ui/providers/login_provider.dart';
import 'package:wasal/features/auth/ui/widgets/auth_header.dart';
import 'package:wasal/features/auth/ui/widgets/auth_primary_button.dart';
import 'package:wasal/features/auth/ui/widgets/auth_social_section.dart';
import 'package:wasal/features/auth/ui/widgets/auth_tab_switcher.dart';
import 'package:wasal/features/auth/ui/widgets/login_form.dart';
import 'package:wasal/features/auth/ui/widgets/register_form.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool _isLogin = true;

  // Login form
  final _loginFormKey = GlobalKey<FormState>();
  final _loginEmailCtrl = TextEditingController();
  final _loginPassCtrl = TextEditingController();
  bool _loginPassVisible = false;

  // Register form
  final _registerFormKey = GlobalKey<FormState>();
  final _registerEmailCtrl = TextEditingController();

  @override
  void dispose() {
    _loginEmailCtrl.dispose();
    _loginPassCtrl.dispose();
    _registerEmailCtrl.dispose();
    super.dispose();
  }

  void _onTabChanged(bool isLogin) {
    setState(() => _isLogin = isLogin);
  }

  void _handleSubmit(WidgetRef ref) {
    if (_isLogin) {
      if (_loginFormKey.currentState?.validate() ?? false) {
        ref
            .read(loginProvider.notifier)
            .login(
              LoginRequest(
                email: _loginEmailCtrl.text.trim(),
                password: _loginPassCtrl.text.trim(),
              ),
            );
      }
    } else {
      if (_registerFormKey.currentState?.validate() ?? false) {
        Navigator.pushNamed(
          context,
          AppRoutes.otpVerification,
          arguments: _registerEmailCtrl.text,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginProvider.select((state) => state), (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      } else if (next.isLoading) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('جاري تسجيل الدخول...')));
      } else {
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

    return Scaffold(
      backgroundColor: AppColor.neutral0,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppDimens.space16),
              const AuthHeader(title: 'الشحن وتتبع في أي وقت'),
              SizedBox(height: AppDimens.space32),
              AuthTabSwitcher(
                isLoginSelected: _isLogin,
                onTabChanged: _onTabChanged,
              ),
              SizedBox(height: AppDimens.space24),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: _isLogin
                    ? LoginForm(
                        key: const ValueKey('login'),
                        formKey: _loginFormKey,
                        emailCtrl: _loginEmailCtrl,
                        passCtrl: _loginPassCtrl,
                        passVisible: _loginPassVisible,
                        onTogglePass: () => setState(
                          () => _loginPassVisible = !_loginPassVisible,
                        ),
                      )
                    : RegisterForm(
                        key: const ValueKey('register'),
                        formKey: _registerFormKey,
                        emailCtrl: _registerEmailCtrl,
                      ),
              ),
              SizedBox(height: AppDimens.space24),
              Consumer(
                builder: (context, ref, child) {
                  final state = ref.watch(loginProvider);
                  return AuthPrimaryButton(
                    isLoading: state.isLoading,
                    label: _isLogin ? 'تسجيل الدخول' : 'إنشاء حساب',
                    onPressed: () => _handleSubmit(ref),
                  );
                },
              ),
              SizedBox(height: AppDimens.space24),
              AuthSocialSection(
                googleLabel: _isLogin
                    ? 'سجّل الدخول باستخدام جوجل'
                    : 'سجل باستخدام جوجل',
              ),
              SizedBox(height: AppDimens.space32),
            ],
          ),
        ),
      ),
    );
  }
}
