// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_di_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(placesApiService)
final placesApiServiceProvider = PlacesApiServiceProvider._();

final class PlacesApiServiceProvider
    extends
        $FunctionalProvider<
          PlacesApiService,
          PlacesApiService,
          PlacesApiService
        >
    with $Provider<PlacesApiService> {
  PlacesApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placesApiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placesApiServiceHash();

  @$internal
  @override
  $ProviderElement<PlacesApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlacesApiService create(Ref ref) {
    return placesApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlacesApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlacesApiService>(value),
    );
  }
}

String _$placesApiServiceHash() => r'67b8d1764fb2bed136bfc5440c18bbf293993cbf';

@ProviderFor(geocodingApiService)
final geocodingApiServiceProvider = GeocodingApiServiceProvider._();

final class GeocodingApiServiceProvider
    extends
        $FunctionalProvider<
          GeocodingApiService,
          GeocodingApiService,
          GeocodingApiService
        >
    with $Provider<GeocodingApiService> {
  GeocodingApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'geocodingApiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$geocodingApiServiceHash();

  @$internal
  @override
  $ProviderElement<GeocodingApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GeocodingApiService create(Ref ref) {
    return geocodingApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GeocodingApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GeocodingApiService>(value),
    );
  }
}

String _$geocodingApiServiceHash() =>
    r'0ad8e2decd472791e5d821f8f45981304e0fe1e5';

/// One session per container: the pickup and drop-off searches run one after
/// the other, so they share the billing session the rider is in.

@ProviderFor(placeSearchSession)
final placeSearchSessionProvider = PlaceSearchSessionProvider._();

/// One session per container: the pickup and drop-off searches run one after
/// the other, so they share the billing session the rider is in.

final class PlaceSearchSessionProvider
    extends
        $FunctionalProvider<
          PlaceSearchSession,
          PlaceSearchSession,
          PlaceSearchSession
        >
    with $Provider<PlaceSearchSession> {
  /// One session per container: the pickup and drop-off searches run one after
  /// the other, so they share the billing session the rider is in.
  PlaceSearchSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placeSearchSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placeSearchSessionHash();

  @$internal
  @override
  $ProviderElement<PlaceSearchSession> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PlaceSearchSession create(Ref ref) {
    return placeSearchSession(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaceSearchSession value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaceSearchSession>(value),
    );
  }
}

String _$placeSearchSessionHash() =>
    r'9f9a768bbe933f9739c8b67f9112a7de5fb831d4';

@ProviderFor(routeRemoteService)
final routeRemoteServiceProvider = RouteRemoteServiceProvider._();

final class RouteRemoteServiceProvider
    extends
        $FunctionalProvider<
          RouteRemoteService,
          RouteRemoteService,
          RouteRemoteService
        >
    with $Provider<RouteRemoteService> {
  RouteRemoteServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routeRemoteServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routeRemoteServiceHash();

  @$internal
  @override
  $ProviderElement<RouteRemoteService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RouteRemoteService create(Ref ref) {
    return routeRemoteService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RouteRemoteService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RouteRemoteService>(value),
    );
  }
}

String _$routeRemoteServiceHash() =>
    r'8cf9250542d8e4ca820db262d7f92324a31570fa';

@ProviderFor(deviceLocationService)
final deviceLocationServiceProvider = DeviceLocationServiceProvider._();

final class DeviceLocationServiceProvider
    extends
        $FunctionalProvider<
          DeviceLocationService,
          DeviceLocationService,
          DeviceLocationService
        >
    with $Provider<DeviceLocationService> {
  DeviceLocationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceLocationServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceLocationServiceHash();

  @$internal
  @override
  $ProviderElement<DeviceLocationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceLocationService create(Ref ref) {
    return deviceLocationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceLocationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceLocationService>(value),
    );
  }
}

String _$deviceLocationServiceHash() =>
    r'b404b0c1bcdc6f4a932ed8a01ebd73dde880d311';

@ProviderFor(geocodingRepo)
final geocodingRepoProvider = GeocodingRepoProvider._();

final class GeocodingRepoProvider
    extends
        $FunctionalProvider<
          BaseGeocodingRepo,
          BaseGeocodingRepo,
          BaseGeocodingRepo
        >
    with $Provider<BaseGeocodingRepo> {
  GeocodingRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'geocodingRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$geocodingRepoHash();

  @$internal
  @override
  $ProviderElement<BaseGeocodingRepo> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BaseGeocodingRepo create(Ref ref) {
    return geocodingRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseGeocodingRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseGeocodingRepo>(value),
    );
  }
}

String _$geocodingRepoHash() => r'3e212fb8f4336e1de2d8505610c85284bd26b7ad';

@ProviderFor(routeRepo)
final routeRepoProvider = RouteRepoProvider._();

final class RouteRepoProvider
    extends $FunctionalProvider<BaseRouteRepo, BaseRouteRepo, BaseRouteRepo>
    with $Provider<BaseRouteRepo> {
  RouteRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routeRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routeRepoHash();

  @$internal
  @override
  $ProviderElement<BaseRouteRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BaseRouteRepo create(Ref ref) {
    return routeRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseRouteRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseRouteRepo>(value),
    );
  }
}

String _$routeRepoHash() => r'843bfcbb3b5ecf482f3d10081ef49cbec20fbd15';

@ProviderFor(deviceLocationRepo)
final deviceLocationRepoProvider = DeviceLocationRepoProvider._();

final class DeviceLocationRepoProvider
    extends
        $FunctionalProvider<
          BaseDeviceLocationRepo,
          BaseDeviceLocationRepo,
          BaseDeviceLocationRepo
        >
    with $Provider<BaseDeviceLocationRepo> {
  DeviceLocationRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceLocationRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceLocationRepoHash();

  @$internal
  @override
  $ProviderElement<BaseDeviceLocationRepo> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BaseDeviceLocationRepo create(Ref ref) {
    return deviceLocationRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseDeviceLocationRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseDeviceLocationRepo>(value),
    );
  }
}

String _$deviceLocationRepoHash() =>
    r'324da7334e468cb96db01dda971ca8395b1123b6';

@ProviderFor(getPointLabelUseCase)
final getPointLabelUseCaseProvider = GetPointLabelUseCaseProvider._();

final class GetPointLabelUseCaseProvider
    extends
        $FunctionalProvider<
          GetPointLabelUseCase,
          GetPointLabelUseCase,
          GetPointLabelUseCase
        >
    with $Provider<GetPointLabelUseCase> {
  GetPointLabelUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPointLabelUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPointLabelUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetPointLabelUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetPointLabelUseCase create(Ref ref) {
    return getPointLabelUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPointLabelUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPointLabelUseCase>(value),
    );
  }
}

String _$getPointLabelUseCaseHash() =>
    r'31cfc1531ca2b555b0c7a77dc4c6f54df2651392';

@ProviderFor(getRouteUseCase)
final getRouteUseCaseProvider = GetRouteUseCaseProvider._();

final class GetRouteUseCaseProvider
    extends
        $FunctionalProvider<GetRouteUseCase, GetRouteUseCase, GetRouteUseCase>
    with $Provider<GetRouteUseCase> {
  GetRouteUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getRouteUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getRouteUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetRouteUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetRouteUseCase create(Ref ref) {
    return getRouteUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetRouteUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetRouteUseCase>(value),
    );
  }
}

String _$getRouteUseCaseHash() => r'8b806898b7690185a5446979af6556395450b16f';

@ProviderFor(searchPlacesUseCase)
final searchPlacesUseCaseProvider = SearchPlacesUseCaseProvider._();

final class SearchPlacesUseCaseProvider
    extends
        $FunctionalProvider<
          SearchPlacesUseCase,
          SearchPlacesUseCase,
          SearchPlacesUseCase
        >
    with $Provider<SearchPlacesUseCase> {
  SearchPlacesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchPlacesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchPlacesUseCaseHash();

  @$internal
  @override
  $ProviderElement<SearchPlacesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchPlacesUseCase create(Ref ref) {
    return searchPlacesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchPlacesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchPlacesUseCase>(value),
    );
  }
}

String _$searchPlacesUseCaseHash() =>
    r'0bded59d098a0b7f6c3e2b9012e8365886bbe1ab';

@ProviderFor(retrievePlaceUseCase)
final retrievePlaceUseCaseProvider = RetrievePlaceUseCaseProvider._();

final class RetrievePlaceUseCaseProvider
    extends
        $FunctionalProvider<
          RetrievePlaceUseCase,
          RetrievePlaceUseCase,
          RetrievePlaceUseCase
        >
    with $Provider<RetrievePlaceUseCase> {
  RetrievePlaceUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'retrievePlaceUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$retrievePlaceUseCaseHash();

  @$internal
  @override
  $ProviderElement<RetrievePlaceUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RetrievePlaceUseCase create(Ref ref) {
    return retrievePlaceUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RetrievePlaceUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RetrievePlaceUseCase>(value),
    );
  }
}

String _$retrievePlaceUseCaseHash() =>
    r'efdcdfc6988316875b100bb8b15068d9bc80ab30';

@ProviderFor(watchDeviceLocationUseCase)
final watchDeviceLocationUseCaseProvider =
    WatchDeviceLocationUseCaseProvider._();

final class WatchDeviceLocationUseCaseProvider
    extends
        $FunctionalProvider<
          WatchDeviceLocationUseCase,
          WatchDeviceLocationUseCase,
          WatchDeviceLocationUseCase
        >
    with $Provider<WatchDeviceLocationUseCase> {
  WatchDeviceLocationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchDeviceLocationUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchDeviceLocationUseCaseHash();

  @$internal
  @override
  $ProviderElement<WatchDeviceLocationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WatchDeviceLocationUseCase create(Ref ref) {
    return watchDeviceLocationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchDeviceLocationUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchDeviceLocationUseCase>(value),
    );
  }
}

String _$watchDeviceLocationUseCaseHash() =>
    r'187d9b473c1e5f9ee567a9db6720082b171d0e70';

@ProviderFor(getCurrentLocationUseCase)
final getCurrentLocationUseCaseProvider = GetCurrentLocationUseCaseProvider._();

final class GetCurrentLocationUseCaseProvider
    extends
        $FunctionalProvider<
          GetCurrentLocationUseCase,
          GetCurrentLocationUseCase,
          GetCurrentLocationUseCase
        >
    with $Provider<GetCurrentLocationUseCase> {
  GetCurrentLocationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCurrentLocationUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCurrentLocationUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetCurrentLocationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetCurrentLocationUseCase create(Ref ref) {
    return getCurrentLocationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCurrentLocationUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCurrentLocationUseCase>(value),
    );
  }
}

String _$getCurrentLocationUseCaseHash() =>
    r'59636ebcb7d351918140b39abbced8440ccc00a7';

@ProviderFor(getLastKnownLocationUseCase)
final getLastKnownLocationUseCaseProvider =
    GetLastKnownLocationUseCaseProvider._();

final class GetLastKnownLocationUseCaseProvider
    extends
        $FunctionalProvider<
          GetLastKnownLocationUseCase,
          GetLastKnownLocationUseCase,
          GetLastKnownLocationUseCase
        >
    with $Provider<GetLastKnownLocationUseCase> {
  GetLastKnownLocationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getLastKnownLocationUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getLastKnownLocationUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetLastKnownLocationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetLastKnownLocationUseCase create(Ref ref) {
    return getLastKnownLocationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetLastKnownLocationUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetLastKnownLocationUseCase>(value),
    );
  }
}

String _$getLastKnownLocationUseCaseHash() =>
    r'28b68ae3f308a1ddf2db98a0cd1c80f63fc8f5e9';

@ProviderFor(isLocationServiceEnabledUseCase)
final isLocationServiceEnabledUseCaseProvider =
    IsLocationServiceEnabledUseCaseProvider._();

final class IsLocationServiceEnabledUseCaseProvider
    extends
        $FunctionalProvider<
          IsLocationServiceEnabledUseCase,
          IsLocationServiceEnabledUseCase,
          IsLocationServiceEnabledUseCase
        >
    with $Provider<IsLocationServiceEnabledUseCase> {
  IsLocationServiceEnabledUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isLocationServiceEnabledUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isLocationServiceEnabledUseCaseHash();

  @$internal
  @override
  $ProviderElement<IsLocationServiceEnabledUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IsLocationServiceEnabledUseCase create(Ref ref) {
    return isLocationServiceEnabledUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IsLocationServiceEnabledUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IsLocationServiceEnabledUseCase>(
        value,
      ),
    );
  }
}

String _$isLocationServiceEnabledUseCaseHash() =>
    r'81c370352915306c08152ed4feb50e512315d2ea';
