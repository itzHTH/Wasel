import 'package:flutter/material.dart';
import 'package:wasel_core/helpers/app_amount_format.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

class RideHistoryAmount extends StatelessWidget {
  const RideHistoryAmount({super.key, required this.price, this.style});

  final double price;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      formatAmountWithCurrency(price),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: style ?? context.styles.font16Secondary900Bold,
    );
  }
}
