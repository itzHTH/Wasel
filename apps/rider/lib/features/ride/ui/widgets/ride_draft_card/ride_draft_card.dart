import 'package:flutter/material.dart';
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
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(
        AppDimens.space16,
        0,
        AppDimens.space16,
        AppDimens.space24,
      ),
      padding: EdgeInsetsDirectional.fromSTEB(
        AppDimens.screenHPadding,
        AppDimens.space16,
        AppDimens.screenHPadding,
        AppDimens.space24,
      ),
      decoration: BoxDecoration(
        color: AppColor.elementBackground,
        borderRadius: BorderRadius.circular(AppDimens.radius24),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondary900.withValues(alpha: 0.08),
            blurRadius: AppDimens.radius16,
            offset: Offset(0, AppDimens.space4),
          ),
        ],
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
