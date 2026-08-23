import 'package:wasel_core/wasel_core.dart';
import 'package:wasal/l10n/rider_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/domain/entities/cancel_ride.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_state.dart';
import 'package:wasal/features/ride/ui/providers/ride_use_case_providers.dart';

part 'cancel_ride_provider.g.dart';

@riverpod
class CancelRideController extends _$CancelRideController {
  @override
  FutureOr<CancelRide?> build() {
    return null;
  }

  Future<void> cancelRide() async {
    final rideCtrl = ref.read(rideControllerProvider);

    if (rideCtrl.stage == RideStage.inProgress) return;

    final rideId = ref.read(requestRideControllerProvider).value?.id;
    if (rideId == null) {
      state = AsyncValue.error(_l10n(ref).noRideToCancel, StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();
    final useCase = ref.read(cancelRideUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(rideId);

    if (!ref.mounted) return;

    result.when(
      failure: (error) {
        state = AsyncValue.error(errorMessageOf(error), StackTrace.current);
      },
      success: (price) {
        state = AsyncValue.data(price);
      },
    );
  }
}

/// Localizations for a notifier, which has no BuildContext of its own.
RiderLocalizations _l10n(Ref ref) =>
    lookupRiderLocalizations(ref.read(appLocalizationControllerProvider));
