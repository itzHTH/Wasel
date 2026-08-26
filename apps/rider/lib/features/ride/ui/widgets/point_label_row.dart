import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/helpers/ride_formatters.dart';
import 'package:wasel_location/wasel_location.dart';
import 'package:wasel_core/wasel_core.dart';

class PointLabelRow extends ConsumerWidget {
  const PointLabelRow({super.key, required this.prefix, required this.point});

  final String prefix;
  final LatLng point;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = ref.watch(
      pointLabelProvider(
        GeoPoint(latitude: point.latitude, longitude: point.longitude),
      ),
    );
    final fallback = RideFormatters.coordinates(
      context.l10n,
      point.latitude,
      point.longitude,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$prefix: ', style: context.styles.bodySecondary()),
        Expanded(
          child: label.when(
            loading: () =>
                const AppSkeleton(child: _LabelText(_placeholderLabel)),
            error: (_, _) => _LabelText(fallback),
            data: (value) => _LabelText(value.isEmpty ? fallback : value),
          ),
        ),
      ],
    );
  }
}

/// Stand-in address the skeleton lays out while the real one resolves.
const _placeholderLabel = 'شارع المعلمين، حي الحمداني';

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
