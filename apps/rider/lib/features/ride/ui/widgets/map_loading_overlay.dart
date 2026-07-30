import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/map/map_ready_provider.dart';
import 'package:wasel_core/wasel_core.dart';

class MapLoadingOverlay extends ConsumerWidget {
  const MapLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapReady = ref.watch(mapReadyProvider);
    if (mapReady) return const SizedBox.shrink();
    return AppLoadingOverlay();
  }
}
