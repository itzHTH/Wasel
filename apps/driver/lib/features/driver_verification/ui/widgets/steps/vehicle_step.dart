import 'package:camera/camera.dart' show XFile;
import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_core/widgets/app_labeled_field.dart';
import 'package:driver/features/driver_verification/ui/widgets/upload_card.dart';

/// Wizard step 2 — vehicle: a photo slot plus model / year / VIN fields.
class VehicleStep extends StatelessWidget {
  final ValueListenable<XFile?> photo;
  final VoidCallback onTapPhoto;
  final GlobalKey<FormState> formKey;
  final TextEditingController modelCtrl;
  final TextEditingController yearCtrl;
  final TextEditingController vinCtrl;

  const VehicleStep({
    super.key,
    required this.photo,
    required this.onTapPhoto,
    required this.formKey,
    required this.modelCtrl,
    required this.yearCtrl,
    required this.vinCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppDimens.space24),
          Text(
            'صوّر مركبتك وأدخل بياناتها.',
            style: AppTextStyles.font14Neutral400Regular,
          ),
          SizedBox(height: AppDimens.space24),
          ValueListenableBuilder<XFile?>(
            valueListenable: photo,
            builder: (context, file, _) => UploadCard(
              label: 'صورة المركبة',
              icon: Icons.directions_car_outlined,
              file: file,
              onTap: onTapPhoto,
            ),
          ),
          SizedBox(height: AppDimens.space24),
          Form(
            key: formKey,
            child: Column(
              children: [
                AppLabeledFormField(
                  label: 'موديل المركبة',
                  hintText: 'مثال: Toyota Corolla',
                  controller: modelCtrl,
                  textInputAction: TextInputAction.next,
                  validator: _validateModel,
                ),
                SizedBox(height: AppDimens.space16),
                AppLabeledFormField(
                  label: 'سنة الصنع',
                  hintText: 'مثال: 2020',
                  controller: yearCtrl,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: _validateYear,
                ),
                SizedBox(height: AppDimens.space16),
                AppLabeledFormField(
                  label: 'رقم الهيكل (VIN)',
                  hintText: '17 خانة',
                  controller: vinCtrl,
                  textInputAction: TextInputAction.done,
                  validator: _validateVin,
                ),
              ],
            ),
          ),
          SizedBox(height: AppDimens.space24),
        ],
      ),
    );
  }
}

// ── Field validators (feature-local; English messages mirror AppValidators) ──

String? _validateModel(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Vehicle model is required';
  }
  return null;
}

String? _validateYear(String? value) {
  if (value == null || value.isEmpty) {
    return 'Year is required';
  }
  if (!RegExp(r'^\d{4}$').hasMatch(value)) {
    return 'Enter a 4-digit year';
  }
  final year = int.parse(value);
  final maxYear = DateTime.now().year + 1;
  if (year < 1950 || year > maxYear) {
    return 'Enter a valid year (1950–$maxYear)';
  }
  return null;
}

String? _validateVin(String? value) {
  if (value == null || value.isEmpty) {
    return 'VIN is required';
  }
  final vin = value.toUpperCase();
  // 17 chars, alphanumeric excluding I, O, Q (per VIN standard).
  if (!RegExp(r'^[A-HJ-NPR-Z0-9]{17}$').hasMatch(vin)) {
    return 'VIN must be 17 characters (letters/numbers, no I, O, Q)';
  }
  return null;
}
