import 'package:driver/core/helpers/ride_formatters.dart';
import 'package:wasel_location/wasel_location.dart';
import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

class TripPointsList extends StatelessWidget {
  const TripPointsList({super.key, this.pickupPoint, this.dropoffPoint});

  final GeoPoint? pickupPoint;
  final GeoPoint? dropoffPoint;

  @override
  Widget build(BuildContext context) {
    final pickupPoint = this.pickupPoint;
    final dropoffPoint = this.dropoffPoint;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Rail(hasPickup: pickupPoint != null, hasDropoff: dropoffPoint != null),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (pickupPoint != null)
                _Point(title: context.l10n.pickupPoint, point: pickupPoint),
              if (pickupPoint != null && dropoffPoint != null)
                SizedBox(height: AppDimens.space24),
              if (dropoffPoint != null)
                _Point(title: context.l10n.dropoffPoint, point: dropoffPoint),
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
              color: context.colors.primary500,
            ),
          if (hasPickup && hasDropoff) const _Connector(),
          if (hasDropoff)
            Icon(
              Icons.circle,
              size: AppDimens.icon18,
              color: context.colors.secondary900,
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
        color: context.colors.neutral200,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
    );
  }
}

/// Reads its own address so a lookup landing repaints one line of the card.
/// Coordinates stand in whenever Google has no name for the spot.
class _Point extends ConsumerWidget {
  const _Point({required this.title, required this.point});

  final String title;
  final GeoPoint point;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = ref.watch(pointLabelProvider(point));
    final fallback = RideFormatters.coordinates(
      context.l10n,
      point.latitude,
      point.longitude,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.styles.caption(color: context.colors.neutral400),
        ),
        label.when(
          loading: () => Align(
            alignment: AlignmentDirectional.centerStart,
            child: AppInlineLoading(size: AppDimens.icon18),
          ),
          error: (_, _) => _LabelText(fallback),
          data: (value) => _LabelText(value.isEmpty ? fallback : value),
        ),
      ],
    );
  }
}

class _LabelText extends StatelessWidget {
  const _LabelText(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: context.styles.body(weight: FontWeight.w600),
    );
  }
}
