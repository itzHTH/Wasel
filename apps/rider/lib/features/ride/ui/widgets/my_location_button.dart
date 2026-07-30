import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_location_controller.dart';
import 'package:wasel_core/wasel_core.dart';

class MyLocationButton extends ConsumerWidget {
  const MyLocationButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLocating = ref.watch(
      rideLocationControllerProvider.select((s) => s.isLocating),
    );

    return FloatingActionButton.small(
      backgroundColor: AppColor.neutral0,
      shape: const CircleBorder(),
      onPressed: isLocating
          ? null
          : () => ref
                .read(rideLocationControllerProvider.notifier)
                .centerOnUserLocation(context),
      child: isLocating
          ? AppInlineLoading(size: AppDimens.icon20)
          : const Icon(Icons.my_location, color: AppColor.primary500),
    );
  }
}
