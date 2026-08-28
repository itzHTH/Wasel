import 'package:driver/features/ride/data/models/foreground/foreground_notification_arg.dart';
import 'package:driver/features/ride/domain/repo/base_driver_foreground_repo.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/base_use_case.dart';

class StartForegroundServiceUseCase
    extends BaseUseCase<ApiResults<void>, ForegroundNotificationArg> {
  final BaseDriverForegroundRepo _baseDriverForegroundRepo;

  StartForegroundServiceUseCase(this._baseDriverForegroundRepo);

  @override
  Future<ApiResults<void>> call(ForegroundNotificationArg params) =>
      _baseDriverForegroundRepo.startService(params);
}
