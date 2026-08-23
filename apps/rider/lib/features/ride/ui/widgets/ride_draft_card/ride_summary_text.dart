import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/widgets/point_label_row.dart';
import 'package:wasel_core/wasel_core.dart';

class RideSummaryText extends ConsumerWidget {
  const RideSummaryText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickup = ref.watch(rideDraftProvider.select((s) => s.pickup));
    final dropoff = ref.watch(rideDraftProvider.select((s) => s.dropoff));
    if (pickup == null && dropoff == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(top: AppDimens.space8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (pickup != null)
            PointLabelRow(prefix: context.l10n.pickupLabel, point: pickup),
          if (dropoff != null) ...[
            SizedBox(height: AppDimens.space4),
            PointLabelRow(
              prefix: context.l10n.destinationLabel,
              point: dropoff,
            ),
          ],
        ],
      ),
    );
  }
}
