import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/widgets/app_secondary_button.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/is_camera_moving_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_state.dart';
import 'package:wasel_core/wasel_core.dart';

class RideActionButtons extends ConsumerWidget {
  const RideActionButtons({
    super.key,
    required this.onConfirm,
    required this.onRequestPrice,
  });

  final VoidCallback onConfirm;
  final VoidCallback onRequestPrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = ref
        .watch(rideDraftProvider.select((s) => s.stage))
        .confirmButtonLabel(context.l10n);
    final showRequestPrice = ref.watch(
      rideDraftProvider.select((s) => s.showRequestPriceButton),
    );
    final isCameraMoving = ref.watch(isCameraMovingProvider);

    if (!showRequestPrice) {
      return AppPrimaryButton(
        label: label,
        onPressed: isCameraMoving ? null : onConfirm,
      );
    }

    return Row(
      children: [
        Expanded(
          child: AppPrimaryButton(
            label: context.coreL10n.confirm,
            onPressed: onRequestPrice,
          ),
        ),
        SizedBox(width: AppDimens.space8),
        Expanded(
          child: AppSecondaryButton(label: label, onPressed: onConfirm),
        ),
      ],
    );
  }
}
