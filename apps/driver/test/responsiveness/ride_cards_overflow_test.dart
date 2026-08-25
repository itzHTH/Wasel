import 'package:driver/features/ride/ui/widgets/fare_hero.dart';
import 'package:driver/features/ride/ui/widgets/offline/offline_card.dart';
import 'package:driver/l10n/driver_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/l10n/core_localizations.dart';
import 'package:wasel_core/theme/app_brand.dart';
import 'package:wasel_core/theme/app_theme.dart';

/// The captain ramp raised body 14→15 and caption 12→14, so the ride cards
/// carry less horizontal slack than they used to.
///
/// IncomingOfferCard is deliberately absent: it reads several providers that
/// need real overrides to build, so covering it means standing up profile and
/// ride-action state rather than passing data in.
const _iphoneSe = Size(320, 568);

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  double textScale = 1.0,
}) async {
  tester.view.physicalSize = _iphoneSe;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, _) => MaterialApp(
          theme: AppTheme.build(
            brand: AppBrand.driver,
            brightness: Brightness.light,
          ),
          locale: const Locale('ar'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            CoreLocalizations.delegate,
            DriverLocalizations.delegate,
          ],
          supportedLocales: DriverLocalizations.supportedLocales,
          builder: (context, widget) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(textScale)),
            child: widget!,
          ),
          home: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: child,
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  final cases = <String, Widget Function()>{
    'FareHero': () => const FareHero(amount: 1250000),
    'OfflineCard': () => OfflineCard(onGoOnline: () {}, onCancel: () {}),
  };

  for (final scale in [1.0, 1.3]) {
    group('320w · textScale $scale', () {
      cases.forEach((name, build) {
        testWidgets(name, (tester) async {
          await _pump(tester, build(), textScale: scale);
          expect(
            tester.takeException(),
            isNull,
            reason: '$name overflows at 320px, textScale $scale',
          );
        });
      });
    });
  }
}
