import 'package:camera/camera.dart' show XFile;
import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:wasel_core/helpers/app_validators.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/forms/app_labeled_field.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/upload_card.dart';

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
            context.l10n.photographVehicle,
            style: context.styles.bodyMuted(),
          ),
          SizedBox(height: AppDimens.space24),
          ValueListenableBuilder<XFile?>(
            valueListenable: photo,
            builder: (context, file, _) => UploadCard(
              label: context.l10n.vehiclePhoto,
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
                  label: context.l10n.vehicleModel,
                  hintText: context.l10n.vehicleModelExample,
                  controller: modelCtrl,
                  textInputAction: TextInputAction.next,
                  validator: AppValidators.required,
                ),
                SizedBox(height: AppDimens.space16),
                AppLabeledFormField(
                  label: context.l10n.manufactureYear,
                  hintText: context.l10n.manufactureYearExample,
                  controller: yearCtrl,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: AppValidators.year,
                ),
                SizedBox(height: AppDimens.space16),
                AppLabeledFormField(
                  label: context.l10n.plateNumber,
                  hintText: context.l10n.plateNumberExample,
                  controller: vinCtrl,
                  textInputAction: TextInputAction.done,
                  validator: AppValidators
                      .required, // TODO: make Iraqi Car Plate Vaildation
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
