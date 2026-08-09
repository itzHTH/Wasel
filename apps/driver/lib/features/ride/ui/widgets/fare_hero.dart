import 'package:driver/core/helpers/ride_formatters.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class FareHero extends StatelessWidget {
  const FareHero({
    super.key,
    required this.amount,
    this.currency = 'IQD',
    this.color,
  });

  final num amount;
  final String currency;

  /// Overrides the default ink — the completed card renders the fare green.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      RideFormatters.fare(amount.toString(), currency: currency),
      style: color == null
          ? AppTextStyles.font32Secondary900Bold
          : AppTextStyles.font32Secondary900Bold.copyWith(color: color),
    );
  }
}
