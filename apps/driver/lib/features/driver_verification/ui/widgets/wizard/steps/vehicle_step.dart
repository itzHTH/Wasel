import 'package:camera/camera.dart' show XFile;
import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:wasel_core/helpers/app_validators.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_core/widgets/app_labeled_field.dart';
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
                  validator: AppValidators.required,
                ),
                SizedBox(height: AppDimens.space16),
                AppLabeledFormField(
                  label: 'سنة الصنع',
                  hintText: 'مثال: 2020',
                  controller: yearCtrl,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: AppValidators.year,
                ),
                SizedBox(height: AppDimens.space16),
                AppLabeledFormField(
                  label: 'رقم اللوحه',
                  hintText: '234244 C / 342134 ب',
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
