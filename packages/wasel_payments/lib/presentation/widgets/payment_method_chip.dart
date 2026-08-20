import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_payments/domain/entities/payment_method.dart';
import 'package:wasel_payments/presentation/widgets/payment_method_style.dart';

class PaymentMethodChip extends StatelessWidget {
  const PaymentMethodChip({super.key, required this.method});

  final PaymentMethod method;

  @override
  Widget build(BuildContext context) {
    final foreground = paymentMethodForeground(context, method);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
        vertical: AppDimens.space4,
      ),
      decoration: BoxDecoration(
        color: paymentMethodBackground(context, method),
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            paymentMethodIcon(method),
            size: AppDimens.icon18,
            color: foreground,
          ),
          SizedBox(width: AppDimens.space4),
          Text(
            method.label,
            style: context.styles.font14Primary500SemiBold.copyWith(
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}
