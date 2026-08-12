import 'package:driver/core/helpers/ride_formatters.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class DriverEarningsChip extends StatelessWidget {
  const DriverEarningsChip({
    super.key,
    required this.total,
    this.currency = 'IQD',
  });

  /// Null until the balance has been read — a figure the driver cannot be
  /// shown yet is not the same as a balance of zero, so it reads as neither.
  final num? total;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final total = this.total;

    // An empty wallet is not a broken one: only money owed back is worth
    // alarming the driver about, and a balance not read yet is worth neither.
    final (foreground, background) = switch (total) {
      final num value when value > 0 => (
        AppColor.alertSuccess500,
        AppColor.alertSuccess100,
      ),
      final num value when value < 0 => (
        AppColor.alertError500,
        AppColor.alertError100,
      ),
      _ => (AppColor.neutral400, AppColor.neutral100),
    };
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
        vertical: AppDimens.space4,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: AppDimens.icon18,
            color: foreground,
          ),
          SizedBox(width: AppDimens.space4),
          Text(
            total == null
                ? '—'
                : RideFormatters.fare(total.toString(), currency: currency),
            textDirection: TextDirection.ltr,
            style: AppTextStyles.font14Primary500SemiBold.copyWith(
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}
