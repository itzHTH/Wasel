import 'package:driver/features/ride/data/repos/ride_repo.dart';
import 'package:driver/features/ride/domain/use_case/watch_ride_event_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ride_use_case.g.dart';

@riverpod
WatchRideEventUseCase watchRideEventUseCase(Ref ref) {
  final repo = ref.watch(rideRepoProvider);
  return WatchRideEventUseCase(repo);
}
