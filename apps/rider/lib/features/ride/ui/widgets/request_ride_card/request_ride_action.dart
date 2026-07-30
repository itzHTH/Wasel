import 'package:flutter/material.dart';
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
        final message = '$error'.trim();
        return RequestRideErrorView(
          message: message.isEmpty
              ? 'تعذّر إرسال الطلب، حاول مرة أخرى'
              : message,
        );
      },
      data: (ride) =>
          ride == null ? const RequestConfirmButton() : const SizedBox.shrink(),
    );
  }
}
