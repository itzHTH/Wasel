/// wasel_core — shared foundation for the Wasel apps.
///
/// Public surface: constants, flavors, helpers, networking (Dio/Retrofit
/// plumbing, results, error handling, interceptors), theming, base use cases,
/// and shared widgets. Routing stays app-owned (each app has its own routes).
library;

// Constants
export 'const/app_constants.dart';

// Flavors
export 'flavors/flavors_config.dart';

// Extensions
export 'extensions/navigation_extension.dart';

// Helpers
export 'helpers/app_image_compressor.dart';
export 'helpers/app_local_cache.dart';
export 'helpers/app_navigation.dart';
export 'helpers/app_url_launcher.dart';
export 'helpers/app_validators.dart';

// Permissions
export 'package:permission_handler/permission_handler.dart'
    show Permission, PermissionStatus, openAppSettings;
export 'permissions/permission_gate.dart';

// Networking
export 'networking/api_constants.dart';
export 'networking/api_results.dart';
export 'networking/dio_factory.dart';
export 'networking/errors/api_error_model.dart';
export 'networking/errors/api_errors.dart';
export 'networking/errors/error_handler.dart';
export 'networking/interceptors/auth_interceptor.dart';

// Theme
export 'theme/app_color.dart';
export 'theme/app_dimens.dart';
export 'theme/app_text_styles.dart';
export 'theme/app_theme.dart';

// Use cases
export 'usecase/base_use_case.dart';
export 'usecase/cancellable_use_case.dart';
export 'usecase/stream_base_use_case.dart';

// Widgets
export 'widgets/app_back_button.dart';
export 'widgets/app_dialog.dart';
export 'widgets/app_header_with_logo.dart';
export 'widgets/app_labeled_field.dart';
export 'widgets/app_text_form_field.dart';
export 'widgets/password_field.dart';
