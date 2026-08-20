import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasel_core/wasel_core.dart';

class RideCardTitle extends ConsumerWidget {
  const RideCardTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(rideDraftProvider.select((s) => s.cardTitle));
    return Text(title, style: context.styles.font20Secondary900Bold);
  }
}
