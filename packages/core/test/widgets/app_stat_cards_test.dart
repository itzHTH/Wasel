import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/theme/app_brand.dart';
import 'package:wasel_core/theme/app_theme.dart';
import 'package:wasel_core/theme/palettes/rider_palette.dart';
import 'package:wasel_core/widgets/app_stat_cards.dart';

void main() {
  final balance = AppStat(
    icon: Icons.account_balance_wallet_rounded,
    iconColor: RiderPalette.light.primary500,
    background: RiderPalette.light.primary100,
    label: 'الرصيد',
    value: '٨٧٬٥١٢',
    valueTextDirection: TextDirection.ltr,
  );

  final rating = AppStat(
    icon: Icons.star_rounded,
    iconColor: RiderPalette.light.primary500,
    background: RiderPalette.light.neutral100,
    label: 'التقييم',
    value: '0.0 (0)',
    valueTextDirection: TextDirection.ltr,
  );

  Widget inUnboundedList(List<AppStat> stats) => ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (_, _) => MaterialApp(
      theme: AppTheme.light(AppBrand.rider),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: ListView(
            children: [
              Column(children: [AppStatCards(stats: stats)]),
            ],
          ),
        ),
      ),
    ),
  );

  testWidgets('lays out inside an unbounded-height list', (tester) async {
    await tester.pumpWidget(inUnboundedList([balance, rating]));

    expect(tester.takeException(), isNull);
  });

  testWidgets('renders every stat label and value', (tester) async {
    await tester.pumpWidget(inUnboundedList([balance, rating]));

    expect(find.text('الرصيد'), findsOneWidget);
    expect(find.text('٨٧٬٥١٢'), findsOneWidget);
    expect(find.text('التقييم'), findsOneWidget);
    expect(find.text('0.0 (0)'), findsOneWidget);
  });

  testWidgets('gives side-by-side cards a matching height', (tester) async {
    await tester.pumpWidget(inUnboundedList([balance, rating]));

    final cards = find.descendant(
      of: find.byType(IntrinsicHeight),
      matching: find.byType(DecoratedBox),
    );

    expect(cards, findsNWidgets(2));
    expect(
      tester.getSize(cards.at(0)).height,
      tester.getSize(cards.at(1)).height,
    );
  });

  testWidgets('lays out a single stat', (tester) async {
    await tester.pumpWidget(inUnboundedList([balance]));

    expect(tester.takeException(), isNull);
    expect(find.text('الرصيد'), findsOneWidget);
  });
}
