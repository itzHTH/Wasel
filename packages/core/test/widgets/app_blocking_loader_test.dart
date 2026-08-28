import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/l10n/core_localizations.dart';
import 'package:wasel_core/theme/app_brand.dart';
import 'package:wasel_core/theme/app_theme.dart';
import 'package:wasel_core/widgets/feedback/app_blocking_loader.dart';

Future<void> _pump(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, _) => MaterialApp(
        locale: const Locale('ar'),
        localizationsDelegates: const [
          CoreLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: CoreLocalizations.supportedLocales,
        theme: AppTheme.build(
          brand: AppBrand.rider,
          brightness: Brightness.light,
        ),
        home: Stack(
          children: [
            const Positioned.fill(child: ColoredBox(color: Colors.green)),
            Positioned.fill(child: child),
          ],
        ),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  testWidgets('veils what is behind it rather than painting it out', (
    tester,
  ) async {
    await _pump(
      tester,
      const AppBlockingLoader(
        logoAsset: 'assets/icons/wasel-icon.svg',
        message: 'يتم إعداد بيئة الاتصال',
      ),
    );

    final scrim = tester.widget<ColoredBox>(
      find.descendant(
        of: find.byType(AppBlockingLoader),
        matching: find.byType(ColoredBox),
      ),
    );

    expect(scrim.color.a, lessThan(1.0));
    expect(scrim.color.a, greaterThan(0.0));
  });

  testWidgets('names what is being waited on', (tester) async {
    await _pump(
      tester,
      const AppBlockingLoader(
        logoAsset: 'assets/icons/wasel-icon.svg',
        message: 'يتم إعداد بيئة الاتصال',
      ),
    );

    expect(find.text('يتم إعداد بيئة الاتصال'), findsOneWidget);
  });
}
