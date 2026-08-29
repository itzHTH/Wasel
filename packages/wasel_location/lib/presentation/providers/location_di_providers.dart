import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/dio/google_search_dio_factory.dart';
import 'package:wasel_location/core/const/location_api_const.dart';
import 'package:wasel_location/data/repos/device_location_repo.dart';
import 'package:wasel_location/data/repos/google_geocoding_repo.dart';
import 'package:wasel_location/data/repos/route_repo.dart';
import 'package:wasel_location/data/services/device_location_service.dart';
import 'package:wasel_location/data/services/geocoding_api_service.dart';
import 'package:wasel_location/data/services/places_api_service.dart';
import 'package:wasel_location/data/session/place_search_session.dart';
import 'package:wasel_location/data/services/route_remote_service.dart';
import 'package:wasel_location/domain/repos/base_device_location_repo.dart';
import 'package:wasel_location/domain/repos/base_geocoding_repo.dart';
import 'package:wasel_location/domain/repos/base_route_repo.dart';
import 'package:wasel_location/domain/usecases/get_current_location_use_case.dart';
import 'package:wasel_location/domain/usecases/get_last_known_location_use_case.dart';
import 'package:wasel_location/domain/usecases/get_point_label_use_case.dart';
import 'package:wasel_location/domain/usecases/get_route_use_case.dart';
import 'package:wasel_location/domain/usecases/retrieve_place_use_case.dart';
import 'package:wasel_location/domain/usecases/search_places_use_case.dart';
import 'package:wasel_location/domain/usecases/is_location_service_enabled_use_case.dart';
import 'package:wasel_location/domain/usecases/watch_device_location_use_case.dart';

part 'location_di_providers.g.dart';

@riverpod
PlacesApiService placesApiService(Ref ref) =>
    PlacesApiService(ref.watch(placesDioProvider));

@riverpod
GeocodingApiService geocodingApiService(Ref ref) =>
    GeocodingApiService(ref.watch(geocodingDioProvider));

/// One session per container: the pickup and drop-off searches run one after
/// the other, so they share the billing session the rider is in.
@riverpod
PlaceSearchSession placeSearchSession(Ref ref) => PlaceSearchSession();

@riverpod
RouteRemoteService routeRemoteService(Ref ref) =>
    RouteRemoteService(dotenv.get(LocationApiConst.routeApiKeyName));

@riverpod
DeviceLocationService deviceLocationService(Ref ref) =>
    DeviceLocationService(ref.watch(trackingSettingsProvider));

@riverpod
BaseGeocodingRepo geocodingRepo(Ref ref) => GoogleGeocodingRepo(
  ref.watch(placesApiServiceProvider),
  ref.watch(geocodingApiServiceProvider),
  ref.watch(placeSearchSessionProvider),
);

@riverpod
BaseRouteRepo routeRepo(Ref ref) =>
    RouteRepo(ref.watch(routeRemoteServiceProvider));

@riverpod
BaseDeviceLocationRepo deviceLocationRepo(Ref ref) =>
    DeviceLocationRepo(ref.watch(deviceLocationServiceProvider));

@riverpod
GetPointLabelUseCase getPointLabelUseCase(Ref ref) =>
    GetPointLabelUseCase(ref.watch(geocodingRepoProvider));

@riverpod
GetRouteUseCase getRouteUseCase(Ref ref) =>
    GetRouteUseCase(ref.watch(routeRepoProvider));

@riverpod
SearchPlacesUseCase searchPlacesUseCase(Ref ref) =>
    SearchPlacesUseCase(ref.watch(geocodingRepoProvider));

@riverpod
RetrievePlaceUseCase retrievePlaceUseCase(Ref ref) =>
    RetrievePlaceUseCase(ref.watch(geocodingRepoProvider));

@riverpod
WatchDeviceLocationUseCase watchDeviceLocationUseCase(Ref ref) =>
    WatchDeviceLocationUseCase(ref.watch(deviceLocationRepoProvider));

@riverpod
GetCurrentLocationUseCase getCurrentLocationUseCase(Ref ref) =>
    GetCurrentLocationUseCase(ref.watch(deviceLocationRepoProvider));

@riverpod
GetLastKnownLocationUseCase getLastKnownLocationUseCase(Ref ref) =>
    GetLastKnownLocationUseCase(ref.watch(deviceLocationRepoProvider));

@riverpod
IsLocationServiceEnabledUseCase isLocationServiceEnabledUseCase(Ref ref) =>
    IsLocationServiceEnabledUseCase(ref.watch(deviceLocationRepoProvider));
