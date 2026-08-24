import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/theme/app_brand.dart';
import 'package:wasel_core/theme/app_shape.dart';
import 'package:wasel_core/theme/app_theme.dart';

Future<void> _inScreenUtil(WidgetTester tester, VoidCallback body) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, _) {
        body();
        return const SizedBox.shrink();
      },
    ),
  );
}

void main() {
  testWidgets('the rider rounds where the captain squares off', (tester) async {
    await _inScreenUtil(tester, () {
      final rider = AppBrand.rider.shape();
      final driver = AppBrand.driver.shape();

      expect(
        rider.radiusButton,
        greaterThan(driver.radiusButton),
        reason: 'the rider CTA is a pill; the captain CTA is a control',
      );
      expect(rider.radiusCard, greaterThan(driver.radiusCard));
      expect(rider.radiusSheet, greaterThan(driver.radiusSheet));
      expect(rider.screenPadding, greaterThan(driver.screenPadding));

      expect(
        driver.buttonHeight,
        greaterThan(rider.buttonHeight),
        reason: 'the captain taps in a moving vehicle',
      );
      expect(driver.fieldHeight, greaterThan(rider.fieldHeight));

      expect(
        rider.radiusField,
        driver.radiusField,
        reason: 'forms behave identically in both apps',
      );
    });
  });

  testWidgets('the theme resolves shape from the brand', (tester) async {
    for (final brand in AppBrand.values) {
      for (final brightness in Brightness.values) {
        late ThemeData theme;
        await _inScreenUtil(tester, () {
          theme = AppTheme.build(brand: brand, brightness: brightness);
        });

        final shape = theme.extension<AppShape>();
        expect(shape, isNotNull, reason: '${brand.name}/${brightness.name}');

        final button =
            theme.elevatedButtonTheme.style?.shape?.resolve({})
                as RoundedRectangleBorder?;
        expect(
          (button?.borderRadius as BorderRadius?)?.topLeft.x,
          shape!.radiusButton,
          reason: '${brand.name}/${brightness.name}',
        );

        final sheet = theme.bottomSheetTheme.shape as RoundedRectangleBorder?;
        expect(
          (sheet?.borderRadius as BorderRadius?)?.topLeft.y,
          shape.radiusSheet,
        );
      }
    }
  });

  testWidgets('shape does not vary with brightness', (tester) async {
    await _inScreenUtil(tester, () {
      for (final brand in AppBrand.values) {
        final light = AppTheme.build(
          brand: brand,
          brightness: Brightness.light,
        ).extension<AppShape>();
        final dark = AppTheme.build(
          brand: brand,
          brightness: Brightness.dark,
        ).extension<AppShape>();
        expect(light, dark, reason: brand.name);
      }
    });
  });
}
