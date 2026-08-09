import 'package:driver/features/ride/domain/entities/rider_profile.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class RiderInfoRow extends StatelessWidget {
  const RiderInfoRow({super.key, required this.profile, this.onCall});

  final RiderProfile profile;
  final VoidCallback? onCall;

  @override
  Widget build(BuildContext context) {
    final onCall = this.onCall;
    final rating = profile.rating;

    return Row(
      children: [
        const _Avatar(),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      profile.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font14Secondary900SemiBold,
                    ),
                  ),
                  if (profile.isPlaceholder) ...[
                    SizedBox(width: AppDimens.space8),
                    const _PlaceholderTag(),
                  ],
                ],
              ),
              if (rating != null) _Rating(rating: rating),
            ],
          ),
        ),
        if (onCall != null) _CallButton(onCall: onCall),
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
      decoration: const BoxDecoration(
        color: AppColor.neutral100,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person_outline,
        size: AppDimens.icon24,
        color: AppColor.neutral400,
      ),
    );
  }
}

/// Marks the row as fed by placeholder data until the rider-profile endpoint
/// exists, so the static name is never mistaken for a real one.
class _PlaceholderTag extends StatelessWidget {
  const _PlaceholderTag();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space8,
        vertical: AppDimens.space4,
      ),
      decoration: BoxDecoration(
        color: AppColor.alertWarning100,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
      child: Text(
        'تجريبي',
        style: AppTextStyles.font12Neutral400Regular.copyWith(
          color: AppColor.alertWarning500,
        ),
      ),
    );
  }
}

class _Rating extends StatelessWidget {
  const _Rating({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star_rounded,
          size: AppDimens.icon18,
          color: AppColor.alertWarning500,
        ),
        SizedBox(width: AppDimens.space4),
        Text(
          rating.toStringAsFixed(1),
          style: AppTextStyles.font14Neutral400Medium,
        ),
      ],
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
        backgroundColor: AppColor.primary100,
        shape: const CircleBorder(),
      ),
      icon: Icon(
        Icons.call_outlined,
        size: AppDimens.icon20,
        color: AppColor.primary500,
      ),
    );
  }
}
