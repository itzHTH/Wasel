import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasel_core/wasel_core.dart';

class CustomPinMap extends ConsumerWidget {
  const CustomPinMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final show = ref.watch(rideDraftProvider.select((s) => s.showMovingPin));
    if (!show) return const SizedBox.shrink();

    final tint = ref.watch(rideDraftProvider.select((s) => s.pinTint));
    return SvgPicture.asset(
      "assets/icons/pin.svg",
      fit: BoxFit.cover,
      height: AppDimens.icon48,
      width: AppDimens.icon48,
      colorFilter: tint == null
          ? null
          : ColorFilter.mode(tint, BlendMode.srcIn),
    );
  }
}
