import 'package:flutter/material.dart';
import 'package:wasel_core/helpers/app_image_picker.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:wasel_core/widgets/app_group_card.dart';
import 'package:wasel_core/widgets/app_menu_tile.dart';

Future<AppImageSource?> showAppImageSourceSheet({
  required BuildContext context,
  String title = 'اختر مصدر الصورة',
  String cameraLabel = 'التقط صورة',
  String galleryLabel = 'اختر من المعرض',
}) {
  return showModalBottomSheet<AppImageSource>(
    context: context,
    backgroundColor: AppColor.screenBackground,
    useSafeArea: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDimens.radius24),
      ),
    ),
    builder: (context) => _AppImageSourceSheet(
      title: title,
      cameraLabel: cameraLabel,
      galleryLabel: galleryLabel,
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
                  color: AppColor.neutral200,
                  borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                ),
              ),
            ),
            SizedBox(height: AppDimens.space24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.font16Secondary900Bold,
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
