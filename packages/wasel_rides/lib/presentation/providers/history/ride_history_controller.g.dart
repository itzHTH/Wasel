// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Paginated ride history.

@ProviderFor(RideHistoryController)
final rideHistoryControllerProvider = RideHistoryControllerProvider._();

/// Paginated ride history.
final class RideHistoryControllerProvider
    extends $AsyncNotifierProvider<RideHistoryController, RideHistoryState> {
  /// Paginated ride history.
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
    r'd9e80879356c02585eac76afa1d14eba1d1b42f5';

/// Paginated ride history.

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
