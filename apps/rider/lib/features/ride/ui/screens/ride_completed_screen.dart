import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
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
                child: RideStageBadge(
                  stage: RideStageVisual.completed,
                  size: AppDimens.icon48,
                ),
              ),
              SizedBox(height: AppDimens.space16),
              Text(
                context.l10n.arrivedSafely,
                textAlign: TextAlign.center,
                style: context.styles.headline(),
              ),
              SizedBox(height: AppDimens.space8),
              Text(
                widget.fare,
                textAlign: TextAlign.center,
                style: context.styles.display(),
              ),
              SizedBox(height: AppDimens.space32),
              _summaryCard(),
              SizedBox(height: AppDimens.space32),
              Text(
                context.l10n.howWasYourRide,
                textAlign: TextAlign.center,
                style: context.styles.title(),
              ),
              SizedBox(height: AppDimens.space16),
              StarRatingBar(
                onRatingChanged: (value) => setState(() => _rating = value),
              ),
              SizedBox(height: AppDimens.space16),
              _commentField(),
              const Spacer(),
              AppPrimaryButton(
                label: context.coreL10n.done,
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
      style: context.styles.body(weight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: context.l10n.writeNotesOptional,
        hintStyle: context.styles.bodyMuted(),
        counterText: '',
        filled: true,
        fillColor: context.colors.elementBackground,
        contentPadding: EdgeInsets.all(AppDimens.space16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.shape.radiusCard),
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
        borderRadius: BorderRadius.circular(context.shape.radiusCard),
      ),
      child: Column(
        children: [
          RideDetailRow(
            label: context.l10n.fromLabel,
            value: widget.pickupLabel,
          ),
          SizedBox(height: AppDimens.space12),
          RideDetailRow(
            label: context.l10n.toLabel,
            value: widget.dropoffLabel,
          ),
        ],
      ),
    );
  }
}
