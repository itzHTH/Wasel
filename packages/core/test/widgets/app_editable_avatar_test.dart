import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/l10n/core_localizations.dart';
import 'package:wasel_core/theme/app_brand.dart';
import 'package:wasel_core/theme/app_theme.dart';
import 'package:wasel_core/widgets/avatar/app_editable_avatar.dart';
import 'package:wasel_core/widgets/feedback/app_loading.dart';

void main() {
  Widget wrap(Widget child) => ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (_, _) => MaterialApp(
      theme: AppTheme.light(AppBrand.rider),
      locale: const Locale('ar'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        CoreLocalizations.delegate,
      ],
      supportedLocales: CoreLocalizations.supportedLocales,
      home: Scaffold(body: Center(child: child)),
    ),
  );

  testWidgets('shows no spinner and stays tappable when idle', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      wrap(AppEditableAvatar(size: 96, onTap: () => taps++)),
    );

    expect(find.byType(AppInlineLoading), findsNothing);

    await tester.tap(find.byType(AppEditableAvatar));
    expect(taps, 1);
  });

  testWidgets('shows a spinner and swallows taps while loading', (
    tester,
  ) async {
    var taps = 0;
    await tester.pumpWidget(
      wrap(AppEditableAvatar(size: 96, isLoading: true, onTap: () => taps++)),
    );

    expect(find.byType(AppInlineLoading), findsOneWidget);

    await tester.tap(find.byType(AppEditableAvatar));
    expect(taps, 0);
  });

  testWidgets('exposes no button semantics without a tap handler', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const AppEditableAvatar(size: 96)));

    expect(find.byType(InkWell), findsNothing);
    expect(find.byType(AppInlineLoading), findsNothing);
  });
}
