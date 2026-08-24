import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:driver/l10n/l10n_extension.dart';

enum CaptureSource { camera, gallery }

Future<CaptureSource?> showCaptureSourceSheet({required BuildContext context}) {
  return showModalBottomSheet<CaptureSource>(
    context: context,
    backgroundColor: context.colors.neutral0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDimens.radius24),
      ),
    ),
    builder: (context) => const _CaptureSourceSheet(),
  );
}

class _CaptureSourceSheet extends StatelessWidget {
  const _CaptureSourceSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppDimens.screenHPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.coreL10n.chooseImageSource,
              textAlign: TextAlign.center,
              style: context.styles.title(),
            ),
            SizedBox(height: AppDimens.space24),
            _SourceTile(
              icon: Icons.photo_camera_outlined,
              label: context.l10n.captureWithCamera,
              onTap: () => Navigator.of(context).pop(CaptureSource.camera),
            ),
            SizedBox(height: AppDimens.space12),
            _SourceTile(
              icon: Icons.photo_library_outlined,
              label: context.l10n.chooseFromGalleryDriver,
              onTap: () => Navigator.of(context).pop(CaptureSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SourceTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radius16),
      child: Container(
        padding: EdgeInsets.all(AppDimens.space16),
        decoration: BoxDecoration(
          color: context.colors.neutral50,
          borderRadius: BorderRadius.circular(AppDimens.radius16),
          border: Border.all(color: context.colors.neutral200),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: AppDimens.icon24,
              color: context.colors.primary500,
            ),
            SizedBox(width: AppDimens.space16),
            Text(
              label,
              style: context.styles.bodyLarge(
                color: context.colors.secondary500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
