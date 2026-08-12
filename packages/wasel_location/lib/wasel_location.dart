/// wasel_location — shared location logic for the Wasel apps.
///
/// Owns every geographic concern the rider and driver apps have in common: the
/// `GeoPoint` they both speak, device positioning and permissions, Google
/// reverse geocoding, route drawing, and (from step 5) the shared map surface.
///
/// Exports are exhaustive in the style of `wasel_auth`: app UIs build requests
/// and read entity types directly, so hiding the data layer would only force
/// re-exports elsewhere.
///
/// Layering note — the presentation layer (providers and widgets) lands in
/// steps 4 and 5. Until then this package is self-contained and unused by the
/// apps, which still hold their own copies.
library;

// Domain — entities
export 'domain/entities/device_fix.dart';
export 'domain/entities/geo_point.dart';
export 'domain/entities/location_access.dart';
export 'domain/entities/location_exception.dart';
export 'domain/entities/route_request.dart';

// Domain — abstract repos
export 'domain/repos/base_device_location_repo.dart';
export 'domain/repos/base_geocoding_repo.dart';
export 'domain/repos/base_route_repo.dart';

// Domain — use cases
export 'domain/usecases/get_current_location_use_case.dart';
export 'domain/usecases/get_last_known_location_use_case.dart';
export 'domain/usecases/get_point_label_use_case.dart';
export 'domain/usecases/get_route_use_case.dart';
export 'domain/usecases/watch_device_location_use_case.dart';

// Data — constants
export 'data/const/location_api_const.dart';

// Data — models
export 'data/models/geocoding/address_component.dart';
export 'data/models/geocoding/google_geocoding_response.dart';

// Data — services
export 'data/services/device_location_service.dart';
export 'data/services/geocoding_api_service.dart';
export 'data/services/route_remote_service.dart';

// Data — repo implementations
export 'data/repos/device_location_repo.dart';
export 'data/repos/geocoding_repo.dart';
export 'data/repos/route_repo.dart';
