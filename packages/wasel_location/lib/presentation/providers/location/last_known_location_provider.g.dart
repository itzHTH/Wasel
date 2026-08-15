// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_known_location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// **What it does:** reads the position the OS already had cached, without
/// switching on any sensors. Null when the cache is empty.
///
/// **Data flow:** `getLastKnownLocationUseCaseProvider` → `deviceLocationRepo` →
/// the OS location cache. Exposes `AsyncValue<GeoPoint?>`; its main consumer is
/// [initialCameraTargetProvider], and the driver's car marker also falls back to
/// it while offline so the car is drawn without holding a position stream open.
///
/// **Why `FutureProvider` rather than a stream:** this is a one-shot cache read
/// with a definite answer, not a feed. It settles in milliseconds and has no
/// subsequent events to deliver — a stream would add an open subscription and a
/// completion state that no caller would ever use.
///
/// **Why `keepAlive`:** the value is effectively immutable for the session (the
/// live stream is what tracks movement), and it sits on the app-start path. A
/// keep-alive means the cost is paid once at launch; auto-disposing would let a
/// screen dismount and force the next screen to re-read the cache — a visible
/// stutter on the exact frame the map is trying to place its camera.
///
/// **Why it never errors:** the repository deliberately maps every failure to
/// null. "No cached fix" and "permission refused" are answered identically by
/// every caller — fall back to a default — so forcing each one to handle an
/// error state would just duplicate that fallback.

@ProviderFor(lastKnownLocation)
final lastKnownLocationProvider = LastKnownLocationProvider._();

/// **What it does:** reads the position the OS already had cached, without
/// switching on any sensors. Null when the cache is empty.
///
/// **Data flow:** `getLastKnownLocationUseCaseProvider` → `deviceLocationRepo` →
/// the OS location cache. Exposes `AsyncValue<GeoPoint?>`; its main consumer is
/// [initialCameraTargetProvider], and the driver's car marker also falls back to
/// it while offline so the car is drawn without holding a position stream open.
///
/// **Why `FutureProvider` rather than a stream:** this is a one-shot cache read
/// with a definite answer, not a feed. It settles in milliseconds and has no
/// subsequent events to deliver — a stream would add an open subscription and a
/// completion state that no caller would ever use.
///
/// **Why `keepAlive`:** the value is effectively immutable for the session (the
/// live stream is what tracks movement), and it sits on the app-start path. A
/// keep-alive means the cost is paid once at launch; auto-disposing would let a
/// screen dismount and force the next screen to re-read the cache — a visible
/// stutter on the exact frame the map is trying to place its camera.
///
/// **Why it never errors:** the repository deliberately maps every failure to
/// null. "No cached fix" and "permission refused" are answered identically by
/// every caller — fall back to a default — so forcing each one to handle an
/// error state would just duplicate that fallback.

final class LastKnownLocationProvider
    extends
        $FunctionalProvider<
          AsyncValue<GeoPoint?>,
          GeoPoint?,
          FutureOr<GeoPoint?>
        >
    with $FutureModifier<GeoPoint?>, $FutureProvider<GeoPoint?> {
  /// **What it does:** reads the position the OS already had cached, without
  /// switching on any sensors. Null when the cache is empty.
  ///
  /// **Data flow:** `getLastKnownLocationUseCaseProvider` → `deviceLocationRepo` →
  /// the OS location cache. Exposes `AsyncValue<GeoPoint?>`; its main consumer is
  /// [initialCameraTargetProvider], and the driver's car marker also falls back to
  /// it while offline so the car is drawn without holding a position stream open.
  ///
  /// **Why `FutureProvider` rather than a stream:** this is a one-shot cache read
  /// with a definite answer, not a feed. It settles in milliseconds and has no
  /// subsequent events to deliver — a stream would add an open subscription and a
  /// completion state that no caller would ever use.
  ///
  /// **Why `keepAlive`:** the value is effectively immutable for the session (the
  /// live stream is what tracks movement), and it sits on the app-start path. A
  /// keep-alive means the cost is paid once at launch; auto-disposing would let a
  /// screen dismount and force the next screen to re-read the cache — a visible
  /// stutter on the exact frame the map is trying to place its camera.
  ///
  /// **Why it never errors:** the repository deliberately maps every failure to
  /// null. "No cached fix" and "permission refused" are answered identically by
  /// every caller — fall back to a default — so forcing each one to handle an
  /// error state would just duplicate that fallback.
  LastKnownLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lastKnownLocationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lastKnownLocationHash();

  @$internal
  @override
  $FutureProviderElement<GeoPoint?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<GeoPoint?> create(Ref ref) {
    return lastKnownLocation(ref);
  }
}

String _$lastKnownLocationHash() => r'96d5dbcb191e0b91eccbd62a2e749b318c221651';
