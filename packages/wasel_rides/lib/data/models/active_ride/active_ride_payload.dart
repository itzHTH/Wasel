import 'package:wasel_rides/data/models/active_ride/response/active_ride_response.dart';
import 'package:wasel_rides/domain/entities/active_ride.dart';

abstract final class ActiveRidePayload {
  static ActiveRide? parse(List<Object?>? args) {
    final normalised = _normalise(args?.firstOrNull);
    if (normalised == null) return null;

    return ActiveRideResponse.fromJson(normalised).toEntity();
  }

  static Map<String, dynamic>? _normalise(Object? raw) {
    if (raw is! Map) return null;

    final byLowercase = <String, Object?>{
      for (final entry in raw.entries)
        entry.key.toString().trim().toLowerCase(): entry.value,
    };

    final result = <String, dynamic>{};
    for (final key in ActiveRideResponse.jsonKeys) {
      final value = byLowercase[key.toLowerCase()];
      if (value != null) result[key] = value;
    }

    return result.isEmpty ? null : result;
  }
}
