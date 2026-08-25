import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/theme/app_brand.dart';
import 'package:wasel_core/theme/app_shape.dart';
import 'package:wasel_core/theme/app_theme.dart';
import 'package:wasel_core/l10n/core_localizations.dart';
import 'package:wasel_core/widgets/buttons/app_back_button.dart';
import 'package:wasel_core/widgets/buttons/app_primary_button.dart';
import 'package:wasel_core/widgets/buttons/app_secondary_button.dart';
import 'package:wasel_core/widgets/cards/app_surface_card.dart';

/// Asserting the ThemeData slot is not enough: these widgets set their own
/// `styleFrom`, so a brand shape can be correct in the theme and still never
/// reach the screen. Everything here reads the rendered widget instead.
Future<AppShape> _pump(
  WidgetTester tester,
  AppBrand brand,
  Widget child,
) async {
  late AppShape shape;
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, _) {
        shape = brand.shape();
        return MaterialApp(
          theme: AppTheme.build(brand: brand, brightness: Brightness.light),
          locale: const Locale('ar'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            CoreLocalizations.delegate,
          ],
          supportedLocales: CoreLocalizations.supportedLocales,
          home: Scaffold(body: Center(child: child)),
        );
      },
    ),
  );
  await tester.pumpAndSettle();
  return shape;
}

double _radiusOf(ButtonStyle? style) {
  final shape = style?.shape?.resolve({}) as RoundedRectangleBorder?;
  return ((shape?.borderRadius as BorderRadius?)?.topLeft.x) ?? -1;
}

void main() {
  testWidgets('the primary CTA renders at the brand radius and height', (
    tester,
  ) async {
    for (final brand in AppBrand.values) {
      final shape = await _pump(
        tester,
        brand,
        AppPrimaryButton(label: 'Go', onPressed: () {}),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(
        _radiusOf(button.style),
        shape.radiusButton,
        reason: '${brand.name} CTA radius must come from the brand',
      );

      final box = tester.widget<SizedBox>(
        find
            .ancestor(
              of: find.byType(ElevatedButton),
              matching: find.byType(SizedBox),
            )
            .first,
      );
      expect(
        box.height,
        shape.buttonHeight,
        reason: '${brand.name} CTA height',
      );
    }
  });

  testWidgets('the secondary CTA renders at the brand radius and height', (
    tester,
  ) async {
    for (final brand in AppBrand.values) {
      final shape = await _pump(
        tester,
        brand,
        AppSecondaryButton(label: 'Later', onPressed: () {}),
      );

      final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      expect(_radiusOf(button.style), shape.radiusButton, reason: brand.name);
    }
  });

  testWidgets('the back button follows the brand, not a hardcoded circle', (
    tester,
  ) async {
    for (final brand in AppBrand.values) {
      final shape = await _pump(tester, brand, const AppBackButton());

      final decoration =
          tester
                  .widget<Container>(
                    find
                        .descendant(
                          of: find.byType(AppBackButton),
                          matching: find.byType(Container),
                        )
                        .first,
                  )
                  .decoration!
              as BoxDecoration;

      expect(
        decoration.shape,
        BoxShape.rectangle,
        reason: '${brand.name} back button must take a brand radius',
      );
      expect(
        (decoration.borderRadius! as BorderRadius).topLeft.x,
        shape.badgeRadiusFor(44.r),
        reason: '${brand.name} back button radius',
      );
    }
  });

  testWidgets('the two brands actually render differently', (tester) async {
    final radii = <AppBrand, double>{};
    final heights = <AppBrand, double>{};
    for (final brand in AppBrand.values) {
      await _pump(
        tester,
        brand,
        AppPrimaryButton(label: 'Go', onPressed: () {}),
      );
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      radii[brand] = _radiusOf(button.style);
      heights[brand] = tester
          .widget<SizedBox>(
            find
                .ancestor(
                  of: find.byType(ElevatedButton),
                  matching: find.byType(SizedBox),
                )
                .first,
          )
          .height!;
    }

    expect(
      radii[AppBrand.rider],
      greaterThan(radii[AppBrand.driver]!),
      reason: 'the rider CTA is a pill, the captain CTA is a control',
    );
    expect(
      heights[AppBrand.driver],
      greaterThan(heights[AppBrand.rider]!),
      reason: 'the captain taps in a moving vehicle',
    );
  });

  testWidgets('the default card surface renders at the brand radius', (
    tester,
  ) async {
    for (final brand in AppBrand.values) {
      final shape = await _pump(
        tester,
        brand,
        const AppSurfaceCard(child: Text('x')),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(AppSurfaceCard),
              matching: find.byType(Container),
            )
            .first,
      );
      final decoration = container.decoration! as BoxDecoration;
      expect(
        (decoration.borderRadius as BorderRadius?)?.topLeft.x,
        shape.radiusCard,
        reason:
            '${brand.name} — most cards in both apps come through this widget',
      );
    }
  });
}
