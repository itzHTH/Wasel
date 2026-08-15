/// wasel_location — shared location logic for the Wasel apps.
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
export 'core/const/location_api_const.dart';

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

// DI — the composition root: services, repos and use cases as providers
export 'presentation/providers/location_di_providers.dart';

// Presentation — extensions at the domain/map boundary
export 'core/extensions/geo_point_map_x.dart';

// Presentation — location providers
export 'presentation/providers/location/device_location_provider.dart';
export 'presentation/providers/location/last_known_location_provider.dart';
export 'presentation/providers/location/location_access_provider.dart';
export 'presentation/providers/location/point_label_provider.dart';
export 'presentation/providers/location/recenter_controller.dart';

// Presentation — map providers
export 'presentation/providers/map/initial_camera_target_provider.dart';
export 'presentation/providers/map/map_marker_icon_provider.dart';
