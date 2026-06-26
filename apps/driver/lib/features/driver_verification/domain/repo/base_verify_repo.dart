import 'package:driver/features/driver_verification/domain/entities/approval_status.dart';
import 'package:wasel_core/wasel_core.dart';

abstract class BaseVerifyRepo {
  ApiResults<ApprovalStatus> getVerificationStatus();
}
