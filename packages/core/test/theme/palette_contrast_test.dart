import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/theme/app_brand.dart';
import 'package:wasel_core/theme/app_colors_extension.dart';
import 'package:wasel_core/theme/app_fonts.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_core/theme/app_theme.dart';

/// WCAG 2.1 relative luminance.
double _luminance(Color c) {
  double channel(double v) =>
      v <= 0.03928 ? v / 12.92 : math.pow((v + 0.055) / 1.055, 2.4).toDouble();
  return 0.2126 * channel(c.r) + 0.7152 * channel(c.g) + 0.0722 * channel(c.b);
}

double _contrast(Color a, Color b) {
  final la = _luminance(a);
  final lb = _luminance(b);
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}

/// Builds each theme once inside a ScreenUtil scope, since [AppDimens]
/// resolves its radii through it.
Future<void> _forEachTheme(
  WidgetTester tester,
  void Function(AppBrand, Brightness, ThemeData, AppColorsExtension) check,
) async {
  for (final brand in AppBrand.values) {
    for (final brightness in Brightness.values) {
      late ThemeData theme;
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, _) {
            theme = AppTheme.build(brand: brand, brightness: brightness);
            return const SizedBox.shrink();
          },
        ),
      );
      check(brand, brightness, theme, brand.paletteFor(brightness));
    }
  }
}

void main() {
  final palettes = <String, AppColorsExtension>{
    for (final brand in AppBrand.values)
      for (final brightness in Brightness.values)
        '${brand.name}/${brightness.name}': brand.paletteFor(brightness),
  };

  group('text pairs clear WCAG AA (4.5:1)', () {
    palettes.forEach((name, c) {
      test(name, () {
        void aa(String label, Color fg, Color bg) {
          expect(
            _contrast(fg, bg),
            greaterThanOrEqualTo(4.5),
            reason: '$name — $label',
          );
        }

        // Body text has to hold on the scaffold as well as on a card; the
        // scaffold is the darker of the two in light mode.
        for (final surface in {c.elementBackground, c.screenBackground}) {
          aa('secondary900 on surface', c.secondary900, surface);
          aa('secondary500 on surface', c.secondary500, surface);
          aa('secondary300 on surface', c.secondary300, surface);
          aa('neutral400 hint on surface', c.neutral400, surface);
          aa('neutral600 label on surface', c.neutral600, surface);
          aa('alertError500 on surface', c.alertError500, surface);
        }

        aa('onPrimary on primary500', c.onPrimary, c.primary500);
        aa('onPrimaryVivid on primaryVivid', c.onPrimaryVivid, c.primaryVivid);
        aa('onAccent on accent500', c.onAccent, c.accent500);
        aa('onScrim on scrim', c.onScrim, c.scrim);
        aa('primary700 on primary100', c.primary700, c.primary100);
      });
    });
  });

  group('non-text UI clears WCAG AA (3:1)', () {
    palettes.forEach((name, c) {
      test(name, () {
        void nonText(String label, Color fg, Color bg) {
          expect(
            _contrast(fg, bg),
            greaterThanOrEqualTo(3.0),
            reason: '$name — $label',
          );
        }

        for (final surface in {c.elementBackground, c.screenBackground}) {
          nonText('borderStrong outline', c.borderStrong, surface);
          // Availability is drawn as a dot beside a text label, so it is
          // graphical. Raise this to 4.5 the day it becomes a text colour.
          nonText('statusOnline dot', c.statusOnline, surface);
          nonText('statusOffline dot', c.statusOffline, surface);
        }
      });
    });
  });

  test('brand colour is never the availability colour', () {
    palettes.forEach((name, c) {
      expect(
        c.primary500,
        isNot(c.statusOnline),
        reason:
            '$name — a driver must be able to tell "online" apart from the '
            'brand colour',
      );
    });
  });

  testWidgets('the input outline uses borderStrong, not the divider', (
    tester,
  ) async {
    await _forEachTheme(tester, (brand, brightness, theme, colors) {
      final enabled = theme.inputDecorationTheme.enabledBorder;
      expect(enabled, isA<OutlineInputBorder>());
      expect(
        (enabled! as OutlineInputBorder).borderSide.color,
        colors.borderStrong,
        reason: '${brand.name}/${brightness.name}',
      );
    });
  });

  testWidgets('the bundled family reaches the text theme', (tester) async {
    await _forEachTheme(tester, (brand, brightness, theme, _) {
      expect(
        theme.textTheme.bodyMedium?.fontFamily,
        AppFonts.family,
        reason: '${brand.name}/${brightness.name}',
      );
    });
  });

  testWidgets('live numerals use the fixed-width family, body text does not', (
    tester,
  ) async {
    await _forEachTheme(tester, (brand, brightness, theme, colors) {
      final styles = AppTextStyles(colors, brand.typeScale());
      expect(styles.timerTextStyle().fontFamily, AppFonts.numeralFamily);
      expect(styles.body().fontFamily, AppFonts.family);
      expect(AppFonts.numeralFamily, isNot(AppFonts.family));
    });
  });
}
