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
        Text(
          label,
          style: context.styles.body(
            weight: FontWeight.w500,
            color: context.colors.secondary500,
          ),
        ),
        Text(value, style: context.styles.body(weight: FontWeight.w600)),
      ],
    );
  }
}
