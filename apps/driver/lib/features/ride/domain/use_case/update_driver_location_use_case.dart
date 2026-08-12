import 'package:driver/features/ride/data/models/update_location/update_location_arg.dart';
import 'package:driver/features/ride/domain/repos/ride_repo.dart';
import 'package:wasel_core/usecase/base_use_case.dart';

class UpdateDriverLocationUseCase extends BaseUseCase<void, UpdateLocationArg> {
  final BaseRideRepo _baseRideRepo;

  UpdateDriverLocationUseCase(this._baseRideRepo);

  @override
  Future<void> call(UpdateLocationArg params) {
    return _baseRideRepo.updateLocation(params);
  }
}
