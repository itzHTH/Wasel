import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasal/core/theme/app_color.dart';
import 'package:wasal/features/auth/ui/providers/logout/logout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الرئيسية')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('مرحباً بك في تطبيقنا!', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                ref.watch(logoutProvider);
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary500,
                    foregroundColor: AppColor.neutral200,
                    fixedSize: const Size(250, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    ref.read(logoutProvider.notifier).execute().then((
                      isLoggedOut,
                    ) {
                      if (isLoggedOut && context.mounted) {
                        Navigator.pushReplacementNamed(context, AppRoutes.auth);
                      } else {
                        if (context.mounted) {
                          // Handle logout failure (e.g., show an error message)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('فشل تسجيل الخروج. حاول مرة أخرى.'),
                            ),
                          );
                        }
                      }
                    });
                  },
                  child: ref
                      .watch(logoutProvider)
                      .when(
                        data: (isLoggedOut) => const Text("تسجيل الخروج"),
                        loading: () => const CircularProgressIndicator(
                          color: AppColor.neutral200,
                        ),
                        error: (error, stackTrace) =>
                            const Text("فشل تسجيل الخروج"),
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
