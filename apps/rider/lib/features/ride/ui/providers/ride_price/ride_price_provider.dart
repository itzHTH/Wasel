import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/data/models/geo_point_request/geo_point_request_body.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ride_di_providers.dart';

part 'ride_price_provider.g.dart';

@Riverpod(keepAlive: true)
class RidePriceEstimate extends _$RidePriceEstimate {
  @override
  FutureOr<RidePrice?> build() {
    return null;
  }

  void adoptFare(num fare) {
    state = AsyncValue.data(RidePrice(estimatedPrice: fare, distanceInKm: ''));
  }

  Future<void> getPrice() async {
    final draft = ref.read(rideDraftProvider);
    final pickup = draft.pickup;
    final dropoff = draft.dropoff;
    if (pickup == null || dropoff == null) return;

    state = const AsyncValue.loading();
    final useCase = ref.read(getRidePriceUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(
      GeoPointRequestBody(
        pickupLat: pickup.latitude.toString(),
        pickupLng: pickup.longitude.toString(),
        dropoffLat: dropoff.latitude.toString(),
        dropoffLng: dropoff.longitude.toString(),
      ),
    );

    if (!ref.mounted) return;

    result.when(
      failure: (error) =>
          state = AsyncValue.error(errorMessageOf(error), StackTrace.current),
      success: (price) => state = AsyncValue.data(price),
    );
  }
}
