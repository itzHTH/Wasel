import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasal/core/routing/app_router.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasal/l10n/rider_localizations.dart';
import 'package:wasel_auth/wasel_auth.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:wasel_location/wasel_location.dart';
import 'package:wasel_payments/wasel_payments.dart';
import 'package:wasel_profile/wasel_profile.dart';
import 'package:wasel_rides/wasel_rides.dart';

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
        builder: AppTextScaling.clamp,
        navigatorKey: AppNavigation.navigatorKey,
        theme: AppTheme.light(brand),
        darkTheme: AppTheme.dark(brand),
        themeMode: themeMode,
        locale: locale,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          RiderLocalizations.delegate,
          CoreLocalizations.delegate,
          AuthLocalizations.delegate,
          RidesLocalizations.delegate,
          ProfileLocalizations.delegate,
          PaymentsLocalizations.delegate,
          LocationLocalizations.delegate,
        ],
        supportedLocales: [
          Locale(AppLocaleType.arabic.code),
          Locale(AppLocaleType.english.code),
        ],
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRouter().onGenerateRoute,
      ),
    );
  }
}
