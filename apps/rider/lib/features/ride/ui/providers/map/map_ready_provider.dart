import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_ready_provider.g.dart';

@riverpod
class MapReady extends _$MapReady {
  @override
  bool build() => false;

  void markReady() {
    if (!state) state = true;
  }
}
