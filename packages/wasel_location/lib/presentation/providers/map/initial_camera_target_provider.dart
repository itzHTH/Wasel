import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/widgets/map/app_map.dart';
import 'package:wasel_location/core/extensions/geo_point_map_x.dart';
import 'package:wasel_location/presentation/providers/location/last_known_location_provider.dart';

part 'initial_camera_target_provider.g.dart';

/// Determines the initial camera position for the map upon app launch.
//
//? - Checks the OS location cache first (via [lastKnownLocationProvider]).
//
//? - Falls back seamlessly to the default service area (e.g., Baghdad center)
//?   if the cache is empty or permission is denied.
//
//? - Never fails: guarantees the map always opens on a valid [LatLng] target
//?   without displaying error states to the user.
//
//? - Kept alive (`keepAlive: true`) to match its dependency and prevent
//?  loading flickers on map remounts.
@Riverpod(keepAlive: true)
Future<LatLng> initialCameraTarget(Ref ref) async {
  final cached = await ref.watch(lastKnownLocationProvider.future);

  return cached?.toLatLng() ?? AppMapDefaults.initialTarget;
}
