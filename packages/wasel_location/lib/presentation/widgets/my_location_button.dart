import 'package:flutter/material.dart';
import 'package:wasel_core/widgets/feedback/app_snack_bar.dart';
import 'package:wasel_location/l10n/location_l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/feedback/app_shimmer_sheen.dart';
import 'package:wasel_location/domain/entities/location_exception.dart';
import 'package:wasel_location/presentation/providers/location/recenter_controller.dart';

class MyLocationButton extends ConsumerWidget {
  const MyLocationButton({super.key, this.heroTag, this.zoom = 16});

  /// Distinguishes this FAB from any other on the same route. The driver map
  /// stacks several
  final Object? heroTag;

  final double zoom;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(recenterControllerProvider.select((s) => s.failure), (_, next) {
      if (next == null) return;
      _showFailure(context, ref, next);
      ref.read(recenterControllerProvider.notifier).acknowledgeFailure();
    });

    final isLocating = ref.watch(
      recenterControllerProvider.select((s) => s.isLocating),
    );

    return AppShimmerSheen(
      enabled: isLocating,
      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      highlight: context.colors.primary500,
      child: FloatingActionButton.small(
        heroTag: heroTag,
        backgroundColor: context.colors.neutral0,
        shape: const CircleBorder(),
        onPressed: isLocating
            ? null
            : () => ref
                  .read(recenterControllerProvider.notifier)
                  .centerOnUser(context, zoom: zoom),
        child: Icon(
          Icons.my_location,
          size: AppDimens.icon20,
          color: context.colors.primary500,
        ),
      ),
    );
  }

  void _showFailure(
    BuildContext context,
    WidgetRef ref,
    LocationFailureReason reason,
  ) {
    final isServiceDisabled = reason == LocationFailureReason.serviceDisabled;

    final message = _messageFor(context, reason);

    // Recoverable with one tap, so it is a warning with the fix attached
    // rather than a dead end.
    if (isServiceDisabled) {
      AppSnackBar.showWarning(
        context,
        message,
        actionLabel: context.locationL10n.settings,
        onAction: () => ref
            .read(recenterControllerProvider.notifier)
            .openLocationSettings(),
      );
      return;
    }

    AppSnackBar.showError(context, message);
  }

  String _messageFor(BuildContext context, LocationFailureReason reason) =>
      switch (reason) {
        LocationFailureReason.serviceDisabled =>
          context.locationL10n.locationServiceOff,
        LocationFailureReason.permissionDenied ||
        LocationFailureReason.permissionPermanentlyDenied =>
          context.locationL10n.locationPermissionMissing,
        LocationFailureReason.fixTimeout =>
          context.locationL10n.locationNotFound,
        LocationFailureReason.unavailable => context.locationL10n.locationError,
      };
}
