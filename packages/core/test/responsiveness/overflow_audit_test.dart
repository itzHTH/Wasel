import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasel_core/l10n/core_localizations.dart';
import 'package:wasel_core/theme/app_brand.dart';
import 'package:wasel_core/theme/app_theme.dart';
import 'package:wasel_core/theme/palettes/rider_palette.dart';
import 'package:wasel_core/widgets/buttons/app_primary_button.dart';
import 'package:wasel_core/widgets/buttons/app_secondary_button.dart';
import 'package:wasel_core/widgets/cards/app_group_card.dart';
import 'package:wasel_core/widgets/cards/app_info_row.dart';
import 'package:wasel_core/widgets/cards/app_menu_tile.dart';
import 'package:wasel_core/widgets/cards/app_stat_cards.dart';
import 'package:wasel_core/widgets/cards/app_surface_card.dart';
import 'package:wasel_core/widgets/feedback/app_error_retry.dart';
import 'package:wasel_core/widgets/feedback/app_inline_error.dart';
import 'package:wasel_core/widgets/settings/app_language_switch.dart';
import 'package:wasel_core/widgets/settings/app_theme_mode_switch.dart';
import 'package:wasel_core/widgets/ride/ride_stage_badge.dart';
import 'package:wasel_core/widgets/ride/ride_stage_header.dart';

/// The narrowest device the apps support, and the one the new type ramp is
/// most likely to break.
const _iphoneSe = Size(320, 568);
const _pixel = Size(360, 640);

/// Real Arabic copy, at the length the backend can actually return.
const _longLabel = 'خدمة الموقع مطفّية، شغّلها حتى نگدر نوصل لموقعك بسرعة';
const _longValue = 'شارع المعلمين، حي الحمداني، بغداد، العراق';

Future<void> _pumpAt(
  WidgetTester tester,
  Size size,
  AppBrand brand,
  Widget child, {
  bool inScroll = true,
  double textScale = 1.0,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, _) => MaterialApp(
          theme: AppTheme.build(brand: brand, brightness: Brightness.light),
          locale: const Locale('ar'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            CoreLocalizations.delegate,
          ],
          supportedLocales: CoreLocalizations.supportedLocales,
          builder: (context, widget) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(textScale)),
            child: widget!,
          ),
          home: Scaffold(
            body: SafeArea(
              child: inScroll
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: child,
                      ),
                    )
                  : Padding(padding: const EdgeInsets.all(16), child: child),
            ),
          ),
        ),
      ),
    ),
  );
  // Not pumpAndSettle: a searching stage runs a radar that never stops.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
}

/// Every widget the audit covers, built with copy long enough to stress it.
final _cases = <String, Widget Function()>{
  'AppPrimaryButton': () =>
      AppPrimaryButton(label: _longLabel, onPressed: () {}),
  'AppSecondaryButton': () =>
      AppSecondaryButton(label: _longLabel, onPressed: () {}),
  'AppInfoRow': () => const AppInfoRow(
    icon: Icons.place_outlined,
    label: _longLabel,
    value: _longValue,
  ),
  'AppMenuTile': () =>
      const AppMenuTile(icon: Icons.settings_outlined, label: _longLabel),
  'AppInlineError': () => const AppInlineError(message: _longLabel),
  'AppErrorRetry': () => AppErrorRetry(message: _longLabel, onRetry: () {}),
  'AppSurfaceCard': () => const AppSurfaceCard(child: Text(_longValue)),
  'AppGroupCard': () => const AppGroupCard(
    children: [
      AppMenuTile(icon: Icons.person_outline, label: _longLabel),
      AppMenuTile(icon: Icons.lock_outline, label: _longLabel),
    ],
  ),
  'AppStatCards (2 up)': () => AppStatCards(
    stats: [
      AppStat(
        icon: Icons.account_balance_wallet_rounded,
        iconColor: RiderPalette.light.primary500,
        background: RiderPalette.light.primary100,
        label: 'الرصيد الحالي في المحفظة',
        value: '٨٧٬٥١٢',
      ),
      AppStat(
        icon: Icons.star_rounded,
        iconColor: RiderPalette.light.primary500,
        background: RiderPalette.light.neutral100,
        label: 'متوسط التقييم العام',
        value: '4.9 (١٢٣)',
      ),
    ],
  ),
  'AppLanguageSwitch': () => const AppLanguageSwitch(),
  'AppThemeModeSwitch': () => const AppThemeModeSwitch(),
  for (final stage in RideStageVisual.values)
    'RideStageHeader.${stage.name}': () =>
        RideStageHeader(stage: stage, title: _longLabel, subtitle: _longValue),
  'RideStageHeader (with trailing)': () => const RideStageHeader(
    stage: RideStageVisual.offerReceived,
    title: _longLabel,
    subtitle: _longValue,
    trailing: SizedBox.square(dimension: 48),
  ),
};

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  for (final size in [_iphoneSe, _pixel]) {
    for (final brand in AppBrand.values) {
      group('${size.width.toInt()}w · ${brand.name}', () {
        _cases.forEach((name, build) {
          testWidgets(name, (tester) async {
            await _pumpAt(tester, size, brand, build());
            expect(
              tester.takeException(),
              isNull,
              reason:
                  '$name overflows at ${size.width.toInt()}px on '
                  'the ${brand.name} ramp',
            );
          });
        });
      });
    }
  }

  // Accessibility text scaling on top of a line-height that is already tall.
  // Fixed-height controls are where this shows up first.
  group('textScale 1.3 · 320w', () {
    for (final brand in AppBrand.values) {
      _cases.forEach((name, build) {
        testWidgets('${brand.name} $name', (tester) async {
          await _pumpAt(tester, _iphoneSe, brand, build(), textScale: 1.3);
          expect(
            tester.takeException(),
            isNull,
            reason: '$name overflows at 1.3x text on the ${brand.name} ramp',
          );
        });
      });
    }
  });
}
