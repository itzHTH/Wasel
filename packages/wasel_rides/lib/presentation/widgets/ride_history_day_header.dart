import 'package:flutter/material.dart';
import 'package:wasel_rides/l10n/rides_l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
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
        RideHistoryLabels.dayLabel(context.ridesL10n, day),
        style: context.styles.caption(
          weight: FontWeight.w600,
          color: context.colors.neutral600,
        ),
      ),
    );
  }
}
