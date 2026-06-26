import 'package:driver/features/driver_verification/domain/entities/verification_status.dart';
import 'package:wasel_core/wasel_core.dart';

abstract class BaseVerifyRepo {
  Future<ApiResults<VerificationStatus>> getVerificationStatus();
}
