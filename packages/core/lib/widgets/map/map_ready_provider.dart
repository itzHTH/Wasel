import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_ready_provider.g.dart';

/// `true` once the map has drawn its first settled frame, so overlays can stop
/// covering it.
@riverpod
class MapReady extends _$MapReady {
  @override
  bool build() => false;

  void markReady() {
    if (!state) state = true;
  }
}
