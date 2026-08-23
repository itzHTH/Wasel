import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasal/l10n/app_localizations.dart';
import 'package:wasel_core/helpers/app_navigation.dart';
import 'package:wasal/core/routing/app_router.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasel_core/localization/app_local_type.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';
import 'package:wasel_core/theme/app_theme.dart';
import 'package:wasel_core/theme/providers/theme_mode_provider.dart';

class WasalApp extends ConsumerWidget {
  const WasalApp({super.key});

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
          AppLocalizations.delegate,
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
