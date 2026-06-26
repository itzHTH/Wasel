import 'package:camera/camera.dart' show XFile;
import 'package:flutter/foundation.dart';

@immutable
class VerificationSubmission {
  final XFile licenseFront;
  final XFile licenseBack;
  final XFile vehiclePhoto;
  final XFile selfie;
  final String vehicleModel;
  final String vehicleYear;
  final String vin;

  const VerificationSubmission({
    required this.licenseFront,
    required this.licenseBack,
    required this.vehiclePhoto,
    required this.selfie,
    required this.vehicleModel,
    required this.vehicleYear,
    required this.vin,
  });
}
