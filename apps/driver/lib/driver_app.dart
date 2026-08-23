import 'package:driver/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/localization/app_local_type.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:driver/core/routing/app_router.dart';
import 'package:driver/core/routing/app_routes_name.dart';

class DriverApp extends ConsumerWidget {
  const DriverApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brand = ref.watch(appBrandProvider);
    final themeMode = ref.watch(themeModeControllerProvider);
    final locale = ref.watch(appLocalizationControllerProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: AppNavigation.navigatorKey,
        theme: AppTheme.light(brand),
        darkTheme: AppTheme.dark(brand),
        themeMode: themeMode,
        locale: locale,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DriverLocalizations.delegate,
        ],
        supportedLocales: [
          Locale(AppLocaleType.arabic.code),
          Locale(AppLocaleType.english.code),
        ],
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRouter().onGenerateRoute,
        builder: (context, child) =>
            Directionality(textDirection: TextDirection.rtl, child: child!),
      ),
    );
  }
}
