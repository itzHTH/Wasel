import 'package:cross_file/cross_file.dart' show XFile;

class DriverProfileSubmission {
  final XFile licenseFront;
  final XFile licenseBack;
  final XFile selfie;
  final XFile vehicleImage;
  final String vehicleModel;
  final String vehicleYear;
  final String vinNumber;

  const DriverProfileSubmission({
    required this.licenseFront,
    required this.licenseBack,
    required this.selfie,
    required this.vehicleImage,
    required this.vehicleModel,
    required this.vehicleYear,
    required this.vinNumber,
  });
}
