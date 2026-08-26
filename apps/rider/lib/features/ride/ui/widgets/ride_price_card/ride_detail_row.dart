import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class RideDetailRow extends StatelessWidget {
  const RideDetailRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.styles.bodySecondary(),
          ),
        ),
        SizedBox(width: AppDimens.space8),
        // Outweighs the label because the figure is what the row exists for.
        Flexible(
          flex: 2,
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: context.styles.body(weight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
