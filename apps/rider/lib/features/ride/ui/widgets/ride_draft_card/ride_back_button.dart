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

    // The gap travels with the button so the stage badge sits flush against
    // the card edge on the stages that have nothing to go back to.
    return Padding(
      padding: EdgeInsetsDirectional.only(end: AppDimens.space12),
      child: AppBackButton(
        onTap: () => ref.read(rideDraftProvider.notifier).goBackOneStep(),
      ),
    );
  }
}
