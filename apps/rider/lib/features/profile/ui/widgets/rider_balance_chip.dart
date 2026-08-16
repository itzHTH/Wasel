import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

class RiderBalanceChip extends StatelessWidget {
  const RiderBalanceChip({super.key, required this.balance});

  final double balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
        vertical: AppDimens.space4,
      ),
      decoration: BoxDecoration(
        color: AppColor.neutral0,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.account_balance_wallet_rounded,
            size: AppDimens.icon18,
            color: AppColor.primary500,
          ),
          SizedBox(width: AppDimens.space4),
          Text(
            NumberFormat.decimalPattern('ar').format(balance),
            style: AppTextStyles.font14Primary500SemiBold,
          ),
        ],
      ),
    );
  }
}
