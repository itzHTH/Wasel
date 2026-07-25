import 'package:flutter/material.dart';
import 'package:wasal/core/helpers/ride_formatters.dart';
import 'package:wasal/features/ride/domain/entities/ride_price.dart';
import 'package:wasel_core/wasel_core.dart';

class RideTripSummary extends StatelessWidget {
  const RideTripSummary({
    super.key,
    this.pickupLabel,
    this.dropoffLabel,
    this.price,
  });

  final String? pickupLabel;
  final String? dropoffLabel;
  final RidePrice? price;

  @override
  Widget build(BuildContext context) {
    final pickup = pickupLabel;
    final dropoff = dropoffLabel;
    final fare = price;

    final hasRoute =
        (pickup != null && pickup.isNotEmpty) ||
        (dropoff != null && dropoff.isNotEmpty);
    if (!hasRoute && fare == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(AppDimens.space16),
      decoration: BoxDecoration(
        color: AppColor.neutral50,
        borderRadius: BorderRadius.circular(AppDimens.radius16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (pickup != null && pickup.isNotEmpty)
            _RoutePoint(
              label: pickup,
              color: AppColor.primary500,

              showConnector: dropoff != null && dropoff.isNotEmpty,
            ),
          if (dropoff != null && dropoff.isNotEmpty)
            _RoutePoint(
              label: dropoff,
              color: AppColor.alertError500,
              showConnector: false,
            ),
          if (fare != null) ...[
            if (hasRoute) ...[
              SizedBox(height: AppDimens.space12),
              Divider(height: 1, color: AppColor.neutral200),
              SizedBox(height: AppDimens.space12),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الأجرة التقديرية',
                  style: AppTextStyles.font14Secondary500Medium,
                ),
                Text(
                  RideFormatters.fare(
                    fare.estimatedPrice,
                    currency: fare.currency,
                  ),
                  style: AppTextStyles.font20Secondary900Bold,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _RoutePoint extends StatelessWidget {
  const _RoutePoint({
    required this.label,
    required this.color,
    required this.showConnector,
  });

  final String label;
  final Color color;
  final bool showConnector;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: AppDimens.space12,
                height: AppDimens.space12,
                margin: EdgeInsets.only(top: AppDimens.space4),
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              if (showConnector)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: EdgeInsets.symmetric(vertical: AppDimens.space4),
                    color: AppColor.neutral200,
                  ),
                ),
            ],
          ),
          SizedBox(width: AppDimens.space12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: showConnector ? AppDimens.space12 : 0,
              ),
              child: Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font14Secondary900SemiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
