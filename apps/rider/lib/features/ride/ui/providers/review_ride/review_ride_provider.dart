import 'package:wasel_core/wasel_core.dart';
import 'package:wasal/l10n/rider_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/domain/entities/review_ride.dart';
import 'package:wasal/features/ride/domain/usecases/review_ride_use_case.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_use_case_providers.dart';

part 'review_ride_provider.g.dart';

@riverpod
class ReviewRideController extends _$ReviewRideController {
  late ReviewRideUseCase _useCase;

  @override
  FutureOr<ReviewRide?> build() {
    _useCase = ref.watch(reviewRideUseCaseProvider);
    ref.onDispose(_useCase.cancel);
    return null;
  }

  Future<void> submit({required int rating, String comment = ''}) async {
    final rideId = ref.read(requestRideControllerProvider).value?.id;
    if (rideId == null) {
      state = AsyncValue.error(_l10n(ref).noRideToRate, StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();

    final result = await _useCase.call(
      ReviewRideParams(rideId: rideId, rating: rating, comment: comment),
    );

    if (!ref.mounted) return;

    result.when(
      failure: (error) {
        state = AsyncValue.error(errorMessageOf(error), StackTrace.current);
      },
      success: (review) {
        state = AsyncValue.data(review);
      },
    );
  }
}

/// Localizations for a notifier, which has no BuildContext of its own.
RiderLocalizations _l10n(Ref ref) =>
    lookupRiderLocalizations(ref.read(appLocalizationControllerProvider));
