/// wasel_auth — shared auth logic for the Wasel apps.
///
/// Exposes the full data + domain surface plus DI providers so any app can
/// drive login / OTP / register / logout from its own UI. The exhaustive
/// export (including request/response models) is intentional: app UIs build
/// request models and read response/entity types directly.
library;

// Domain — entities
export 'domain/entities/complete_registration.dart';
export 'domain/entities/initiate_registeration.dart';
export 'domain/entities/login.dart';
export 'domain/entities/logout.dart';
export 'domain/entities/verify_otp.dart';

// Domain — abstract repo + use cases
export 'domain/repo/base_auth_repo.dart';
export 'domain/usecases/complete_registration_use_case.dart';
export 'domain/usecases/initiate_registeration_use_case.dart';
export 'domain/usecases/login_use_case.dart';
export 'domain/usecases/logout_use_case.dart';
export 'domain/usecases/verify_otp_use_case.dart';

// Data — request models
export 'data/models/login/request/login_request.dart';
export 'data/models/logout/request/logout_request.dart';
export 'data/models/register/complete_registration/request/complete_registration_request.dart';
export 'data/models/register/initiate_registeration/request/initiate_registeration_request.dart';
export 'data/models/register/verify_otp/request/verify_otp_request.dart';

// Data — response models
export 'data/models/login/response/login_response.dart';
export 'data/models/logout/response/logout_response.dart';
export 'data/models/register/complete_registration/response/complete_registration_response.dart';
export 'data/models/register/initiate_registeration/response/initiate_registeration_response.dart';
export 'data/models/register/verify_otp/response/verify_otp_respons.dart';

// Data — repo impl + Retrofit service
export 'data/repo/auth_repo.dart';
export 'data/services/auth_api_service.dart';

// DI — use-case providers (authApiService -> authRepo -> use cases)
export 'providers/auth_use_case_providers.dart';
