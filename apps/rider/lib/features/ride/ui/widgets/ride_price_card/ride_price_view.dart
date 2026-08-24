import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasal/core/helpers/ride_formatters.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
import 'package:wasal/features/ride/ui/widgets/payment/payment_method_row.dart';
import 'package:wasal/features/ride/ui/widgets/request_ride_card/request_ride_action.dart';
import 'package:wasal/features/ride/ui/widgets/ride_price_card/ride_detail_row.dart';
import 'package:wasel_core/wasel_core.dart';

class RidePriceView extends StatelessWidget {
  const RidePriceView({super.key, required this.price});

  final RidePrice price;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            borderRadius: BorderRadius.circular(AppDimens.radius16),
          ),
          child: Column(
            children: [
              Text(
                context.l10n.estimatedFare,
                style: context.styles.bodySecondary(),
              ),
              SizedBox(height: AppDimens.space4),
              Text(
                RideFormatters.fare(
                  context.l10n,
                  price.estimatedPrice,
                  currency: price.currency,
                ),
                style: context.styles.display(),
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimens.space16),
        RideDetailRow(
          label: context.l10n.distanceLabel,
          value: RideFormatters.distance(context.l10n, price.distanceInKm),
        ),
        SizedBox(height: AppDimens.space12),
        const PaymentMethodRow(),
        SizedBox(height: AppDimens.space24),
        const RequestRideAction(),
      ],
    );
  }
}
