import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasal/core/routing/app_router.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasal/core/theme/app_theme.dart';
import 'package:wasal/features/splash/ui/screens/splash_screen.dart';

class WasalApp extends StatelessWidget {
  const WasalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRouter().onGenerateRoute,
      ),
    );
  }
}
