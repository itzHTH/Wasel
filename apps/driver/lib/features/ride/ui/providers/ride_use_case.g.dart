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

@ProviderFor(updateDriverLocationUseCase)
final updateDriverLocationUseCaseProvider =
    UpdateDriverLocationUseCaseProvider._();

final class UpdateDriverLocationUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateDriverLocationUseCase,
          UpdateDriverLocationUseCase,
          UpdateDriverLocationUseCase
        >
    with $Provider<UpdateDriverLocationUseCase> {
  UpdateDriverLocationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateDriverLocationUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateDriverLocationUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateDriverLocationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateDriverLocationUseCase create(Ref ref) {
    return updateDriverLocationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateDriverLocationUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateDriverLocationUseCase>(value),
    );
  }
}

String _$updateDriverLocationUseCaseHash() =>
    r'f91afee09d697bbffa65921ba416cce81844dc2d';
