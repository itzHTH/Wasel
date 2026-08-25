import 'package:driver/core/helpers/ride_formatters.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class EarningsTotalCard extends StatelessWidget {
  const EarningsTotalCard({super.key, required this.totalEarnings});

  final num totalEarnings;

  @override
  Widget build(BuildContext context) {
    final onPrimary = context.colors.onPrimary;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimens.space24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [context.colors.primary500, context.colors.primary700],
        ),
        borderRadius: BorderRadius.circular(context.shape.radiusCard),
        boxShadow: [
          BoxShadow(
            color: context.colors.scrim.withValues(alpha: 0.12),
            blurRadius: AppDimens.radius16,
            offset: Offset(0, AppDimens.space4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.savings_outlined,
                size: AppDimens.icon20,
                color: onPrimary.withValues(alpha: 0.8),
              ),
              SizedBox(width: AppDimens.space8),
              Expanded(
                child: Text(
                  context.l10n.totalEarnings,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.styles.body(
                    weight: FontWeight.w600,
                    color: onPrimary.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space12),
          // A mirrored amount is a different number.
          Text(
            RideFormatters.fare(context.l10n, totalEarnings.toString()),
            textDirection: TextDirection.ltr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.styles.displayLarge(
              weight: FontWeight.w700,
              color: onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
