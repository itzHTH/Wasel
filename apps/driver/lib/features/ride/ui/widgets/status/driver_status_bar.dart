import 'package:driver/features/ride/ui/providers/earnings/driver_balance_provider.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:driver/features/ride/ui/widgets/status/driver_earnings_chip.dart';
import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

/// The pill above the map: where the driver stands right now, plus today's
/// earnings. Reads the stage itself so no caller has to thread it through.
class DriverStatusBar extends ConsumerWidget {
  const DriverStatusBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stage = ref.watch(
      rideControllerProvider.select((state) => state.stage),
    );
    final connection = ref.watch(
      rideControllerProvider.select((state) => state.connection),
    );

    final balance = ref.watch(driverBalanceControllerProvider);

    ref.listen(rideControllerProvider.select((state) => state.stage), (
      previous,
      next,
    ) {
      if (next == DriverStage.completed) {
        ref.read(driverBalanceControllerProvider.notifier).refresh();
      }
    });

    return Material(
      color: context.colors.elementBackground,
      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.space16,
          vertical: AppDimens.space8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ConnectionDot(stage: stage, connection: connection),
            SizedBox(width: AppDimens.space8),
            Flexible(
              child: Text(
                _titleFor(context, stage, connection),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.styles.font14Secondary900SemiBold,
              ),
            ),
            SizedBox(width: AppDimens.space12),

            // Loading and error both mean "no figure to show" — the chip is a
            // glance, not a place to explain a failed request.
            DriverEarningsChip(total: balance.value),
          ],
        ),
      ),
    );
  }

  /// A live connection attempt outranks the stage: mid-reconnect the driver is
  /// still on their ride, but what they need to know is that the link is down.
  String _titleFor(
    BuildContext context,
    DriverStage stage,
    DriverConnectionState connection,
  ) => switch (connection) {
    DriverConnectionState.connecting => context.l10n.connecting,
    DriverConnectionState.reconnecting => context.l10n.reconnecting,
    DriverConnectionState.dropped => context.l10n.disconnected,
    DriverConnectionState.idle => switch (stage) {
      DriverStage.offline => context.l10n.offline,
      DriverStage.online => context.l10n.online,
      DriverStage.offerReceived => context.l10n.requestReceived,
      DriverStage.heading => context.l10n.onWayToRider,
      DriverStage.arrived => context.l10n.waitingForRider,
      DriverStage.inProgress => context.l10n.rideOngoing,
      DriverStage.completed => context.l10n.rideFinished,
    },
  };
}

class _ConnectionDot extends StatelessWidget {
  const _ConnectionDot({required this.stage, required this.connection});

  final DriverStage stage;
  final DriverConnectionState connection;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.circle,
      size: AppDimens.icon18,
      color: switch (connection) {
        DriverConnectionState.dropped => context.colors.alertError500,
        DriverConnectionState.reconnecting => context.colors.alertWarning500,
        DriverConnectionState.connecting => context.colors.neutral400,
        DriverConnectionState.idle =>
          stage == DriverStage.offline
              ? context.colors.statusOffline
              : context.colors.statusOnline,
      },
    );
  }
}
