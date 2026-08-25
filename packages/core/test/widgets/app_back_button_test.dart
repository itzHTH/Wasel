import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/l10n/core_localizations.dart';
import 'package:wasel_core/theme/app_brand.dart';
import 'package:wasel_core/theme/app_theme.dart';
import 'package:wasel_core/widgets/buttons/app_back_button.dart';

Future<void> _pump(WidgetTester tester, Locale locale) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      key: ValueKey(locale),
      designSize: const Size(375, 812),
      builder: (_, _) => MaterialApp(
        theme: AppTheme.build(
          brand: AppBrand.rider,
          brightness: Brightness.light,
        ),
        locale: locale,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          CoreLocalizations.delegate,
        ],
        supportedLocales: CoreLocalizations.supportedLocales,
        home: const Scaffold(body: Center(child: AppBackButton())),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Finder _arrow() => find.descendant(
  of: find.byType(AppBackButton),
  matching: find.byType(Icon),
);

/// The horizontal scale [Icon] applies to a direction-aware glyph: -1 once it
/// has been mirrored, +1 while it is drawn as authored.
double _renderedScaleX(WidgetTester tester) {
  final transforms = find.descendant(
    of: _arrow(),
    matching: find.byType(Transform),
  );
  if (transforms.evaluate().isEmpty) return 1;
  return tester.widget<Transform>(transforms.first).transform.storage[0];
}

void main() {
  testWidgets('the arrow is drawn as authored in a left-to-right locale', (
    tester,
  ) async {
    await _pump(tester, const Locale('en'));

    expect(tester.widget<Icon>(_arrow()).icon, Icons.arrow_back_rounded);
    expect(_renderedScaleX(tester), 1);
  });

  testWidgets('the arrow mirrors to point back in a right-to-left locale', (
    tester,
  ) async {
    await _pump(tester, const Locale('ar'));

    final icon = tester.widget<Icon>(_arrow()).icon!;

    expect(
      icon.matchTextDirection,
      isTrue,
      reason: 'the glyph has to be one Flutter mirrors on its own',
    );
    expect(
      icon,
      Icons.arrow_back_rounded,
      reason: 'flipping to the forward glyph cancels the automatic mirror',
    );
    expect(
      _renderedScaleX(tester),
      -1,
      reason: 'in RTL the arrow must end up pointing right',
    );
  });
}
