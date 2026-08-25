import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasal/features/ride/domain/entities/driver_profile.dart';
import 'package:wasel_core/wasel_core.dart';

class DriverInfoRow extends StatelessWidget {
  const DriverInfoRow({super.key, required this.driver});

  final DriverProfile driver;

  @override
  Widget build(BuildContext context) {
    final vehicle = driver.vehicleLabel;
    final plate = driver.plateNumber;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DriverAvatar(photoUrl: driver.photoUrl),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // The plate sits beside the name while both fit and drops to its
              // own line when they do not — a plate is how the rider finds the
              // car, so it is the one thing here that must never be clipped.
              Wrap(
                spacing: AppDimens.space8,
                runSpacing: AppDimens.space8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    driver.name.isEmpty
                        ? context.l10n.waselDriverName
                        : driver.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.styles.title(),
                  ),
                  if (plate != null && plate.isNotEmpty)
                    _PlateChip(plateNumber: plate),
                ],
              ),
              if (vehicle != null) ...[
                SizedBox(height: AppDimens.space4),
                Text(
                  vehicle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.styles.bodySecondary(),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _DriverAvatar extends StatelessWidget {
  const _DriverAvatar({this.photoUrl});

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final placeholder = Icon(
      Icons.person_rounded,
      color: context.colors.neutral400,
      size: AppDimens.icon24,
    );

    return Container(
      width: AppDimens.icon48,
      height: AppDimens.icon48,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colors.neutral100,
        shape: BoxShape.circle,
      ),
      child: photoUrl == null || photoUrl!.isEmpty
          ? placeholder
          : Image.network(
              photoUrl!,
              fit: BoxFit.cover,

              errorBuilder: (_, _, _) => placeholder,
            ),
    );
  }
}

class _PlateChip extends StatelessWidget {
  const _PlateChip({required this.plateNumber});

  final String plateNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
        vertical: AppDimens.space8,
      ),
      decoration: BoxDecoration(
        color: context.colors.secondary900,
        borderRadius: BorderRadius.circular(AppDimens.radius8),
      ),
      child: Text(
        plateNumber,
        textDirection: TextDirection.ltr,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.styles.bodyLarge(
          weight: FontWeight.w600,
          color: context.colors.onPrimary,
        ),
      ),
    );
  }
}
