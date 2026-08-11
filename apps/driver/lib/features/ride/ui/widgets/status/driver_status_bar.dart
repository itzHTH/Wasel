import 'package:driver/features/ride/ui/providers/earnings/driver_balance_provider.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:driver/features/ride/ui/widgets/status/driver_earnings_chip.dart';
import 'package:flutter/material.dart';
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

    final earnings = ref.watch(driverBalanceControllerProvider);

    ref.listen(rideControllerProvider.select((state) => state.stage), (
      previous,
      next,
    ) {
      if (next == DriverStage.completed) {
        ref.read(driverBalanceControllerProvider.notifier).getDriverBalance();
      }
    });

    return Material(
      color: AppColor.elementBackground,
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
            Text(
              _titleFor(stage, connection),
              style: AppTextStyles.font14Secondary900SemiBold,
            ),
            SizedBox(width: AppDimens.space12),

            DriverEarningsChip(total: earnings, currency: "د.ع"),
          ],
        ),
      ),
    );
  }

  /// A live connection attempt outranks the stage: mid-reconnect the driver is
  /// still on their ride, but what they need to know is that the link is down.
  String _titleFor(DriverStage stage, DriverConnectionState connection) =>
      switch (connection) {
        DriverConnectionState.connecting => 'دا نتصل...',
        DriverConnectionState.reconnecting => 'دا نعيد الاتصال...',
        DriverConnectionState.dropped => 'انقطع الاتصال',
        DriverConnectionState.idle => switch (stage) {
          DriverStage.offline => 'غير متصل',
          DriverStage.online => 'متصل',
          DriverStage.offerReceived => 'وصلك طلب',
          DriverStage.heading => 'بالطريق للراكب',
          DriverStage.arrived => 'بانتظار الراكب',
          DriverStage.inProgress => 'رحلة جارية',
          DriverStage.completed => 'خلصت الرحلة',
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
        DriverConnectionState.dropped => AppColor.alertError500,
        DriverConnectionState.reconnecting => AppColor.alertWarning500,
        DriverConnectionState.connecting => AppColor.neutral400,
        DriverConnectionState.idle => stage == DriverStage.offline
            ? AppColor.neutral400
            : AppColor.alertSuccess500,
      },
    );
  }
}
