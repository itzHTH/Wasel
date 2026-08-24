import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_state.dart';
import 'package:wasel_core/wasel_core.dart';

class RideCardTitle extends ConsumerWidget {
  const RideCardTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stage = ref.watch(rideDraftProvider.select((s) => s.stage));
    final title = stage.cardTitle(context.l10n);
    return Text(title, style: context.styles.title());
  }
}
