import 'package:driver/core/helpers/ride_formatters.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class DriverEarningsChip extends StatelessWidget {
  const DriverEarningsChip({
    super.key,
    required this.total,
    this.currency = 'IQD',
    this.isPlaceholder = false,
  });

  final num total;
  final String currency;

  /// Dims the chip while the earnings endpoint does not exist, so the number
  /// is not read as a real balance.
  final bool isPlaceholder;

  @override
  Widget build(BuildContext context) {
    final foreground = isPlaceholder
        ? AppColor.neutral400
        : AppColor.alertSuccess500;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
        vertical: AppDimens.space4,
      ),
      decoration: BoxDecoration(
        color: isPlaceholder
            ? AppColor.neutral100
            : AppColor.alertSuccess100,
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
            RideFormatters.fare(total.toString(), currency: currency),
            style: AppTextStyles.font14Primary500SemiBold.copyWith(
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}
