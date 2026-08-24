import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/ui/animation/search_radius_motion.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_state.dart';

part 'search_radius_motion_provider.g.dart';

@riverpod
SearchRadiusMotion searchRadiusMotion(Ref ref) {
  final motion = SearchRadiusMotion();
  ref.onDispose(motion.dispose);

  final requestSent = ref.watch(
    requestRideControllerProvider.select((s) => s.value != null),
  );
  final stage = requestSent
      ? ref.watch(rideControllerProvider.select((s) => s.stage))
      : RideStage.idel;

  if (stage == RideStage.searching) {
    motion.start();
  } else {
    motion.stop();
  }

  return motion;
}
