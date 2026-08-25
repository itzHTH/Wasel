import 'package:wasel_core/wasel_core.dart';
import 'package:wasal/l10n/rider_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/domain/entities/cancel_ride.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_state.dart';
import 'package:wasal/features/ride/ride_di_providers.dart';

part 'cancel_ride_provider.g.dart';

@riverpod
class CancelRideController extends _$CancelRideController {
  @override
  FutureOr<CancelRide?> build() {
    // Registered once here rather than per call: the in-flight request is tied
    // to this notifier's life, and re-registering on every tap would stack up
    // callbacks that all fire on the one disposal.
    final useCase = ref.watch(cancelRideUseCaseProvider);
    ref.onDispose(useCase.cancel);

    return null;
  }

  Future<void> cancelRide() async {
    // A second tap while the first call is in flight is a double tap.
    if (state.isLoading) return;

    final rideCtrl = ref.read(rideControllerProvider);

    if (rideCtrl.stage == RideStage.inProgress) {
      _fail(_l10n(ref).cannotCancelInProgress);
      return;
    }

    final rideId = ref.read(requestRideControllerProvider).value?.id;
    if (rideId == null) {
      _fail(_l10n(ref).noRideToCancel);
      return;
    }

    state = const AsyncValue.loading();

    final result = await ref.read(cancelRideUseCaseProvider).call(rideId);

    if (!ref.mounted) return;

    result.when(
      failure: (error) => _fail(errorMessageOf(error)),
      success: (cancellation) {
        // A refusal comes back as a plain success the UI cannot act on, so it
        // is reported as the failure it is rather than left as a dead end.
        if (!cancellation.isCancelled) {
          _fail(_l10n(ref).cancelRideFailed);
          return;
        }
        state = AsyncValue.data(cancellation);
      },
    );
  }

  void _fail(String message) =>
      state = AsyncValue.error(message, StackTrace.current);
}

/// Localizations for a notifier, which has no BuildContext of its own.
RiderLocalizations _l10n(Ref ref) =>
    lookupRiderLocalizations(ref.read(appLocalizationControllerProvider));
