import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasel_payments/wasel_payments.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/selected_payment_method_provider.dart';
import 'package:wasal/features/ride/ui/widgets/payment/card_form_sheet.dart';
import 'package:wasal/features/ride/ui/widgets/payment/payment_method_sheet.dart';
import 'package:wasel_core/wasel_core.dart';

class PaymentMethodRow extends ConsumerWidget {
  const PaymentMethodRow({super.key});

  Future<void> _pick(BuildContext context, WidgetRef ref) async {
    final current = ref.read(selectedPaymentMethodProvider);

    ref.read(riderWalletBalanceControllerProvider.notifier).refresh();

    final picked = await showPaymentMethodSheet(
      context: context,
      selected: current,
    );
    if (picked == null || !context.mounted) return;

    final token = ref.read(tokenizeCardControllerProvider).value;
    if (PaymentEligibilityPolicy.requiresCard(picked, token)) {
      final tokenized = await showCardFormSheet(context, ref);
      if (!tokenized || !context.mounted) return;
    }

    ref.read(selectedPaymentMethodProvider.notifier).select(picked);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedPaymentMethodProvider);

    return InkWell(
      onTap: () => _pick(context, ref),
      borderRadius: BorderRadius.circular(AppDimens.radius8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimens.space4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.paymentMethodLabel,
              style: context.styles.bodySecondary(),
            ),
            Row(
              children: [
                Icon(
                  paymentMethodIcon(selected),
                  size: AppDimens.icon20,
                  color: context.colors.primary500,
                ),
                SizedBox(width: AppDimens.space8),
                Text(
                  selected.label(context.paymentsL10n),
                  style: context.styles.body(weight: FontWeight.w600),
                ),
                Icon(
                  Icons.chevron_left_rounded,
                  size: AppDimens.icon20,
                  color: context.colors.neutral400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
