import 'package:flutter/material.dart';
import 'package:wasel_rides/l10n/rides_l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_rides/domain/entities/ride_history_entry.dart';
import 'package:wasel_rides/core/formatters/ride_history_labels.dart';
import 'package:wasel_rides/presentation/widgets/ride_history_amount.dart';
import 'package:wasel_rides/presentation/widgets/ride_history_status_chip.dart';

class RideHistoryCardHeader extends StatelessWidget {
  const RideHistoryCardHeader({
    super.key,
    required this.entry,
    required this.isExpanded,
  });

  final RideHistoryEntry entry;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppDimens.icon40,
          height: AppDimens.icon40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colors.primary100,
            borderRadius: BorderRadius.circular(AppDimens.radius12),
          ),
          child: Icon(
            Icons.route_rounded,
            size: AppDimens.icon20,
            color: context.colors.primary500,
          ),
        ),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                RideHistoryLabels.timeLabel(
                  context.ridesL10n,
                  entry.requestedAt,
                ),
                style: context.styles.body(weight: FontWeight.w600),
              ),
              SizedBox(height: AppDimens.space4),
              RideHistoryStatusChip(status: entry.status),
            ],
          ),
        ),
        SizedBox(width: AppDimens.space12),
        RideHistoryAmount(price: entry.price),
        SizedBox(width: AppDimens.space4),
        AnimatedRotation(
          turns: isExpanded ? 0.25 : 0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: ExcludeSemantics(
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: AppDimens.icon20,
              color: context.colors.neutral400,
            ),
          ),
        ),
      ],
    );
  }
}
