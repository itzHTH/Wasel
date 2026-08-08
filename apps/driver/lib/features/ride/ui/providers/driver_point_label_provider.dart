import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'driver_point_label_provider.g.dart';

/// Driver-side mirror of the rider's `pointLabel`.
///
/// The driver app has no geocoding slice yet, so this resolves to an empty
/// label and every consumer falls back to formatted coordinates. When the
/// geocoding slice is ported, only this body changes — the signature already
/// matches the rider's provider.
@Riverpod(keepAlive: true)
Future<String> driverPointLabel(Ref ref, GeoPoint point) async => '';
