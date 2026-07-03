import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wasel_core/wasel_core.dart';

class CustomPinMap extends StatelessWidget {
  const CustomPinMap({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/pin.svg",
      fit: BoxFit.cover,
      height: AppDimens.icon48,
      width: AppDimens.icon48,
    );
  }
}
