import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_controller_provider.g.dart';

@Riverpod(keepAlive: true)
class MapControllerHolder extends _$MapControllerHolder {
  final _pending = Completer<GoogleMapController>();

  @override
  Future<GoogleMapController> build() => _pending.future;

  void attach(GoogleMapController controller) {
    if (!_pending.isCompleted) _pending.complete(controller);

    state = AsyncValue.data(controller);
  }
}
