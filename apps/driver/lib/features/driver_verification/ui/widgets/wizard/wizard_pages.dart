import 'package:camera/camera.dart' show XFile;
import 'package:flutter/material.dart';
import 'package:driver/features/driver_verification/ui/utils/verification_capture.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/steps/license_step.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/steps/selfie_step.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/steps/vehicle_step.dart';

class WizardPages extends StatelessWidget {
  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  final ValueNotifier<XFile?> licenseFront;
  final ValueNotifier<XFile?> licenseBack;
  final ValueNotifier<XFile?> vehiclePhoto;
  final ValueNotifier<XFile?> selfie;

  final GlobalKey<FormState> vehicleFormKey;
  final TextEditingController modelCtrl;
  final TextEditingController yearCtrl;
  final TextEditingController vinCtrl;

  const WizardPages({
    super.key,
    required this.pageController,
    required this.onPageChanged,
    required this.licenseFront,
    required this.licenseBack,
    required this.vehiclePhoto,
    required this.selfie,
    required this.vehicleFormKey,
    required this.modelCtrl,
    required this.yearCtrl,
    required this.vinCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: onPageChanged,
      children: [
        LicenseStep(
          front: licenseFront,
          back: licenseBack,
          onTapFront: () => captureInto(context, licenseFront, captureLicense),
          onTapBack: () => captureInto(context, licenseBack, captureLicense),
        ),
        VehicleStep(
          photo: vehiclePhoto,
          onTapPhoto: () => captureInto(context, vehiclePhoto, captureVehicle),
          formKey: vehicleFormKey,
          modelCtrl: modelCtrl,
          yearCtrl: yearCtrl,
          vinCtrl: vinCtrl,
        ),
        SelfieStep(
          selfie: selfie,
          onTap: () => captureInto(context, selfie, captureSelfie),
        ),
      ],
    );
  }
}
