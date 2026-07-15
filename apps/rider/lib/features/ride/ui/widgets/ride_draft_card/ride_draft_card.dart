import 'package:flutter/material.dart';
import 'package:wasal/features/ride/ui/widgets/ride_card_shell.dart';
import 'package:wasal/features/ride/ui/widgets/ride_draft_card/ride_action_buttons.dart';
import 'package:wasal/features/ride/ui/widgets/ride_draft_card/ride_back_button.dart';
import 'package:wasal/features/ride/ui/widgets/ride_draft_card/ride_card_title.dart';
import 'package:wasal/features/ride/ui/widgets/ride_draft_card/ride_summary_text.dart';
import 'package:wasel_core/wasel_core.dart';

class RideDraftCard extends StatelessWidget {
  const RideDraftCard({
    super.key,
    required this.onConfirm,
    required this.onRequestPrice,
  });

  final VoidCallback onConfirm;
  final VoidCallback onRequestPrice;

  @override
  Widget build(BuildContext context) {
    return RideCardShell(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppDimens.screenHPadding,
        AppDimens.space16,
        AppDimens.screenHPadding,
        AppDimens.space24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            children: [
              RideBackButton(),
              Expanded(child: RideCardTitle()),
            ],
          ),
          const RideSummaryText(),
          SizedBox(height: AppDimens.space16),
          RideActionButtons(
            onConfirm: onConfirm,
            onRequestPrice: onRequestPrice,
          ),
        ],
      ),
    );
  }
}
