import 'package:wasel_core/networking/json_num_converters.dart';
import 'package:wasel_profile/domain/entities/driver_approval_status.dart';
export 'package:wasel_core/networking/json_num_converters.dart';

DriverApprovalStatus driverApprovalStatusFromJson(Object? value) =>
    DriverApprovalStatus.fromCode(intFromJson(value));

int driverApprovalStatusToJson(DriverApprovalStatus status) => status.code;
