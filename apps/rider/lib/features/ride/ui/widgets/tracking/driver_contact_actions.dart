import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class DriverContactActions extends StatelessWidget {
  const DriverContactActions({
    super.key,
    required this.onCall,
    required this.onMessage,
  });

  final VoidCallback onCall;
  final VoidCallback onMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ContactButton(
            icon: Icons.phone_rounded,
            label: 'اتصال',
            onPressed: onCall,
            filled: true,
          ),
        ),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: _ContactButton(
            icon: Icons.chat_bubble_rounded,
            label: 'رسالة',
            onPressed: onMessage,
            filled: false,
          ),
        ),
      ],
    );
  }
}

class _ContactButton extends StatelessWidget {
  const _ContactButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.filled,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final foreground = filled ? AppColor.neutral0 : AppColor.primary500;

    return Material(
      color: filled ? AppColor.primary500 : AppColor.primary100,
      borderRadius: BorderRadius.circular(AppDimens.radius12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppDimens.radius12),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppDimens.space12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: foreground, size: AppDimens.icon20),
              SizedBox(width: AppDimens.space8),
              Text(
                label,
                style: filled
                    ? AppTextStyles.font16Neutral0SemiBold
                    : AppTextStyles.font14Primary500SemiBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
