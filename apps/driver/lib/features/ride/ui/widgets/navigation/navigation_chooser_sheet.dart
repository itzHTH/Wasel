import 'package:driver/features/ride/ui/providers/navigation/navigation_handoff_provider.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class NavigationChooserSheet extends StatelessWidget {
  const NavigationChooserSheet({
    super.key,
    required this.apps,
    required this.onSelect,
  });

  final List<NavigationApp> apps;
  final ValueChanged<NavigationApp> onSelect;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.all(AppDimens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'اختر تطبيق الملاحة',
              style: AppTextStyles.font20Secondary900Bold,
            ),
            SizedBox(height: AppDimens.space16),
            for (final app in apps)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.navigation_outlined,
                  size: AppDimens.icon24,
                  color: AppColor.primary500,
                ),
                title: Text(
                  _labelFor(app),
                  style: AppTextStyles.font14Secondary900SemiBold,
                ),
                onTap: () => onSelect(app),
              ),
          ],
        ),
      ),
    );
  }
}

String _labelFor(NavigationApp app) => switch (app) {
  NavigationApp.waze => 'Waze',
  NavigationApp.googleMaps => 'خرائط جوجل',
  NavigationApp.appleMaps => 'خرائط آبل',
  NavigationApp.web => 'فتح بالمتصفح',
};
