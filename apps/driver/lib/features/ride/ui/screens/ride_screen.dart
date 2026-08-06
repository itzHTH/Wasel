import 'package:driver/core/const/app_driver_consts.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:driver/features/ride/ui/providers/driver_location_broadcaster.dart';
import 'package:driver/features/ride/ui/providers/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:driver/features/ride/ui/widgets/cards/ride_offer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

class RideScreen extends ConsumerWidget {
  const RideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(rideActionControllerProvider, (previous, next) {
      if (!next.hasError) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(next.error.toString())));
    });

    ref.watch(driverLocationBroadcasterProvider);

    final isOnline = ref.watch(
      rideControllerProvider.select(
        (state) => state.stage != DriverStage.offline,
      ),
    );

    final isOffering = ref.watch(
      rideControllerProvider.select(
        (state) => state.stage == DriverStage.offerReceived,
      ),
    );

    final offer = ref.watch(
      rideControllerProvider.select((state) => state.ride),
    );

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const AppMap(mapId: AppDriverConsts.mapStyleID),
          const Positioned.fill(child: AppMapLoadingOverlay()),
          Positioned(
            top: AppDimens.space16,
            child: SafeArea(
              child: _OnlineToggleCard(
                isOnline: isOnline,
                onChanged: (value) => value
                    ? ref.read(rideControllerProvider.notifier).goOnline()
                    : ref.read(rideControllerProvider.notifier).goOffline(),
              ),
            ),
          ),
          if (isOffering && offer != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: RideOfferCard(
                pickupText: _coordinates(offer.position),
                dropoffText: _coordinates(offer.dropPosition),
                priceText: '${offer.calculatedPrice.toStringAsFixed(0)} د.ع',
                paymentText: offer.paymentMethod,
                onAccept: () =>
                    ref.read(rideControllerProvider.notifier).acceptOffer(),
                onReject: () =>
                    ref.read(rideControllerProvider.notifier).rejectOffer(),
              ),
            ),
        ],
      ),
    );
  }
}

String _coordinates(GeoPoint point) =>
    '${point.latitude.toStringAsFixed(5)}, ${point.longitude.toStringAsFixed(5)}';

class _OnlineToggleCard extends StatelessWidget {
  const _OnlineToggleCard({required this.isOnline, required this.onChanged});

  final bool isOnline;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.elementBackground,
      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.space16,
          vertical: AppDimens.space8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isOnline ? 'متصل' : 'غير متصل',
              style: AppTextStyles.font14Secondary900SemiBold,
            ),
            SizedBox(width: AppDimens.space8),
            Switch(
              value: isOnline,
              activeTrackColor: AppColor.primary500,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
