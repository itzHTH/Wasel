import 'package:driver/features/ride/ui/providers/location/device_location_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasel_location/core/const/app_map_defaults.dart';

part 'initial_camera_target_provider.g.dart';

@Riverpod(keepAlive: true)
Future<LatLng> initialCameraTarget(Ref ref) async {
  final cached = await ref.watch(lastKnownLocationProvider.future);

  // No cached fix — the service centre is a fine opener.
  return cached ?? AppMapDefaults.initialTarget;
}
