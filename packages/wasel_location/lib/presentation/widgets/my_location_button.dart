import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/app_loading.dart';
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

    return FloatingActionButton.small(
      heroTag: heroTag,
      backgroundColor: context.colors.neutral0,
      shape: const CircleBorder(),
      onPressed: isLocating
          ? null
          : () => ref
                .read(recenterControllerProvider.notifier)
                .centerOnUser(context, zoom: zoom),
      child: isLocating
          ? AppInlineLoading(size: AppDimens.icon20)
          : Icon(
              Icons.my_location,
              size: AppDimens.icon20,
              color: context.colors.primary500,
            ),
    );
  }

  void _showFailure(
    BuildContext context,
    WidgetRef ref,
    LocationFailureReason reason,
  ) {
    final isServiceDisabled = reason == LocationFailureReason.serviceDisabled;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_messageFor(reason)),
        action: isServiceDisabled
            ? SnackBarAction(
                label: 'الإعدادات',
                onPressed: () => ref
                    .read(recenterControllerProvider.notifier)
                    .openLocationSettings(),
              )
            : null,
      ),
    );
  }

  String _messageFor(LocationFailureReason reason) => switch (reason) {
    LocationFailureReason.serviceDisabled =>
      'خدمة الموقع مطفّية، شغّلها حتى نگدر نوصل لموقعك',
    LocationFailureReason.permissionDenied ||
    LocationFailureReason.permissionPermanentlyDenied =>
      'ما نگدر نوصل لموقعك بدون إذن الموقع',
    LocationFailureReason.fixTimeout => 'ما گدرنا نلگه موقعك، جرّب مرة ثانية',
    LocationFailureReason.unavailable => 'صار خطأ وإحنا ندوّر على موقعك',
  };
}
