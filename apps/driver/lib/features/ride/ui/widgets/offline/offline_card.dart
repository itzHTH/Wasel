import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:wasel_core/wasel_core.dart';

class OfflineCard extends StatelessWidget {
  const OfflineCard({
    super.key,
    required this.onGoOnline,
    required this.onCancel,
    this.isConnecting = false,
  });

  final VoidCallback onGoOnline;

  /// Aborts an attempt that is still in flight.
  final VoidCallback onCancel;

  final bool isConnecting;

  @override
  Widget build(BuildContext context) {
    return RideCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RideStageHeader(
            stage: isConnecting
                ? RideStageVisual.connecting
                : RideStageVisual.offline,
            title: isConnecting
                ? context.l10n.connectingToServer
                : context.l10n.youAreOffline,
            subtitle: isConnecting
                ? context.l10n.oneMomentConnecting
                : context.l10n.noRequestsWhileOffline,
          ),
          SizedBox(height: AppDimens.space24),
          AppPrimaryButton(
            label: context.l10n.startAcceptingRides,

            onPressed: isConnecting ? null : onGoOnline,
            isLoading: isConnecting,
          ),
          if (isConnecting) ...[
            SizedBox(height: AppDimens.space12),
            AppSecondaryButton(
              label: context.coreL10n.cancel,
              onPressed: onCancel,
            ),
          ],
        ],
      ),
    );
  }
}
