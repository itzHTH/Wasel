import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:driver/features/ride/domain/repo/base_ride_repo.dart';
import 'package:wasel_core/usecase/stream_base_use_case.dart';

class WatchRideEventUseCase extends StreamBaseUseCase<DriverRideEvent, void> {
  final BaseRideRepo _baseRideRepo;

  WatchRideEventUseCase(this._baseRideRepo);

  @override
  Stream<DriverRideEvent> call(void params) {
    return _baseRideRepo.watchRideEvents();
  }
}
