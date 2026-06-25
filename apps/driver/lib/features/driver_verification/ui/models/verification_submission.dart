import 'package:camera/camera.dart' show XFile;
import 'package:flutter/foundation.dart';

/// UI-only payload carried from the wizard into the uploading screen.
///
/// Holds the in-memory captures + vehicle fields for the whole session so a
/// failed upload can be retried **without re-capturing**. This is a presentation
/// DTO — it is replaced by the domain submit request when the provider/use-case
/// layer lands (see the `// TODO(provider)` seams).
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
