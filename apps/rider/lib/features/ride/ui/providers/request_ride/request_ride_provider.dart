import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/data/models/geo_point_request/geo_point_request_body.dart';
import 'package:wasal/features/ride/domain/entities/request_ride.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_use_case_providers.dart';
import 'package:wasel_core/networking/api_results.dart';

part 'request_ride_provider.g.dart';

@riverpod
class RequestRideController extends _$RequestRideController {
  @override
  FutureOr<RequestRide?> build() {
    return null;
  }

  Future<void> requetsRide() async {
    final draft = ref.read(rideDraftProvider);
    final pickup = draft.pickup;
    final dropoff = draft.dropoff;
    if (pickup == null || dropoff == null) return;

    state = const AsyncValue.loading();
    final useCase = ref.read(requestRideUseCaseProvider);
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
      failure: (error) {
        state = AsyncValue.error(
          error.apiErrorModel.message ?? "حصل خطأ ما",
          StackTrace.current,
        );
      },
      success: (price) {
        state = AsyncValue.data(price);
      },
    );
  }
}
