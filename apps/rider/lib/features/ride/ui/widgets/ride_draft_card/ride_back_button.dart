import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasel_core/wasel_core.dart';

class RideBackButton extends ConsumerWidget {
  const RideBackButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final show = ref.watch(rideDraftProvider.select((s) => s.showBackButton));
    if (!show) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsetsDirectional.only(start: AppDimens.space8),
      child: IconButton(
        onPressed: () => ref.read(rideDraftProvider.notifier).goBackOneStep(),
        style: IconButton.styleFrom(backgroundColor: context.colors.neutral100),
        icon: Icon(Icons.arrow_back, color: context.colors.secondary900),
      ),
    );
  }
}
