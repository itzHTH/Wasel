import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasal/features/ride/domain/entities/driver_profile.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_state.dart';
import 'package:wasal/features/ride/ui/widgets/ride_draft_card/ride_back_button.dart';
import 'package:wasal/features/ride/ui/widgets/ride_draft_card/ride_card_title.dart';
import 'package:wasal/features/ride/ui/widgets/ride_price_card/ride_price_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_arrived_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/driver_on_the_way_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/ride_in_progress_card.dart';
import 'package:wasal/features/ride/ui/widgets/tracking/searching_for_driver_card.dart';
import 'package:wasal/l10n/rider_localizations.dart';
import 'package:wasel_core/l10n/core_localizations.dart';
import 'package:wasel_core/theme/app_brand.dart';
import 'package:wasel_core/theme/app_theme.dart';

/// The stage badge added a 40px leading box to every ride card header, and the
/// draft header carries the back button beside it. This is where that lands if
/// it is too much for the narrowest device.
const _iphoneSe = Size(320, 568);

const _address = 'شارع المعلمين، حي الحمداني، بغداد، العراق';

/// Forces a picking stage without running the geocoder the real notifier
/// starts on every confirm.
class _StubDraft extends RideDraft {
  _StubDraft(this.stage);

  final PickingStage stage;

  @override
  RideDraftState build() => RideDraftState(stage: stage);
}

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  PickingStage stage = PickingStage.pickup,
  double textScale = 1.0,
}) async {
  tester.view.physicalSize = _iphoneSe;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [rideDraftProvider.overrideWith(() => _StubDraft(stage))],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, _) => MaterialApp(
          theme: AppTheme.build(
            brand: AppBrand.rider,
            brightness: Brightness.light,
          ),
          locale: const Locale('ar'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            CoreLocalizations.delegate,
            RiderLocalizations.delegate,
          ],
          supportedLocales: RiderLocalizations.supportedLocales,
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

DriverProfile _captain() => DriverProfile(
  id: '1',
  name: 'أبو حيدر عبد الرزاق الجنابي',
  phoneNumber: '07701234567',
  plateNumber: 'بغداد ٢٢ أ ٤٥٦٧٨',
  carModel: 'تويوتا كورولا',
  carColor: 'أبيض',
);

final _price = RidePrice(estimatedPrice: 12500, distanceInKm: '7.4');

void main() {
  final cases = <String, Widget Function()>{
    'SearchingForDriverCard': () => SearchingForDriverCard(
      onCancel: () {},
      pickupLabel: _address,
      dropoffLabel: _address,
      price: _price,
    ),
    'DriverOnTheWayCard': () => DriverOnTheWayCard(
      driver: _captain(),
      onCancel: () {},
      onCall: () {},
      onMessage: () {},
      etaMinutes: 12,
      pickupLabel: _address,
      dropoffLabel: _address,
      price: _price,
    ),
    'DriverArrivedCard': () => DriverArrivedCard(
      driver: _captain(),
      onCancel: () {},
      onCall: () {},
      onMessage: () {},
      pickupLabel: _address,
      dropoffLabel: _address,
      price: _price,
    ),
    'RideInProgressCard': () => RideInProgressCard(
      destinationLabel: _address,
      driver: _captain(),
      etaMinutes: 9,
      pickupLabel: _address,
      price: _price,
    ),
  };

  // The price body needs payment and request providers of its own; this covers
  // the header, which is the row that gained a back button and a badge.
  cases['RidePriceCard header'] = () => RidePriceCard(onClose: () {});

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

      // The one header that carries a back button beside the badge.
      for (final stage in PickingStage.values) {
        testWidgets('RideDraftCard header · ${stage.name}', (tester) async {
          await _pump(
            tester,
            const Row(
              children: [
                RideBackButton(),
                Expanded(child: RideCardTitle()),
              ],
            ),
            stage: stage,
            textScale: scale,
          );
          expect(
            tester.takeException(),
            isNull,
            reason: 'draft header overflows at ${stage.name}, scale $scale',
          );
        });
      }
    });
  }
}
