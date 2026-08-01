import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wasal/core/consts/app_icons.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasel_core/wasel_core.dart';

class CustomPinMap extends ConsumerWidget {
  const CustomPinMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final show = ref.watch(rideDraftProvider.select((s) => s.showMovingPin));
    if (!show) return const SizedBox.shrink();

    final isStarterPoint = ref.watch(
      rideDraftProvider.select((s) => s.isStarterPoint),
    );

    return SvgPicture.asset(
      isStarterPoint ? AppIcons.pinStart : AppIcons.pinDestination,
      fit: BoxFit.cover,
      height: AppDimens.icon48,
      width: AppDimens.icon48,
    );
  }
}
