import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasel_core/wasel_core.dart';

class RideSummaryText extends ConsumerWidget {
  const RideSummaryText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(rideDraftProvider.select((s) => s.summaryText));
    if (summary.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(top: AppDimens.space8),
      child: Text(summary, style: AppTextStyles.font14Secondary500Medium),
    );
  }
}
