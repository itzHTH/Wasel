import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class RidePriceLoading extends StatelessWidget {
  const RidePriceLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimens.space24),
      child: const Center(child: AppInlineLoading()),
    );
  }
}
