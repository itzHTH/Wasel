import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/widgets/map/map_ready_provider.dart';
import 'package:wasel_core/widgets/app_loading.dart';

/// Covers the map until it has drawn its first settled frame, so the user never
/// sees the blank tile grid.
class AppMapLoadingOverlay extends ConsumerWidget {
  const AppMapLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapReady = ref.watch(mapReadyProvider);
    if (mapReady) return const SizedBox.shrink();
    return const AppLoadingOverlay();
  }
}
