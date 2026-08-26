import 'package:flutter/material.dart';
import 'package:wasel_payments/l10n/payment_labels.dart';
import 'package:wasel_payments/l10n/payments_l10n_extension.dart';
import 'package:wasel_core/widgets/app_icon_pill.dart';
import 'package:wasel_payments/domain/entities/payment_method.dart';
import 'package:wasel_payments/presentation/widgets/payment_method_style.dart';

class PaymentMethodChip extends StatelessWidget {
  const PaymentMethodChip({super.key, required this.method});

  final PaymentMethod method;

  @override
  Widget build(BuildContext context) {
    return AppIconPill(
      icon: paymentMethodIcon(method),
      label: method.label(context.paymentsL10n),
      foreground: paymentMethodForeground(context, method),
      background: paymentMethodBackground(context, method),
    );
  }
}
