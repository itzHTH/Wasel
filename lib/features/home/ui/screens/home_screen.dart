import 'package:flutter/material.dart';
import 'package:wasal/core/helpers/app_local_cache.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasal/core/theme/app_color.dart';

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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.alertError500,
                foregroundColor: AppColor.neutral200,
                fixedSize: const Size(250, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),

              onPressed: () {
                AppLocalCache.clearAllSecuredData().then((_) {
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, AppRoutes.auth);
                  }
                });
              },
              child: const Text("تسجيل الخروج"),
            ),
          ],
        ),
      ),
    );
  }
}
