import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/selected_payment_method_provider.dart';
import 'package:wasal/features/ride/ui/widgets/payment/card_form_sheet.dart';
import 'package:wasal/features/ride/ui/widgets/payment/payment_method_sheet.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:wasel_payments/core/policies/payment_eligibility_policy.dart';
import 'package:wasel_payments/presentation/providers/tokenize/tokenize_card_provider.dart';
import 'package:wasel_payments/presentation/providers/wallet/rider_wallet_balance_provider.dart';
import 'package:wasel_payments/presentation/widgets/payment_method_style.dart';

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
            Text('طريقة الدفع', style: context.styles.font14Secondary500Medium),
            Row(
              children: [
                Icon(
                  paymentMethodIcon(selected),
                  size: AppDimens.icon20,
                  color: context.colors.primary500,
                ),
                SizedBox(width: AppDimens.space8),
                Text(
                  selected.label,
                  style: context.styles.font14Secondary900SemiBold,
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
