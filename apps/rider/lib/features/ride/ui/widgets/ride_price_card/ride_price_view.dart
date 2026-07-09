import 'package:flutter/material.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
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
        RideDetailRow(label: 'السعر', value: '${price.estimatedPrice} د.ع'),
        SizedBox(height: AppDimens.space8),
        RideDetailRow(label: 'المسافة', value: '${price.distanceInKm} كم'),
        SizedBox(height: AppDimens.space24),
        const RequestRideAction(),
      ],
    );
  }
}
