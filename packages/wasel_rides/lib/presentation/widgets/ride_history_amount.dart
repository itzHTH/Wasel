import 'package:flutter/material.dart';
import 'package:wasel_core/helpers/app_amount_format.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

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
      style: style ?? AppTextStyles.font16Secondary900Bold,
    );
  }
}
