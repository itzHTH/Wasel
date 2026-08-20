import 'package:flutter/material.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';

class AppProfileAvatar extends StatelessWidget {
  const AppProfileAvatar({super.key, this.photoUrl, this.size});

  final String? photoUrl;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final resolvedSize = size ?? AppDimens.icon48;

    final placeholder = Icon(
      Icons.person_rounded,
      color: context.colors.neutral400,
      size: resolvedSize / 2,
    );

    return Container(
      width: resolvedSize,
      height: resolvedSize,
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
