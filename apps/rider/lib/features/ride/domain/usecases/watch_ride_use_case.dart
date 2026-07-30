import 'package:wasal/features/ride/domain/entities/ride_event.dart';
import 'package:wasal/features/ride/domain/repo/base_ride_repo.dart';
import 'package:wasel_core/wasel_core.dart';

class WatchRideUseCase extends StreamBaseUseCase<RideEvent, String> {
  final BaseRideRepo _baseRideRepo;

  WatchRideUseCase(this._baseRideRepo);

  @override
  Stream<RideEvent> call(String rideId) {
    return _baseRideRepo.watchRide(rideId);
  }
}
