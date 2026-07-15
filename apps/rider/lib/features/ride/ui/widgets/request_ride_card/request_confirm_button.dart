import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/widgets/app_primary_button.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';

class RequestConfirmButton extends ConsumerWidget {
  const RequestConfirmButton({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppPrimaryButton(
      label: 'تأكيد الطلب',
      isLoading: isLoading,
      onPressed: () =>
          ref.read(requestRideControllerProvider.notifier).requetsRide(),
    );
  }
}
