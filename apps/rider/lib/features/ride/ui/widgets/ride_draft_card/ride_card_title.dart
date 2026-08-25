import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_state.dart';
import 'package:wasel_core/wasel_core.dart';

class RideCardTitle extends ConsumerWidget {
  const RideCardTitle({super.key});

  static RideStageVisual _badgeFor(PickingStage stage) => switch (stage) {
    PickingStage.pickup => RideStageVisual.choosingPickup,
    PickingStage.dropoff => RideStageVisual.choosingDropoff,
    PickingStage.done => RideStageVisual.reviewingTrip,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stage = ref.watch(rideDraftProvider.select((s) => s.stage));

    return Row(
      children: [
        RideStageBadge(stage: _badgeFor(stage)),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: Text(
            stage.cardTitle(context.l10n),
            style: context.styles.title(),
          ),
        ),
      ],
    );
  }
}
