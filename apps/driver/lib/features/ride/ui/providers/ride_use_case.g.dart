// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(watchRideEventUseCase)
final watchRideEventUseCaseProvider = WatchRideEventUseCaseProvider._();

final class WatchRideEventUseCaseProvider
    extends
        $FunctionalProvider<
          WatchRideEventUseCase,
          WatchRideEventUseCase,
          WatchRideEventUseCase
        >
    with $Provider<WatchRideEventUseCase> {
  WatchRideEventUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchRideEventUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchRideEventUseCaseHash();

  @$internal
  @override
  $ProviderElement<WatchRideEventUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WatchRideEventUseCase create(Ref ref) {
    return watchRideEventUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchRideEventUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchRideEventUseCase>(value),
    );
  }
}

String _$watchRideEventUseCaseHash() =>
    r'de50baeabdc2537eb725193d8bf31768ced388b6';
