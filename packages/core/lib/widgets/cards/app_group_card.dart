import 'package:flutter/material.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/cards/app_menu_tile.dart';
import 'package:wasel_core/widgets/cards/app_surface_card.dart';

class AppGroupCard extends StatelessWidget {
  const AppGroupCard({super.key, required this.children, this.dividerIndent});

  final List<Widget> children;
  final double? dividerIndent;

  @override
  Widget build(BuildContext context) {
    final indent = dividerIndent ?? AppMenuTile.leadingExtent;

    final rows = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) {
        rows.add(
          Padding(
            padding: EdgeInsetsDirectional.only(start: indent),
            child: Divider(
              height: 1,
              thickness: 1,
              color: context.colors.neutral200,
            ),
          ),
        );
      }
      rows.add(children[i]);
    }

    return AppSurfaceCard(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      borderRadius: AppDimens.radius16,
      child: Column(mainAxisSize: MainAxisSize.min, children: rows),
    );
  }
}
