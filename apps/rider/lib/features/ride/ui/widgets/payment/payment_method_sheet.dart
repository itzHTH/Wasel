import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasel_payments/wasel_payments.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/helpers/ride_formatters.dart';
import 'package:wasel_core/wasel_core.dart';

const _selectableMethods = [
  PaymentMethod.cash,
  PaymentMethod.card,
  PaymentMethod.wallet,
];

Future<PaymentMethod?> showPaymentMethodSheet({
  required BuildContext context,
  required PaymentMethod selected,
}) {
  return showModalBottomSheet<PaymentMethod>(
    context: context,
    backgroundColor: context.colors.screenBackground,
    useSafeArea: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDimens.radius24),
      ),
    ),
    builder: (context) => _PaymentMethodSheet(selected: selected),
  );
}

class _PaymentMethodSheet extends StatelessWidget {
  const _PaymentMethodSheet({required this.selected});

  final PaymentMethod selected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppDimens.space16,
          AppDimens.space12,
          AppDimens.space16,
          AppDimens.space24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: AppDimens.space40,
                height: AppDimens.space4,
                decoration: BoxDecoration(
                  color: context.colors.neutral200,
                  borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                ),
              ),
            ),
            SizedBox(height: AppDimens.space24),
            Text(
              context.l10n.paymentMethodLabel,
              textAlign: TextAlign.center,
              style: context.styles.bodyLarge(weight: FontWeight.w700),
            ),
            SizedBox(height: AppDimens.space16),
            AppGroupCard(
              children: [
                for (final method in _selectableMethods)
                  AppMenuTile(
                    icon: paymentMethodIcon(method),
                    label: method.label(context.paymentsL10n),
                    trailing: _MethodTrailing(
                      method: method,
                      isSelected: method == selected,
                    ),
                    onTap: () => Navigator.of(context).pop(method),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MethodTrailing extends ConsumerWidget {
  const _MethodTrailing({required this.method, required this.isSelected});

  final PaymentMethod method;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final check = isSelected
        ? Icon(
            Icons.check_circle_rounded,
            color: context.colors.primary500,
            size: AppDimens.icon20,
          )
        : const SizedBox.shrink();

    if (method != PaymentMethod.wallet) return check;

    // A balance that has not arrived yet is not a balance of zero, so the row
    // stays bare until the figure is real.
    final wallet = ref.watch(riderWalletBalanceControllerProvider);
    final balance = wallet.hasError ? null : wallet.value?.balance;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (balance != null) ...[
          Text(
            RideFormatters.fare(context.l10n, balance),
            style: context.styles.body(
              weight: FontWeight.w500,
              color: context.colors.secondary500,
            ),
          ),
          SizedBox(width: AppDimens.space8),
        ],
        check,
      ],
    );
  }
}
