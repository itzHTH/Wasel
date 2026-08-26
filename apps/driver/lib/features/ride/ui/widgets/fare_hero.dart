import 'package:driver/core/helpers/ride_formatters.dart';
import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
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
      RideFormatters.fare(context.l10n, amount.toString(), currency: currency),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: color == null
          ? context.styles.display()
          : context.styles.display().copyWith(color: color),
    );
  }
}
