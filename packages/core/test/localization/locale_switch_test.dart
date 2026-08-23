import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:wasel_core/l10n/core_localizations.dart';
import 'package:wasel_core/localization/app_local_type.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';

/// Minimal host that mirrors how the apps wire localization, so the test
/// exercises the real delegate + locale path rather than a stub.
Widget _host() => Consumer(
  builder: (context, ref, _) => MaterialApp(
    locale: ref.watch(appLocalizationControllerProvider),
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      CoreLocalizations.delegate,
    ],
    supportedLocales: CoreLocalizations.supportedLocales,
    home: Builder(builder: (context) => Text(context.coreL10n.language)),
  ),
);

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('defaults to Arabic and lays out right-to-left', (tester) async {
    await tester.pumpWidget(ProviderScope(child: _host()));
    await tester.pumpAndSettle();

    expect(find.text('اللغة'), findsOneWidget);
    expect(
      Directionality.of(tester.element(find.text('اللغة'))),
      TextDirection.rtl,
    );
  });

  testWidgets('setLocale to English swaps copy and flips to left-to-right', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: _host()),
    );
    await tester.pumpAndSettle();

    await container
        .read(appLocalizationControllerProvider.notifier)
        .setLocale(const Locale('en'));
    await tester.pumpAndSettle();

    expect(find.text('Language'), findsOneWidget);
    expect(find.text('اللغة'), findsNothing);
    expect(
      Directionality.of(tester.element(find.text('Language'))),
      TextDirection.ltr,
    );
  });

  test('an unrecognised persisted code falls back to Arabic', () async {
    SharedPreferences.setMockInitialValues({'flutter.locale': 'fr'});

    expect(await AppLocalizationController.restore(), const Locale('ar'));
    expect(AppLocalizationController.currentLocale, const Locale('ar'));
  });

  testWidgets('the chosen locale is persisted for the next launch', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: _host()),
    );
    await tester.pumpAndSettle();

    await container
        .read(appLocalizationControllerProvider.notifier)
        .setLocale(Locale(AppLocaleType.english.code));
    await tester.pumpAndSettle();

    expect(await AppLocalizationController.restore(), const Locale('en'));
  });
}
