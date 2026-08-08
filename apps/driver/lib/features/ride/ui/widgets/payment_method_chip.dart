import 'package:driver/features/ride/domain/entities/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class PaymentMethodChip extends StatelessWidget {
  const PaymentMethodChip({super.key, required this.method});

  final PaymentMethod method;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
        vertical: AppDimens.space4,
      ),
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, size: AppDimens.icon18, color: _foreground),
          SizedBox(width: AppDimens.space4),
          Text(
            method.label,
            style: AppTextStyles.font14Primary500SemiBold.copyWith(
              color: _foreground,
            ),
          ),
        ],
      ),
    );
  }

  Color get _background => switch (method) {
    PaymentMethod.cash => AppColor.alertSuccess100,
    PaymentMethod.card => AppColor.alertInfo100,
    PaymentMethod.wallet => AppColor.primary100,
    PaymentMethod.unknown => AppColor.neutral100,
  };

  Color get _foreground => switch (method) {
    PaymentMethod.cash => AppColor.alertSuccess500,
    PaymentMethod.card => AppColor.alertInfo500,
    PaymentMethod.wallet => AppColor.primary500,
    PaymentMethod.unknown => AppColor.neutral400,
  };

  IconData get _icon => switch (method) {
    PaymentMethod.cash => Icons.payments_outlined,
    PaymentMethod.card => Icons.credit_card,
    PaymentMethod.wallet => Icons.account_balance_wallet_outlined,
    PaymentMethod.unknown => Icons.help_outline,
  };
}
