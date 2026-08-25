import 'package:driver/features/driver_earnings/domain/entities/driver_earnings.dart';
import 'package:driver/features/driver_earnings/domain/entities/earnings_period.dart';
import 'package:driver/features/driver_earnings/ui/providers/driver_earnings_provider.dart';
import 'package:driver/features/ride/ui/providers/rider_profile/current_rider_profile_provider.dart';
import 'package:driver/features/ride/ui/widgets/fare_hero.dart';
import 'package:driver/features/ride/ui/widgets/incoming_offer/incoming_offer_card.dart';
import 'package:driver/features/ride/ui/widgets/offline/offline_card.dart';
import 'package:driver/features/ride/ui/widgets/searching/searching_card.dart';
import 'package:driver/l10n/driver_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/l10n/core_localizations.dart';
import 'package:wasel_core/theme/app_brand.dart';
import 'package:wasel_core/theme/app_theme.dart';
import 'package:wasel_location/wasel_location.dart';
import 'package:wasel_payments/domain/entities/payment_method.dart';
import 'package:wasel_payments/l10n/payments_localizations.dart';

/// The captain ramp raised body 14→15 and caption 12→14, so the ride cards
/// carry less horizontal slack than they used to.
const _iphoneSe = Size(320, 568);

const _pickup = GeoPoint(latitude: 33.3152, longitude: 44.3661);
const _dropoff = GeoPoint(latitude: 33.2778, longitude: 44.4361);

/// A real address, at the length the geocoder can actually return.
const _address = 'شارع المعلمين، حي الحمداني، بغداد، العراق';

/// The cards reach the ride controller and the geocoder through providers that
/// need the whole network graph to build. Stubbing at the edge keeps the cards
/// under test without standing up DI.
class _StubEarnings extends DriverEarningsController {
  @override
  Future<DriverEarnings> build(EarningsRange range) async => _widestEarnings;
}

/// The widest figures the panel can be asked to lay out: a seven-digit fare,
/// a three-digit ride count and a two-part duration.
const _widestEarnings = DriverEarnings(
  completedRides: 128,
  totalEarnings: 1250000,
  onlineMinutes: 1439,
  canCashOut: true,
);

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  double textScale = 1.0,
}) async {
  tester.view.physicalSize = _iphoneSe;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentRiderProfileProvider.overrideWithValue(null),
        driverEarningsControllerProvider(
          EarningsRange.today,
        ).overrideWith(_StubEarnings.new),
        pointLabelProvider(_pickup).overrideWith((ref) async => _address),
        pointLabelProvider(_dropoff).overrideWith((ref) async => _address),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, _) => MaterialApp(
          theme: AppTheme.build(
            brand: AppBrand.driver,
            brightness: Brightness.light,
          ),
          locale: const Locale('ar'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            CoreLocalizations.delegate,
            DriverLocalizations.delegate,
            PaymentsLocalizations.delegate,
          ],
          supportedLocales: DriverLocalizations.supportedLocales,
          builder: (context, widget) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(textScale)),
            child: widget!,
          ),
          home: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: child,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  // Not pumpAndSettle: the searching card runs a radar that never stops. The
  // window is long enough for an expandable card to finish its peek.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 1200));
}

void main() {
  final cases = <String, Widget Function()>{
    'FareHero': () => const FareHero(amount: 1250000),
    'OfflineCard': () => OfflineCard(onGoOnline: () {}, onCancel: () {}),
    'OfflineCard (connecting)': () =>
        OfflineCard(onGoOnline: () {}, onCancel: () {}, isConnecting: true),
    'SearchingCard': () => SearchingCard(onGoOffline: () {}),
    'IncomingOfferCard': () => IncomingOfferCard(
      fare: 1250000,
      paymentMethod: PaymentMethod.cash,
      pickupPoint: _pickup,
      dropoffPoint: _dropoff,
      total: const Duration(seconds: 30),
      remaining: const Duration(seconds: 12),
      onAccept: () {},
      onDismiss: () {},
    ),
  };

  for (final scale in [1.0, 1.3]) {
    group('320w · textScale $scale', () {
      cases.forEach((name, build) {
        testWidgets(name, (tester) async {
          await _pump(tester, build(), textScale: scale);
          expect(
            tester.takeException(),
            isNull,
            reason: '$name overflows at 320px, textScale $scale',
          );
        });
      });
    });
  }
}
