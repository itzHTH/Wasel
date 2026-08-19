// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Paginated ride history.
///
/// One controller serves both apps: `GET /Rides/history` derives rider vs
/// driver from the JWT, so there is nothing role-specific to parameterise.

@ProviderFor(RideHistoryController)
final rideHistoryControllerProvider = RideHistoryControllerProvider._();

/// Paginated ride history.
///
/// One controller serves both apps: `GET /Rides/history` derives rider vs
/// driver from the JWT, so there is nothing role-specific to parameterise.
final class RideHistoryControllerProvider
    extends $AsyncNotifierProvider<RideHistoryController, RideHistoryState> {
  /// Paginated ride history.
  ///
  /// One controller serves both apps: `GET /Rides/history` derives rider vs
  /// driver from the JWT, so there is nothing role-specific to parameterise.
  RideHistoryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: _noRetry,
        name: r'rideHistoryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideHistoryControllerHash();

  @$internal
  @override
  RideHistoryController create() => RideHistoryController();
}

String _$rideHistoryControllerHash() =>
    r'e226d670bf66808e513b43d15ed5171e375b7c24';

/// Paginated ride history.
///
/// One controller serves both apps: `GET /Rides/history` derives rider vs
/// driver from the JWT, so there is nothing role-specific to parameterise.

abstract class _$RideHistoryController
    extends $AsyncNotifier<RideHistoryState> {
  FutureOr<RideHistoryState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<RideHistoryState>, RideHistoryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RideHistoryState>, RideHistoryState>,
              AsyncValue<RideHistoryState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
