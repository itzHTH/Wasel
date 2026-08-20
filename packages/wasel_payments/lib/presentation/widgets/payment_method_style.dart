import 'package:flutter/material.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_payments/domain/entities/payment_method.dart';

IconData paymentMethodIcon(PaymentMethod method) => switch (method) {
  PaymentMethod.cash => Icons.payments_outlined,
  PaymentMethod.card => Icons.credit_card,
  PaymentMethod.wallet => Icons.account_balance_wallet_outlined,
  PaymentMethod.unknown => Icons.help_outline,
};

Color paymentMethodBackground(BuildContext context, PaymentMethod method) =>
    switch (method) {
      PaymentMethod.cash => context.colors.alertSuccess100,
      PaymentMethod.card => context.colors.alertInfo100,
      PaymentMethod.wallet => context.colors.primary100,
      PaymentMethod.unknown => context.colors.neutral100,
    };

Color paymentMethodForeground(BuildContext context, PaymentMethod method) =>
    switch (method) {
      PaymentMethod.cash => context.colors.alertSuccess500,
      PaymentMethod.card => context.colors.alertInfo500,
      PaymentMethod.wallet => context.colors.primary500,
      PaymentMethod.unknown => context.colors.neutral400,
    };
