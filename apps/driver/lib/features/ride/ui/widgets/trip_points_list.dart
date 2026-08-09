import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class TripPointsList extends StatelessWidget {
  const TripPointsList({super.key, this.pickupLabel, this.dropoffLabel});

  final String? pickupLabel;
  final String? dropoffLabel;

  @override
  Widget build(BuildContext context) {
    final pickupLabel = this.pickupLabel;
    final dropoffLabel = this.dropoffLabel;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Rail(
          hasPickup: pickupLabel != null,
          hasDropoff: dropoffLabel != null,
        ),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (pickupLabel != null)
                _Point(title: 'نقطة الانطلاق', value: pickupLabel),
              if (pickupLabel != null && dropoffLabel != null)
                SizedBox(height: AppDimens.space24),
              if (dropoffLabel != null)
                _Point(title: 'نقطة الوصول', value: dropoffLabel),
            ],
          ),
        ),
      ],
    );
  }
}

/// The bullets and the connector between them, kept in their own column so
/// the labels beside them stay free to wrap.
class _Rail extends StatelessWidget {
  const _Rail({required this.hasPickup, required this.hasDropoff});

  final bool hasPickup;
  final bool hasDropoff;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppDimens.space4),
      child: Column(
        children: [
          if (hasPickup)
            Icon(
              Icons.circle,
              size: AppDimens.icon18,
              color: AppColor.primary500,
            ),
          if (hasPickup && hasDropoff) const _Connector(),
          if (hasDropoff)
            Icon(
              Icons.circle,
              size: AppDimens.icon18,
              color: AppColor.alertSuccess500,
            ),
        ],
      ),
    );
  }
}

class _Connector extends StatelessWidget {
  const _Connector();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimens.space4,
      height: AppDimens.space32,
      margin: EdgeInsets.symmetric(vertical: AppDimens.space4),
      decoration: BoxDecoration(
        color: AppColor.neutral200,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
    );
  }
}

class _Point extends StatelessWidget {
  const _Point({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.font12Neutral400Regular),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.font14Secondary900SemiBold,
        ),
      ],
    );
  }
}
