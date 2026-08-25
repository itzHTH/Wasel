import 'package:driver/l10n/l10n_extension.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class EarningsCashOutButton extends StatelessWidget {
  const EarningsCashOutButton({super.key, required this.canCashOut});

  final bool canCashOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.cashOut,
                style: context.styles.title(weight: FontWeight.w700),
              ),
            ),
            const AppSoonBadge(),
          ],
        ),
        SizedBox(height: AppDimens.space12),
        AppPrimaryButton(
          label: context.l10n.cashOut,
          onPressed: canCashOut ? () => _showComingSoon(context) : null,
        ),
        if (!canCashOut) ...[
          SizedBox(height: AppDimens.space8),
          Text(
            context.l10n.cashOutUnavailableHint,
            style: context.styles.captionMuted(),
          ),
        ],
      ],
    );
  }

  Future<void> _showComingSoon(BuildContext context) {
    return AppDialog.show(
      context,
      title: context.l10n.cashOutSoonTitle,
      message: context.l10n.cashOutSoonMessage,
      confirmLabel: context.coreL10n.done,
      icon: Icons.account_balance_wallet_outlined,
    );
  }
}
