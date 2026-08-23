import 'package:driver/features/ride/domain/entities/rider_profile.dart';
import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:wasel_core/wasel_core.dart';

class RiderInfoRow extends StatelessWidget {
  const RiderInfoRow({
    super.key,
    required this.profile,
    this.onCall,
    this.canCall = true,
  });

  final RiderProfile profile;
  final bool canCall;

  /// Overrides the default hand-off to the dialer. The call button is hidden
  /// when there is neither an override nor a phone number on the profile.
  final VoidCallback? onCall;

  @override
  Widget build(BuildContext context) {
    final phoneNumber = profile.phoneNumber;
    final onCall =
        this.onCall ??
        (phoneNumber == null ? null : () => AppUrlLauncher.dial(phoneNumber));

    return Row(
      children: [
        const _Avatar(),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.styles.font14Secondary900SemiBold,
              ),
              SizedBox(height: AppDimens.space4),
              if (canCall)
                Text(
                  phoneNumber ?? context.l10n.phoneUnavailable,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.styles.font14Neutral400Medium,
                ),
            ],
          ),
        ),
        if (onCall != null && canCall) _CallButton(onCall: onCall),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimens.icon48,
      height: AppDimens.icon48,
      decoration: BoxDecoration(
        color: context.colors.neutral100,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person_outline,
        size: AppDimens.icon24,
        color: context.colors.neutral400,
      ),
    );
  }
}

class _CallButton extends StatelessWidget {
  const _CallButton({required this.onCall});

  final VoidCallback onCall;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onCall,
      style: IconButton.styleFrom(
        backgroundColor: context.colors.primary100,
        shape: const CircleBorder(),
      ),
      icon: Icon(
        Icons.call_outlined,
        size: AppDimens.icon20,
        color: context.colors.primary500,
      ),
    );
  }
}
