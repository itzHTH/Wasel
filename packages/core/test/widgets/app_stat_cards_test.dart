import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/widgets/app_stat_cards.dart';

void main() {
  const balance = AppStat(
    icon: Icons.account_balance_wallet_rounded,
    iconColor: AppColor.primary500,
    background: AppColor.primary100,
    label: 'الرصيد',
    value: '٨٧٬٥١٢',
    valueTextDirection: TextDirection.ltr,
  );

  const rating = AppStat(
    icon: Icons.star_rounded,
    iconColor: AppColor.primary500,
    background: AppColor.neutral100,
    label: 'التقييم',
    value: '0.0 (0)',
    valueTextDirection: TextDirection.ltr,
  );

  Widget inUnboundedList(List<AppStat> stats) => ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (_, _) => MaterialApp(
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
    await tester.pumpWidget(inUnboundedList(const [balance, rating]));

    expect(tester.takeException(), isNull);
  });

  testWidgets('renders every stat label and value', (tester) async {
    await tester.pumpWidget(inUnboundedList(const [balance, rating]));

    expect(find.text('الرصيد'), findsOneWidget);
    expect(find.text('٨٧٬٥١٢'), findsOneWidget);
    expect(find.text('التقييم'), findsOneWidget);
    expect(find.text('0.0 (0)'), findsOneWidget);
  });

  testWidgets('gives side-by-side cards a matching height', (tester) async {
    await tester.pumpWidget(inUnboundedList(const [balance, rating]));

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
    await tester.pumpWidget(inUnboundedList(const [balance]));

    expect(tester.takeException(), isNull);
    expect(find.text('الرصيد'), findsOneWidget);
  });
}
