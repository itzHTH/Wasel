import 'package:flutter/material.dart';
import 'package:wasal/features/ride/ui/widgets/ride_completed/star_rating_bar.dart';
import 'package:wasal/features/ride/ui/widgets/ride_price_card/ride_detail_row.dart';
import 'package:wasel_core/wasel_core.dart';

/// The post-ride screen (pushed on completion): shows the fare and trip summary,
/// collects a 1–5 star rating with an optional comment, and hands both to
/// [onDone]. Pure — the parent owns navigation, submission, and [isSubmitting].
class RideCompletedScreen extends StatefulWidget {
  const RideCompletedScreen({
    super.key,
    required this.fare,
    required this.pickupLabel,
    required this.dropoffLabel,
    required this.onDone,
    this.isSubmitting = false,
  });

  final String fare;
  final String pickupLabel;
  final String dropoffLabel;
  final void Function(int rating, String comment) onDone;
  final bool isSubmitting;

  @override
  State<RideCompletedScreen> createState() => _RideCompletedScreenState();
}

class _RideCompletedScreenState extends State<RideCompletedScreen> {
  final _commentController = TextEditingController();
  int _rating = 0;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.screenBackground,
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
                  decoration: BoxDecoration(
                    color: context.colors.alertSuccess100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: context.colors.alertSuccess500,
                    size: AppDimens.icon24,
                  ),
                ),
              ),
              SizedBox(height: AppDimens.space16),
              Text(
                'وصلت بالسلامة',
                textAlign: TextAlign.center,
                style: context.styles.font24Secondary900Bold,
              ),
              SizedBox(height: AppDimens.space8),
              Text(
                widget.fare,
                textAlign: TextAlign.center,
                style: context.styles.font32Secondary900Bold,
              ),
              SizedBox(height: AppDimens.space32),
              _summaryCard(),
              SizedBox(height: AppDimens.space32),
              Text(
                'شلون كانت رحلتك؟',
                textAlign: TextAlign.center,
                style: context.styles.font20Secondary900Bold,
              ),
              SizedBox(height: AppDimens.space16),
              StarRatingBar(
                onRatingChanged: (value) => setState(() => _rating = value),
              ),
              SizedBox(height: AppDimens.space16),
              _commentField(),
              const Spacer(),
              AppPrimaryButton(
                label: 'تم',
                isLoading: widget.isSubmitting,
                onPressed: () =>
                    widget.onDone(_rating, _commentController.text.trim()),
              ),
              SizedBox(height: AppDimens.space24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _commentField() {
    return TextField(
      controller: _commentController,
      maxLines: 3,
      maxLength: 500,
      textInputAction: TextInputAction.newline,
      style: context.styles.font14Secondary900SemiBold,
      decoration: InputDecoration(
        hintText: 'اكتب ملاحظاتك (اختياري)',
        hintStyle: context.styles.font14Neutral400Regular,
        counterText: '',
        filled: true,
        fillColor: context.colors.elementBackground,
        contentPadding: EdgeInsets.all(AppDimens.space16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _summaryCard() {
    return Container(
      padding: EdgeInsets.all(AppDimens.space16),
      decoration: BoxDecoration(
        color: context.colors.elementBackground,
        borderRadius: BorderRadius.circular(AppDimens.radius16),
      ),
      child: Column(
        children: [
          RideDetailRow(label: 'من', value: widget.pickupLabel),
          SizedBox(height: AppDimens.space12),
          RideDetailRow(label: 'إلى', value: widget.dropoffLabel),
        ],
      ),
    );
  }
}
