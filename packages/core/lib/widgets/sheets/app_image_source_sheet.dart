import 'package:flutter/material.dart';
import 'package:wasel_core/helpers/app_image_picker.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/cards/app_group_card.dart';
import 'package:wasel_core/widgets/cards/app_menu_tile.dart';

Future<AppImageSource?> showAppImageSourceSheet({
  required BuildContext context,
  String? title,
  String? cameraLabel,
  String? galleryLabel,
}) {
  // Read into locals: a nullable parameter does not promote inside the
  // builder closure below.
  final sheetTitle = title ?? context.coreL10n.chooseImageSource;
  final camera = cameraLabel ?? context.coreL10n.takePhoto;
  final gallery = galleryLabel ?? context.coreL10n.chooseFromGallery;

  return showModalBottomSheet<AppImageSource>(
    context: context,
    backgroundColor: context.colors.screenBackground,
    useSafeArea: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.shape.radiusSheet),
      ),
    ),
    builder: (context) => _AppImageSourceSheet(
      title: sheetTitle,
      cameraLabel: camera,
      galleryLabel: gallery,
    ),
  );
}

class _AppImageSourceSheet extends StatelessWidget {
  const _AppImageSourceSheet({
    required this.title,
    required this.cameraLabel,
    required this.galleryLabel,
  });

  final String title;
  final String cameraLabel;
  final String galleryLabel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppDimens.space16,
          AppDimens.space12,
          AppDimens.space16,
          AppDimens.space24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: AppDimens.space40,
                height: AppDimens.space4,
                decoration: BoxDecoration(
                  color: context.colors.neutral200,
                  borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                ),
              ),
            ),
            SizedBox(height: AppDimens.space24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.styles.bodyLarge(weight: FontWeight.w700),
            ),
            SizedBox(height: AppDimens.space16),
            AppGroupCard(
              children: [
                AppMenuTile(
                  icon: Icons.photo_camera_outlined,
                  label: cameraLabel,
                  trailing: const SizedBox.shrink(),
                  onTap: () => Navigator.of(context).pop(AppImageSource.camera),
                ),
                AppMenuTile(
                  icon: Icons.photo_library_outlined,
                  label: galleryLabel,
                  trailing: const SizedBox.shrink(),
                  onTap: () =>
                      Navigator.of(context).pop(AppImageSource.gallery),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
