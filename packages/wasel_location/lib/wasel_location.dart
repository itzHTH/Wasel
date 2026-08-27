/// wasel_location — shared location logic for the Wasel apps.
library;

// Localization
export 'l10n/location_localizations.dart';
export 'l10n/location_l10n_extension.dart';

// The map package itself. Re-exported so a screen needs a single import to get
// both the coordinates and the types they are drawn with; `wasel_core` used to
// carry this and no longer knows what a map is.
export 'package:google_maps_flutter/google_maps_flutter.dart';

// Domain — entities
export 'domain/entities/device_fix.dart';
export 'domain/entities/geo_point.dart';
export 'domain/entities/location_access.dart';
export 'domain/entities/location_exception.dart';
export 'domain/entities/route_request.dart';

// Domain — movement maths
export 'core/geo/geo_interpolation.dart';

// Domain — abstract repos
export 'domain/repos/base_device_location_repo.dart';
export 'domain/repos/base_geocoding_repo.dart';
export 'domain/repos/base_route_repo.dart';

// Domain — use cases
export 'domain/usecases/get_current_location_use_case.dart';
export 'domain/usecases/get_last_known_location_use_case.dart';
export 'domain/usecases/get_point_label_use_case.dart';
export 'domain/usecases/get_route_use_case.dart';
export 'domain/usecases/is_location_service_enabled_use_case.dart';
export 'domain/usecases/watch_device_location_use_case.dart';

// Core — constants
export 'core/const/app_map_defaults.dart';
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

// Core — extensions at the domain/map boundary
export 'core/extensions/geo_point_map_x.dart';
export 'core/extensions/vehicle_pose_map_x.dart';

// Presentation — animation
export 'presentation/animation/config/vehicle_motion_config.dart';
export 'presentation/animation/models/vehicle_pose.dart';
export 'presentation/animation/utils/motion_vsync.dart';
export 'presentation/animation/vehicle_motion.dart';

// Presentation — location providers
export 'presentation/providers/location/device_location_provider.dart';
export 'presentation/providers/location/last_known_location_provider.dart';
export 'presentation/providers/location/location_access_provider.dart';
export 'presentation/providers/location/point_label_provider.dart';
export 'presentation/providers/location/recenter_controller.dart';

// Presentation — map providers
export 'presentation/providers/map/initial_camera_target_provider.dart';
export 'presentation/providers/map/map_controller_provider.dart';
export 'presentation/providers/map/map_marker_icon_provider.dart';
export 'presentation/providers/map/map_ready_provider.dart';

// Presentation — widgets
export 'presentation/widgets/app_map.dart';
export 'presentation/widgets/app_map_loading_overlay.dart';
export 'presentation/widgets/location_permission_banner.dart';
export 'presentation/widgets/my_location_button.dart';
