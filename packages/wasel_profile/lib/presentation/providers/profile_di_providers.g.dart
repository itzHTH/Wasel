// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_di_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileApiService)
final profileApiServiceProvider = ProfileApiServiceProvider._();

final class ProfileApiServiceProvider
    extends
        $FunctionalProvider<
          ProfileApiService,
          ProfileApiService,
          ProfileApiService
        >
    with $Provider<ProfileApiService> {
  ProfileApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileApiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileApiServiceHash();

  @$internal
  @override
  $ProviderElement<ProfileApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileApiService create(Ref ref) {
    return profileApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileApiService>(value),
    );
  }
}

String _$profileApiServiceHash() => r'400da717fc7a2e3773ff956cc57b196283f15dbc';

@ProviderFor(profileRepo)
final profileRepoProvider = ProfileRepoProvider._();

final class ProfileRepoProvider
    extends
        $FunctionalProvider<BaseProfileRepo, BaseProfileRepo, BaseProfileRepo>
    with $Provider<BaseProfileRepo> {
  ProfileRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileRepoHash();

  @$internal
  @override
  $ProviderElement<BaseProfileRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BaseProfileRepo create(Ref ref) {
    return profileRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseProfileRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseProfileRepo>(value),
    );
  }
}

String _$profileRepoHash() => r'7556f1d56e11205b570a9a32002e9a491cabe482';

@ProviderFor(getRiderProfileUseCase)
final getRiderProfileUseCaseProvider = GetRiderProfileUseCaseProvider._();

final class GetRiderProfileUseCaseProvider
    extends
        $FunctionalProvider<
          GetRiderProfileUseCase,
          GetRiderProfileUseCase,
          GetRiderProfileUseCase
        >
    with $Provider<GetRiderProfileUseCase> {
  GetRiderProfileUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getRiderProfileUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getRiderProfileUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetRiderProfileUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetRiderProfileUseCase create(Ref ref) {
    return getRiderProfileUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetRiderProfileUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetRiderProfileUseCase>(value),
    );
  }
}

String _$getRiderProfileUseCaseHash() =>
    r'ab9a659fd5f1eac39d1d31a9d6213b9a66ca3b63';

@ProviderFor(getDriverProfileUseCase)
final getDriverProfileUseCaseProvider = GetDriverProfileUseCaseProvider._();

final class GetDriverProfileUseCaseProvider
    extends
        $FunctionalProvider<
          GetDriverProfileUseCase,
          GetDriverProfileUseCase,
          GetDriverProfileUseCase
        >
    with $Provider<GetDriverProfileUseCase> {
  GetDriverProfileUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getDriverProfileUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getDriverProfileUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetDriverProfileUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetDriverProfileUseCase create(Ref ref) {
    return getDriverProfileUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetDriverProfileUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetDriverProfileUseCase>(value),
    );
  }
}

String _$getDriverProfileUseCaseHash() =>
    r'b702cab71dfb3b19720861c9bd501577c5490eaf';

@ProviderFor(updateRiderPhotoUseCase)
final updateRiderPhotoUseCaseProvider = UpdateRiderPhotoUseCaseProvider._();

final class UpdateRiderPhotoUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateRiderPhotoUseCase,
          UpdateRiderPhotoUseCase,
          UpdateRiderPhotoUseCase
        >
    with $Provider<UpdateRiderPhotoUseCase> {
  UpdateRiderPhotoUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateRiderPhotoUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateRiderPhotoUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateRiderPhotoUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateRiderPhotoUseCase create(Ref ref) {
    return updateRiderPhotoUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateRiderPhotoUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateRiderPhotoUseCase>(value),
    );
  }
}

String _$updateRiderPhotoUseCaseHash() =>
    r'a933ad63b1a9e80d6f934b42f15a6007f3f1bc79';

@ProviderFor(updateRiderProfileUseCase)
final updateRiderProfileUseCaseProvider = UpdateRiderProfileUseCaseProvider._();

final class UpdateRiderProfileUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateRiderProfileUseCase,
          UpdateRiderProfileUseCase,
          UpdateRiderProfileUseCase
        >
    with $Provider<UpdateRiderProfileUseCase> {
  UpdateRiderProfileUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateRiderProfileUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateRiderProfileUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateRiderProfileUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateRiderProfileUseCase create(Ref ref) {
    return updateRiderProfileUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateRiderProfileUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateRiderProfileUseCase>(value),
    );
  }
}

String _$updateRiderProfileUseCaseHash() =>
    r'c7c9c0d5a9fad12bd20ae98a9468ed9451f2ddba';

@ProviderFor(updateDriverProfileUseCase)
final updateDriverProfileUseCaseProvider =
    UpdateDriverProfileUseCaseProvider._();

final class UpdateDriverProfileUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateDriverProfileUseCase,
          UpdateDriverProfileUseCase,
          UpdateDriverProfileUseCase
        >
    with $Provider<UpdateDriverProfileUseCase> {
  UpdateDriverProfileUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateDriverProfileUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateDriverProfileUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateDriverProfileUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateDriverProfileUseCase create(Ref ref) {
    return updateDriverProfileUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateDriverProfileUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateDriverProfileUseCase>(value),
    );
  }
}

String _$updateDriverProfileUseCaseHash() =>
    r'b5e158fa669a89fa681d51442744fabd743192b6';
