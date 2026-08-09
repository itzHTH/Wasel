import 'package:driver/core/helpers/ride_formatters.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class DriverEarningsChip extends StatelessWidget {
  const DriverEarningsChip({
    super.key,
    required this.total,
    this.currency = 'IQD',
  });

  final num total;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final isPositive = total > 0;

    final foreground = isPositive
        ? AppColor.alertSuccess500
        : AppColor.alertError500;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
        vertical: AppDimens.space4,
      ),
      decoration: BoxDecoration(
        color: isPositive ? AppColor.alertSuccess100 : AppColor.alertError100,
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
            RideFormatters.fare(total.toString()),
            textDirection: TextDirection.ltr,
            style: AppTextStyles.font14Primary500SemiBold.copyWith(
              color: foreground,
            ),
          ),
          SizedBox(width: AppDimens.space4),
          Text(
            currency,
            style: AppTextStyles.font14Primary500SemiBold.copyWith(
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}
