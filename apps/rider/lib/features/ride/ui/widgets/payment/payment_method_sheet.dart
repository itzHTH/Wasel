import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:wasel_payments/domain/entities/payment_method.dart';
import 'package:wasel_payments/presentation/widgets/payment_method_style.dart';

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
    backgroundColor: AppColor.screenBackground,
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
                  color: AppColor.neutral200,
                  borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                ),
              ),
            ),
            SizedBox(height: AppDimens.space24),
            Text(
              'طريقة الدفع',
              textAlign: TextAlign.center,
              style: AppTextStyles.font16Secondary900Bold,
            ),
            SizedBox(height: AppDimens.space16),
            AppGroupCard(
              children: [
                for (final method in _selectableMethods)
                  AppMenuTile(
                    icon: paymentMethodIcon(method),
                    label: method.label,
                    trailing: method == selected
                        ? Icon(
                            Icons.check_circle_rounded,
                            color: AppColor.primary500,
                            size: AppDimens.icon20,
                          )
                        : const SizedBox.shrink(),
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
