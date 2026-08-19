import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_payments/domain/entities/payment_method.dart';

IconData paymentMethodIcon(PaymentMethod method) => switch (method) {
  PaymentMethod.cash => Icons.payments_outlined,
  PaymentMethod.card => Icons.credit_card,
  PaymentMethod.wallet => Icons.account_balance_wallet_outlined,
  PaymentMethod.unknown => Icons.help_outline,
};

Color paymentMethodBackground(PaymentMethod method) => switch (method) {
  PaymentMethod.cash => AppColor.alertSuccess100,
  PaymentMethod.card => AppColor.alertInfo100,
  PaymentMethod.wallet => AppColor.primary100,
  PaymentMethod.unknown => AppColor.neutral100,
};

Color paymentMethodForeground(PaymentMethod method) => switch (method) {
  PaymentMethod.cash => AppColor.alertSuccess500,
  PaymentMethod.card => AppColor.alertInfo500,
  PaymentMethod.wallet => AppColor.primary500,
  PaymentMethod.unknown => AppColor.neutral400,
};
