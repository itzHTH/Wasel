import 'package:flutter/material.dart';
import 'package:wasal/features/ride/ui/widgets/ride_price_card/ride_detail_row.dart';
import 'package:wasel_core/wasel_core.dart';

/// The price panel in the shape it will arrive in. Mirrors RidePriceView's
/// layout rather than reusing it, so no quote is requested to draw a skeleton.
class RidePriceLoading extends StatelessWidget {
  const RidePriceLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeleton(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: AppDimens.space16,
              horizontal: AppDimens.space16,
            ),
            decoration: BoxDecoration(
              color: context.colors.primary100,
              borderRadius: BorderRadius.circular(context.shape.radiusCard),
            ),
            child: Column(
              children: [
                Text('الأجرة التقديرية', style: context.styles.bodySecondary()),
                SizedBox(height: AppDimens.space4),
                Text('١٢٬٥٠٠ د.ع', style: context.styles.display()),
              ],
            ),
          ),
          SizedBox(height: AppDimens.space16),
          const RideDetailRow(label: 'المسافة', value: '٤٫٢ كم'),
          SizedBox(height: AppDimens.space8),
          const RideDetailRow(label: 'المدة', value: '١٥ دقيقة'),
        ],
      ),
    );
  }
}
