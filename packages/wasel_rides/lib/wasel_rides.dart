/// wasel_rides — shared ride history for the rider and driver apps.
///
/// `GET /Rides/history` resolves the caller's role from the JWT, so the data,
/// domain, providers and UI in here are role-agnostic and used verbatim by
/// both apps.
library;

// Constants
export 'core/const/rides_api_const.dart';

// Data
export 'data/models/ride_history/response/ride_history_item_response.dart';
export 'data/models/ride_history/response/ride_history_page_response.dart';
export 'data/repos/rides_history_repo.dart';
export 'data/services/rides_api_service.dart';

// Domain
export 'domain/entities/ride_history_entry.dart';
export 'domain/entities/ride_history_status.dart';
export 'domain/repos/base_rides_history_repo.dart';
export 'domain/usecases/get_ride_history_use_case.dart';

// Presentation
export 'core/formatters/ride_history_labels.dart';
export 'presentation/providers/history/ride_history_controller.dart';
export 'presentation/providers/rides_di_providers.dart';
export 'presentation/screens/ride_history_screen.dart';
export 'presentation/providers/history/ride_history_state.dart';
