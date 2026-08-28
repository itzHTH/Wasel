import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasel_core/wasel_core.dart';

class RideRecoveryErrorCard extends ConsumerWidget {
  const RideRecoveryErrorCard({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRetrying = ref.watch(
      rideControllerProvider.select((s) => s.isRecovering),
    );

    return RideCardShell(
      child: AppErrorRetry(
        message: message,
        isRetrying: isRetrying,
        onRetry: () =>
            ref.read(rideControllerProvider.notifier).retryRecovery(),
      ),
    );
  }
}
