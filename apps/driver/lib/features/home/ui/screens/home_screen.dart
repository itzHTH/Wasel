import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/features/auth/ui/providers/logout/logout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الرئيسية — السائق')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'مرحباً بك في تطبيق السائق',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: AppDimens.space12),
            Consumer(
              builder: (context, ref, child) {
                final logoutState = ref.watch(logoutProvider);
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary500,
                    foregroundColor: AppColor.neutral0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    fixedSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: logoutState.isLoading
                      ? null
                      : () async {
                          final isLoggedOut = await ref
                              .read(logoutProvider.notifier)
                              .execute();
                          if (!context.mounted) return;
                          if (isLoggedOut) {
                            context.pushNamedAndRemoveUntil(AppRoutes.auth);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('فشل تسجيل الخروج. حاول مرة أخرى.'),
                              ),
                            );
                          }
                        },
                  child: logoutState.isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: AppColor.neutral0,
                          ),
                        )
                      : const Text('تسجيل الخروج'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
