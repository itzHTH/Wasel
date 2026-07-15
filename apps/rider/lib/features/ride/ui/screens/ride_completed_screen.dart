import 'package:flutter/material.dart';
import 'package:wasal/core/widgets/app_primary_button.dart';
import 'package:wasal/features/ride/ui/widgets/ride_completed/star_rating_bar.dart';
import 'package:wasal/features/ride/ui/widgets/ride_price_card/ride_detail_row.dart';
import 'package:wasel_core/wasel_core.dart';

/// The post-ride screen (pushed on completion): shows the fare and trip summary,
/// collects a 1–5 star rating, and confirms via [onDone]. Pure — the parent owns
/// navigation and submitting the rating.
class RideCompletedScreen extends StatelessWidget {
  const RideCompletedScreen({
    super.key,
    required this.fare,
    required this.pickupLabel,
    required this.dropoffLabel,
    required this.onRatingChanged,
    required this.onDone,
  });

  final String fare;
  final String pickupLabel;
  final String dropoffLabel;
  final ValueChanged<int> onRatingChanged;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.screenBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: AppDimens.space40),
              Center(
                child: Container(
                  width: AppDimens.icon48,
                  height: AppDimens.icon48,
                  decoration: const BoxDecoration(
                    color: AppColor.alertSuccess100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: AppColor.alertSuccess500,
                    size: AppDimens.icon24,
                  ),
                ),
              ),
              SizedBox(height: AppDimens.space16),
              Text(
                'وصلت بالسلامة',
                textAlign: TextAlign.center,
                style: AppTextStyles.font24Secondary900Bold,
              ),
              SizedBox(height: AppDimens.space8),
              Text(
                fare,
                textAlign: TextAlign.center,
                style: AppTextStyles.font32Secondary900Bold,
              ),
              SizedBox(height: AppDimens.space32),
              _summaryCard(),
              SizedBox(height: AppDimens.space32),
              Text(
                'شلون كانت رحلتك؟',
                textAlign: TextAlign.center,
                style: AppTextStyles.font20Secondary900Bold,
              ),
              SizedBox(height: AppDimens.space16),
              StarRatingBar(onRatingChanged: onRatingChanged),
              const Spacer(),
              AppPrimaryButton(label: 'تم', onPressed: onDone),
              SizedBox(height: AppDimens.space24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryCard() {
    return Container(
      padding: EdgeInsets.all(AppDimens.space16),
      decoration: BoxDecoration(
        color: AppColor.elementBackground,
        borderRadius: BorderRadius.circular(AppDimens.radius16),
      ),
      child: Column(
        children: [
          RideDetailRow(label: 'من', value: pickupLabel),
          SizedBox(height: AppDimens.space12),
          RideDetailRow(label: 'إلى', value: dropoffLabel),
        ],
      ),
    );
  }
}
