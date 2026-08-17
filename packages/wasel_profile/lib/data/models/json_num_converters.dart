import 'package:wasel_profile/domain/entities/driver_approval_status.dart';

double doubleFromJson(Object? value) => switch (value) {
  num n => n.toDouble(),
  String s => double.tryParse(s) ?? 0,
  _ => 0,
};

int intFromJson(Object? value) => switch (value) {
  num n => n.toInt(),
  String s => int.tryParse(s) ?? 0,
  _ => 0,
};

DriverApprovalStatus driverApprovalStatusFromJson(Object? value) =>
    DriverApprovalStatus.fromCode(intFromJson(value));

int driverApprovalStatusToJson(DriverApprovalStatus status) => status.code;
