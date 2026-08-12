import 'package:driver/features/ride/domain/entities/ride_connection_status.dart';
import 'package:driver/features/ride/domain/repos/ride_repo.dart';
import 'package:wasel_core/usecase/stream_base_use_case.dart';

class WatchRideConnectionUseCase
    extends StreamBaseUseCase<RideConnectionStatus, void> {
  final BaseRideRepo _baseRideRepo;

  WatchRideConnectionUseCase(this._baseRideRepo);

  @override
  Stream<RideConnectionStatus> call(void params) {
    return _baseRideRepo.watchConnectionStatus();
  }
}
