import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_rides/core/formatters/ride_history_labels.dart';

class RideHistoryDayHeader extends StatelessWidget {
  const RideHistoryDayHeader({super.key, required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: AppDimens.space4,
        top: AppDimens.space16,
        bottom: AppDimens.space8,
      ),
      child: Text(
        RideHistoryLabels.dayLabel(day),
        style: AppTextStyles.font12Neutral600SemiBold,
      ),
    );
  }
}
