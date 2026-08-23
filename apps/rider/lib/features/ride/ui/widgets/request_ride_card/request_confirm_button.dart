import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/widgets/app_primary_button.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';

class RequestConfirmButton extends ConsumerWidget {
  const RequestConfirmButton({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppPrimaryButton(
      label: context.l10n.confirmRequest,
      isLoading: isLoading,
      onPressed: () =>
          ref.read(requestRideControllerProvider.notifier).requestRide(),
    );
  }
}
