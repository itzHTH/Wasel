import 'package:flutter/material.dart';
import 'package:wasal/features/ride/ui/widgets/request_ride_card/request_confirm_button.dart';
import 'package:wasel_core/wasel_core.dart';

class RequestRideErrorView extends StatelessWidget {
  const RequestRideErrorView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.font14alertError500SemiBold,
        ),
        SizedBox(height: AppDimens.space16),
        const RequestConfirmButton(),
      ],
    );
  }
}
