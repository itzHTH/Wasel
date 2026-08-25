import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/theme/app_brand.dart';
import 'package:wasel_core/theme/app_colors_extension.dart';
import 'package:wasel_core/theme/app_theme.dart';
import 'package:wasel_core/widgets/ride/ride_search_radar.dart';
import 'package:wasel_core/widgets/ride/ride_stage_badge.dart';

Future<AppColorsExtension> _pump(
  WidgetTester tester,
  AppBrand brand,
  Widget child,
) async {
  late AppColorsExtension colors;
  await tester.pumpWidget(
    ScreenUtilInit(
      // Keyed per brand so a second pump builds a fresh tree rather than
      // animating the first brand's colours and corners across.
      key: ValueKey(brand),
      designSize: const Size(375, 812),
      builder: (_, _) {
        colors = brand.paletteFor(Brightness.light);
        return MaterialApp(
          theme: AppTheme.build(brand: brand, brightness: Brightness.light),
          home: Scaffold(body: Center(child: child)),
        );
      },
    ),
  );
  // Not pumpAndSettle: the searching badge runs a radar that never stops.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
  return colors;
}

BoxDecoration _decorationOf(WidgetTester tester) =>
    tester
            .widget<Container>(
              find
                  .descendant(
                    of: find.byType(RideStageBadge),
                    matching: find.byType(Container),
                  )
                  .first,
            )
            .decoration!
        as BoxDecoration;

void main() {
  test('every stage maps to a glyph of its own', () {
    final icons = RideStageVisual.values.map((stage) => stage.icon).toList();

    expect(
      icons.toSet(),
      hasLength(RideStageVisual.values.length),
      reason: 'two stages sharing a glyph cannot be told apart at a glance',
    );
  });

  testWidgets('the searching badge draws the radar, not a static glyph', (
    tester,
  ) async {
    await _pump(
      tester,
      AppBrand.rider,
      const RideStageBadge(stage: RideStageVisual.searching),
    );

    expect(find.byType(RideSearchRadar), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(RideStageBadge),
        matching: find.byType(Icon),
      ),
      findsNothing,
    );
  });

  testWidgets('the tint follows the stage in both brands', (tester) async {
    for (final brand in AppBrand.values) {
      final expected = <RideStageVisual, (Color, Color)>{};
      final colors = brand.paletteFor(Brightness.light);

      expected[RideStageVisual.accepted] = (
        colors.primary100,
        colors.primary500,
      );
      expected[RideStageVisual.arrived] = (
        colors.alertSuccess100,
        colors.alertSuccess500,
      );
      expected[RideStageVisual.completed] = (
        colors.alertSuccess100,
        colors.alertSuccess500,
      );
      expected[RideStageVisual.offline] = (
        colors.neutral100,
        colors.neutral400,
      );
      expected[RideStageVisual.cancelled] = (
        colors.alertError100,
        colors.alertError500,
      );

      for (final entry in expected.entries) {
        await _pump(tester, brand, RideStageBadge(stage: entry.key));

        expect(
          _decorationOf(tester).color,
          entry.value.$1,
          reason: '${brand.name} ${entry.key.name} background',
        );
        expect(
          tester
              .widget<Icon>(
                find.descendant(
                  of: find.byType(RideStageBadge),
                  matching: find.byType(Icon),
                ),
              )
              .color,
          entry.value.$2,
          reason: '${brand.name} ${entry.key.name} glyph',
        );
      }
    }
  });

  testWidgets('the badge corners come from the brand shape', (tester) async {
    final radii = <AppBrand, double>{};

    for (final brand in AppBrand.values) {
      await _pump(
        tester,
        brand,
        const RideStageBadge(stage: RideStageVisual.accepted),
      );

      final radius =
          (_decorationOf(tester).borderRadius! as BorderRadius).topLeft.x;

      expect(
        radius,
        brand.shape().radiusBadge,
        reason: '${brand.name} badge radius must come from the brand',
      );
      radii[brand] = radius;
    }

    expect(
      radii[AppBrand.rider],
      greaterThan(radii[AppBrand.driver]!),
      reason: 'the rider rounds more generously than the captain',
    );
  });

  testWidgets('a stage change cross-fades the glyph in place', (tester) async {
    var stage = RideStageVisual.accepted;
    late StateSetter setStage;

    await _pump(
      tester,
      AppBrand.rider,
      StatefulBuilder(
        builder: (context, setState) {
          setStage = setState;
          return RideStageBadge(stage: stage);
        },
      ),
    );

    expect(find.byIcon(RideStageVisual.accepted.icon), findsOneWidget);

    setStage(() => stage = RideStageVisual.arrived);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 130));

    expect(
      find.byIcon(RideStageVisual.accepted.icon),
      findsOneWidget,
      reason: 'the outgoing glyph must still be fading, not cut',
    );
    expect(find.byIcon(RideStageVisual.arrived.icon), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byIcon(RideStageVisual.accepted.icon), findsNothing);
    expect(find.byIcon(RideStageVisual.arrived.icon), findsOneWidget);
  });
}
