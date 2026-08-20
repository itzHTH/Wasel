import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_rides/domain/entities/ride_history_entry.dart';
import 'package:wasel_rides/core/formatters/ride_history_labels.dart';
import 'package:wasel_rides/presentation/widgets/ride_history_amount.dart';

/// The revealed half of a history card.
class RideHistoryCardDetails extends StatelessWidget {
  const RideHistoryCardDetails({super.key, required this.entry});

  final RideHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: AppDimens.space12),
        Divider(height: 1, thickness: 1, color: context.colors.neutral100),
        SizedBox(height: AppDimens.space12),
        _DetailRow(
          label: 'التاريخ',
          value: Text(
            RideHistoryLabels.fullDateLabel(entry.requestedAt),
            style: context.styles.font14Secondary900SemiBold,
          ),
        ),
        SizedBox(height: AppDimens.space8),
        _DetailRow(
          label: 'وقت الطلب',
          value: Text(
            RideHistoryLabels.timeLabel(entry.requestedAt),
            style: context.styles.font14Secondary900SemiBold,
          ),
        ),
        SizedBox(height: AppDimens.space8),
        _DetailRow(
          label: 'قيمة الرحلة',
          value: RideHistoryAmount(
            price: entry.price,
            style: context.styles.font14Secondary900SemiBold,
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(label, style: context.styles.font12Neutral400Regular),
        ),
        SizedBox(width: AppDimens.space12),
        Flexible(child: value),
      ],
    );
  }
}
