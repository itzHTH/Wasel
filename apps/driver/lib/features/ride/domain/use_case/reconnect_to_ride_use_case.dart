import 'package:driver/features/ride/domain/repo/base_ride_repo.dart';
import 'package:wasel_core/usecase/base_use_case.dart';

class ReconnectToRideUseCase extends BaseUseCase<bool, String> {
  final BaseRideRepo _baseRideRepo;

  ReconnectToRideUseCase(this._baseRideRepo);

  @override
  Future<bool> call(String rideId) => _baseRideRepo.reconnectToRide(rideId);
}
