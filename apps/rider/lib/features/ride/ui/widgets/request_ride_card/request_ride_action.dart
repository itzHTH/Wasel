import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasel_payments/wasel_payments.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/widgets/request_ride_card/request_confirm_button.dart';
import 'package:wasal/features/ride/ui/widgets/request_ride_card/request_ride_error_view.dart';

class RequestRideAction extends ConsumerWidget {
  const RequestRideAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(requestRideControllerProvider);
    return state.when(
      loading: () => const RequestConfirmButton(isLoading: true),
      error: (error, _) {
        // A blocked payment method arrives as a reason, not a sentence, so the
        // copy is chosen here rather than in the domain layer.
        if (error is PaymentBlocker) {
          return RequestRideErrorView(
            message: error.message(context.paymentsL10n),
          );
        }

        final message = '$error'.trim();
        return RequestRideErrorView(
          message: message.isEmpty ? context.l10n.requestRideFailed : message,
        );
      },
      data: (ride) =>
          ride == null ? const RequestConfirmButton() : const SizedBox.shrink(),
    );
  }
}
