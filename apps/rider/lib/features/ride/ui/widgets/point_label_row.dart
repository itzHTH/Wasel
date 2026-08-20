import 'package:flutter/material.dart';
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
      point.latitude,
      point.longitude,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$prefix: ', style: context.styles.font14Secondary500Medium),
        Expanded(
          child: label.when(
            loading: () => Align(
              alignment: AlignmentDirectional.centerStart,
              child: AppInlineLoading(size: AppDimens.icon18),
            ),
            error: (_, _) => _LabelText(fallback),
            data: (value) => _LabelText(value.isEmpty ? fallback : value),
          ),
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
      style: context.styles.font14Secondary900SemiBold,
    );
  }
}
