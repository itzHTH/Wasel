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
          Row(
            children: [
              _OfflineBadge(isConnecting: isConnecting),
              SizedBox(width: AppDimens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isConnecting
                          ? context.l10n.connectingToServer
                          : context.l10n.youAreOffline,
                      style: context.styles.title(),
                    ),
                    Text(
                      isConnecting
                          ? context.l10n.oneMomentConnecting
                          : context.l10n.noRequestsWhileOffline,
                      style: context.styles.bodyMuted(),
                    ),
                  ],
                ),
              ),
            ],
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

class _OfflineBadge extends StatelessWidget {
  const _OfflineBadge({required this.isConnecting});

  final bool isConnecting;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.space8),
      decoration: BoxDecoration(
        color: isConnecting
            ? context.colors.primary100
            : context.colors.neutral100,
        borderRadius: BorderRadius.circular(AppDimens.radius12),
      ),
      child: Icon(
        Icons.power_settings_new_rounded,
        size: AppDimens.icon20,
        color: isConnecting
            ? context.colors.primary500
            : context.colors.neutral400,
      ),
    );
  }
}
